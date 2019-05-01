Return-Path: <SRS0=GORt=TB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACF4C43219
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 17:14:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A7820835
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 17:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="mCxlssX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A7820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5B24D2AA3;
	Wed,  1 May 2019 17:14:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8C6DB2A83
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 17:14:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
	(mail-eopbgr820094.outbound.protection.outlook.com [40.107.82.94])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 025AC876
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 17:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=HABJON+PUwKKspjD9/5rvoUoFvtxnRJTtI3uP9m84jA=;
	b=mCxlssX/fSUbWEVb2VVYdxuzP6WTJXUoID7oXybpmZtZVwXaaUwA6oDPteNnndFZnjcms3WVbEk0dOF3DlZqKIX7AfYJZP4sJmCbYRtdw60uIVrSxajoSw9KnZsTqvAgS57jzMC7IzyRbPDt9Kp6+5jrtJIrn0lz0wT4pi/eiYQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
	MWHPR2201MB1360.namprd22.prod.outlook.com (10.174.162.150) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.11; Wed, 1 May 2019 17:13:57 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
	([fe80::b9d6:bf19:ec58:2765]) by
	MWHPR2201MB1277.namprd22.prod.outlook.com
	([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1835.018;
	Wed, 1 May 2019 17:13:57 +0000
From: Paul Burton <paul.burton@mips.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/7 v2] MIPS: use the generic uncached segment support in
	dma-direct
Thread-Topic: [PATCH 5/7 v2] MIPS: use the generic uncached segment support in
	dma-direct
Thread-Index: AQHVAB+93knDJH4MwEqQLib+MMfMNKZWgkOA
Date: Wed, 1 May 2019 17:13:57 +0000
Message-ID: <20190501171355.7wnrutfnax5djkpx@pburton-laptop>
References: <20190430110032.25301-1-hch@lst.de>
	<20190430110032.25301-6-hch@lst.de>
	<20190430201041.536amvinrcvd2wua@pburton-laptop>
	<20190430202947.GA30262@lst.de>
	<20190430211105.ielntedm46uqamca@pburton-laptop>
	<20190501131339.GA890@lst.de>
In-Reply-To: <20190501131339.GA890@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0050.namprd02.prod.outlook.com
	(2603:10b6:a03:54::27) To MWHPR2201MB1277.namprd22.prod.outlook.com
	(2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11d33d32-661c-4be2-e2ef-08d6ce586500
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:MWHPR2201MB1360; 
x-ms-traffictypediagnostic: MWHPR2201MB1360:
x-microsoft-antispam-prvs: <MWHPR2201MB1360446168387E44DE27414AC13B0@MWHPR2201MB1360.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 00246AB517
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(39840400004)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(44832011)(71190400001)(71200400001)(486006)(4744005)(6436002)(6486002)(1076003)(476003)(11346002)(6506007)(386003)(8676002)(73956011)(102836004)(26005)(81166006)(81156014)(478600001)(6116002)(3846002)(66946007)(229853002)(305945005)(2906002)(7736002)(446003)(256004)(66476007)(64756008)(66446008)(66556008)(7416002)(6916009)(8936002)(4326008)(68736007)(33716001)(6512007)(52116002)(76176011)(99286004)(53936002)(42882007)(6246003)(9686003)(5660300002)(66066001)(316002)(186003)(58126008)(54906003)(14454004)(25786009)(41533002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2201MB1360;
	H:MWHPR2201MB1277.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RyJnvgB3VbpTL1lCiqOR1TUJLbWECPHaCuWA4fJ4a25biAZrmmqnIY/y4PaIgDe+k9ZqYq6Kue008thEQ7/ViQ0msPhX/yfaRI4Lu1LwY0MUXoN9ZHu0fWjLG1cN53DkiOjeJ17ykF8TOzIYyWDCnhN4AwRHESAlxD5kGqKCkJjiKX4wqU41M9uxtrB6pNYbmBe1478S51AbWB0ZceRXxMX0lpP5EuF1C9GJYOlvXvGVIlEinM4Y8iyJpdQk6FQwXM4TzOSuWZwBO4GjFt4f6MSKj6bhnToCXk4jvAzHre8aQFrce1x0zNCKn80ju95fNSN1mhqRloSJxq8uPM+Ty44XPZeB+xEbJ/YCDZlPhjPnwsS3J70XuYQV9KemHV8BNMyOOZY3IuIzSL7FdDWmRWrv2vEECO89rI8SxzaLvZ8=
Content-ID: <F14412FE76975045800B7CCED7EAD807@namprd22.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d33d32-661c-4be2-e2ef-08d6ce586500
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2019 17:13:57.6422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1360
Cc: Michal Simek <monstr@monstr.eu>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	James Hogan <jhogan@kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190501171357.z7smeWGMlidtHduaiLcQRxAP0vkivtnZFjq01bQN-5M@z>

Hi Christoph,

On Wed, May 01, 2019 at 03:13:39PM +0200, Christoph Hellwig wrote:
> Stop providing our arch alloc/free hooks and just expose the segment
> offset instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/mips/Kconfig              |  1 +
>  arch/mips/include/asm/page.h   |  3 ---
>  arch/mips/jazz/jazzdma.c       |  6 ------
>  arch/mips/mm/dma-noncoherent.c | 26 +++++++++-----------------
>  4 files changed, 10 insertions(+), 26 deletions(-)

This one looks good to me now, for patches 1 & 5:

  Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
