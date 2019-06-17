Return-Path: <SRS0=Kmd8=UQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA09DC31E44
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 04:26:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2B02189F
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 04:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="RjfIwE86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2B02189F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5D34BBA4;
	Mon, 17 Jun 2019 04:26:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E4F42BA0
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 04:25:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
	(mail-eopbgr1400108.outbound.protection.outlook.com [40.107.140.108])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B43D37DB
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 04:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=mVBLrhLxN3rj2YawJzJpiyrCBOnRrTY927PRyDtmuV4=;
	b=RjfIwE86t4QF24zAT4BQ5BeniFxsF4T8+nNCQPXl77gln1mDRIVqnyzkXsPHwztui2wYdXH0mP3tuAzkMK1kiqtoj4GzVKyBE5pZje56jto1qDcGIMeR/IqgauIE9hCZEA1Uk7UEut3xc1HGDoKMp+RzMJXn0fUFBngcVhwoddE=
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com (20.178.97.80) by
	OSBPR01MB2902.jpnprd01.prod.outlook.com (52.134.255.16) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1987.12; Mon, 17 Jun 2019 04:25:55 +0000
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com
	([fe80::b1c2:125c:440d:e240]) by
	OSBPR01MB3590.jpnprd01.prod.outlook.com
	([fe80::b1c2:125c:440d:e240%4]) with mapi id 15.20.1987.014;
	Mon, 17 Jun 2019 04:25:55 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Wolfram Sang <wsa@the-dreams.de>
Subject: RE: [RFC PATCH v6 4/5] mmc: tmio: Use dma_max_mapping_size() instead
	of a workaround
Thread-Topic: [RFC PATCH v6 4/5] mmc: tmio: Use dma_max_mapping_size() instead
	of a workaround
Thread-Index: AQHVIdGm2I9J5403AkGhlbCnRkkrDqaZ/Y2AgAVHc3A=
Date: Mon, 17 Jun 2019 04:25:55 +0000
Message-ID: <OSBPR01MB35903578F49A50C64A9557CDD8EB0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<20190613194547.GD6863@kunai>
In-Reply-To: <20190613194547.GD6863@kunai>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50fb9265-cf99-4dc0-17c8-08d6f2dbe3e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:OSBPR01MB2902; 
x-ms-traffictypediagnostic: OSBPR01MB2902:
x-microsoft-antispam-prvs: <OSBPR01MB290251A391707EFF4922774CD8EB0@OSBPR01MB2902.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(229853002)(256004)(99286004)(6116002)(486006)(53936002)(71190400001)(4326008)(71200400001)(25786009)(3846002)(4744005)(66066001)(8936002)(66446008)(66946007)(66556008)(64756008)(81156014)(81166006)(8676002)(55016002)(6506007)(9686003)(76116006)(11346002)(52536014)(476003)(5660300002)(86362001)(26005)(66476007)(446003)(6246003)(73956011)(305945005)(54906003)(102836004)(186003)(76176011)(7736002)(33656002)(68736007)(478600001)(7416002)(74316002)(7696005)(6916009)(6436002)(316002)(14444005)(14454004)(2906002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:OSBPR01MB2902;
	H:OSBPR01MB3590.jpnprd01.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j8+49kK98RhW90gAPxMvMppeXZVjgNQs410LW7yZ7rltkkGLwhqDb+PjS59dGCl1fbn6iu4IhwffZANrnivaRLqauHJRBaDEfMIVDHqHnRHi8A6A0P8v/hX8UzgPDoS21k4iAE8eqoiQkyGPqke5OvXgruPEnaQlrAg9oGiB4vFO2pLhmycyNeJ+kJBAnzALkm7Vvlw9zhi4PLdiM24PhrEm3CI4ifaX6TTg53yZYC6EzwY53FZkl4Vswh08g+0BOsIAi7gEHuKv1DEG24uQymDueTxo1bxM/X5rSSMx9q7C0IUK+E8VvTW17mSf3g771TAbFQbwVQgNEo3fM3/G/3cSCBoM3InHRZG2tCbVTQ7zEwkdjuYwJ4pDs0Dk4NyQSmNy/ReiJfD+0crXtsVPVgAoUDmdusYV9E2AQ9V/Jgo=
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fb9265-cf99-4dc0-17c8-08d6f2dbe3e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 04:25:55.1961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2902
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
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

Hi Wolfram-san,

> From: Wolfram Sang, Sent: Friday, June 14, 2019 4:46 AM
> 
> On Thu, Jun 13, 2019 at 07:20:14PM +0900, Yoshihiro Shimoda wrote:
> > Since the commit 133d624b1cee ("dma: Introduce dma_max_mapping_size()")
> > provides a helper function to get the max mapping size, we can use
> > the function instead of the workaround code for swiotlb.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> I love it! I'd really like to see this code go away. Do I get this right
> that this patch is kinda independent of the reset of the series? Anyway:

Thank you for your suggestion! I think so (because IOMMU and block patches seem
to need update). I'll submit 3/5 and 4/5 patches as independent later.

> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thank you for your Acked-by!

Best regards,
Yoshihiro Shimoda

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
