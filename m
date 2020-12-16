Return-Path: <SRS0=vTls=FU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94BDC4361B
	for <iommu@archiver.kernel.org>; Wed, 16 Dec 2020 22:31:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E099423602
	for <iommu@archiver.kernel.org>; Wed, 16 Dec 2020 22:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E099423602
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7B9F086CDD;
	Wed, 16 Dec 2020 22:31:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2PWVcdPDWP75; Wed, 16 Dec 2020 22:31:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2882386CB7;
	Wed, 16 Dec 2020 22:31:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17E8DC088E;
	Wed, 16 Dec 2020 22:31:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A59DC013B;
 Wed, 16 Dec 2020 22:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6D7B886B1A;
 Wed, 16 Dec 2020 22:17:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rsR5vvtJsq7J; Wed, 16 Dec 2020 22:17:56 +0000 (UTC)
X-Greylist: delayed 00:10:15 by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-edgeKA27.fraunhofer.de (mail-edgeka27.fraunhofer.de
 [153.96.1.27])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C635786AB7;
 Wed, 16 Dec 2020 22:17:55 +0000 (UTC)
IronPort-PHdr: =?us-ascii?q?9a23=3AAaq8uhy9eEAhEdnXCy+N+z0EezQntrPoPwUc9p?=
 =?us-ascii?q?sgjfdUf7+++4j5ZRaPt/J3hVTNUMPQ7PcXw+bVsqW1X2sG7N7BtX0Za5VDWl?=
 =?us-ascii?q?cDjtlehA0vBsOJSCiZZP7nZiA3BoJOAVli+XzoNlJcE8LzIVbVpy764TsbAB?=
 =?us-ascii?q?6qMw1zK6z8EZLTiMLi0ee09vixKwVFjTawe/V8NhKz+AzQrcQdx4V4I7s3yh?=
 =?us-ascii?q?zHr2EOd+kFyA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FgAAD2g9pf/xwBYJliGgEBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBARIBAQEBAgIBAQEBQIFPgSMBLiMGKHyBOAqHfQOFOYgiA5kKglM?=
 =?us-ascii?q?DTgYLAQEBAQEBAQEBBwEBGAEMCAIEAQEChAREAoFyASU4EwIQAQEGAQEBAQE?=
 =?us-ascii?q?GBAIChk4Mg0YOgQcBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEFAg1UKz0BAQEBAgEBES4BATcBBAsCAQgRBAEBLygKHQgCBAENBQgagwW?=
 =?us-ascii?q?BflIFAw4fAgMLoiUCgTyIaXSBNIMEAQEFhTQYghADBgkBgS6CdYJqToMGg3I?=
 =?us-ascii?q?IHoFdPoERQ4JWPoJdBIE0KyuDHYIsgVkqRi5bLB8CLRElEisICixBBiuSG4g?=
 =?us-ascii?q?RjASQO3sDBAOBY4ERiSOLNYcVgyaKJoUoMY8YhhyNaYsNkSImCIRLAgQCBAU?=
 =?us-ascii?q?CDgEBBYFtgXtxXA2CT1AXAg2LSIJZDBeBAgECgkmKWHQCATQCBgoBAQMJfIZ?=
 =?us-ascii?q?7Ai2BBgGBEAEB?=
X-IPAS-Result: =?us-ascii?q?A2FgAAD2g9pf/xwBYJliGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFPgSMBLiMGKHyBOAqHfQOFOYgiA5kKglMDTgYLAQEBAQEBA?=
 =?us-ascii?q?QEBBwEBGAEMCAIEAQEChAREAoFyASU4EwIQAQEGAQEBAQEGBAIChk4Mg0YOg?=
 =?us-ascii?q?QcBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAg1UKz0BA?=
 =?us-ascii?q?QEBAgEBES4BATcBBAsCAQgRBAEBLygKHQgCBAENBQgagwWBflIFAw4fAgMLo?=
 =?us-ascii?q?iUCgTyIaXSBNIMEAQEFhTQYghADBgkBgS6CdYJqToMGg3IIHoFdPoERQ4JWP?=
 =?us-ascii?q?oJdBIE0KyuDHYIsgVkqRi5bLB8CLRElEisICixBBiuSG4gRjASQO3sDBAOBY?=
 =?us-ascii?q?4ERiSOLNYcVgyaKJoUoMY8YhhyNaYsNkSImCIRLAgQCBAUCDgEBBYFtgXtxX?=
 =?us-ascii?q?A2CT1AXAg2LSIJZDBeBAgECgkmKWHQCATQCBgoBAQMJfIZ7Ai2BBgGBEAEB?=
