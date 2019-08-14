Return-Path: <SRS0=gZYu=WK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4201BC433FF
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 15:58:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CF82083B
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 15:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="j2emEbzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CF82083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B7C2DF00;
	Wed, 14 Aug 2019 15:58:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 81238E9D
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 15:58:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
	(mail-eopbgr50069.outbound.protection.outlook.com [40.107.5.69])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D042487E
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 15:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=A5ZxutQL7uHbe/e9D8WkqXWJy0DzTRUTBOwNj9nPNINXXdKKqqC1tHbSWWTwi2BCYhbSx2T5IPgKW3wT4PhIeRJ9EHgRc10gOuOq4c1PQ5U9Z7zyEoEXPEywK/YwkD0VZ7iX4unefItTJ7hSmGRjkf19RHWCiUtrJLj0HWYR19PUQfDJy6yilOgxOQXnDkYTVZoFvtukCa+BL+oaXfYmVe2ORHZLvoAaVd/V6thY1k3iWMEXNcH1/Y6qW6WqgaubrrLLp8W8oGfiE/MprskU8mcOTSyzGqh1w7JrY5wkjBAxvoMnoApx6VXBul0PZhB9UEq8SYPVj7hugI1R3BVv8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=kX12tyjKySVLO7krMetcV1eho0h6a7kh9QLyW09aC/c=;
	b=n4m+QDyi+VDk9RARKuoMSSJnDOxmbp6XWfvNv3KSu0CXnPchQJd5bHGhJwByOlU8EVb5U6Lx6McioumWWqNPAV9dniX6dND/IZK82UTOinB19A0r2hppcB41z9z6ji8mfiop46Rt4egsNKam7h2XdIgtg4RceZPqIDGX3zsG5ejClgX37JAMbXCSC2odLq6KRFjE9BKAH4+A3+Dka0dIL6CmsmL47PtWMlAsrhMQnHBP8wkNRbHVtiCk6GEqhmoqcGZCcAtiU4ePU9c5MG0eYh3jnQsboNYs6mE1Ch3j9/ggNzIelIZLtEOVsuoh9cP34Fm/i85cCLRbueghALZaZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=mellanox.com;
	dmarc=pass action=none header.from=mellanox.com; 
	dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=kX12tyjKySVLO7krMetcV1eho0h6a7kh9QLyW09aC/c=;
	b=j2emEbzSLqIj3UVsOhs+lvK7XwOdn12tGgds1++RAqcZL+iSOVHZ7YbFVTtLWbKVihC2P1UrG0Pik4vBIblEixKQz3jtsgeu2OmmubCPDu6pRcpr9R0bPfpFoH4zj1/6HpVpo18qKzaCATgD7yqjqr4kWOszrc4uRuKb9WnDsZs=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
	VI1PR05MB4527.eurprd05.prod.outlook.com (20.176.3.16) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2157.21; Wed, 14 Aug 2019 15:58:35 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
	([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
	([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2157.022;
	Wed, 14 Aug 2019 15:58:35 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 hmm 04/11] misc/sgi-gru: use mmu_notifier_get/put for
	struct gru_mm_struct
Thread-Topic: [PATCH v3 hmm 04/11] misc/sgi-gru: use mmu_notifier_get/put for
	struct gru_mm_struct
Thread-Index: AQHVTKz0H8HKrXog20KnkgLCdHpVKKbxDfkAgAnK6AA=
Date: Wed, 14 Aug 2019 15:58:34 +0000
Message-ID: <20190814155830.GO13756@mellanox.com>
References: <20190806231548.25242-1-jgg@ziepe.ca>
	<20190806231548.25242-5-jgg@ziepe.ca> <20190808102556.GB648@lst.de>
In-Reply-To: <20190808102556.GB648@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
	(2603:10b6:c00:14::21) To VI1PR05MB4141.eurprd05.prod.outlook.com
	(2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f452d47-361b-4148-3fe8-08d720d0431a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:VI1PR05MB4527; 
x-ms-traffictypediagnostic: VI1PR05MB4527:
x-microsoft-antispam-prvs: <VI1PR05MB452757B28C504200EBDD963ACFAD0@VI1PR05MB4527.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(186003)(386003)(6506007)(64756008)(66946007)(6916009)(14454004)(102836004)(5660300002)(6116002)(66066001)(3846002)(66556008)(7416002)(7736002)(558084003)(26005)(66446008)(76176011)(66476007)(305945005)(99286004)(52116002)(33656002)(25786009)(486006)(11346002)(53936002)(476003)(446003)(2616005)(6486002)(8676002)(71190400001)(478600001)(229853002)(6436002)(86362001)(8936002)(6246003)(71200400001)(6512007)(2906002)(256004)(1076003)(54906003)(316002)(81166006)(36756003)(81156014)(4326008);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB4527;
	H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P4cIbC9UB4TXA1Re37qaL3G8qNfaDTpe5E/VhxHFoqiww8UBin+G0kbdUqjOk5LcFd7HbT3u6TC6M8bznMxkGMxA7l0pqXGlhylmnl2ayEu9mulhmwpVzsI8kwmORH67heQaHuRNGMN8vy4RcutO+XS9UW2Adq9MNo5vAeIzLAnOB5wjGAUP7p5MkRHUvx45CTlqdqHrIx+ak9rgG+dI/ac2Z+tqHN2XFJF8dcBg3nAPoGxT1yMjkDwrmOGAcJtnzn2jkHRhm7jAfRwlqEJCED20f2sGEwKDDUjasrTRcPVibfjs+W2SPFo8+2l9vU/+p58LXGOH4+3+Y4l7uZFkH24ugo8RSFtM4MLJlIDCFczyIBFYCBYKf6ml+bcCYWGq09Zt07T7KULHxW5W5JvODA7Syz9V+CImkq3CIhKaZSo=
x-ms-exchange-transport-forked: True
Content-ID: <F0E9FF81CF4345488D7CAC8D98C33BE1@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f452d47-361b-4148-3fe8-08d720d0431a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 15:58:34.8913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 053W0fAsixcgoOURzLSl+CEs/S7QS4kXawheIsIVdXp5FFr0v9GhbiQRLDbiWY2ErA2OzXSUhWtEq7LDxy8P5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4527
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	"David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
	Ralph Campbell <rcampbell@nvidia.com>, Dimitri Sivanich <sivanich@sgi.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Andrea Righi <andrea@betterlinux.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>, "Kuehling,
	Felix" <Felix.Kuehling@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	=?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	=?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
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

On Thu, Aug 08, 2019 at 12:25:56PM +0200, Christoph Hellwig wrote:
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Dimitri, are you OK with this patch?

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
