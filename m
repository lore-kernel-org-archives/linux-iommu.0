Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF83CC43334
	for <iommu@archiver.kernel.org>; Mon, 13 Jun 2022 00:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5883C60D78;
	Mon, 13 Jun 2022 00:17:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0P2Un4-1GGhQ; Mon, 13 Jun 2022 00:17:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 42F9160C04;
	Mon, 13 Jun 2022 00:17:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B85BC0032;
	Mon, 13 Jun 2022 00:17:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87B97C002D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 00:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61047403F7
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 00:17:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=renesas.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GGLKTbtXHHnr for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 00:17:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01on20712.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7010::712])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BBF214010D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 00:17:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yw85zDfscAaNXdBGCgWA/sdJcbBdM1G8pY+qgsr4xwTBOjjJkKHT29yzKsgMbVenEZzdDjLRU7ltZ+FsN2XOIIQmEs8ZBc5+NbxZnk/+s4y2pxObEMviUq4QK5+209Jm8jaZOTPzVxrNApESyih63gxIJmjyGw66+irGTv5yWKCaJNge5MSqxfoOUH+A46SQXPV9wseUdaLpfYoofR5Z0cViylDm+M3t9E2luuC3lx0l0t6rjb6yvG6ZirGidv0uBbOQnWT/mKhkuIk/YcQ9vI3gdHMt5ehALipJWGJjm9uBBjvFOtxutl2FO1Dxfp6UZNnO5AEMbUFtYYRXimPCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhOJefs20jpZEQiDw7uAHTA6CySM2+Fm76UUlbUKAeo=;
 b=DcqGJqAfsf3NhOwab63CZZlk71NLf9SqDyysjai94TLIEaXDYTGMUNjf0Q8qCsCbguoUITqR5ehXgExRbISb8ZSOAXhVxqKtr/MvJlIL4HZwbPj9l1lF6D24H86EVcwhh6KVG5J+3mvp9ywAdVx5QW5IyHooyxoQYC0BDfVQOvFfZ3gSuXdjUQkAnDaVB+kol5f0+XydK1g5Utc3D+jijZsrAIOkknSpEF5kzz8ZtzC1bn24NMtvABZ37SEDmBRY3wioCu9B0F2b884QfyqHK7RHhKHCZlDCQcThiH2zudmJuStP/DG03zjBGIcR5LEpRDa2c8ToFwGFpeNm1a9VdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhOJefs20jpZEQiDw7uAHTA6CySM2+Fm76UUlbUKAeo=;
 b=hDNBmTS7wL3GN1O4YCW/iiYa8Vm7Cgz//kVOKNeqRb0Ut8Gd++SSiKwlEnpn5A5qB9GO1dD0wOF9h5MhZF3iffgc9hMNIhLohud5HXGX6LjlEsioYhoym48dnA0Rnzi99fGCfdI53V+SKh5BA+HUw4b7Vp+3DgDupZpISfsF6+U=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB6526.jpnprd01.prod.outlook.com
 (2603:1096:400:9a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 00:17:29 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d%5]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 00:17:29 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: RE: [PATCH v2] dt-bindings: iommu: renesas,ipmmu-vmsa: R-Car V3U is
 R-Car Gen4
Thread-Topic: [PATCH v2] dt-bindings: iommu: renesas, ipmmu-vmsa: R-Car V3U is
 R-Car Gen4
