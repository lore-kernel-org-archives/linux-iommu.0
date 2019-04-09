Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC93C10F0E
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433B220883
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="SleyPmA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433B220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 17D2BDDE;
	Tue,  9 Apr 2019 17:24:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3281FDB3
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:24:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr690060.outbound.protection.outlook.com [40.107.69.60])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0E46BF4
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=KGPwwYc/VUGVEgjbazzT8nXv2SHXye0yvJPcYPtZTsM=;
	b=SleyPmA4C1Sg1Ly+vzgkHHGGnCanHt9Q+J3KfArmIAPNIP32k5GId13edeIfaQmtSoVQ/CJYhEZciKtOrFsmiOfjMUjin8AmsjviWrcye9y5TqPHANgcCVkqgHyd+L3KZYQi5QGsqjNwr018Shjcqtk5o/rsJomV6vcPHmV+rxc=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
	MN2PR05MB6064.namprd05.prod.outlook.com (20.178.241.19) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.7; Tue, 9 Apr 2019 17:24:49 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
	([fe80::91e:292d:e304:78ad]) by MN2PR05MB6141.namprd05.prod.outlook.com
	([fe80::91e:292d:e304:78ad%7]) with mapi id 15.20.1792.009;
	Tue, 9 Apr 2019 17:24:49 +0000
To: "hch@lst.de" <hch@lst.de>
Subject: Re: revert dma direct internals abuse
Thread-Topic: revert dma direct internals abuse
Thread-Index: AQHU7fmi7IV/x30l7UexE5gP02MWCKYymy+AgAD+MwCAADQ1gIAAB6sAgAAMwgCAABMAAIAAIUkA
Date: Tue, 9 Apr 2019 17:24:48 +0000
Message-ID: <da06614b308500392c179651ef9c6fb835ee4045.camel@vmware.com>
References: <20190408105525.5493-1-hch@lst.de>
	<7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
	<20190409095740.GE6827@lst.de>
	<5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
	<20190409133157.GA10876@lst.de>
	<466e658c73607fca5112d718972e87c0b78653ad.camel@vmware.com>
	<20190409152538.GA12816@lst.de>
In-Reply-To: <20190409152538.GA12816@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66876b2c-e08f-4d47-0552-08d6bd10452c
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:MN2PR05MB6064; 
x-ms-traffictypediagnostic: MN2PR05MB6064:
x-microsoft-antispam-prvs: <MN2PR05MB60645127B57101360D2C8079A12D0@MN2PR05MB6064.namprd05.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(366004)(189003)(199004)(7736002)(99286004)(102836004)(8676002)(478600001)(186003)(1730700003)(68736007)(316002)(76176011)(2501003)(14444005)(256004)(26005)(81156014)(476003)(6512007)(81166006)(2906002)(486006)(4326008)(25786009)(6506007)(6116002)(6246003)(71200400001)(8936002)(71190400001)(36756003)(3846002)(2351001)(53936002)(11346002)(106356001)(446003)(5640700003)(6916009)(105586002)(54906003)(86362001)(93886005)(305945005)(5660300002)(66066001)(14454004)(229853002)(2616005)(6486002)(118296001)(97736004)(6436002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR05MB6064;
	H:MN2PR05MB6141.namprd05.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: vmware.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /1q0DzMWqjcs/2spBCcUdevM2Pep028QddjwuQQ8ZuLMxndvvX6Ozictvvuh6gjNmwXmgE5to+neB8aB8duAPMFudAKGYcCOvPlX1SaDbJ0dQu7LffckMw77MPxAxBFt7jvijFvKBaIwwXOCzI0yh6hVvxkwclz9D4Gv8LTYBycKk6+2/kX3B+ApPlZE9EeIikPHpZxvsJHXsTPcEvMxA6geV/EgdHXhRzo1nmbK/MOlMFobB15swK9lMsZLRFZWjmMMc3Sv92kBIeR9jUQb9ZaaWv9EZqUQPlzjb4z12HY5p3bgOZQfUAz8F9fKB/ImD4oeKsjrqZAwHRQpYlJNcO1PB+fL8+uXbcKAHIVr8TLsC2YlqSCcbVSdCon1VrHEy752Yiz4avfUBl6/Zet42PzIfrWZbKjuCaY4RRXLM5M=
Content-ID: <5F44158474DBDB4E8E43F25AFEB4988C@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66876b2c-e08f-4d47-0552-08d6bd10452c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 17:24:49.4551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6064
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Deepak Singh Rawat <drawat@vmware.com>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
From: Thomas Hellstrom via iommu <iommu@lists.linux-foundation.org>
Reply-To: Thomas Hellstrom <thellstrom@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190409172448.0LXlsUv_PzgxSdnzUHB2FuDyiI4swNUPRSEuTJSbiXU@z>

On Tue, 2019-04-09 at 17:25 +0200, hch@lst.de wrote:
> On Tue, Apr 09, 2019 at 02:17:40PM +0000, Thomas Hellstrom wrote:
> > If that's the case, I think most of the graphics drivers will stop
> > functioning. I don't think people would want that, and even if the
> > graphics drivers are "to blame" due to not implementing the sync
> > calls,
> > I think the work involved to get things right is impressive if at
> > all
> > possible.
> 
> Note that this only affects external, untrusted devices.  But that
> may include eGPU,

What about discrete graphics cards, like Radeon and Nvidia? Who gets to
determine what's trusted?

> so yes GPU folks finally need to up their game and
> stop thinking they are above the law^H^H^Hinterface.

And others doing user-space DMA. But I don't think a good way is to
break their drivers.

> 
> > There are two things that concerns me with dma_alloc_coherent:
> > 
> > 1) It seems to want pages mapped either in the kernel map or
> > vmapped.
> > Graphics drivers allocate huge amounts of memory, Typically up to
> > 50%
> > of system memory or more. In a 32 bit PAE system I'm afraid of
> > running
> > out of vmap space as well as not being able to allocate as much
> > memory
> > as I want. Perhaps a dma_alloc_coherent() interface that returns a
> > page
> > rather than a virtual address would do the trick.
> 
> We can't just simply export a page.  For devices that are not cache
> coherent we need to remap the returned memory to be uncached.  In the
> common cases that is either done by setting an uncached bit in the
> page
> tables, or by using a special address space alias.  So the virtual
> address to access the page matter, and we can't just kmap a random
> page an expect it to be coherent.  If you want memory that is not
> mapped into the kernel direct mapping and DMA to it you need to
> use the proper DMA streaming interface and obey their rules.

