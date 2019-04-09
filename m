Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B04C10F0E
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 13:04:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07712084F
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 13:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="QuL32gr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07712084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C06E8F69;
	Tue,  9 Apr 2019 13:04:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F3297F4F
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 13:04:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
	(mail-eopbgr740071.outbound.protection.outlook.com [40.107.74.71])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 48A5C735
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 13:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=C41PUBBcnnR9YA3IKjd7xBvEj7wdobq/pnqIXKF20sk=;
	b=QuL32gr5KzRwGqH9X+UyGDJ469QQR1zxpwRMr3Y1oyiPuX0SFm2gK0/aLYTXXHM98hz2y3DkPssJjaX4M3na6QiK0jksof+P7Wrmg+R90ZNsKqDGFQFiK4RuMp3Lek2ACvYynvwMw37nZxNWcbtdSoJ6H0WvABh7/f3MBv1rvek=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
	MN2PR05MB6030.namprd05.prod.outlook.com (20.178.241.159) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.8; Tue, 9 Apr 2019 13:04:52 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
	([fe80::91e:292d:e304:78ad]) by MN2PR05MB6141.namprd05.prod.outlook.com
	([fe80::91e:292d:e304:78ad%7]) with mapi id 15.20.1792.009;
	Tue, 9 Apr 2019 13:04:51 +0000
To: "hch@lst.de" <hch@lst.de>
Subject: Re: revert dma direct internals abuse
Thread-Topic: revert dma direct internals abuse
Thread-Index: AQHU7fmi7IV/x30l7UexE5gP02MWCKYymy+AgAD+MwCAADQ1gA==
Date: Tue, 9 Apr 2019 13:04:51 +0000
Message-ID: <5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
References: <20190408105525.5493-1-hch@lst.de>
	<7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
	<20190409095740.GE6827@lst.de>
In-Reply-To: <20190409095740.GE6827@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0730120-209b-40a6-b92c-08d6bcebf433
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:MN2PR05MB6030; 
x-ms-traffictypediagnostic: MN2PR05MB6030:
x-microsoft-antispam-prvs: <MN2PR05MB60301B836146E453BF743C32A12D0@MN2PR05MB6030.namprd05.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(136003)(346002)(366004)(39860400002)(396003)(376002)(189003)(199004)(54534003)(66066001)(97736004)(305945005)(256004)(14444005)(68736007)(106356001)(105586002)(2351001)(7736002)(1730700003)(8676002)(36756003)(2501003)(8936002)(81166006)(86362001)(81156014)(6506007)(99286004)(476003)(5640700003)(6486002)(2616005)(316002)(71200400001)(446003)(229853002)(6436002)(76176011)(6916009)(5660300002)(71190400001)(11346002)(2906002)(486006)(118296001)(478600001)(14454004)(102836004)(53936002)(6512007)(186003)(26005)(6246003)(4326008)(3846002)(6116002)(25786009)(54906003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR05MB6030;
	H:MN2PR05MB6141.namprd05.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: vmware.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N89MSUIDAdhlBnHARM6Ca3nGYKHxeis2+F8Ap8rrHWeZVOJkTt6OAAH1ve+aMGB4Ov1PKigv5VTNyGjACHKxbw7wSpozRtLatdtLRf8q94Yd20Ixlf28V34gQIA2rqvtIrYXfNRo235nJlNbC+1wcQLU//aCVSVlDwK6qBrRIgYsCzXhcwVicE9yuBc+5+3ZxlHxZZNKoChP2+3xAnq+50Hea8hIP8IzkIklCS8AO9PCOwlYDl0xX4IiPYi9S83ovcqTDXmXC5449k99aKB9Vo7p2gSF5SVqbLkFQuGrH5wRI6Sl+jshV6w9II1fc8syo/e8ZlCm0PkyrPyJERMOLpFZe62jHvInKzVOAx3KyR9nX3uW2RYhFZo2L+PYWrtRFfQXpZ4o66EjZvDACEY9WzAi7fOGF4cW4BQEDeh8n4M=
Content-ID: <490CD89E2D46FA4C8C1C0C92F9FEC9BF@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0730120-209b-40a6-b92c-08d6bcebf433
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 13:04:51.7739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6030
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
Message-ID: <20190409130451.NLDvpVeWGjxSjoH3TjQa86LdEYBw6fy_Gl_c31EH7t0@z>

On Tue, 2019-04-09 at 11:57 +0200, hch@lst.de wrote:
> On Mon, Apr 08, 2019 at 06:47:52PM +0000, Thomas Hellstrom wrote:
> > We HAVE discussed our needs, although admittedly some of my emails
> > ended up unanswered.
> 
> And than you haven't followed up, and instead ignored the layering
> instructions and just commited a broken patch?

Yes, I'm really sorry for not observing the layering instructions. To
be completely honest I didn't observe that layering warning, rather
than ignoring it. The patch doesn't claim to be generic and I believe
that on the VMware platform it is functionally correct, please see
below. I also would like not to focus on who did what and why. I can't
see how that will help this discussion moving forward.

> 
> > We've as you're well aware of had a discussion with the other
> > subsystems doing user-space DMA-buffers wanting this functionality
> > from
> > the dma api (AMD graphics and RDMA people IIRC). that is a bool
> > that
> > tells us whether streaming dma mappings are coherent, and I
> > described
> > in detail why we couldn't use the dma_sync_* API and
> > dma_alloc_coherent().
> 
> And that is not at all what you either check or claim to do in the
> changelog (which btw, are two different things).
> 
> > The other option we have is to just fail miserably without messages
> > if
> > streaming DMA is not coherent, which I think the other drivers
> > might
> > do... That's all I'm trying to avoid here. I'd much prefer to have
> > the
> > dma API export this bool.
> 
> Both DMA direct and non-DMA direct streaming mappings can be either
> coherent or incoherent, so your patch doesn't archive that.  The
> commit log claims the following:
> 
> "drm/vmwgfx: Improve on IOMMU detection
>     
>  instead of relying on intel_iommu_enabled, use the fact that the
>  dma_map_ops::map_page != dma_direct_map_page"
> 
> which has nothing to do with the fact that streaming mappings are
> coherent.  It also is incorrect as there are direct mapping that
> do not use dma_direct_map_page (e.g. on ARM, or x86 with VMD).

On the VMware platform we have two possible vIOMMUS, the AMD iommu and
Intel VTD, Given those conditions I belive the patch is functionally
correct. We can't cover the AMD case with intel_iommu_enabled.
Furthermore the only form of incoherency that can affect our graphics
device is someone forcing SWIOTLB in which case that person would be
happier with software rendering. In any case, observing the fact that
the direct_ops are not used makes sure that SWIOTLB is not used.
Knowing that we're on the VMware platform, we're coherent and can
safely have the dma layer do dma address translation for us. All this
information was not explicilty written in the changelog, no.


In any case, assuming that that patch is reverted due to the layering
violation, Are you willing to help out with a small API to detect the
situation where streaming DMA is incoherent?

/Thomas


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
