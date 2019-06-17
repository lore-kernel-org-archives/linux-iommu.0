Return-Path: <SRS0=Kmd8=UQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EB5C31E44
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 04:54:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F8521881
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 04:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="U0CACPbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F8521881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 30BA8A5E;
	Mon, 17 Jun 2019 04:54:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 897BB255
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 04:54:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
	(mail-eopbgr1410131.outbound.protection.outlook.com [40.107.141.131])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 37D827DB
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 04:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=tBs6DjSniTBp0wubAe36CjoKCpovrbC9VOMS8YGkyzM=;
	b=U0CACPbYH1BjpYuWBqCSbQuUTRbbyb1xyeW+bhbU1pm61EJ6OuNTNDCql0PI6pyX1qYo1DFZzuCqiTUYETr8c+QukUUBJ3kiVFV1mzOeBGVSN0EuMIUj6CZeiVuqZ55/iUFHNRwac6waYbxvI3xLW3n4dk7EGslYpVqPiP6wx/Y=
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com (20.178.97.80) by
	OSBPR01MB1542.jpnprd01.prod.outlook.com (52.134.225.145) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1987.13; Mon, 17 Jun 2019 04:54:28 +0000
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com
	([fe80::b1c2:125c:440d:e240]) by
	OSBPR01MB3590.jpnprd01.prod.outlook.com
	([fe80::b1c2:125c:440d:e240%4]) with mapi id 15.20.1987.014;
	Mon, 17 Jun 2019 04:54:27 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig <hch@lst.de>
Subject: RE: [RFC PATCH v6 4/5] mmc: tmio: Use dma_max_mapping_size() instead
	of a workaround
Thread-Topic: [RFC PATCH v6 4/5] mmc: tmio: Use dma_max_mapping_size() instead
	of a workaround
Thread-Index: AQHVIdGm2I9J5403AkGhlbCnRkkrDqaaC4IAgACzcgCAAAKLAIAEhNUQ
Date: Mon, 17 Jun 2019 04:54:27 +0000
Message-ID: <OSBPR01MB3590D4EF069F4554DA5D7ABBD8EB0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<CAMuHMdXYqgPRX1WfUTRsKHhnSok5vfnr4AY36=vXoUvAxcNyWQ@mail.gmail.com>
	<20190614071800.GB8420@lst.de>
	<CAMuHMdXm5RtDUL5Wkyd6aJihu9nykYOhRf7vN6hOtB-OO8CTQQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXm5RtDUL5Wkyd6aJihu9nykYOhRf7vN6hOtB-OO8CTQQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 518661ca-7bf1-4cf1-a947-08d6f2dfe09d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:OSBPR01MB1542; 
x-ms-traffictypediagnostic: OSBPR01MB1542:
x-microsoft-antispam-prvs: <OSBPR01MB154295F96B86314E54BB2038D8EB0@OSBPR01MB1542.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(366004)(376002)(346002)(396003)(39860400002)(189003)(199004)(316002)(7696005)(6506007)(64756008)(2906002)(86362001)(102836004)(66556008)(14454004)(66066001)(55016002)(7416002)(53936002)(6246003)(53546011)(6116002)(3846002)(71200400001)(476003)(71190400001)(99286004)(9686003)(76176011)(486006)(73956011)(54906003)(76116006)(66946007)(186003)(68736007)(446003)(4326008)(478600001)(66446008)(26005)(52536014)(229853002)(305945005)(110136005)(7736002)(6436002)(11346002)(8936002)(5660300002)(33656002)(74316002)(256004)(81166006)(81156014)(8676002)(66476007)(25786009);
	DIR:OUT; SFP:1102; SCL:1; SRVR:OSBPR01MB1542;
	H:OSBPR01MB3590.jpnprd01.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XBC3F6p3NDp2aUZeWfuLLbdTBV3VqqNJAH/C21adlCSzt1s1kIJfPd7Q1vc+WCY5bno/rlZj2v/YI5qa16YMZrhyWjezi+ONSO31Ejsftnwh73IWYzGaZYYXNmSYgNsrVfbSaYpyJjO+VvJuioBBB//Q/ZuaZP3+k6PWhD8wZNrEFCJBkgs81EXrQHVSpVKgkrVl4RSabLREwuhu4TsdRJTuUA6uyR+3/SMShyHihXOUQif3nTKPPO75z+aur7GoL//U2YdwQhaxnqm25TaK9+RIqieT5E5V//ACZrDS0ebjibpSxM1dt/ykXJZY/8f8WZaUixbXegpGt0gzzcb+3JSW+xVKvPpmeeOj9/wuuC/PibIuHY+kUJbHqvr79pSVZ20yw8vkAG4YA3NeeMnYWm86PaT+yafIPof6QCtRH6I=
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518661ca-7bf1-4cf1-a947-08d6f2dfe09d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 04:54:27.8921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1542
Cc: Jens Axboe <axboe@kernel.dk>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linux MMC List <linux-mmc@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Linux IOMMU <iommu@lists.linux-foundation.org>
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

Hi Geert, Christoph,

Thank you for your comments!

> From: Geert Uytterhoeven, Sent: Friday, June 14, 2019 4:27 PM
> 
> Hi Christoph,
> 
> On Fri, Jun 14, 2019 at 9:18 AM Christoph Hellwig wrote:
> > On Thu, Jun 13, 2019 at 10:35:44PM +0200, Geert Uytterhoeven wrote:
> > > I'm always triggered by the use of min_t() and other casts:
> > > mmc->max_blk_size and mmc->max_blk_count are both unsigned int.
> > > dma_max_mapping_size() returns size_t, which can be 64-bit.
> > >
> > >  1) Can the multiplication overflow?
> > >     Probably not, as per commit 2a55c1eac7882232 ("mmc: renesas_sdhi:
> > >     prevent overflow for max_req_size"), but I thought I'd better ask.

Geert-san:

I agree.

> > >  2) In theory, dma_max_mapping_size() can return a number that doesn't
> > >     fit in 32-bit, and will be truncated (to e.g. 0), leading to max_req_size
> > >     is zero?

Geert-san:

I agree. If dma_max_mapping_size() return 0x1_0000_0000, it will be truncated to 0
and then max_req_size is set to zero. It is a problem. Also, the second argument
"mmc->max_blk_size * mmc->max_blk_count" will not be overflow and then the value is
0xffff_ffff or less. So, I also think this should use size_t instead of unsigned int.

> > This really should use a min_t on size_t.  Otherwise the patch looks
> > fine:
> 
> Followed by another min() to make it fit in mmc->max_req_size, which is
> unsigned int.

Geert-san:

I'm afraid, but I cannot understand this means.
Is this patch is possible to be upstream? Or, do you have any concern?


Best regards,
Yoshihiro Shimoda

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
