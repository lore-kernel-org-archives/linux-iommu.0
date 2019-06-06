Return-Path: <SRS0=1Id5=UF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9B4C28D1A
	for <iommu@archiver.kernel.org>; Thu,  6 Jun 2019 06:28:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508212070B
	for <iommu@archiver.kernel.org>; Thu,  6 Jun 2019 06:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="N0tF6kXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508212070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0BCEFAD1;
	Thu,  6 Jun 2019 06:28:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2DE982F
	for <iommu@lists.linux-foundation.org>;
	Thu,  6 Jun 2019 06:28:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
	(mail-eopbgr1400134.outbound.protection.outlook.com [40.107.140.134])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7F8EA34F
	for <iommu@lists.linux-foundation.org>;
	Thu,  6 Jun 2019 06:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=6mrscffEdaONOt18iWr+6AmSys1rpIqcdDsa9pp8H9Q=;
	b=N0tF6kXdtFeVfukjtlKsjfgbxb1Td5ua1zRED0cnijUy8zypu6MgUFotdJcKSK6rQOhoG40cXoUwHrDVCOZas3VwPCDiwYrUQtna+TXYXWsVtpKyn+K/zYoPljx/L++I0uJ7VfEaCLv5rzpEUpfCHcQf3qdl5tZoAaBi9be0gSQ=
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com (52.134.247.150) by
	OSAPR01MB4241.jpnprd01.prod.outlook.com (20.178.128.75) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.22; Thu, 6 Jun 2019 06:28:47 +0000
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com
	([fe80::19ad:b6ce:a287:dc85]) by
	OSAPR01MB3089.jpnprd01.prod.outlook.com
	([fe80::19ad:b6ce:a287:dc85%7]) with mapi id 15.20.1943.018;
	Thu, 6 Jun 2019 06:28:47 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
Thread-Topic: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
Thread-Index: AQHVG5AuSNIEYbUj60Sza33KteoVlaaM+2qAgAAEhACAASFw4A==
Date: Thu, 6 Jun 2019 06:28:47 +0000
Message-ID: <OSAPR01MB3089448A3D44BE61B127AA73D8170@OSAPR01MB3089.jpnprd01.prod.outlook.com>
References: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<7dfeb7d8-b777-b4af-d892-2829cd05241b@arm.com>
	<20190605123808.GA12529@lst.de>
In-Reply-To: <20190605123808.GA12529@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c728d5bd-20b8-4dfb-1cd5-08d6ea483b9e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:OSAPR01MB4241; 
x-ms-traffictypediagnostic: OSAPR01MB4241:
x-microsoft-antispam-prvs: <OSAPR01MB42412BB13DFA8C0320A15403D8170@OSAPR01MB4241.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(199004)(189003)(305945005)(14454004)(229853002)(76116006)(74316002)(6116002)(26005)(66476007)(64756008)(66446008)(3846002)(476003)(7736002)(33656002)(486006)(25786009)(55016002)(6436002)(53936002)(9686003)(86362001)(478600001)(11346002)(8936002)(81166006)(8676002)(81156014)(446003)(102836004)(66946007)(66556008)(73956011)(2906002)(71190400001)(4326008)(71200400001)(6246003)(7696005)(316002)(76176011)(110136005)(52536014)(6506007)(5660300002)(54906003)(14444005)(256004)(186003)(66066001)(68736007)(99286004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:OSAPR01MB4241;
	H:OSAPR01MB3089.jpnprd01.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hREshsBnJWQ4ZpPxF+0cabo0J91Rc000rdI5BhSm5i5q0jKGUIj0jIbAvamPP8iS4PKUdApaIjznsZt+VnrESAu1zz1bkvZUp40QYTT7R+AgOHf+i57fqnDQ/gG0ewItHTufM/52jHU4JdULLv2PM0bKiaBar3Z/AA0DcbHlQ/+KWdu5/ldpmgvWRzWkbb0eWwjTW23UILElrgqbiYD6uf6bh6IbKcj5ysgVnQMqFi1t/N4URATJR15hAaqD168Tu/5Ca8bI/Rf+DoiPRKZRaUBl4b8RoieOnOAVZuIh0wSJNc8d3hc0fzlc2nE1SLrOTgea/Fv5n4dOgwF9BWcpyhI6/LuVQlEuwrkWgQ84Boly/zEdjIvzPRzmCCF4lpclZ4uKyUDGf02Yn53F+eK28yxtJoV9PaWVEaWj2PleZw0=
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c728d5bd-20b8-4dfb-1cd5-08d6ea483b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 06:28:47.6427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4241
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

Thank you for your comments!

> From: Christoph Hellwig, Sent: Wednesday, June 5, 2019 9:38 PM
> 
> On Wed, Jun 05, 2019 at 01:21:59PM +0100, Robin Murphy wrote:
> > And if the problem is really that you're not getting merging because of
> > exposing the wrong parameters to the DMA API and/or the block layer, or
> > that you just can't quite express your requirement to the block layer in
> > the first place, then that should really be tackled at the source rather
> > than worked around further down in the stack.
> 
> The problem is that we need a way to communicate to the block layer
> that more than a single segment is ok IFF the DMA API instance supports
> merging.  And of course the answer will depend on futher parameters
> like the maximum merged segment size and alignment for the segement.

I'm afraid but I don't understand why we need a way to communicate to
the block layer that more than a single segment is ok IFF the DMA API
instance supports merging.

> We'll need some way to communicate that, but I don't really think this
> is series is the way to go.

I should discard the patches 1/8 through 4/8.

> We'd really need something hanging off the device (or through a query
> API) how the dma map ops implementation exposes under what circumstances
> it can merge.  The driver can then communicate that to the block layer
> so that the block layer doesn't split requests up when reaching the
> segement limit.

The block layer already has a limit "max_segment_size" for each device so that
regardless it can/cannot merge the segments, we can use the limit.
Is my understanding incorrect?

Best regards,
Yoshihiro Shimoda

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
