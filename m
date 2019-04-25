Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A03C10F03
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 11:31:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A7E20811
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 11:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fBN5zXpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A7E20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EDB721D8F;
	Thu, 25 Apr 2019 11:31:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2193A1D8C
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 11:31:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
	(mail-eopbgr80071.outbound.protection.outlook.com [40.107.8.71])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8222874A
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 11:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Vcd3L1QPNSwk5NsNneEVBZx0mhsJQL7y0KMeVYuHDOk=;
	b=fBN5zXpm4OIkkIPYdy5dHl+xre5tOXu0GIfOzcyHIG+UC+JSbaeV7GTn04cL71LeJiZpVy7PqrqWv9dscw/KbjA6W3/xjbES7NkH/gbj6nGASk1n9KO1t99lp9AAzAarB5VnWGrqyasCu8ZdWBAke6m+pBVQCCKGeb/T5Lr3GOk=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
	VI1PR04MB5742.eurprd04.prod.outlook.com (20.178.127.84) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13; Thu, 25 Apr 2019 11:30:54 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::81d8:f74b:f91e:f071]) by
	VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::81d8:f74b:f91e:f071%6]) with mapi id 15.20.1813.017;
	Thu, 25 Apr 2019 11:30:54 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH] dma-mapping: create iommu mapping for newly allocated
	dma coherent mem
Thread-Topic: [RFC PATCH] dma-mapping: create iommu mapping for newly
	allocated dma coherent mem
Thread-Index: AQHU+SuhzP7n9rkWMk6epTxwq855uaZIeyMAgAHQb4CAAR4MgIABWJQA
Date: Thu, 25 Apr 2019 11:30:54 +0000
Message-ID: <b9f2b425-dde9-f9a1-b8fa-b7710e764b16@nxp.com>
References: <20190422165125.21704-1-laurentiu.tudor@nxp.com>
	<20190422181100.GB32490@lst.de>
	<VI1PR04MB513407A66107759EC0DFE175EC230@VI1PR04MB5134.eurprd04.prod.outlook.com>
	<20190424145705.GB21480@lst.de>
In-Reply-To: <20190424145705.GB21480@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9efaa0ed-af9c-44e0-6dc1-08d6c9717a97
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:VI1PR04MB5742; 
x-ms-traffictypediagnostic: VI1PR04MB5742:
x-microsoft-antispam-prvs: <VI1PR04MB574294BDBD6817E2786A1E96EC3D0@VI1PR04MB5742.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(136003)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(8936002)(478600001)(4326008)(97736004)(6246003)(66066001)(6486002)(81156014)(6436002)(81166006)(71200400001)(71190400001)(8676002)(256004)(6116002)(3846002)(229853002)(36756003)(54906003)(316002)(11346002)(476003)(2616005)(486006)(44832011)(6916009)(5660300002)(2906002)(66946007)(66446008)(64756008)(66556008)(76176011)(76116006)(7736002)(305945005)(73956011)(68736007)(26005)(6506007)(186003)(53546011)(99286004)(102836004)(446003)(66476007)(31686004)(31696002)(93886005)(53936002)(86362001)(25786009)(14454004)(6512007);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5742;
	H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3qlcUcjzUEFjHGfOOWWpa9IGk1mwUS5fLKHYrpNF7G//Owsr88hjnShhckMLU7GM+7sZCcxcR39/sLaeLl8Zi2prcvnmnmAvtgFcIBkB5AM4nUivoq/icqzTfj+pHUFUORVKhRK2erfCL3hB4E0hJmcDLfsNvGMcd+ztolPtDsOYk3BcUo3UKItSLa332LUNTfAd3XIt0yc9Zo6RFqeA8Gv0qSom2SPjy2vkysBpgrPBjoxT9HoT25k+CBSnDXANMV2YcihMmUDf8T+cJWnzlYSzsmCs5zNb3hnCvysVA+W1PNuFXsPXWMw4wfIHZiiuVaoml+7248YKnhKNbgYbLFRHPYPHLeL8OBxjOi+TWBmp7ogzgrH/z2RAylMNsLUU46QwP7KA2ntiXkqtUsgbg9+No40szz0+v0X/2wBdPbs=
Content-ID: <C3DAFF8A2E6710478B0D4E110DCF3AE3@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efaa0ed-af9c-44e0-6dc1-08d6c9717a97
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 11:30:54.3194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5742
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Leo Li <leoyang.li@nxp.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
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
Message-ID: <20190425113054.f3jv_4U72HJ2hgLJ7RkfV1Be0Pb8svVP6PFPRZw4XJY@z>

Hi Christoph,

On 24.04.2019 17:57, Christoph Hellwig wrote:
> I'd be happy to offload all of the mentioned tasks to you if you
> volunteer.

Alright, I think I mostly got it and can start with the two usb drivers 
you mentioned. Just need a few clarifications, please see inline.

> I think the first step is to move the two USB controller that can only
> DMA to their own BAR off the existing DMA coherent infrastructure.  The
> controllers are already identified using the HCD_LOCAL_MEM flag, so we
> just need to key off that in the hcd_buffer_* routines and call into a

So if HCD_LOCAL_MEM is set I should call into the gen_pool api instead 
of existing dma_{alloc,free}_coherent().

> genalloc that has been fed using the bar, replacing the current
> dma_declare_coherent usage.  Take a look at drivers/pci/p2pdma.c
> for another example of allocating bits of a BAR using genalloc.

Where should I place the reference to the gen_pool? How does local_pool 
in 'struct hcd_usb' sound?

---
Thanks & Best Regards, Laurentiu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
