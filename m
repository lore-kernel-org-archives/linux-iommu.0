Return-Path: <SRS0=pxo5=UG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E86C2BCA1
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 12:05:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF802089E
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 12:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="l4BW6/J0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF802089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DF03F1124;
	Fri,  7 Jun 2019 12:05:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A044F1118
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 12:04:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
	(mail-eopbgr1410111.outbound.protection.outlook.com [40.107.141.111])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 257337F8
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 12:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=x1QtP2y3RnZowpIpOtByrCE5FxuGznrF064EoJ9njNE=;
	b=l4BW6/J0RWlyQGEthEIbmrYC1az7p00Ps0GPzDbtRnTqlz6RKTXHhtEDKkNssOADAAbJCzKAUBWQjSGnbncRc02C6bgZYG+S4FxxUFmuLEdRcvxBIF0s6yZ8Kkhv7pFAPxyAp5npYXaLKYLWld3M4Aey+8mn6gI61++m51LvyP8=
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com (52.134.247.150) by
	OSAPR01MB3137.jpnprd01.prod.outlook.com (52.134.249.18) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.15; Fri, 7 Jun 2019 12:04:17 +0000
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com
	([fe80::19ad:b6ce:a287:dc85]) by
	OSAPR01MB3089.jpnprd01.prod.outlook.com
	([fe80::19ad:b6ce:a287:dc85%7]) with mapi id 15.20.1965.011;
	Fri, 7 Jun 2019 12:04:17 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH] Documentation: DMA-API: fix a function name of
	max_mapping_size
Thread-Topic: [PATCH] Documentation: DMA-API: fix a function name of
	max_mapping_size
Thread-Index: AQHVHQX28aIqCA/T0kKXQB70i48QjqaP1kMAgAACTBCAAAUfgIAAOh3w
Date: Fri, 7 Jun 2019 12:04:17 +0000
Message-ID: <OSAPR01MB3089F8522C11A80E4FB38933D8100@OSAPR01MB3089.jpnprd01.prod.outlook.com>
References: <1559893633-6852-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<20190607080814.GA10303@lst.de>
	<TYAPR01MB3102C6CCC204DAAA6570FD25D8100@TYAPR01MB3102.jpnprd01.prod.outlook.com>
	<20190607083447.GA10860@lst.de>
In-Reply-To: <20190607083447.GA10860@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f10c3bf-abdd-4f25-b2d5-08d6eb40446b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:OSAPR01MB3137; 
x-ms-traffictypediagnostic: OSAPR01MB3137:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <OSAPR01MB313799D854033FCD0939A808D8100@OSAPR01MB3137.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(376002)(39860400002)(346002)(396003)(366004)(199004)(189003)(86362001)(64756008)(66446008)(256004)(14444005)(74316002)(3846002)(6116002)(305945005)(54906003)(66556008)(966005)(6306002)(9686003)(99286004)(66476007)(7696005)(76176011)(6436002)(52536014)(6916009)(4744005)(55016002)(14454004)(76116006)(71190400001)(66946007)(71200400001)(73956011)(5660300002)(478600001)(2906002)(446003)(476003)(11346002)(33656002)(486006)(25786009)(6246003)(53936002)(316002)(102836004)(66066001)(6506007)(8676002)(81166006)(81156014)(186003)(68736007)(26005)(8936002)(4326008)(7736002)(229853002)(6606295002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:OSAPR01MB3137;
	H:OSAPR01MB3089.jpnprd01.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l0R9ahB6JcaRybmNLe/KgRU4wQBirDQxqZVfkrUAFxt01SLhlcowZv4NOei55GE/pIZI6scZZqlcC2RKrRHmt1fC76ifQjrQskyC2Ud+2uX9iSxwerHMrsx/rOD/+Cp47pUaP9HHGHaAyzcKBy15hE6w0i9SR+2E3aM9fsK0HPcJ1U/yMAHeRUtiRJG7nOrcnk3aD5hQevBj5oe5lVb8vosw02XXGadfomQwpIS+7KCJtu4GPbivjo3jrNdWfC0TtcWrE2wj5h+YUbSE91LkLHMXTchQKxvituzG/V37LWOwLLFX4r8/jTsduIjFIONOreMYp3YpB1bJtKKb8jBMD/Ie7FOncYqoXq1sac5IncMtpFKxUie4kBnHKrYPW8E29+lE2PzOmH26l130MznO6scesYSbwS3eQrENH9FwMRY=
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f10c3bf-abdd-4f25-b2d5-08d6eb40446b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 12:04:17.6147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3137
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"jroedel@suse.de" <jroedel@suse.de>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>
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

> From: Christoph Hellwig, Sent: Friday, June 7, 2019 5:35 PM
> 
> On Fri, Jun 07, 2019 at 08:19:08AM +0000, Yoshihiro Shimoda wrote:
> > Hi Christoph,
> >
> > > From: Christoph Hellwig, Sent: Friday, June 7, 2019 5:08 PM
> > >
> > > Looks good.  And it seems like you've also found the solution to
> > > your usb storage problem, but I'm going to post the variant I just
> > > hacked up nevertheless.
> >
> > Thank you for your reply! I think this API is related to my problem,
> > but I don't have any actual solution (a patch) for now. So, I'll wait
> > for your patch!
> 
> Turns out it isn't as simple as I thought, as there doesn't seem to
> be an easy way to get to the struct device used for DMA mapping
> from USB drivers.  I'll need to think a bit more how to handle that
> best.

Thank you for your reply. I sent an email on the original report as below.
https://marc.info/?l=linux-block&m=155990883224615&w=2

Best regards,
Yoshihiro Shimoda

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
