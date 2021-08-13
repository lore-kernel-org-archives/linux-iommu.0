Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7EAC4320A
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 08:45:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E2B6104F
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 08:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 35E2B6104F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=motorola.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0450180AC2;
	Fri, 13 Aug 2021 08:45:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RWQRC-RWieD2; Fri, 13 Aug 2021 08:45:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AAECE80B23;
	Fri, 13 Aug 2021 08:45:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BB90C0020;
	Fri, 13 Aug 2021 08:45:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 717FDC000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 08:41:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4CBC2607D4
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 08:41:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=motorola.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id el3EP-1rycQw for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 08:41:37 +0000 (UTC)
X-Greylist: delayed 00:14:06 by SQLgrey-1.8.0
Received: from mail1.bemta23.messagelabs.com (mail1.bemta23.messagelabs.com
 [67.219.246.5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 439A06070A
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 08:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
 s=Selector; t=1628843250; i=@motorola.com;
 bh=rKrNuFLHswztvt3vcteEu63BnMguzJfPKV7Xbf+TJew=;
 h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 b=kFqq3ds0Z4BAHsmkCHPfQaPMKZVpOiX5m2Nz/34NHMneNIMXATIWWhsJKhz5wD0wL
 hIQH3ugEMClEj/k4mtiMPeT6fgJORp8CNqXZukJn31t+B8gFBoX+j9/QOjnB6E9u10
 KURoleUcfEN1GrErvFvVKKpFPrWrvzbGmK++hELZ+4FSSNny1XEUkLT2ORwnldnTyE
 fVWeq92DYO6ftQbBi6Ixf5NgFqXK1QMsGHIZDMp1FAaJ+wrM3hqZUlTBw9JUZ0zu+R
 KnDy+wbe3xYqoTgGw6pXenDtJscn1i9xVAI7DtzgK/Uo2GXsAahtZ20Wi7+JF9/Wp2
 6h5i0V6RPhmzw==
Received: from [100.112.0.142] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-5.bemta.az-b.us-east-1.aws.symcld.net id 2B/79-28183-1FC26116;
 Fri, 13 Aug 2021 08:27:29 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfVRTdRjH99vutiuwzmW8/RggMjV822CAdI2
 TpzI6NyuPnMOxU1Z6iRubbWNnd8iLnYLKFDjAkoVI21jEi84BttQKOXXAIS9FeQgUMSUa1BFQ
 FgGReKS7XbT65zmf5/f9Pc/zfe75XZQnNgolKJVnoPRaUi0V+CHKuHcSZZ4toWR87b043NzqE
 ODzrXd5+KnTXVzc9m0K/lObWYDfdCzz8WbXDSHeOD8jxDs843y88soC/0k/wmF1AMJt+VxIOO
 3FAsI5e0xI9FQvIUTlcBMgLlwrFBAz3wwJiPKzdkD86Vy92+8VvkqbkZ23n6881VfB1V2PyFu
 8UcQvBI6IEuCHAqyBB48MdgE2uYTAxsoWhE3OA9g9OCgsAatQMWblwu47XK8gxkYBvOhp4HsF
 AbYelt12+SqCsR4EusdMviQIew/AeVuN71Ywlg5dJy0Iy4/Diu/+5nkZYap/No/67oiw12DDe
 DXCjjAC2Ob43ieswrbDkeOVPh8Ai4JVv45yvczDwqClih0AMQzWt//IYzkE3nLf57NLlAPovF
 K+IkTBgdpSZlWU4Rehu/9VFjfBycI4FtfB+535LKqhsSiGrXsUDk8fXemxGtrLxhCWo2FV3Yy
 Q5Uj4y/CXApaNAjhwfo3XAMQqEfhF8fxKQTy0LrgErNAeCKusFYgRyGr+s00NM5uHbYStbXHs
 cQw0lY4Ja3xfKBD2nhhHbACxg60ZelWW0qAhVWqZIj5eplAkyBJkydvkZIEsQ55DyyiSNsgUc
 jKXltP5mjfUmXItZXAC5hFm6ripX4GlKY+8E4SjXGmI6Ex/MCl+JCM7M19J0sp9+hw1RXeCSB
 SVQtHtdaGkOFBPZVF5b6rUzFN+IEM0QBosKlnLyCJaR2poVRYr9YFU1HjLUsdDPzxnZeJf73/
 KxF57PRNdloY6nhjRZmspSZgoN5wpxrzFyhztw9YPfpQBECUJEgEOhyMO0FF6jcrwf30ShKFA
 GiRq3sx0CVBpDQ8dTDLmuIy5lpQQrzkD+a8kKeQWlBkd1Jm62d5D26+Od1Aetybg45u5O4QS5
 Pf23OUeB7XhqTnJPeq3lE+aiOd1sfn4vnSdtsBlTU46Qr2g7V/zQWu4y9i9NXX5axnVBfaSW4
 aO0lL/vXOBZQdKD/qndaTdGY4IrR65UDzxnE0fEy0//uwh+MzTL21MP7w8nZRWFOt8rPCqYWi
 DaeKztL4/JPymKfuibSnlrfC1p2NfHxq7mPju/trDC4CoiMybml3s04wXWOebA9PvmnftaeyP
 z6TnNr9s2rbTY3Kbg7rBpXPXYo9dthy8PrLetmvkibOTQRx5iAkcGBibCNjDebveP47T/8Puy
 0ktJ7XtiTs+mo5OTuiWIrSSVGzi6WnyH4OQ9dCjBAAA
X-Env-Sender: zoujc@motorola.com
X-Msg-Ref: server-18.tower-396.messagelabs.com!1628843247!135706!1
X-Originating-IP: [104.47.126.51]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25037 invoked from network); 13 Aug 2021 08:27:28 -0000
Received: from mail-pu1apc01lp2051.outbound.protection.outlook.com (HELO
 APC01-PU1-obe.outbound.protection.outlook.com) (104.47.126.51)
 by server-18.tower-396.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 13 Aug 2021 08:27:28 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2019XVgihuGPFqeTO6jxJhZKAZltWFjZRIkb/ta++HcU5SpNs2bPIjVmTAbxY/3USrbnT4ExvxR2kcUEFkl47oYPgwYczuOtM/i709vZ4V+1Pahzw5rITULiSzw07VKWomxjubCPh+REhTjZzvOLpX7/bY+Og6c1BbjZ4L0ZOXy3pxa0tjBxYgEzHPEVNP/mhpRp6VKjnspkts7LaMyg050LZwGbV7HRE/QBeqbjh2qlSew5U0VuGCAr/jch1KZyAA7xSdRFfe8UCZ37xDIgOVukJBORhrHtLnSMs1Lx3FIj7FbL6GCMhIFbAGXZsmAhqmnAmfT7FljLT4h/EwFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKrNuFLHswztvt3vcteEu63BnMguzJfPKV7Xbf+TJew=;
 b=avoGu2EnfoMc/cmWgv7ZezzcGrOAn/QAgcS5p7dtGOb1HiMPmj2xOVE9HVOHc1QCQU7KGmO2OfV4EVUfFyYWWIUW1Age9DONIJngOoYtxRPgRTCkAaX7zUinFiJgPbqtTUcg0zH1hh289RHAxxQ6/vm5j/ih68EPUp2eqKopUjEMSCANE355dChe1cZT/F6dhL+2zyaRh5PvzjFbewTxS62Ql/t9AtPRDWV4az8tpuf/0Rmjblla645Af4Un5wLUCgIRaKoXEEKwNIEClCwAer40or41Cp5KPPqiZI9Wz5P8eJDMAdTncG1xMrN7cUCnK9UECmm4E4VXpCR9w0/04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from HK0PR03MB4177.apcprd03.prod.outlook.com (2603:1096:203:9b::11)
 by HK0PR03MB3858.apcprd03.prod.outlook.com (2603:1096:203:7f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.7; Fri, 13 Aug
 2021 08:27:26 +0000
Received: from HK0PR03MB4177.apcprd03.prod.outlook.com
 ([fe80::3866:22b3:d4cc:6be2]) by HK0PR03MB4177.apcprd03.prod.outlook.com
 ([fe80::3866:22b3:d4cc:6be2%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 08:27:26 +0000
From: Jichao Zou <zoujc@motorola.com>
To: David Hildenbrand <david@redhat.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "minchan@kernel.org" <minchan@kernel.org>, "song.bao.hua@hisilicon.com"
 <song.bao.hua@hisilicon.com>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, JianQi Yang <yangj@motorola.com>, Yanjune
 Tian <tianyje@motorola.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRXh0ZXJuYWxdUmU6IEFuIGNtYSBvcHRpbWl6YXRpb24gcGF0?=
 =?utf-8?Q?ch_is_used_for_cma=5F[alloc|free].?=
Thread-Topic: [External]Re: An cma optimization patch is used for
 cma_[alloc|free].
Thread-Index: AdeQD/l5FWbWirK9SGKJhUkkmda/hgAByYkAAAAgDAA=
Date: Fri, 13 Aug 2021 08:27:25 +0000
Message-ID: <HK0PR03MB41775573A48273BF128C7F72D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
References: <HK0PR03MB4177A44D9DAD3302251B0EC8D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
 <f5cd9fe6-3b62-eab8-1ff1-d3943d4bb85b@redhat.com>
In-Reply-To: <f5cd9fe6-3b62-eab8-1ff1-d3943d4bb85b@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f245046c-b8bb-4799-e0a4-08d95e342e7b
x-ms-traffictypediagnostic: HK0PR03MB3858:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR03MB3858F796A3018C18A0884B3BD5FA9@HK0PR03MB3858.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rww1aOFhE1CN/H/wNEqCG9dXYTTR1aosq35JNsdbw3WfKSFrFOogB3gzwt0//1z4vl3Qvboysa+5OmIBoiuClPSoSLNwz+pa+D77y4MkBCyPxPNxIZJLap7H4AVuWZ2dyLPeX1qu6KGj/vNpwxY7zuNnCJz18/az2Zzg/OluxgkCHN66ryqAdMKjufSZwSN4XVVdvN5rkcOq/Z1rY5d92iIKgCnnuNpgsxNRADSM7QmNTMrlJeU1QEt0209O1/O5Zr38SzFClsiZyQpFGmcdYD+Kgp3NWB5SLsqR1fb4Ks7yOhIEto4nzIjRDgFEX4cykirhAzG+GgjhsDpI8CJexx2LgcHv8E317BLtrDAM3Rlfm3TCEzrjn4C3MPcT/gnV4P7tc7vPVmUReAJpiXeuS51IL5b7sCEiyqfjYLLNI6AYU0eKAtQDIEI4G7Dq4FU2UlBIq238zlzeH0QcLLLGf+S6u/CaUE4PjRcrvJmUcCl5EUm+Nii4zXbPsuZCgWzSlrw+/4poEsHkDFGHrO5riOQtPJFKb2550wgSJ8n+rMKQF1gVXbRA56s0EKlwjRgAZVmUlKyGnk+0u6S4edsCAFCXh4qd6ggoq7oP6mjBzWNAT6uf/4fgYUnM/HFpEa/4aEznhioTuJq+uO/CVXFrhqw8vyK6//cqs1dbHlbhODAE+jLVoazKFbHUH9FSStHZ6d0SFLCp5RhF6qsl1qKbYAU+Z2WfxO3Gv+54VPbfXXY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HK0PR03MB4177.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(8936002)(224303003)(33656002)(7696005)(122000001)(26005)(38100700002)(53546011)(6506007)(316002)(86362001)(110136005)(5660300002)(52536014)(2906002)(7416002)(921005)(6636002)(478600001)(38070700005)(66946007)(66476007)(66556008)(64756008)(66446008)(55016002)(76116006)(9686003)(186003)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXlrajM5TDQyZzB0VVhhU3dNc2FJRFlDTE1vS2lJOVA4SkZEV1lBdFVhalN5?=
 =?utf-8?B?ZnR2MHI4VzRsSityTnBQM1owWGxiaklCcHVrZUhqMmMzSUJGOUVwdVNsUnFT?=
 =?utf-8?B?cTN1MjhBbCs1RTNheTc1N2pIT1lUYk00T0tyUFZ5VWxlMGF0NjhwS2VCYk5J?=
 =?utf-8?B?eUZHS2VhbUZTOG9KdHE1bUpyTjZaZ3IyZEZpMjVxSGVZVUVyTGNMbHRncjNI?=
 =?utf-8?B?SjBiK1EyVDFSTXcvM1FUcGltT212UkFtSTF4dG9EVXRIZHFIKy9RcE9vS21Z?=
 =?utf-8?B?VyszdlhyMzZ1QXVwVEhZZkpFN0p6MjlsSEY3N3RHeGlYL0lkNzBOQkZxWk9G?=
 =?utf-8?B?SHZXaEgxd05xd242SVlmWXBKaUpKa2hOS2d6b2p3MEJFQ2djb3dTRW1EMlBq?=
 =?utf-8?B?eHdKazhkWjY4WFZISXlxVnc4ZkdSb3k3YTdzd3E0VTJWQWMxU0pJSkdhejdz?=
 =?utf-8?B?T3doM1FHUW5vNFMwUmcxc0pPRFZXSXF5ZWdodzd2T0lzeEdkZUh1bTJXaTZa?=
 =?utf-8?B?VlE3TUUwc0wzSW1kYTdqdjJ5RzZMSXhRUGVRMzJLQzZCaTlQQUFWMmlTaWhJ?=
 =?utf-8?B?a0wwK3FWaGhJaFZLTjlHYXVIZ1FmeGhCU1dkN3dRRmNiK1RUZlJLcnFHTS96?=
 =?utf-8?B?U1B3VHZrV2NxenVZUStmSmtsWU5RYmpzcmxkakdtK0xBVEM1S3dhcmxTbi8w?=
 =?utf-8?B?SjN1TE85N2Vyb29rYjRqZVNEV0dFektKUFFEVmFwOUJsTlRuNE1aVS96c05B?=
 =?utf-8?B?aXMzV1oyRit3UHBZMHRiNmVjUi9GZUs4ZXlPeUVDRzlhWGFEb0QvOEJpc04z?=
 =?utf-8?B?dTF5TjlYNWxWcHRWY0xjVzBCQWxZT2JBVmRDRml0ZFZIcDJjNkt3R0hCdUFC?=
 =?utf-8?B?c0EwSU42VS85eTRwSlhqY0FiM1ZESnJqTEl2Njd1am1Wdk9rOUI5QUZuWXRz?=
 =?utf-8?B?Wk1WNWJETVp1Y29OQXFtRmYxRmlyVE1tOUdmdmkyUkpRenhEYkU0eHMrUm91?=
 =?utf-8?B?cjJEK2JhQ2o0R01qR0twdTkzWjNKaFJwWUpxR3dQeFV4MGlwczg4VHJvNGZD?=
 =?utf-8?B?NjVERDRucldWZ0xWckJZYUNNclEwdS9NZjFFdGtGd3J4eHZkRDkra0NPd01G?=
 =?utf-8?B?OU5TMlFwazdrTHdEcUhLNXVxeGEwYzR5YjVXT0F5eFdJN3ZwREFaaHltdTRa?=
 =?utf-8?B?M2FOdzB3VnhRRmdqTU1Oai85bkMzSWlwY0IwMUlvdVUvbk15bnVVWEErVGpS?=
 =?utf-8?B?T1FoMG9zclBsayszd2J3S3RtMUFNS1lXUzJRcXczUkRjUVlUczhtSHlPMnpr?=
 =?utf-8?B?SjRBZlM0dmx5RVRiWUtyU3l6T0hLajM2M2dQK1VxT0NxaU91RGVxZ1RvQ0I0?=
 =?utf-8?B?RXBndVhtUHJ5UGpJMWp2cWJFRXpneDVYVnVWSzNNUnVpVjBwTEpuQldNUTNR?=
 =?utf-8?B?NFBZWFU4eGZwZCtqcFBSR3kvakgxS3krMm5pVm9EL3BCWkpVZi9HajlST0xB?=
 =?utf-8?B?djlxS25BY3RhUlRaWkhwS2U3Nk1KVXozSjZoK1FHTDhhNnprQmN1NTZrc0g4?=
 =?utf-8?B?NWIyRmJIWXE4UUNaWFg1em43UFBDeFZ3a1ZkcmZiYi9sQldsbjllUldUTGJC?=
 =?utf-8?B?M2VWTzNxNXU4eDhjUEJObUI2WkRhbVVLcXE4Y3pka1ZnQVBDVUkvUmltQndZ?=
 =?utf-8?B?cG84TXh5elpVc0ljSlVSVDBtS1BhSzFHY3VKYmkxVy8vK1Y5cU1WNTNzRGRs?=
 =?utf-8?Q?Wqn0gtOjd7ywkOoHkn/m6zhwRbfufQpB8fg3sie?=
MIME-Version: 1.0
X-OriginatorOrg: motorola.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB4177.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f245046c-b8bb-4799-e0a4-08d95e342e7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 08:27:25.9467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XHeq/8EkNvhPAG0x5bEs9aTm3VevmpxH5YQiIjc7oRMF+vKyNCInx4aP31enz3cri6WEyrQxr3VxM2boWSvTRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3858
X-Mailman-Approved-At: Fri, 13 Aug 2021 08:45:09 +0000
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgRGF2aWQsDQoJSSdsbCBnaXQtc2VuZC1lbWFpbCBwYXRjaCBhZ2Fpbi4NCglZb3VyIHVuZGVy
c3RhbmRpbmcgaXMgZXhhY3RseSByaWdodC4gDQoJTGV0IG1lIGV4cGxhaW4gdGhlIGJhY2tncm91
bmQgb2YgUGF0Y2gsIHdlIGFyZSBkZXZlbG9waW5nIEFuZHJvaWQgcGhvbmUsIGtlcm5lbCBpcyA1
LjEwLjQzIExUUywgd2UgZW5jb3VudGVyIGNtYV9hbGxvYyBmYWlsZWQgZHVyaW5nIGtlcm5lbCBz
dGFydHVwLCBidWRkeSBzeXN0ZW0gaXMgcmVhZHksICANCjAxLTExIDE0OjIyOjA4LjY1MCAgIDIx
NiAgIDIxNiBFIGNtYSAgICAgOiBjbWFfYWxsb2MoWzIxNl1baW5pdF06Y21hKGZmZmZmZmZmMDBi
NTAwMDA6dG90YWwgODE5MikgbGludXgsY21hKGZmZmZmZmU4OWQwODRjZjApLCBjb3VudCAyLCBh
bGlnbiAxIGdmcF9tYXNrIDB4Y2MwKQ0KMDEtMTEgMTQ6MjI6MDguNjUwICAgMjE2ICAgMjE2IEUg
Y21hICAgICA6IGNtYV9hbGxvYygpOiBtZW1vcnkgcmFuZ2UgYXQgZmZmZmZmZmYwMGI2Mjg4MCBp
cyBidXN5LCByZXRyeWluZw0KIA0KCWNtYSBiaXRtYXAgc2hvdyBtZW1vcnkgaXMgZnJlZSwgYnV0
IGFsbG9jX2NvbnRpZ19yYW5nZSBmYWlsZWQsIHdlIGNoZWNrZWQgaXQgb3V0IHRoYXQgc29tZSBk
cml2ZXJzIGNtYV9hbGxvYyBhcmUgDQoJInN0cnVjdCBwYWdlICpjbWFfYWxsb2Moc3RydWN0IGNt
YSAqY21hLCBzaXplX3QgY291bnQsIHVuc2lnbmVkIGludCBhbGlnbiwgYm9vbCBub193YXJuKSIN
CglJbiA1LjEwLjQzLCBjbWFfYWxsb2MgaXMgIA0KCSJzdHJ1Y3QgcGFnZSAqY21hX2FsbG9jKHN0
cnVjdCBjbWEgKmNtYSwgc2l6ZV90IGNvdW50LCB1bnNpZ25lZCBpbnQgYWxpZ24sIGdmcF90IGdm
cF9tYXNrKSINCiAJQWZ0ZXIgY2hhbmdlIGNtYV9hbGxvYyBwYXJhbWV0ZXIgd2l0aCBHRlBfS0VS
TkVMLCBpc3N1ZSBpcyBmaXhlZCwgYXQgdGhlIHNhbWUgdGltZSwgd2UgZm91bmQgdGhhdCBwcmVh
bGxvY2F0ZSBhIHBvcnRpb24gb2YgY21hIG1lbW9yeSBmb3IgYXVkaW8mdmlkZW8gcmVzdWx0ZWQg
aW4gYmV0dGVyIHBlcmZvcm1hbmNlIGFuZCBndWFyYW50ZWUgQVYgZnVuY3Rpb24gZXZlbiB1bmRl
ciBtZW1vcnkgcHJlc3N1cmUsIHNvIHdlIHRyeSB0byBzdWJtaXQgdGhpcyBwYXRjaC4NCg0KVGhh
bmtzLg0KDQpCZXN0IFJlZ2FyZHMsDQoNClpvdSBKaWNoYW8g6YK557qq6LaFDQpBZHZpc29yeSBF
bmdpbmVlciwgU1cgQlNQDQpNQkcgUk9XIFNXIEJKIFBGIEJTUCAoQ04pDQpNb3Rvcm9sYSBNb2Jp
bGl0eSwgQSBMZW5vdm8gQ29tcGFueQ0KbW90b3JvbGEuY29tIA0KTSArODYgMTg5MTA4NjAyMTIN
CkUgem91amNAbGVub3ZvLmNvbQ0KdHdpdHRlciB8IGZhY2Vib29rIHwgaW5zdGFncmFtIHwgYmxv
ZyB8IGZvcnVtcyANCg0KDQoNCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBE
YXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4gDQrlj5HpgIHml7bpl7Q6IDIwMjHl
ubQ45pyIMTPml6UgMTU6NDUNCuaUtuS7tuS6ujogSmljaGFvIFpvdSA8em91amNAbW90b3JvbGEu
Y29tPjsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBtaW5jaGFuQGtlcm5lbC5vcmc7IHNvbmcuYmFvLmh1
YUBoaXNpbGljb24uY29tOyBoY2hAbHN0LmRlOyBtLnN6eXByb3dza2lAc2Ftc3VuZy5jb207IHJv
YmluLm11cnBoeUBhcm0uY29tOyBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgSmlh
blFpIFlhbmcgPHlhbmdqQG1vdG9yb2xhLmNvbT47IFlhbmp1bmUgVGlhbiA8dGlhbnlqZUBtb3Rv
cm9sYS5jb20+DQrkuLvpopg6IFtFeHRlcm5hbF1SZTogQW4gY21hIG9wdGltaXphdGlvbiBwYXRj
aCBpcyB1c2VkIGZvciBjbWFfW2FsbG9jfGZyZWVdLg0KDQpPbiAxMy4wOC4yMSAwOTowMCwgSmlj
aGFvIFpvdSB3cm90ZToNCj4gUHJlLWFsbG9jYXRlwqBDTUHCoG1lbW9yecKgdGhhdMKgY29uZmln
dXJlZMKgaW7CoGRldmljZSB0cmVlLMKgdGhpc8KgZ3JlYXRsecKgDQo+IGltcHJvdmVzwqB0aGXC
oENNQcKgbWVtb3J5IGFsbG9jYXRpb27CoGVmZmljaWVuY3kswqBjbWFfW2FsbG9jfGZyZWVdwqBp
c8KgDQo+IGxlc3MgdGhhbsKgMW1zLMKgb2xkwqB3YXnCoGlzwqB0b29rwqBhwqBmZXfCoG1zwqB0
b8KgdGVuc8Kgb3IgaHVuZHJlZHPCoG1zLg0KPiANCg0KUGxlYXNlIHNlbmQgcGF0Y2hlcyBhcyBw
cm9wZXIgZW1haWxzIChtYW4gZ2l0LWZvcm1hdC1wYXRjaDsgbWFuIGdpdC1zZW5kLWVtYWlsKS4N
Cg0KV2hhdCB5b3UgcHJvcG9zZSBpcyB0dXJuaW5nIGNtYSByZXNlcnZhdGlvbnMgaW50byBzb21l
dGhpbmcgY29tcGFyYWJsZSB0byBwZXJtYW5lbnQgYm9vdHRpbWUgYWxsb2NhdGlvbnMuIEZyb20g
dGhlIFBPViBvZiB0aGUgYnVkZHksIHRoZSBwYWdlcyBhcmUgYWx3YXlzIGFsbG9jYXRlZCBhbmQg
Y2Fubm90IGJlIHJlcHVycG9zZWQgZm9yIGUuZy4sIG1vdmFibGUgYWxsb2NhdGlvbnMgdW50aWwg
KmFjdHVhbGx5KiBhbGxvY2F0ZWQgdmlhIENNQS4NCg0KSSBkb24ndCB0aGluayB3ZSB3YW50IHRo
aXMgYmVoYXZpb3IgdXBzdHJlYW0uDQoNCi0tDQpUaGFua3MsDQoNCkRhdmlkIC8gZGhpbGRlbmIN
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
