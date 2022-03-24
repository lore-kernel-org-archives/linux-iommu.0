Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BD6C433F5
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 03:09:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B88E081D16;
	Thu, 24 Mar 2022 03:09:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Os7X0pFu0eVO; Thu, 24 Mar 2022 03:09:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 966AC81BF4;
	Thu, 24 Mar 2022 03:09:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7148FC001A;
	Thu, 24 Mar 2022 03:09:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76269C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 03:09:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73AF1416AC
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 03:09:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6rurmY2qDNIr for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 03:09:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D6C740422
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 03:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648091392; x=1679627392;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZAt7kzNiY0ajueHais0qgnY/GUNFEemHTJOugqHIMXs=;
 b=PMik9eFtWrIqm513Y/5hgBw8IhO7TQgAOj2ken8O22/yJs4cATXIAHgJ
 VcZ2tr0kVSkCr3vkMCMJ4vrpnON/gdbNrLyeg6Qdt6dG1la+zxSv3Gji4
 EA+LU4sD+cbiqW3pnVq4Wjzs2slDbvjnzkrEK5ZiUCKS5OQHP0DDWHDW+
 T0/GJxAhu4IGdr6kear6e8/J8gyP7HElRe+XgCn5qhw8bLZwPrKXdJjoV
 mqpmkvKXiwNn1/vAVmvyF5hsDhGZKBltOYd0CsC+yaBMjSGkZCrb9jZWE
 kTAr3wKY+sYFwRTrUQwgXSBMsSE430jlxQoIe1qtJjzo2IAXxvfJZ9at7 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="255841077"
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; d="scan'208";a="255841077"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2022 20:09:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; d="scan'208";a="552717890"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga007.fm.intel.com with ESMTP; 23 Mar 2022 20:09:50 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 23 Mar 2022 20:09:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 23 Mar 2022 20:09:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 23 Mar 2022 20:09:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIAoJHyxhnCu81J2fDMinelzfF8MKgcRJ488DktDznBcYh1iHd9GJuOS8NM/XCrLDSFni9Ds/e1Zi8R5C5IlQg345CxgG5dtaCcZ8R3YsKS2MVA6GLOV/jHpBLSq4IiZzWwJptHmoz5ufflaVBIe/hx88i9lwXAoTuPmH/L5+nLlwqn/mZ4kUtw95vidSjOqYLz3w4yQLCJkgaaEFVzkjiu/SchNjsTFKi+4eaIQH+IHuCuq/6668GfCWtwTaTKW8Ip2GmbYp+3k7aByCi7AKAnsYJka8ImAcwBg+zif436BdpyMavr5nSBjV2L9BL1ynqQBcZKjRSz9JqQoIAoBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EikI/LFcqPiMs+pMJy6FxRHZq7JNxNZXoZKQ5lfupsQ=;
 b=KtZnqgvxQRePHbdTak4oqEYPIcCZ1w8ANQtUP2YZzsxQ/Z1s+wX06wDft5l080Y8Qz7jR9qbGpe2Bzi0ZHZYDcV7IxnoQEdFXSGWKdy0S56XtDvMyKegZ8gavVnQRau4mcSRrbkb6OtXPqF9yds4hraUIXjQMZsUL6s20Mntj9H9IKx3KyL57vLoIWM+KYVL0uTqt7ZP6jTTb91KT/8jGIqSru0pjgVrUMAW5TkdRZTDClzUv/S8SqwDJtYZz4h8yv52y2vpkgrvjXTx6/Z3IjhI//twepvsiUjw37GRB9fXbmX/AyBekdhfg8Nuir7x0N1ycV1R1pM7hv5g5tm7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5691.namprd11.prod.outlook.com (2603:10b6:610:110::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 03:09:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5102.018; Thu, 24 Mar 2022
 03:09:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH RFC 07/12] iommufd: Data structure to provide IOVA to PFN
 mapping
Thread-Topic: [PATCH RFC 07/12] iommufd: Data structure to provide IOVA to PFN
 mapping
Thread-Index: AQHYOu2DzqqoQpHhKEmsdDOP14CZV6zL/uQAgAFPOACAAJMrgA==
Date: Thu, 24 Mar 2022 03:09:46 +0000
Message-ID: <BN9PR11MB5276D51A07EF91D19A78C6B08C199@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <7-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <20220322161544.54fd459d.alex.williamson@redhat.com>
 <20220323181532.GA1184709@nvidia.com>
