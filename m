Return-Path: <SRS0=1rof=6B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A259AC3815B
	for <iommu@archiver.kernel.org>; Fri, 17 Apr 2020 18:42:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690D622250
	for <iommu@archiver.kernel.org>; Fri, 17 Apr 2020 18:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="MgTq2g0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690D622250
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2587A867E5;
	Fri, 17 Apr 2020 18:42:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IB2Zprcnr3tA; Fri, 17 Apr 2020 18:42:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 86B5786519;
	Fri, 17 Apr 2020 18:42:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B658C1AE8;
	Fri, 17 Apr 2020 18:42:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB256C0172
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 18:42:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D55A68781C
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 18:42:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t0qkGt4EBO1k for <iommu@lists.linux-foundation.org>;
 Fri, 17 Apr 2020 18:42:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4EDB487814
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 18:42:01 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id k15so1462060pfh.6
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 11:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=Ju33b1g72uTAJNdx7tvrGrx42I2+s4vgy+9DTyNsRdk=;
 b=MgTq2g0+QPDr3oesAW/HHVoC/JjUZ5+d9D9oiJIWFpRrCiRXmAsGt/kZStXgTbeynL
 ++nCOqIEuGPy+qXVJ+KcY4od24xU5qFSu0YHHMysmyUrwotgVPo7MianqVterrTWUHoA
 XxuP6zhz0/YU7uK+0VBcevQLi1+hZE9TZgWDGteRTydfYVMV9xVNxZB7vf8Rt7+jf5z8
 lixGSkyHF7OLMpEp8xlwO8DMqAnA5DGS4QoQFSwwrIzDTwZBkGK3X7wNKjkwRk+k/T0a
 yCUNAX/+DXzERd2LtBHKwzAz5O7f7ceX2sZK3pxoPxvUpyyxjGi9VjxPLKF/Fch5at/o
 e6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=Ju33b1g72uTAJNdx7tvrGrx42I2+s4vgy+9DTyNsRdk=;
 b=dHD0QTDBy5ujvA280QdxNpRn7VSdgBzN5j/dQdxZsEKmtb1khD/o6UkmDU2Ez6UNVH
 RSF0FuppiSt7w2DUMvJXDK8nEWcuQSV8eKC84AzkX64P21ykiV3mQu/AoYQ3TGdWJ/XL
 j3pNiu2rTaxYZwnrr1QdoIr9gAzr7tEU9XWXKwvFVovHjNfj3CHYeqgkOmdkXu0jpiPU
 e370bBcGKr8xl2Az45BwTTsPg2tK4iZ+B8V6iJ/JKFGHa+6TRP4kbyV6WEQlf5cR01GV
 vNWi7sFwpZt26qeAGuXJEgUYoe/N2TujoDBTBcGPBVEMU9ZfudpWg06AKxbFFdk+ixFy
 4IfQ==
X-Gm-Message-State: AGi0PubxgYv2aAuHx+eSezmsZMVJOjwUOz+GhWf5FagVF/ihPAcdYY5D
 IyEX7MTxWCVyVfuoBCGtDA4qxw==
X-Google-Smtp-Source: APiQypJC/aD8pTpMxfxD1DsFucYiSus4dpyYDV3M7HF2NRR9RFgjCECAPHHQoRU+qzU+Mzu87xLoBQ==
X-Received: by 2002:a62:2b05:: with SMTP id r5mr4240532pfr.120.1587148920663; 
 Fri, 17 Apr 2020 11:42:00 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id i10sm6730303pfa.166.2020.04.17.11.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 11:41:59 -0700 (PDT)
Date: Fri, 17 Apr 2020 11:41:59 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [patch 0/7] unencrypted atomic DMA pools with dynamic
 expansion
In-Reply-To: <20200417071112.GD19153@lst.de>
Message-ID: <alpine.DEB.2.22.394.2004171126240.88048@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
 <20200417071112.GD19153@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 Brijesh Singh <brijesh.singh@amd.com>, Jon Grimm <jon.grimm@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, 17 Apr 2020, Christoph Hellwig wrote:

> So modulo a few comments that I can fix up myself this looks good.  Unless
> you want to resend for some reason I'm ready to pick this up once I open
> the dma-mapping tree after -rc2.
> 

Yes, please do, and thanks to both you and Thomas for the guidance and 
code reviews.

Once these patches take on their final form in your branch, how supportive 
would you be of stable backports going back to 4.19 LTS?

There have been several changes to this area over time, so there are 
varying levels of rework that need to be done for each stable kernel back 
to 4.19.  But I'd be happy to do that work if you are receptive to it.

For rationale, without these fixes, all SEV enabled guests warn of 
blocking in rcu read side critical sections when using drivers that 
allocate atomically though the DMA API that calls set_memory_decrypted().  
Users can see warnings such as these in the guest:

BUG: sleeping function called from invalid context at mm/vmalloc.c:1710
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3383, name: fio
2 locks held by fio/3383:
 #0: ffff93b6a8568348 (&sb->s_type->i_mutex_key#16){+.+.}, at: ext4_file_write_iter+0xa2/0x5d0
 #1: ffffffffa52a61a0 (rcu_read_lock){....}, at: hctx_lock+0x1a/0xe0
CPU: 0 PID: 3383 Comm: fio Tainted: G        W         5.5.10 #14
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 dump_stack+0x98/0xd5
 ___might_sleep+0x175/0x260
 __might_sleep+0x4a/0x80
 _vm_unmap_aliases+0x45/0x250
 vm_unmap_aliases+0x19/0x20
 __set_memory_enc_dec+0xa4/0x130
 set_memory_decrypted+0x10/0x20
 dma_direct_alloc_pages+0x148/0x150
 dma_direct_alloc+0xe/0x10
 dma_alloc_attrs+0x86/0xc0
 dma_pool_alloc+0x16f/0x2b0
 nvme_queue_rq+0x878/0xc30 [nvme]
 __blk_mq_try_issue_directly+0x135/0x200
 blk_mq_request_issue_directly+0x4f/0x80
 blk_mq_try_issue_list_directly+0x46/0xb0
 blk_mq_sched_insert_requests+0x19b/0x2b0
 blk_mq_flush_plug_list+0x22f/0x3b0
 blk_flush_plug_list+0xd1/0x100
 blk_finish_plug+0x2c/0x40
 iomap_dio_rw+0x427/0x490
 ext4_file_write_iter+0x181/0x5d0
 aio_write+0x109/0x1b0
 io_submit_one+0x7d0/0xfa0
 __x64_sys_io_submit+0xa2/0x280
 do_syscall_64+0x5f/0x250
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
