Return-Path: <SRS0=kXp2=FW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C09C4361B
	for <iommu@archiver.kernel.org>; Fri, 18 Dec 2020 09:29:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8560239EE
	for <iommu@archiver.kernel.org>; Fri, 18 Dec 2020 09:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8560239EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F213186D32;
	Fri, 18 Dec 2020 09:29:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EFhYE84QLHCO; Fri, 18 Dec 2020 09:28:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CCF7486C76;
	Fri, 18 Dec 2020 09:28:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF270C1786;
	Fri, 18 Dec 2020 09:28:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE7AEC0893;
 Fri, 18 Dec 2020 09:28:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B8A2087A84;
 Fri, 18 Dec 2020 09:28:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UxZej4NBpF4U; Fri, 18 Dec 2020 09:28:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-edgeKA24.fraunhofer.de (mail-edgeka24.fraunhofer.de
 [153.96.1.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E5EC587A6F;
 Fri, 18 Dec 2020 09:28:53 +0000 (UTC)
IronPort-PHdr: =?us-ascii?q?9a23=3AbjoJRRTDbDocSQVQxgNJvbUHxdpsv++ubAcI9p?=
 =?us-ascii?q?oqja5Pea2//pPkeVbS/uhpkESQB9+J4vdIzeHRtvOoVW8B5MOHt3YPONxJWg?=
 =?us-ascii?q?QegMob1wonHIaeCEL9IfKrCk5yHMlLWFJ/uX3uN09TFZX3YlGUqXq3vnYeHx?=
 =?us-ascii?q?zlPl9zIeL4UofZk8Ww0bW0/JveBmcAhDe0bb5oahusqgCEv8gNjIAkJLw41x?=
 =?us-ascii?q?3JpXVFYaJayDBl?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EEAQCLddxf/xoBYJliGwEBAQEBAQE?=
 =?us-ascii?q?BBQEBARIBAQEDAwEBAUCBT4EjAS4jLoI0Cod9A4U5iCIDmQyCUwNLCQsBAQE?=
 =?us-ascii?q?BAQEBAQEHAQEYARQCBAEBAoRIAoF1ASU4EwIQAQEGAQEBAQEGBAIChk4Mg1S?=
 =?us-ascii?q?BBwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCgQw9AQE?=
 =?us-ascii?q?BAQIBAREuAQE3AQQLAgEIEQQBAQEuKAodCAIEDgUIGoUDUgUDDh8CA6JUAoE?=
 =?us-ascii?q?8iGl0gTSDBAEBBYUiGIIQCQkBgS6CdYJqToZ4JoFdPoERQ4JWPoRAg0iCLIF?=
 =?us-ascii?q?ZKkYuW4ELJRIzCixykhuIEIwFkDx7AwQDgWOBEZRYhxWDJo9QMY8Yhh6qQYR?=
 =?us-ascii?q?TAgQCBAUCDgEBBYFtgXtxXA2CT1AXAg2LSIJZDBeDTopYdAI1AgYKAQEDCXy?=
 =?us-ascii?q?JUi2BBgGBEAEB?=
X-IPAS-Result: =?us-ascii?q?A2EEAQCLddxf/xoBYJliGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBT4EjAS4jLoI0Cod9A4U5iCIDmQyCUwNLCQsBAQEBAQEBAQEHAQEYA?=
 =?us-ascii?q?RQCBAEBAoRIAoF1ASU4EwIQAQEGAQEBAQEGBAIChk4Mg1SBBwEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCgQw9AQEBAQIBAREuAQE3A?=
 =?us-ascii?q?QQLAgEIEQQBAQEuKAodCAIEDgUIGoUDUgUDDh8CA6JUAoE8iGl0gTSDBAEBB?=
 =?us-ascii?q?YUiGIIQCQkBgS6CdYJqToZ4JoFdPoERQ4JWPoRAg0iCLIFZKkYuW4ELJRIzC?=
 =?us-ascii?q?ixykhuIEIwFkDx7AwQDgWOBEZRYhxWDJo9QMY8Yhh6qQYRTAgQCBAUCDgEBB?=
 =?us-ascii?q?YFtgXtxXA2CT1AXAg2LSIJZDBeDTopYdAI1AgYKAQEDCXyJUi2BBgGBEAEB?=
X-IronPort-AV: E=Sophos;i="5.78,430,1599516000"; d="scan'208,217";a="26487191"
Received: from mail-mtaka26.fraunhofer.de ([153.96.1.26])
 by mail-edgeKA24.fraunhofer.de with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Dec 2020 10:28:50 +0100
IronPort-PHdr: =?us-ascii?q?9a23=3A8ZbRSx/iUqTRrf9uRHGN82YQeigqvan1NQcJ65?=
 =?us-ascii?q?0hzqhDabmn44+7ZhaN7PBhylTOWNaT5/FFjr/QtKbtESwF7I2auX8POJpLS1?=
 =?us-ascii?q?ceiMoQkgBhZazNCUDyIPPwKSBvGsNEWQxs+n39Ok9QS47yYlTIqSi06jgfUh?=
 =?us-ascii?q?z0KQtyILHzHYjf6qb/1+2795DJJQtSgz/oaLJpIR7wox/Yq88WhoVvMOA9x0?=
 =?us-ascii?q?jE?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CdAQBUddxf/z6wYZliGwEBAQEBAQE?=
 =?us-ascii?q?BBQEBARIBAQEDAwEBAUAHgUiBIwEuIy4HgU8eQAqHfQOFOYgiA5kMglMDVAs?=
 =?us-ascii?q?BAwEBAQEBBwEBGAEUAgQBAYRKAoFyAiY4EwIQAQEFAQEBAgEGBHGFYQyFcgE?=
 =?us-ascii?q?BAQECAQERLgEBFCMBBAsCAQgRBAEBAS4oCgcWCAIEDgUIGoUDUgUDDh8CA6J?=
 =?us-ascii?q?UAoE8iGl0gTSDBAEBBYUiGIIQCQkBgS6CdYJqToZ4ggM+gRFDglY+hECDSII?=
 =?us-ascii?q?sgVkqRi5bgQslEjMKLHKSG4gQjAWQPHsDBAOBY4ERlFiHFYMmj1AxjxiGHqp?=
 =?us-ascii?q?BhFMCBAIEBQIOAQEFgW0jgVdxXA2CT1AXAg2LSIJZDBeDTopYQzECNQIGCgE?=
 =?us-ascii?q?BAwl8iVItgQYBgRABAQ?=
X-IronPort-AV: E=Sophos;i="5.78,430,1599516000"; d="scan'208,217";a="98549256"
Received: from 153-97-176-62.vm.c.fraunhofer.de (HELO
 XCH-HYBRID-01.ads.fraunhofer.de) ([153.97.176.62])
 by mail-mtaKA26.fraunhofer.de with ESMTP; 18 Dec 2020 10:28:47 +0100
Received: from XCH-HYBRID-02.ads.fraunhofer.de (10.225.8.59) by
 XCH-HYBRID-01.ads.fraunhofer.de (10.225.8.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; 
 Fri, 18 Dec 2020 10:28:46 +0100
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (10.225.8.41) by
 XCH-HYBRID-02.ads.fraunhofer.de (10.225.8.59) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2
 via Frontend Transport; Fri, 18 Dec 2020 10:28:46 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWEGOERgN2pdsSAFWuRUt3dM4nscRNIgwrFOPqaRZtmujl1Zgl7lKvnNCcrlY+HwceSFPBztEHJ8BAdElsQXMOU6OuAA1vGInqajBBrF0GuURQOazhL4L1uvtkTpAMKZd787DLF6m4QQ43R1pLZC5W38MVt0V72AoDTRvCjvPNu7l5prI2EmFOidQEf5+cqixyj/UrfRMo5Hl6nGW0qvNBb6CZis9hmG0UdECg5ns7TWhXuD0hmVSe2IPtcWV5341KYeqVtFCKhTa+T3KtS9qGkN9WCa6JZazuPnkaZFdfCO229UUkZ3YMpBNYidM++VOc6DKhQ55p3e+O9W1WEa5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHbf8hClnDNITRFmXGvKySRg0iHHgNRRxzj1RFx6GBs=;
 b=ii/P3igHj6/m6QyxvgY9iMPjqR4aJ8Lq7s8ulkq5/jBgdHO4mX8qawpfoEekC/K/skakzhh7ap83l+3mh9PlJYyi7HYghcTLN0Y9H0BwvWf3FcNIHSv2ANXvX4KwJd/Oi817Y5wQqGxnZotqQ0kFV1xCYcCD9iq3myUGGkg8JiRvLpUpOYll8D0AzefthP26oTuMUXsbm9wnr7PiDRMISBhN2wNL8uorbGhbhtm2g7Gi0SmK8+DeAQAK/1wL8gllaWCEyX50TzaUuX0mNSnQ/rRzvEXqLxUSLsdeOWJSmR8205KX1egDyXd7C/tA1VrUnFERHeKEEMADTR63s/a9AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHbf8hClnDNITRFmXGvKySRg0iHHgNRRxzj1RFx6GBs=;
 b=WP3FPamqQqM46i/z+AQuKaX+tb6fo8puXYfkZh5MflWXkLS2tT3vC2h6VeVImsfY/ybp1l6nfIgVjo4OhWjinyBAu3Epyd25bvlcmi8AZ3u0uhr4B9h9UY3l2dBDYWhr7EifM1QTXsryCgpHvm+4YPDx+zr+5FT1hDi30lez7Uo=
Received: from AM7P194MB0900.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:174::13)
 by AM7P194MB0803.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:14d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 18 Dec
 2020 09:28:46 +0000
Received: from AM7P194MB0900.EURP194.PROD.OUTLOOK.COM
 ([fe80::5c40:ad2f:a2d7:f786]) by AM7P194MB0900.EURP194.PROD.OUTLOOK.COM
 ([fe80::5c40:ad2f:a2d7:f786%7]) with mapi id 15.20.3676.025; Fri, 18 Dec 2020
 09:28:45 +0000
From: "Radev, Martin" <martin.radev@aisec.fraunhofer.de>
To: Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: swiotlb/virtio: unchecked device dma address and length
Thread-Topic: swiotlb/virtio: unchecked device dma address and length
Thread-Index: AQHWz+L1ZOj1dhNPc0WrKfOuJwl5Nqn3JlIAgABceACAAe+egIAARpIAgACG7pSAAbXXgIAApUdM
Date: Fri, 18 Dec 2020 09:28:45 +0000
Message-ID: <AM7P194MB0900187909FBDD16B533D845D9C30@AM7P194MB0900.EURP194.PROD.OUTLOOK.COM>
References: <d2ae0b1d-332b-42a1-87bf-7da2b749cac2@sect.tu-berlin.de>
 <20201214214950.GC18103@char.us.oracle.com>
 <c3629a27-3590-1d9f-211b-c0b7be152b32@redhat.com>
 <20201215074427-mutt-send-email-mst@kernel.org>
 <DBDBA8B6-6CC3-47B5-A20E-6D5DD29DB47E@oracle.com>
 <AM7P194MB0900948E02C21FB13B722CD5D9C50@AM7P194MB0900.EURP194.PROD.OUTLOOK.COM>,
 <20201217231717.GB14861@ashkalra_ubuntu_server>
In-Reply-To: <20201217231717.GB14861@ashkalra_ubuntu_server>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none
 header.from=aisec.fraunhofer.de;
x-originating-ip: [78.27.97.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa7f738c-c7a3-4672-fd80-08d8a3375191
x-ms-traffictypediagnostic: AM7P194MB0803:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7P194MB08032A88B159E7E9730E4E28D9C30@AM7P194MB0803.EURP194.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ByyGNVTVFS2/bpdnUuJBdEOC7nx046eZWL49r49OmUBtSqASGJkIjs2K/m5r8sSFei80y5TbK5gi/r+HoObVeQfx9DG0TOnMvUxQKqs8oM466zOV4j8vsSazn9yqdaNRTsh+rXiROA54jTzjh6iBWnYb2UGrZspCYrrtyqiEGFToSYcfZ4LJnjLrXtpvdspoqDpiE1gXim+KK8LZ1Mna/N6umcS077HFrn5uzLQ5kV6IPpelebNmxQLVp6bn86Sf6SnffHI5pAgEuch99ddKK7b/yTePcAi/kOj3dpjk5i5hZHPhBCJKpNgj0gCk6i7WUfgJfKABLf9BA1fbXagCkw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7P194MB0900.EURP194.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(346002)(136003)(366004)(376002)(5660300002)(53546011)(83380400001)(8676002)(64756008)(55016002)(66476007)(76116006)(33656002)(86362001)(9686003)(316002)(6506007)(6916009)(54906003)(66946007)(26005)(7696005)(2906002)(91956017)(8936002)(66556008)(4326008)(66446008)(52536014)(478600001)(7416002)(19627405001)(71200400001)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+2vd5GBfUspeS0PB9uUbmIrV3YHvbmeTOqCVe5avu34iBEc/qgh7MKppgBPW?=
 =?us-ascii?Q?Ve8FAKUxz0Ahnii70LsRu2c/5XxXA5g7Jl4uF/R1pvl3ys/seVKQ4adFaBLG?=
 =?us-ascii?Q?cU7slaHxNoAdUbuOmyib1Cq3RURL5dQaRYDtW1Nz7bweBF4Y3/LboE4PH0Ga?=
 =?us-ascii?Q?0R8krY+1IKVCgrhDIaPTK/f0NcMU8hVDl/YKZlVHZ/CfgcDK5qd+tjEzKxWJ?=
 =?us-ascii?Q?jrU9MqdBdLEIgKoKLk34l1xDGd2cP4qCdDUBtbGW6eFyw/RBhUT9IxPI13Qp?=
 =?us-ascii?Q?ClA8zDE6Hierk7Lfe3OtIf5KX71FVTUS+rODmvxygvVmZnSgFsBbk1fK63G+?=
 =?us-ascii?Q?Xmlk+bhQo8cABnXG1uWKXKgtCokBzXGCVDcM808jT5WMAaJiBthET7IcfFXH?=
 =?us-ascii?Q?SvlMqinPL19z0aS8iUec1mPkLpuiXhcyxo2RzlfweBXB1YbQvRS20LcLQzkX?=
 =?us-ascii?Q?cjNAd+KanRFYeizi1WYrB/s9nDigzzVXHcOYNaAG3vZwJre2UOrojl6wnOp0?=
 =?us-ascii?Q?oYyUj23c+r62JSr3jSM8//V2DH3y5B5TFRGgsXwixdxw9tvGHier9yLl3rYk?=
 =?us-ascii?Q?3CBQsSq8ddQaYN9wlyegmTjHKQTy8pZAXJP5XUgFJ+x3Cj9EG9b3lXTmxmjh?=
 =?us-ascii?Q?jUl3NJdvXkYTreGL1GA4V+5/XiStiKkzEQtMll+DNJUDKL8cQwl2fYatF8In?=
 =?us-ascii?Q?LcaYo8x3HA+ViQA4IBOpI67xdRCDCzr5W/opgoUv+TJORNHyuA9NQUZsdj6Z?=
 =?us-ascii?Q?YvkJ7VjxfINggANzZdX/Mhb6PRMZwgrOXoMANoOfLKG8JWa6CtX30nQjIkAl?=
 =?us-ascii?Q?vuNHKEwuIWCH9DE5zrSZ8vCr4ifePxHLmH6M0SzlITLWdxFPoJNXOhjicSP4?=
 =?us-ascii?Q?7Z6PSytCChWE2jyaMj5BaGlODWt8mQXfvNkTfvQjACa5YiRwktOmOeXkelvx?=
 =?us-ascii?Q?LcltGhS4GlqlkBgrljg05QU7ts0seop6WGIaO+bwsdY=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P194MB0900.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7f738c-c7a3-4672-fd80-08d8a3375191
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 09:28:45.8422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vilRlrRYTsy+uOeslGKjR4MVHaOMv70S5R9xUyyq3IaWfrx+AuVit+1S/94qn80GqyY9QxJbySVVtqo4w5PgK+3ScL/4KfdzM1hlLdwqz4kTxx1xCdy0+jB+gPYG4UjH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P194MB0803
X-OriginatorOrg: aisec.fraunhofer.de
Cc: "Thomas.Lendacky@amd.com" <Thomas.Lendacky@amd.com>,
 "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
 Felicitas Hetzelt <file@sect.tu-berlin.de>,
 "david.kaplan@amd.com" <david.kaplan@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Robert Buhren <robert@sect.tu-berlin.de>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>, "Morbitzer,
 Mathias" <mathias.morbitzer@aisec.fraunhofer.de>, "hch@lst.de" <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: multipart/mixed; boundary="===============7015825692104698262=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============7015825692104698262==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_AM7P194MB0900187909FBDD16B533D845D9C30AM7P194MB0900EURP_"

--_000_AM7P194MB0900187909FBDD16B533D845D9C30AM7P194MB0900EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> I believe the above example is without a SEV guest enabled/active,
> as SEVguest debugging can only be done with SEV Debug patches applied.
SEV is active.
Adding `console=3DttyS0` to the kernel parameters and `GRUB_TERMINAL=3D"con=
sole serial"`
seems to do the job without any AMD-internal patches.

Note that even without SEV, I could get an exact repro by adding `swiotlb=
=3Dforce` to the
kernel cmd and `iommu_platform=3Don` to the qemu virtio device.
________________________________
From: Ashish Kalra <ashish.kalra@amd.com>
Sent: Friday, December 18, 2020 12:17 AM
To: Radev, Martin <martin.radev@aisec.fraunhofer.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>; Michael S. Tsirkin <mst=
@redhat.com>; Jason Wang <jasowang@redhat.com>; Felicitas Hetzelt <file@sec=
t.tu-berlin.de>; jun.nakajima@intel.com <jun.nakajima@intel.com>; hch@lst.d=
e <hch@lst.de>; virtualization@lists.linux-foundation.org <virtualization@l=
ists.linux-foundation.org>; iommu@lists.linux-foundation.org <iommu@lists.l=
inux-foundation.org>; Morbitzer, Mathias <mathias.morbitzer@aisec.fraunhofe=
r.de>; Robert Buhren <robert@sect.tu-berlin.de>; david.kaplan@amd.com <davi=
d.kaplan@amd.com>; Thomas.Lendacky@amd.com <Thomas.Lendacky@amd.com>; Jon.G=
rimm@amd.com <Jon.Grimm@amd.com>; brijesh.singh@amd.com <brijesh.singh@amd.=
com>
Subject: Re: swiotlb/virtio: unchecked device dma address and length

On Wed, Dec 16, 2020 at 10:07:31PM +0000, Radev, Martin wrote:
> Hello everybody,
>
> I will try help clarify some things.
>
> > On a DMA unmap SWIOTLB (when force is used) it trusts the driver from p=
roviding
> > the correct DMA address and length which SWIOTLB uses to match to its a=
ssociated
> > original PA address.
> > The length is not checked so the attacker can modify that to say a huge=
 number
> > and cause SWIOTLB bounce code to write or read data from non SWIOTLB PA=
 into the
> > SWIOTLB PA pool.
>
> This is true.
> As an example, I attached to the QEMU process, set a BP to `virtqueue_spl=
it_fill`
> and modified the length field from 0x40 to 0x10000, and filled the corres=
ponding
> buffer in the swiotlb region with As (0x41).
>
> Immediately after resuming execution, the kernel would crash:
> [  122.154142] general protection fault, probably for non-canonical addre=
ss 0x4141414141414141: 0000 [#1] PREEMPT SMP NOPTI
> [  122.156088] CPU: 0 PID: 917 Comm: kworker/0:6 Kdump: loaded Tainted: G=
        W   E     5.6.12-sevault+ #28
> [  122.157855] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0=
.0.0 02/06/2015
> [  122.159079] Workqueue: events_freezable_power_ disk_events_workfn
> [  122.160040] RIP: 0010:scsi_queue_rq+0x5af/0xa70 [scsi_mod]
> [  122.160916] Code: 01 89 83 9c 02 00 00 41 80 7f 08 00 74 07 83 8b 9c 0=
2 00 00 08 48 8b 83 40 02 00 00 c7 83 3c 01 00 00 00 00 00 00 48 8d 78 08 <=
48>
>                      c7 00 00 00 00 00 48 c7 40 58 00 00 00 00 48 83 e7 f=
8 48 29 f8
> [  122.163821] RSP: 0018:ffffc900002efb08 EFLAGS: 00010202
> [  122.164637] RAX: 4141414141414141 RBX: ffff888035b89c00 RCX: ffff88803=
5b89ed0
> [  122.165775] RDX: 0000000000000008 RSI: 0000000000000000 RDI: 414141414=
1414149
> [  122.166891] RBP: ffff888035946000 R08: ffff888035a79860 R09: 000000000=
0000000
> [  122.168016] R10: ffffea0001287280 R11: 0000000000000008 R12: ffff88803=
5b89d18
> [  122.169159] R13: ffff888035945000 R14: ffff888035946000 R15: ffffc9000=
02efba0
> [  122.170287] FS:  0000000000000000(0000) GS:ffff88807f800000(0000) knlG=
S:0000000000000000
> [  122.171564] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  122.172470] CR2: 0000560e654b77b8 CR3: 000000004dd38000 CR4: 000000000=
03406f0
>

I believe the above example is without a SEV guest enabled/active, as SEV
guest debugging can only be done with SEV Debug patches applied.

> What and where gets overwritten entirely depends on what virtio driver is=
 being
> targeted. All manage their memory for the descriptor buffers differently =
so the overwrite
> may require to be large.
>
> In the context of VirtIO and SWIOTLB, there are also these three fields o=
ther than the length:
> dma_addr, flags, next
>
> I had a look around a little bit, so my take is the following:
>
> 1) There's already validation for dma_addr before doing the unmap with a =
call
>    to is_swiotlb_buffer (1). I think this check is sufficient.
>
> 2) flags
>    Before doing the unmap, the virtio implementation would check the flag=
 and based on it
>    would select a DMA direction (TO/FROM DEVICE). Still, it seems that th=
is would not
>    trick the driver to copy data to the device since only a `sync for CPU=
` may be performed
>    in the unmap path.

That seems to be true.

Thanks,
Ashish


--_000_AM7P194MB0900187909FBDD16B533D845D9C30AM7P194MB0900EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
&gt; I believe the above example is without a SEV guest enabled/active,<br>
&gt; as SEVguest debugging can only be done with SEV Debug patches applied.=
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"background-color:rgb(255, 255, 255);display:inline !importan=
t">SEV is active.</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Adding `console=3DttyS0` to the kernel parameters and `GRUB_TERMINAL=3D&quo=
t;console serial&quot;`</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
seems to do the job without any AMD-internal patches.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Note that even without SEV, I could get an exact repro by adding&nbsp;<span=
 style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica, sans=
-serif; font-size: 12pt;">`swiotlb=3Dforce` to the</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;">kernel cmd and `iommu_platform=3Don` to the =
qemu virtio device.</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Ashish Kalra &lt;ashi=
sh.kalra@amd.com&gt;<br>
<b>Sent:</b> Friday, December 18, 2020 12:17 AM<br>
<b>To:</b> Radev, Martin &lt;martin.radev@aisec.fraunhofer.de&gt;<br>
<b>Cc:</b> Konrad Rzeszutek Wilk &lt;konrad.wilk@oracle.com&gt;; Michael S.=
 Tsirkin &lt;mst@redhat.com&gt;; Jason Wang &lt;jasowang@redhat.com&gt;; Fe=
licitas Hetzelt &lt;file@sect.tu-berlin.de&gt;; jun.nakajima@intel.com &lt;=
jun.nakajima@intel.com&gt;; hch@lst.de &lt;hch@lst.de&gt;; virtualization@l=
ists.linux-foundation.org
 &lt;virtualization@lists.linux-foundation.org&gt;; iommu@lists.linux-found=
ation.org &lt;iommu@lists.linux-foundation.org&gt;; Morbitzer, Mathias &lt;=
mathias.morbitzer@aisec.fraunhofer.de&gt;; Robert Buhren &lt;robert@sect.tu=
-berlin.de&gt;; david.kaplan@amd.com &lt;david.kaplan@amd.com&gt;;
 Thomas.Lendacky@amd.com &lt;Thomas.Lendacky@amd.com&gt;; Jon.Grimm@amd.com=
 &lt;Jon.Grimm@amd.com&gt;; brijesh.singh@amd.com &lt;brijesh.singh@amd.com=
&gt;<br>
<b>Subject:</b> Re: swiotlb/virtio: unchecked device dma address and length=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, Dec 16, 2020 at 10:07:31PM +0000, Radev, M=
artin wrote:<br>
&gt; Hello everybody,<br>
&gt; <br>
&gt; I will try help clarify some things.<br>
&gt; <br>
&gt; &gt; On a DMA unmap SWIOTLB (when force is used) it trusts the driver =
from providing<br>
&gt; &gt; the correct DMA address and length which SWIOTLB uses to match to=
 its associated<br>
&gt; &gt; original PA address.<br>
&gt; &gt; The length is not checked so the attacker can modify that to say =
a huge number<br>
&gt; &gt; and cause SWIOTLB bounce code to write or read data from non SWIO=
TLB PA into the<br>
&gt; &gt; SWIOTLB PA pool.<br>
&gt; <br>
&gt; This is true.<br>
&gt; As an example, I attached to the QEMU process, set a BP to `virtqueue_=
split_fill`<br>
&gt; and modified the length field from 0x40 to 0x10000, and filled the cor=
responding<br>
&gt; buffer in the swiotlb region with As (0x41).<br>
&gt; <br>
&gt; Immediately after resuming execution, the kernel would crash:<br>
&gt; [&nbsp; 122.154142] general protection fault, probably for non-canonic=
al address 0x4141414141414141: 0000 [#1] PREEMPT SMP NOPTI<br>
&gt; [&nbsp; 122.156088] CPU: 0 PID: 917 Comm: kworker/0:6 Kdump: loaded Ta=
inted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; W&nbsp;&nbsp; E&nbsp;&nb=
sp;&nbsp;&nbsp; 5.6.12-sevault+ #28<br>
&gt; [&nbsp; 122.157855] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)=
, BIOS 0.0.0 02/06/2015<br>
&gt; [&nbsp; 122.159079] Workqueue: events_freezable_power_ disk_events_wor=
kfn<br>
&gt; [&nbsp; 122.160040] RIP: 0010:scsi_queue_rq+0x5af/0xa70 [scsi_mod]<br>
&gt; [&nbsp; 122.160916] Code: 01 89 83 9c 02 00 00 41 80 7f 08 00 74 07 83=
 8b 9c 02 00 00 08 48 8b 83 40 02 00 00 c7 83 3c 01 00 00 00 00 00 00 48 8d=
 78 08 &lt;48&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c7 00 00 00 00 00 4=
8 c7 40 58 00 00 00 00 48 83 e7 f8 48 29 f8<br>
&gt; [&nbsp; 122.163821] RSP: 0018:ffffc900002efb08 EFLAGS: 00010202<br>
&gt; [&nbsp; 122.164637] RAX: 4141414141414141 RBX: ffff888035b89c00 RCX: f=
fff888035b89ed0<br>
&gt; [&nbsp; 122.165775] RDX: 0000000000000008 RSI: 0000000000000000 RDI: 4=
141414141414149<br>
&gt; [&nbsp; 122.166891] RBP: ffff888035946000 R08: ffff888035a79860 R09: 0=
000000000000000<br>
&gt; [&nbsp; 122.168016] R10: ffffea0001287280 R11: 0000000000000008 R12: f=
fff888035b89d18<br>
&gt; [&nbsp; 122.169159] R13: ffff888035945000 R14: ffff888035946000 R15: f=
fffc900002efba0<br>
&gt; [&nbsp; 122.170287] FS:&nbsp; 0000000000000000(0000) GS:ffff88807f8000=
00(0000) knlGS:0000000000000000<br>
&gt; [&nbsp; 122.171564] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033<br>
&gt; [&nbsp; 122.172470] CR2: 0000560e654b77b8 CR3: 000000004dd38000 CR4: 0=
0000000003406f0<br>
&gt; <br>
<br>
I believe the above example is without a SEV guest enabled/active, as SEV<b=
r>
guest debugging can only be done with SEV Debug patches applied.<br>
<br>
&gt; What and where gets overwritten entirely depends on what virtio driver=
 is being<br>
&gt; targeted. All manage their memory for the descriptor buffers different=
ly so the overwrite<br>
&gt; may require to be large.<br>
&gt; <br>
&gt; In the context of VirtIO and SWIOTLB, there are also these three field=
s other than the length:<br>
&gt; dma_addr, flags, next<br>
&gt; <br>
&gt; I had a look around a little bit, so my take is the following:<br>
&gt; <br>
&gt; 1) There's already validation for dma_addr before doing the unmap with=
 a call<br>
&gt;&nbsp;&nbsp;&nbsp; to is_swiotlb_buffer (1). I think this check is suff=
icient.<br>
&gt; <br>
&gt; 2) flags<br>
&gt;&nbsp;&nbsp;&nbsp; Before doing the unmap, the virtio implementation wo=
uld check the flag and based on it<br>
&gt;&nbsp;&nbsp;&nbsp; would select a DMA direction (TO/FROM DEVICE). Still=
, it seems that this would not<br>
&gt;&nbsp;&nbsp;&nbsp; trick the driver to copy data to the device since on=
ly a `sync for CPU` may be performed<br>
&gt;&nbsp;&nbsp;&nbsp; in the unmap path.<br>
<br>
That seems to be true. <br>
<br>
Thanks,<br>
Ashish<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM7P194MB0900187909FBDD16B533D845D9C30AM7P194MB0900EURP_--

--===============7015825692104698262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7015825692104698262==--
