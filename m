Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A6AC433EF
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 05:04:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DBF8540BB8;
	Thu, 12 May 2022 05:04:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZGylV9OVbleD; Thu, 12 May 2022 05:04:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5955740BB6;
	Thu, 12 May 2022 05:04:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1442AC0039;
	Thu, 12 May 2022 05:04:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A289C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 05:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 01F08416E5
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 05:04:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UXLzmqeGnc7M for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 05:04:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B3D1416C3
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 05:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652331849; x=1683867849;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nMhjqCoCUXkAEsuNTKaQIpf38TZASYcCOOAoHaZT5HQ=;
 b=mrwSHc7FUQjNDXPcPTgqvNpbCOtHYh0t9tu+IVXxvlQ/OkvXb5TcP0pW
 91JEyzAeo0ZIUE4KnNvYNlDSAaVzOIYJWLQYCdzu7SVu3+anQbmEZT53w
 RXO9c28K4C2T5fN7exxgRsCRvibJVUI1Lu7Hhv6wxC0eD9vfQ68TMVQog
 Azv6Bs0+OIiRo3b7ZLK3+aTakV/DCcbUVOexXpPXvhAbfICpqytxigt7W
 AuAtl1JVhZiD2/BZQhG7vjmPt5k7Cvtfu5QUO4OIx6iqFfbqMwswriKaO
 iFHi+QZtzfdjEESvIaRPsynOMUp93q7+Jk5eFHVc/6V0u3OtVTCrFO+o6 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="295137221"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="295137221"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 22:04:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="739523647"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga005.jf.intel.com with ESMTP; 11 May 2022 22:04:07 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 22:04:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 11 May 2022 22:04:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 11 May 2022 22:04:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qdb6AdBW0vGreAGb2EKlVdfvUm+IvRHcjsR/gHsnUxxFm5W36z0vlLcF0D6XBWZstEpsLi9jnN5eA1nf5in439mBO8n2lWokZvHScu99jvMndgo14gRSLlvgFvosskmNQjJ1iaGoyOith5/u9OybIyPdcev1cGGIsF5SGpqv4R+1bl+XM4cRjKc2Vob8PhlwK1iZR4TRb0U8xCfHYuYGo/2JaFEKvJjC1H6TgKPymlwNYpn1HjMHlM3BG0JK5ihSOaRFtjst6+7lZlwvYktdIETElB10zFUP3bz4OdPCvhEwvtfqxFsiYl0K7f6LKNjGL+q8G0bv/UE9KlwDf91xdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kf5g3krL56kueQppFpbCceqKfECMcDsFdzYMuxBQW8o=;
 b=dmtUYCrhtPYIKV5HyU89odVBZD2JgmPYJOFLVKX64rJ0dEu8CWSL2sPg65ei+HJ6AMu/+DxBOWoVanMIAIsu9kYNTLSerCeWQMyjqFdlX0y2sCrwv71XLdrj2xFGjl+IH2m5EwBFLZMqL4//EVBlw4ZaaOP3JAn4RfkuFjjosGKp1F6jResDXkqAEw59/4XmwzD2QY0Li5f2cfT0jKhMPKZfI/Vi3zvcRheor0mtj8k3Gubto18IWfn+LimIFOHhBaEFpOPfTXsWo5DztOfJUZ6LVIA4knIQHCiq5zEM9oHv6KVEnDXF9js2RxaHUwUd2V5pBmlsUzACOdfnGVYOiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN6PR11MB3053.namprd11.prod.outlook.com (2603:10b6:805:d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 05:04:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 05:04:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, "Alex
 Williamson" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH] vfio: Remove VFIO_TYPE1_NESTING_IOMMU
