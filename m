Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DD9C433B4
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 04:39:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A8761057
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 04:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A8761057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5B54940292;
	Thu,  1 Apr 2021 04:39:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00MHtP1mtTJG; Thu,  1 Apr 2021 04:39:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 36581400E0;
	Thu,  1 Apr 2021 04:39:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C3F7C000D;
	Thu,  1 Apr 2021 04:39:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EC87C000B
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 04:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4CDF28490D
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 04:38:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ifi2EMpZGRew for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 04:38:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6751A8480D
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 04:38:57 +0000 (UTC)
IronPort-SDR: 2COWcrynziaQOY5obK6166TsAqo9532r7gLQ6yMJ/3/WRwvXnRAegYN9lTVQYvmqaVzT3ZiyiD
 MLmJ4ONpdtoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="172182408"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; d="scan'208";a="172182408"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2021 21:38:56 -0700
IronPort-SDR: Y+IGxmc4FguCGL96VWhe93DTaEAlZGRJ/MRsIjvE7C6hdSsvHKxtF0A9b9HQBpmEGlozFl10Ag
 1dGUjzV8rTXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; d="scan'208";a="455806551"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by orsmga001.jf.intel.com with ESMTP; 31 Mar 2021 21:38:55 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 31 Mar 2021 21:38:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 31 Mar 2021 21:38:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 31 Mar 2021 21:38:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 31 Mar 2021 21:38:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcHiDmz0a7UQAhRLIMEH8/mLHt3eGrRvSNyA9/1jL6L6V609puhVN0RZfJ5LicUgwMyWQQjD8zRea1YU6w6eKtmXSfqAuSSsavmHnX9N1UfPc5neLZZFMGfJPkQAbAqSMyLbhuTyxRY3FX4XndL8b/VWUiv9+jjyp33ksY0xZgi3tbT06L72gKkajSoKc88Ph+TQWgLv06daoAEM02CJ1dtwARnoKxlN0pJykL5Cbtkx+Jx0hWlxg+pAmP7CClpvBD2bz14UhU4yDYex2k+VfZcd+1OeVzMVTsCq9QOUZHgVlNdED40MsV3CZXd2fZAOiTqvU9SVjsLSWX9uCGJiuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXSOJViBbZ6SuHEVQVEIFjoANg7WaIZHScfU6nPwqcw=;
 b=IEW92ARm7nP8U2EbJqAeeGEwf5XgCXkzyroQV+Jd29khgMlQuayIjzxyuR9eroRnqlDDISEfpAyFj46cjMCLrMkTuOW9/yeWNm9sOAjFtZg8EIngpS3pi64DbGxgc4I8rfjfMdo1DQMm8Nx6n3TGRSzyV/sPHaTHSkIiSP4N2+OKtbnStWwlnNRWnjTyRfWAcTpIbwQeWgKlGyzfucXnvgCxJULBTfHT8JRUUvD7q29IZZEdYT28DDThoRyXVPQ10LYa/1l4/bdds+4JrjML353QdJnGj5tBUScrmoCdpPkeI8d3P52VogpzI3UC7lIHWl2RuFyXZZK0zWYngSlqGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXSOJViBbZ6SuHEVQVEIFjoANg7WaIZHScfU6nPwqcw=;
 b=J8yjvtnnqRimNIHzZPeBaOTZFyaQMhrl4aQaVJtnw2WpHTS8cGtmwAZpuKOPvA4J6eikQ68lCeRQVc4wNIF0ddHeM0RulvSYfmcceNwLq3Lfu59qRqlrYiVHmRbCd9FaijIMNE8Y71OoCeqO8g3dM9Gc8GtPdDAJp8fdmfxYp74=