X-IronPort-AV: E=Sophos;i="5.78,425,1599516000"; d="scan'208,217";a="26514898"
Received: from mail-mtaka28.fraunhofer.de ([153.96.1.28])
 by mail-edgeKA27.fraunhofer.de with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Dec 2020 23:07:37 +0100
IronPort-PHdr: =?us-ascii?q?9a23=3AlJvAPhI8g4P8xFVBodmcpTVXNCE6p7X5OBIU4Z?=
 =?us-ascii?q?M7irVIN76u5InmIFeGv6U/i0XAVoHWrflDjrmev6PhXDkG5pCM+DAHfYdXXh?=
 =?us-ascii?q?AIwcMRg0Q7AcGDBEG6SZyibyEzEMlYElMw+Xa9PBtSAs/1Y1CUqXq3vnYeHx?=
 =?us-ascii?q?zlPl9zIeL4UofZk8Ww0bW0/JveBmcAhDe0bb5oahusqgCEv8gNjIAkJLw41x?=
 =?us-ascii?q?3JpXVFYaJayDBl?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DTAQD2g9pf/z6wYZliGwEBAQEBAQE?=
 =?us-ascii?q?BBQEBARIBAQEDAwEBAUAHgUiBIwEuIwYoB3VaHkAKh30DhTmIIgOZCoJTA1Q?=
 =?us-ascii?q?LAQMBAQEBAQcBARgBDAgCBAEBhAZEAoFvAiY4EwIQAQEFAQEBAgEGBHGFYQy?=
 =?us-ascii?q?FcgEBAQMBAREuAQEUIwEECwIBCBEEAQEvKAoHFggCBAENBQgagwWBflIFAw4?=
 =?us-ascii?q?fAgMLoiUCgTyIaXSBNIMEAQEFhTQYghADBgkBgS6CdYJqToMGg3IIgXs+gRF?=
 =?us-ascii?q?DglY+gl0EgTQrK4MdgiyBWSpGLlssHwItESUSKwgKLEEGK5IbiBGMBJA7ewM?=
 =?us-ascii?q?EA4FjgRGJI4s1hxWDJoomhSgxjxiGHI1piw2RIiYIhEsCBAIEBQIOAQEFgW0?=
 =?us-ascii?q?jgVdxXA2CT1AXAg2LSIJZDBeBAgECgkmKWEMxAgE0AgYKAQEDCXyGewImB4E?=
 =?us-ascii?q?GAYEQAQE?=
X-IronPort-AV: E=Sophos;i="5.78,425,1599516000"; d="scan'208,217";a="42262023"
Received: from 153-97-176-62.vm.c.fraunhofer.de (HELO
 XCH-HYBRID-01.ads.fraunhofer.de) ([153.97.176.62])
 by mail-mtaKA28.fraunhofer.de with ESMTP; 16 Dec 2020 23:07:33 +0100
