Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1F5C10F13
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 18:47:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC0920833
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 18:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="KChuzRkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC0920833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 10685CA1;
	Mon,  8 Apr 2019 18:47:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A99A9CA0
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 18:47:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
	(mail-eopbgr820043.outbound.protection.outlook.com [40.107.82.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 177B27A6
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 18:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=cIdNsSLVH2hh5zGk/ICxSFOHgDl30IbEJy3O8LbL9Aw=;
	b=KChuzRkE1Nz02tnvaugxkWDJJC5zBSjcPcDYEgV3n1haQUwNWI4mGRPAJ/r0Ds3CsFQIhd8GLNnx0zGE10GRih9Ppp/z94jEIQnfOhhQPBELYl8B8yI7U7A/mhsprk6t8fqwiuntHtiJRjZLu4KRkn3ObTC62yEQtseIpk8azxk=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
	MN2PR05MB6605.namprd05.prod.outlook.com (20.178.248.155) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.8; Mon, 8 Apr 2019 18:47:52 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
	([fe80::91e:292d:e304:78ad]) by MN2PR05MB6141.namprd05.prod.outlook.com
	([fe80::91e:292d:e304:78ad%7]) with mapi id 15.20.1792.009;
	Mon, 8 Apr 2019 18:47:52 +0000
To: "hch@lst.de" <hch@lst.de>, "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>
Subject: Re: revert dma direct internals abuse
Thread-Topic: revert dma direct internals abuse
Thread-Index: AQHU7fmi7IV/x30l7UexE5gP02MWCKYymy+A
Date: Mon, 8 Apr 2019 18:47:52 +0000
Message-ID: <7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
References: <20190408105525.5493-1-hch@lst.de>
In-Reply-To: <20190408105525.5493-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 704abf75-30df-4f09-4ef6-08d6bc52b4e7
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:MN2PR05MB6605; 
x-ms-traffictypediagnostic: MN2PR05MB6605:
x-microsoft-antispam-prvs: <MN2PR05MB6605FFAE3F7300D1244B1A19A12C0@MN2PR05MB6605.namprd05.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(136003)(376002)(39860400002)(396003)(346002)(189003)(199004)(36756003)(446003)(3846002)(81166006)(81156014)(5660300002)(2616005)(97736004)(486006)(476003)(11346002)(99286004)(316002)(14444005)(6116002)(256004)(2501003)(68736007)(71190400001)(71200400001)(118296001)(86362001)(106356001)(7736002)(305945005)(105586002)(8676002)(110136005)(6246003)(6512007)(54906003)(2906002)(4326008)(14454004)(6506007)(478600001)(6436002)(8936002)(26005)(229853002)(76176011)(6486002)(25786009)(102836004)(186003)(53936002)(66066001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR05MB6605;
	H:MN2PR05MB6141.namprd05.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: vmware.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5huBmpd/OcXofqbOxzjcEaSUZegvOHyppkTdudErT5BLfehl6f/3Sjcx6ziVvNa5MCOz5DZJ12qT+mgK7NJVGsOPBBIJ/J9RvNXu1Sc3xz5OJ9wMTLKwwgcNYUt/aBaTM8DKwk2Ox8pZ0uWBFJbWYjEv9gHMIrJLkbFydiPwiLL9QiPqfVaQdI5vC0uPPC7ugry6CjeS3zZhqK2THlrnMbDsmJt8aWe6St0JCYuuFEEHO6wW/39asueYFg6dpQlNXpII/A04slc5ULpHHzil0X1ci84a6uHkZXj78jSzPBBEPrzbJaSeKJewQRIoXf1o2X2tzuDAt+/VhTGGq3mlxNaJ3rhDeerdWVpVSEVqrnUxvaehvPMfymzPhxh7yJ9ofj0jUvufhgplcdKwNfZxQglNh34C3ihP7//Lh+Fn8lQ=
Content-ID: <A4C855632C5C4A4A994C7890F5A162D2@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704abf75-30df-4f09-4ef6-08d6bc52b4e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 18:47:52.6270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6605
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Deepak Singh Rawat <drawat@vmware.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
From: Thomas Hellstrom via iommu <iommu@lists.linux-foundation.org>
Reply-To: Thomas Hellstrom <thellstrom@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190408184752.s-De-chLsHCCgj-edAKrgehuXwkxHs-kHd6kGS3jGrU@z>

Christoph,


On Mon, 2019-04-08 at 12:55 +0200, Christoph Hellwig wrote:
> Hi Linus,
> 
> unfortunately it took less than a merge window for the:
> 
> /*
>  * All the dma_direct_* declarations are here just for the indirect
> call bypass,
>  * and must not be used directly drivers!
>  */
> 
> warning in dma-mapping.h to be ignored.  This series reverts the
> offender
> to keep our API clean.
> 
> Thomas: please talk me first about your needs and I'll be happy to
> figure out
> a proper API for what you want to do.

We HAVE discussed our needs, although admittedly some of my emails
ended up unanswered.

We've as you're well aware of had a discussion with the other
subsystems doing user-space DMA-buffers wanting this functionality from
the dma api (AMD graphics and RDMA people IIRC). that is a bool that
tells us whether streaming dma mappings are coherent, and I described
in detail why we couldn't use the dma_sync_* API and
dma_alloc_coherent().

The other option we have is to just fail miserably without messages if
streaming DMA is not coherent, which I think the other drivers might
do... That's all I'm trying to avoid here. I'd much prefer to have the
dma API export this bool.

/Thomas






_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