Received: from BN6PR11MB4068.namprd11.prod.outlook.com (2603:10b6:405:7c::31)
 by BN6PR11MB1265.namprd11.prod.outlook.com (2603:10b6:404:48::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 04:38:44 +0000
Received: from BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d]) by BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 04:38:44 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZuc1/oaTFwUU0WheDxUmLBHiqqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAmFuAgADGxQCAAR7PEIAAZiYAgAECgOA=
Date: Thu, 1 Apr 2021 04:38:44 +0000
Message-ID: <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
References: <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com> <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com> <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
In-Reply-To: <20210331124038.GE1463678@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94b98ee3-e671-45bd-5896-08d8f4c8083e
x-ms-traffictypediagnostic: BN6PR11MB1265:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB126577E59EB3FA3BEEBF4BBCC37B9@BN6PR11MB1265.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ljCPlGSnJRdn3cVDOLC1heirXannNmEQMolmbQ6wPtyKvkSGtY2hq9IN1to1CGI5IOA6M23Gc+fwVebYnfwIa0cY0i9M1I3NvBhHZFaZKO49/BGSAJJ7+z3iZQ8mKEUnhA2vEf7XAqTyO2KMW7tBrMAv8f8BakWpfGFSo1/IdTGYdnGVeX/rN+ITye4Da0+yus8drPp+lb51pDh9coJXOOE+pCSZZnpaAVuQ80S7Ti2AkfQmr9Dry01dPLzUuJTxEtBzPqdk0RTz4BJTUsYJPZ7de+TMPufTi4TU5jgxb67w7F0irrhcwAEp/q61HpVbBZlnqHjH0Nc2utrNFOekC9iVfmF2bm/OICCC5vCYkbCC9FL86Xgg0aLXUTaIFDCmdDQzTCLews9d+4L4dsi6YkQM0YDCzYEZ1wBi9V6cAMESEwa6+Ogf2Z1m8Rqqi9U9tcid8GqGkCxFBhyi+J12ysFfb48wIPSjGuCWUV/YHOxEk33Pdcw4MlT3wXhHvhbvnOIZ4VxHfDuvX4E5r78lhbLakoDndvrIZSbp/Y5OzZglpjgCron+Kb/C5v1IQBxEt9KdguBQFOA4FAtgqgMFiOPKt76wNu1mHGlUpHw8CA1bRU3IXbSF8ZJeIPMNGaqCUuxGKm0yjza0gulxXd/ca8IWD+fG87+l+7lzax7O1Ac=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR11MB4068.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(366004)(376002)(136003)(346002)(396003)(54906003)(66446008)(7696005)(76116006)(6916009)(52536014)(64756008)(2906002)(478600001)(7416002)(6506007)(9686003)(26005)(5660300002)(38100700001)(55016002)(66946007)(8936002)(66556008)(316002)(33656002)(71200400001)(186003)(66476007)(86362001)(4326008)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uqmJC007WMrQqhTkoXPbRC6QWIUbGVoq/Q44NNaNDtZKEAIQifyuzXlcJGkV?=
 =?us-ascii?Q?67l6NISur/s8RKK1uLQSUjngpL0f7I4VJ5RWqKTiNeKTM+UJ3w7miShBPlc+?=
 =?us-ascii?Q?88uL5rU8UlbAXfDlsV5OA/fRRpVxp6CRZC6C/3x6g7BwnO43uhOkcjZOrGxE?=
 =?us-ascii?Q?XN20K/a+y7tZNfEPdNAaQMyBcma6n99j2ZpFkuJf75mTHx5qd7wHm3kP/gYK?=
 =?us-ascii?Q?NDqaBdRoLF2c2RhrAHmAklfaDS+Ost/xnC31mmUTMO4kaa1ls7UYPPRrBdbg?=
 =?us-ascii?Q?ummUjf0PX/FWOJGqv6w4EQOe1ptG+HB3aoinMb6hCcne0XZbYuFvsEqCea8Y?=
 =?us-ascii?Q?UZmRtlFFsj+gU+vHOJzoaYw/d0aMIV0/uhANLVqgbj2mlvde6Fi8Xozqc7M0?=
 =?us-ascii?Q?gUF63JKOnXSCzrAgkFEdnl3Cn3+t4O0xiQo2vkFsSuPsTzBvSwEXB93SwJ2D?=
 =?us-ascii?Q?F8/uloSFY8hKJE1oZFUSczla34a9Zv1ssXkBGhgKiXoKvIsMVdxZYnerqoXN?=
 =?us-ascii?Q?bC/LQLZZsh2yiOHl+qex751LdjsnKN1+Tt45AFxgvrRtkVfyFN6CcevbvLd2?=
 =?us-ascii?Q?ZzFw9G6HDFOxkyxyr6urDVOm8z2DWm8YLiN+NeefU64HpByXnh9M0jDfvzDg?=
 =?us-ascii?Q?O68eBcTwwaLJcOoL+lxBQiXfpZ4u5SmhMU/bu1TF/lmG9RrMSqh7gz0qdK4N?=
 =?us-ascii?Q?m64GBYcCWQ45IfQeLOG5FuT/C/iYzkZozPK4nTM/nmHgcAnsPA/h3k/0emd8?=
 =?us-ascii?Q?LHtcG2FlSSEB4ZcWUnWzUM4n5VqqCUPquZ/ZuttBzwsaWgIwX3XIjW7CeCnJ?=
 =?us-ascii?Q?xZBQcsmhUBoqKBh2iQ/l+/30+5C1lDCrTATR9FjiiyU1gX+NDYuXnCpxxTwO?=
 =?us-ascii?Q?Y+mvPOtexVGzNQEqmfhP4MYXfW7tiwEmQr8hx0h0kicA04j8eTr93u2B6Vo4?=
 =?us-ascii?Q?Vn9bM2Y10F/jFp+d/BsdRPyH2l4ccvYLP7oZE8J+9NCLAq+6ikeCdZoBZxd2?=
 =?us-ascii?Q?2PkgnzA72Qu7/IX+GiVbokmd8WoAkPLc4r2zTTJMxiwhryGE0+PJooeSVNK9?=
 =?us-ascii?Q?Q0RocB/rpCJKHrSVLYa9NUZJ/Lkm2Ti7mZoazcti0JddMtJGb4WHoQKLqqEO?=
 =?us-ascii?Q?EAJhBeL26GudMh6lNTerPgBHt04j/hc+mXkZrQU+JtmFlPcG4o/hVJOOADof?=
 =?us-ascii?Q?EIh6hHka4wB8TCYCpbW7udpxJi9Iho3215vwLQymomHFmU0K8WNBueNSwg9x?=
 =?us-ascii?Q?QwlV3m+nsslsY9v4N9Jwh+rCrUvjYE00EMS3G8CInmzz67IZ2Irp1fNLKQOO?=
 =?us-ascii?Q?n39rCr6JpM121rjsGORNjJQg?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4068.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b98ee3-e671-45bd-5896-08d8f4c8083e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 04:38:44.0865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2i0Q9A0EjC6nW6y8sCuTn9eAr9XTUBlt6deS3WXp1yaihsLa3kjHInVg139c3jLnJKcece3HAfPreAfwM/FgHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1265
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jonathan
 Corbet <corbet@lwn.net>, Jean-Philippe
 Brucker <jean-philippe@linaro.com>, LKML <linux-kernel@vger.kernel.org>, "Jiang,
 Dave" <dave.jiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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
