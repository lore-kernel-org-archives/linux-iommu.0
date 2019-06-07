Return-Path: <SRS0=pxo5=UG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E721BC28CC3
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 05:42:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD40208C0
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 05:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="eQtbGksG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD40208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6D7CBE1F;
	Fri,  7 Jun 2019 05:42:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7742FE1E
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 05:42:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
	(mail-eopbgr1410111.outbound.protection.outlook.com [40.107.141.111])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 772B8A9
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 05:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=A3EOvjLTGDd9vxBbzyy0wg1TKtuboU1uyCkbH/jtKk8=;
	b=eQtbGksGML4ZcZ8abnlJep20ui+yLGrjyJV43A2vyfmFzo+hAS7l1S1OJw2YashwPLuASBREDI6lKdjTQYi3vHrtGyVOF+qBH+7OUTGdUle+mMRx8dbMxru1rRMX0m2l65cR2AjnYZR+LyrqpeCjY5YLwSVpnE4xqMveSCmvjNM=
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com (52.134.247.150) by
	OSAPR01MB2850.jpnprd01.prod.outlook.com (52.134.246.150) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.14; Fri, 7 Jun 2019 05:41:56 +0000
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com
	([fe80::19ad:b6ce:a287:dc85]) by
	OSAPR01MB3089.jpnprd01.prod.outlook.com
	([fe80::19ad:b6ce:a287:dc85%7]) with mapi id 15.20.1943.023;
	Fri, 7 Jun 2019 05:41:56 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
Thread-Topic: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
Thread-Index: AQHVG5AuSNIEYbUj60Sza33KteoVlaaM+2qAgAAEhACAASFw4IAAErKAgAFoAcA=
Date: Fri, 7 Jun 2019 05:41:56 +0000
Message-ID: <OSAPR01MB3089E3E79B0BDF24610FBEC2D8100@OSAPR01MB3089.jpnprd01.prod.outlook.com>
References: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<7dfeb7d8-b777-b4af-d892-2829cd05241b@arm.com>
	<20190605123808.GA12529@lst.de>
	<OSAPR01MB3089448A3D44BE61B127AA73D8170@OSAPR01MB3089.jpnprd01.prod.outlook.com>
	<20190606070059.GI27033@lst.de>