Thread-Topic: [PATCH] vfio: Remove VFIO_TYPE1_NESTING_IOMMU
Thread-Index: AQHYZI7dq9TduIMKTkCo3fSMMIGO560asiUw
Date: Thu, 12 May 2022 05:04:05 +0000
Message-ID: <BN9PR11MB5276B77429B8B601A25228D58CCB9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com>
In-Reply-To: <0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 272d4cc8-3f8e-43e8-1a7c-08da33d4d696
x-ms-traffictypediagnostic: SN6PR11MB3053:EE_
x-microsoft-antispam-prvs: <SN6PR11MB3053D6812BDF423BD0D08C678CCB9@SN6PR11MB3053.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9MVVHRZmd+JKWs3l7Rzw9sdkwUwuv1fJrvurnITdnfpGGoRqvSzKYO/ZgFAVrgX+OVvoc3pANtV4PgevU9wqQ6rvSf9osw29HlkhURR9tgM8qmlC36v4ukVJo7MbuOnTgNiRc/T5urOlqvnuYOKOfxiO8x6iKs4ekvO6usISHBRSxbws4L8lBrJZSrSbxk0jDH3KVTKfz0T2IIsAcEDk2C+mlSbwTAqU6ZlpSdorFLe2yv3M39jkg3ChrtO5mHrwg4A94zvLUELft5TTUsUeW0dHv2mQmPeX7VmoBVk5olEmzPEXGGP2v7JTP0VyL6V6GFkm8Iq7ii/JFQTwZf2xPP7vtrJH6UNlyKNORakqHeD/Fn2kRPbwqTbMecmDaq4owRyt/SYYMM6IotHK7kTNQzxWir2zcIjr6Mqx/gHsdC58fDTVFZX915g2tW8WadjIiTRG53/i34q9dbpx7RMf+Op4vl5DWQSnsutrLrJtoNFFm8UoMpbLKAqY6wHeB7a2TNj19uvYMu2wiqbfTVV/zra5YYfRX+ZA7y5BLuqaBJswQ/hHdsarCqaMa7l1Spv1LhvLtL4kvqzVnxhwV57CDmTyvHMiRkZ3K0v3X8ZpZ1pvImUEzAgV7DLBae3W7vfxbGKRHG+XgVlze4pPTS35qxTDWwLg+X8ELNj0bMuYfiYNT8noLWaGPM2zYquuGH0nOYJHampijT37tI1gvonrleiR9t4cgnlsAoShYpxOzMz10r+Z+vusxoOcJpCXhftXrZrrZoOhYWuZBjfLF8xQLBWIKZSdMyzXmjgWyFXUzWQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(2906002)(66556008)(66446008)(6506007)(7696005)(86362001)(316002)(38100700002)(83380400001)(38070700005)(5660300002)(186003)(26005)(966005)(9686003)(33656002)(52536014)(82960400001)(508600001)(8936002)(122000001)(55016003)(110136005)(76116006)(66946007)(8676002)(71200400001)(64756008)(4326008)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pKiNFv8lRpLaXY+IJBUup56mdlWEvqjObWyceuax0dwj2CrMjnTVof8R1w6y?=
 =?us-ascii?Q?qKR5H5K3iH2sHDeuF+Su6oEwYh8h48Ms4qbRsijcy45Q2Yv+C9Jk/fEveIqQ?=
 =?us-ascii?Q?FW2eKFQYJ4+yhpNMqmnAT9u4JF9m4nQV9p6mMXCD07eee7Sip4HC4oEVMVQV?=
 =?us-ascii?Q?wfFGwcnuuUS3uE2lHhyhtkIKUyvsTLRSwQgpN4KHxnD4qq7wfm7RJs2f3LpQ?=
 =?us-ascii?Q?05Kt62sTxZkzVgmZ5tFIRyTOZKDgDdL4bm1s76kNMPC03HtEUX4dFIHkUAHf?=
 =?us-ascii?Q?kghcMQPJyU/VvLWmYmomzCtABthLKlYb9KDZ44NTUoc+G88Pt6bh6j1VwPED?=
 =?us-ascii?Q?JF6F0sTcWAM1yjV31nE7hxzFSmeoUgBPgXiZZ3xPYV2D/HmJaBTkLmRZfvwE?=
 =?us-ascii?Q?ZtINOMW+OnEbAoQnMOVLylo0MHgu78YLxnxPHheaDKMT9KN9uwTOn4aqnhce?=
 =?us-ascii?Q?GWZsYxzrHMe6HJAA50yREZpJPgHXsVW8g5DhsfpuLgSh3hRcle3cIN2BRZ5B?=
 =?us-ascii?Q?YBTrn2eLVB1MyibemluFVV68fYKFtwEyAkj25OXsC1NQ07DGZBlIlPwqRGI0?=
 =?us-ascii?Q?HIZuu6+9bR9kn45I1H77Rmv7c7etcMAvuqJwa61/hy0I5EWcyxl1iI5ayg2/?=
 =?us-ascii?Q?hq+m3ODYZzQKwCLqYlHMWNJx5/eGl3ydvf4ZoPT9ctvX9k3btMs2Eil2q+lA?=
 =?us-ascii?Q?Dk2WCV7JJAnkcdtaeul8mlrmvZykkse+UfNjZ347n2Ip+jHUe+txi4LiCxYl?=
 =?us-ascii?Q?1P0gpsW4GCicPotpfz7qlT3lIwlo8qE6agB2leANdyqnWOKwEJyXFfYRjnTz?=
 =?us-ascii?Q?BQub86TRs5yX4virA3H0NlPKpOijLAhCW/DnMZLtPptn210znYbA0uuTHeTV?=
 =?us-ascii?Q?KYcEnz58hh6BhIcV0cZkGxkgOX6qGjvoOjMgJSFKpppjPsSRFvunyqwkhWp9?=
 =?us-ascii?Q?KfjTLY2IvcedQUlXOBBxztmO3mzM1l8Xjl+R/3S+nnNxINHylA7SICHUQJkm?=
 =?us-ascii?Q?RFuDgvRPDjX5Q2A664JHj51CShzUeSIAiVgbTr/XvWg0S8lVkIL1tVit6/CA?=
 =?us-ascii?Q?xr1+jI1h2uQQfYhI2MO/nkzQgicex+bNpOUt3jLenUDybumzaD3TgEfrANFR?=
 =?us-ascii?Q?pu5cxXFyIkFd9KRPjyGImB1EfO/HQEYj8/Z8s66D2fKC4hQPVpaPS+E18QOJ?=
 =?us-ascii?Q?0+ZZg8LNi/YLc7SK8f+5FPZA9wb79KtF3xi9jnkcWIhRmq3rDSvy/5lyEswu?=
 =?us-ascii?Q?pfr/LqyaZMJG8vx4ycg/7Pwopsvl3JkRMP7O16s6zgGSKRj+fAN1AJyQVo/+?=
 =?us-ascii?Q?U1rKRxGLlGgrvSKdbQhe6w+ASqzCqBYa8EZEoEKnAEtcy8n317gMw9ieyEnq?=
 =?us-ascii?Q?6aszxJQvjwV52gUwhrJH47XUFcLJQC1NiElehT5oJgF4/pMfcg2TI4b0Rwnm?=
 =?us-ascii?Q?ttLUeQfj2rEZ+Vvtkdv8nE5geviy5EOUXREdNuZiIQUR+e+OK6EhF1y7x7hK?=
 =?us-ascii?Q?apu2sepAoHql5BssdugJzqxQNnn67ZPznoMbi/1tYH/IwnE06HacGFhXjOI7?=
 =?us-ascii?Q?wVZQ6xyc3amrXjRRD4vcq3EXIeJYXOVog007ke7GQacgzdqdXVlT7s7Qz4ra?=
 =?us-ascii?Q?WMhUmtLd1GlkjF2XSbNtEl3joGeohA1vt6ntPQNlB4nWrbxavWhGoUvlEoC3?=
 =?us-ascii?Q?RgyoIZ0c43XtaDCWPonXMxIV6f98crox9vLu9HrNl9/lu/YPvw7cMwXNXbFT?=
 =?us-ascii?Q?RHSugEYPZg=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272d4cc8-3f8e-43e8-1a7c-08da33d4d696
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 05:04:05.2435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUI8XBwKlndFNq0YNDuMIMrzZL/x1AxNIqY77AkhfPmNr7LXprWfVyMy+eVO0N9apXV/gQ6KK70qqm7bX1wcKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3053
X-OriginatorOrg: intel.com
Cc: Will Deacon <will@kernel.org>
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