> Sent: Wednesday, March 31, 2021 8:41 PM
> 
> On Wed, Mar 31, 2021 at 07:38:36AM +0000, Liu, Yi L wrote:
> 
> > The reason is /dev/ioasid FD is per-VM since the ioasid allocated to
> > the VM should be able to be shared by all assigned device for the VM.
> > But the SVA operations (bind/unbind page table, cache_invalidate) should
> > be per-device.
> 
> It is not *per-device* it is *per-ioasid*
>
> And as /dev/ioasid is an interface for controlling multiple ioasid's
> there is no issue to also multiplex the page table manipulation for
> multiple ioasids as well.
> 
> What you should do next is sketch out in some RFC the exactl ioctls
> each FD would have and show how the parts I outlined would work and
> point out any remaining gaps.
> 
> The device FD is something like the vfio_device FD from VFIO, it has
> *nothing* to do with PASID beyond having a single ioctl to authorize
> the device to use the PASID. All control of the PASID is in
> /dev/ioasid.

good to see this reply. Your idea is much clearer to me now. If I'm getting
you correctly. I think the skeleton is something like below:

1) userspace opens a /dev/ioasid, meanwhile there will be an ioasid
   allocated and a per-ioasid context which can be used to do bind page
   table and cache invalidate, an ioasid FD returned to userspace.
2) userspace passes the ioasid FD to VFIO, let it associated with a device
   FD (like vfio_device FD).
3) userspace binds page table on the ioasid FD with the page table info.
4) userspace unbinds the page table on the ioasid FD
5) userspace de-associates the ioasid FD and device FD

Does above suit your outline?

If yes, I still have below concern and wish to see your opinion.
- the ioasid FD and device association will happen at runtime instead of
  just happen in the setup phase.
- how about AMD and ARM's vSVA support? Their PASID allocation and page table
  happens within guest. They only need to bind the guest PASID table to host.
  Above model seems unable to fit them. (Jean, Eric, Jacob please feel free
  to correct me)
- this per-ioasid SVA operations is not aligned with the native SVA usage
  model. Native SVA bind is per-device.

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
