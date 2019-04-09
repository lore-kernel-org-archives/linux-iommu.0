Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0595FC282CE
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 14:17:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B634E20830
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 14:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="E8Be1q65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B634E20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6E43E1024;
	Tue,  9 Apr 2019 14:17:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 66BBCF7F
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 14:17:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
	(mail-eopbgr730042.outbound.protection.outlook.com [40.107.73.42])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9E5B2F4
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 14:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=nvyflkmnKfvlccwSogOs65ZBTrmmtvji8K0vGJVWLng=;
	b=E8Be1q65FxPI1ryqOw0KDfaneUYYa/WWGQN8S4sP5g20Ke0aYKax+2cVvjXYFxynILROXGOuTDswdgujX8PWkypbXbxzCMgrZ34GQudVQ/3gWkOyl5LM51e6oEt7nfsbKdZR1UQXGV4rVVEq9onNJDLIWT7mylKEYVI5jKkdyRU=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
	MN2PR05MB6575.namprd05.prod.outlook.com (20.178.248.88) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.7; Tue, 9 Apr 2019 14:17:40 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
	([fe80::91e:292d:e304:78ad]) by MN2PR05MB6141.namprd05.prod.outlook.com
	([fe80::91e:292d:e304:78ad%7]) with mapi id 15.20.1792.009;
	Tue, 9 Apr 2019 14:17:40 +0000
To: "hch@lst.de" <hch@lst.de>
Subject: Re: revert dma direct internals abuse
Thread-Topic: revert dma direct internals abuse
Thread-Index: AQHU7fmi7IV/x30l7UexE5gP02MWCKYymy+AgAD+MwCAADQ1gIAAB6sAgAAMwgA=
Date: Tue, 9 Apr 2019 14:17:40 +0000
Message-ID: <466e658c73607fca5112d718972e87c0b78653ad.camel@vmware.com>
References: <20190408105525.5493-1-hch@lst.de>
	<7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
	<20190409095740.GE6827@lst.de>
	<5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
	<20190409133157.GA10876@lst.de>
