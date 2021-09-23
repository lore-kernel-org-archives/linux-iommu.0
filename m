Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B84AC433F5
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 03:11:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07A860D42
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 03:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F07A860D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2A1A82ACD;
	Thu, 23 Sep 2021 03:11:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 235-I6uqrNZA; Thu, 23 Sep 2021 03:11:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4FB52817D3;
	Thu, 23 Sep 2021 03:11:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EAD6C000F;
	Thu, 23 Sep 2021 03:11:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37523C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 03:10:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1804E402D6
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 03:10:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sUzOMiTEu8jD for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 03:10:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ADDCE40269
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 03:10:56 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="210831203"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; d="scan'208";a="210831203"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2021 20:10:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; d="scan'208";a="435663078"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga006.jf.intel.com with ESMTP; 22 Sep 2021 20:10:55 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 20:10:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 22 Sep 2021 20:10:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 22 Sep 2021 20:10:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjI0vZUtq1C1Q1xS99SQ32hz/jg3jtTp8TdTjFiq2nxfnj/BIGfmNjr/cOs2/2MJ1Od5C+3NrL3R2IgtmZBhUdCIVqS2yuwM6fFfkEK1q3PrwkTGp2wpJgZsu66I8w6eaYId5mL4yMMohQRQ/TEws9jIb4YMrWW8sjsbj5N7YZbuscr3QY9zxat//kdRdZQScb3yKe/UvAuL6AGwaODITVObSiFISNUIZzXFWrtjzsuVGP1JRVw9HIpCp6mcSJNqxCyo2wZR/sKe+VdE682LBCEgbxlE1ixCd7kpQPmZM07oPMMyhwl5BCe7Fa4FkZi7RnDDC8qVjNXaxEkbLbAobA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=CzUbuPQetpE2XjPkbrqNd4I02ux7zcdpqgDyjmdZNj8=;
 b=ToKDodwo6CuI8QYVJ0sesyOEzW03zoPCkxQy5SgXM7sAk5+GkG/Bgsj1cT9CRb3EEtgrW5V/O9HzCIwr+OyXZwMD7lJcbVyeJemWVYMVEpbDesypdMXou7x25gRrGLhE0VpdStbw4ZnJ7gaoSejzsQlsXiStN0q2mtbeHyYg2lwjsU7GxotMc6TvVnS7njLulEEW2RBHXoEYfUob9pJCm7qIdI/8Ec3UFRhcIjuppIZyqihdP49o0Bp0gg7Qmkfc9ROH480HhAcmBZH+L25v5a6iWa2O8j8Lgzkgc86HZ+V4ZNBUQk4JXxC5ShA3NnIvRRwVY7smciWCJU8wakSclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzUbuPQetpE2XjPkbrqNd4I02ux7zcdpqgDyjmdZNj8=;
 b=ku9SyRYIp7cQJd01L6IUiLP5BeIw2kT5ARciTCJSySonZoGhFllKfXH20nhSlZO0jZ07Wso1J6gX6n/mEulz8qMCp5xNezsdnNCJq8l9c/lKies+Zq88ijUbie6Ivnto29nS2940NoQqDTCZCZl6rIcBoFVszJmkXVoe88vNIzY=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB1617.namprd11.prod.outlook.com (2603:10b6:405:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Thu, 23 Sep
 2021 03:10:47 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 03:10:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Thread-Topic: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Thread-Index: AQHXrSGNbNtRgavabUSKJjvt8l12BauwlhaAgAAouwCAACufAA==
Date: Thu, 23 Sep 2021 03:10:47 +0000
Message-ID: <BN9PR11MB543333AD3C81312115686AAA8CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-11-yi.l.liu@intel.com>
 <20210922152407.1bfa6ff7.alex.williamson@redhat.com>
 <20210922234954.GB964074@nvidia.com>
In-Reply-To: <20210922234954.GB964074@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13d75e3c-e803-423d-dd47-08d97e3fbd72
x-ms-traffictypediagnostic: BN6PR11MB1617:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB16172D42F4F43CB7CCB9520F8CA39@BN6PR11MB1617.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2keU7ObT5Yv7Xkb9h/FtFnFeItmMmXW108xyisT/aDJ6zu8AWJZ0wsys1kwWlcB4022BRQfUk5WAQUDSr2YjjPWVB4wvPpzghZLmrKs6rKngLjngRLWEU79d+qBb6/TZkVtw8rB02QI7+WZo2nudAHDfz62D5jHyoS73JCGKBK3m4arFQhFbZ0sGUl/EGFh7vZjik0NEpZmVIj/64TMCdynsirKZLvqP7CpmKqsKTwuU0FAjRD3Jmt/55bN4/NDirnpT9VYD95WNTrHh2v+O7GdpI/9DqJCx/WRU3yo/+v7xyrAebZtxRyBtyemM9C2nP7z583II/KlgN16yVwktWqbbZmRXUjyMBhxdRxHCic11SgMQP7YCeZnjH7ZRDH+XxUEWFSa+aCpDalsqVqMn/itPDQgxfN6ax8z4S+sKoLgbrDnA0AkQuIyL38maz5+fDo2x2bQCcIj9/OdMMbA73Q8y4bJ39Mjuh7/vtTWg3M6OnHj+578AytT1JO3Hge26uMllMpWrsAT3yHUQlZ++Ox9NcRsdbadfAos72D7CtspmHcyon5ntG4bzEHBfGd+R5JIl34B8rGqYokXxpRPzsMw+zkdGdzbyzaHOdEClR/UgzaxYYbRs8IoaJf2M/62tjU77Y0cG7NaaKjbl9VLAbdBqY3YxTfYLwdeLaz+XpfS82npP1S13RFdfqU9DC2G66Pt2nCA6dtPXqNean/gmBQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016002)(86362001)(8676002)(52536014)(316002)(4326008)(38070700005)(8936002)(76116006)(9686003)(71200400001)(66446008)(7696005)(7416002)(2906002)(33656002)(66476007)(64756008)(66946007)(66556008)(110136005)(26005)(5660300002)(6506007)(54906003)(83380400001)(38100700002)(508600001)(122000001)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t4Y2S2J3xYq/jtYWyj8zzjGxTVx6iVukXWsogkjeebROXAyvexf38Xjcwy12?=
 =?us-ascii?Q?xsnoB7QKMpqupWj0o/BjKpg1MsCVWg8ew5N/1JWtAU2l32PRPJk8VbHOjlI2?=
 =?us-ascii?Q?flpw5UiGU1hu0LReesCmQgMaNSUNx2dVqS5biLWj3whuxwFEkcMgWz6MGZ4K?=
 =?us-ascii?Q?MFbEXgK28cvHvXutLrN5S1JfSG5joUcXbiBU+EsX+/nEzaTmJ/0jW0fg8PdG?=
 =?us-ascii?Q?5gdVXUONc2Lf1ekjil21l5DENc0wVEDjUMdlfQOGlyJpLTAQu3C7GwYFSK+7?=
 =?us-ascii?Q?msj16DFCxAne14kx8men5517xHbu8Z0En2kgHVdHasjxD/VVQSc2Dpeo7jc8?=
 =?us-ascii?Q?YmivX3scIUrAKKjVhlpd7kA+a+xs3S7BScbDrHKVtjV0vzv/xhhOLxH9Knrf?=
 =?us-ascii?Q?U9OE+pIy5/cDujFrLt7X4ocHKevHXUB1Vjfg7g2vpxf8FLM5u1wLMN2KwVZi?=
 =?us-ascii?Q?b/b5jwPY1IFzXY/iG9Kfg2UAUk022Sl8Gmm++oKV+G8pKBW993a+dxvis+0m?=
 =?us-ascii?Q?z9/I1VQj689fb9gUnCD6SNYROiY5YF2VN13iVKz1FAwfrcYFuFck9fDDDQMo?=
 =?us-ascii?Q?dG9TYxokTwUIwWyjIpJcH7Kyt7o+DjPdN8il+uRkCRh9zem8qKNW1rYhxXgm?=
 =?us-ascii?Q?fzcQI8iQwpBjAz6dZZCWjlL3RwatADHrjI4LEyBqmbav1kFKoPwv489RJCh8?=
 =?us-ascii?Q?9Q9pVXNc2MRLN9dzxuqZw2iNAUhP3Dzi2zkJVkkWnrDci98jOgmlEd80Uv+l?=
 =?us-ascii?Q?JQyOCsuLov0DkKrkSs74P+5qR1uwPuGxabNZyQyazJI8fLQJ/LpZ7TIJ4hGM?=
 =?us-ascii?Q?dhntBYlj7UtP54b9GGp1Fq+8eyYqMKkxCLVwwNStVR20Psls3tVjtgRFFZ+t?=
 =?us-ascii?Q?yInvINIUWZ2m6hL270OouHG+dV6dn5HKFk3cEP6ZyEgn/Ft6bkLXQFOIIvfV?=
 =?us-ascii?Q?8641o4LFL0iVJqVUjts7CJDhzDHYHUVb4EVXVvYRgL1/4QDkx8xg4epDue7F?=
 =?us-ascii?Q?vNxP2Qs6OrRA+3WRDVPmPqHrCGmG/ShzgLHyKfIs735MaYfo21372/6zkGtr?=
 =?us-ascii?Q?2fKLauRSlpz/IX4/6VGBfwW/B1JHgoYBB7wvJh3SwvOKQ8OKekcMEORljXox?=
 =?us-ascii?Q?ZHo0j4+5SnOnNk77jkFRT+sf8wSdTdFj1x8nrFPwt9dwRZgFivK4I91Td8Uu?=
 =?us-ascii?Q?SvCDf0YCDXhVyGjbesoYOpRLs0pNVrbrcvfGWsCf+evbwingrLhc3ynjbkw0?=
 =?us-ascii?Q?78jjXusbdPaWyaXYhMKUNytH2gf8UfJ8zTk1BluTCFfN1C9EuoqcRNW1D8nD?=
 =?us-ascii?Q?p489wLsL/P4ij8vRSeWa1KNc?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d75e3c-e803-423d-dd47-08d97e3fbd72
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 03:10:47.3986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +x/j0gqX2g1RNmv5GqM70AcjSHUtLy/etrVfFsUSSHk++3p2hsXCr/9EFXr3EUU7GqO4nqF4uWhc1RTYtD/Xuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1617
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
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
> Sent: Thursday, September 23, 2021 7:50 AM
> 
> On Wed, Sep 22, 2021 at 03:24:07PM -0600, Alex Williamson wrote:
> > On Sun, 19 Sep 2021 14:38:38 +0800
> > Liu Yi L <yi.l.liu@intel.com> wrote:
> >
> > > +struct iommu_device_info {
> > > +	__u32	argsz;
> > > +	__u32	flags;
> > > +#define IOMMU_DEVICE_INFO_ENFORCE_SNOOP	(1 << 0) /* IOMMU
> enforced snoop */
> >
> > Is this too PCI specific, or perhaps too much of the mechanism rather

Isn't snoop vs. !snoop a general concept not pci specific?

> > than the result?  ie. should we just indicate if the IOMMU guarantees
> > coherent DMA?  Thanks,
> 
> I think the name of "coherent DMA" for this feature inside the kernel
> is very, very confusing. We already have something called coherent dma
> and this usage on Intel has nothing at all to do with that.
> 
> In fact it looks like this confusing name has already caused
> implementation problems as I see dma-iommu, is connecting
> dev->dma_coherent to IOMMU_CACHE! eg in dma_info_to_prot(). This is
> completely wrong if IOMMU_CACHE is linked to no_snoop.
> 
> And ARM seems to have fallen out of step with x86 as the ARM IOMMU
> drivers are mapping IOMMU_CACHE to ARM_LPAE_PTE_MEMATTR_OIWB,
> ARM_LPAE_MAIR_ATTR_IDX_CACHE
> 
> The SMMU spec for ARMv8 is pretty clear:
> 
>  13.6.1.1 No_snoop
> 
>  Support for No_snoop is system-dependent and, if implemented, No_snoop
>  transforms a final access attribute of a Normal cacheable type to
>  Normal-iNC-oNC-OSH downstream of (or appearing to be performed
>  downstream of) the SMMU. No_snoop does not transform a final access
>  attribute of any-Device.
> 
> Meaning setting ARM_LPAE_MAIR_ATTR_IDX_CACHE from IOMMU_CACHE
> does NOT
> block non-snoop, in fact it *enables* it - the reverse of what Intel
> is doing!

Checking the code:

        if (data->iop.fmt == ARM_64_LPAE_S2 ||
            data->iop.fmt == ARM_32_LPAE_S2) {
                if (prot & IOMMU_MMIO)
                        pte |= ARM_LPAE_PTE_MEMATTR_DEV;
                else if (prot & IOMMU_CACHE)
                        pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
                else
                        pte |= ARM_LPAE_PTE_MEMATTR_NC;

It does set attribute to WB for IOMMU_CACHE and then NC (Non-cacheable)
for !IOMMU_CACHE. The main difference between Intel and ARM is that Intel
by default allows both snoop and non-snoop traffic with one additional bit
to enforce snoop, while ARM requires explicit SMMU configuration for snoop
and non-snoop respectively.

        } else {
                if (prot & IOMMU_MMIO)
                        pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
                                << ARM_LPAE_PTE_ATTRINDX_SHIFT);
                else if (prot & IOMMU_CACHE)
                        pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
                                << ARM_LPAE_PTE_ATTRINDX_SHIFT);
        }

