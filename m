Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14B3C433EF
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 07:19:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6712E40891;
	Tue, 12 Apr 2022 07:19:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 39K-Iy2QsNPc; Tue, 12 Apr 2022 07:19:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EBB6D40884;
	Tue, 12 Apr 2022 07:19:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA3C3C0033;
	Tue, 12 Apr 2022 07:19:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6752FC002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 07:19:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 560BF6080A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 07:19:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ldCPwJNX_8QH for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:19:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99A7260615
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 07:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649747972; x=1681283972;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+WPPUKKdZrPTFPagYMY4zV5lofmswVwN6xvkZAJnHoI=;
 b=lRWwqGwWQo7eMH7Hc7jOHgKhhlJjjRkydHPDF9IU7IupPhgEji+6RiDL
 OGCdHK7GgFFMj0fFOFH0I6a3oLykagYRnceL30K4uySr12fV4+8rabNPZ
 rL+1bR53sYtrC5bVJGpq3iNZfBD2SrbOUtDgkNMiSObXcu4oiD+ghX+Wi
 qCuA46bQpbIbu79sSllleNzEsskKIIF+wF5lQfRTTusuvPoPjodgcGkok
 9GFYeJxkfahggQidd03xqU32wpRSlUFZUc/9ZUSbOGQvGYdJ8cqOGG3n1
 O6sm0F3ScnGCUgFzPeCAbUB002GmZwRZY/siNRuvZzsPVVx1BqNyra2IR w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242883986"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="242883986"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 00:19:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="559210036"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by fmsmga007.fm.intel.com with ESMTP; 12 Apr 2022 00:19:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Apr 2022 00:19:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 12 Apr 2022 00:19:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 12 Apr 2022 00:19:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3kMiRyKg6gRrZOfuYMwWw9Xc2JWX9dnrNeszZjIr9XxxTdIaLMo0aQ6+USRRNwB/oD4tWV9pVw47Zs531OfdyPYgOqpvtjdVksYT7969/nF+4HbSQG9rcmZPs8gMfQYW0J+ORViQm2FtaTv6wASoGsq4zS5WrPCGTn7Vk/Gdq6su17rW5Y/WL9YusPwlUNo2NPUERawXq2JEA6TTpd4qqj+GMF9NGqIGL5FoiNkZp/apE8+BOEgkbus0K+znh1iGHOFwhvz47Un9feDbbkVd+mKQIrddYq1O9Lm2Cf7eYgB4B3m4nVmQd9niFNZIiPqumfc1K1AuTTSMJft124E+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2a1a5YVCvNZwxdfZJo5oTIO9f6TIfs+MJLi7zV9Qdks=;
 b=e9g8uJTvQa4MzapqHKC/dvTg69n8W8LfKbSrNut5wtgxU0wVyL3D18tzibnbn0kzdBFy161znmNAcfig6mQyE9aZQEN9iku6JJLh9/TDFIf000af2IZnu0Hv/Xs8dxvSBidlXEJ9m8jGoUhw2lyrWqCrhrR93TEhmRyHif8HktJk6cNcO4k7I6W4vWLNhTNbZpyAPWBrGQ+jkhvVVd9vayTBjO1RGFJiqlOgYlKOPYiXUgfpIbw0TWBhRvJ9RivmQTZ0NfzBxlZs3c453sLff5YU35b3IH/ttTz3Rl9NIyXQfbPq3I8bw/qSdaNZ58U6y97i5xdxEHzaSDQXZQJplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4570.namprd11.prod.outlook.com (2603:10b6:303:5f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 07:19:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%8]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 07:19:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>, "Robin Murphy"
 <robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: RE: [PATCH RFC v3 08/12] iommu/sva: Use attach/detach_pasid_dev in
 SVA interfaces
Thread-Topic: [PATCH RFC v3 08/12] iommu/sva: Use attach/detach_pasid_dev in
 SVA interfaces