In-Reply-To: <20220323181532.GA1184709@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5da286a6-3150-4a9b-aa93-08da0d43c08a
x-ms-traffictypediagnostic: CH0PR11MB5691:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH0PR11MB5691F83D85985CA7DFD0C7B58C199@CH0PR11MB5691.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6DbmKPwtsStFiE+zkJPaLdFhmzLClYOXwx3GZPczQCaAoWhnR+42bk/XspDjdlx/So94D0WedQAn41EID09NzvWDFZBC6gb0SaEUsXGcmgTy016pUJ3k7nggD7uqRFUMs06Ukbnnsz7B7K2XM38puyg8gg4m4OhgsjhrY6zUOXRyAES84a6QWDuxUr/mIBbmSNFpZ4y3Zgs+bDsNSk/XXCQxTMtO0pxLry4cSpIN0tJFQciNyTKRHObkwQjYaE+7pAE0HTjxILQwPNkHgKgMORrK1hGWe6M1epiQcnrjFInTRv70wIhFUak+xGnX1oOgtvQee0p2DJ/JjK8ukfRs4URvNddT02JgJJMmRVTqM19alMe0KEZRICEYAdTK7E3nHpTmOawdmdk6X6v1znQj2Ef8TzmqKLfOdvc4AGo4SJBV3XFyWH/c+MBqeGRGjodtRW104PoZL4MeyCJ1WeDcbGzRf2nooZh3J09SzukdNex679IG8WITctfequZVMUx41Ye98GGgfm3vpBSHKHe7UxZoo2zxgswUjDol+l8dSYh3eJFugDZgM4dvDKsFbCxO4YJ/KdzsqJiRkNss1I+z/NfnqyvhclIRSJGnNYz6GmVNoHXuArnOGrUKR4oGE9WeDlWtUke+bXi4q/rfOI7RCunGghniaOMllM4kmUhAG8pnDHjW62afkuSj6yLFqa7ekkkKy+hzXOs7QpCQi0iGLg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(33656002)(8936002)(508600001)(38070700005)(7416002)(83380400001)(122000001)(76116006)(71200400001)(66946007)(26005)(66476007)(8676002)(52536014)(66556008)(4326008)(64756008)(186003)(66446008)(110136005)(316002)(7696005)(5660300002)(9686003)(54906003)(6506007)(55016003)(38100700002)(2906002)(82960400001)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qrJdqkL6jfrr4wySD8rT7XyseUvF04yx1xA8JSVUexRmGpioZM5+fQZMyIWo?=
 =?us-ascii?Q?6VoOmfsqNfaUJwt2o3wxMkMfVDmTJWn/vReLHUUKWMecsBwKplym+oYVFEwQ?=
 =?us-ascii?Q?a8ctHTapapCoTk1fRt2k0qQIN27l4pDhzsujndZZOxf2G5oCmfaX6MfeWCcA?=
 =?us-ascii?Q?MetBb6EiMi8avjDF1VzELnYaF5+C7iAlwBkJISZWd9BmeB7UwatmJSTw/mGV?=
 =?us-ascii?Q?wm3N9QelPXB1+JGzR/fhV86tGkI5qCS1pExdT6N0LFE8Aj8T5e7Y2nstmAs5?=
 =?us-ascii?Q?DyOGcfCJAJRLy8npRVQsRMv4bAPPBM04p50Cd8F0J+xhqXEqx7R9F5L1B7Hp?=
 =?us-ascii?Q?asDZJhPSKn7V1iKJGDB9vFJcbGP0Zxcrj8f5HiSa8cnoShmFnKDBJy4EgCq1?=
 =?us-ascii?Q?iYo5vH1Zb6e8ARvGOI4Ce/Lt2ueRpnkFN+kJg7HJeDAiyeWdtt05l0+zOV9e?=
 =?us-ascii?Q?k7AyTwQxpETVM5OqbYjGLSpodO5r7pY2DyXVRIMtqxy8+HkGQqYfyPp0q5j2?=
 =?us-ascii?Q?17hbGRRDnL7r6shQeVyJioJWdKHmywzM322XIOKTh5QfCI/v0UwzacYWf+kR?=
 =?us-ascii?Q?HM4bB0qDbR/MCop8deFVSKUHuZhyKfxpzd2stgmbAXeX9suDR28Z1uSZHVzx?=
 =?us-ascii?Q?VgOBs+LI+SFqEwY+zRlHWEA9qL/5BTrGA7PXvw4UATNiFeh57qJhrJ4p7fdB?=
 =?us-ascii?Q?x3NLWj/83Mw+16Yr/y8iWKlx4Z9m7klNa/fkoVtVQo9yBhPDH0/MeD9A34Zc?=
 =?us-ascii?Q?WDDK2hgMFoXKVA6P4liMR8rvoDU6W4bwg/+/naLJORzwGGDm5/A1iLCEplYy?=
 =?us-ascii?Q?rP9iZFgsr0Vnn8DkGAk50oMpq5D84U35eMs2JNnJX2jhv+wS4txlGEHS56uG?=
 =?us-ascii?Q?KUlBrfGnk2y2tDWpNkhFpnY5JWOHHrX8KVGBu/eEdovKG9FOYrt1bFTPLjsb?=
 =?us-ascii?Q?jVqn65sOfSQe6OCbU6NNnH/XeYjm/nFaAwUTMmt7Js9+26g61T25Q9CJrB+I?=
 =?us-ascii?Q?cW45lcbGaz+Gajx0FO3Dgj+ovUBTayH0Jermv9ggE8nShI0NgvTgKmshNQL8?=
 =?us-ascii?Q?9G2fAd6/Z5HdXJRNrtnO/QmnxvYiPhGKprB6L3rL1hiYkdZio+XZHztsi3Nm?=
 =?us-ascii?Q?qMOH8D0er0U6rkDQUn27J2dav21g0DfD0flgrnPSwQpyHTBzuKPs3XwEx0Tc?=
 =?us-ascii?Q?rSTZT+6KYc1gUQNGXjp9XGxz1wqus7JXL+JFf1YeBudxh3lM4/+ZKukxRbMu?=
 =?us-ascii?Q?KiSHXcSfvOcklsle+G+ySvBzqiPXL6Qj+sY0lIR2+AsBrKv28V6PQ7+/4yVJ?=
 =?us-ascii?Q?Yp2Jw7evdJH1dYkGHbil6u/L8+O15vlkWmW+AHqXder+K8Xa2zCwL/vzHfL3?=
 =?us-ascii?Q?IbFWdRzFJlHfAD/TM+vt22guD3KIY4Fgefxl2PIdUQqsMgiC537gNK3p+hDz?=
 =?us-ascii?Q?fFxpcHJipX2pcoZ65DMF5ygQSOk5iSQC?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da286a6-3150-4a9b-aa93-08da0d43c08a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 03:09:46.9379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQ1hZk/HJ0rRG7MPq3MmD8wK0bXW37mDCBB31sWaSLb/IPBqjnDYPMtOR2MuOKL//A1s8yCyyni6gvHF1/gjog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5691
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>
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
> Sent: Thursday, March 24, 2022 2:16 AM
> 
> On Tue, Mar 22, 2022 at 04:15:44PM -0600, Alex Williamson wrote:
> 
> > > +int iopt_access_pages(struct io_pagetable *iopt, unsigned long iova,
> > > +		      unsigned long length, struct page **out_pages, bool write)
> > > +{
> > > +	unsigned long cur_iova = iova;
> > > +	unsigned long last_iova;
> > > +	struct iopt_area *area;
> > > +	int rc;
> > > +
> > > +	if (!length)
> > > +		return -EINVAL;
> > > +	if (check_add_overflow(iova, length - 1, &last_iova))
> > > +		return -EOVERFLOW;
> > > +
> > > +	down_read(&iopt->iova_rwsem);
> > > +	for (area = iopt_area_iter_first(iopt, iova, last_iova); area;
> > > +	     area = iopt_area_iter_next(area, iova, last_iova)) {
> > > +		unsigned long last = min(last_iova, iopt_area_last_iova(area));
> > > +		unsigned long last_index;
> > > +		unsigned long index;
> > > +
> > > +		/* Need contiguous areas in the access */
> > > +		if (iopt_area_iova(area) < cur_iova || !area->pages) {
> >                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Should this be (cur_iova != iova && iopt_area_iova(area) < cur_iova)?
> 
> Oh good eye
> 
> That is a typo < should be >:
> 
> 		if (iopt_area_iova(area) > cur_iova || !area->pages) {
> 
> There are three boundary conditions here to worry about
>  - interval trees return any nodes that intersect the queried range
>    so the first found node can start after iova
> 
>  - There can be a gap in the intervals
> 
>  - The final area can end short of last_iova
> 
> The last one is botched too and needs this:
>         for ... { ...
> 	}
> +	if (cur_iova != last_iova)
> +		goto out_remove;
> 
> The test suite isn't covering the boundary cases here yet, I added a
> FIXME for this for now.
> 

Another nit about below:

+		/*
+		 * Can't cross areas that are not aligned to the system page
+		 * size with this API.
+		 */
+		if (cur_iova % PAGE_SIZE) {
+			rc = -EINVAL;
+			goto out_remove;
+		}

Currently it's done after iopt_pages_add_user() but before cur_iova 
is adjusted, which implies the last add_user() will not be reverted in
case of failed check here.

suppose this should be checked at the start of the loop.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
