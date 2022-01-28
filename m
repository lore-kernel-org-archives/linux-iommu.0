Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5178BC433F5
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 00:09:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C651A41622;
	Fri, 28 Jan 2022 00:09:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wFYbBYgHsEtz; Fri, 28 Jan 2022 00:09:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B0F7F415F1;
	Fri, 28 Jan 2022 00:09:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 780E1C001A;
	Fri, 28 Jan 2022 00:09:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0844C000B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 00:09:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CAB324019A
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 00:09:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=renesas.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HqK0u6Sme19m for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 00:09:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01on20725.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:700c::725])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F1854400E5
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 00:09:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjyO7eUAkzXdxxs3LOYiRwpAFVdB5RCWzCRLxFKWYIlr0QqoJxOt748ggb0wDYujKZOVgIBA0YIkfZz6UMkfOy6DGZ0+G79brmYJDrWv0FINMash0sJzNkAvM7C7yLL5xmBRapuDrelOpd0k4S19WneL1z4RpOfHkk7aTs8zU1Xqt7fL0EKOOQTtsncl2vok4Nwm74Vf2CHiCbS/soVqKtifU96zP9STkaUfCmaTXknUKiAEP2l6S1P/yvV3Kj0KPAiVPiKHyloDu2sOQOV25smEuKfwhhykpuaycZbW9AxtrTtGn4s4BkwFcRkIP/v+hEkMZ9nF8qwvZXVunr4Uqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFa+4CTDEvujI82vO4g69u2oD/9qlIf16U6DqB1jabY=;
 b=gUF7xUcXa9lzwtU1eA63IuoRoOLkd4NwvlRWvuKe/D3M77486BvSg80r1BxdJmL7LzF4LKq/bmCg7UuUaVnixDIZpMCpn3EEjl1ESt934SXoBKCOJx1LB5XkNm9P2SUz3kHhkzP6xk6H+LhJgZ9zfUQszDm7+ODypuROeUC/FnBTFed3aBtB0t5vk+W2g9o6n9pZsooG3ZF2aZC/+0jwnpn3wo30Y9zdVi8lc0Cu6c/d8kQnOXiPwS9/oignz0Gk7+vei8zXVJDKl+BvmxX9H+g5lYQPgGwE4hB2XMOdeCefxDwgQkYMBIESkKUeU9dyAEUoilA0ldBr5uVaiDuNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFa+4CTDEvujI82vO4g69u2oD/9qlIf16U6DqB1jabY=;
 b=kgFXi2VUZsk5HSixQf1O+IpVobCdyf1EF6qlhUyBMi/8BAKqaz5Y0y03pIA8/n49FUkbkFnJcQHV81PnAr4CoH2gBtck8TlNRb+0EUTuf5T3Onb0dJO+WM1G+kwr+0Ui4F0HhxeE5nsuHVkUYxIpEIZbrzkQb3p08itnn+cb0ZI=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSBPR01MB2309.jpnprd01.prod.outlook.com
 (2603:1096:603:24::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Fri, 28 Jan
 2022 00:09:31 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b8a7:7600:2af0:eea7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b8a7:7600:2af0:eea7%4]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 00:09:31 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [PATCH 1/2] dt-bindings: iommu: renesas, ipmmu-vmsa: add r8a779f0
 support
Thread-Topic: [PATCH 1/2] dt-bindings: iommu: renesas, ipmmu-vmsa: add r8a779f0
 support
Thread-Index: AQHYEerypcOcHYEUjUGCEHMYVKVwLax2t8OAgADXzMA=
Date: Fri, 28 Jan 2022 00:09:31 +0000
Message-ID: <TYBPR01MB5341EA35142A1AFCF75F591FD8229@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220125125602.4144793-1-yoshihiro.shimoda.uh@renesas.com>
 <20220125125602.4144793-2-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXgg8XApJETkN1oDDSy=N01kJaTz4DADyD9ZOM0ZXXttA@mail.gmail.com>
