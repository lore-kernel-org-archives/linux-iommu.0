Return-Path: <SRS0=c+U5=L2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923DEC11F6A
	for <iommu@archiver.kernel.org>; Fri,  2 Jul 2021 03:08:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3696140A
	for <iommu@archiver.kernel.org>; Fri,  2 Jul 2021 03:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3696140A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD1194225B;
	Fri,  2 Jul 2021 03:08:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fksxqvkIFq-p; Fri,  2 Jul 2021 03:08:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 534C342259;
	Fri,  2 Jul 2021 03:08:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3249BC0010;
	Fri,  2 Jul 2021 03:08:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21196C000E
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 03:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EDEEE405A0
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 03:08:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bRgPtE9eBIrL for <iommu@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 03:08:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2759940121
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 03:08:10 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id s17so9854736oij.0
 for <iommu@lists.linux-foundation.org>; Thu, 01 Jul 2021 20:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=vnC0TqPJlyIMqLOncGpr5zl9pmbmcIIyiC4phT6PUIQ=;
 b=rcatVMwnoboRAVBm6z7P2HYmOyqx+HWthzA0HOg5zSVWMr7WIAx3ZVtmMQBABS3jSs
 ll3cBrlaV5N4g4Rvy938v3Mka2o7BKSsLAnp0j9BVKtd6G0HRyhUAM117EPetSB6PYk4
 aIzksvokAZwg7oj60y4L3zka5GOYTYtCADcKKqh9eOpTeqFos+tdtKUeh13pl/ncaATb
 z+gsly2qHHMFdyn0yxdy8vih0i6Y3VD1swKheCHmBE++JlII4Ajp+FJ6942Kfxfr0p9t
 PlSPUBKWfUPw26fCx2/8jDss0gWJ7ZhSbqGnHJzN7Y9CqXNOHLSOGPQ6Z7xfZJI1OXzp
 hIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=vnC0TqPJlyIMqLOncGpr5zl9pmbmcIIyiC4phT6PUIQ=;
 b=hua+oF/5sqqVbv4KLBTMEgYyRX09no0cH6PlXho+rkm/61WyPn+euijJjyh6LOiMpA
 dEflPRLFonGrL0cg8uJbPrvmOfqrRATflPZB2SwGM8pyclG0cg+Vc1BGGguFkkg+MtmW
 AeDNp8ewJ52MQvYb6F/+SEb/b1tDinBWDraaC5l++TurtHQCpLIRqSrFRgESEcMLWKic
 /zd0xtsK6HtEcttts7Jv1VVyR0SrCChXKLYNOp2/XNc0SotzOLmxmoKOwZ5xY/MKjJFC
 KRsbIAVkSvLhdrU+3ix1luLNkinIWUzbbmY7x/FDC7arAPAD1uL1ebvluJUcrraBwukw
 yymg==
X-Gm-Message-State: AOAM530MRJl7z3C9mfOBCkzm/Hu8JIJhoxIlbHp1NeHnCuQlyqhBfkxb
 wvUxTZF3nn7SnAoMX/icXCE=
X-Google-Smtp-Source: ABdhPJxROyx59a65CULGKnIjDKL6LEkceViIozGHO/6JCiILIO/ostWPfjk3TYymGpFPnNGZwku3+w==
X-Received: by 2002:a54:4187:: with SMTP id 7mr2101677oiy.127.1625195289117;
 Thu, 01 Jul 2021 20:08:09 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id l2sm374555otl.27.2021.07.01.20.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jul 2021 20:08:08 -0700 (PDT)
Date: Thu, 1 Jul 2021 20:08:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Claire Chang <tientzu@chromium.org>
Subject: Re: [PATCH v15 12/12] of: Add plumbing for restricted DMA pool
Message-ID: <20210702030807.GA2685166@roeck-us.net>
References: <20210624155526.2775863-1-tientzu@chromium.org>
 <20210624155526.2775863-13-tientzu@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210624155526.2775863-13-tientzu@chromium.org>
Cc: heikki.krogerus@linux.intel.com,
 linux-devicetree <devicetree@vger.kernel.org>, peterz@infradead.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org, jxgao@google.com,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 xen-devel@lists.xenproject.org, matthew.auld@intel.com,
 Nicolas Boichat <drinkcat@chromium.org>, thomas.hellstrom@linux.intel.com,
 Will Deacon <will@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 intel-gfx@lists.freedesktop.org, Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
 rodrigo.vivi@intel.com, bhelgaas@google.com, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 airlied@linux.ie, Thierry Reding <treding@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 quic_qiancai@quicinc.com, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 thomas.lendacky@amd.com, Robin Murphy <robin.murphy@arm.com>,
 bauerman@linux.ibm.com
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

