Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED762CCA479
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 22:32:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84901846F1;
	Wed, 22 Jun 2022 22:32:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 84901846F1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector2 header.b=GhtKPm9a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KFktCGP8CgsN; Wed, 22 Jun 2022 22:32:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1F380846EE;
	Wed, 22 Jun 2022 22:32:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F380846EE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2E57C0039;
	Wed, 22 Jun 2022 22:32:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1DEEC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 22:32:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AFC1B846EE
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 22:32:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AFC1B846EE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6mEFNZxvE24c for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 22:32:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE251846F0
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE251846F0
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 22:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYrXGTbDAx12Cz6ItLjA4/5bLafwQo3Rmja2WVm3C45uRuqFsK6C49shAsnF94jYP8ZyqzRxU989e6vorGt66SbFHt0ek+iVhgT7s89CuU+VmbDTRUyPUeOdHzw0DAGrxsQTaBrtpxpGpWypKT/bHeThjzhNQplQB7pkzqEWrBayWsT4mtNPmNuprAAT9j0p3K9T7UofQFck6+VBvlhsfoT3VXkKlY7dChR4FhWXNliU37WEDS0LMpq4DAJWSlhkrW+8ffTA1fVMJ8feqOZgG5lFgMNf9SrOalwJ2JjY8eDt3b4QMy1plLZrsQv4Oo0WYifziHqrWNr/nuQVWSSB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYNteLc0oXHmmhGb51wXEs5y3AJN6oRkC/UAfon/T0M=;
 b=HW/CZckAqpDuUwKPvix69JCCL6kgMIw/YchcDl8DCGOSRe79B+8eY1AzS8WvcxhyPpfPtG3NEu7dtPrH7XjD/Uqy3QIxUVhqqNVfbaT/n7fIrjbRkqSwZRJacLV1S8Is4UrgwpXA2MOPbivaLlZNcImRatvGqql/CZlGRt63+spAJq4vS/cm0lbl5E8dmcZsDKDMh4XRpv44kPqJiwYbDU0lhhgafEZZbUQpaEs3xHiaoTC1CU5icQUOpgEi8sagRP/mhLw99+HeXlkVPn7kq3hR5GuDuu0+UY/0UjOqid7OIp3IYuELDLvhfDkO0OZijLN7ToTQJFH7nE3EGwu/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYNteLc0oXHmmhGb51wXEs5y3AJN6oRkC/UAfon/T0M=;
 b=GhtKPm9aiQ7GlDSGs4wsxeRhWo6laiMywJ8QTnnH2leiIgKpr9qhUbhCefSyytqFiZwvshLSblxXpDh44w29MN5JpAbpYJzO5+OeJYKXhXtelcUp+pATrUbfGoZIq5btSxu8gmRSyT7cYHfqo/r6xzKAYlZlXBs9z2D4P903b74=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7114.eurprd04.prod.outlook.com (2603:10a6:10:fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 22:32:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 22:32:06 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally
 <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Subject: RE: [PATCH v1 0/2] Fix console probe delay due to fw_devlink
Thread-Topic: [PATCH v1 0/2] Fix console probe delay due to fw_devlink
Thread-Index: AQHYhoNTqpdzQgAFwEqvJEpPmUMPoa1cAlLQ
Date: Wed, 22 Jun 2022 22:32:05 +0000
Message-ID: <DU0PR04MB941733BFD323D3542B7F75A888B29@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220622215912.550419-1-saravanak@google.com>
In-Reply-To: <20220622215912.550419-1-saravanak@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f247e3f-a76d-4d2f-0d05-08da549f0959
x-ms-traffictypediagnostic: DB8PR04MB7114:EE_
x-microsoft-antispam-prvs: <DB8PR04MB711465B6A0588A7508E2A74788B29@DB8PR04MB7114.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U3bXUSghbJcAsnTF3KmCzAfEvamP2+yBqlkuLyN1hso3KPDfOC3bEKEJGiYZV6j2esPpYoEB8XLLRP9af42MdnL+awhpGILtC4138xmXkpwkFg9zSx8L376By125Fw2vOBfdxKFISObgL+0Z+8F87nQ7kgzAi8H+BCCLRgLcXVhvmS9gAwtCmM5n8ufv3GRxtvpLpXAsEIpp+JvIKWg00+l9kbZHXkOR8g+MN5pUQQjJLq/IHoTtvfQR9CmpwdA+2EuxqnuDKi8A7njaIjg9ANLF1v6+lZqoz8z464qZ1fgb41cpkE0Crcnapeo7P2lnzPk3Ux7OeV5Wy3WTGnfgUgLwH92VrctC53QovvNSYB8Dew3QYovhHTSRilsLXLTUiO44bjnANNxzc+Lz3GlJJw3bhLkcAJ+Shqvaw6ElkFr46cGKQHvNrfLqvr6Je4r8lyDji/TMxJZVn+1+olV6vsWFYnnsOu/FM76kzMipBRQp/lP+MmLDz0NornmTeZjS0B2LBNqcdED+zvvoPfuXvhXkVFsMv+Y49Av0gn1IX8REMwxuSexQ3HJ9AIB0/zhhIaMbU52sIqayXuohe0SW+Wkx/mWqwmTxUvODio2tPl7Iqi85XqHAaY9EVZp2AwSdYCxvI+pN4qdU5mw8gsX2lQuDJfEh8Kmr7hKKBGY5J7SP9OZ1Cs4yTeDNtjHq7uFCYqEYHsPntP1du+levYwOaiDvf+PpBc2MpZdTqEADaJiKU7LcqXSn5rkii0Nv7nA0BUHrFR7NA1mE1R62r3q7GhUIXZ6bXkNp1Yllv59n/Mo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(186003)(7406005)(6506007)(76116006)(7696005)(55016003)(5660300002)(7416002)(8936002)(83380400001)(71200400001)(38070700005)(44832011)(66556008)(122000001)(8676002)(110136005)(2906002)(4326008)(316002)(478600001)(921005)(54906003)(64756008)(66446008)(26005)(66946007)(38100700002)(41300700001)(9686003)(66476007)(86362001)(52536014)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHowOWczUWcrUVRQTHhqdWxMbW9ZcVBHb1lsUEZENC81bGlnQmhram5Ya0du?=
 =?utf-8?B?YmhMdEM5bVZOSjQxZHhVbWtxT3plbC9VeGowblpVNVk0ellEcVExNDdaZDY1?=
 =?utf-8?B?Y1J4ZVhyY04wcktQNU5sWG1IeEd5QWFpY1lqV0wxWnpsRDJGRWJyZUZOR1d5?=
 =?utf-8?B?ZkZGb0xOTmVsMm8zaHArdTlnSHVLcGh0SWxHZG8vVVc3RzVuR2tVSnRIU2l5?=
 =?utf-8?B?K3hBRmZIclhNYldyT1kxeExzQWdOdXEza1ovb1Z4R05HWS94YjY1eXhDYTNz?=
 =?utf-8?B?Qnd1RG96dGxpdEFKdW5WK3JuWDFWSGRjTmFhdktpNWE4VXYwbDA4UHNCNWp3?=
 =?utf-8?B?RnZHa1RQZEQyMWJIT3hrQllMeC9GVHg1eFBuRFNydjlESmV3MEtwRXBOUnkz?=
 =?utf-8?B?L2d4bDBCRjc4cjNCVUZiUzJMT2dabU40c2NVM2VaNCt2OGdkWDZaYmtMY1Nx?=
 =?utf-8?B?SU9MMzZ5YzQ2NkthVVNQdEZ5TjRWMDF0WUVROVIvMS9kUDJHeFh2MkE3WG9t?=
 =?utf-8?B?MGFRN2tkR0pJL3ZVRkx4VmpDVUJUd09DcVg3TzlxTnBjV1F6UG8vVmp0dTFn?=
 =?utf-8?B?Q292Yks1SHdTOUpoQnlPWENoTFdVVEZwRXgwL1cvVk5QWittTE1XU1pveHJI?=
 =?utf-8?B?VStTbkp3WWZxVWJNNEE0UmxObkFieE9mdGsxbkNoTXVIYytpMWpCeU1RTGJW?=
 =?utf-8?B?Y01hUU56dEtZQ094RTZUWXlNdzhZcEduMGVhWmlDYjBJRTdBTXYrQnVNMjAw?=
 =?utf-8?B?MDJFcEJoZVB5YTB4Mk5aZEg4Uk1IaHlmTTQzRkovdFpXRzBObHUvL1k2VkZV?=
 =?utf-8?B?UVhjR1lHOGhlRGNuVlp1dXE5RHg0RTc0UXRNUGFPY3RyTis2bTFHOEU3bVFV?=
 =?utf-8?B?MGdrTVVnV0NwTW42SGIrZ2FnSnVFYWZjVmtuSU4xU29QNnlUbEp5cXdoWk5u?=
 =?utf-8?B?dThmSGtnblRVL1AxT3FVVW1PZCtqZlZoSlZDRGEyMnYxTFQ5ZkFyNThuRjRq?=
 =?utf-8?B?UUp5bGRMb0Vpb091V3FadGdFV1lFQk9XQnVFbTVQMG5Salc2cjNhRXNrajAr?=
 =?utf-8?B?Znh6bzQza3FJOC9UdnZQR01STzhmS3p4SVJOZ1oveXVhQ3NNK0w0d3AvUGtT?=
 =?utf-8?B?Wi9pOHZxcGZEYUFZcVpYcWkva3BybWNMSjJ0T25GWWpyeGxPdWZ5Zkh1WlBO?=
 =?utf-8?B?N3dFUENRMmRoYmo5SHJWODVaN09IS1Nib0IwUk5YY1Y4eEkvaytPQW9IUEZM?=
 =?utf-8?B?VXNmdGpLcGZKTFZnSlo5VmpIWmlPNXZONFlpSGplUlFhUlM5OHVjYzVneXU5?=
 =?utf-8?B?dEpvc0xvUS90VU9rWEZ5c3dzVExyTndNK1d2emFpZENHU08zTEZlei9sc1E4?=
 =?utf-8?B?dElUQ0hGcDdxbFhkaHovVEdiTUp3eDhQdmtRbXpDbFk5b2lZNnNnRDBCdWw0?=
 =?utf-8?B?T2htRWRib3A5WEZ3Z1VHZkVicnZCTkpmWTN4TUJxZWFYZjBObldRNjRIdlZK?=
 =?utf-8?B?UzhvNVhjcmtFVnJ2cEVHY0s1Z1NiQmhOZy9jZmlsT09rWVJDMUdkclZHSDlp?=
 =?utf-8?B?L2dWZDZTRGxONXlHZkYxVzRuTkFxbXowZ01GMUtUYVlVUXhRYnYvWU10T3Fs?=
 =?utf-8?B?cWFBWUhsd1JVdEl2cVFZQW1Pa0dkMmtRZmVuWS9QYkNUS0o1OVdyZFZVTWk5?=
 =?utf-8?B?ZEhkRkNiQnBDWCtOUUNMNzFaYjkvYSt4bG5jdUJwQWFzRVk5bXh4SkhOU0tZ?=
 =?utf-8?B?YmRWaVBUT2RaakNIWGJ5eUFMT3FQaXFZR01LZkJydmZXellOeGhvZ1BQUzlI?=
 =?utf-8?B?TnRWK0RIL2hhT2lBaE04bWx6SHJNRkdWN3o5aStHRVFJYndWdXFCK28wR0dp?=
 =?utf-8?B?RVc0cCtMSlhpYUtvNlVTRHlUcE5TUUVXTTNaRU5iSTAvSGhuUnorVlhRQkdi?=
 =?utf-8?B?NWdlU2pZWlpnUWplZEtpcHJieG0zbWk5VnY0KzBQa0pOaFZMaStHNHBWYXdO?=
 =?utf-8?B?SWllYjg3WTduaVNJSUhrZFlMRFhSTDhGQ2VJOFRJWW9valoxbWhPYTlqalRY?=
 =?utf-8?B?UldZS21hVEw1all2aFVxaWJwNTZ5V011aTNDZFZkd3hOVmVpT2pFbU1OSVpi?=
 =?utf-8?B?U1c4WitEMVNlY0M2NStkU2hSUEdlcko1djZKUjZkWjh6cFllOTc0ZlUya2hO?=
 =?utf-8?B?S1RyNy9rNXM3T2lRTGFIby9PNTRGbVl5dyt2MEpzcnJNSnArMTJnWDR1UWkv?=
 =?utf-8?B?dVdFWEJxSDFKYUMvUjRLNTJtYlNaY3hFWmZ3b3pFVFpnRXhVbzBJVjQ3YzBB?=
 =?utf-8?B?Nk9NdGhBY2xWNjA1ZE9lT1BBb1BNdVYrK1VkWDZSSGl6S1hldG1wQT09?=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f247e3f-a76d-4d2f-0d05-08da549f0959
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 22:32:05.9241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZM9n+CNU5DqHelOP1YQ9aPpCJ7ZrwMd8Znd1zPtiD7Hm47aP5kEL74+egByiHxa0O4/mxS0uTCOBKudXR/4m1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7114
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Sascha Hauer <sha@pengutronix.de>, Kevin Hilman <khilman@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "kernel-team@android.com" <kernel-team@android.com>,
 Len Brown <len.brown@intel.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 David Ahern <dsahern@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>, "David S.
 Miller" <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>
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

> Subject: [PATCH v1 0/2] Fix console probe delay due to fw_devlink
> 
> fw_devlink.strict=1 has been enabled by default. This was delaying the probe
> of console devices. This series fixes that.
> 
> Sasha/Peng,
> 
> Can you test this please?

Thanks, just give a test on i.MX8MP-EVK, works well now.

Tested-by: Peng Fan <peng.fan@nxp.com> #i.MX8MP-EVK

Thanks,
Peng.

> 
> -Saravana
> 
> Cc: Sascha Hauer <sha@pengutronix.de>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: kernel-team@android.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: netdev@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Cc: kernel@pengutronix.de
> 
> Saravana Kannan (2):
>   driver core: fw_devlink: Allow firmware to mark devices as best effort
>   of: base: Avoid console probe delay when fw_devlink.strict=1
> 
>  drivers/base/core.c    | 3 ++-
>  drivers/of/base.c      | 2 ++
>  include/linux/fwnode.h | 4 ++++
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> --
> 2.37.0.rc0.161.g10f37bed90-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
