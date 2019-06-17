Return-Path: <SRS0=Kmd8=UQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CD7C31E44
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 06:54:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5DC2189F
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 06:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="n/Xt2/Pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5DC2189F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 75360C6F;
	Mon, 17 Jun 2019 06:54:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B505A2F
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 06:54:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
	(mail-eopbgr1410124.outbound.protection.outlook.com [40.107.141.124])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 317562C3
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 06:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=enhWT74/cCvJF0nC6N6Nkz9H+M7tE6bXm/KQF0zE/7I=;
	b=n/Xt2/PtgIDInZNQITAgCkcX26JHzjc0hkzuq+Fx9hSm2SSA0k8IWt6njnrt8WBV7rNRCgCP+kg1dQpKfcJg46igRqDmxnmeX2ugNwtv1buFu8RuJhqnywVhKn8HWWKlJYIkwMrHPPVts+OnETQBkgWdcl2jGjo9lmXqfDnnJoQ=
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com (20.178.97.80) by
	OSBPR01MB2134.jpnprd01.prod.outlook.com (52.134.243.11) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1987.13; Mon, 17 Jun 2019 06:54:31 +0000
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com
	([fe80::b1c2:125c:440d:e240]) by
	OSBPR01MB3590.jpnprd01.prod.outlook.com
	([fe80::b1c2:125c:440d:e240%4]) with mapi id 15.20.1987.014;
	Mon, 17 Jun 2019 06:54:31 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [RFC PATCH v6 4/5] mmc: tmio: Use dma_max_mapping_size() instead
	of a workaround
Thread-Topic: [RFC PATCH v6 4/5] mmc: tmio: Use dma_max_mapping_size() instead
	of a workaround
Thread-Index: AQHVIdGm2I9J5403AkGhlbCnRkkrDqaaC4IAgACzcgCAAAKLAIAEhNUQgAAgXgCAAAgYEA==
Date: Mon, 17 Jun 2019 06:54:31 +0000
Message-ID: <OSBPR01MB3590218F1CA8CEE5DCB53065D8EB0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<CAMuHMdXYqgPRX1WfUTRsKHhnSok5vfnr4AY36=vXoUvAxcNyWQ@mail.gmail.com>
	<20190614071800.GB8420@lst.de>
	<CAMuHMdXm5RtDUL5Wkyd6aJihu9nykYOhRf7vN6hOtB-OO8CTQQ@mail.gmail.com>
	<OSBPR01MB3590D4EF069F4554DA5D7ABBD8EB0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
	<CAMuHMdWPUZGFWeKzPK=zkwc5h2SD+aW6ULb8C2rDJSmTWNXjeA@mail.gmail.com>
In-Reply-To: <CAMuHMdWPUZGFWeKzPK=zkwc5h2SD+aW6ULb8C2rDJSmTWNXjeA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c698aa4-6fec-4fcb-e07b-08d6f2f0a61f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:OSBPR01MB2134; 
x-ms-traffictypediagnostic: OSBPR01MB2134:
x-microsoft-antispam-prvs: <OSBPR01MB213416C684FD4E44E21ECFDED8EB0@OSBPR01MB2134.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(979002)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(2906002)(66066001)(305945005)(7736002)(5660300002)(74316002)(4326008)(6436002)(229853002)(52536014)(6916009)(54906003)(71200400001)(71190400001)(476003)(316002)(486006)(68736007)(76176011)(66446008)(64756008)(7416002)(11346002)(81166006)(81156014)(8936002)(446003)(256004)(6506007)(53546011)(478600001)(26005)(7696005)(6116002)(99286004)(76116006)(66946007)(186003)(14454004)(66476007)(66556008)(8676002)(6246003)(102836004)(86362001)(33656002)(3846002)(55016002)(53936002)(73956011)(9686003)(25786009)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:OSBPR01MB2134;
	H:OSBPR01MB3590.jpnprd01.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5ducfu4Ew1x2Y+uk6LN7poEQhg0GmkXwPQBepJCt4croP5CVp9bsbOLBH+5HlTYzo7WJ334hoXu1e/MicmB/p6XZad0PEmttKxNnwtYMAPWQvy/l94GzsTCAcwc9chQfK5TpDWZhS3uRetWCHRa86Vj2t5a8IppxsQvaHkjqADM3EK6Kzu08iXHw/UABsT+PCnODJe9ycoYyt6OW7bgVvkiSexd+fmmjR6QGWsKaiwCsfbD+p6uL1xlCF2d74zVM6pqcJSvhCgRYr0uqUdJHCx1sxZ/k9sLW5sKEPo/60rYbWjxT9t0iF3yv3KpFXlxaaV3RdH2DoR0mjODIXcw9/smaD5/FIo9ZEr3kU6L4UgHyV47Zfxkwb+qY8skGbaCpFf+a1dpavUu2ZrFa/BNML+7vjtCFJSusRNfR3H+oSkk=
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c698aa4-6fec-4fcb-e07b-08d6f2f0a61f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 06:54:31.1514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2134
Cc: Jens Axboe <axboe@kernel.dk>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linux MMC List <linux-mmc@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
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

Hi Geert-san,

> From: Geert Uytterhoeven, Sent: Monday, June 17, 2019 3:23 PM
> 
> Hi Shimoda-san,
> 
> On Mon, Jun 17, 2019 at 6:54 AM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > From: Geert Uytterhoeven, Sent: Friday, June 14, 2019 4:27 PM
> > > On Fri, Jun 14, 2019 at 9:18 AM Christoph Hellwig wrote:
> > > > On Thu, Jun 13, 2019 at 10:35:44PM +0200, Geert Uytterhoeven wrote:
<snip>
> > > > This really should use a min_t on size_t.  Otherwise the patch looks
> > > > fine:
> > >
> > > Followed by another min() to make it fit in mmc->max_req_size, which is
> > > unsigned int.
> >
> > Geert-san:
> >
> > I'm afraid, but I cannot understand this means.
> > Is this patch is possible to be upstream? Or, do you have any concern?
> 
> Please disregard my last comment: as the value of "mmc->max_blk_size *
> mmc->max_blk_count" is always 0xffff_ffff or less, "min_t(size_t,
> mmc->max_blk_size * mmc->max_blk_count, dma_max_mapping_size(&pdev->dev))"
> will always be 0xffff_ffff or less, too, so there is no extra step needed
> to make it fit in mmc->max_req_size.

Thank you for your prompt reply! I understood it.

> Sorry for the confusion.

No worries.

Best regards,
Yoshihiro Shimoda

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