Thread-Index: AQHYTMWeRZaN3+doq02z8waSkl9xz6zr2plg
Date: Tue, 12 Apr 2022 07:19:19 +0000
Message-ID: <BN9PR11MB5276BCAA64597FE400DF15CF8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-9-baolu.lu@linux.intel.com>
In-Reply-To: <20220410102443.294128-9-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f067bdf-54ba-45de-f125-08da1c54c297
x-ms-traffictypediagnostic: MW3PR11MB4570:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MW3PR11MB4570F9B7CF139A9E6B3BDCEE8CED9@MW3PR11MB4570.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8E7UgAsgDQDzLCLRtQ41kSeesZOQOsmAAYKH/KlX6HiCsg5QNyJjq315haUr9e5LXsxZeXCVQMjZVxI+X8sWYMS5SPuIxzx5qBTSqxfRL3a/usOmYF5coj4te6icRwcuWBhPE3sT4bXhGMyWH4XWQzW3nJ6OqwtaJAksq4sf9NyN/HjoZO6DQv413My82DehGEgSQqwBI836Px3N64+ZPny0pSHxk0/EW5Xz9tUZp/id3LUkodIyLMohTryp2hOKiH90wwdUL0Z0Cb7Ve+ROjimSQsQp/aBaN7FHq3GI8eoDfEpLfRyPcCYAxcH6zXLQ24KZ0f9wPmMIVEFXEAle/0YtdkqstBxg9286V7goro1rCqWjfKg2OIFQIWytB+J+misokwX52yQ1ujnA3qJxXMRoAPLKiSNHqkH43YLg/7PFDCt+TwDQcgGJLk7W3HeWKTRP67VK6FQ1keCSt90OIQBb4sfmpkygquZgUUDpzVBm8dLbLr142R/wa2ouiNcnpDKQFjmxmbOh8TPMW4cgaUu1mtGJAFw97UHHhrUM7LSJ91PMh/gYcGAk3/hlgzaoCiNchfVBd6Ge6wSacLwdc/l6mWg+MVq5WS2+l/qGGW3BXltzmzizK/ohYbeocwgSNga2Hj+uegilxOykuDS6fpGoLtYWWSpe3UxROLrY1Cvzf8gAEUioUNlcNJSzMXahc3EXkYkP45KG3tG6uN5wxw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(2906002)(122000001)(6506007)(38100700002)(7696005)(9686003)(7416002)(8936002)(71200400001)(186003)(83380400001)(26005)(33656002)(82960400001)(110136005)(508600001)(52536014)(54906003)(5660300002)(316002)(4326008)(66446008)(66556008)(64756008)(66476007)(66946007)(8676002)(55016003)(76116006)(86362001)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vt7JN7F2HoJX3b6d3JiUKf1YvoGnGXpsGjG0xTGdhR3ZfnVPwe/dIjZFyTSN?=
 =?us-ascii?Q?5/0n3cqJVNoclsmXg786op9iDTC+4h8t9FMoamPGxjrl5gW0+iaL1fe8TJ72?=
 =?us-ascii?Q?G/0rADCJ3LQSeYfVpml2kXvXd812V8/s9++N+Zh5ZIP2tYw5IH1x/XMjsG9r?=
 =?us-ascii?Q?xxjRZO/rvv2Lgu8ngeK1ZLAcUez6mwFwlW8XIqnd6jgJcDgzNrn1hFhqZIkQ?=
 =?us-ascii?Q?qumM3K4IDlxj+WL0jaby/1IU8boTNzt+4UKHz05AyP9lgocgpLDJLyIx9OM3?=
 =?us-ascii?Q?mg4Do93uQPcs41PxZ/RqaPOTC/yqyndYR164rKzSXRGt2dNwNLnUYhmJULNe?=
 =?us-ascii?Q?1yJ2BvLsgKvGo+TC6gPivf2iothH9lxnV0/IPLtDfjMbEUk6yknv5hUu2/jo?=
 =?us-ascii?Q?Z4HRRxKSeykmAXRC193PTYJjuNnZctzw4Vq2SLP4v45RyaxJLCRxfg74+UcC?=
 =?us-ascii?Q?cyFH1h+kt0Q3AC+7qV9aCUesBfajDmQjeybwdHMjpRDcDSg/g7+rpqNkplr6?=
 =?us-ascii?Q?AXXwxH7uNDB7tiHKuo3t1u8oykJAzTFjWGN/CZ+Jm8ND03LjRZIS2ylEFtxF?=
 =?us-ascii?Q?K5ToGmSd7Afy1B7n23pCZqrOh2dSrCUexEk0vUPtZQuh/gklkEVfn42i9Mxp?=
 =?us-ascii?Q?Kq25y+4Kt2hbSJmbCG6I0XNDP3q7LzgsaL3ec7vGvWT5AuUHPcRmrJj92MKi?=
 =?us-ascii?Q?m5+SPQ7T8vh/5S/ZZ68yKgHH5iL3QJDAB4pSF0dV4cqEWUj8Xv1WbGM8il1O?=
 =?us-ascii?Q?FxAn5TxmaeC1hl1cREC4CREexeOnol+RuZ6ZhcvmnTgHdnHwGr3n8XST6eT7?=
 =?us-ascii?Q?2F872HkRi/HX9tuCf17ZoypSBvOusO1BCsMWlKPE8Ve/UEs09ZP7SipVgm/f?=
 =?us-ascii?Q?g93SLd+Dy7HHhWVTb25TukFM1OdCnYCCQvjyXoSkIxeSTWMc2mx2kNPe6ge+?=
 =?us-ascii?Q?NwXWYuNbIhalSzy0CF6BKt0lo/+/YxckqglhTk1ei7wvzWgS9rmiP5O5eBZ3?=
 =?us-ascii?Q?FIuzp7wBgqTYZ9ZcQYA+3MYYOax2+pnHBFVFN0tgknebriZBFnhPH6kFlaYl?=
 =?us-ascii?Q?6GkRT+UME3psc4R8bxa9kwzXtf1qbN9SxbVEtZZK/JnH3EBdOh7+exPUrVXb?=
 =?us-ascii?Q?hJC9rCoRtnkLg8w/nTKknIDyNgqHoUX5XrKoiXB5ZlvKkIB0c0z1O5XG8p7N?=
 =?us-ascii?Q?Ax3OukeCt5moan0hASu4+L3l/GeyOMu4MlK0sU7Os/m2o/p1ncisljNnkwRA?=
 =?us-ascii?Q?K8H3SMWmjpUqwwOsKN2k36Iczj+IpH8usO1wbU9ICff52SCBBkMQ+A/eh8S+?=
 =?us-ascii?Q?9wkc4VPWIjYtaiUEIDrcEqiB0T9MLXUjL8/fEHfwnd1OJUvWpsj8ncbw0tIm?=
 =?us-ascii?Q?uHK+Rrzqwwv0ZIoNHBNWqhSKCrUgzjr8zsyV9M8cV7+E6s6h4VoAMhoCAOB0?=
 =?us-ascii?Q?tvrtMOj4QtkCOekyUjEviTcOKDVdFTh1q4qFRqO8i/AA+I4aecfnp5I05+1g?=
 =?us-ascii?Q?dwwgjgnMGWQPejvMQ5xMubB0Ch7BqW52I4nBQyvyZ7nUsbm4cBld7yNJNotn?=
 =?us-ascii?Q?BZMCl3KWAqSJd/mvvNzFtKRMXXEplbBlpSzlKrpAeAfwOAYU8jd+QgHylpHy?=
 =?us-ascii?Q?2QHR8clX5mXzijuEGiDfE/ud9q78qQKg3xEkePh54hfnc8c9VvDCkjp4fEes?=
 =?us-ascii?Q?iVJZkitdE/bzdfi8akq6BYgj/heD+5HhDK/ozAe1pVjh/bT/Dh7cxi7k6XO+?=
 =?us-ascii?Q?bKSpuuhBmQ=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f067bdf-54ba-45de-f125-08da1c54c297
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 07:19:19.2665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9a7EQ7lM8nWV3yr3pGsVdKmRTRUYPdp0u5azh607WlEI5LoqZ6WqMV6UtcfLJn+9P8kPPoxwlQ39SIZRqpCjKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4570
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, April 10, 2022 6:25 PM
> +struct iommu_sva *
> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void
> *drvdata)
> +{
> +	int ret = -EINVAL;
> +	struct iommu_sva *handle;
> +	struct iommu_domain *domain;
> +	struct iommu_sva_ioas *ioas;
> +
> +	/*
> +	 * TODO: Remove the drvdata parameter after kernel PASID support
> is
> +	 * enabled for the idxd driver.
> +	 */
> +	if (drvdata)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	/* Allocate mm->pasid if necessary. */
> +	ret = iommu_sva_alloc_pasid(mm, 1, (1U << dev->iommu->pasid_bits)
> - 1);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	mutex_lock(&iommu_sva_lock);
> +	ioas = iommu_sva_ioas_get(mm, mm->pasid);
> +	if (!ioas) {
> +		ret = -ENOMEM;

ioas can be NULL for multiple reasons, e.g. :

1) ioas->mm != mm;
2) kzalloc failure;
3) xa_store failure;

It's more sensible to return error from iommu_sva_ioas_get() directly.

> +		goto out_unlock;
> +	}
> +
> +	/* Search for an existing bond. */
> +	list_for_each_entry(handle, &ioas->bonds, node) {
> +		if (handle->dev == dev) {
> +			refcount_inc(&handle->users);
> +			/* No new bond, drop the counter. */
> +			iommu_sva_ioas_put(ioas);
> +			goto out_success;
> +		}
> +	}
> +
> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);

s/handle/bond/?

> +	if (!handle) {
> +		ret = -ENOMEM;
> +		goto out_put_ioas;
> +	}
> +
> +	/* The reference to ioas will be kept until domain free. */
> +	domain = iommu_sva_alloc_domain(dev, ioas);

Shouldn't we first try whether existing domains are compatible to this
device?

> @@ -1952,6 +1954,7 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>  void iommu_domain_free(struct iommu_domain *domain)
>  {
>  	iommu_put_dma_cookie(domain);
> +	iommu_sva_ioas_put(domain->sva_ioas);
>  	domain->ops->free(domain);
>  }

is it good to have general iommu_domain_free() to always call a put()
function for a specific domain type? Why cannot it be done before
calling iommu_domain_free() in sva-lib.c?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
