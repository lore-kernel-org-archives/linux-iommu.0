Return-Path: <SRS0=Kmd8=UQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F27C31E44
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 06:29:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24994218C9
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 06:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="sygBfvZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24994218C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E7908C6E;
	Mon, 17 Jun 2019 06:29:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 077AEA5E
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 06:29:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
	(mail-eopbgr1400123.outbound.protection.outlook.com [40.107.140.123])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F23567DB
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 06:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Vko7yAWz5RpBME2huowP5ti6qs9L1iHfX7uWHTycylI=;
	b=sygBfvZcPBunr5s1KfsSBWBiuwdoV3v/nUxmH8Dqh3WAhyN2guPrC7wKAwZ6kBflafYRhPbc7NJg4R4UI4z4HpTM540d/IvVfdxHWraA6cEqRrD+tg698zBAUFmJ3WHFam25eTwDaWY0ObrPkoUFfGtkeJpq7LqtYJ8ntFsuM3U=
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com (20.178.97.80) by
	OSBPR01MB3253.jpnprd01.prod.outlook.com (52.134.251.205) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.13; Mon, 17 Jun 2019 06:29:31 +0000
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com
	([fe80::b1c2:125c:440d:e240]) by
	OSBPR01MB3590.jpnprd01.prod.outlook.com
	([fe80::b1c2:125c:440d:e240%4]) with mapi id 15.20.1987.014;
	Mon, 17 Jun 2019 06:29:31 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: RE: [RFC PATCH v6 3/5] block: add a helper function to merge the
	segments by an IOMMU
Thread-Topic: [RFC PATCH v6 3/5] block: add a helper function to merge the
	segments by an IOMMU
Thread-Index: AQHVIdGm9DzU/q+TZ0eYoDEn/dmDGqaa6rgAgAR7xQA=
Date: Mon, 17 Jun 2019 06:29:31 +0000
Message-ID: <OSBPR01MB3590A1AA199894E8220777EFD8EB0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<039d7388-ed24-c7e7-dd6a-656c719a5ed9@arm.com>
In-Reply-To: <039d7388-ed24-c7e7-dd6a-656c719a5ed9@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57dcdba1-60e8-46af-ac83-08d6f2ed280f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:OSBPR01MB3253; 
x-ms-traffictypediagnostic: OSBPR01MB3253:
x-microsoft-antispam-prvs: <OSBPR01MB325398BE878B761E8D1CFBFED8EB0@OSBPR01MB3253.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(979002)(346002)(136003)(39860400002)(366004)(376002)(396003)(199004)(189003)(11346002)(229853002)(53546011)(6436002)(66946007)(66556008)(14454004)(99286004)(8936002)(7696005)(68736007)(76176011)(7416002)(33656002)(55016002)(64756008)(8676002)(102836004)(6506007)(9686003)(66476007)(74316002)(7736002)(52536014)(81156014)(66446008)(6246003)(486006)(305945005)(2906002)(478600001)(5660300002)(73956011)(53936002)(26005)(4326008)(54906003)(186003)(25786009)(316002)(81166006)(14444005)(86362001)(71200400001)(256004)(3846002)(6116002)(66066001)(476003)(71190400001)(76116006)(446003)(6916009)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:OSBPR01MB3253;
	H:OSBPR01MB3590.jpnprd01.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ookrFj0YWkEdiesS1geCt9LmuXlc7koRNT9eyE3J3QY7PYbN4vLo5WX6+nxOuZBNRU43CyCk2+LT/Yr4p+FMmApcyUj0Nm4KtJd+InyBY/3pQ7QZiknmI0zfcBx3E80kluFqwCyn78qTfBaFGTRxudIZ42fIYsJ/Qznt70tWTnVz8t5xh9jhfC3+3cm3fR57hEkUUQdoaEQwEv4AqbGRvGIyzdFaSGG85K3MN2QFNK0+iJCKGz2ZxNTXgH7MWLYy5PZ/KD9V6/qqd8NU/gbXzf0xj99ARwKMR9umAa66JWM+yrBcHDenkpYWyFxa2dm3QJ8JyhoeGaKJ9/0b3Qjm+XYzcvTcdiAVEb+1lI3uCOuavdO7BL+4EjlcgnkAmeJ9BFKVA/6nH9I4HSMioM1I5ytI8ecVwTSV2vGffiKxGeI=
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dcdba1-60e8-46af-ac83-08d6f2ed280f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 06:29:31.1131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3253
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"hch@lst.de" <hch@lst.de>
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

Hi Robin,

> From: Robin Murphy, Sent: Friday, June 14, 2019 6:55 PM
> 
> On 13/06/2019 11:20, Yoshihiro Shimoda wrote:
<snip>
> > +bool blk_queue_can_use_iommu_merging(struct request_queue *q,
> > +				     struct device *dev)
> > +{
> > +	struct iommu_domain *domain;
> > +
> > +	/*
> > +	 * If the device DMA is translated by an IOMMU, we can assume
> > +	 * the device can merge the segments.
> > +	 */
> > +	if (!device_iommu_mapped(dev))
> 
> Careful here - I think this validates the comment I made when this
> function was introduced, in that that name doesn't necesarily mean what
> it sounds like it might mean - "iommu_mapped" was as close as we managed
> to get to a convenient shorthand for "performs DMA through an
> IOMMU-API-enabled IOMMU". Specifically, it does not imply that
> translation is *currently* active; if you boot with "iommu=pt" or
> equivalent this will still return true even though the device will be
> using direct/SWIOTLB DMA ops without any IOMMU translation.

Thank you for your comments. I understood the mean of "iommu_mapped" and
this patch's condition causes a problem on iommu=pt.
So, I'll add and additional condition like
"domain->type == IOMMU_DOMAIN_DMA" to check whether the translation is
currently active on the domain or not.

Best regards,
Yoshihiro Shimoda

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