GPU libraries traditionally have been taking care of the CPU mapping
caching modes since the first AGP drivers. GPU MMU ptes commonly
support various caching options and pages are changing caching mode
dynamically.
So even if the DMA layer needs to do the remapping, couldn't we do that
on-demand when needed with a simple interface?

> 
> > 2) Exporting using dma-buf. A page allocated using
> > dma_alloc_coherent()
> > for one device might not be coherent for another device. What
> > happens
> > if I allocate a page using dma_alloc_coherent() for device 1 and
> > then
> > want to map it using dma_map_page() for device 2?
> 
> The problem in this case isn't really the coherency - once a page
> is mapped uncached it is 'coherent' for all devices, even those not
> requiring it.  The problem is addressability - the DMA address for
> the same memory might be different for different devices, and
> something
> that looks contigous to one device that is using an IOMMU might not
> for another one using the direct mapping.
> 
> We have the dma_get_sgtable API to map a piece of coherent memory
> using the streaming APIs for another device, but it has all sorts of
> problems.
> 
> That being said: your driver already uses the dma coherent API
> under various circumstances, so you already have the above issues.

Yes, but they are hidden behind driver options. We can't have someone
upgrade their kernel and suddenly things don't work anymore, That said,
I think the SWIOTLB case is rare enough for the below solution to be
acceptable, although the TTM check for the coherent page pool being
available still needs to remain.

Thanks,
Thomas


> 
> In the end swiotlb_nr_tbl() might be the best hint that some bounce
> buffering could happen.  This isn't proper use of the API, but at
> least a little better than your old intel_iommu_emabled check
> and much better than we we have right now.  Something like this:
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index 6165fe2c4504..ff00bea026c5 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -545,21 +545,6 @@ static void vmw_get_initial_size(struct
> vmw_private *dev_priv)
>  	dev_priv->initial_height = height;
>  }
>  
> -/**
> - * vmw_assume_iommu - Figure out whether coherent dma-remapping
> might be
> - * taking place.
> - * @dev: Pointer to the struct drm_device.
> - *
> - * Return: true if iommu present, false otherwise.
> - */
> -static bool vmw_assume_iommu(struct drm_device *dev)
> -{
> -	const struct dma_map_ops *ops = get_dma_ops(dev->dev);
> -
> -	return !dma_is_direct(ops) && ops &&
> -		ops->map_page != dma_direct_map_page;
> -}
> -
>  /**
>   * vmw_dma_select_mode - Determine how DMA mappings should be set up
> for this
>   * system.
> @@ -581,25 +566,14 @@ static int vmw_dma_select_mode(struct
> vmw_private *dev_priv)
>  		[vmw_dma_map_populate] = "Keeping DMA mappings.",
>  		[vmw_dma_map_bind] = "Giving up DMA mappings early."};
>  
> -	if (vmw_force_coherent)
> -		dev_priv->map_mode = vmw_dma_alloc_coherent;
> -	else if (vmw_assume_iommu(dev_priv->dev))
> -		dev_priv->map_mode = vmw_dma_map_populate;
> -	else if (!vmw_force_iommu)
> -		dev_priv->map_mode = vmw_dma_phys;
> -	else if (IS_ENABLED(CONFIG_SWIOTLB) && swiotlb_nr_tbl())
> +	if (vmw_force_coherent ||
> +	    (IS_ENABLED(CONFIG_SWIOTLB) && swiotlb_nr_tbl()))
>  		dev_priv->map_mode = vmw_dma_alloc_coherent;
> +	else if (vmw_restrict_iommu)
> +		dev_priv->map_mode = vmw_dma_map_bind;
>  	else
>  		dev_priv->map_mode = vmw_dma_map_populate;
>  
> -	if (dev_priv->map_mode == vmw_dma_map_populate &&
> vmw_restrict_iommu)
> -		dev_priv->map_mode = vmw_dma_map_bind;
> -
> -	/* No TTM coherent page pool? FIXME: Ask TTM instead! */
> -        if (!(IS_ENABLED(CONFIG_SWIOTLB) ||
> IS_ENABLED(CONFIG_INTEL_IOMMU)) &&
> -	    (dev_priv->map_mode == vmw_dma_alloc_coherent))
> -		return -EINVAL;
> -
>  	DRM_INFO("DMA map mode: %s\n", names[dev_priv->map_mode]);
>  	return 0;
>  }
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
