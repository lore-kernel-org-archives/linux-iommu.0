Return-Path: <SRS0=zRLl=YR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFA3CA9EBC
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 07:49:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62BF52084C
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 07:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hucKS8iu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BF52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 34728B6D;
	Thu, 24 Oct 2019 07:49:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 26644B09
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 07:49:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
	(mail-eopbgr140052.outbound.protection.outlook.com [40.107.14.52])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2F85F87B
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 07:49:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=gUXpUnKvbfC+wZqBAVh5yFP84zLRapg8t5PsFUqDI3PrhdYIiY4P5W/EGhhuYId83/Jl4lNiYp2KKNzPgqvTLFblizTzKf02sFm/3X1HxfC7g1rntpN6Ys5fXzcsWBW0OxE10IE+zNvw+aNl6LPuSON9OJZ7GH3OGkBIMcVN3UzuEqI6yCkfSkHKIZyOe3zTih5JoEWXpu2idSOZWZ997MW8wcHA+dEIhpsZ0gU3ZdUnRnfQh3OuwLQZNm/VrxJPF6w9fAcSYuKnz5CGlF0+r9GhTW50X3NPq9lEze1mi/eTbSeJENMXxRkSaYGlwipwNwqY1C0Gc7nKddWHVC6Nvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=tQ5MH9mEysUW4bL432qsECcRaRrIC0mqKe8cZSnzaf0=;
	b=GgOHdxHs25kztN4DE/KA+qJFNXeISLfqNliFi8g/xN1C7SHw+b5eqSgIVs5U4tRK1gx1Ukl1SJtw4SvKcJGx273rTy0XK3fTIyxRX2jbQiu3O9xEC4SeZb/ECe4Qjb7eQCgTQyIvmko7tiV+HveTf51ix8YxvvoYylM27oDAxIW4/BkjLqdKyApcAEtDzcnbf42rQjuh2y0lcHjTUwhgKOdUj0MgLWb7ZmjDERdBXqz0yIeslsOr6z2vd9moCmecoHWAcsXP/pi/48r2dxJr4cx3ESURyNkYLz3y9kc5MYqTo1j3cUydzEdTa33Qo9ZCFFeQui+P8d7UpEGT41NhKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com;
	dkim=pass header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=tQ5MH9mEysUW4bL432qsECcRaRrIC0mqKe8cZSnzaf0=;
	b=hucKS8iuMJbMIpEML8XcuAln7JcM8dQeaAVWJQj1H8u5XaGy+YXGti9s6lNfKQVT/Gs9PboWxtaO7W1NkN2snaSHVXsIIzwctcaa6ZFy61CKHER3qW4dJbLeNNpunQxqhRRijGCyZnEpoJPyMvosbkZ3r3OOVoyk1N7IuJUdJYU=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.51.208) by
	VI1PR04MB4912.eurprd04.prod.outlook.com (20.177.50.209) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2367.24; Thu, 24 Oct 2019 07:49:03 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::10f0:af2c:76ac:dfb]) by VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::10f0:af2c:76ac:dfb%7]) with mapi id 15.20.2347.030;
	Thu, 24 Oct 2019 07:49:03 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC PATCH 1/3] dma-mapping: introduce a new dma api
	dma_addr_to_phys_addr()
Thread-Topic: [RFC PATCH 1/3] dma-mapping: introduce a new dma api
	dma_addr_to_phys_addr()
Thread-Index: AQHVig771lgo9fKx8UCeiOjKFT5WdadpauGA
Date: Thu, 24 Oct 2019 07:49:03 +0000
Message-ID: <ebbf742e-4d1f-ba90-0ed8-93ea445d0200@nxp.com>
References: <20191022125502.12495-1-laurentiu.tudor@nxp.com>
	<20191022125502.12495-2-laurentiu.tudor@nxp.com>
	<62561dca-cdd7-fe01-a0c3-7b5971c96e7e@arm.com>
	<50a42575-02b2-c558-0609-90e2ad3f515b@nxp.com>
	<20191024020140.GA6057@lst.de>