Received: from XCH-HYBRID-02.ads.fraunhofer.de (10.225.8.59) by
 XCH-HYBRID-01.ads.fraunhofer.de (10.225.8.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; 
 Wed, 16 Dec 2020 23:07:33 +0100
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (10.225.8.41) by
 XCH-HYBRID-02.ads.fraunhofer.de (10.225.8.59) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2
 via Frontend Transport; Wed, 16 Dec 2020 23:07:32 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvjF1TBfUV8EEmqXPRxw62VW9Xfwo78NhT/h6yK2W8KdMISHHdBPUoMI+GMQhSnuYM3b+iU09bIK1AAxOBa7QdwS2d2qJZ8The3i5CySNOOoi/ImD9iLSX9m2laR6HAsTHK0fvnKlQpu8Dzm4Kh/M4hFFTDO+idclkkl6N/X+JCHl/2+j00sb6aHfg6EsTGArFcLk3Tie3v0b2zmlZ8JSyKm9c24Qr1Wj3vTXd3j1cM8hcdXh7DGM5xxs1EAV0+5FREV/8WTLZgJJGObpH3yR0fGbVH7cTRcsV1DYFFRERNCtcdV7BKSIjBqEoeVEJtbI6ChOtXXTnmFQJWGFnbvMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+EJKcwwwDnAKm9jw86O+wXZJEXjRxmvSre/uUg22qU=;
 b=YsLpbFDcREoXc9jJQKETXvg5rSAZ4i2th/MgAERCaI4f693jYFRqBTpUPHtWQ5wriQENRzuNlqXZGZyqKK+i8zG7b9PH48J6TJhUYNwFdJ5/7AARUbEg3C5+DIC4QgiMW/QJmYqOYVe+eXEtfSjKRNRiRxPtRZbd6ZC8LvpWKqow5a29bD+COENpt9chpOlpWJhc5o+jWHaixeE3H917P4GapZOQsKJ9HV0fL/X986fGIRIkMaWxCuAz96rWMNE26epDwH1yFB11LJ7r7qs8cr/tKLkxl+aGA78KQBffWLlBgO/hyAtHn/Nf0IxvmFyQoX8kw1HPj41N8qyvhgXblQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+EJKcwwwDnAKm9jw86O+wXZJEXjRxmvSre/uUg22qU=;
 b=LU4M87vQ8Iy5Cm7zKG5P90U3LOnp4nT04lYVl1pYlpRmx2q+o+oMQfFKIJFf+9H/hoU38mon9jS6aqTULEqkydk2omQyJQytlZlC8F9BST1RUVODiryg4TWHAL6msn1eJFGaL14fB9WHO6aZWOhVG9mKy0LTeaaLPQE7/7Whz78=
Received: from AM7P194MB0900.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:174::13)
 by AM7P194MB0883.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:14c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Wed, 16 Dec
 2020 22:07:31 +0000
Received: from AM7P194MB0900.EURP194.PROD.OUTLOOK.COM
 ([fe80::5c40:ad2f:a2d7:f786]) by AM7P194MB0900.EURP194.PROD.OUTLOOK.COM
 ([fe80::5c40:ad2f:a2d7:f786%4]) with mapi id 15.20.3654.024; Wed, 16 Dec 2020
 22:07:31 +0000
From: "Radev, Martin" <martin.radev@aisec.fraunhofer.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: swiotlb/virtio: unchecked device dma address and length
Thread-Topic: swiotlb/virtio: unchecked device dma address and length
Thread-Index: AQHWz+L1ZOj1dhNPc0WrKfOuJwl5Nqn3JlIAgABceACAAe+egIAARpIAgACG7pQ=
Date: Wed, 16 Dec 2020 22:07:31 +0000
Message-ID: <AM7P194MB0900948E02C21FB13B722CD5D9C50@AM7P194MB0900.EURP194.PROD.OUTLOOK.COM>
References: <d2ae0b1d-332b-42a1-87bf-7da2b749cac2@sect.tu-berlin.de>
 <20201214214950.GC18103@char.us.oracle.com>
 <c3629a27-3590-1d9f-211b-c0b7be152b32@redhat.com>
 <20201215074427-mutt-send-email-mst@kernel.org>,
 <DBDBA8B6-6CC3-47B5-A20E-6D5DD29DB47E@oracle.com>
In-Reply-To: <DBDBA8B6-6CC3-47B5-A20E-6D5DD29DB47E@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none
 header.from=aisec.fraunhofer.de;
