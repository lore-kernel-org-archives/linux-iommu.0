Return-Path: <SRS0=MPmd=TK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB457C04A6B
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 13:17:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D8121479
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 13:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hUfz837x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D8121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5C715E6C;
	Fri, 10 May 2019 13:17:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BBF92265
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 12:33:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
	(mail-eopbgr30046.outbound.protection.outlook.com [40.107.3.46])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9523F834
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 12:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=pXUrqKxKXYpJ9knrQccAiT5FJfTkcq9dCnjv0LZgUZU=;
	b=hUfz837xgLpvrmo4AoEk+zIFDL0tSK7BhkHaHouMZ4PwEHJWeF+zCOhlSj5L06kHOYjCI+vKSuYvceZ4xWWh4bGV22dto9VyPl4rjReobdUyw3MEAfNY5IdUmDj1yLlBl7Px1L99C91ncL+w278/9Y4kCNzM+7n3mVs4Fh9ESLM=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
	VI1PR0401MB2255.eurprd04.prod.outlook.com (10.169.133.148) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.21; Fri, 10 May 2019 12:33:55 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
	([fe80::5e3:7122:7d0e:7fb7]) by
	VI1PR0401MB2496.eurprd04.prod.outlook.com
	([fe80::5e3:7122:7d0e:7fb7%3]) with mapi id 15.20.1878.022;
	Fri, 10 May 2019 12:33:54 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Subject: [ARM SMMU] Dynamic StreamID allocation
Thread-Topic: [ARM SMMU] Dynamic StreamID allocation
Thread-Index: AdUHKxeT0UQZA1BdS6SusO/TAZQ/qA==
Date: Fri, 10 May 2019 12:33:54 +0000
Message-ID: <VI1PR0401MB24969CE24E4FB91EC8551DEBF10C0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [92.120.0.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b9b6fd3-8afc-414a-2ae4-08d6d543c428
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:VI1PR0401MB2255; 
x-ms-traffictypediagnostic: VI1PR0401MB2255:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0401MB22552794C48D6F16D903E7EEF10C0@VI1PR0401MB2255.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(346002)(39860400002)(366004)(396003)(136003)(376002)(199004)(189003)(55016002)(6436002)(44832011)(186003)(71190400001)(53936002)(71200400001)(6506007)(68736007)(4744005)(8936002)(102836004)(6116002)(7736002)(4326008)(305945005)(74316002)(26005)(3846002)(25786009)(6306002)(316002)(256004)(14444005)(33656002)(99286004)(76116006)(81166006)(14454004)(81156014)(8676002)(9686003)(7696005)(52536014)(66946007)(486006)(86362001)(2906002)(110136005)(5660300002)(478600001)(66476007)(66066001)(73956011)(476003)(54906003)(66556008)(966005)(66446008)(64756008);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2255;
	H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v5x2hG19gEvxcs/sZn995NyJLknGB7OIVwN0cg3FU8JiyhLyeVLxSPx1dxpgOk/hj2OFZuarmagTJLaP5oIEVRl7aQ0TBQrukItds9QJZP17chiw99HNp9vSMRDV3vhRYaj3Wfv0SFBvsTQbnOrzE7AQErHiuRFqOOtUDLFbYUN9jpn8X4Xsv74jFBlVoPoWVvfsy3WkglBmiVJO/5muPr22ZwXbmRTMtwBvgzxN7UkHKoW0s9A79qHf2+Svi3xU777O/FAX7xuFd6x93n2rpU2zd4ryUCRiouNdzfiv/DKtsM1WwE0fRLQbduQVf0sdilDZHZJwGJTS+z5VAgnKlPT342N3bou2wmXZ0fnXYRORF1dmEScEqtlzevUNxZlq0In+IuglKMl3lHsFsuum9AFHtA3ngZwBGX4KH0OpM+c=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9b6fd3-8afc-414a-2ae4-08d6d543c428
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 12:33:54.8094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2255
X-Mailman-Approved-At: Fri, 10 May 2019 13:17:16 +0000
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

Hi Will/Robin/Joerg,

I am s/w engineer from NXP India Pvt. Ltd.
We are using SMMU-V3 in one of NXP SOC.
I have a question about the SMMU Stream ID allocation in linux.

Right now the Stream IDs allocated to a device are mapped via device tree to the device.
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt#L39

As the device tree is passed from bootloader to linux, we detect all the stream IDs needed by a device in bootloader and add their IDs in respective device nodes.
For each PCIE Endpoint (a unique BDF (Bus Device Function)) on PCIE bus, we are assigning a unique Stream ID in bootloader.

However, this poses an issue with PCIE hot plug.
If we plug in a pcie device while linux is running, a unique BDF is assigned to the device, for which there is no stream ID in device tree.

How can this problem be solved in linux?

Is there a way to assign (and revoke) stream IDs at run time?

Regards,
Pankaj Bansal

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
