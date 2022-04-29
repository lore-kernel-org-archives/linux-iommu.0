Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8210CC433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 08:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1555583FC6;
	Fri, 29 Apr 2022 08:28:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h_2fgNurcEHZ; Fri, 29 Apr 2022 08:28:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ADEB383FA2;
	Fri, 29 Apr 2022 08:28:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7290FC0039;
	Fri, 29 Apr 2022 08:28:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE6B5C002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:28:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9184360C0E
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:28:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wM1yUqvGC1S5 for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 08:28:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F29D60AB2
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 08:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651220903; x=1682756903;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=krn5JuG2bgPuGygkdBBKSNqjhR3ZAxPy6LrFsVQIOyY=;
 b=mKDxlXn7xyHOFbta//onJFOUYOdhTWC1bzjeQ0xFXoUahPposFKyxmF8
 TpZSQFdTusb/GiI4jSwXLuCjiXlTrLGZVp0UIxRwy3JoVc/DyGuKBI4R0
 gC/fCzp34cVFA8R3644L6N80fZY6t6FB5lxAeFEc6d9zzQbeGYKkNgUja
 au2LVKXYevdQ2iN6vsvBLAnXbYfsCLkMN3u34LTQV+JMOKk8V6pBVdDZD
 2swEykRojwlynSSTdw6xmrgu7wK1yq8jnuUOSDFY+OqLbs1vLLnyD6BLU
 JDdo3q2OKPCCS6fQGBa+Li8lvbNHwien95lvSchoD84zmY8qvapDYlAYu w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="247133378"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; d="scan'208";a="247133378"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 01:28:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; d="scan'208";a="560202512"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by orsmga007.jf.intel.com with ESMTP; 29 Apr 2022 01:28:21 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 29 Apr 2022 01:28:21 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 29 Apr 2022 01:28:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 29 Apr 2022 01:28:20 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 29 Apr 2022 01:28:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvbbsqB8wvZRZCCUJKISkJu54XwE6Q0IBNeWWlK+eV3/EJuylfiW8ydOqdQG7cQ2kOPyJfTWISWQQqrZZQGnxImMn7AIF9w6YcltsLgUl3akCtLWH12F2+dZIsNbEhnWAet3TWxtIDKMbOfTGtOXPXzuu2dmDc15juoxFzyanrIVBNZ9H7yoFhkz19iVepIB3Sm2fDUexk1d2oF96004VQBcizFteKQrRvXIbzXxhko3kFpi0FXXiwwXiPhOqLT9Km+ymAQx1SVHPy0HIUBDLW2PZqMdLASbyN4rJJL2AJMfbLkXSY1U7Cjeuswmlz8dRkXyl5dsvlBeWgN0t7VAIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krn5JuG2bgPuGygkdBBKSNqjhR3ZAxPy6LrFsVQIOyY=;
 b=l1n4c1yMlyB/7r4ClEwXcj5pU1ZyyMtL6jR9BnKGSv1O0DvEcW7Osjvrki3yd6pnWZpqxOEi1JEPqbSlguC3wPthMhEkzkO+oHfAqNwu/N4+VrWIGZ+szIn6gLyIjcfuQSih24tsta1j5rlezdF8T/LOnF+gJXXlw5YB4WVtekPyWGqmXXAfhUdPlMZc0D1YAqEKpCyeQnaPffO3XZ/TkPI6GGRQPfCkKcUwWBTYVPovnqLqxf6ZbQv2nn7tVlac6o/ubziAFNhxybQYQ/3egIza4CIR1uGC/Tjn1oqVTRO5a7y3tBviBwEE9Chl85kkPgcevh7Hgkh8wmOxVjdpUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4663.namprd11.prod.outlook.com (2603:10b6:208:26f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 08:28:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 08:28:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH RFC 15/19] iommu/arm-smmu-v3: Add
 set_dirty_tracking_range() support
Thread-Topic: [PATCH RFC 15/19] iommu/arm-smmu-v3: Add
 set_dirty_tracking_range() support
