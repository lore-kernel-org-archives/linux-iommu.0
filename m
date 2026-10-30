Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793361940;
	b=eEDNHTxWX89tcNhIvX0029tWggnWyAtuOhFQFZfnWf8ZhcMQhjU8mBfmJ13Bx+h5/C8Z
	 GzZzFrcu832RV6HydPWYW3YvLAKX+2arGktVEs/QO70aj/FJon3qJHbhi4rD3CLRLfqDR
	 +VUg/uA7T/vK+t3xcHqp6CHAgyBlwy+nN5z6crQqcrJKaEpPU2jejS2eBG9ct2S4TDqUl
	 2OO8pMhZGLimjUmNYJ4uBMeJyTkJW5YKdbGP+uhKTeD5SUVIXp66jk3hm+N5N+b5B2mv5
	 MXPLAv1rnnXUpz1EOabCkFHnQnkWY7L72a2+swCYWaARRWsJTfBg8yz/tWCiZZhZkuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361940;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Q7t9CPgwPuQWq61enOypXbsTqNX/BSy4u5bvT5MOI8M=;
	b=I+7qUzdue46UKLHKTXDUEUNGr+OM1yZp0PCMtqlpjUrg25VvuoQzU9F21lbq7ysKc8Gg
	 Ffc7fkSQTptDz0wWN9gqZpoVZ1nKdlr1r60ZZbOaoJ4du15Wwnb4itG/gNEmadv5vKDf4
	 nkc1Xf6zgv3hbof+m6HGg0SHZDvbY82CguFDNUH1QgnbQsfP8vX+rq/K5uzb73PquoBOJ
	 bDQOLWJOZt4Shxk4JP3SKrBIDmAJUPkl3TZqXhrAaeCNnJsNZO1UnLdjV+GERf4u9qXid
	 wfeNWeTWBOMfQndAOEdZIz0uX+7MbJiKYWUVQyQvzXvku5R5KPpPTpXx29BmQzWyHtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HvgSkIGk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.25
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011025.outbound.protection.outlook.com [40.107.130.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A027606A322
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 12:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A027606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HvgSkIGk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEWohsF+NXCaIKwtulk5TX7eVPcSKx0ej+vLl1WC35Qx3Mf4CiI8gr2jZqGs9ydYKre/S0zu7hPqqMK5fcH2abnI8U3CbvtYArst3CtcYaFWSzUw67tmOioG6MfdLN/KqYgSZwmMUATIKJiIR4UHnGRIT7DwaMbiHZScfzs517Fn3yhXf7AiNrDMKq0TxBxQchnmYWPDNAFkdsRCF53ux7qlkBBev7SsyghvuFFDnVPiJQGkKHitQL47NSluS1OQaH+cjNTvez8wAwzunVoVEVfa/aACahstobdvehN4iNV0LnoBl+BMigUkvphXehSIcclvhVad9z5dNv3Ao718nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7t9CPgwPuQWq61enOypXbsTqNX/BSy4u5bvT5MOI8M=;
 b=qoPC3a6SwUHt3OA4e+LZuhHieylMpbO/wvnxOTUflz9+2bjPzjtnfXcHkQOnNDNDKAiXlzA0onti+1FlRcJh2EGpQUFgtjS3q0xE5OohwFhxaIMgeIaT56e/+qQ1jsljZAEPkFltWl8v3gzKh9wasg9fX7xgTQxg/NuN+15KmfUH+mtM/Y4a2CRDReYVBj0iLH5Cz9Z+XllOJm7Vr64Qg1GjchKRMkww/4lXWrfLQflX2Fi4c0e0Pk+LABDxhzvnYD3LKR3PZjcGZU05GQ2BGnQdzmBwifBsuHSLaLwxZ3TqKA1P6xIcd+rUmzI/5JIlaT0see1UA7SijoQnZ2LUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7t9CPgwPuQWq61enOypXbsTqNX/BSy4u5bvT5MOI8M=;
 b=HvgSkIGku0HKx2XOJaZzLfYRV7NVdS4kct1hiU6/m4d7C5MsFicLkLKizZKBedr5E+ENxQzyMUGevhqlZpVduAaUjljdfET0gaBG6WGUBhm/yIy6cflca8n58c3CY4m3pxpMadCJhno7R/m5ecO4gSNgt9DpoxA8mww9DfUQm7PdPJ1ePN1t316wmesniZHcQS40YNAaWLLQYcys18ozQm/5TVfjh7xoIDDqgw0R5mry04RE5R7vQloE8PiuJIlR0YYy60z8BvPxdloJbhiitpZ0i85KJSDRTb/49UT97pJGvpfzIzG4v5QlcYL47Z+5cE3VvxIEZLfg7TLdHGW7JA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV1PR04MB10751.eurprd04.prod.outlook.com (2603:10a6:150:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 12:05:33 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:05:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 30 Oct 2026 20:09:39 +0800
Subject: [PATCH RFC v7 7/7] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-7-961726ebd6ab@Example.Com>
References: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab@Example.Com>
In-Reply-To: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab@Example.Com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jean-Philippe Brucker <jpb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI3PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:295::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV1PR04MB10751:EE_
X-MS-Office365-Filtering-Correlation-Id: 1487ca6b-0c6b-4613-a5ba-08df367e194e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|376014|7416014|1800799024|22082099003|18002099003|56012099006|11063799006|261022075727099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261026121527099003|261009223027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	CHpC3t77eeUlXSB9Usa5DrS4LkUSZX3BRJXRVNyft7BDJ+fjpjXS3fPz/Vm54DVdi1LoXFBlSINlUGF7T47IDIwiiHbfgX3Vskz2vM+gAadkiLTp+F/zHjYQYuIlub24kMTm0PvtqMjWi/+NyGsm4NUXYtRuO8zx8XJ2QJE+EtBKTEr+aVwPlbL01j8qPLDs7xUs5ml5M3fkoP+2JZQ2mNM/7Iaovg3D1I/+TEzJiLa0BDX7TMelP3CGHiqxqYGe3iP+dmAErIK+Eq2GrRG6iQeHzUSS48/EPP66geWAMm5GDtjTXgp1v4+qDAOI1NKyWFy1Y5oyEw9qF9Dkn94MZVa8025YuZCJ7ZCRvVOZHLYL5jpEgebUjIGU+Ug4sEWmcKjHCeyboOKGmgjZmaNn6hWqE3ipQyDF7NRooPsi3JvBzytL9i6uPqpUyeWB8wg31JvH7BecMuHCfOagfA5amHkSa34qsYBA+uCrcEHw9AGwI7J84eA4KTLGbJ3N+comzHXbLIjowmTfiC9UxPI97pMAALsU5UxUA/Y2klrPmDgCFkUg9ZYa+yTHXcIhlRG6sLCd7Ft+I+oX7kIA7jiwKQaRIh/TH8PkoJnZobRKIN/kXFOnOkqdl3Zgf6PKG/ysDQd36LHpo0ODy84R+Zg2TWm7daFX7wI6pXCAXO1HCa8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(261022075727099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnV3MnpLTDRJUUl0T3VDTmNGOUpKTTZ2YnIzZ2RUT0xHc0puaXpRR2o3alZM?=
 =?utf-8?B?TFFxNUExRnIzWTMwMkQ2eDJlVm1pTlE3WDVuYUZoNkkwSVNiTjBPL1hqdXN6?=
 =?utf-8?B?OHhtaGt3dWJZSFNjMzVZREUwREx3TG8zenZ5bmpHUzRReE5oN2cydnF3U3gx?=
 =?utf-8?B?L3J5aDAyd2lTdU1oTkdMRTZhc2FLem5iYmFmQUdBSXVQNzg3Z1pvL0Jzb0F6?=
 =?utf-8?B?bXdjcnVuK28zY3BRRURmSS8rbXJobS8wRlAzWDN6TDhKckhhdzcwRlpXMVBu?=
 =?utf-8?B?V1hHa0N5cmxncmNmZmlpV3k0QTVETDJwNjNBdzd6c3AvbEd6UmlaL3lnU0Qr?=
 =?utf-8?B?N0kzSWZVSkVGSjZLczlQcFFLNjIxOVFLcFRqelNrUWpwQmNueHBLWU03aWZl?=
 =?utf-8?B?MVJVdGRHeHRCTEs3MDh2NGVzRnd3cTY1QnZBNEZGcTBKcWU3NmlRa3laek5v?=
 =?utf-8?B?QjcrZDROWi8rd2VxbFo5UGNVaUlsMnhYUTByRmRzTXBYUm9EU016R0dsQWtv?=
 =?utf-8?B?M2FDMkVXNGYvMGxTOWI0dW44ajVGdnBzNVNUYm13emtnUWh6MHl5U3hRMUVH?=
 =?utf-8?B?WkgvM3dlYzcxb083RVc0Ly9mZ3lNZGxnazFZVnJxUVhuSzk0YVA0T056d3hQ?=
 =?utf-8?B?QlhzUDBsY2dRVXdHWlN0MGVEWnFMak56Z2o0ejZaL3RwYnJxZ2RmR3ArWVpS?=
 =?utf-8?B?K25GdEpjam5seG1mdnZBVDhXTkZEYWE4cTdrVEFXMnBOcExMdWRub3JBVTd3?=
 =?utf-8?B?cVh3ZVo4M2xPWFhFejJoOGE0TFVSMUp1c3VrcU1mMmlNRTQvY1ZORkdyTEpu?=
 =?utf-8?B?blJUbk9rUk13WGZlaHZNZGM0cnAybEMrQzNjSDNweFRtR3FsUTJvSEJPZWtx?=
 =?utf-8?B?VW04WHl5a1hMTFp4di8zM1ZyWCtZT2hjWEc5eFJkVkY4MjM4c0YwNkl1a0pn?=
 =?utf-8?B?cXZ2RDNFVjhNVlN5emREcS9zcmlvbEovbEZjL1U5SVZkWlE1ZXpKUFBpWHlB?=
 =?utf-8?B?aXRzVzYxMnF3Y0xhSjJ6a0EwV1VYUnVZcVlUYjhXZCt2SDE2aUJwQ1hpSEdF?=
 =?utf-8?B?cnJQQllicXZJd1V3a3hhTE44SWxoWE9DNEpWUkVQdEZjOW9UZ08rZzY4akZk?=
 =?utf-8?B?WjFJcitXeG9ENThSUjQyTG82alhXc2pOVTVReE9hMjU5d0RUYU9ZTHlMbnRR?=
 =?utf-8?B?TExnUjZPaHlnalhXc0huZy9rbHcxdy9vTDVReDM2enBiQU5RUURxZFRVMi92?=
 =?utf-8?B?OEZIN09JYVRqM25LKys5cmUvMVp0QmFPa2ZzQ0x6SGRXSnVBRzhHc2lRNk5H?=
 =?utf-8?B?dVZVMEdjMnBCK0hUMk1BVVo0WWY1S1lxU2pYL04yeTk4QWsvaEdaRXhQak9r?=
 =?utf-8?B?UmdqeGVvelZxMWZtWEgwQm13QmprWnBZVWx0SkxhNXFQM0xjRUZaSmZiWTQ3?=
 =?utf-8?B?QlhBSlBRU2dsT1VEaUJpb2tBa3h3dUQ2dGxiSXhQdERhNWRDWHdZQzRTa0JB?=
 =?utf-8?B?TFhPd0dMcUMzQkRpYWtiaElveEJnNWEzVk4yemhMTzhDVHZFNlN2Y0NLbHNy?=
 =?utf-8?B?U0xEcFZEa0FOM0RGejc1UlNrZDVjTWhxVnZ4NXFlbVd5WmVkLzJPSStQUUc0?=
 =?utf-8?B?VEI1ay9UbHAxbkNKNXRRT0dwWStRZWRNdmNMMEZWM0xjdDZGYklwTGhmNEl6?=
 =?utf-8?B?S3lBaXJGVVZnR1B3V0FaWWdDOFhNZ1M5SmFsV282dUVsTEIrcDNuREJ0VEZi?=
 =?utf-8?B?MWx1dkpub240c2VSL2hOUzE2ZEQxWmszd1I3NWhuaWFhQSs3Y1BRY0k4UXR5?=
 =?utf-8?B?WFEyRHZmWFhrVDkzL1F0VDF3MG90d3VLdCt2VGR4SHR4MkQrcG5nK1dtaW9W?=
 =?utf-8?B?OWdUQ1ZJM0tOendtZzJTMm85bnJnWXJIRzlNRFVDU2w2Tm1iZkdnbHNObzhp?=
 =?utf-8?B?QzZYQjNTN0dVbjI3V3E0ZkNuaGk5NDhiOXA2ejUrczBqcHlDYWt1UjZzdnhp?=
 =?utf-8?B?Y2kvT3dlcHNZT1ZRRUpOMGpjMGdGNzhNRllkand1UWwrQ0JNT1lDVmFMR096?=
 =?utf-8?B?emUvVlRnVXhhMEVYcFBqMHphSC91TGRpZDh2cmVqVmJPSnR6ejJrZ2svSGd0?=
 =?utf-8?B?SnVkNzYxTGhFdzFmaUdqRTRXWU5uWjJ5b3FlUXdTQWR4VWdRN1pjK0djVkt5?=
 =?utf-8?B?WGRtRlBEZHpqV3hjaVJjTWtOcDE1WVhBd2ZUekx5MWg2TU5ENmdHdmZvd1FU?=
 =?utf-8?B?T1FoMW8yMmdwazhySS8xcy9xSUdxTnVWL0J3V2lhNWV3bzRUUmhFN2FSc2VT?=
 =?utf-8?B?VG85bnNBd1EwZkdDb2hUVkJqWUdQQXo3TGxlSk9GSXdjVFp4Sm1xdlZHYjMr?=
 =?utf-8?Q?fMnd4dnFzwG8looLslsZYxmcZgUVU4r3IflQJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1487ca6b-0c6b-4613-a5ba-08df367e194e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:05:32.9248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rowGUUilGpQ3iKBeqLRQ6ketom9Mr2INTAVHaP08pekCqRVG9q2DRsrWjHLdS+6YDsx8PMsdh3p46q9ccYDcK2XVO0rsCZrEdNBaQdoo0awI1wcTgB4dLq/uLc91bAdv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10751

From: Peng Fan <peng.fan@nxp.com>

With the per-domain CD table, every non-PASID sharer of a SID builds the
same normal-domain STE: same S1ContextPtr, S1DSS and S1CDMAX. Disable
stall and ATS for shared SIDs as well, so the remaining STE fields are
common too, and let any sharer program the STE. This also handles the
case where one device's driver attaches before the stream owner's driver:
the first attach now installs a valid STE instead of leaving the boot or
firmware STE in place.

A release or blocked attach must not abort a shared STE while other
sharers remain, otherwise it would break their ongoing DMA. Skip those
writes while the SID is shared; the last master (no longer shared) still
tears the STE down. This also means removing one device from a shared
group no longer leaves the survivors aborted.

Fault events on shared SIDs cannot be attributed to a specific master,
so arm_smmu_find_master() returns NULL when the stream's shared_masters
list is non-empty.

Disable SVA, PASID, vSMMU nesting, ATS and IOPF/stall for shared-SID
masters since all of them require an unambiguous SID-to-device mapping.
Reject sharing at insert_master() time if either master has stall enabled,
or if the existing master has PASID or ATS enabled.

Introduce arm_smmu_master_stall_enabled() to describe the policy actually
programmed into the hardware: a master stalls only if it asked for it and
its StreamID is not shared. Use it consistently for CD.S, STE.S1STALLD and
STE.S2S so a shared CD always terminates faults and CD.S agrees with the
STE. Resolve stall_enabled before insert_master() so the incoming master's
policy is visible to the sharing check.

Add arm_smmu_is_shared_sid() as an inline helper in arm-smmu-v3.h so that
arm-smmu-v3-sva.c and arm-smmu-v3-iommufd.c can use it without repeating
the list_empty() pattern.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c   |  5 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 79 ++++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        | 18 +++++
 5 files changed, 91 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 853276dd54536..b435cc541aed3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -310,7 +310,7 @@ static int arm_vsmmu_vdevice_init(struct iommufd_vdevice *vdev)
 	 * arm_vsmmu_vsid_to_sid() maps a vSID to master->streams[0] alone, so
 	 * more streams would leave the rest stale and none reads out of bounds.
 	 */
-	if (master->num_streams != 1)
+	if (master->num_streams != 1 || arm_smmu_is_shared_sid(master))
 		return -EOPNOTSUPP;
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index faeec656da9e7..b74fe609c907a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -281,6 +281,9 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
 		return -EOPNOTSUPP;
 
+	if (arm_smmu_is_shared_sid(master))
+		return -EOPNOTSUPP;
+
 	/* Prevent arm_smmu_mm_release from being called while we are attaching */
 	if (!mmget_not_zero(domain->mm))
 		return -EINVAL;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index 864d9f2350bc1..a3fbcd88675a5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -215,6 +215,7 @@ static void arm_smmu_test_make_cdtable_ste(struct arm_smmu_ste *ste,
 		.stall_enabled = stall_enabled,
 	};
 
+	INIT_LIST_HEAD(&master.shared_masters_elm);
 	arm_smmu_make_cdtable_ste(ste, &master, &master.cd_table, ats_enabled,
 				  s1dss);
 	if (feat & ARM_SMMU_MASTER_TEST_NESTED) {
@@ -351,6 +352,7 @@ static void arm_smmu_test_make_s2_ste(struct arm_smmu_ste *ste,
 		.pgtbl_ops = &io_pgtable.ops,
 	};
 
+	INIT_LIST_HEAD(&master.shared_masters_elm);
 	io_pgtable.cfg.arm_lpae_s2_cfg.vttbr = 0xdaedbeefdeadbeefULL;
 	io_pgtable.cfg.arm_lpae_s2_cfg.vtcr.ps = 1;
 	io_pgtable.cfg.arm_lpae_s2_cfg.vtcr.tg = 2;
@@ -506,6 +508,7 @@ static void arm_smmu_test_make_s1_cd(struct arm_smmu_cd *cd, unsigned int asid)
 		},
 	};
 
+	INIT_LIST_HEAD(&master.shared_masters_elm);
 	io_pgtable.cfg.arm_lpae_s1_cfg.ttbr = 0xdaedbeefdeadbeefULL;
 	io_pgtable.cfg.arm_lpae_s1_cfg.tcr.ips = 1;
 	io_pgtable.cfg.arm_lpae_s1_cfg.tcr.tg = 2;
@@ -549,6 +552,7 @@ static void arm_smmu_test_make_sva_cd(struct arm_smmu_cd *cd, unsigned int asid)
 		.smmu = &smmu,
 	};
 
+	INIT_LIST_HEAD(&master.shared_masters_elm);
 	arm_smmu_make_sva_cd(cd, &master, &sva_mm, asid);
 }
 
