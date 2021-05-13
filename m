Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9BAC433ED
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 19:15:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3558613C1
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 19:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3558613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6078841463;
	Thu, 13 May 2021 19:15:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YFi8kYhRDUJu; Thu, 13 May 2021 19:15:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AC9B40FAD;
	Thu, 13 May 2021 19:15:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 024A9C000E;
	Thu, 13 May 2021 19:15:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA24CC0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 19:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3316402C2
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 19:15:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3XlB2URm-8zQ for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 19:15:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 209F3400D6
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 19:15:00 +0000 (UTC)
IronPort-SDR: lX3kLw6/VTwpe6VxTsq2KcXGGgwaB3ccBZctgv3bG4O+Gt/i/RSr1u6zCsVsb+M4xwOrRVOT85
 1+qBvL6MX3Cg==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="261273077"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="261273077"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 12:14:57 -0700
IronPort-SDR: 7WEggcpESFwbovgw4qCaZtkJ0dnpYOGOo+UvuJZn9NCMESFuAGSr/nAaGZZYjsp3VWNrGfznTf
 SBUHkmiZmNHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="401132951"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga007.fm.intel.com with ESMTP; 13 May 2021 12:14:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 13 May 2021 12:14:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 13 May 2021 12:14:54 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Thu, 13 May 2021 12:14:54 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Thread-Topic: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Thread-Index: AQHXR/foStIq1WXEVUyqodFI447jQarh3/IAgAAZyAD//6FJIIAAhnOA//+hPACAAHc/AP//jORg
Date: Thu, 13 May 2021 19:14:54 +0000
Message-ID: <e9dd39aa8a144c23beffa5ca58936385@intel.com>
References: <20210511163521.GN1002214@nvidia.com>
 <20210511110550.477a434f@jacob-builder> <20210511194726.GP1002214@nvidia.com>
 <YJt3tGlzFK3b4E82@infradead.org> <20210513060012.0fcc7653@jacob-builder>
 <20210513133834.GC1002214@nvidia.com> <20210513081050.5cf6a6ed@jacob-builder>
 <dd52760ab65a40328b4c1a26ddd0e1d0@intel.com>
 <20210513173303.GL1002214@nvidia.com>
 <20210513185349.GA801495@agluck-desk2.amr.corp.intel.com>
 <20210513190040.GR1002214@nvidia.com>
In-Reply-To: <20210513190040.GR1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
MIME-Version: 1.0
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
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

> If you want this then be explicit about what it is you are making when
> building the API. Don't try to hide it under some generic idea of
> "kernel PCI DMA SVA"

So, a special API call (that Dave can call from IDXD) to set up this
kernel PASID. With suitable documentation to explain the scope.
Maybe with a separate CONFIG option so it can be completely
stubbed out (IDXD does *NOT* "select" this option ... users have
to explicitly pick it).

> I could easily see an admin option to "turn this off" entirely as
> being too dangerous, especially if the users have no interest in IDXD.

And a kernel command line option to block IDXD from using that
special API ... for users on generic kernels who want to block
this use model (but still use IDXD in non-kernel cases). Users
who don't want IDXD at all can block loading of the driver.

Would that work?

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
