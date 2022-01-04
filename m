Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EF3C433F5
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 14:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0AF27404C0;
	Tue,  4 Jan 2022 14:52:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eP7RJgAjF92N; Tue,  4 Jan 2022 14:52:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 98B39400F6;
	Tue,  4 Jan 2022 14:52:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6341BC0030;
	Tue,  4 Jan 2022 14:52:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90133C001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 14:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 70CF782611
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 14:52:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MAr-W1y-KCe5 for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 14:51:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BF7081448
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 14:51:59 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 k66-20020a1ca145000000b00345fa984108so1572750wme.2
 for <iommu@lists.linux-foundation.org>; Tue, 04 Jan 2022 06:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b3+GmntaMimU+/bPpFnuf/v5ZVH63cB+da8coqiM/zw=;
 b=N527UQ1nLed3ybJh40N4gmE3IN6I/NBefqguG4g0QweliMdjEyIH6vg7YEd5hRVZSU
 rqt4wEiqdbBzWJZHMR8+69TblC0O0V4NGH+PadAp12yLnj6tIxPC2KGUnLiCGqVqGTtf
 w9qh+qtDgOxpXlcULoFT/ArwdHXFL8cWNtqUbBPBGOH45wCFricCO7Cvopbg/4LRF+zo
 0OlKbwYGlYyb/JoMBuh1OYyYVrH3tgff1eyYlxmPBvOx2fwy37aqn+QD6RaKiR0Y1mhH
 Pw8W2ZEa1I93WUgDm/OgcT2R7hylWS3KtPfo7f9lsIsKssZRLOGBaUF0NiCsaYr/xNlL
 2THQ==
X-Gm-Message-State: AOAM5316xZmTiZZmONsaRJdH5NchVIDulJgMGv0Z6YsbNtU15KRbTbOt
 urgWDPo6DsvYTpE+igD5km0=
X-Google-Smtp-Source: ABdhPJzjX5oClLRzYaX+nwg/mczDAlcvm4aJRos5NEuVy9/Ir+iOKjFdNrYEQvcjJTtqOW+WLD1Ikg==
X-Received: by 2002:a1c:c917:: with SMTP id f23mr43473624wmb.10.1641307917364; 
 Tue, 04 Jan 2022 06:51:57 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id k31sm37872962wms.21.2022.01.04.06.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jan 2022 06:51:56 -0800 (PST)
Date: Tue, 4 Jan 2022 14:51:55 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Swiotlb: Add CONFIG_HAS_IOMEM check around memremap() in
 the swiotlb_mem_remap()
Message-ID: <20220104145155.hm7j5byhddn4zhb2@liuwe-devbox-debian-v2>
References: <20211231165640.1245751-1-ltykernel@gmail.com>
 <YdKrxgnpT0Dc0t2T@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YdKrxgnpT0Dc0t2T@infradead.org>
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com, wei.liu@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, kernel test robot <lkp@intel.com>,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 Tianyu Lan <ltykernel@gmail.com>, michael.h.kelley@microsoft.com,
 iommu@lists.linux-foundation.org, brijesh.singh@amd.com, vkuznets@redhat.com,
 kys@microsoft.com, robin.murphy@arm.com, hch@lst.de
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

On Sun, Jan 02, 2022 at 11:54:46PM -0800, Christoph Hellwig wrote:
> On Fri, Dec 31, 2021 at 11:56:40AM -0500, Tianyu Lan wrote:
> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > 
> > HAS_IOMEM option may not be selected on some platforms(e.g, s390) and this
> > will cause compile error due to miss memremap() implementation. Fix it via
> > adding HAS_IOMEM check around memremap() in the swiotlb.c.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > ---
> >  kernel/dma/swiotlb.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index b36c1cdd0c4f..3de651ba38cc 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -167,6 +167,7 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
> >  {
> >  	void *vaddr = NULL;
> >  
> > +#ifdef CONFIG_HAS_IOMEM
> 
> Please stub out all of swiotlb_mem_remap instead of the ifdef inside the
> function.

Does this look okay to you?

---8<---
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b36c1cdd0c4f..f1e7ea160b43 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -163,6 +163,7 @@ static inline unsigned long nr_slots(u64 val)
  * when swiotlb_unencrypted_base is set. (e.g. for Hyper-V AMD SEV-SNP
  * Isolation VMs).
  */
+#ifdef CONFIG_HAS_IOMEM
 static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
 {
 	void *vaddr = NULL;
@@ -178,6 +179,12 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
 
 	return vaddr;
 }
+#else
+static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
+{
+	return NULL;
+}
+#endif
 
 /*
  * Early SWIOTLB allocation may be too early to allow an architecture to
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
