Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394D7C433F5
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 20:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D038561008;
	Fri, 22 Apr 2022 20:05:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sGtwT8C1k1zr; Fri, 22 Apr 2022 20:05:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7298360E36;
	Fri, 22 Apr 2022 20:05:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53631C0032;
	Fri, 22 Apr 2022 20:05:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B364C002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 20:05:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E89F04056E
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 20:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ULHwwa2dWSQZ for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 20:05:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::60d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B49DD40360
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 20:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz31HMuhRHO79iRsa+CIDl5EbuQI6yHrLqUZED6CR5D0RgT3qVEMScvV+UAZQjM8AfqHs1qBOfTQIqv1lLKk//C7HavjE5mleHyzhLEoI3etwvcP869/tmwj+6fb0vqh8LQh453PscoVllTlSu39YEmkXP2K4Cql5vHXi2dtMwc+Wii/58CjYFACUmsZPYILiE+6RM3HGMxtCRYejq3qnAQOZriW0zDRDc9PylQzM/WX75OC9ZkPeolgN48c2XFW8Xc9IOoX00p8HCEH7zwO7bCSNrRNUrThrG2cmqMiDRdDecaIpeBid7v4GIet8d57B321VvioIq5zq7ZjzMZ5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=350S4fAC5KifeQLT8wgKi1XDeI/q6eapxAcnFsmjnZk=;
 b=lyNlM0WgQK8S94tvU9A2OhVOkhkfE6d6oXEv87Y0a1zlr2d3V+QLSO70eplmhvmiGnY4D5il1lJmfYV13HMR5mp0Gy2Wzdr70jZlcUT5Miied+lsKoULMeYKb7Z+eTf9UHYv6Uvm4Wm/AhtbmtTAy9ps0hKuxS3OzA3GJ6EyPOeswKBsXvuCL0cKLglA1PpvcylYoaY1K5c/D436TEQkIHyK0XYG1BGRRI6ne7XLRmgxwiV+T1TCmhXp2zNVZan6As986CHB3Op4mRK4EgBV8w/JMj0QsnzS+mNM47r5MmBMA1l2Z/jqXA0JoufxTypnJ12s0PxdMXIgKC2DX+D1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=350S4fAC5KifeQLT8wgKi1XDeI/q6eapxAcnFsmjnZk=;
 b=x+xradlnM4GwmkGBrSssIkfNU1HGJzslizPqcFtAZtfgV0p6iL6dL4chhdcbLYjc8gPjGFD46XfCcYwiCdCJNlyqfFVDLjLcBbWXbqrdtjGu6cnamByzDBUvhhOamVBS+QIuCnKTv130/xib38ZJ1mcDllGn+oRXju4Ye/sPyY4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 20:05:25 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::98b8:8b06:2069:c838]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::98b8:8b06:2069:c838%7]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 20:05:25 +0000
To: Robin Murphy <robin.murphy@arm.com>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de"
 <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "joro@8bytes.org" <joro@8bytes.org>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>, "will@kernel.org"
 <will@kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "Hegde, Vasant" <Vasant.Hegde@amd.com>
Subject: RE: [PATCH v4] Documentation: x86: rework IOMMU documentation
Thread-Topic: [PATCH v4] Documentation: x86: rework IOMMU documentation
Thread-Index: AQHYVnILoAEZrZOhO0iIGelLt1T6q6z8VO2AgAAGhrA=
Date: Fri, 22 Apr 2022 20:05:25 +0000
Message-ID: <BL1PR12MB51447D05D90FC2B25A43F55AF7F79@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220422175423.44491-1-alexander.deucher@amd.com>
 <a9e09125-c61b-4a2a-f87e-1ba8147f659f@arm.com>
