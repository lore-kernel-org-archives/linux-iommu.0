Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD841C433FE
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 10:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A6C760D89;
	Tue, 15 Mar 2022 10:24:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N5E5ityaGX8a; Tue, 15 Mar 2022 10:24:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E61D560DF6;
	Tue, 15 Mar 2022 10:24:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B652DC001A;
	Tue, 15 Mar 2022 10:24:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A0C8C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 10:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 012E9415F4
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 10:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zMXGQwMJidpB for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 10:24:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A0A94415F1
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 10:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647339892; x=1678875892;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qT1G6daL/6sLj1qww8o56suCDrMdK8yiZAJyESJkol0=;
 b=mv3RFP8E5JJFa/4GZJT4XyLo50I2asZMj4tW9/bq443Rs5L7Z7LXgxaY
 qY9dlJ70Xr9X6q6XXGaSwAlB0OGft0vcClP/qSQuZ1Ltv+g1/ipuvax7I
 VkflHlNNfY/vHEtzMV2WhiEe7G85/DsYhq10r8GeycibZIss9F9xsMG5D
 oensmqlBtgKej8mg13mUpmv2r+7nx3EnF3UZT5xYb4V4+t/7q7z7kpUro
 zuxpqVHS2OU+y+gTYrMkdKD6hIImWOMggfGmF+S5/1W+xowfPljd/jIFW
 75pZHBd4sx0e/bUvuRs4HcIbG1Xwip2Rl+yW5frqbfA7AyRX32xaZtE/n A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281033994"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; d="scan'208";a="281033994"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 03:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; d="scan'208";a="549547559"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga007.fm.intel.com with ESMTP; 15 Mar 2022 03:24:51 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 03:24:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 15 Mar 2022 03:24:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 15 Mar 2022 03:24:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp1eMRgh77lcIX9J2DcodlABhxV0+HedHuGlxmpqi54zCgNXBzo1jQz0flyuQF4HIRJhXI8y/UihmHYUL6fh9Va/KWulI0FvHjp8RJaPqbsq7HsjdcXTzj43YQIsN3yV8yRJEugLSsImSxZHZulhJz0llguwc6RuvYMWGlxRee0Z+PdDOfdwhmFZh9dE0Q7trIRDFcSsE9wEUYea7fCA+bpWfEAqgaV3z0dHlvU4edUBfjwq88vs3CAi3rBX0hDUS5tPhp87Hf2BbYNkgFRzwrwV1SF/gvWubbiSRXI3BRwt8lory7+m6z1pT22W5eOxAKn2+NTenwVuTA+cnJ41zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCSzp+6qRlY1XMdWPvBPG1ECztRa6SwYo0SmsyGuLl0=;
 b=SsBrTJZEVzU6lIcl3+me9+pICfnpAN4DmbHgWOLEvdDFYFfirbis+W4gLyt0PUEqlkknOBB4pki9Oq5l2GgNTXdLDcaIcWhGqDgKhZFtEcyJ1MXwJbLZYSlORd6uMBg3FbEbmmxs3uhxIltB6/PGQ231vStNAZ30ds8n2qHqgdFgSroeQTIuc+0131LW5tSa9KB1+HlhHHADZeLMfwQffKqCroAsu+mMpvdvg1J8we7CDHjWHYibby0Os008HGIh+VlB/LeV6OvLRpRw6s/IcguQgpw2IUIs78RHJ24g/84hbZIy3+fSE0D1Xq2V7M7AtaB5FSfCVI72cWiErRiZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4350.namprd11.prod.outlook.com (2603:10b6:208:191::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 10:24:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893%8]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 10:24:49 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: RE: [PATCH v2 2/8] iommu: Add attach/detach_dev_pasid domain ops