In-Reply-To: <CAMuHMdXgg8XApJETkN1oDDSy=N01kJaTz4DADyD9ZOM0ZXXttA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73d01f26-cbde-45fb-4c90-08d9e1f2753b
x-ms-traffictypediagnostic: OSBPR01MB2309:EE_
x-microsoft-antispam-prvs: <OSBPR01MB230938698FBDAD82AA1466BCD8229@OSBPR01MB2309.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5L3LrToKlFFeEs0+fbgAzRoYwCnQ7Q/dFOyMGOZNHRpD7O4D5bEaMzz8h08ytdhSXRHcpx3A5jNyjwPktR4dIrW/X1IoRNWvOpaO1Ou3PkyoBrMbix76FTNQM0ie6S8YaNk1rxgko+JyOsHLDoU0HujUx18sB9sZVWO7jOHAaLm2IMAHrc8vze07ZJAE6+UTvad8mBojhcs8rqWq8P+CrqCw/ORFSa1Ll8hpldJ5NnM5mpFk6Yii78H+owQ8ay3nbHp9bqBcPdkZCRA6WwkeySI6nyk0rd5X14+Q2sEGMiJpaqD/1e01FrAvSWh0esjD3v1fvaCfIJ3IrQa2Yq0MDGQ3MwsV5EwTJwhmydbGPN3rUPySrwRoXa4jj+j+bE+uysihKwp+HOHzpUWiuEego0M03yVyIG/zzElT96L3YaI0+QoR2ayJFacdVW/32LkEj/A6NOQwX/j8sqywtSkarIjdIXo3docc44J6SUihVh8kzY6qwQTVs48ndrQlQEJlXH94ixp9RHlRlyK/0DdETkGyoVjk23MUIRHkO5z49XlSimZdq2MBcrdB9DKEDfyteWz6XfNrYiO8oypUp1GyBJY1RBj+e3xiVovBXMwjZmINP8zGVRAwRqlZhJmHwxIzpUZsqal40UP0WEoTA2Id37OG+nwBwFNghHiOtNWZjFWYma9BmdoJFCHhhU1TJIunrHNzFCJgYp7+n/IHrsNxuQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYBPR01MB5341.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(122000001)(508600001)(38100700002)(64756008)(38070700005)(55016003)(52536014)(5660300002)(186003)(2906002)(66556008)(66476007)(9686003)(316002)(53546011)(8936002)(66946007)(7696005)(66446008)(4326008)(6916009)(71200400001)(33656002)(86362001)(83380400001)(6506007)(76116006)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dStMU3NXRkI4YmRoUDVTeEFOeGVEaHlxbDh4THRwK21tK0FMeDFSc2pBMHBk?=
 =?utf-8?B?bUlYOWZrMHdnYTVKSnpNTlhkOU9iSW56SzBRSFd6T2tQZXMwUjVZT1pmZEM3?=
 =?utf-8?B?Z1JGeU5HMkluU0xiVGppOWZwYXRSbkJwQkhWeG9rcjA5ZlhVbktleG5mc1FJ?=
 =?utf-8?B?QWIvOWljZTZEZytibzU3SzJsWVdlYml2THVUS1dsOVNDaStpOTRvcnh2cDQ5?=
 =?utf-8?B?WW0rRTZmd0tpclY3Sk9VSUJKdWYwM1J6aUszWG9MSlpCZzBiYUlwKzR5QTJv?=
 =?utf-8?B?RXlmNTdGejRGRW9ldmpKeDJlRERlZUxFUVI5L2RCUytJMWFYU2tBSGYvZW1x?=
 =?utf-8?B?T0pYSitIWFpxazY2QThNMktKakhablk4U1ZGUDBBUm9VZ1ZuL0szQ1hQQjdN?=
 =?utf-8?B?Sms0dTNybEVxbmdJdWFVeXZLKzFCN0o3dW51YkNCWW43ZXNSZ2hvWU9QV05a?=
 =?utf-8?B?NVJ1REcyMlB6dDMwM2dWOGd0U0FmY2drT0VOV2hLaHRCTnkzRTNQK3lsSFRs?=
 =?utf-8?B?ZDNidGE1QTl6OGR4WFJhRWFlV1c4NmNCMGpydE9XTzNqYi9DdTBZZVJ4STJq?=
 =?utf-8?B?NlpGUjF6VWYyTUZEeEZKSEdFYXhZS2dPZlc1Zlc2N09OVWNyUTJzbUlPNHJL?=
 =?utf-8?B?Z24rVGYvVWowRnJsVmNZUHA4U0VsZ3BxejhSaHNPSzh3elp1K0wzYnVwYmt3?=
 =?utf-8?B?aUlXdnZuQ21lMEF6MGhNWGFLSjU1cE5vMFJyZG96YklFaFZ2cjVQUktoSzE3?=
 =?utf-8?B?Q0JicEV1bjIxcWZteE8zU3o3QlJWcFpmWVdPYzEvc3h5eSt1SWhqejFzYnJ0?=
 =?utf-8?B?dVUwaGYyS0diVi9WMW1uVHZHMFpJVmorUG1RcXI2Nk5waXY1MmVrQUk4UmdG?=
 =?utf-8?B?WXcwRXpPUmZxdXRVT2VMNEtoWVhNYUxRaEhjOW5XdCtDNXM1TVdKaEU4U292?=
 =?utf-8?B?K2hwYjZLZHFNZTM5Yi9RK0ZCbHcxbW5HM3FxZE5OcTdnWHBNT3psMG13Mm1O?=
 =?utf-8?B?dm92bm1YQ011UnZOd1VuTEViK25RZnVmamtOakpmNEFiYWh0bTZGQmNwWDNz?=
 =?utf-8?B?MjFWWGxmTTFxZURxSmVsdU1QSHZhdWo3b1kvWjlTdXprUG4vZHZrR1RRN3p2?=
 =?utf-8?B?ck53ZEhRYUlHYlBTSlRsa0xhQzhiZnpVaWZ3bWI1VWtTRFZlNmxOMmpvUkF4?=
 =?utf-8?B?NGVXMkp6eDJVaEhVS2UvdnZZZzF0b2M4MTNYVUhHdndjVzFicGN0ZmxWbmMy?=
 =?utf-8?B?KzNiR09RdjhHQjVMcWdNaEdEU1dkRWVCK3puTnRqSE1HYlV0YzEybkkvKzls?=
 =?utf-8?B?TzlITkZJS2ROK21NcmtwZ2hBTmgzNWNURVEyMk1Xb1IzTEdwTEs1UkZSVS9m?=
 =?utf-8?B?RVc2WmR5QkRLelRoYVV0TnRKald1aVUxRDdxVjgrbnYwTVV3RUhxOEZFRGo0?=
 =?utf-8?B?WVN4NVNCd0VrZDkwTGZDcDFOR1RxNzBPbXZvOWF4Q3JjbUJpemJlL3MyRFZr?=
 =?utf-8?B?SVoraHJOZG1rdlNWZmgva0p2YjJSbHBzRTVlalB5OTEyTklxdXdXYUUxRXFW?=
 =?utf-8?B?Mkd6ck4rV1IyVG5OZnFmRFV5cHRPekIrSm1ock0yR2NGeTYzR2dHU0JJV2V4?=
 =?utf-8?B?WkZmL2s2ZHU4NW1GZ291VHRmZ2hTNWNGaCt4R1l6b3VCZkpPTlYxREtwRFo2?=
 =?utf-8?B?N0ZIK3owVTVVdFpEellOTUJidnc0Y0w3OUZ2c0JjRTBGYjF4SlJRT3VQOFBa?=
 =?utf-8?B?TDcyWE9MU0IyUTk0MUd2Y09mcGttMytxcXhqbzdma05MdnBudDlLNkRURFJt?=
 =?utf-8?B?VnFKSVZQZEVPRzRUOUVEdUgxWCtsMmhpang4ejM5bmxrcFdzQlE2QTlyR2dB?=
 =?utf-8?B?UnAwVmEwY090bk1MNGN0ZERWZU9XK3BEVUVJZDhoZThPaHJYZW94YUdjWEYz?=
 =?utf-8?B?OUVCR2NQTU93WCs0WWM0cGYyUzJiMzM1RWd5TkdNaE12b2hkU1IvSy9yL1pv?=
 =?utf-8?B?dU1PcmpJV0Y5YUQ4K3ZCbjB0MCs5VU96MkNtNEZaMlBmM0lkTE9UWmNxNGk2?=
 =?utf-8?B?TFhOOEpNbVBjYVFwRE90aWU0TFl4QXJVN3dpM3QzR1ZYQ2syRTdhT0xTMXpo?=
 =?utf-8?B?UUgrSVcrL0IwRExnZ0RyT2RNaDJidzFobFFENkVpU2dLb0hRUk9GZTZCWFhZ?=
 =?utf-8?B?WnAzbVI0TDJxSVZmcnRFYm9mTWFDd294eUZTNzZjbzE0cE5ON05TNnVVZCtm?=
 =?utf-8?B?Q2Z4TWtSQUw2RDJPNWtJdEU2M1c1OExNWFJKWEVmcDU4YVJybVpDZTNBQi94?=
 =?utf-8?B?Rm5RYlgxMWRmNTBiYVNNYzBnazlwRUdZVCtWWEhUbUNUMlBuOHM5a3E5UHBF?=
 =?utf-8?Q?3NjfU8R5bA6JhKIxEAiLR+sHkfmj+KNnIwdwg?=
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d01f26-cbde-45fb-4c90-08d9e1f2753b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 00:09:31.4010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjY19a6K+IPGJGi2LR8xiuKxNZLyk6OtW6eNtKA05eTTOWJX3PV+/LZLY65E2iAqq5c6eh/24ANrc91UuTz1BmSpcVEVORuwk4SjAn3u179zUFXkRBKUxVFMqPtHnOYV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2309
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
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

