Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A58BC433ED
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 16:44:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D8F61438
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 16:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D8F61438
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 700498392C;
	Thu, 13 May 2021 16:44:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SYx6dOwGcp51; Thu, 13 May 2021 16:44:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E86B838E0;
	Thu, 13 May 2021 16:44:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35222C000D;
	Thu, 13 May 2021 16:44:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DAE8C0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 16:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C1B38392C
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 16:44:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FMGfzA9q_Hxg for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 16:44:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 94E0F838E0
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 16:44:23 +0000 (UTC)
IronPort-SDR: 5hM0ciqSAOMUcuUsl17wYpT6NmhbPgshhspQlddXaUz9Vh1c+Yahb8534AOM79vSY11MmK7krL
 S0pQuErqqzwQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="198024314"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="198024314"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 09:44:17 -0700
IronPort-SDR: IzZGvtmnOazCD/bdR7ddiOefUMtd/AXraOiK6SBYoyzo+X5ZP/cBfdwwYrFpbll8uQyCUSKjPz
 m0Sm8Wk2hywA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="626299114"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga005.fm.intel.com with ESMTP; 13 May 2021 09:44:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 13 May 2021 09:44:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 13 May 2021 09:44:14 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Thu, 13 May 2021 09:44:14 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Thread-Topic: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Thread-Index: AQHXR/foStIq1WXEVUyqodFI447jQarh3/IAgAAZyAD//6FJIA==
Date: Thu, 13 May 2021 16:44:14 +0000
Message-ID: <dd52760ab65a40328b4c1a26ddd0e1d0@intel.com>
References: <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210510233749.GG1002214@nvidia.com>	<20210510203145.086835cc@jacob-builder>
 <20210511114848.GK1002214@nvidia.com>	<20210511091452.721e9a03@jacob-builder>
 <20210511163521.GN1002214@nvidia.com>	<20210511110550.477a434f@jacob-builder>
 <20210511194726.GP1002214@nvidia.com>	<YJt3tGlzFK3b4E82@infradead.org>
 <20210513060012.0fcc7653@jacob-builder>	<20210513133834.GC1002214@nvidia.com>
 <20210513081050.5cf6a6ed@jacob-builder>
In-Reply-To: <20210513081050.5cf6a6ed@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
MIME-Version: 1.0
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

> For shared workqueue, it can only generate DMA request with PASID. The
> submission is done by ENQCMDS (S for supervisor) instruction.
>
> If we were not to share page tables with init_mm, we need a system PASID
> that doing the same direct mapping in IOMMU page tables.

Note that for the currently envisioned kernel use cases for accelerators it
would be OK for this system PASID to just provide either:

1) A 1:1 mapping for physical addresses.  Kernel users of the accelerators
  would provide physical addresses in descriptors.
2) The same mapping that the kernel uses for its "1:1" map of all physical
    memory. Users would use kernel virtual addresses in that "1:1" range
    (e.g. those obtained from page_to_virt(struct page *p);)

If people want to use an accelerator on memory allocated by vmalloc()
things will get more complicated. But maybe we can delay solving that
problem until someone comes up with a real use case that needs to
do this?

-Tony


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