x-originating-ip: [87.138.167.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84072a68-d305-43b8-359f-08d8a20efc24
x-ms-traffictypediagnostic: AM7P194MB0883:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7P194MB0883894C2FB665851B373227D9C50@AM7P194MB0883.EURP194.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mrxnCzEmHBhaXJrH/xhrTXpUgz+fNxsXapGSlrLpuf8Hg0XpFGQoZtRZSScM0gtCcNht/dxs5tYP0sW23QwP26XzRpSDMLoVzjcg6X7fh4z/cr+FeC7XGM9YrQKmTpa/SYZugStqZ78+TjHunsU1w5O1MoJfl+jCIvypRUyNTxq7zu0RwI87295GmZNLtSzhkqLYscnuOIbdLy8FndEZn7kWIyrj/04ZJaJfA4v3riC7oFagFdvBMpzHSFkseXzsuKrjVwekhJGu2TDsSsMhWsH3MAze1SWNoT1dsc7QxAkbQc1dGofq5OHHBrldyJk7RuRhTz3WEZu6l3KhltrpU95lyD1Z7WXWUd7W6CrqvZGbo5FUP/+9nA3dv3dvmXwkFulw+BDs5xYEaiL/BdZ0Kg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7P194MB0900.EURP194.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(346002)(366004)(136003)(396003)(52536014)(8676002)(71200400001)(5660300002)(186003)(478600001)(110136005)(66446008)(86362001)(7416002)(54906003)(19627405001)(76116006)(53546011)(7696005)(66946007)(83380400001)(316002)(966005)(166002)(26005)(6506007)(91956017)(4326008)(66556008)(33656002)(2906002)(8936002)(66476007)(55016002)(64756008)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?luiswFM0fg4XiPCo9WZjvRg8z2wa70pWltpGDvQ7rUPKTSOBEw9UQozRlF4t?=
 =?us-ascii?Q?DP2p8N+o6AdzSS8Xm+3LP/0BFtQYG0JcGBO2IXzHQNkU5xFRdfCO5OOwUJQA?=
 =?us-ascii?Q?oDA6fFZ3HDeqM1pcKyMvmpSFuHe8r13+EV0CPT2lBd/Kp293MOBRc474scHm?=
 =?us-ascii?Q?NZnLGxV2Db1JpAtSYvaPXKo26SNEjminVAWQw5bb1BXtZLXB1crTjD5VnKuL?=
 =?us-ascii?Q?nbKLIselNv3RRMZsYlnBrO2pdVVDHxpGx0tkFuhO6vh+inLi7oeEwL6HEV10?=
 =?us-ascii?Q?FXnYwTfBCX51WQuqcqnrI9uVf2szUT2AzVJF/poFucWMY82OsJbSMCj5xIfI?=
 =?us-ascii?Q?mK3OOWEs/ISW6AWLQ3GGn0vT3MpNu82zHlguXNdU3iucJJr2cZhA12F0upOS?=
 =?us-ascii?Q?RtajkWV+ctIHqdS8Uu2ukuccDCA2mEpCPbrKCy/97vA05Uja0hrD9r+cykk0?=
 =?us-ascii?Q?LOduGsU0VQbvS9izWylxaLaE0oAhP0lepBdBjSISYF93fJ0tl/sL41X+WPTz?=
 =?us-ascii?Q?Ku5rv/8UNJdcfWIGhSdGUu3nxSORNuP+nDF42Xb5uzrjmheHdFBRlHhbdqFo?=
 =?us-ascii?Q?D4CM/e6Xdo4vwARv3NyKIPeV+zsJiW0WUqNMpH+7DUJSKBhZKW3ctD4A2Q9K?=
 =?us-ascii?Q?wv25Almyi8rgPwHY9FMact5pxHnPd24QPahuH7n01pQrkbpq7FSL78t1QqUc?=
 =?us-ascii?Q?bjUwNlwOelnXYh4auk0/RRFwU46d67Vf3Hm6vogs93XGQs32VGljstLCvyJl?=
 =?us-ascii?Q?CkRLr8+7u+mnolMeNizw/TciUEye7omsWGZtI6v6YOCtNjrChI7fF9PZb2bY?=
 =?us-ascii?Q?IBnnonZ47a5JsxGcgxfCLHjn5wgfXpdZ+yL+H8ebMT0AXMnFO4WNI7GE7MmL?=
 =?us-ascii?Q?9ZnqXasTR02c1r4OKbxJ3rJJpqv2PEa0SwQZRmxARGJq9D2JF9N5njjuu+b1?=
 =?us-ascii?Q?9VPbUp+ZzIIoJVuEM0PItnSyfig5TY/bUn4wJVjccqE=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P194MB0900.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 84072a68-d305-43b8-359f-08d8a20efc24
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 22:07:31.5611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +bhMqeIJGsDzkE+yGlU/Xtl5lgGyFk2bC7Ldm+hxIOL6aPX5Rlh0oEJ+mRo63R2KgP83bDKhrVjHntmlHJzK2pYxGGimWrUFiuSSbE2q0nbdvskOeazTmm2viuDIlovs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P194MB0883
X-OriginatorOrg: aisec.fraunhofer.de
X-Mailman-Approved-At: Wed, 16 Dec 2020 22:31:25 +0000
Cc: "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
 Felicitas Hetzelt <file@sect.tu-berlin.de>,
 "david.kaplan@amd.com" <david.kaplan@amd.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Robert Buhren <robert@sect.tu-berlin.de>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Morbitzer, Mathias" <mathias.morbitzer@aisec.fraunhofer.de>,
 "hch@lst.de" <hch@lst.de>
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
Content-Type: multipart/mixed; boundary="===============1902103019585587964=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============1902103019585587964==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_AM7P194MB0900948E02C21FB13B722CD5D9C50AM7P194MB0900EURP_"

--_000_AM7P194MB0900948E02C21FB13B722CD5D9C50AM7P194MB0900EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello everybody,

I will try help clarify some things.

> On a DMA unmap SWIOTLB (when force is used) it trusts the driver from pro=
viding
> the correct DMA address and length which SWIOTLB uses to match to its ass=
ociated
> original PA address.
> The length is not checked so the attacker can modify that to say a huge n=
umber
> and cause SWIOTLB bounce code to write or read data from non SWIOTLB PA i=
nto the
> SWIOTLB PA pool.

This is true.
As an example, I attached to the QEMU process, set a BP to `virtqueue_split=
_fill`
and modified the length field from 0x40 to 0x10000, and filled the correspo=
nding
buffer in the swiotlb region with As (0x41).

Immediately after resuming execution, the kernel would crash:
[  122.154142] general protection fault, probably for non-canonical address=
 0x4141414141414141: 0000 [#1] PREEMPT SMP NOPTI
[  122.156088] CPU: 0 PID: 917 Comm: kworker/0:6 Kdump: loaded Tainted: G  =
      W   E     5.6.12-sevault+ #28
[  122.157855] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0=
.0 02/06/2015
[  122.159079] Workqueue: events_freezable_power_ disk_events_workfn
[  122.160040] RIP: 0010:scsi_queue_rq+0x5af/0xa70 [scsi_mod]
[  122.160916] Code: 01 89 83 9c 02 00 00 41 80 7f 08 00 74 07 83 8b 9c 02 =
00 00 08 48 8b 83 40 02 00 00 c7 83 3c 01 00 00 00 00 00 00 48 8d 78 08 <48=
>
                     c7 00 00 00 00 00 48 c7 40 58 00 00 00 00 48 83 e7 f8 =
48 29 f8
[  122.163821] RSP: 0018:ffffc900002efb08 EFLAGS: 00010202
[  122.164637] RAX: 4141414141414141 RBX: ffff888035b89c00 RCX: ffff888035b=
89ed0
[  122.165775] RDX: 0000000000000008 RSI: 0000000000000000 RDI: 41414141414=
14149
[  122.166891] RBP: ffff888035946000 R08: ffff888035a79860 R09: 00000000000=
00000
[  122.168016] R10: ffffea0001287280 R11: 0000000000000008 R12: ffff888035b=
89d18
[  122.169159] R13: ffff888035945000 R14: ffff888035946000 R15: ffffc900002=
efba0
[  122.170287] FS:  0000000000000000(0000) GS:ffff88807f800000(0000) knlGS:=
0000000000000000
[  122.171564] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  122.172470] CR2: 0000560e654b77b8 CR3: 000000004dd38000 CR4: 00000000003=
406f0

What and where gets overwritten entirely depends on what virtio driver is b=
eing
targeted. All manage their memory for the descriptor buffers differently so=
 the overwrite
may require to be large.

In the context of VirtIO and SWIOTLB, there are also these three fields oth=
er than the length:
dma_addr, flags, next

I had a look around a little bit, so my take is the following:

1) There's already validation for dma_addr before doing the unmap with a ca=
ll
   to is_swiotlb_buffer (1). I think this check is sufficient.

