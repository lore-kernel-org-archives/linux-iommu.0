Return-Path: <SRS0=HAYh=TN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC69C04AA7
	for <iommu@archiver.kernel.org>; Mon, 13 May 2019 13:34:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1EF20862
	for <iommu@archiver.kernel.org>; Mon, 13 May 2019 13:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dzdlrm4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1EF20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 08CA5DC5;
	Mon, 13 May 2019 13:34:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B88449D
	for <iommu@lists.linux-foundation.org>;
	Mon, 13 May 2019 13:34:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-eopbgr150081.outbound.protection.outlook.com [40.107.15.81])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5E63127B
	for <iommu@lists.linux-foundation.org>;
	Mon, 13 May 2019 13:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=51nOMgyPMv9hkAmh+/0TQCoCoGxY33f/Y81SzW6bFtY=;
	b=Dzdlrm4m3+vJ+BI8u2jzrsmr+TV3CwrdnhoMxRprCBrFDwgYwgtaukB1rwVUGzNHzQ4KVoCINSxnVfn45NS5SSLNmtj8zyEXjQ6z4HeivYilD114rDLEhavc65UKKLi7mVlZcweZX96silhuCXT66DNwKkGhLsRadgCotR3IP1Y=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
	VI1PR04MB3199.eurprd04.prod.outlook.com (10.170.229.142) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.22; Mon, 13 May 2019 13:34:03 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::8942:6d16:631:413]) by VI1PR04MB5134.eurprd04.prod.outlook.com
	([fe80::8942:6d16:631:413%4]) with mapi id 15.20.1878.024;
	Mon, 13 May 2019 13:34:03 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, Will Deacon <will.deacon@arm.com>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [ARM SMMU] Dynamic StreamID allocation
Thread-Topic: [ARM SMMU] Dynamic StreamID allocation
Thread-Index: AdUHKxeT0UQZA1BdS6SusO/TAZQ/qACZO3ow
Date: Mon, 13 May 2019 13:34:03 +0000
Message-ID: <VI1PR04MB51344BE2FF0A8C09D123AAFBEC0F0@VI1PR04MB5134.eurprd04.prod.outlook.com>
References: <VI1PR0401MB24969CE24E4FB91EC8551DEBF10C0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB24969CE24E4FB91EC8551DEBF10C0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [82.76.163.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f26f3fb-47a8-4a54-221d-08d6d7a7aa68
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:VI1PR04MB3199; 
x-ms-traffictypediagnostic: VI1PR04MB3199:
x-microsoft-antispam-prvs: <VI1PR04MB31999E540A9EC19C1BEF736FEC0F0@VI1PR04MB3199.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(346002)(136003)(39860400002)(396003)(376002)(13464003)(51444003)(189003)(199004)(66946007)(76116006)(73956011)(86362001)(14454004)(305945005)(66476007)(64756008)(66446008)(66556008)(74316002)(55016002)(66066001)(2906002)(478600001)(6436002)(5660300002)(14444005)(256004)(3846002)(6116002)(7736002)(71190400001)(229853002)(52536014)(71200400001)(68736007)(8936002)(9686003)(316002)(81166006)(81156014)(53936002)(446003)(33656002)(11346002)(99286004)(486006)(110136005)(476003)(186003)(25786009)(44832011)(8676002)(4326008)(26005)(102836004)(6506007)(54906003)(76176011)(7696005)(6246003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB3199;
	H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PyxGOhB1gEKAZRS4ih18qvwMganXcu3jQx2lDwnif4jCp/dqFzOiIc7pp+E9zw0/WVN/qyJ2Wp7hL4zFOQ+KU08tcMr51qQhAhHNvoOveCucdB5iFNQYrIAddPLyhTNUp0hnOLHJizY+0xVw6nqk/fqbwvYzwRSOW6yK9j+DbXN2z376qK5yePXjPUvkRc/IQ4wRNlXWemKvqejyq4EG2WSAfJxkWMka9SsVXsWcwwmloy9/h4vD07QpUZkg0tTqWWIGsQmjHMpioA7UCJ6wfbdhZz1moWdSRSL+kt/oDD5lJW/K9iZdNr2s7Jt+LSq55GjuQJ5LhFR2Z8jglrny7TnxYkjToLEjjwwugjl53xp46mdjjM1MAQeMB/uhOHs0sD+k7uGUfkKi9NCKx6HsjFpxwvgUoqaw+fff9PNPXoc=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f26f3fb-47a8-4a54-221d-08d6d7a7aa68
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 13:34:03.6914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3199
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Varun Sethi <V.Sethi@nxp.com>, "linux-arm-kernel@lists.infradead.org"
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Pankaj,

> -----Original Message-----
> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> Behalf Of Pankaj Bansal
> Sent: Friday, May 10, 2019 3:34 PM
> 
> Hi Will/Robin/Joerg,
> 
> I am s/w engineer from NXP India Pvt. Ltd.
> We are using SMMU-V3 in one of NXP SOC.
> I have a question about the SMMU Stream ID allocation in linux.
> 
> Right now the Stream IDs allocated to a device are mapped via device tree
> to the device.

[snip]

> 
> As the device tree is passed from bootloader to linux, we detect all the
> stream IDs needed by a device in bootloader and add their IDs in
> respective device nodes.
> For each PCIE Endpoint (a unique BDF (Bus Device Function)) on PCIE bus,
> we are assigning a unique Stream ID in bootloader.
> 
> However, this poses an issue with PCIE hot plug.
> If we plug in a pcie device while linux is running, a unique BDF is
> assigned to the device, for which there is no stream ID in device tree.
> 
> How can this problem be solved in linux?
> 
> Is there a way to assign (and revoke) stream IDs at run time?

I think that our main problem is that we enumerate the PCI EPs in the bootloader (u-boot) and allocate StreamIDs just for them, completely disregarding hotplug scenarios. One simple fix would be to not do this and simply allocate a decently sized, fixed range of StreamIDs per PCI controller.

---
Best Regards, Laurentiu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
