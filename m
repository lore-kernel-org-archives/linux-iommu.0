Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD94C4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 14:24:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716076113E
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 14:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 716076113E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34C2040180;
	Thu,  5 Aug 2021 14:24:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XQPr1DNoDdhP; Thu,  5 Aug 2021 14:24:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A6046400F0;
	Thu,  5 Aug 2021 14:24:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83ABBC0010;
	Thu,  5 Aug 2021 14:24:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63B23C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 14:24:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51AAB404CB
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 14:24:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Yq55TR8MDaD for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 14:24:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01725404BC
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 14:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=zMcKhJ07Z0yEyEv/MZ8pR7li72ad4G0VC4wqCeDkbDY=; b=Q8Gt1gPN7F9SkQKtk66lR0Nvuh
 J+bQdo/XSF0T67gISx6Vc66q4fTo+FTFXUMBRhgaIYcCdf4qsGlh0/mWJ+py9vssB/RciYSkt7LqL
 D0cqTwAYfbBkgMf2ypNTXXW2W20qbJJiGowvi4sZXl3BoY2qT/+k7Nng8ZQfv0ypsUQI4WocLRzCG
 u80NaVh0JtgNowR5InuyXmnurSDKaZAz/gxT14CsI+ZrymZR8Osz9v++VxUgQS1ig9yJ1gWeOnHdN
 4FgEGzlqGLrJBOnGChRGgnAbrCvPvgpl8CZ89abXFTd7+wD4SGh2nZ+kuynsPyLw62j/Wl+j9erZJ
 uCRxZNTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBeHe-0064f4-Gt; Thu, 05 Aug 2021 14:23:42 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B62C30027B;
 Thu,  5 Aug 2021 16:23:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 1E329201DCD23; Thu,  5 Aug 2021 16:23:41 +0200 (CEST)
Date: Thu, 5 Aug 2021 16:23:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V2 03/14] x86/set_memory: Add x86_set_memory_enc static
 call support
Message-ID: <YQv0bRBUq1N5+jgG@hirez.programming.kicks-ass.net>
References: <20210804184513.512888-1-ltykernel@gmail.com>
 <20210804184513.512888-4-ltykernel@gmail.com>
 <5823af8a-7dbb-dbb0-5ea2-d9846aa2a36a@intel.com>
 <942e6fcb-3bdf-9294-d3db-ca311db440d3@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <942e6fcb-3bdf-9294-d3db-ca311db440d3@gmail.com>
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 david@redhat.com, ardb@kernel.org, dave.hansen@linux.intel.com,
 Dave Hansen <dave.hansen@intel.com>, hpa@zytor.com, kys@microsoft.com,
 will@kernel.org, boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org,
 wei.liu@kernel.org, sstabellini@kernel.org, sthemmin@microsoft.com,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
 aneesh.kumar@linux.ibm.com, x86@kernel.org, decui@microsoft.com, hch@lst.de,
 michael.h.kelley@microsoft.com, mingo@redhat.com, pgonda@google.com,
 rientjes@google.com, kuba@kernel.org, jejb@linux.ibm.com,
 martin.b.radev@gmail.com, thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 keescook@chromium.org, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, vkuznets@redhat.com,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kirill.shutemov@linux.intel.com,
 tj@kernel.org, akpm@linux-foundation.org, robin.murphy@arm.com,
 davem@davemloft.net, rppt@kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Aug 05, 2021 at 10:05:17PM +0800, Tianyu Lan wrote:
>  static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
>  {
> +	return static_call(x86_set_memory_enc)(addr, numpages, enc);
>  }

Hurpmh... So with a bit of 'luck' you get code-gen like:

__set_memory_enc_dec:
	jmp __SCT_x86_set_memory_enc;

set_memory_encrypted:
	mov $1, %rdx
	jmp __set_memory_enc_dec

set_memory_decrypted:
	mov $0, %rdx
	jmp __set_memory_enc_dec


Which, to me, seems exceedingly daft. Best to make all 3 of those
inlines and use EXPORT_STATIC_CALL_TRAMP_GPL(x86_set_memory_enc) or
something.

This is assuming any of this is actually performance critical, based off
of this using static_call() to begin with.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