In-Reply-To: <20191024020140.GA6057@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 566b47aa-28e5-43f4-a5d4-08d75856a3c1
x-ms-traffictypediagnostic: VI1PR04MB4912:|VI1PR04MB4912:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB49125CA14F9CC1B4326A0F68EC6A0@VI1PR04MB4912.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(52314003)(199004)(189003)(14454004)(6916009)(31696002)(71200400001)(6246003)(8936002)(71190400001)(76116006)(91956017)(4326008)(561944003)(229853002)(6512007)(1730700003)(81156014)(81166006)(66066001)(8676002)(6486002)(66556008)(5640700003)(64756008)(66446008)(478600001)(66476007)(66946007)(6436002)(316002)(6506007)(53546011)(2351001)(2906002)(54906003)(6116002)(186003)(3846002)(305945005)(7736002)(26005)(31686004)(25786009)(86362001)(76176011)(102836004)(99286004)(2616005)(2501003)(11346002)(446003)(44832011)(486006)(476003)(36756003)(5660300002)(256004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4912;
	H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fFvD6/irDk36MlUmhZiGirNVQX+1Fw8ol8y9qJ6zFLcYLW0ToTca3ATXxjtOJx+tXMqqrjrCAgnX6qMI1ynze0Zi2/BNFOr2TeEtRNTogUyx0qPInUn1aw5mdZ2lixCf5BA1fx1V2rD+BOh2dwlZXhmrv4/fG3YMPbHGKTBBuBOg2bnIxybi8EVhu13jEtVujd/iStieVagQstld4twNzB8rG/c8XALEqkbDSJhQM4fxBem7FUrqnwvlPhJZcRGQv6VCblMw+k7SFf8J1mOjyq2K8rFSqIUc+PMzTY0SjP1RH1nOn4Rb1/TSAUz4MK5KQcBwDpgKB8B3qXgTAPST+F1HY3g/HIGZf2Sc4EWvdB9ULsdVqvSvX527xbZQA4+dt4iGuK5Or/kP/ibCPDrvJdB1L7i91d8zEvImdS8G07yTfOV9oRxqebPcHrpk2T1J
Content-ID: <975444B2A0E5ED48B1C92BF5D9BCD6C0@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566b47aa-28e5-43f4-a5d4-08d75856a3c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 07:49:03.2174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJWJQ0W9lCl3zNMbuy+H80YzerbvQfd2U/uTC6I1gFdTF2N672LMrr1SFLEaMfty3LfCzgCyGBGU/bvetBMIUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4912
Cc: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Leo Li <leoyang.li@nxp.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>, Robin Murphy <robin.murphy@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>
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



On 24.10.2019 05:01, hch@lst.de wrote:
> On Wed, Oct 23, 2019 at 11:53:41AM +0000, Laurentiu Tudor wrote:
>> We had an internal discussion over these points you are raising and
>> Madalin (cc-ed) came up with another idea: instead of adding this prone
>> to misuse api how about experimenting with a new dma unmap and dma sync
>> variants that would return the physical address by calling the newly
>> introduced dma map op. Something along these lines:
>>    * phys_addr_t dma_unmap_page_ret_phys(...)
>>    * phys_addr_t dma_unmap_single_ret_phys(...)
>>    * phys_addr_t dma_sync_single_for_cpu_ret_phys(...)
>> I'm thinking that this proposal should reduce the risks opened by the
>> initial variant.
>> Please let me know what you think.
> 
> I'm not sure what the ret is supposed to mean, but I generally like
> that idea better.  

It was supposed to be short for "return" but given that I'm not good at 
naming stuff I'll just drop it.

> We also need to make sure there is an easy way
> to figure out if these APIs are available, as they generally aren't
> for any non-IOMMU API IOMMU drivers.

I was really hoping to manage making them as generic as possible but 
anyway, I'll start working on a PoC and see how it turns out. This will 
probably happen sometime next next week as the following week I'll be 
traveling to a conference.

---
Best Regards, Laurentiu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
