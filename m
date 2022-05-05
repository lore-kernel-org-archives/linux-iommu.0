Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59B3C433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 23:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 572128401F;
	Thu,  5 May 2022 23:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OSqvSd6BpjDD; Thu,  5 May 2022 23:34:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1D3C784002;
	Thu,  5 May 2022 23:34:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE9C3C0032;
	Thu,  5 May 2022 23:34:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74017C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:34:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4DE32410A3
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:34:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oP730OT7CJ5E for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 23:34:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B4ECF409A0
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 23:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651793676; x=1683329676;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=e4xAlXjdS8MCGUsR10ciFFRDY1UxoD2TIASBAviQ/iQ=;
 b=blbHNPyh9g3wkZIM20QPpfV3nT0WBUtXJelWTUh1t0G92nSRAv4XS8ER
 UyEgH5k/nz8HqxP9N33/9TMfHvW6ZFUqzH0UXlyrT5HkrQ6fAdbdyfvDA
 5QS5Ljz4ErUfn6AcQwEYgwsmTZu8lMH3d5DKx7oT+FIzt0rlABMgGRPyK
 q7IYOOB34Q1hWg6Z0w4KruJCtQZElDymiLRlCAAuadc3EbHDFaRlCJPZO
 nI37lcPZVqLUZ5KcGN00HUKMAxxl/yynF65ykvA6RKjtIc1nuLKvW0S8+
 wHLpWn+bytpfln6uiyXp3nDTTAFDfzPI79kw7GWybzv2nLdM7+vnr+g5o Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293491206"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293491206"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 16:34:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="563505870"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by orsmga007.jf.intel.com with ESMTP; 05 May 2022 16:34:33 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 16:34:33 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 16:34:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 16:34:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 16:34:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THc6LezqOr5YaYK0tkpLdkwnmB5zSyExlFtyIQ7P8mbSl4vuFJYX+U/og6Ain9cN7E9N8pre9JskuBE942zANQSZ4/HbC4yFWmsY4sEkLTsfbOiMUH1DCKs2yD0WQBvfFRcSD66sNYSSiuBcffxRLIo7C9X/aS/T5BnfeQY5o6NTXkoX4S4O04Ok/IYQ8Xp5laUoMSPxsdpq78Pisw7Ksz91MTjsjQAlVGFNdhSF+ilD789xaEzYV1IdAVlsuVCKIJw5RjzWEid7wfyZvIReXciTHIEe7Ni6N4sFCgcXW77EClrQQfC/1jXMxUGgrnBIOpOSkjCNN6qmUOdPotKK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjqauQu2Yr3JZYKjjIqTv/CExlCW0vP1frWALq46DP4=;
 b=a46ltuIjAa/KYto7E9/+a6xQyUIhOF3s2RLrjHLoaGqDWxrTyNfdJVtCXm4IpLBwlkZ2PBXIf9Q8MbqsAT70z67Zeyo/XiqYeW/GyN/KgnUyji8c9vbiIxtpfS75EO6LuTPrOi+SDP6gtZXfdqWExF8VzM7obuUPhLPKgyGU/sH28vsK+/q6mhfda4op0/dg261/TgFSnfEARQ+/dKv6/68kUPZlcsG0xnHb9q93pHPdZotINVlCGMosJ/EGLq5XzCwgP9+UZIzlrHXvm0C6uao11xDnmsC+GlEaY91SOVjuuX/wvTHaUXAwbojRtegGym9Eq/+wbr1bqgQnUxKYZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB3568.namprd11.prod.outlook.com (2603:10b6:208:ee::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 23:34:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 23:34:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: RE: [PATCH] iommu: Reorganize __iommu_attach_group()
Thread-Topic: [PATCH] iommu: Reorganize __iommu_attach_group()
Thread-Index: AQHYYJusplp8455nTEigm2v8aR71HK0Q8AEg
Date: Thu, 5 May 2022 23:34:28 +0000
Message-ID: <BN9PR11MB5276772178BE6E3780D5C5518CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-9bdc3d71e81c+494-iommu_attach_group_jgg@nvidia.com>
In-Reply-To: <0-v1-9bdc3d71e81c+494-iommu_attach_group_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d0caa4d-5f61-45ca-1fc3-08da2eefcc75
x-ms-traffictypediagnostic: MN2PR11MB3568:EE_
x-microsoft-antispam-prvs: <MN2PR11MB35684D90C797072799DF37D68CC29@MN2PR11MB3568.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6092UfRTAJ/QWs09IPAC6c/g74SmjVHX7usYSEhJ5puGqzpJGLeIj/jp1KewcG86hPBy+f05Efy/zq7tQGFkaqiFN5fwre4alEmw6sRJg6TV+4izbgGhkS1XhRsEpmFGt/aFjy3yUu2rsavzt6yRE/1voukx2D0boKoYCqPkKkOLGAOUcgvq9FtnQfWp4hlmyEGV78Gv5dX0JpN/ZOwKJBBt5oxo7aFFZaSnhnqkw4sh/zK72NAuwwiCIVo8mWKuyPZiB2Kz7nbaZLxfMwNpvE2udBzaRhMyPGtT7xOwesg8YGITtIFoD4wauM3Z8/OHnVMp+eEJas2AJjSIGH8ON9Nz2nwXt6Bk2/b0Cixn5X9MC6p3pMkErC8NLzGq8xUrocjHfC0McZIqYsJ/YRi0CmsrizSy7WOjWR7hMR/OVY0Qj9ZJKE4tGyWGXq7/aKWcFN/2Spa9H/cZdAEDTHkqSQssIDLkWKiQ7rxBfK92H7AAbvVhzLdxyL/grQE/wbqUL9noit2Tt7AHjUbiJpbvUtD7SKbhVooMvOfaeOTAl+wtg1PvOLfwREGRXKIcqIMpKsNRs4wrEcsSTHbY3A21s8WIIQrMsaf+B+TPoe/mEkpVu3kUGAZObM7ttZWuxoNJhp61/gyWP4KeG3K7NsRarsEo/d9PJ8CP2TW7fGD+i/XUnhutTDFfdeJYx6VGCN6hPPeJ0SoJ4rhbaKPBX8dFsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(508600001)(71200400001)(9686003)(38070700005)(38100700002)(7696005)(55016003)(26005)(186003)(6506007)(83380400001)(66446008)(52536014)(64756008)(76116006)(8936002)(66476007)(66556008)(66946007)(82960400001)(122000001)(5660300002)(33656002)(8676002)(316002)(110136005)(86362001)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QK1jCQiuZTmgCsC/w7qXY1eSrxHh4FWf7cpA2HTIS899KgvpJolaLZedLA++?=
 =?us-ascii?Q?xVhykMpLlSIZ8PmZEUQRnaoK5XkAiGQrIryR/xZlybRBW6o31vUgs+0RhXWj?=
 =?us-ascii?Q?ZVxTXT8/OVJFAu3y6jnAML3RYf9jt+7GmMhCiiPGA7e5Fp4JpMrx82UpdEJH?=
 =?us-ascii?Q?W2cHx718uSIWq+B7swQ6L8JqZlHECvmgf1hQ5HMH0FR4QYWkE97oXZw/cNYr?=
 =?us-ascii?Q?PO6tOPEha+cIbTX1VBsMNxjIofiDDFLfUJ1zOitu3ns/6DP8Uq2O4IItPfKO?=
 =?us-ascii?Q?OgzVVxXdrRwmVlXsTPrt3wGkY1B78FA18rcsgvxZTQX1O05ihJgfwclzOXqU?=
 =?us-ascii?Q?7L1JKq9FCESs19RMwOBDwjo29kU6RZ8AkYIWWExPlIStH7zieg16w5+Ksuws?=
 =?us-ascii?Q?ekQll7B68AOLtURyPcm40oPY4Ndubw4mknDUqu6QpfucqOhebw/UMVokiloM?=
 =?us-ascii?Q?AJzaf/tR9BGvDqq6frEIPXR3+fLTxCLDGNqr4IRx8dzgd0axkgfG9cJIWwGi?=
 =?us-ascii?Q?ietv7eA/lK3Z9DitrsU6pnt/30bugVF1deVuyiUrA2uawh7cdAiXrJJqLyg6?=
 =?us-ascii?Q?MmeD8kh6FKLhfxayazmEqpVRru2JXQ67wYyKtN83OWyIzsW32SjZyxjMrBuF?=
 =?us-ascii?Q?vGjBo+DDMi2VH4LcF80NtXrxPs2iATd76pW0bujY+ceMTFF3wwnIfcn1OTfl?=
 =?us-ascii?Q?g0M/j+a59n7EzAs+xziy1whLBvureuK7wKRrZfwxPKYfIzfaCvscqfWjb9xc?=
 =?us-ascii?Q?MXmG1EdgYk+Cr0KvFkcFvE/gynKGOKjr9ePoN7XHFW0kJm8r2ywvjZsEabl3?=
 =?us-ascii?Q?qxFUpMQJiQ2NHy9+F46FkRf+YWv+m84J3ST+iapquwQA2hvD2Pt9sQgq8eBV?=
 =?us-ascii?Q?eNSHV110eaPL1vfKqalwQWAfcbaOfRyfMoZ6FjiIyGlroSh3gBxVR4wKCecj?=
 =?us-ascii?Q?m3+q8xxqwH/vgLDGaX2Oc4PGrh2j9nfTg2D3Nup+lE/ieymb3Bq0poJpzabx?=
 =?us-ascii?Q?at53hhZyWSeQ8w3/ok8g4D76NzBxCDSoQmRyE/KmfzkJu5Frg7vvp5oAPwma?=
 =?us-ascii?Q?NyF5XSN6xFM7kiTn6eF6+/TAR5ImJ0sVF1O04p4NhVfojZzgCgjCfCCt8bwK?=
 =?us-ascii?Q?bcSlDPuE9r0E1j8M0Mfsjnv69im70Tf3K1vPPo3N17bEaBpta38pjVRIDBox?=
 =?us-ascii?Q?P/VA2m54oFLEAcVDXNf+uh6/6Cbzq7ZJ9uv3Nh5ZoKt7lvco19aiqAc5jmsM?=
 =?us-ascii?Q?K0Ult6jm30Uctj841IqLTkdIEQrbV9gMaLyDZstSrWIh8cyZwgnMBQ+p0rTM?=
 =?us-ascii?Q?C+vIJ7Y8uq58dzoSINNvnc9mEwltr4ppKS1Sm8pZF61W/tgLlNZDeU4Hb49k?=
 =?us-ascii?Q?AomUHgaNbkF7GUFKYngJiWJp/PFQC6Bb5jXddxx7XY1cJQC4mLJSbFQ9ceHC?=
 =?us-ascii?Q?O8NBrSyCyIrBpdv8+ex18zPizWLFxvXp4uUE0e9sEhRyoDHqIGNKRHdVG9im?=
 =?us-ascii?Q?YdX3k27rCb4n4BCx/ZteQ/4yoAXhS2vw2vj3qWkQAPOQgk/9PZ4QN2t69WFg?=
 =?us-ascii?Q?+irKu8PUkKeeWgBTw8tQsCD8Uo6KBYU8yJd62fXDHvmV27i3Oi2siC8W8DjR?=
 =?us-ascii?Q?Zr6PbgrXCDANBp8eNWgDilsNhMAxI1GZ/xnjIldz9J7NGME/Zhsk5QWkil3u?=
 =?us-ascii?Q?RKSGjshUGdCRjXeeDiwlQZGQCMevwDo3RdYjJzqYMwhoyfmHljBBZYE5rEj7?=
 =?us-ascii?Q?MS6CanOrXA=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0caa4d-5f61-45ca-1fc3-08da2eefcc75
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 23:34:28.8479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXzcIOoB7Too9BRDJ5B9LF3E17GMrCoirdJBmBJtEgpJi/6JdmVU5l0B88r5ePo+gk552wDIeB6f5cHScElXog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3568
X-OriginatorOrg: intel.com
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, May 6, 2022 12:16 AM
> 
> Call iommu_group_do_attach_device() only from
> __iommu_group_attach_domain() which should be used to attach any
> domain to
> the group.
> 
> The only unique thing __iommu_attach_group() does is to check if the group
> is already attached to some caller specified group. Put this test into
> __iommu_group_is_core_domain(), matching the
> __iommu_group_attach_core_domain() nomenclature.
> 
> Change the two callers to directly call __iommu_group_attach_domain() and
> test __iommu_group_is_core_domain().
> 
> iommu_attach_device() should trigger a WARN_ON if the group is attached
> as
> the caller is using the function wrong.
> 
> Suggested-by: "Tian, Kevin" <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> ---
>  drivers/iommu/iommu.c | 42 +++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
> 
> This goes after "iommu: iommu_group_claim_dma_owner() must always
> assign a
> domain" and simplifies some of the remaining duplication.
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index c1bdec807ea381..09d00be887f924 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -81,9 +81,10 @@ static struct iommu_domain
> *__iommu_domain_alloc(struct bus_type *bus,
>  						 unsigned type);
>  static int __iommu_attach_device(struct iommu_domain *domain,
>  				 struct device *dev);
> -static int __iommu_attach_group(struct iommu_domain *domain,
> -				struct iommu_group *group);
> +static int __iommu_group_attach_domain(struct iommu_group *group,
> +				       struct iommu_domain *new_domain);
>  static void __iommu_group_attach_core_domain(struct iommu_group
> *group);
> +static bool __iommu_group_is_core_domain(struct iommu_group *group);
>  static int iommu_create_device_direct_mappings(struct iommu_group
> *group,
>  					       struct device *dev);
>  static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
> @@ -1938,10 +1939,11 @@ int iommu_attach_device(struct iommu_domain
> *domain, struct device *dev)
>  	 */
>  	mutex_lock(&group->mutex);
>  	ret = -EINVAL;
> -	if (iommu_group_device_count(group) != 1)
> +	if (iommu_group_device_count(group) != 1 ||
> +	    WARN_ON(!__iommu_group_is_core_domain(group)))
>  		goto out_unlock;
> 
> -	ret = __iommu_attach_group(domain, group);
> +	ret = __iommu_group_attach_domain(group, domain);
> 
>  out_unlock:
>  	mutex_unlock(&group->mutex);
> @@ -2032,31 +2034,19 @@ static int iommu_group_do_attach_device(struct
> device *dev, void *data)
>  	return __iommu_attach_device(domain, dev);
>  }
> 
> -static int __iommu_attach_group(struct iommu_domain *domain,
> -				struct iommu_group *group)
> -{
> -	int ret;
> -
> -	if (group->domain && group->domain != group->default_domain &&
> -	    group->domain != group->blocking_domain)
> -		return -EBUSY;
> -
> -	ret = __iommu_group_for_each_dev(group, domain,
> -					 iommu_group_do_attach_device);
> -	if (ret == 0)
> -		group->domain = domain;
> -
> -	return ret;
> -}
> -
>  int iommu_attach_group(struct iommu_domain *domain, struct
> iommu_group *group)
>  {
>  	int ret;
> 
>  	mutex_lock(&group->mutex);
> -	ret = __iommu_attach_group(domain, group);
> -	mutex_unlock(&group->mutex);
> +	if (!__iommu_group_is_core_domain(group)) {
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
> 
> +	ret = __iommu_group_attach_domain(group, domain);
> +out_unlock:
> +	mutex_unlock(&group->mutex);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iommu_attach_group);
> @@ -2110,6 +2100,12 @@ static int __iommu_group_attach_domain(struct
> iommu_group *group,
>  	return 0;
>  }
> 
> +static bool __iommu_group_is_core_domain(struct iommu_group *group)
> +{
> +	return !group->domain || group->domain == group-
> >default_domain ||
> +	       group->domain == group->blocking_domain;
> +}
> +
>  /*
>   * Put the group's domain back to the appropriate core-owned domain -
> either the
>   * standard kernel-mode DMA configuration or an all-DMA-blocked domain.
> 
> base-commit: f9169ee95787fe691287eeed1a1c269ea72c8fb4
> --
> 2.36.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