Thread-Topic: [PATCH v2 2/8] iommu: Add attach/detach_dev_pasid domain ops
Thread-Index: AQHYOCoYv35DknzN5kqPD8yptRL1a6zAPSbQ
Date: Tue, 15 Mar 2022 10:24:49 +0000
Message-ID: <BN9PR11MB52762F97E491B6A8541D38BD8C109@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e8c3f07-1949-4b4b-3154-08da066e08e8
x-ms-traffictypediagnostic: MN2PR11MB4350:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <MN2PR11MB43504410B4D3212D492AAA7C8C109@MN2PR11MB4350.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /8LdfYk/534yN/L4Wr2/uMJLjDoFTU5rO3x0/vCjJFIfyUuHwTmbtOeRh1Nlld+0nLD+a61AlVnCLZ3aexuVewZBdYSOflSJY0g0CLBtiotgVUZzhEz8DPVotLJ/wNuHpYThvup1sq12Ar+3I2I3OvTbTTg1psVU3bkv7yFGop6Wgy11Hqcjic+zeWTZ/hYVu/p48DsXOq9ctE7EXgP69UyThGcjaMTSuLEATttUIIVz4RdAsU4wgb+xOOINum3AThs7YI5DgSpm6MnEeVOfn78o1ibJSrhFgQ6H+JczE6yCIpt4vQC4rMQgOM/l4BLjJTHeHUdIeS2u+outOD+bHYRuSiJHziWZPwkj0u76N+mRxkgo57av/RCuVizoXRNxCZU2gMkN0K8eTq3scAQnq87whbirBjNiKWpremKpwmdUONLPoScEo3rvREmoNCfvpgRqDZo4ZlcSFoXyjlks40292HymeN/n1ktfDhmGBeHRamSxk/yUSB7nec9mtKnw36+GB+RC3l9Sj8Y+nxQk7t312mLiLtVPjh2bSD6Xbch4ILwdIgD3dZ8fqPytfZUVwgJ78ofEWs3nj3EIgdhU2ivj4OvFucfnF9Cjn1xtETqIQNcXZQpOh5hxhKvRbs8S8p9l00jce0ssOYrzb+sQ1AY5l1VaIg8LcLQeaqZKpfaDJmMqGB3QUoBNXQ14bveV8A17WjQgqjk8hPMFDyTVTQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(122000001)(82960400001)(66476007)(66446008)(64756008)(508600001)(8676002)(4326008)(66946007)(33656002)(66556008)(76116006)(316002)(55016003)(26005)(186003)(9686003)(8936002)(2906002)(52536014)(86362001)(6506007)(7696005)(5660300002)(38100700002)(38070700005)(110136005)(83380400001)(54906003)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A40px6IQ/8EPHslfGKXs2hh1iJJqlS5bmE/3UAAhsexcFcAauDDAVSVoWEt7?=
 =?us-ascii?Q?bn3Y77W+thzzrOf6fglfijBXJB5XGSPjQjybvMDWFLNdM9c5w+U5XTa+wLlD?=
 =?us-ascii?Q?YkcowQ9mzrLCKQl7t1heHnDb1hI0kZz13qUojFNaRNjPSMPqTbST1+yvj+ok?=
 =?us-ascii?Q?mbaw5ht8ewrefk/uCylTQ9f2G+lO1cFQfmwS/NjVdhd0+jJYrNImwpIWf+8b?=
 =?us-ascii?Q?l9bj6ZtYf6QYx9FAFbK0axAII28V4TOIjJ6RKIPpAR6i4cO3YxBaIYjB37h5?=
 =?us-ascii?Q?jegwuJtPoD7dsDeINK4XVww2VdPRf/ir7+li65TD6QOQnTr4K5WH2OIWZa5B?=
 =?us-ascii?Q?mDYykProfGTWLICwKc6dC4AisLUKe9Ttwjp8e+7Rb6gNsi35IdHwyeaKLHYP?=
 =?us-ascii?Q?F2e0UtecZvXQxyriGWFSvpKmvnw+i+8KfgyrRgZs7j1bHTX9euJiH8CAsZJ+?=
 =?us-ascii?Q?hDsyoqFz/DOzU3aBNO4USvgE7eEo22jBGv+5x+t6G2d4uTh/DI/SADjUyaJy?=
 =?us-ascii?Q?cd8U66nSvIj8Q8cP7iLheLYQPTY7CpkjNJ3qVxqEAvREvWbgCpcMgs0w4HM2?=
 =?us-ascii?Q?At5dsbQ2XLEKh50q6ii0VHoB28yVYfMxTLkPjMDJqbFqEXpVpSpb6+lw4OXW?=
 =?us-ascii?Q?QTobfrR1ZWiSvWTx36EjAyAw0xKeI0REZyRn4H8t3hTq2sn2uplrrnA2+/33?=
 =?us-ascii?Q?dD9gX25LlD7SmYSnselddPl1e9jQmg62i2qGelOi3nzztahFsmoKvZT3BmjH?=
 =?us-ascii?Q?2JbS9MEZyWRkqtYMxw5yfgsBanWEGyGEL/+vdlvyWYzG17FhxB9tcNZmCTeL?=
 =?us-ascii?Q?NwUeR5QN35wvNlQlEMMhOwD8tG2nJJQTD2n/HTHJJBe5j0CyWb2Awj4uVT8l?=
 =?us-ascii?Q?BxgikJFZlHprzgahV5xMmOcS8UH5oTRHoFQIzxF6Mfs/tAVVIRA285yYJxNf?=
 =?us-ascii?Q?h7HmZfmlB24RgPhwSfwpiniVa+/Lcjr1DhnVgWrKYKU0ExC89j4wA4mf/AAy?=
 =?us-ascii?Q?t9jUQvJD5g8VKlf3FUMXeZ9P02Dv/QB5rmTDjhTIXvnEr8MV7XrMmK7VKtID?=
 =?us-ascii?Q?qxpVOi1uWCdhFRR/9UUDz13KURzYuODoLDlSB6Z6NM/IPpg3eovYWokNNzhH?=
 =?us-ascii?Q?X1l2PAeMxGpk9YSMLgxLeLocExa/XeXIYuo/h52UHsDrJ8ETOaE84QZ3etGg?=
 =?us-ascii?Q?a7KfEqlKd/iJErEePwpAj+7zAsJuCzCIU1Y+8gDj8aWEzZ+oZsR0+4aHAn2W?=
 =?us-ascii?Q?bAi5wHYqeTrhU6kbpGVUwih1rxmwBshdwQURE6FbTPGLqRLUGvfoqMMIC/V6?=
 =?us-ascii?Q?OT3k1SZE25os8BE5r1RnyMO7FIAmMrgJS6UcYh+KVeHP0jJ62A1gfQKrSxwu?=
 =?us-ascii?Q?32ShiNMmnOOELYS2AhlIF78jV/JulzdUXUqReHYXbeGbOU19KGVUSQwsTsu8?=
 =?us-ascii?Q?HPYHkaa2eSiJ/21DyPhFKU7p3mOv0E5U?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8c3f07-1949-4b4b-3154-08da066e08e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 10:24:49.1169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYcTpq69lAYq3tTQxlreFiBOUhw86p9vzKsb2JHf3og/qMq0ZlXhe5vBWSr9SubyxeLq/tUAD+bShh/Z+jwGFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4350