Thread-Index: AQHYfLJGDtesU6kSy0SelTCXmAqaRa1MfEiA
Date: Mon, 13 Jun 2022 00:17:29 +0000
Message-ID: <TYBPR01MB53417DC3D91B01E66D3CCF48D8AB9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <36400fe2cc6b6dcc0d6984fb77338d4d163e84dc.1654855711.git.geert+renesas@glider.be>
In-Reply-To: <36400fe2cc6b6dcc0d6984fb77338d4d163e84dc.1654855711.git.geert+renesas@glider.be>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13866902-662d-4694-a9de-08da4cd21a2a
x-ms-traffictypediagnostic: TYCPR01MB6526:EE_
x-microsoft-antispam-prvs: <TYCPR01MB652609C97BBEFCEE98A63D0CD8AB9@TYCPR01MB6526.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWWv3gzuy2L4B1Na7FXvmUXHqOxxiHPM/LHd3XUqNj9aukNds3SI5Txd76+4RTzITQQStLTQzlxcZAhTcurYY6SOb2UoYBQDsPjwJacp1C+JtE/ak+pro6PC3oJLkl0DlaWVp0HsQp9sf0gHuN3D0t7kk8EddOQStjVqilbhFE1YyBZNwVVvI3PQkiMnmPnFnP3rb2VMtI3uFnONGvi/kXq8cHSlYexAqsf3moEbSR+OiQLQzMxvfSRRIpN25UcLTH1ZogXefV2j7h8ghjYZZX8rB6mpBuJ15p/nxKb27JGKU8/ucqYaLaLCZfR1O4yBj7SM1UTxF6k73fWcnQqwihIV4VoHdASC92uQnyi9PJ4zbLzQBWPDzjN57gpNLbX9iYjqtNmBMrFNdZVOkCLdBU4fQawoBhPBCA/ns75/TiUQUR/x3ZdOpHOTgTeEdidkcksf8Aajm6k4ygcCseaf1AllEDpdU4zK3bKkMNyLPCiEazsXH2qRZK3+nyxQdJy53SeJbq1xqyQ+XJfSoyqKq30bWs4x6KOkBy/gyIP7G+gW8lAsaGY2/keGdZwtCjpX01GgFrnxOEUuhYfMv5+jJr0Ump/49gtf7rYy1Fq9XU0HItRG8H53Rs/q87Rv8EhUeA9yPFw6y7nyrRFCBXQbyguC9DLCQ+l3/kQ5CxCP30nzD+X26GHwEOC/vqpTvnQZuh7KJzsx8pxFM6pmy79OQg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYBPR01MB5341.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(8676002)(38100700002)(122000001)(6506007)(8936002)(52536014)(9686003)(66446008)(64756008)(38070700005)(66476007)(54906003)(66946007)(66556008)(76116006)(316002)(110136005)(7696005)(4744005)(71200400001)(33656002)(186003)(508600001)(4326008)(2906002)(55016003)(7416002)(5660300002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VSx42EcFyDgodEFInkAS7/hwdikhx4TJAUngB9J/YP4QBBIXO1+unpQE6coH?=
 =?us-ascii?Q?SJbNPxuKdJ9xc4yTs8EvcBvRNbtMpDmQ13EFGCbTk5oWxfuzikAV1aBrIDXZ?=
 =?us-ascii?Q?XFSuVhSGTkbUVZ28eLBWjkAiYyrIxw8Jscy/LgAiachiYS2vw8OxFwrXmP0z?=
 =?us-ascii?Q?tEjJ1FUlN/rehmd+1WCmJ+oR31CWzTPAkb2IIXp/xaldfboD5rfj6q7cRzrj?=
 =?us-ascii?Q?xCyxHYi5wicO7yyoEKHdl6c7TjSAcvY2NtJZh0Xs18+JBmP+sR+KQgiL7Qfv?=
 =?us-ascii?Q?yqIoe6kaoLiO1b3TS72kAO30AlQPzlS186H9B12PdYkJRTFSIQkuC8Yymmn7?=
 =?us-ascii?Q?kvFvJ2b5Ssw9tfqBrlmajR6E6VfXJue+38cqKfpXge1dId55kQFr5uBcjLoe?=
 =?us-ascii?Q?0IkovVjrAOq/duPqes3anMEY5ZocdiI4gkf35dR2HAgRnQhS3bV87L/1K8Rp?=
 =?us-ascii?Q?d53wiJYEBn+OSyvFhkGJ+L+NYSVy5ur1CnY8PcyblYGOKKZT6P5NJiLmLt3F?=
 =?us-ascii?Q?FmXBYlErtYzFbVefZqybmZZwkRpJXiePyc2ZNKwx6Exxlmq6TBL831vSi6Tm?=
 =?us-ascii?Q?Jm6Yb/tslFrAUVgGk/TZACM/qrg3bbC6p5ZWci74Euefh4Xx1nxzydN9/r0O?=
 =?us-ascii?Q?cpKvoBwlkX/z6ECX+6+PLNrANKcA2qF7ykMSJR/WHYMjgGejh8b1Q13wbZwu?=
 =?us-ascii?Q?4YS90vTCfsUZ+zvIBlR2AxD4qVrzsQQ4ljZCaQ8Dq+F8L6z8xkaVrjBIozmy?=
 =?us-ascii?Q?QD/E5QJot2ONEcnXdZ73VkEJd6QfReqSpc/zb5QG4tcY+1vkKPfqUEKDXVNC?=
 =?us-ascii?Q?52UBTRuwaJjy7/gXOLrw39+s7wVhvMAyhWtX0gvRD9icjX5VIgVIydTUr5mY?=
 =?us-ascii?Q?RZCchUlqnmUAR/yeMW/PEWUgtjWNbUQq7Fr8yd0cM7ToMKNgewpZ9orUrcfK?=
 =?us-ascii?Q?PCPO8NyKneZJTzfte4wWrKySfvXR4Z53b539yGZ/wRvmBrz+uGw1iSgAHTnq?=
 =?us-ascii?Q?qyO3qRGb0DgDONF74/YisId3np8bIwLHSuJZbmKCaGpyTpIcAWU5ZeR+zM2m?=
 =?us-ascii?Q?DGEwvILCXNnbbpvoAS1DVgUSdz0SKkgJTPP022wMPQ1NN/pK4RqWTZXE8jgv?=
 =?us-ascii?Q?PJJ7SYZpYSKsQVUN/0zuiroMAm/9ym77CL+r2hEg7YFNuo4bCEsR7MTdelwl?=
 =?us-ascii?Q?LNi4938sRtA1STpuS/cD40j5z54AmC9j5Pe/kCdI5GaHsttU7iUM11ZAOd0Y?=
 =?us-ascii?Q?MAtU6MSxACeAZSCu8mazD95rHKr+A9WDJAqhkLb2XuSHRptjP9M30OaU5N28?=
 =?us-ascii?Q?vdXlpCjxj9Bruh1E4xDplMse/Kt408IhvBcGL17aGBy7SSOpuIWaH5Ae3bLe?=
 =?us-ascii?Q?NaynnYBoEzDQWYSFL1FhVUonBJ0LD183flG9TrJigu3VhB7CdFgLuZr+6vFc?=
 =?us-ascii?Q?48dcsNHAWojmiVo8uVxYiRSCQgwzJ7QBS7RJ2qIUXqlSnQtUWxtq9OepmNab?=
 =?us-ascii?Q?nBuoz2bvclkK1y+oq+yCr2KeGapXgaV0Jcmlj9DWq6tX2wj62GAQa87/lv6K?=
 =?us-ascii?Q?eveluYAzoGYNDZG1ukFIer71AFq80yyw/n2eXLiseaW3RE+J108m2BP/LThL?=
 =?us-ascii?Q?Cg+odiRlek+92jJqezCl4j8mTjrn/3fdMcXI8t7IiQb8xvp+41QTIrPsye/i?=
 =?us-ascii?Q?V0Rq7rzCSeRoWI+p47MjalTKHPds6k0V3In1ZC1ZrUmyDblE5Dohqu8sAwMf?=
 =?us-ascii?Q?Mj827BP8Ugy3nPMbTEMrVaEUhrjgB6/3y7LvqJEZU6VTEmX3zH9QAGRYalkK?=
x-ms-exchange-antispam-messagedata-1: mfWByGfEpSt7fNA4doqDSJHtsYHvreMnmNk=
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13866902-662d-4694-a9de-08da4cd21a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 00:17:29.2037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4O+TKPmPgDsl95Lv8kukjETZXyxFZZzSqy0B8oDWjz3n60olJbOc4gB7fqN12DEIPpy8XlffvBP8LDf5su2bInUoWZUnnp83zJk2WB2TTN7ECpRfAaYJqlwzfhHvS6FB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6526
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Joerg Roedel <jroedel@suse.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

Hi Geert-san,

> From: Geert Uytterhoeven, Sent: Friday, June 10, 2022 7:10 PM
> 
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  Hence move its compatible value to the R-Car Gen4 section.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Joerg Roedel <jroedel@suse.de>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