@@ -559,6 +563,7 @@ static void arm_smmu_test_make_sva_release_cd(struct arm_smmu_cd *cd,
 		.smmu = &smmu,
 	};
 
+	INIT_LIST_HEAD(&master.shared_masters_elm);
 	arm_smmu_make_sva_cd(cd, &master, NULL, asid);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0ff513f9e0bc1..ee6060f05538f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1692,7 +1692,8 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 		CTXDESC_CD_0_V |
 		FIELD_PREP(CTXDESC_CD_0_TCR_IPS, tcr->ips) |
 		CTXDESC_CD_0_AA64 |
-		(master->stall_enabled ? CTXDESC_CD_0_S : 0) |
+		(arm_smmu_master_stall_enabled(master) ?
+			 CTXDESC_CD_0_S : 0) |
 		CTXDESC_CD_0_R |
 		CTXDESC_CD_0_A |
 		CTXDESC_CD_0_ASET |
@@ -1947,7 +1948,7 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 		FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 		FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
 		((smmu->features & ARM_SMMU_FEAT_STALLS &&
-		  !master->stall_enabled) ?
+		  !arm_smmu_master_stall_enabled(master)) ?
 			 STRTAB_STE_1_S1STALLD :
 			 0) |
 		FIELD_PREP(STRTAB_STE_1_EATS,
@@ -2034,7 +2035,8 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 		STRTAB_STE_2_S2ENDI |
 #endif
 		STRTAB_STE_2_S2PTW |
-		(master->stall_enabled ? STRTAB_STE_2_S2S : 0) |
+		(arm_smmu_master_stall_enabled(master) ?
+			 STRTAB_STE_2_S2S : 0) |
 		STRTAB_STE_2_S2R);
 
 	target->data[3] = cpu_to_le64(pgtbl_cfg->arm_lpae_s2_cfg.vttbr &
@@ -3194,6 +3196,20 @@ arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	}
 }
 
