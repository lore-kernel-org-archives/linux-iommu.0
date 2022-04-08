Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C95DC433F5
	for <iommu@archiver.kernel.org>; Fri,  8 Apr 2022 08:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 460758434F;
	Fri,  8 Apr 2022 08:26:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7zFUFI3WHCqc; Fri,  8 Apr 2022 08:26:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 285B18434E;
	Fri,  8 Apr 2022 08:26:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 017A0C0033;
	Fri,  8 Apr 2022 08:26:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CEE8C002C
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 08:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A14141D36
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 08:26:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vNtGyIX_f2tr for <iommu@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 08:26:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6838441D34
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 08:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649406373; x=1680942373;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7pgivR5gXD1Gru4YrAsH8EJNTujxED1M40YfCPyXrJ8=;
 b=TPBOgCm1Uc7ee7WTycQmvAfJvkTalsyMB4XDyK7bBptKL61T5l1vVtP4
 gQ5TjzTksVDJI8KTnSJfr90ss7z149IVHjEgWUQOGm58AA7exPjPRqYn8
 Q90DnHFBgeAK9awhF330XDasq1fMrhzkGFyBqVY6MSaHgOVFaKijlPvdj
 qSE6jBVoqNmak/HtX/m03aiXNz7PED4mvCpw+GpwWPizCh9q9fWm8erdv
 c6VzeMTkSkozjnnL613oANUiHu2prxSDnqtVj0qDyfErwZCU4DMCr+2LD
 J6yAOy5zTNmvS63N/glD9mH8Sn6A//NYncVAfasLfNDV9glDC0Ng2Xw37 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="322232547"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; d="scan'208";a="322232547"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2022 01:26:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; d="scan'208";a="589148119"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga001.jf.intel.com with ESMTP; 08 Apr 2022 01:26:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Apr 2022 01:26:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 8 Apr 2022 01:26:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 8 Apr 2022 01:26:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nShKDb0AVaB60ukSkfoeRgRERXO3VuqkrS/4oKXfztuOMF/qvPsOB8A75h3028nsShtOmm+9lG4kinZql8c9m+qp+rr/Z07eVtSoMv28rnKl+8XeuPJ6cQ0KPHiAAlAkR62W5n8EXKEeTIS3nZbnEMkz86AbgkhAhimoTu2ciFmbPdc1kCG8CjP4GZa6lk/P+07k3Ut280qUurBlguC5dh76iNLDgGMgX+2e50RDHAvO3EabbmwH2DC02tQMNBRAsF5T16Cu1D9NbJKsYC9u5gvnjpu/H+MUz0Rna/W0lWAo0TJwDXkuMt2Cn1BY/EWVTQBtrdPJeo2hgDpP407GPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNCw6R1L6/Gh4yx3fSRS/fDNEB4p6knvh5JvLZpBSzk=;
 b=H6iWZMwtqPZtvaf+3kSOpl09Fb+Y5B21UYY2uYJGB2hwCVdELHpV9bR2QbJNs02VRkyLiAhcIjpQg0h9cfWMIIrdRWn2MpRTf5DUTv90tfvlTelvo7AdBkt8wHwT3o8nmqFzYKvEWA1RvUW3OZGCn9kutdJ0kthjfVxR6m52N9x0pEQora8159H4HA3OPAdl48fNQjVFutqlVteaoK0dOAfNDsXzTm9Qi8CG9QRIIo14/sahhHUN74Iaiy/6nI0o85gRew/joqvxlyJKcLENXj6c0+O2vspG1K8valwzaPI3JzZa7x1CWfDatRUKYv+6cw/jRF3FzEL9WTbCcPRyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY5PR11MB3973.namprd11.prod.outlook.com (2603:10b6:a03:185::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 08:26:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%9]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 08:26:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>, Lu Baolu <baolu.lu@linux.intel.com>, "Cornelia
 Huck" <cohuck@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Joerg
 Roedel" <joro@8bytes.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon
 <will@kernel.org>
Subject: RE: [PATCH v2 4/4] vfio: Require that devices support DMA cache
 coherence
Thread-Topic: [PATCH v2 4/4] vfio: Require that devices support DMA cache
 coherence
