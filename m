Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D43C4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 09:15:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5159B61029
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 09:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5159B61029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1789583123;
	Thu,  5 Aug 2021 09:15:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2a66JixDFOb2; Thu,  5 Aug 2021 09:15:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 01D4D82778;
	Thu,  5 Aug 2021 09:15:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8288C001A;
	Thu,  5 Aug 2021 09:15:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96323C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 09:15:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9327140417
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 09:15:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vOecmENgoM33 for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 09:15:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300091.outbound.protection.outlook.com [40.107.130.91])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BCF01401EE
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 09:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7SYhsQMB4l+cwhSidB/ZtepfF/cFxaugjjbtyOZcVIsrSM6q2Wywg92POEDJkXo8gjEblAQ429vmRUFRgNuqnYMk1/ndOM4dFKwjFMOlhj8WiCRl2j1+D2fiyUtaWumDAKepxz/1+3OAgD2GQcd6/SKAyCCC1F/eVGwsbDa7meB2xXDPLwnp3Scb2WuQH49uYr9rMucDcSRcVeo04hFDNiROgmSamFwCb6VxHKjTU4bTuwaiOjbT7XnzB2QlLykTLsxG9LnFOjREMqbuoVahgHAAJZyQB8gEbY6GdiWsDlMyzeX6F5vMFazBuUpvrR0A+ZULpiMkgzHSx+/m+RP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfhnP4duEt0rQ+tzV/ZBRilwS6G2jUQqedrEsZ2c+w4=;
 b=UtJ0x4CK2p/Yu1O10GtsAzZipWlVd2h++NLWZC8ows6nrvgIQgoGO6Tg7aUd8+X6Glj/JOK0twqDzWWOvXXbzN5OPW4c2KeXcJvTIJtsB83as3cSsxKFKM0be0al6kzIz3FHBuZycMB1m6ZVDAvNkHv+L/0FsrieElo8QuLAwnER6fO7lvlQIVq57IOSxkeTfx2iay4TyhuuYn8lXddsxc3G9LG/xozQCYBb0InlkfVgM/bPHRhklLD8IEMGppzOZB+mJGyURiq7s/Ms9pbsas6tTlMvJXGrdkeJlvgwIoMzSDVXlOwESVswgYP4xNlFbnh4x65j9If3F/XDIrNupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfhnP4duEt0rQ+tzV/ZBRilwS6G2jUQqedrEsZ2c+w4=;
 b=X4z6DaC2gqIWFiWEZRJQheUZtaS70yX4wpN925HflY1ZHBA0dMMCBZiwb4V0dfC9EEOGcMmif4etPktM1R8Kq19TMicEqjXbB6rsUkgJGwZ+ymjb9dEvsT/0/rgHHktSgeia0Yw8W0XrM0886zZxgw8PpGZf349Q9asAmNroGts=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB2171.jpnprd01.prod.outlook.com (2603:1096:404:d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Thu, 5 Aug
 2021 09:15:16 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::7db6:310f:a5ed:82f6]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::7db6:310f:a5ed:82f6%3]) with mapi id 15.20.4373.027; Thu, 5 Aug 2021
 09:15:16 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, 
 "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v3 01/25] iommu: Pull IOVA cookie management into the core
Thread-Topic: [PATCH v3 01/25] iommu: Pull IOVA cookie management into the core
Thread-Index: AQHXiVRuiRPJzKZWwUWHKsKVODgthqtkoGMA
Date: Thu, 5 Aug 2021 09:15:15 +0000
Message-ID: <TY2PR01MB36926E2F76FDEFD87564C3B3D8F29@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <cover.1628094600.git.robin.murphy@arm.com>
 <46f4cda8215bd5f8a9f9fd5a4a6451805f75efa3.1628094600.git.robin.murphy@arm.com>