+static bool arm_smmu_ste_is_release(const struct arm_smmu_ste *target)
+{
+	u64 data0 = le64_to_cpu(target->data[0]);
+	u64 data1 = le64_to_cpu(target->data[1]);
+
+	if (FIELD_GET(STRTAB_STE_0_CFG, data0) == STRTAB_STE_0_CFG_ABORT)
+		return true;
+
+	return FIELD_GET(STRTAB_STE_0_CFG, data0) ==
+		       STRTAB_STE_0_CFG_S1_TRANS &&
+	       FIELD_GET(STRTAB_STE_1_S1DSS, data1) ==
+		       STRTAB_STE_1_S1DSS_TERMINATE;
+}
+
 void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 				  const struct arm_smmu_ste *target)
 {
@@ -3209,8 +3225,7 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 
 	for (i = 0; i < master->num_streams; ++i) {
 		u32 sid = master->streams[i]->id;
-		struct arm_smmu_ste *step =
-			arm_smmu_get_step_for_sid(smmu, sid);
+		struct arm_smmu_ste *step;
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
@@ -3219,6 +3234,19 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 		if (j < i)
 			continue;
 
+		/*
+		 * A shared STE represents the group's domain, not a single
+		 * master. Every sharer builds the same normal-domain STE, so
+		 * any of them may program it. A release/blocked attach would
+		 * instead abort the translation for the surviving sharers;
+		 * skip it until the last master (no longer shared) tears the
+		 * STE down.
+		 */
+		if (arm_smmu_is_shared_sid(master) &&
+		    arm_smmu_ste_is_release(target))
+			continue;
+
+		step = arm_smmu_get_step_for_sid(smmu, sid);
 		arm_smmu_write_ste(master, sid, step, target);
 	}
 }
