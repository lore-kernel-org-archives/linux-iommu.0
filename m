Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457C5C282E1
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 12:26:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13076214AE
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 12:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="KgiT7EwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13076214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3B3E811BA;
	Tue, 23 Apr 2019 12:26:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C049211A1
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 12:26:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr690077.outbound.protection.outlook.com [40.107.69.77])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 490C582B
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 12:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=kck8DemmQ9/yxr0ZunbSvB4VNBMZK6t3Tj3gnwaMuT0=;
	b=KgiT7EwMbCPsxjkqTWcpDnbd/sXtcK9WVL42mwrYOb65AIdb0VoFtfqjTm61v3/SROvlmuFK5c179vvtVt6V8dcDk0xvVo2ji8Sdgg7B3olkuAsOAIdoii9N7KsgTDAbaa242svTVIMvvCkKSh/tMDDaw/V/3dLy1tpUUWzCejg=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
	MN2PR05MB6494.namprd05.prod.outlook.com (20.178.246.92) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.7; Tue, 23 Apr 2019 12:26:05 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
	([fe80::441b:ef64:e316:b294]) by
	MN2PR05MB6141.namprd05.prod.outlook.com
	([fe80::441b:ef64:e316:b294%5]) with mapi id 15.20.1835.010;
	Tue, 23 Apr 2019 12:26:05 +0000
To: "hch@lst.de" <hch@lst.de>
Subject: Re: revert dma direct internals abuse
Thread-Topic: revert dma direct internals abuse
Thread-Index: AQHU7fmi7IV/x30l7UexE5gP02MWCKYymy+AgAD+MwCAADQ1gIAAB6sAgAAMwgCAABMAAIAAIUkAgADfTYCAAIrrAIATDOyAgAE2CwA=
Date: Tue, 23 Apr 2019 12:26:05 +0000
Message-ID: <a5643cb106797f7079c70d63f5031bdc01259bb0.camel@vmware.com>
References: <20190408105525.5493-1-hch@lst.de>
	<7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
	<20190409095740.GE6827@lst.de>
	<5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
	<20190409133157.GA10876@lst.de>
	<466e658c73607fca5112d718972e87c0b78653ad.camel@vmware.com>
	<20190409152538.GA12816@lst.de>
	<da06614b308500392c179651ef9c6fb835ee4045.camel@vmware.com>
	<20190410064359.GC5543@lst.de>
	<0c897b24b234f8d42ef597dbe31fa8293519a4b2.camel@vmware.com>
	<20190422175623.GA32411@lst.de>
In-Reply-To: <20190422175623.GA32411@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d358cf3-d450-4b97-fad1-08d6c7e6db6d
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:MN2PR05MB6494; 
x-ms-traffictypediagnostic: MN2PR05MB6494:
x-microsoft-antispam-prvs: <MN2PR05MB6494DD1A54852D6EDF7E3561A1230@MN2PR05MB6494.namprd05.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(136003)(39860400002)(366004)(396003)(376002)(346002)(189003)(199004)(2616005)(478600001)(14454004)(54906003)(76176011)(316002)(5660300002)(93886005)(2906002)(81166006)(8936002)(229853002)(6436002)(256004)(2501003)(8676002)(6116002)(6486002)(3846002)(6512007)(81156014)(6916009)(68736007)(1730700003)(118296001)(66066001)(53936002)(305945005)(6246003)(25786009)(5640700003)(66446008)(4744005)(97736004)(76116006)(4326008)(99286004)(73956011)(486006)(36756003)(6506007)(86362001)(102836004)(476003)(2351001)(11346002)(7736002)(26005)(71190400001)(186003)(71200400001)(446003)(66946007)(66476007)(64756008)(66556008)(91956017);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR05MB6494;
	H:MN2PR05MB6141.namprd05.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: vmware.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XK2rCq/bwv17lAZ+tqBjKgaLQsBC79MLwDqvBQau3CsroFNp8lQ6XesK30G/pmp6YT2ztdrmhmPPKHOv6KHt09eRr3PtUT/AR8XNzqD6D/+DWDXthwOAAlnNxWy1ZvkfQm4RZsL1LkbkT9j7oU0nBTSnErdA+2q1wKd1S3guAd6gQBgr2hC7SVumcpvYL7KeBHwejR5etkIt90hKOgd+5MmGjLziaatMQcko/eJgld9IXnvV9Fn4AYvEjZxyMhH2TXqPVl/YpqIcjR4v1/eUN2RXCmzRI1n8uh6mO7Ga+9Hg4S1eNKeuPhAHLvFx8fOgHk8s7U4Vl1s49J9A7NnfqssLhEtZbXBEXDWJk+jzAwXGToTMyeS46BO56CCnR5JMl554NsUXt1WEvULCAe8iZE2T4LwwH6aiQyROUCWVUF8=
Content-ID: <115D6E66AC3ABA42801EEC939502B6AF@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d358cf3-d450-4b97-fad1-08d6c7e6db6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 12:26:05.4995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6494
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
Message-ID: <20190423122605.KUvVVYDsQIL168TNIyEQEObBtxfZU0hZmo_aJ0_jL1E@z>

Hi, Christoph,

On Mon, 2019-04-22 at 19:56 +0200, hch@lst.de wrote:
> On Wed, Apr 10, 2019 at 03:01:14PM +0000, Thomas Hellstrom wrote:
> > > So can you please respin a version acceptable to you and submit
> > > it
> > > for 5.1 ASAP?  Otherwise I'll need to move ahead with the simple
> > > revert.
> > 
> > I will. 
> > I need to do some testing to investigate how to best choose between
> > the
> > options, but will have something ready for 5.1.
> 
> I still don't see anything in -rc6..

Been on easter vacation. I have a patch ready for review, though, will
send it out in a moment.

It turns out that to do something well-behaved in case someone sets
swiotlb=force, the variable swiotlb_force would need to be exported.
(I can't rely on swiotlb_nr_tbl()).

That's not currently done in the patch, but instead the driver just
malfunctions like most other graphics drivers.

/Thomas

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