Thread-Index: AQHYW0SWhZnvJgES3Eazl10cRzBZjq0Gjfyw
Date: Fri, 29 Apr 2022 08:28:17 +0000
Message-ID: <BN9PR11MB5276AEDA199F2BC7F13035B98CFC9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-16-joao.m.martins@oracle.com>
In-Reply-To: <20220428210933.3583-16-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb4020bf-d93e-43a2-2a19-08da29ba35f2
x-ms-traffictypediagnostic: MN2PR11MB4663:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB4663593821129D08F39515178CFC9@MN2PR11MB4663.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AfX0+xRJ7A5DTg5DfoxNPtCOWuh7kYHedYdedM3rIP0JBzbPM2L3RxTRDSqnIHeGxoO52cv211qDElYshgwPTjriFB+98ODD2NPY0TOEAAgHE6xf36bLRwnUm3RHWIjUGkqfelonCjLcDyuUbPJXzkvxWd+z9FT5JKX/M+9aiGWeZKtVPQkMfxZMdzWW395lWeoqiaKctqwvuATuySyuNKRpw3uZU0Sj5w04OWGOv0+/zNmiwN8fopJYXiNCzPTj2gjupEcc2Ub0zmEyuKNnO5Dqu4rUbSnmik//774Qa7Sj3L8oSymx/tX64T9uK/hUnLGp5cIhN1CVVdCFSzoCgdGlKc6Ey3Vlptbp4r4fOyyVT7vIGMNM8UsXchyO/E5J4uxCvnBHmPRGvLYpUbKh3yOJEnJg4eVVbtRW2XLOYpZAAVju7lKjkzlAB7mfELtAwTdbKw8/L5dSzN9OlSThB8OTsCPt55zFqPn21U4UsdqIvqQhtUdICQ4MegTf75HxAzuGXIAYBnaF1qlk3G6sPFV4n1wwzddHwlNKi13aRghyMma8it9U3bLK4tL6eTSJPy9YGwhkACaHl2RCZk46sm+eIEHtlfVChoMmzbK7VnjeM4SMenzfmsnQVq8m92mzd/UBUb51Bm4b639G6tsB7mYN3jyVL2WC469K8O2BgdnzaLQBrGrrptvKe7xFHKjuZTWujOCIABXKThCOUtOIo7sqEPRiVosUC7I7yLov2yo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(71200400001)(316002)(4744005)(33656002)(110136005)(7416002)(54906003)(83380400001)(55016003)(186003)(82960400001)(52536014)(38070700005)(38100700002)(2906002)(508600001)(8676002)(26005)(4326008)(86362001)(8936002)(64756008)(66946007)(76116006)(6506007)(9686003)(7696005)(66476007)(66446008)(66556008)(122000001)(5660300002)(14143004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P9jnmz7+U7QNj02nWHG1qrxGqq1YmHu6wXqgV1NdhyxzgvIuq92D0WBYI6w6?=
 =?us-ascii?Q?BexDwQPKF3akBkz1Pp1MJ8fCLIKCg38AmGyISne7fknAUiQEX7q1bv1IgNSh?=
 =?us-ascii?Q?Sg5eO4Rn17xTVAs7dLB4vsozH7DFd0n/tfqdiCP4epBeOEvgFSb6ou3yy1bh?=
 =?us-ascii?Q?jCFK8cJbuXZntARpEueHJvsDsJ2uizV3/b+BY2RWUUj7LlWfpcsK+OmhiV3q?=
 =?us-ascii?Q?VPnHVszE1LJnSLvMD97lmO+1ENTyJ52D7Tj+q4xSrnaJSN0FE/2V5SnyPGrU?=
 =?us-ascii?Q?VC7t5QbV/wfq33UXQrVOJ+48NHiDNAdFqyOgOitvc49hT4UPnCdmYhdoWchW?=
 =?us-ascii?Q?JoJC2fIhJjtYxQe2wh5f+zyNf+b1IOJ6iYzYWSiIwZCPTQ/7Cz/XXQpEUV1p?=
 =?us-ascii?Q?Ydwi8nUkfsaJrvl05z86tR1qawc2oGlV6dBFGtOVeYYLXymIUJuHH2iy7YRt?=
 =?us-ascii?Q?94Q4BJi2BGgqGhm9sZE34lTMZDPeInoIZN113iQ6xIWzK98gVL/IL+Tfaqt4?=
 =?us-ascii?Q?To5G/+bNr7XH0RtM5HDPwQSkwlpfQ44dQFMbELnmjqZsGEmL+kqX5MQHvmFE?=
 =?us-ascii?Q?Y0OE8GxUeA0CazBxJh2bo+tVwKXWMbzjKNTWb3vMecvTMyzRVBoYrtIJxSMJ?=
 =?us-ascii?Q?4hSBFy9+zi3yquEMgWEn9Mv0Gfwd7l4WSGLo8scYx+bTYi7jhyxZIORJGHsG?=
 =?us-ascii?Q?kZLV5UWo6arrGp3KsaHmW+tehUi/QYdPaBKB3h4pVdeYuXwZsd47K5uh7zi1?=
 =?us-ascii?Q?VfmnexXFSWuBi1g9NtrTtK+M60CwV7qtEpyCrPGd0Yi3GGOesAwoJ9Pot4h0?=
 =?us-ascii?Q?umGCG/B425hrT26AfZVm+nEbFAiAaIc50P9Yne2c3B9RC8tm1urP9BcCO1xz?=
 =?us-ascii?Q?zTpA8lXiedr1Zo+mz73mHmmGCl8T6aAspJ95wAaRuz9OkNjycUNfQ+HpVBXs?=
 =?us-ascii?Q?1KFbXG15xqSTrSxtYEjzhZJ9kJyMx7sxjFzcSGUXX1LklHQTXH3FeeJHt2Uv?=
 =?us-ascii?Q?W6ifXdriXgP/NojyffvhXmlHdcwxpl+deF2/tB02XsEXw7bbRx41wR2+eZ0b?=
 =?us-ascii?Q?IPMMgZcIzL7Mp8VWaqGtTiRot1SeD3ac7n7Zt2X2a71iKYeYp62d58140SJY?=
 =?us-ascii?Q?fs2viAxt5BZxe3FHyg7MfPVrg62FISK6QWPQq5ed7iU0iBv8+rYsvLcCoOIn?=
 =?us-ascii?Q?jhbu+OBKQLMGmwj1C0orEAjKhWJIukIW+q357t694qi/uxZcOQZVjMwGSufp?=
 =?us-ascii?Q?xfz+oKsDn0pcCjtllz6DxObrAtdl95al6uhPDRlUyYZMFaeSQBjo0d40uyjJ?=
 =?us-ascii?Q?3C+cgxJjhz+cPS7qyYC8wZ7CeKHqLngSVQf+2n9599S6Ehby0cUDu5NYrlrm?=
 =?us-ascii?Q?dAL0D5tQ3tKjqk2SxByDIjCQIOAty6yqoRn3ebHjlFTfJ1LtAd4BAp9yzRv0?=
 =?us-ascii?Q?gVqGqAUdXqBNsF7nmmLW4uFAyVBd6gWGmXCfs2lhT87O3xs2NLTabKyG1o6D?=
 =?us-ascii?Q?nc+vPW0T5K1+BiIGfawTVyqhwEpu8p9WrMCt726vvbgtqOLh5m9gqzcuB88u?=
 =?us-ascii?Q?1u9QihivY5Mg6wSMakmfLNvE6pY16LwzlVmYuMDmydo5+Heqv92SPsLgQ4AX?=
 =?us-ascii?Q?iLdx/HllUVGscX8S2yRBzw/uuoxCiZ3HTA27t34M0CZuc9pMfP6vlN09wUp6?=
 =?us-ascii?Q?B1xdcg2JT8WXSGjAAlitGVokUp9Stc4gPkcyLAzUbtg4H3N6GNwGEp8JxTXv?=
 =?us-ascii?Q?hgTRotu2jA=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4020bf-d93e-43a2-2a19-08da29ba35f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 08:28:17.1440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tAt5gqXnlI0dqZ6UuynrD5037ZiEOojcdHWNjUTo+2FZBcNz8UmsveN4WbFV1Dny4T/lRt++ZWN/MFlRhdfxgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4663
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Cornelia
 Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>
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

> From: Joao Martins <joao.m.martins@oracle.com>
> Sent: Friday, April 29, 2022 5:09 AM
> 
> Similar to .read_and_clear_dirty() use the page table
> walker helper functions and set DBM|RDONLY bit, thus
> switching the IOPTE to writeable-clean.

this should not be one-off if the operation needs to be
applied to IOPTE. Say a map request comes right after
set_dirty_tracking() is called. If it's agreed to remove
the range op then smmu driver should record the tracking
status internally and then apply the modifier to all the new
mappings automatically before dirty tracking is disabled.
Otherwise the same logic needs to be kept in iommufd to
call set_dirty_tracking_range() explicitly for every new
iopt_area created within the tracking window.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
