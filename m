Return-Path: <SRS0=X07A=AC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE6BC433E0
	for <iommu@archiver.kernel.org>; Sun, 21 Jun 2020 20:05:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05015204EA
	for <iommu@archiver.kernel.org>; Sun, 21 Jun 2020 20:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="FEOXINd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05015204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A568326143;
	Sun, 21 Jun 2020 20:05:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vkm8b1IpDogB; Sun, 21 Jun 2020 20:05:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BAC9F204B2;
	Sun, 21 Jun 2020 20:05:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97A22C0891;
	Sun, 21 Jun 2020 20:05:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C43FCC016F
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 20:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B97C886C6A
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 20:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lh90NL2dIQh8 for <iommu@lists.linux-foundation.org>;
 Sun, 21 Jun 2020 20:05:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 12E7F86C67
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 20:05:29 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id y18so6585971plr.4
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=X7OgyVSuMYJEbRKK/i9+0glEO3PUSbKBvGeuyKIoZ/k=;
 b=FEOXINd8eHKchJBRGzFYOm0z4eYkmtbgEWvjBFNQhWwDOw7ASZ7gt5fuSAYYQQ6XWs
 IaF6hhHqjpivcgS4yIIwysgbQ5X0IMF+WI151tPWf9x6AVVp9Jl2P9m+KceZApxAx3nT
 dZTAhf1UCoXOr66cN7CImpY/qmfQRVGou43E7LjmqCqckgupVbbR5HdtmEhvTNWLEZ1s
 ne1oJi3lqBydkId+zh5pnQpf3jOZp1HSwCSo86EcL71rLxyvnmToHSeC8rlUUwuO5qUq
 3ImJEHOpHu/JltpmPOU18olGw9pLSNg7kGFxi555F4Q7mDJ1tKK5DESmU/Zm0SoLhcVb
 LN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=X7OgyVSuMYJEbRKK/i9+0glEO3PUSbKBvGeuyKIoZ/k=;
 b=ZfqaG26VhbtKVzfGuXtGNynbEEE0RebzO9Pv0nrDflYXiAxiP12FH4gQ2pUf960Fkg
 9raivay8jj0jz1PZtxPk5CGt9OgraFcjF7mJxEXzM/xEsmo0ZJAh4MGa6zHFYzSuqHK7
 I+FcFQwNZLHwU4sTQ92GpB1aiWzCUYjfOH8UCbJUFpTpyM3uhd3qPvhS4sBSTffhPQM7
 5PfHImq4deRu91ZN6PQZgRDVuofYu+IuIlxiUHc6C5gdcWOUvnd3ZSBQCYcDzh9Yq/jw
 PMa4a7OGETA5jGtFxVgua7ZGxIR7rUdDWSrJEOtL9CP0oU/oWzyaKbJY84GWw366QFEP
 s8sg==
X-Gm-Message-State: AOAM531kQ/4w0U837lGuDkv1Qq9gGr1LIKyu9x7wAWUZbVzCKHmfFAj4
 0bW7Adevj2AVkD3qCEWR/JLQMg==
X-Google-Smtp-Source: ABdhPJx+GLSo7Zt2qVszU4jxzYm+pQRxbDIdXFksrvF7xCgmalSHVt7Ytq3xCa3awHjCgrDIX4suWA==
X-Received: by 2002:a17:90b:4d0f:: with SMTP id
 mw15mr14682826pjb.68.1592769928367; 
 Sun, 21 Jun 2020 13:05:28 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id ev20sm10942379pjb.8.2020.06.21.13.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2020 13:05:27 -0700 (PDT)
Date: Sun, 21 Jun 2020 13:05:27 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Roman Gushchin <guro@fb.com>, Takashi Iwai <tiwai@suse.de>
Subject: Re: kernel BUG at mm/huge_memory.c:2613!
In-Reply-To: <20200619225704.GC237539@carbon.dhcp.thefacebook.com>
Message-ID: <alpine.DEB.2.22.394.2006211302270.195301@chino.kir.corp.google.com>
References: <20200619001938.GA135965@carbon.dhcp.thefacebook.com>
 <CAHbLzkrDcn-GQOrAM=m7+2g5_J6obsz4K50Oqb-1RD5p1iWTPQ@mail.gmail.com>
 <20200619011449.GC135965@carbon.dhcp.thefacebook.com>
 <20200619024026.GB21081@redhat.com> <20200619185540.GB217189@carbon.lan>
 <alpine.DEB.2.22.394.2006191354080.26224@chino.kir.corp.google.com>
 <20200619225704.GC237539@carbon.dhcp.thefacebook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: Andrea Arcangeli <aarcange@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Linux MM <linux-mm@kvack.org>,
 iommu@lists.linux-foundation.org, Wei Yang <richardw.yang@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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