In-Reply-To: <20190409133157.GA10876@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4a54a59-b8ca-4004-05d5-08d6bcf62033
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:MN2PR05MB6575; 
x-ms-traffictypediagnostic: MN2PR05MB6575:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR05MB6575D36135F1EA356410271CA12D0@MN2PR05MB6575.namprd05.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(366004)(199004)(189003)(54534003)(6246003)(305945005)(186003)(11346002)(81156014)(2501003)(105586002)(53936002)(446003)(486006)(2616005)(476003)(1730700003)(2351001)(5640700003)(6116002)(2906002)(3846002)(8676002)(6512007)(8936002)(7736002)(6916009)(102836004)(81166006)(106356001)(26005)(6306002)(6506007)(76176011)(71200400001)(71190400001)(118296001)(229853002)(5660300002)(256004)(45080400002)(68736007)(14444005)(966005)(6486002)(316002)(54906003)(86362001)(36756003)(25786009)(97736004)(99286004)(14454004)(93886005)(66066001)(6436002)(4326008)(478600001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR05MB6575;
	H:MN2PR05MB6141.namprd05.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: vmware.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iI6DhIXeC0WlDD1UjTUb/d9fnUJFFW8Va8y0HUDGa5IfwMXpLlsV6rtoNdU3LMzchLuxuk7W2GapEJ3nxbdu+2ht/Km0c+M3r53byfU+IQrL3DnupRv5JwPKtR3YszKEaYaSsWePSAZ5WxzTqZ6FL9TMIdgpNEW4K571W2V2gL7v/dzFYJNHdxRHqIvaBEKa8MWifK37cIzpVFiTsAmMoU6gQy1IL0mZESzOx7wFKZKER2tf5BA+7UDf6qSvGQ9o0aaW6gV/LWbir4/mzJMy+gVrm4C5xvrY3BdyXkXLyRTQWN0WkS4kUlVybU6rDVS1bgbYnMJ4EV3mKCYuMaPsNCcZAK/foWlKML/eRuVCtb7oRdqzLXE9nzlA6VVRncPJgcOiTMaDr1hTdRsq5ZjcnRBU6Xqg8LrR7CZGAraM1V0=
Content-ID: <EFF776B10FD27C4D84FB452D0A206EF9@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a54a59-b8ca-4004-05d5-08d6bcf62033
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 14:17:40.6234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6575
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
Message-ID: <20190409141740.Ud2eVAsl2w91qK0gJxS5k2K52YZan3HBdC6PaG_RQ_c@z>

On Tue, 2019-04-09 at 15:31 +0200, hch@lst.de wrote:
> On Tue, Apr 09, 2019 at 01:04:51PM +0000, Thomas Hellstrom wrote:
> > On the VMware platform we have two possible vIOMMUS, the AMD iommu
> > and
> > Intel VTD, Given those conditions I belive the patch is
> > functionally
> > correct. We can't cover the AMD case with intel_iommu_enabled.
> > Furthermore the only form of incoherency that can affect our
> > graphics
> > device is someone forcing SWIOTLB in which case that person would
> > be
> > happier with software rendering. In any case, observing the fact
> > that
> > the direct_ops are not used makes sure that SWIOTLB is not used.
> > Knowing that we're on the VMware platform, we're coherent and can
> > safely have the dma layer do dma address translation for us. All
> > this
> > information was not explicilty written in the changelog, no.
> 
> We have a series pending that might bounce your buffers even when
> using the Intel IOMMU, which should eventually also find its way
> to other IOMMUs:
> 
>     
> https://nam04.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.linuxfoundation.org%2Fpipermail%2Fiommu%2F2019-March%2F034090.html&amp;data=02%7C01%7Cthellstrom%40vmware.com%7C9933ee7b805842607ea908d6bcefc505%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C636904135345010687&amp;sdata=Px500%2B1FjL%2FZLedUdbAXz4a%2BT5DaZBFf6wnesTyFvZY%3D&amp;reserved=0

If that's the case, I think most of the graphics drivers will stop
functioning. I don't think people would want that, and even if the
graphics drivers are "to blame" due to not implementing the sync calls,
I think the work involved to get things right is impressive if at all
possible.

> 
> > In any case, assuming that that patch is reverted due to the
> > layering
> > violation, Are you willing to help out with a small API to detect
> > the
> > situation where streaming DMA is incoherent?
> 
> The short but sad answer is that we can't ever guarantee that you
> can skip the dma_*sync_* calls.  There are too many factors in play
> that might require it at any time - working around unaligned
> addresses
> in iommus, CPUs that are coherent for some device and not some,
> addressing
> limitations both in physical CPUs and VMs (see the various "secure
> VM"
> concepts floating around at the moment).
> 
> If you want to avoid the dma_*sync_* calls you must use
> dma_alloc_coherent to allocate the memory.  Note that the memory for
> dma_alloc_coherent actually comes from the normal page pool most of
> the time, and for certain on x86, which seems to be what you care
> about.  The times of it dipping into the tiny swiotlb pool are long
> gone.  So at least for you I see absolutely no reason to not simply
> always use dma_alloc_coherent to start with.  For other uses that
> involve platforms without DMA coherent devices like arm the tradeoffs
> might be a little different.

There are two things that concerns me with dma_alloc_coherent:

1) It seems to want pages mapped either in the kernel map or vmapped.
Graphics drivers allocate huge amounts of memory, Typically up to 50%
of system memory or more. In a 32 bit PAE system I'm afraid of running
out of vmap space as well as not being able to allocate as much memory
as I want. Perhaps a dma_alloc_coherent() interface that returns a page
rather than a virtual address would do the trick.

2) Exporting using dma-buf. A page allocated using dma_alloc_coherent()
for one device might not be coherent for another device. What happens
if I allocate a page using dma_alloc_coherent() for device 1 and then
want to map it using dma_map_page() for device 2?

Thanks,
Thomas



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