> From: Jason Gunthorpe
> Sent: Wednesday, May 11, 2022 12:55 AM
> 
> This control causes the ARM SMMU drivers to choose a stage 2
> implementation for the IO pagetable (vs the stage 1 usual default),
> however this choice has no visible impact to the VFIO user. Further qemu
> never implemented this and no other userspace user is known.
> 
> The original description in commit f5c9ecebaf2a ("vfio/iommu_type1: add
> new VFIO_TYPE1_NESTING_IOMMU IOMMU type") suggested this was to
> "provide
> SMMU translation services to the guest operating system" however the rest
> of the API to set the guest table pointer for the stage 1 was never
> completed, or at least never upstreamed, rendering this part useless dead
> code.
> 
> Since the current patches to enable nested translation, aka userspace page
> tables, rely on iommufd and will not use the enable_nesting()
> iommu_domain_op, remove this infrastructure. However, don't cut too deep
> into the SMMU drivers for now expecting the iommufd work to pick it up -
> we still need to create S2 IO page tables.
> 
> Remove VFIO_TYPE1_NESTING_IOMMU and everything under it including the
> enable_nesting iommu_domain_op.
> 
> Just in-case there is some userspace using this continue to treat
> requesting it as a NOP, but do not advertise support any more.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ----------------
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 16 ----------------
>  drivers/iommu/iommu.c                       | 10 ----------
>  drivers/vfio/vfio_iommu_type1.c             | 12 +-----------
>  include/linux/iommu.h                       |  3 ---
>  include/uapi/linux/vfio.h                   |  2 +-
>  6 files changed, 2 insertions(+), 57 deletions(-)
> 
> It would probably make sense for this to go through the VFIO tree with
> Robin's
> ack for the SMMU changes.
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 627a3ed5ee8fd1..b901e8973bb4ea 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2724,21 +2724,6 @@ static struct iommu_group
> *arm_smmu_device_group(struct device *dev)
>  	return group;
>  }
> 
> -static int arm_smmu_enable_nesting(struct iommu_domain *domain)
> -{
> -	struct arm_smmu_domain *smmu_domain =
> to_smmu_domain(domain);
> -	int ret = 0;
> -
> -	mutex_lock(&smmu_domain->init_mutex);
> -	if (smmu_domain->smmu)
> -		ret = -EPERM;
> -	else
> -		smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
> -	mutex_unlock(&smmu_domain->init_mutex);
> -
> -	return ret;
> -}
> -
>  static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args
> *args)
>  {
>  	return iommu_fwspec_add_ids(dev, args->args, 1);
> @@ -2865,7 +2850,6 @@ static struct iommu_ops arm_smmu_ops = {
>  		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
>  		.iotlb_sync		= arm_smmu_iotlb_sync,
>  		.iova_to_phys		= arm_smmu_iova_to_phys,
> -		.enable_nesting		= arm_smmu_enable_nesting,
>  		.free			= arm_smmu_domain_free,
>  	}
>  };
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 568cce590ccc13..239e6f6585b48d 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1507,21 +1507,6 @@ static struct iommu_group
> *arm_smmu_device_group(struct device *dev)
>  	return group;
>  }
> 
> -static int arm_smmu_enable_nesting(struct iommu_domain *domain)
> -{
> -	struct arm_smmu_domain *smmu_domain =
> to_smmu_domain(domain);
> -	int ret = 0;
> -
> -	mutex_lock(&smmu_domain->init_mutex);
> -	if (smmu_domain->smmu)
> -		ret = -EPERM;
> -	else
> -		smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
> -	mutex_unlock(&smmu_domain->init_mutex);
> -
> -	return ret;
> -}
> -
>  static int arm_smmu_set_pgtable_quirks(struct iommu_domain *domain,
>  		unsigned long quirks)
>  {
> @@ -1600,7 +1585,6 @@ static struct iommu_ops arm_smmu_ops = {
>  		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
>  		.iotlb_sync		= arm_smmu_iotlb_sync,
>  		.iova_to_phys		= arm_smmu_iova_to_phys,
> -		.enable_nesting		= arm_smmu_enable_nesting,
>  		.set_pgtable_quirks	= arm_smmu_set_pgtable_quirks,
>  		.free			= arm_smmu_domain_free,
>  	}
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 857d4c2fd1a206..f33c0d569a5d03 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2561,16 +2561,6 @@ static int __init iommu_init(void)
>  }
>  core_initcall(iommu_init);
> 
> -int iommu_enable_nesting(struct iommu_domain *domain)
> -{
> -	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
> -		return -EINVAL;
> -	if (!domain->ops->enable_nesting)
> -		return -EINVAL;
> -	return domain->ops->enable_nesting(domain);
> -}
> -EXPORT_SYMBOL_GPL(iommu_enable_nesting);
> -
>  int iommu_set_pgtable_quirks(struct iommu_domain *domain,
>  		unsigned long quirk)
>  {
> diff --git a/drivers/vfio/vfio_iommu_type1.c
> b/drivers/vfio/vfio_iommu_type1.c
> index 9394aa9444c10c..ff669723b0488f 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -74,7 +74,6 @@ struct vfio_iommu {
>  	uint64_t		num_non_pinned_groups;
>  	wait_queue_head_t	vaddr_wait;
>  	bool			v2;
> -	bool			nesting;
>  	bool			dirty_page_tracking;
>  	bool			container_open;
>  	struct list_head	emulated_iommu_groups;
> @@ -2207,12 +2206,6 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
>  	if (!domain->domain)
>  		goto out_free_domain;
> 
> -	if (iommu->nesting) {
> -		ret = iommu_enable_nesting(domain->domain);
> -		if (ret)
> -			goto out_domain;
> -	}
> -
>  	ret = iommu_attach_group(domain->domain, group->iommu_group);
>  	if (ret)
>  		goto out_domain;
> @@ -2546,9 +2539,7 @@ static void *vfio_iommu_type1_open(unsigned
> long arg)
>  	switch (arg) {
>  	case VFIO_TYPE1_IOMMU:
>  		break;
> -	case VFIO_TYPE1_NESTING_IOMMU:
> -		iommu->nesting = true;
> -		fallthrough;
> +	case __VFIO_RESERVED_TYPE1_NESTING_IOMMU:
>  	case VFIO_TYPE1v2_IOMMU:
>  		iommu->v2 = true;
>  		break;
> @@ -2634,7 +2625,6 @@ static int
> vfio_iommu_type1_check_extension(struct vfio_iommu *iommu,
>  	switch (arg) {
>  	case VFIO_TYPE1_IOMMU:
>  	case VFIO_TYPE1v2_IOMMU:
> -	case VFIO_TYPE1_NESTING_IOMMU:
>  	case VFIO_UNMAP_ALL:
>  	case VFIO_UPDATE_VADDR:
>  		return 1;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 9208eca4b0d1ac..51cb4d3eb0d391 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -272,7 +272,6 @@ struct iommu_ops {
>   * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty
> flush
>   *            queue
>   * @iova_to_phys: translate iova to physical address
> - * @enable_nesting: Enable nesting
>   * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
>   * @free: Release the domain after use.
>   */
> @@ -300,7 +299,6 @@ struct iommu_domain_ops {
>  	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
>  				    dma_addr_t iova);
> 
> -	int (*enable_nesting)(struct iommu_domain *domain);
>  	int (*set_pgtable_quirks)(struct iommu_domain *domain,
>  				  unsigned long quirks);
> 
> @@ -496,7 +494,6 @@ extern int iommu_page_response(struct device *dev,
>  extern int iommu_group_id(struct iommu_group *group);
>  extern struct iommu_domain *iommu_group_default_domain(struct
> iommu_group *);
> 
> -int iommu_enable_nesting(struct iommu_domain *domain);
>  int iommu_set_pgtable_quirks(struct iommu_domain *domain,
>  		unsigned long quirks);
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index fea86061b44e65..6e0640f0a4cad7 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -35,7 +35,7 @@
>  #define VFIO_EEH			5
> 
>  /* Two-stage IOMMU */
> -#define VFIO_TYPE1_NESTING_IOMMU	6	/* Implies v2 */
> +#define __VFIO_RESERVED_TYPE1_NESTING_IOMMU	6	/* Implies v2
> */
> 
>  #define VFIO_SPAPR_TCE_v2_IOMMU		7
> 
> 
> base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
> --
> 2.36.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