2) flags
   Before doing the unmap, the virtio implementation would check the flag a=
nd based on it
   would select a DMA direction (TO/FROM DEVICE). Still, it seems that this=
 would not
   trick the driver to copy data to the device since only a `sync for CPU` =
may be performed
   in the unmap path.
   However, I can see that this would eliminate a memcpy to any passed buff=
er which means
   that an uninitialized buffer may be passed to some client like a user sp=
ace application.
   I tested that with the device `virtio-rng` which would leak some stored =
kernel address.

3) next
   I think this was reported by Felicitas that this can lead to an OOB acce=
ss, but it is limited.

So, I think that the problem of overwriting the addr and flags fields are n=
ot a big issue
on their own. But there should be some validation for the size and that sho=
uld be probably
done the SWIOTLB implementation level.
There's already an array to keep the original address (3), What about addin=
g an extra array
to keep track of also the `original size`. It would be populated when some =
memory is mapped,
just like with io_tlb_orig_addr (4). Then the validation can be added in (5=
) and (6).

This swiotlb/virtio issue affects the AMD SEV features where swiotlb is alw=
ays
forcefully enabled. I can also see that SWIOTLB is also always enabled for =
s390 but I don't
know their threat model.

[1] https://elixir.bootlin.com/linux/v5.10/source/include/linux/swiotlb.h#L=
72
[2] https://elixir.bootlin.com/linux/v5.8/source/drivers/virtio/virtio_ring=
.c#L381
[3] https://elixir.bootlin.com/linux/v5.8/source/kernel/dma/swiotlb.c#L103
[4] https://elixir.bootlin.com/linux/v5.8/source/kernel/dma/swiotlb.c#L570
[5] https://elixir.bootlin.com/linux/v5.8/source/kernel/dma/swiotlb.c#L588
[6] https://elixir.bootlin.com/linux/v5.8/source/kernel/dma/swiotlb.c#L633
________________________________
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Sent: Wednesday, December 16, 2020 2:07 PM
To: Michael S. Tsirkin <mst@redhat.com>; Jason Wang <jasowang@redhat.com>
Cc: Felicitas Hetzelt <file@sect.tu-berlin.de>; ashish.kalra@amd.com <ashis=
h.kalra@amd.com>; jun.nakajima@intel.com <jun.nakajima@intel.com>; hch@lst.=
de <hch@lst.de>; virtualization@lists.linux-foundation.org <virtualization@=
lists.linux-foundation.org>; iommu@lists.linux-foundation.org <iommu@lists.=
linux-foundation.org>; Radev, Martin <martin.radev@aisec.fraunhofer.de>; Mo=
rbitzer, Mathias <mathias.morbitzer@aisec.fraunhofer.de>; Robert Buhren <ro=
bert@sect.tu-berlin.de>; david.kaplan@amd.com <david.kaplan@amd.com>
Subject: Re: swiotlb/virtio: unchecked device dma address and length

