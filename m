Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E359EC282CE
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 15:01:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B702082E
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 15:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ZtbvpoNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B702082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6D3BA1A09;
	Wed, 10 Apr 2019 15:01:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 584FD16A0
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 15:01:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr790077.outbound.protection.outlook.com [40.107.79.77])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2AD9A860
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=CQ8Kk2N+TL4xKSWoAAfCVirjmuD7R7tCVz4/9fUB+bM=;
	b=ZtbvpoNs5ohc8OW2NNUtUzn+24XMKipsS+XVB1vPnCJsYnjK6FhO3XgAMw1xrM//4cf4m7IdWf5BKlUD0357yq+aY/7p6lMDYn76ZfKmSHyIwA3VLKxg6X1xaChGzrRpEn2Uxoj+QW3MR1KhJ7+MY/KqURuFE5wvXwOeo37QuT4=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
	MN2PR05MB6527.namprd05.prod.outlook.com (20.178.246.209) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.7; Wed, 10 Apr 2019 15:01:14 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
	([fe80::91e:292d:e304:78ad]) by MN2PR05MB6141.namprd05.prod.outlook.com
	([fe80::91e:292d:e304:78ad%7]) with mapi id 15.20.1792.009;
	Wed, 10 Apr 2019 15:01:14 +0000
To: "hch@lst.de" <hch@lst.de>
Subject: Re: revert dma direct internals abuse
Thread-Topic: revert dma direct internals abuse
Thread-Index: AQHU7fmi7IV/x30l7UexE5gP02MWCKYymy+AgAD+MwCAADQ1gIAAB6sAgAAMwgCAABMAAIAAIUkAgADfTYCAAIrrAA==
Date: Wed, 10 Apr 2019 15:01:14 +0000
Message-ID: <0c897b24b234f8d42ef597dbe31fa8293519a4b2.camel@vmware.com>
References: <20190408105525.5493-1-hch@lst.de>
	<7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
	<20190409095740.GE6827@lst.de>
	<5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
	<20190409133157.GA10876@lst.de>
	<466e658c73607fca5112d718972e87c0b78653ad.camel@vmware.com>
	<20190409152538.GA12816@lst.de>
	<da06614b308500392c179651ef9c6fb835ee4045.camel@vmware.com>
	<20190410064359.GC5543@lst.de>
In-Reply-To: <20190410064359.GC5543@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2942fa3b-3597-4de4-c523-08d6bdc56063
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:MN2PR05MB6527; 
x-ms-traffictypediagnostic: MN2PR05MB6527:
x-microsoft-antispam-prvs: <MN2PR05MB65272E3B60EBE20B20AFA8F7A12E0@MN2PR05MB6527.namprd05.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(136003)(396003)(346002)(39860400002)(366004)(376002)(199004)(189003)(8936002)(316002)(97736004)(486006)(14454004)(6486002)(4326008)(36756003)(6512007)(86362001)(99286004)(2616005)(3846002)(6116002)(2501003)(6246003)(305945005)(5660300002)(7736002)(2906002)(93886005)(53936002)(6916009)(54906003)(229853002)(446003)(76176011)(26005)(68736007)(105586002)(81156014)(118296001)(102836004)(5640700003)(81166006)(71200400001)(6506007)(66066001)(476003)(71190400001)(6436002)(186003)(256004)(478600001)(1730700003)(2351001)(5024004)(14444005)(11346002)(25786009)(8676002)(106356001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR05MB6527;
	H:MN2PR05MB6141.namprd05.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: vmware.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DOjKWTlKRhmf269CIiqftcX1gpcqKTd/SWebAGDp9ELF8WmYEspzrDNeiXZkNWw0mEVlEaIUeBwovxEVYSb9AMuPAyLQ/GprYjGWJ4WWoYvAs6knKH8u1wojvNqgTDLKVhum3marQrbl5kaXzoICraxkgOUEwle6UcKUtMZbzB41eZmoVGgD8dDPj3tNLFwOwMbyWnzm9muTSNM44SvZsfBTZf5WERTN9zm2ERDUvGJGE/Z9b2tQPKFHt1saahkGcA3aXFfw2gAbvOgQuLgTE6VP76bwu23Quk6JDfOhOMvlXj7XUkP7lYnFlBfQtJmOe0u/8lrmyKKFcVhU2PEM6dI1mitiW/ZDr2ymhjCiaWqpsv8SMPoYMZqdytJO1gBFAHZhl7NUiQ4Jyn6WEXJKUwTPtuPt09W+A3XyXR/Syqs=
Content-ID: <5D2AB352DE7A2F4BB71CA19FEF5367B8@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2942fa3b-3597-4de4-c523-08d6bdc56063
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 15:01:14.1931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6527
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
Message-ID: <20190410150114.UWRTu8gKqv8GlM5z6SDFBbREPLRM-UEdtu7MBKMUmr8@z>

On Wed, 2019-04-10 at 08:43 +0200, hch@lst.de wrote:
> On Tue, Apr 09, 2019 at 05:24:48PM +0000, Thomas Hellstrom wrote:
> > > Note that this only affects external, untrusted devices.  But
> > > that
> > > may include eGPU,
> > 
> > What about discrete graphics cards, like Radeon and Nvidia? Who
> > gets to
> > determine what's trusted?
> 
> Based on firmware tables.  discrete graphics would not qualify unless
> they are attached through thunderbolt bridges or external PCIe ports.
> 
> > GPU libraries traditionally have been taking care of the CPU
> > mapping
> > caching modes since the first AGP drivers. GPU MMU ptes commonly
> > support various caching options and pages are changing caching mode
> > dynamically.
> > So even if the DMA layer needs to do the remapping, couldn't we do
> > that
> > on-demand when needed with a simple interface?
> 
> The problem is that there is no "simple" interface as the details
> depend on the architecture.  We have the following base variants
> to create coherent memory:
> 
>   1) do nothing - this works on x86-like platforms where I/O is
> always
>      coherent
>   2) use a special kernel segment, after flushing the caches for the
>      normal segment, done on platforms like mips that have this
>      special segment
>   3) remap the existing kernel direct mapping, after flushing the
>      caches, done by openrisc and in some cases arm32
>   4) create a new mapping in vmap or ioremap space after flushing the
>      caches - done by most architectures with an MMU and non-coherent
>      devices
>   5) use a special pool of uncached memory set aside by the hardware
>      or firmware - done by most architectures without an MMU but with
>      non-coherent devices
> 

Understood. Unfortunately IMO this severly limits the use of the
dma_alloc_coherent() method.

> So that is just five major variants with a lot of details on how
> it is done in practice.  Add to that that many of the operations
> are fairly expensive and need to be pre-loaded.
> 
> > > That being said: your driver already uses the dma coherent API
> > > under various circumstances, so you already have the above
> > > issues.
> > 
> > Yes, but they are hidden behind driver options. We can't have
> > someone
> > upgrade their kernel and suddenly things don't work anymore, That
> > said,
> > I think the SWIOTLB case is rare enough for the below solution to
> > be
> > acceptable, although the TTM check for the coherent page pool being
> > available still needs to remain.
> 
> So can you please respin a version acceptable to you and submit it
> for 5.1 ASAP?  Otherwise I'll need to move ahead with the simple
> revert.

I will. 
I need to do some testing to investigate how to best choose between the
options, but will have something ready for 5.1.

/Thomas

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