In-Reply-To: <a9e09125-c61b-4a2a-f87e-1ba8147f659f@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-22T20:04:34Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7a90ea29-c470-4af1-b0c1-774300e3b2e2;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-22T20:05:24Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 9f7369ea-37b9-4011-a72c-fea01db05cac
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1cdf9ce-cdcd-4258-25eb-08da249b70b4
x-ms-traffictypediagnostic: MN2PR12MB4126:EE_
x-microsoft-antispam-prvs: <MN2PR12MB412613CD41EBF004FCF1B3BAF7F79@MN2PR12MB4126.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iNxSFElRQjBMPyCNpFU1dXAVfk7t/fCVAgw3dBInI6a3+dwxlpKthreQCOnWUglZFOmHU2r9Htio/635UCXKrnN3vMjoO3dqs68InnL1eMbp2pTSsEf5lVmZRqECRxMrClhebSupR1IuD6yF/4Gyzdu69NPlwm3POhKptwQfMmt/NMrMFyvUMOF7Ay/ramnbhZBghPlSClnHSJH5nY70x14QAQwMe8jPhHw75pC7FRH0unXZV+iJsyd8l9sDe5VEMwMGbPNVI1GSIbAaeEsZYvaUSoZxzg/lNSjYDg5QsgU1bFS+SuyEPojNGOHtaBiCE0z5lVTTFXrXzLIz7ZVjvlJrWCVk6FM06UqjgQP4oZIuH/syMl+xJAkO6LwDWcg5kuItu93RyUXYtbrLpx2mhibKHyXnfmx/IlvXaywoPYhqoom6CH/1V5sQpulOBRJIBM1PvorOQJD5ZoAtOyX4ZTBOYjy/G7YS+V3CfdK2emIQKyXsV57AG+X/xMlIi2piYM9l6oZDVDVzrxcWxhq+GQ3IN0HWQ5q57zVtk8HKDSDYkWk35hOZXA36+C9NY12Dv/DGjSk5PTLa9fmzKSvCQ8LPYrTnwCMrKp+dKD8GWjMpDPZY4IrzZGEUjeJJnhjzUT90dNi0bjyIJHfNi7dqZaSY3p1simuCpHNRgqHXQlMI6sVw7Gd+e504txffv70gB1Vq8vzeTNTOuPRHCwH8AQOyD0fRlVcOj1TTC9Czp00=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(64756008)(66556008)(66446008)(52536014)(83380400001)(71200400001)(122000001)(76116006)(66476007)(7696005)(110136005)(8676002)(921005)(6636002)(86362001)(2906002)(316002)(33656002)(8936002)(6506007)(38100700002)(7416002)(53546011)(38070700005)(5660300002)(55016003)(508600001)(186003)(9686003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1gwYThjQVpiVmlRMklkN3VhaFEwTkdmREozTEdCVURQQjJ3Z2JiWDlneWpP?=
 =?utf-8?B?L29PZmd5ODEvZUQyZU1GamdGamxFSFdJazRES3hqQ3IyVWZ5aU5vb1ByN3ZR?=
 =?utf-8?B?eGxVNmdNVVZueUQzUHVoR1hwQktTMG9JZmt0S1VNUktkeFNvZnVoc0wzMnJx?=
 =?utf-8?B?K05JbnR2OWVaV252UmplczFGWW9Nak8wNFhLM25VOE1KWkpTTVNRS2xScXUz?=
 =?utf-8?B?MTl3Z2tpVWhmUzVxQWtJRTY2ZUg3RnhWbThnZGFTOWhpbGJzcFF1dEpKNEJy?=
 =?utf-8?B?ajdBUEIyWWtaTHhQRGRCd2xtZkd2YXRXNkhGSC9VK1ZyYTZIeGJqNjJ4c0ZM?=
 =?utf-8?B?aFQwMUN1bVJHaVlmMmNvRGFMR2VGYUpvbitHcWFWZ3ZsdmxGdnBZc243TkQx?=
 =?utf-8?B?b2Y5Z1AzSGpqdjRFcENCbW5YV050b3A5TEt0ZWt0NllPWFVFaG1RdTluTjcz?=
 =?utf-8?B?SkFCYzNiZ3lIWXpnVVBjWkFTM1VRcm92SGl5ZzdnYTd1aGwxcWl5dXIzdTE5?=
 =?utf-8?B?UURJL0NGMHo3OHZIeGtTTlFGVTV2ZjNNMnprMkVUWmMwS0FJSm84Tk1CVzNP?=
 =?utf-8?B?QU1qREhVWFRMWVdzYUUyOW96QXJVUWQzUmJ4cU95WW4xK05ZU05kcERPOERi?=
 =?utf-8?B?Wlc4KzhlR0VUUUFYQ0dNeDVnbXpPZnRsYnEvLzdqOFRtY3dCZjJCRTVuZ3ZE?=
 =?utf-8?B?ZUhqRjRlUnhLRDlNckJHQUFuQ2VvMG15WFcrdUUvTGo0YVBuOUlBUDV1bUdX?=
 =?utf-8?B?a3lBWE5pY01DTTJuL1ZtWkhmR3NBQmE2bU1VaFI1TWJuRWJXZEFYK2Yyb3B6?=
 =?utf-8?B?RjMzOEdtM2pHUVFTbzV4cGV6bnhRaTcwM3Z6cGs4OTY2dkUyWktqUWQzbDNM?=
 =?utf-8?B?MndBRHkyWS9kYTdKd3FxZ3orazV4WWRPSGRGWFEvNnFCa09RTTRTMmZxTXdO?=
 =?utf-8?B?dHc3U1Y1R2cxSituVU9xN05ORXEwTy9xSURMZnU2R3lURENVNEdqOUcvc0Vx?=
 =?utf-8?B?REh3dmxnWlR1OWFMVmFoc2JXckF5OXhTQW11MWFBbGw2QmFoTHY5d3JvL3RJ?=
 =?utf-8?B?ekV4ZHczRFltbWRqQitxbS9NQWJXK0MwaWdWK0R5M0x5SnJORlJiVlRZSFBi?=
 =?utf-8?B?RDVCM3Rnb29UL2NYencrNGttNlR0ZFkrMkl6M0dlc21CcXk3TVBtYmxZYm1Z?=
 =?utf-8?B?MEFSQzBSVlJHSFRwWTEwOGNybFRWbm4zV3g5d05wTTYxdFVzZ01wNnlYeFov?=
 =?utf-8?B?VEFCaU1WVXAzZWxLRHV6NXB6K3V5Z21kVlNGYmhma0RhTU9qTCs1MEJUaDNm?=
 =?utf-8?B?V0lIdXZXalo2amRyYUNYaTZJbDZicGVmRTFacEFWa3JCZ1RCWHdIZGtoWU1G?=
 =?utf-8?B?TDNBeDEyTkd3S2ZRYktHZnlob2NodUtMWXhoKytaU0N2V3RvMmNWSTlYcTFK?=
 =?utf-8?B?NDZwK3VXN0NBdjg4RC9hVUtyLzJtVEVpYklKRUdUU1d4ZlJuckQ5bWsyQ0Y2?=
 =?utf-8?B?U2xIdUIvZHlaSmVkZDNhS0MrRHp3QUF0eVVLUVpoS1ZwZlJlWTlVY1NlWmhC?=
 =?utf-8?B?c3pIbXcvTzNVNG5kUlcvMVoxMmtuSW9nVFpyMGU2SkttL2NRSlhEY3F1dnJH?=
 =?utf-8?B?OGw1VTBIS0VKMnY0NUQ4Z01GbFJRQXlxUytUMTJqMmNEODU5YzJESWlDOU02?=
 =?utf-8?B?ZjloNm5nenRWNzhEL2x5NTRaa3V0cHNTM1U0SEZzTHUvVUhvVmZSVkpEYkJO?=
 =?utf-8?B?d05rOVlwRFI5L3Fwb01TWFhTZHptRTlGRm5xS2pUOXJrVmhhQUhYdnpCMGx5?=
 =?utf-8?B?SnNndDFlNU1ZRGVSNGVvWFVUOUo0bno1UWlFU0k1K2huak5iZy94SG44WnlI?=
 =?utf-8?B?S2toZUdKQ3JCREFpUnVPWDRYMHpqd0tFRGxKVU9aNXlzZlEwdnBhOWR4a0k0?=
 =?utf-8?B?dmZmQ1hpd0ZPc3ByYmg3bXVKZTM5VDhRNUpZMGtjYmVLLzFDd1lHaG1DdkNE?=
 =?utf-8?B?dndwYkYvcm15N3pBMXZSWS9qMHZUZzRFWWNsN3FEUVFpM3R1VzhvREhNSWgw?=
 =?utf-8?B?T1RPOEw1TC9GdnVIQnY0WWdUYkdUeDk5UnV5VXlHV01Nb0JWdGlucU94SGdq?=
 =?utf-8?B?Y0NJNTdHSS83Z1BCOVdFRFNmeDNoRjZOcms5aWtxSzRheE1pTldubzJ5a2Nw?=
 =?utf-8?B?TjJwSCt4QlA2ME9RMkdaUVBpNFQwaU5OZ2xuNkNlZVNVNFQ0VUhiejNYVVk1?=
 =?utf-8?B?YnNheW1MQllMdkF0VWtuUFpHYTVEMHlqQ1RwWnhkcHh5V0N4SEdFZ25Wd2dM?=
 =?utf-8?B?WXVzQTk5RG9OcS96amtiQnk1ckkvTmo1aWFRY3BMcDFaSVZCRVdmdz09?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cdf9ce-cdcd-4258-25eb-08da249b70b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 20:05:25.5575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3U7dxhCiTCy+RniTO3mW0/hork5A8XuA61xNjlvQLD3KEbjreCAqcO09OKGWiVPgRV5A1/Bx3rV0BqV93uY+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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
From: "Deucher, Alexander via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

[Public]

> -----Original Message-----
> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Friday, April 22, 2022 3:41 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; corbet@lwn.net;
> hpa@zytor.com; x86@kernel.org; dave.hansen@linux.intel.com;
> bp@alien8.de; mingo@redhat.com; tglx@linutronix.de; joro@8bytes.org;
> Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>; will@kernel.org;
> iommu@lists.linux-foundation.org; Hegde, Vasant <Vasant.Hegde@amd.com>
> Subject: Re: [PATCH v4] Documentation: x86: rework IOMMU documentation
> 
> On 2022-04-22 18:54, Alex Deucher wrote:
> [...]
> > +Intel Specific Notes
> > +--------------------
> > +
> > +Graphics Problems?
> > +^^^^^^^^^^^^^^^^^^
> > +
> > +If you encounter issues with graphics devices, you can try adding
> > +option intel_iommu=igfx_off to turn off the integrated graphics engine.
> > +If this fixes anything, please ensure you file a bug reporting the problem.
> > +
> > +Some exceptions to IOVA
> > +^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff).
> > +The same is true for peer to peer transactions. Hence we reserve the
> > +address from PCI MMIO ranges so they are not allocated for IOVA
> addresses.
> 
> Note that this should be true for both drivers.
> 
> > +
> > +AMD Specific Notes
> > +------------------
> > +
> > +Graphics Problems?
> > +^^^^^^^^^^^^^^^^^^
> > +
> > +If you encounter issues with integrated graphics devices, you can try
> > +adding option iommu=pt to the kernel command line use a 1:1 mapping
> > +for the IOMMU.  If this fixes anything, please ensure you file a bug
> reporting the problem.
> 
> And indeed this is a generic option. I reckon we could simply merge these two
> sections together, with the first paragraph being something like:
> 
> If you encounter issues with integrated graphics devices, you can try adding
> the option "iommu.passthrough=1", or the equivalent "iommu=pt", to the
> kernel command line to use a 1:1 mapping for the IOMMU in general.  On
> Intel you can also try "intel_iommu=igfx_off" to turn off translation specifically
> for the integrated graphics engine only.  If this fixes anything, please ensure
> you file a bug reporting the problem.
> 
> > +
> > +Fault reporting
> > +---------------
> > +When errors are reported, the IOMMU signals via an interrupt. The
> > +fault reason and device that caused it is printed on the console.
> > +
> > +
> > +Kernel Log Samples
> > +------------------
> > +
> > +Intel Boot Messages
> > +^^^^^^^^^^^^^^^^^^^
> > +
> > +Something like this gets printed indicating presence of DMAR tables
> > +in ACPI.
> > +
> > +::
> > +
> > +	ACPI: DMAR (v001 A M I  OEMDMAR  0x00000001 MSFT
> 0x00000097) @
> > +0x000000007f5b5ef0
> > +
> > +When DMAR is being processed and initialized by ACPI, prints DMAR
> > +locations and any RMRR's processed
> > +
> > +::
> > +
> > +	ACPI DMAR:Host address width 36
> > +	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed90000
> > +	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed91000
> > +	ACPI DMAR:DRHD (flags: 0x00000001)base: 0x00000000fed93000
> > +	ACPI DMAR:RMRR base: 0x00000000000ed000 end:
> 0x00000000000effff
> > +	ACPI DMAR:RMRR base: 0x000000007f600000 end:
> 0x000000007fffffff
> > +
> > +When DMAR is enabled for use, you will notice
> > +
> > +::
> > +
> > +	PCI-DMA: Using DMAR IOMMU
> > +
> > +Intel Fault reporting
> > +^^^^^^^^^^^^^^^^^^^^^
> > +
> > +::
> > +
> > +	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> > +	DMAR:[fault reason 05] PTE Write access is not set
> > +	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> > +	DMAR:[fault reason 05] PTE Write access is not set
> > +
> > +AMD Boot Messages
> > +^^^^^^^^^^^^^^^^^
> > +
> > +Something like this gets printed indicating presence of the IOMMU.
> > +
> > +::
> > +
> > +	iommu: Default domain type: Translated
> > +	iommu: DMA domain TLB invalidation policy: lazy mode
> 
> Similarly, that's common IOMMU API reporting which will be seen on all
> architectures (let alone IOMMU drivers). Maybe some of the messages from
> print_iommu_info() might be better AMD-specific examples?
> 

All good points.  I've integrated these suggestions and will send out a new version.

Thanks!

Alex

> Cheers,
> Robin.
> 
> > +
> > +AMD Fault reporting
> > +^^^^^^^^^^^^^^^^^^^
> > +
> > +::
> > +
> > +	AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0007
> address=0xffffc02000 flags=0x0000]
> > +	AMD-Vi: Event logged [IO_PAGE_FAULT device=07:00.0
> domain=0x0007
> > +address=0xffffc02000 flags=0x0000]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