..snip..
>> > > This raises two issues:
>> > > 1) swiotlb_tlb_unmap_single fails to check whether the index
>generated
>> > > from the dma_addr is in range of the io_tlb_orig_addr array.
>> > That is fairly simple to implement I would think. That is it can
>check
>> > that the dma_addr is from the PA in the io_tlb pool when
>SWIOTLB=3Dforce
>> > is used.
>>
>>
>> I'm not sure this can fix all the cases. It looks to me we should map
>> descriptor coherent but readonly (which is not supported by current
>DMA
>> API).
>
>Neither is this supported but encrypted memory technologies.


-ECONFUSED.

Could you state this once more please? I am not exactly sure what you are s=
aying

>
>> Otherwise, device can modify the desc[i].addr/desc[i].len at any time
>to
>> pretend a valid mapping.
>>
>> Thanks
>>
>>
>> >


--_000_AM7P194MB0900948E02C21FB13B722CD5D9C50AM7P194MB0900EURP_
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
Hello everybody,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I will try help clarify some things.<br>
<br>
&gt; On a DMA unmap SWIOTLB (when force is used) it trusts the driver from =
providing
<div>&gt; the correct DMA address and length which SWIOTLB uses to match to=
 its associated</div>
<div>&gt; original PA address.</div>
<div>&gt; The length is not checked so the attacker can modify that to say =
a huge number</div>
<div>&gt; and cause SWIOTLB bounce code to write or read data from non SWIO=
TLB PA into the</div>
<div>&gt; SWIOTLB PA pool.</div>
<div><br>
</div>
<div>This is true.</div>
<div>As an example, I attached to the QEMU process, set a BP to `virtqueue_=
split_fill`</div>
<div>and modified the length field from 0x40 to 0x10000, and filled the cor=
responding</div>
<div>buffer in the swiotlb region with As (0x41).</div>
<div><br>
</div>
<div>Immediately after resuming execution, the kernel would crash:</div>
<div>[ &nbsp;122.154142] general protection fault, probably for non-canonic=
al address 0x4141414141414141: 0000 [#1] PREEMPT SMP NOPTI &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</div>
<div>[ &nbsp;122.156088] CPU: 0 PID: 917 Comm: kworker/0:6 Kdump: loaded Ta=
inted: G &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp; E &nbsp; &nbsp; 5.6.12-sevault=
+ #28 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;
</div>
<div>[ &nbsp;122.157855] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)=
, BIOS 0.0.0 02/06/2015 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</div>
<div>[ &nbsp;122.159079] Workqueue: events_freezable_power_ disk_events_wor=
kfn &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp;
</div>
<div>[ &nbsp;122.160040] RIP: 0010:scsi_queue_rq+0x5af/0xa70 [scsi_mod]</di=
v>
<div>[ &nbsp;122.160916] Code: 01 89 83 9c 02 00 00 41 80 7f 08 00 74 07 83=
 8b 9c 02 00 00 08 48 8b 83 40 02 00 00 c7 83 3c 01 00 00 00 00 00 00 48 8d=
 78 08 &lt;48&gt;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;c7 00 00 00 00 00 48 c7 40 58 00 00 00 00 48 83 e7 f8 48 29 f8</div>
