Return-Path: <SRS0=E0xS=ZG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FD2C43215
	for <iommu@archiver.kernel.org>; Thu, 14 Nov 2019 11:13:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF08206D8
	for <iommu@archiver.kernel.org>; Thu, 14 Nov 2019 11:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PMUtKvwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF08206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C7BBC108B;
	Thu, 14 Nov 2019 11:13:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 047C7107D
	for <iommu@lists.linux-foundation.org>;
	Thu, 14 Nov 2019 11:13:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
	(mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AA677CF
	for <iommu@lists.linux-foundation.org>;
	Thu, 14 Nov 2019 11:13:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=a8OaCBtaBFwzEpWwQDtVIMwjndFEWIOJ065ZmqntKJuTl4SACL9hAcfeOCmWTqYUKQlit0jivqmF1zk8pv8Eb9X8SAt0oVr89hihHPJ7fFy1CuyKAqPn6Kszmfg6lhVMUDfS1QYeh7hyecBReZRsK+TLEVru+oMlemPJ59HoO5sLqpUxnfrfgj1mLb9A2i33p4r7G6xaKT3yyrys1OWS+RppOM9/Ljlon7fj+b9SOerZQQBLnzHxSvDV6PVqlzBKkvkppWpou2hHWvp2+o7W8ca5enzbJA7CSKghw9Dt9k4pPihrL50XX+hPi34OTfADULEl4Of76bvNOjDgiKhtZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=oYAjsatHdLHoWo+HEJtZ5yEtn6oTV/EkAwmp9sfTxTI=;
	b=E/Pr0a6pGwMNWaqhAsD9tGuB74Yom19QsUGCOQ70SeU/ELXUiJxbRGTVe2zw6m6eIDN7OCF27CFbA4NQeqa1mX1ElkBKYNHQnNC5ff+mqmnzbW/YU+oaZzH6sPus9hsCxToCl3B+eA8110uy6B3htk4JZKnCxCji74c78go6O/n/73XHpoltA5Z84X8xpJAPhKzkL6lOx9glZcfaRAstk9yAfoi8FyL5/Y32rHXuqD8EdAmh2NZvItLwmi4NB9eCKgBqHTVmmZwVmLI4LrhrgEULdoaE+HnToxvKjkEC3X2zBzl1d8BAnybHpQDNSN1LV5oXgB5xpU+EYlYHwF5x5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com;
	dkim=pass header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=oYAjsatHdLHoWo+HEJtZ5yEtn6oTV/EkAwmp9sfTxTI=;
	b=PMUtKvwooBamQ1NFZXq/hE4DhfCeEp7fk7gUyVGcIBM0kqBiVjNTnI3nzNk3ZxzMfyXLHvkpjU8ERxE5s8j9LykPokivuQELDbIht6K+JrF3RQdMxVNolSyxrEjuOSW6RYgphP0DpxBlbl5PjukVGwzgs8VgOWAd9XtTAUPRsEw=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.51.208) by
	VI1PR04MB6176.eurprd04.prod.outlook.com (20.179.25.140) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2451.23; Thu, 14 Nov 2019 11:13:28 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::71d2:55b3:810d:c75b]) by
	VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::71d2:55b3:810d:c75b%7]) with mapi id 15.20.2451.027;
	Thu, 14 Nov 2019 11:13:28 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3 0/4] dma-mapping: introduce new dma unmap and sync
	variants
Thread-Topic: [PATCH v3 0/4] dma-mapping: introduce new dma unmap and sync
	variants
Thread-Index: AQHVmh1EAM9HSxnkaEm+5zOWq0YV/qeJiNoAgAD7/oA=
Date: Thu, 14 Nov 2019 11:13:28 +0000
Message-ID: <81b6e75b-a827-32e2-77bd-50220ddd66cc@nxp.com>
References: <20191113122407.1171-1-laurentiu.tudor@nxp.com>
	<20191113.121132.1658930697082028145.davem@davemloft.net>
In-Reply-To: <20191113.121132.1658930697082028145.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 404e478a-56bb-4132-4791-08d768f3ace7
x-ms-traffictypediagnostic: VI1PR04MB6176:|VI1PR04MB6176:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB617685810398D719E2E9141AEC710@VI1PR04MB6176.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(199004)(189003)(86362001)(102836004)(486006)(76116006)(305945005)(26005)(44832011)(76176011)(6506007)(186003)(446003)(11346002)(5660300002)(478600001)(66556008)(3846002)(64756008)(66476007)(6116002)(53546011)(7736002)(66946007)(66446008)(316002)(31696002)(8676002)(81156014)(81166006)(14454004)(2906002)(54906003)(6246003)(4326008)(36756003)(476003)(91956017)(25786009)(6436002)(31686004)(6512007)(2616005)(8936002)(71190400001)(71200400001)(256004)(99286004)(14444005)(66066001)(6916009)(6486002)(229853002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6176;
	H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kIeeJyVS/rjDoiaMrxeG9to0pexVVIYc8uBmpYCK1nN1TVQ1IdntSH+HPNz4gPkId74ZpF72Qw/bF9CZNqCpAaqwnmREgX8F2sSGlkOtkmmB8fTD0b1ZYlsM08BS3vMMH56aq+MlblijRDubZ2gCQnmss86z3yM5Gc4uM/3q2XMw0/mbUHskVS6VBQZaJ1vysisle1u3VKJi1AFxlHJw96jx3Ra0NRnZctBa3NWCQEm06eJVJ8YB3VeBHnH/J+aqxQmQSstets7BAgr6JSZjHxDniSvB7i5LE1XBhQjHux4oLwiODP7zXlQse/83WwJZfRzREU89lxgzIzmZOE6bynBHR2Ekh54cqaIUrpVr/dF1KkX0Qeo+GTVJrZvOhJemHwk8fggMJjioAxqnclN/E0j46JJ9NlhqAUj73Cfg5p4JVk/BEfbwW2Flmr4gq1ar
Content-ID: <5BF3621345F8844FA6A5E2E8A59180E8@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404e478a-56bb-4132-4791-08d768f3ace7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 11:13:28.2046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kBnEN1YX8sPA+ogMn96GIe/r7YVcns/EfzObrXNCDID3sGuKlPml1h4Wi2cg6msE/fBWid4r4trIIuXsBSqcCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6176
Cc: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Leo Li <leoyang.li@nxp.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Camelia Alexandra Groza <camelia.groza@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>, Roy Pledge <roy.pledge@nxp.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>
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

On 13.11.2019 22:11, David Miller wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Date: Wed, 13 Nov 2019 12:24:17 +0000
> 
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> This series introduces a few new dma unmap and sync api variants that,
>> on top of what the originals do, return the virtual address
>> corresponding to the input dma address. In order to do that a new dma
>> map op is added, .get_virt_addr that takes the input dma address and
>> returns the virtual address backing it up.
>> The second patch adds an implementation for this new dma map op in the
>> generic iommu dma glue code and wires it in.
>> The third patch updates the dpaa2-eth driver to use the new apis.
> 
> The driver should store the mapping in it's private software state if
> it needs this kind of conversion.

On this hardware there's no way of conveying additional frame 
information, such as original va/pa behind the dma address. We have also 
pondered on the idea of keeping this in some kind of data structure but 
could not find a lock-less solution which obviously would bring 
performance to the ground.
I'll let my colleagues maintaining these ethernet drivers to get into 
more details, if required.

---
Best Regards, Laurentiu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
