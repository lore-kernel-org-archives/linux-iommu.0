Return-Path: <SRS0=mxFs=VA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93699C0650E
	for <iommu@archiver.kernel.org>; Wed,  3 Jul 2019 12:48:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6765C2187F
	for <iommu@archiver.kernel.org>; Wed,  3 Jul 2019 12:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="k90WjiK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6765C2187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 20070F3F;
	Wed,  3 Jul 2019 12:48:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9FE56F14
	for <iommu@lists.linux-foundation.org>;
	Wed,  3 Jul 2019 12:47:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM05-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr710131.outbound.protection.outlook.com [40.107.71.131])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 14C0E837
	for <iommu@lists.linux-foundation.org>;
	Wed,  3 Jul 2019 12:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=76XIjbz8Uc7Tq+D1vwNiQ4/FI/+4VBwHzXo63jQcruU=;
	b=k90WjiK1onDuCZbwTfI8aAescdsTNdVZSaeOXWICBFT2aRdfRyG2xWvLfJmEi7axWF98waJeyK2iDCylUsJsWIieoe5h0E+HI5OBDpZa5+8HjNGjT0EaNiKxU+UlUQaAUflWyJVu+XbkpEiZXcy+DPLR/Gd/WD3A5otkZcAzc9g=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.214.23) by
	CY4PR2201MB1173.namprd22.prod.outlook.com (10.171.240.35) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2052.16; Wed, 3 Jul 2019 12:47:44 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
	([fe80::9554:3ef:4a67:87f8]) by
	CY4PR2201MB1272.namprd22.prod.outlook.com
	([fe80::9554:3ef:4a67:87f8%5]) with mapi id 15.20.2032.019;
	Wed, 3 Jul 2019 12:47:44 +0000
From: Paul Burton <paul.burton@mips.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] MIPS: only select ARCH_HAS_UNCACHED_SEGMENT for
	non-coherent platforms
Thread-Topic: [PATCH] MIPS: only select ARCH_HAS_UNCACHED_SEGMENT for
	non-coherent platforms
Thread-Index: AQHVL2OakQs3eFNofkSxhu39rzGYG6a43DeA
Date: Wed, 3 Jul 2019 12:47:44 +0000
Message-ID: <20190703124739.vgz7bwkjdyiwc7lx@pburton-laptop>
References: <20190630164805.12229-1-hch@lst.de>
In-Reply-To: <20190630164805.12229-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0040.GBRP265.PROD.OUTLOOK.COM
	(2603:10a6:600:5c::28) To CY4PR2201MB1272.namprd22.prod.outlook.com
	(2603:10b6:910:6e::23)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a02:c7f:5e43:2c00:50fd:bec4:fe7e:44e7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a272da24-7363-4f22-ea9d-08d6ffb4a467
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:CY4PR2201MB1173; 
x-ms-traffictypediagnostic: CY4PR2201MB1173:
x-microsoft-antispam-prvs: <CY4PR2201MB1173B9EE193AC4CA12B87AF9C1FB0@CY4PR2201MB1173.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(136003)(39850400004)(346002)(366004)(396003)(376002)(199004)(189003)(53936002)(486006)(44832011)(11346002)(476003)(9686003)(6512007)(66446008)(64756008)(66556008)(66476007)(66946007)(73956011)(446003)(1076003)(2906002)(14454004)(68736007)(6246003)(58126008)(7736002)(316002)(305945005)(81166006)(8936002)(81156014)(6116002)(8676002)(6916009)(6486002)(54906003)(478600001)(229853002)(33716001)(6436002)(99286004)(71200400001)(386003)(6506007)(186003)(46003)(25786009)(71190400001)(4326008)(102836004)(52116002)(5660300002)(76176011)(42882007)(4744005)(14444005)(256004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR2201MB1173;
	H:CY4PR2201MB1272.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U4vArmeBuGN1lU/zciNGRNBv+In7uCfNFuVlYyUhDgKA6kSi/k3HUmSdOMkBpockNAthxhp8QfpNiAqWYMKD5YrGN5Vqy/gD10+13l9OpWJW4VdrIxsZyDWUrgj/xfFbAb6I7+fQxkz27xcavrW/ydXraJIhWSIYXe9ZnXKILz/dB2IMHQtejm1WDwn1TzU75ecvdKtlQfiABQgiW/9lkA1O/cbllYHzhqiSu5ur9yY3J+2/zaCGTp+DovDqbb2xzXlo1BDZz+CyKNA5MxEDHCX/huzCnClE8xrfGoezMKuFrXIFpJt0O4vS6EPRHq33a2YqAWDw7yRCvYn5Sw49CmrOe+WAKR2r0iVHGn0ChZWajtkJybZidjC//ktqjcdGNLDi/09/FWS4imQyZbabQfw8wAHVlmCcQ0sfmOOLHsc=
Content-ID: <59985F48F24AFA488F895AB8AD226DA5@namprd22.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a272da24-7363-4f22-ea9d-08d6ffb4a467
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 12:47:44.1357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pburton@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1173
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"linux@roeck-us.net" <linux@roeck-us.net>
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

On Sun, Jun 30, 2019 at 06:48:05PM +0200, Christoph Hellwig wrote:
> While mips might architecturally have the uncached segment all the time,
> the infrastructure to use it is only need on platforms where DMA is
> at least partially incoherent.  Only select it for those configuration
> to fix a build failure as the arch_dma_prep_coherent symbol is also only
> provided for non-coherent platforms.
> 
> Fixes: 2e96e04d25 ("MIPS: use the generic uncached segment support in dma-direct")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