<div>[ &nbsp;122.163821] RSP: 0018:ffffc900002efb08 EFLAGS: 00010202</div>
<div>[ &nbsp;122.164637] RAX: 4141414141414141 RBX: ffff888035b89c00 RCX: f=
fff888035b89ed0</div>
<div>[ &nbsp;122.165775] RDX: 0000000000000008 RSI: 0000000000000000 RDI: 4=
141414141414149 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</div>
<div>[ &nbsp;122.166891] RBP: ffff888035946000 R08: ffff888035a79860 R09: 0=
000000000000000 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</div>
<div>[ &nbsp;122.168016] R10: ffffea0001287280 R11: 0000000000000008 R12: f=
fff888035b89d18</div>
<div>[ &nbsp;122.169159] R13: ffff888035945000 R14: ffff888035946000 R15: f=
fffc900002efba0</div>
<div>[ &nbsp;122.170287] FS: &nbsp;0000000000000000(0000) GS:ffff88807f8000=
00(0000) knlGS:0000000000000000 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</div>
<div>[ &nbsp;122.171564] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</div>
<div>[ &nbsp;122.172470] CR2: 0000560e654b77b8 CR3: 000000004dd38000 CR4: 0=
0000000003406f0</div>
<div><br>
</div>
<div>What and where gets overwritten entirely depends on what virtio driver=
 is being</div>
<div>targeted. All manage their memory for the descriptor buffers different=
ly so the overwrite<br>
may require to be large.</div>
<div><br>
</div>
<div>In the context of VirtIO and SWIOTLB, there are also these three field=
s other than the length:</div>
<div>dma_addr, flags, next</div>
<div><br>
</div>
<div>I had a look around a little bit, so my take is the following:</div>
<div><br>
</div>
<div>1) There's already validation for dma_addr before doing the unmap with=
 a call</div>
<div>&nbsp; &nbsp;to is_swiotlb_buffer (1). I think this check is sufficien=
t.</div>
<div><br>
</div>
<div>2) flags</div>
<div>&nbsp; &nbsp;Before doing the unmap, the virtio implementation would c=
heck the flag and based on it</div>
<div>&nbsp; &nbsp;would select a DMA direction (TO/FROM DEVICE). Still, it =
seems that this would not</div>
<div>&nbsp; &nbsp;trick the driver to copy data to the device since only a =
`sync for CPU` may be performed</div>
<div>&nbsp; &nbsp;in the unmap path.</div>
<div>&nbsp; &nbsp;However, I can see that this would eliminate a memcpy to =
any passed buffer which means</div>
<div>&nbsp; &nbsp;that an uninitialized buffer may be passed to some client=
 like a user space application.</div>
<div>&nbsp; &nbsp;I tested that with the device `virtio-rng` which would le=
ak some stored kernel address.</div>
<div><br>
</div>
<div>3) next</div>
<div>&nbsp; &nbsp;I think this was reported by Felicitas that this can lead=
 to an OOB access, but it is limited.</div>