same for this one. MAIR_ELx register is programmed to ARM_LPAE_MAIR_
ATTR_WBRWA for IDX_CACHE bit. I'm not sure why it doesn't use 
IDX_NC though, when !IOMMU_CACHE.

> 
> So this is all a mess.
> 
> Better to start clear and unambiguous names in the uAPI and someone
> can try to clean up the kernel eventually.
> 
> The required behavior for iommufd is to have the IOMMU ignore the
> no-snoop bit so that Intel HW can disable wbinvd. This bit should be
> clearly documented for its exact purpose and if other arches also have
> instructions that need to be disabled if snoop TLPs are allowed then
> they can re-use this bit. It appears ARM does not have this issue and
> does not need the bit.

Disabling wbinvd is one purpose. imo the more important intention
is that iommu vendor uses different PTE formats between snoop and
!snoop. As long as we want allow userspace to opt in case of isoch 
performance requirement (unlike current vfio which always choose
snoop format if available), such mechanism is required for all vendors.

When creating an ioas there could be three snoop modes:

1) snoop for all attached devices;
2) non-snoop for all attached devices;
3) device-selected snoop;

Intel supports 1) <enforce-snoop on> and 3) <enforce-snoop off>. snoop
and nonsnoop devices can be attached to a same ioas in 3).

ARM supports 1) <snoop format> and 2) <nonsnoop format>. snoop devices
and nonsnoop devices must be attached to different ioas's in 1) and 2)
respectively.

Then the device info should reports:

/* iommu enforced snoop */
+#define IOMMU_DEVICE_INFO_ENFORCE_SNOOP	(1 << 0)
/* iommu enforced nonsnoop */
+#define IOMMU_DEVICE_INFO_ENFORCE_NONSNOOP	(1 << 1)
/* device selected snoop */
+#define IOMMU_DEVICE_INFO_DEVICE_SNOOP	(1 << 2)

> 
> What ARM is doing with IOMMU_CACHE is unclear to me, and I'm unclear
> if/how iommufd should expose it as a controllable PTE flag. The ARM
> 

Based on above analysis I think the ARM usage with IOMMU_CACHE
doesn't change. 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