In-Reply-To: <20190606070059.GI27033@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.142]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8836f55e-3ad4-4b05-fa53-08d6eb0ada9f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:OSAPR01MB2850; 
x-ms-traffictypediagnostic: OSAPR01MB2850:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <OSAPR01MB285036A5A52D44AFDEC9CE5BD8100@OSAPR01MB2850.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(6306002)(33656002)(53936002)(66066001)(86362001)(6436002)(14454004)(2906002)(71190400001)(478600001)(256004)(71200400001)(966005)(68736007)(6916009)(14444005)(25786009)(52536014)(476003)(74316002)(9686003)(55016002)(486006)(446003)(6506007)(76176011)(26005)(11346002)(186003)(73956011)(66446008)(64756008)(66556008)(66476007)(54906003)(229853002)(66946007)(5660300002)(99286004)(7696005)(3846002)(76116006)(6116002)(6246003)(4326008)(8936002)(81156014)(81166006)(305945005)(8676002)(7736002)(102836004)(316002)(6606295002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:OSAPR01MB2850;
	H:OSAPR01MB3089.jpnprd01.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6VFV+41doyYXdeY2hiN2Ht3MeK6m7hbo2WV2hVBlakxgl5Nv4xhYHXSCsboayPwEIQ1CavJpDOlch9VMCpJ68k8zcSYoPvwDwdZdA4QWupPUx2/e89RRNmvU+Sd8/XetjWqTKvKT62QRE8348EkVoLCmcOkvdybU/dkIbxcU9IX6nf3259yLEoPATsHID7mgBogvwG56nGhjwZRLpCT5OTos5c0BL1EQLTyZ241YR9tsiYHU3V/rNySiAG2l5aIKLEVQsvS9s/clbssDKp4ymBUn8xsMFCFH6BX9Y2jtA+pa1sYF9npfVS2IfKNm1KYPlO15vN0+FZnRkOCzrkwCvTYhkfoeO5s4UiLbTQyNGZ3YFYA9bJQBc72mXxKvni9RQk5r7suu4J0a3uON7ef6QuEcKSjOeiwwagTCWuH3JY0=
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8836f55e-3ad4-4b05-fa53-08d6eb0ada9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 05:41:56.7792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2850
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Christoph,

> From: Christoph Hellwig, Sent: Thursday, June 6, 2019 4:01 PM
> 
> On Thu, Jun 06, 2019 at 06:28:47AM +0000, Yoshihiro Shimoda wrote:
> > > The problem is that we need a way to communicate to the block layer
> > > that more than a single segment is ok IFF the DMA API instance supports
> > > merging.  And of course the answer will depend on futher parameters
> > > like the maximum merged segment size and alignment for the segement.
> >
> > I'm afraid but I don't understand why we need a way to communicate to
> > the block layer that more than a single segment is ok IFF the DMA API
> > instance supports merging.
> 
> Assume a device (which I think is your case) that only supports a single
> segment in hardware.  In that case we set max_segments to 1 if no
> IOMMU is present.  But if we have a merge capable IOMMU we can set
> max_segments to unlimited (or some software limit for scatterlist
> allocation), as long as we set a virt_boundary matching what the IOMMU
> expects, and max_sectors_kb isn't larger than the max IOMMU mapping
> size.  Now we could probably just open code this in the driver, but
> I'd feel much happier having a block layer like this:

Thank you for the explanation in detail!

> bool blk_can_use_iommu_merging(struct request_queue *q, struct device *dev)
> {
> 	if (!IOMMU_CAN_MERGE_SEGMENTS(dev))
> 		return false;

As Robin mentioned, all IOMMUs can merge segments so that we don't need
this condition, IIUC. However, this should check whether the device is mapped
on iommu by using device_iommu_mapped().

> 	blk_queue_virt_boundary(q, IOMMU_PAGE_SIZE(dev));
> 	blk_queue_max_segment_size(q, IOMMU_MAX_SEGMENT_SIZE(dev));

By the way, I reported an issue [1] and I'm thinking dima_is_direct() environment
(especially for swiotlb) is also needed such max_segment_size changes somehow.
What do you think?

[1]
https://marc.info/?l=linux-block&m=155954415603356&w=2

> 	return true;
> }
> 
> and the driver then does:
> 
> 	if (blk_can_use_iommu_merging(q, dev)) {
> 		blk_queue_max_segments(q, MAX_SW_SEGMENTS);
> 		// initialize sg mempool, etc..
> 	}

In this case, I assume that "the driver" is ./drivers/mmc/core/queue.c,
not any drivers/mmc/host/ code.

> Where the SCREAMING pseudo code calls are something we need to find a
> good API for.

I assumed
 - IOMMU_PAGE_SIZE(dev) = dma_get_seg_boundary(dev);
 - IOMMU_MAX_SEGMENT_SIZE(dev) = dma_get_max_seg_size(dev);

I could not find "IOMMU_PAGE_SIZE(dev))" for now.
If it's true, I'll add such a new API.

> And thinking about it the backend doesn't need to be an iommu, swiotlb
> could handle this as well, which might be interesting for devices
> that need to boune buffer anyway.  IIRC mmc actually has some code
> to copy multiple segments into a bounce buffer somewhere.

I see. So, as I mentioned above, this seems that swiotlb is also needed.
IIUC, now mmc doesn't have a bounce buffer from the commit [2].

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/core?h=v5.2-rc3&id=de3ee99b097dd51938276e3af388cd4ad0f2750a

> > The block layer already has a limit "max_segment_size" for each device so that
> > regardless it can/cannot merge the segments, we can use the limit.
> > Is my understanding incorrect?
> 
> Yes.

Now I understand that block layer's max_segment_size differs with IOMMU's one.

Best regards,
Yoshihiro Shimoda

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