On Fri, 19 Jun 2020, Roman Gushchin wrote:

> > > [   40.287524] BUG: unable to handle page fault for address: ffffa77b833df000
> > > [   40.287529] #PF: supervisor write access in kernel mode
> > > [   40.287531] #PF: error_code(0x000b) - reserved bit violation
> > > [   40.287532] PGD 40d14e067 P4D 40d14e067 PUD 40d14f067 PMD 3ec54d067
> > > PTE 80001688033d9163
> > > [   40.287538] Oops: 000b [#2] SMP NOPTI
> > > [   40.287542] CPU: 9 PID: 1986 Comm: pulseaudio Tainted: G      D
> > >       5.8.0-rc1+ #697
> > > [   40.287544] Hardware name: Gigabyte Technology Co., Ltd.
> > > AB350-Gaming/AB350-Gaming-CF, BIOS F25 01/16/2019
> > > [   40.287550] RIP: 0010:__memset+0x24/0x30
> > > [   40.287553] Code: cc cc cc cc cc cc 0f 1f 44 00 00 49 89 f9 48 89
> > > d1 83 e2 07 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48
> > > 0f af c6 <f3> 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89
> > > d1 f3
> > > [   40.287556] RSP: 0018:ffffa77b827a7e08 EFLAGS: 00010216
> > > [   40.287558] RAX: 0000000000000000 RBX: ffff90f77dced800 RCX: 00000000000008a0
> > > [   40.287560] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffa77b833df000
> > > [   40.287561] RBP: ffff90f7898c7000 R08: ffff90f78c507768 R09: ffffa77b833df000
> > > [   40.287563] R10: ffffa77b833df000 R11: ffff90f7839f2d40 R12: 0000000000000000
> > > [   40.287564] R13: ffff90f76a802e00 R14: ffffffffc0cb8880 R15: ffff90f770f4e700
> > > [   40.287567] FS:  00007f3d8e8df880(0000) GS:ffff90f78ee40000(0000)
> > > knlGS:0000000000000000
> > > [   40.287569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   40.287570] CR2: ffffa77b833df000 CR3: 00000003fa556000 CR4: 00000000003406e0
> > > [   40.287572] Call Trace:
> > > [   40.287584]  snd_pcm_hw_params+0x3fd/0x490 [snd_pcm]
> > > [   40.287593]  snd_pcm_common_ioctl+0x1c5/0x1110 [snd_pcm]
> > > [   40.287601]  ? snd_pcm_info_user+0x64/0x80 [snd_pcm]
> > > [   40.287608]  snd_pcm_ioctl+0x23/0x30 [snd_pcm]
> > > [   40.287613]  ksys_ioctl+0x82/0xc0
> > > [   40.287617]  __x64_sys_ioctl+0x16/0x20
> > > [   40.287622]  do_syscall_64+0x4d/0x90
> > > [   40.287627]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > Hi Roman,
> > 
> > If you have CONFIG_AMD_MEM_ENCRYPT set, this should be resolved by
> > 
> > commit dbed452a078d56bc7f1abecc3edd6a75e8e4484e
> > Author: David Rientjes <rientjes@google.com>
> > Date:   Thu Jun 11 00:25:57 2020 -0700
> > 
> >     dma-pool: decouple DMA_REMAP from DMA_COHERENT_POOL
> > 
> > Or you might want to wait for 5.8-rc2 instead which includes this fix.
> > 
> 
> Hello, David!
> 
> Thank you for pointing at it! Unfortunately, there must be something wrong
> with drivers, your patch didn't help much. I still see the same stacktrace.
> 

Wow, I'm very surprised.  Do you have CONFIG_AMD_MEM_ENCRYPT enabled?

Adding Takashi.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