Thank you for your review!

> From: Geert Uytterhoeven, Sent: Thursday, January 27, 2022 8:06 PM
> 
> Hi Shimoda-san,
> 
> CC Laurent, Magnus.
> 
> On Tue, Jan 25, 2022 at 6:33 PM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > Document the compatible values for the IPMMU-VMSA blocks in
> > the Renesas R-Car S4-8 (R8A779F0) SoC and R-Car Gen4.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Thanks for your patch!
> 
> > --- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> > @@ -44,6 +44,10 @@ properties:
> >                - renesas,ipmmu-r8a77990 # R-Car E3
> >                - renesas,ipmmu-r8a77995 # R-Car D3
> >                - renesas,ipmmu-r8a779a0 # R-Car V3U
> > +      - items:
> > +          - enum:
> > +              - renesas,ipmmu-r8a779f0 # R-Car S4-8
> > +          - const: renesas,rcar-gen4-ipmmu-vmsa  # R-Car Gen4
> >
> 
> I'm wondering if we need the family-specific fallback.
> For R-Car Gen3, we don't have it, and match on (all) the SoC-specific
> compatible values instead.
> Do you remember why we decided to do it that way?
> 
> At least R-Car V3M/V3H/D3 have slight differences in the register bits,
> but I don't think that was the reason.

I don't remember why... Maybe, we had never discussed this topic?
I searched this topic a little on the ML archive, but I could not find it...

Since upcoming R-Car Gen4 SoC's IPMMU is the same specification with r8a779f0,
I believe renesas,rcar-gen4-ipmmu-vmsa is helpful to support it.

Best regards,
Yoshihiro Shimoda

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