In-Reply-To: <46f4cda8215bd5f8a9f9fd5a4a6451805f75efa3.1628094600.git.robin.murphy@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db643699-1216-4b3a-4f0e-08d957f189d6
x-ms-traffictypediagnostic: TY2PR01MB2171:
x-microsoft-antispam-prvs: <TY2PR01MB2171CA1229206DAC1ABF1490D8F29@TY2PR01MB2171.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DHZtOyJg/5935jiUFn1zRxcz/Bd7ywtHBeS3U9BIrs8bSEBb252uSuGzIxolObvJTecRz3B8OsaFaYh5IloqnkMHiC8HWQEV/iI42vUJl82HQemXmd1+TIC0BGaDsDPqBnFvTcE96bU12a6fjiZ6wdwMaYDDsRLGN9/jqRkrjdqaThRdjoS+dVvSjnl6MdKZcyskwG4AxHaKmIxUrG62NJsvdAOuQFE07z/E+00Qch6n2jb6iDa5QxoIHjU4mpyGn0x0xlxpzdZycGsMeeNQTC/PxXMfyiXH5LwuKxUcvCfYV46zjse1EXcH4Ig1vWUKsAhYnc+KhHW3XjkRXIkDyUwW3s3ePRS+jyqiIZ2C2cVRLykIx4HCN/5+nYgjAX7HFwcSWiqTc408EwM6EL24xCj1xZzfKhZUjRDzOjQ0D7l5n0i0xe+ontUN/T4adti2tlN26a+ad0Up2+2ExYRRLKegJN8Gym1G9Gt6fJWidDTANDcpi1pDU7k8WN6KmVC3x7O9WWzFCMLCfujtJ40pPUeGMmaGC04jg+LEnyNGfsgI7Gpn95jEzQBS35hKv1lTmlTG3A6Oz6lmPD90luS0jyxv4VJaBa5slEInJ59PjuJSR+XxYaQNIwDUdlUpJVznNyGXNesVxwF7/TYKR6vHSr0ZPWPdS0wGS65jD6tZz7HzKWio+hw5ddiwhkuoWIu+p8L48+VimWFQyxyYkJFTDA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB3692.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(122000001)(8676002)(55016002)(33656002)(7416002)(66946007)(2906002)(5660300002)(7696005)(66556008)(66476007)(64756008)(66446008)(26005)(8936002)(508600001)(71200400001)(76116006)(9686003)(52536014)(4744005)(4326008)(55236004)(38070700005)(6506007)(54906003)(86362001)(186003)(316002)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LnZJGaFvzQmmnVSLV8+t0id2q6cfWbsGPgfpm1utL6z3QUNZ3mQbOBBwZ5/8?=
 =?us-ascii?Q?B44A2+i4DUq3Vse8DE4spwzhbM/crbVb1NR5JtRWMfdVO6Cl0+AnRMwxtVx0?=
 =?us-ascii?Q?vLw6wcAI52qoOL2llXLn4nIiP3szM2hcFvbRZTgOnKQH3cPdy3VUKvbwv4Xa?=
 =?us-ascii?Q?jdyx9PaLbM3uYrgb7ap9dh2xigr/4CQqohfb9QcaYrKoFPRfXkj9jh6WcMYG?=
 =?us-ascii?Q?Rp9giswPqy9jS6kBgYilGtgherKN1k8AEcN2sffplK7YmF9vnLE+Uk18ynNt?=
 =?us-ascii?Q?dlQTkcjTiZKNX9DflyDiWWeFXbBrXWqvZN/uDodmLp3bmCP9m1Nu1ZJRo2oY?=
 =?us-ascii?Q?8vG9mr6N7sUSUGA4GA2EhWQtpzRi2xw+FXnz0aRUZL6BJOLz707NGS9Z1Sbd?=
 =?us-ascii?Q?Dsr1Wid7o8w6BC26LxY0Q18t+D7ck1o/u9cNNJODQC0SnIvLD1uRKXq0LGCr?=
 =?us-ascii?Q?SqLCg7bpd6R1bsTeaojjQSpftsdVTA9mKkZMvOeb2bNYHIjl4rw+N/IYr16W?=
 =?us-ascii?Q?lyuH5+tSL53E3M2NScW81dGV17IuAVET19QE86eRg2manNYgEY7bUKinFuou?=
 =?us-ascii?Q?lNuyA/2XTWDrvgVyvmlK4yiJmUU6kKIxJAIPODTRP966BT2ahf6feRy9rTT+?=
 =?us-ascii?Q?xi0b0VzsbRNefSTB5McYlXZtzr0wQCPf8RQXQYAzuCvERj6YQ7F6b9nllHrp?=
 =?us-ascii?Q?+MP6BzCjDFgKoOyZkPfgvE4gpqjjIE0on3YKMfmsh+zPHljKipF9BwmNs2oK?=
 =?us-ascii?Q?d/iQQ+ycgoLWHZZG+wSP63+llvP6adecp0RmknuztmEZiT01JNitVJp66UcD?=
 =?us-ascii?Q?odpWUK5WzO4RjvKJpi6z3drd8XN0SuXpvGBEw2fATLCjCYa/FgV0AvjiP4iU?=
 =?us-ascii?Q?buaHCZf4Tvgw1lkYwgnBI/77L9NFexPscho9UX18CLPptbRDtm2JgNPFE0Eu?=
 =?us-ascii?Q?LW3YpC0VUyUniQ9BCvfrxcDHGbag317AzGQhWva/t5Ecka1VxYx3y9b3HYmy?=
 =?us-ascii?Q?cXdZb0LBNUPGQ7LWnYJsG0oGuKXJPVG8KGdZBr9HP5dIEvNzKOjoumbneYLF?=
 =?us-ascii?Q?mLa6mGs+B3qZdDpns/pWROhqAONLz6jT/gIye5cAQhXj9DF5USzsUl5O+mjP?=
 =?us-ascii?Q?r9BAVCvSpUUp63UnlTnthAmeoLN6e96EKbvURV8C6hLVmC3nwd0wkD+FGMzE?=
 =?us-ascii?Q?AUZA5oZCR6TefOPBm+JrpngqEvEb/rDNSUt4J+pe38OiOx/6ylzo1Vr3uYsd?=
 =?us-ascii?Q?bB4pJ7mWHnkdhA9gy6v6WyCsjr7mRPJHlMgCWhCWev0vWpbqfJK61SyqY3Bk?=
 =?us-ascii?Q?iVcdYesxVFnSOXJFEPFxhPKm?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db643699-1216-4b3a-4f0e-08d957f189d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 09:15:16.0014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBxZ/qPd5q5ENQQ1U80TZfckAhJ35fPBRYGSAPUBeMgtZXxBWjkUubJNd/r5GbxbeFW3EId/UooZxawTnX4HXg01fvdb6NbN/N/K55x+epYh8fpBwTPDssUbk03VrPur
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2171
Cc: Maxime Ripard <mripard@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Chunyan Zhang <chunyan.zhang@unisoc.com>,
 "dianders@chromium.org" <dianders@chromium.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "rajatja@google.com" <rajatja@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Robin,

> From: Robin Murphy, Sent: Thursday, August 5, 2021 2:15 AM
> 
> Now that everyone has converged on iommu-dma for IOMMU_DOMAIN_DMA
> support, we can abandon the notion of drivers being responsible for the
> cookie type, and consolidate all the management into the core code.
> 
> CC: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> CC: Geert Uytterhoeven <geert+renesas@glider.be>
> CC: Yong Wu <yong.wu@mediatek.com>
> CC: Heiko Stuebner <heiko@sntech.de>
> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
> CC: Maxime Ripard <mripard@kernel.org>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thank you for the patch!
I tested on my environment (r8a77951-salvator-xs),
and I didn't observe any regression. So,

Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