Thread-Index: AQHYSpOCUIkD9YA9P0Wkck7HssDSt6zlrpew
Date: Fri, 8 Apr 2022 08:26:10 +0000
Message-ID: <BN9PR11MB52764BF8AC747D4B2E2B8BAA8CE99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <4-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
In-Reply-To: <4-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e00e6d2-7986-47c2-da91-08da19396f84
x-ms-traffictypediagnostic: BY5PR11MB3973:EE_
x-microsoft-antispam-prvs: <BY5PR11MB39739ADD7BBAE6E9AFC2D4FA8CE99@BY5PR11MB3973.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uHJmZUVvMxZgr6PLoc9RISjcv+kd5bK+jWrfydmS1GUnJ/4qcKoyJIW6fOro1dEyB0VIuD4Hfp2kRLHvN98QgYhgrhtzf3Sw4+0RoBFQqbrwJOODyNhPAB654AZUqa9vK9vbwfNEM8r/5XcXIP84puVvZw+UIj7IP/DAslH5OTl0PaQfrHABeyLt3sfRZLvrjCLpM3rwSBgbuGwa4pzbdnMSaxgzNofnCB4WLdzLwp48DYI4MaAD4LC++gBgyQRz+fLYFdc/h8PDETs7wtREQuSbLmfM42TY2AGAeVGkyDcv5zPDWiKsgW1csYAE7kxoZ2Mc51sZgjoOVKT4p9dHNZdBGDGQyueiLzg1fAUyQtkZF16vEU/PXiOloScpN0ay6YHTZ976ayXGwGThn2eafe6pbyY0BNn8GlRryqa1tf9wk5KxCb8+i0d08DoWfLY31W0grYA5a+nKGAptL7cXma20lo8cuM2G4Al/k+oXJyUFpZ/nq4WTeETOmPjzPcUKGXsLPRauAfIxVkt2ZrCfTj0CrIGl8y6MIZxy2OYgQ/X6qDRq52g6lbSyDRZmL9L1v1QrtvvUOqosfgevQVHfAv8muop2Wo5Q6IZQDbB19KLRbOPmvG/EUS4cP0tLjIp+I2JsSZQwCGF4IAPFsx3KHi/c3T/Cyok+Kdm6c+6I6K84PCP5uPM7esoDZMMXv4JHzPI0TO/tftdaXM0HI55pr96CWZdkUqgTtbf/ICIC+wg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(186003)(83380400001)(66556008)(66946007)(110136005)(26005)(82960400001)(8936002)(38070700005)(508600001)(6506007)(2906002)(7696005)(122000001)(33656002)(86362001)(55016003)(9686003)(7416002)(54906003)(71200400001)(5660300002)(316002)(76116006)(64756008)(921005)(52536014)(4326008)(8676002)(38100700002)(66476007)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?llffwlVnMjMww4So9LqbkownB+S7VGLy4HvavI3XuVAVx4lVm2Ae+XOY3z9z?=
 =?us-ascii?Q?2zA6H8SjLYm/9FOr46AMfZ95GBq9OfeR+VhajrvONH4y4sz9BiGTlQtF+AvC?=
 =?us-ascii?Q?meZp2f6pYIcNvKwwwPUv5TpmNURh8mNl6dQE8nVJkHAIAxj+HagS/2MOS/an?=
 =?us-ascii?Q?Vv9/plTxwJ1Ha1phHhqlHaJeyP8zSv3o6zxb443grJO6c7Kl9t7zwIVSpzWJ?=
 =?us-ascii?Q?Zi57Tc8Hyg4w3qCdGxiDsRRn2YLwPMbejGPSqi3xsa0pnkxImv3OnKoI/yVc?=
 =?us-ascii?Q?NuwRRvrY0w3oCShOWd07VvGZ6xX8CLrbQR5odOud/epI0fUyiZ+T2LDKFPKU?=
 =?us-ascii?Q?DMCAirUl3ljJSMUL8e0Z2N+pF5HKv0TqJx3ha/qLli3OrfCLxzxgYq++o4wJ?=
 =?us-ascii?Q?3ozyc13so9KhX61CdnWLPpZxEEYt3bxhiV4AFRQb1h5e16UEfjIjuFyq5aW3?=
 =?us-ascii?Q?nZKiVXwUNQcevvY14m5FlIaYqeQ+VABfbYRkslPO6mQHqqSP35f8qCWQZ+Ry?=
 =?us-ascii?Q?U9y7rT2fB5YanQdVDmoK0vMXH8gbUn/f0nKhgBgi5+69fW4EV2I0mwfi1Rza?=
 =?us-ascii?Q?U6K/iWzZwN8EkdG9gaaCHLFb5izVGW4dv5F0dIQy8AojLG2vsvCeeijoirZX?=
 =?us-ascii?Q?q2lgyR/ARtanJOaz/Xo/8DYIDcMvpK9NF6d6Wh2icq1eHVuFPWm1QT+sK5DX?=
 =?us-ascii?Q?PictLK7AO7ZnvnGD1xOf6G/fwOxKvo9P7Eb9wTrA7hqNcbRH8nIOLUcvfc/X?=
 =?us-ascii?Q?M8AtX5SXMpcKs63BDbUpBXEY5BRDWCelw3f8+IR/mAaXdCAcoO8aS7naoqd0?=
 =?us-ascii?Q?O4RSp84DA7qHe9giFN+v9v5S/oNRdrQylP4uyTHEU+Z6i/pxQfhxKZA7zFpB?=
 =?us-ascii?Q?j6HTLR+EArcEeAhWozzOXyEAFU1opsel5eDTrev5j0NN6tgJSsEJ+7eqHVQX?=
 =?us-ascii?Q?FxR5NyY1W/046nq2+pQT+4L04lxfE8i22Ik8cCrkA+DcASF57PmlBAWWxNNx?=
 =?us-ascii?Q?rJuUUnw2BZBC/ylh5NMHyyczCzcXvzVxaVdync3a9zj6VaofAduN26esDhof?=
 =?us-ascii?Q?4J3JH7NJT6n+uXlQ8QFcgwCmn9Rhoe3tHCw/iN/JJnqefCpcESLV0snk6MjC?=
 =?us-ascii?Q?0vk8cEdpSnW3gtWm9uc9Y5e/DEUG3bt5Iwo+N2waWQsUmgu1k+c3yBH+IU7K?=
 =?us-ascii?Q?zpyiY/pBnWUa1F/tvcvGO6d1Xwwhuy+gsa75wYiJ3xyUj69Rgpa3eW2vhB+n?=
 =?us-ascii?Q?1veabeWOtbbg3RdRKmKCBivg9KaCa+IC6oSPP0UOqg365b9gLrEzU8l+5JIh?=
 =?us-ascii?Q?7YxPd5s4Sg2NPxqQ32JtXYHSKm6jGS4M/EFJ0d1hNIres1OsnypsSu3p9R36?=
 =?us-ascii?Q?YRirZHkC3+nb3ERLJ6509+5wcog6EVx9HsuVgSM3Yu90XdVckyMu00utKz0T?=
 =?us-ascii?Q?6HZOE5L6J4m3QkcX/C+HhHFUnK40vpWx3CX/MBSO6Crs9V/mjWWsKZf5HZwA?=
 =?us-ascii?Q?3zyxyh1tLIUrheoV7IE7DlMnK9xG6w1f4s0aSwVKrLkH74ccJZCiUmMn+X22?=
 =?us-ascii?Q?U0XTwu7hGOBkgCVGruCxvfzw1ZiFglCu3/WTbV7HfFxpVs8nA6UnaXFaa2Bv?=
 =?us-ascii?Q?W1RTuZxzdRicM5NKN1QN4e3d/x2rzFmxoUQgFD/fQOaNUCFI3mXrgyhM/+dA?=
 =?us-ascii?Q?uUe0DeYz86HqBIX13EHyrvlakLlIiu2VsUf/HuVq9iuxlH7xxVHLT6uMGkQg?=
 =?us-ascii?Q?hFgZ21UnQA=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e00e6d2-7986-47c2-da91-08da19396f84
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 08:26:10.0216 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVuLFPpCqpsUsj32DGKgKhSvAzKksxnT+iDEauz8l1Q2fdJmNcgOmQ0sEB5p7z/bOSpVYqPj18vWCNN6uB3shA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3973
X-OriginatorOrg: intel.com
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
> Sent: Thursday, April 7, 2022 11:24 PM
> 
> IOMMU_CACHE means that normal DMAs do not require any additional
> coherency
> mechanism and is the basic uAPI that VFIO exposes to userspace. For
> instance VFIO applications like DPDK will not work if additional coherency
> operations are required.
> 
> Therefore check IOMMU_CAP_CACHE_COHERENCY like vdpa & usnic do
> before
> allowing an IOMMU backed VFIO device to be created.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index a4555014bd1e72..9edad767cfdad3 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -815,6 +815,13 @@ static int __vfio_register_dev(struct vfio_device
> *device,
> 
>  int vfio_register_group_dev(struct vfio_device *device)
>  {
> +	/*
> +	 * VFIO always sets IOMMU_CACHE because we offer no way for
> userspace to
> +	 * restore cache coherency.
> +	 */
> +	if (!iommu_capable(device->dev->bus,
> IOMMU_CAP_CACHE_COHERENCY))
> +		return -EINVAL;
> +

One nit. Is it logistically more reasonable to put this patch before
changing VFIO to always set IOMMU_CACHE?

otherwise,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