<div><br>
</div>
<div>So, I think that the problem of overwriting the addr and flags fields =
are not a big issue</div>
<div>on their own. But there should be some validation for the size and tha=
t should be probably</div>
<div>done the SWIOTLB implementation level.</div>
<div>There's already an array to keep the original address (3), What about =
adding an extra array</div>
<div>to keep track of also the `original size`. It would be populated when =
some memory is mapped,</div>
<div>just like with io_tlb_orig_addr (4). Then the validation can be added =
in (5) and (6).</div>
<div><br>
</div>
<div>This swiotlb/virtio issue affects the AMD SEV features where swiotlb i=
s always</div>
<div>forcefully enabled. I can also see that SWIOTLB is also always enabled=
 for s390 but I don't</div>
<div>know their threat model.</div>
<div><br>
</div>
<div>[1] https://elixir.bootlin.com/linux/v5.10/source/include/linux/swiotl=
b.h#L72</div>
<div>[2] https://elixir.bootlin.com/linux/v5.8/source/drivers/virtio/virtio=
_ring.c#L381</div>
<div>[3] https://elixir.bootlin.com/linux/v5.8/source/kernel/dma/swiotlb.c#=
L103</div>
<div>[4] https://elixir.bootlin.com/linux/v5.8/source/kernel/dma/swiotlb.c#=
L570</div>
<div>[5] https://elixir.bootlin.com/linux/v5.8/source/kernel/dma/swiotlb.c#=
L588</div>
[6] <a href=3D"https://elixir.bootlin.com/linux/v5.8/source/kernel/dma/swio=
tlb.c#L633" id=3D"LPlnk583130">
https://elixir.bootlin.com/linux/v5.8/source/kernel/dma/swiotlb.c#L633</a><=
br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Konrad Rzeszutek Wilk=
 &lt;konrad.wilk@oracle.com&gt;<br>
<b>Sent:</b> Wednesday, December 16, 2020 2:07 PM<br>
<b>To:</b> Michael S. Tsirkin &lt;mst@redhat.com&gt;; Jason Wang &lt;jasowa=
ng@redhat.com&gt;<br>
<b>Cc:</b> Felicitas Hetzelt &lt;file@sect.tu-berlin.de&gt;; ashish.kalra@a=
md.com &lt;ashish.kalra@amd.com&gt;; jun.nakajima@intel.com &lt;jun.nakajim=
a@intel.com&gt;; hch@lst.de &lt;hch@lst.de&gt;; virtualization@lists.linux-=
foundation.org &lt;virtualization@lists.linux-foundation.org&gt;;
 iommu@lists.linux-foundation.org &lt;iommu@lists.linux-foundation.org&gt;;=
 Radev, Martin &lt;martin.radev@aisec.fraunhofer.de&gt;; Morbitzer, Mathias=
 &lt;mathias.morbitzer@aisec.fraunhofer.de&gt;; Robert Buhren &lt;robert@se=
ct.tu-berlin.de&gt;; david.kaplan@amd.com &lt;david.kaplan@amd.com&gt;<br>
<b>Subject:</b> Re: swiotlb/virtio: unchecked device dma address and length=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">..snip..<br>
&gt;&gt; &gt; &gt; This raises two issues:<br>
&gt;&gt; &gt; &gt; 1) swiotlb_tlb_unmap_single fails to check whether the i=
ndex<br>
&gt;generated<br>
&gt;&gt; &gt; &gt; from the dma_addr is in range of the io_tlb_orig_addr ar=
ray.<br>
&gt;&gt; &gt; That is fairly simple to implement I would think. That is it =
can<br>
&gt;check<br>
&gt;&gt; &gt; that the dma_addr is from the PA in the io_tlb pool when<br>
&gt;SWIOTLB=3Dforce<br>
&gt;&gt; &gt; is used.<br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; I'm not sure this can fix all the cases. It looks to me we should =
map<br>
&gt;&gt; descriptor coherent but readonly (which is not supported by curren=
t<br>
&gt;DMA<br>
&gt;&gt; API).<br>
&gt;<br>
&gt;Neither is this supported but encrypted memory technologies.<br>
<br>
<br>
-ECONFUSED.<br>
<br>
Could you state this once more please? I am not exactly sure what you are s=
aying <br>
<br>
&gt;<br>
&gt;&gt; Otherwise, device can modify the desc[i].addr/desc[i].len at any t=
ime<br>
&gt;to<br>
&gt;&gt; pretend a valid mapping.<br>
&gt;&gt; <br>
&gt;&gt; Thanks<br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; &gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM7P194MB0900948E02C21FB13B722CD5D9C50AM7P194MB0900EURP_--

--===============1902103019585587964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1902103019585587964==--