Hi,

On Thu, Jun 24, 2021 at 11:55:26PM +0800, Claire Chang wrote:
> If a device is not behind an IOMMU, we look up the device node and set
> up the restricted DMA when the restricted-dma-pool is presented.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> Tested-by: Stefano Stabellini <sstabellini@kernel.org>
> Tested-by: Will Deacon <will@kernel.org>

With this patch in place, all sparc and sparc64 qemu emulations
fail to boot. Symptom is that the root file system is not found.
Reverting this patch fixes the problem. Bisect log is attached.

Guenter

---
# bad: [fb0ca446157a86b75502c1636b0d81e642fe6bf1] Add linux-next specific files for 20210701
# good: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
git bisect start 'HEAD' 'v5.13'
# bad: [f63c4fda987a19b1194cc45cb72fd5bf968d9d90] Merge remote-tracking branch 'rdma/for-next'
git bisect bad f63c4fda987a19b1194cc45cb72fd5bf968d9d90
# good: [46bb5dd1d2a63e906e374e97dfd4a5e33934b1c4] Merge remote-tracking branch 'ipsec/master'
git bisect good 46bb5dd1d2a63e906e374e97dfd4a5e33934b1c4
# good: [43ba6969cfb8185353a7a6fc79070f13b9e3d6d3] Merge remote-tracking branch 'clk/clk-next'
git bisect good 43ba6969cfb8185353a7a6fc79070f13b9e3d6d3
# good: [1ca5eddcf8dca1d6345471c6404e7364af0d7019] Merge remote-tracking branch 'fuse/for-next'
git bisect good 1ca5eddcf8dca1d6345471c6404e7364af0d7019
# good: [8f6d7b3248705920187263a4e7147b0752ec7dcf] Merge remote-tracking branch 'pci/next'
git bisect good 8f6d7b3248705920187263a4e7147b0752ec7dcf
# good: [df1885a755784da3ef285f36d9230c1d090ef186] RDMA/rtrs_clt: Alloc less memory with write path fast memory registration
git bisect good df1885a755784da3ef285f36d9230c1d090ef186
# good: [93d31efb58c8ad4a66bbedbc2d082df458c04e45] Merge remote-tracking branch 'cpufreq-arm/cpufreq/arm/linux-next'
git bisect good 93d31efb58c8ad4a66bbedbc2d082df458c04e45
# good: [46308965ae6fdc7c25deb2e8c048510ae51bbe66] RDMA/irdma: Check contents of user-space irdma_mem_reg_req object
git bisect good 46308965ae6fdc7c25deb2e8c048510ae51bbe66
# good: [6de7a1d006ea9db235492b288312838d6878385f] thermal/drivers/int340x/processor_thermal: Split enumeration and processing part
git bisect good 6de7a1d006ea9db235492b288312838d6878385f
# good: [081bec2577cda3d04f6559c60b6f4e2242853520] dt-bindings: of: Add restricted DMA pool
git bisect good 081bec2577cda3d04f6559c60b6f4e2242853520
# good: [bf95ac0bcd69979af146852f6a617a60285ebbc1] Merge remote-tracking branch 'thermal/thermal/linux-next'
git bisect good bf95ac0bcd69979af146852f6a617a60285ebbc1
# good: [3d8287544223a3d2f37981c1f9ffd94d0b5e9ffc] RDMA/core: Always release restrack object
git bisect good 3d8287544223a3d2f37981c1f9ffd94d0b5e9ffc
# bad: [cff1f23fad6e0bd7d671acce0d15285c709f259c] Merge remote-tracking branch 'swiotlb/linux-next'
git bisect bad cff1f23fad6e0bd7d671acce0d15285c709f259c
# bad: [b655006619b7bccd0dc1e055bd72de5d613e7b5c] of: Add plumbing for restricted DMA pool
git bisect bad b655006619b7bccd0dc1e055bd72de5d613e7b5c
# first bad commit: [b655006619b7bccd0dc1e055bd72de5d613e7b5c] of: Add plumbing for restricted DMA pool
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