@@ -3229,6 +3257,9 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 	struct arm_smmu_device *smmu = master->smmu;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
+	if (arm_smmu_is_shared_sid(master))
+		return false;
+
 	if (!(smmu->features & ARM_SMMU_FEAT_ATS))
 		return false;
 
@@ -3366,8 +3397,7 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
 	if (!master->stall_enabled)
 		return 0;
 
-	/* We're not keeping track of SIDs in fault events */
-	if (master->num_streams != 1)
+	if (master->num_streams != 1 || arm_smmu_is_shared_sid(master))
 		return -EOPNOTSUPP;
 
 	if (master->iopf_refcount) {
@@ -3889,7 +3919,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 		 * terminate faults.
 		 */
 		if (master->ats_always_on ||
-		    master->stall_enabled ||
+		    arm_smmu_master_stall_enabled(master) ||
 		    arm_smmu_ssids_in_use(&master->cd_table)) {
 			cd_table = &master->cd_table;
 			cdptr = arm_smmu_alloc_cd_ptr(master, IOMMU_NO_PASID);
@@ -3962,6 +3992,9 @@ static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
 		return -EINVAL;
 
+	if (arm_smmu_is_shared_sid(master))
+		return -EOPNOTSUPP;
+
 	/*
 	 * We can read cd.asid outside the lock because arm_smmu_set_pasid()
 	 * will fix it
@@ -4490,9 +4523,20 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				break;
 			}
 
-			if (stream->master->stall_enabled) {
+			if (stream->master->stall_enabled ||
+			    master->stall_enabled) {
+				dev_warn(master->dev,
+					 "Shared StreamID 0x%x rejected: stall enabled\n",
+					 sid);
+				ret = -EBUSY;
+				break;
+			}
+
+			if (stream->master->ats_always_on ||
+			    stream->master->ats_enabled ||
+			    arm_smmu_ssids_in_use(&stream->master->cd_table)) {
 				dev_warn(master->dev,
-					 "Shared StreamID 0x%x rejected: existing master has stall enabled\n",
+					 "Shared StreamID 0x%x rejected: existing master has PASID/ATS enabled\n",
 					 sid);
 				ret = -EBUSY;
 				break;
@@ -4614,6 +4658,16 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	master->smmu = smmu;
 	dev_iommu_priv_set(dev, master);
 
+	/*
+	 * Resolve the stall policy before inserting the master. StreamID
+	 * sharing is rejected when either device wants stalling, and the
+	 * insert path needs to know the incoming master's policy.
+	 */
+	if ((smmu->features & ARM_SMMU_FEAT_STALLS &&
+	     device_property_read_bool(dev, "dma-can-stall")) ||
+	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
+		master->stall_enabled = true;
+
 	ret = arm_smmu_insert_master(smmu, master);
 	if (ret)
 		goto err_free_master;
@@ -4635,11 +4689,6 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		master->ssid_bits = min_t(u8, master->ssid_bits,
 					  CTXDESC_LINEAR_CDMAX);
 
-	if ((smmu->features & ARM_SMMU_FEAT_STALLS &&
-	     device_property_read_bool(dev, "dma-can-stall")) ||
-	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
-		master->stall_enabled = true;
-
 	ret = arm_smmu_master_prepare_ats(master);
 	if (ret)
 		goto err_disable_pasid;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c57221b311245..03fa965c4c888 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1242,6 +1242,24 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
 
+static inline bool arm_smmu_is_shared_sid(struct arm_smmu_master *master)
+{
+	return !list_empty(&master->shared_masters_elm);
+}
+
+/*
+ * The stall fault model is negotiated per device. A shared StreamID cannot
+ * represent differing per-device policies and stall events cannot be
+ * attributed to a single master, so sharing always terminates faults.
+ *
+ * This must be used consistently for CD.S, STE.S1STALLD and STE.S2S: an
+ * implementation can flag C_BAD_CD/C_BAD_STE for a mismatched CD/STE pair.
+ */
+static inline bool arm_smmu_master_stall_enabled(struct arm_smmu_master *master)
+{
+	return master->stall_enabled && !arm_smmu_is_shared_sid(master);
+}
+
 static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
 {
 	return dev_iommu_fwspec_get(master->dev)->flags &

-- 
2.34.1