X-OriginatorOrg: intel.com
Cc: "Luck, Tony" <tony.luck@intel.com>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>
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

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Tuesday, March 15, 2022 1:07 PM
> 
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> An IOMMU domain represents an address space which can be attached by
> devices that perform DMA within a domain. However, for platforms with
> PASID capability the domain attachment needs be handled at device+PASID
> level. There can be multiple PASIDs within a device and multiple devices
> attached to a given domain.
> This patch introduces a new IOMMU op which support device, PASID, and
> IOMMU domain attachment. The immediate use case is for PASID capable
> devices to perform DMA under DMA APIs.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/linux/iommu.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 369f05c2a4e2..fde5b933dbe3 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -227,6 +227,8 @@ struct iommu_iotlb_gather {
>   * @aux_get_pasid: get the pasid given an aux-domain
>   * @sva_bind: Bind process address space to device
>   * @sva_unbind: Unbind process address space from device
> + * @attach_dev_pasid: attach an iommu domain to a pasid of device
> + * @detach_dev_pasid: detach an iommu domain from a pasid of device
>   * @sva_get_pasid: Get PASID associated to a SVA handle
>   * @page_response: handle page request response
>   * @cache_invalidate: invalidate translation caches
> @@ -296,6 +298,10 @@ struct iommu_ops {
>  	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct
> *mm,
>  				      void *drvdata);
>  	void (*sva_unbind)(struct iommu_sva *handle);
> +	int (*attach_dev_pasid)(struct iommu_domain *domain,
> +				struct device *dev, ioasid_t id);
> +	void (*detach_dev_pasid)(struct iommu_domain *domain,
> +				 struct device *dev, ioasid_t id);
>  	u32 (*sva_get_pasid)(struct iommu_sva *handle);
> 
>  	int (*page_response)(struct device *dev,
> --
> 2.25.1

Probably this can be combined with patch05 to demonstrate the usage
together with the definition of the new ops. Then comes the vt-d specific
change.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
