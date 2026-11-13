Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576161;
	b=Jm+9GbZ4YQ9mOLTDTFDAMkem0UDs7PelvAzmmagg1eEW/PahJibQz3wHzuZCFaNO0wTL
	 2lrFZAr7tSmAOqysvJft6fmXLUyy4bAmxA0q6kgFkv8N0txJGr3eSkH8bCDnFlXDS6XCN
	 fnCzOGJ/jQ/EFK36AieemDStnn21DUthGJvEMYazl1vEaGN+zYFKj7nvCz2cdvlnaBayw
	 adfdPb0ZQEfVTXB8exT0ptpqXNcWEFGOnfVmQhM8TEkzx18wT0tYiURfY39Ru2D48w8i8
	 JRyh/pv2KQeoZhTQS0NKGZrphM0Mh2Qf7fnc8/7QwJnjms7M5GbsUPFCoFpOzqIK/cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576161;
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
	bh=/rUGGBN5a0Z1gN7Wg0iu0q584Iftdd7SQhdhkl4Bg0Q=;
	b=AL2JpU9MI6niaNLPApVy+UQmB1EuV9/i73Ju2Lz80r3bB7sL07kJ7M3zgmfF5B1e7iB7
	 4cXR+65Oqzy34pLyk4pLHYd7PzJ0OCp4GNrnlrDBvxwnVIVw6vf0w5TRVHnyu8dXi4qBW
	 pwDZd7bfv0QpLNRbdE5MMfHSOE4hKQ9N2t1jrcXWpx/xaH0mhKuI98hL++UO7Qi7UZKP1
	 mBcB/E3a99m1EaWKcEUNE7pBjN1iEShJZnPLBLcvGQIh35D7clVRFGGeZyGxu6deaCKcd
	 qcsENBwuJcMwLIwr9fgojLTzVElf85D4faZyycpkdOf19xNedEwulP74otkHthUcWGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="P7fJJ/Su";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.9
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010009.outbound.protection.outlook.com [52.101.84.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF0E606A8AD
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 13:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDF0E606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=P7fJJ/Su
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNBJR2hR8uEb34mVL9wVacPFiNR2dIffLX1MM7QO7xx3RfDxM/2EJOQV5D5a0buu9jQnC+zaloX9+bA7s4CtYt7lV92i2aQCa5Vwk5JcYKOQVHfLku1mp4BQ7+rpKA7MJ1BdKzrzZCqCMxLf8bs3VE7r6PeC87h3SEL1byDA81MSiocL0AY5kbggiIZQc21TrYDwenutPwOLK6yGjxZxNw+wv8B01+oGX5Mm6jsLZV/g2kzVBih6eIenxV4BWZ/ptZ7zcwSU9Abalue9Hm3WM3qscBOwXJio+e+7lX/nW+e0LXhIgca6WYV1ALWA96QlUJ5qZVAxl8TyI9VVkzImuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rUGGBN5a0Z1gN7Wg0iu0q584Iftdd7SQhdhkl4Bg0Q=;
 b=TJfzgtaejn1BtQJHZXWGHP3mBGTMArd5AfC5Fc+4ghalwbu70JCn+Zl5To5FcI39k5BZE2WBHxxMQ6LU3ThlkF4F8+b5YErL3o3ua62WCmA5eUI1suGS1Q5hhwKedlGbQbyNSXHEUyl7cGwq4g8rZfDweqtVXtBwOylRvFejeza1+gYr78DopXIi0PGKqL5IDUZqsRILxShRlx+hoACabdfodo/NyxKDk1CoG8gpgVAX14u/tHh+eMd1BKEqCih+EAVIMKvtxmutbidn1gVdTVH8LReMz8MQo8YvnkGvyGw4/FcmDGEiquPu3n5ij4YQEt5IjBfRiGyxfic3psaFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rUGGBN5a0Z1gN7Wg0iu0q584Iftdd7SQhdhkl4Bg0Q=;
 b=P7fJJ/SuXIrtvAJxHqKlnoOHAIZWf5uuwPLd71PwiFcCGknXcwr3UIeuDU92LVTfrSNo8DF8SUokjFRW0wrWYkYy9Nm9O09Yqy1qNkUGRvFH6peYohbkaWKlqVi3U323gmeDiuk1Jx4JmhEVU82ubeZqe0oOBxqJWs/w7thY4JTWupjAoHgg7gh8g25iBEWPkw1Pyfi59JXVNIVWTDucqgOfnzB6ZNuKZOT4vbzRpeRUEULCBAzZTa4n9iBeAxpSmMh5upp5G+JHqXQx4bleUe236n0q0tXFaloUV6Zm7qwVkgXKNntIkDvQuyeYAOKc5dEPjDX2NTuBovG9p4KV7w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by BR2PR04MB007356.eurprd04.prod.outlook.com (2603:10a6:2c8:6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:22:38 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 13:22:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 13 Nov 2026 21:27:14 +0800
Subject: [PATCH RFC v8 2/9] iommu/arm-smmu-v3: Delay stream allocation to
 inside the mutex
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-b4-smmu-shared-sid-ver8-v8-2-587307a77f3a@nxp.com>
References: <20261113-b4-smmu-shared-sid-ver8-v8-0-587307a77f3a@nxp.com>
In-Reply-To: <20261113-b4-smmu-shared-sid-ver8-v8-0-587307a77f3a@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5PR01CA0244.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|BR2PR04MB007356:EE_
X-MS-Office365-Filtering-Correlation-Id: b0fabe6e-d00d-46bf-68a0-08df41892f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|921020|11063799006|261102123227099003|261022075727099003|261021121427099003|261021135927099003|56012099006|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	GfH72Nyt46ZQLUjeggWKxeEGTTdqEVw1j1S77+OMh8anaOkNEokv7adY63TqllK8brpJKkjsLpj9jhRgVRJhYsXayM7F7ycTgOiUIBPyopfhw0VYEx2388qMInw/jU5k5Tu/K6OlzRNiHEhjnYKxD8e+16r2yOVZYGlpnJT51tchF34rbzyxk74FUz5bZs8oZdhw+VBLvU42tRwpEMqEip7AhrJ1a/sYoGrluCdC1bLasrowENC6mPnbjxhIbXPWWsdswvp6ap+jKSFzdAAE5uaMPsLe5IIct182MCgLyWdsWurPZ+cchxgRn0aAs83dlgd9P8Rq2j/SmnLIb51AAtjZkX3nKJhSVMsQh79571poxzcYbzdlj5lSw5gWWLYxHLNX6pZpSRsFB5zCRretiGNU4qNuJLF/tu0t639LQ74ghYCIrRiUnLHVknHxv/2rueL70kX9YA9tF0S6soPoRbioobFqPa8Iyz6yDU3x0Vogk/HQcRj7OkGjqnYswiZc/AcFKB19yTXPcnMHwZmCpMkvgjsIFbxoiV4Hfjcn4n4edYD6ScmsbiTVx3uoKp0/8AdaixCnaHrMeo1yMVO9Ucb00039zVj63/Npvh6D8yTZZy8NCxxVROg5ubnv3eH/gVBnHbtAvhSJSc0PWVkg5JUDymj69LqmDt6jmTcoZkx6CUtCl+qq4UwzO1sBw13ivK2bJko2XtxI1aYLGHnJ+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(921020)(11063799006)(261102123227099003)(261022075727099003)(261021121427099003)(261021135927099003)(56012099006)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3pIOWIyb1dRWi9yNVR5TWZLMHZCbWZITGZnMFAwdXl6dDU4dHp6WGpWdW9i?=
 =?utf-8?B?cDBoUEhITC85Qys0NXhJT3BFZmgzMVhIemZhS200QWhNemVuSDBCTUhIaHNV?=
 =?utf-8?B?NitCNExsMGNNM2M0TzhwQlpTZnF6Wm0rOEZnS3VGemEyV0M0YlloYllIdjVY?=
 =?utf-8?B?TFFmSllnTXkxQmkxWjV0VDhPYTNxTDk3RGJIRlJibm5PSytUcGFrNVBGb0ZL?=
 =?utf-8?B?eTFwM2V1MGFibFFGQldEMnBOUnlESnAyVjc0cXU5VWhTQVUwK093T0lBMUpn?=
 =?utf-8?B?SE5WdE1wQzBEbmFlb0ZMRjduNVA5YkdkaE5vNEszcngzOHYyWnRPS2JBK3Fw?=
 =?utf-8?B?RVlEd0RSUmZFcWh0VFNoTXM4Z0VrT3BuOXJOUlg3TXdXYWRQZHZ1YVF6U09P?=
 =?utf-8?B?L0dpc3FuN05RRHhwZ1UrWVlsaVRmZU1WSzN3SmhIbUZ6U3V3YUhYKzRtYjZm?=
 =?utf-8?B?SmJQV3Y2N3UxdEVBSGpQZlRuWk5hbmFXcnZkemNpdlRubE9TdjZCak5OcWo2?=
 =?utf-8?B?NWpTd2RXUjFYRW8yd1JyVkVaR0tBbWQ0SU11TG8yb1R3ZWtxUitZUUVlSHA3?=
 =?utf-8?B?b2YzelBvazltUUphT1YvdzBLU1dYVEI2SFJlSkdIRWhINDBRQ0Q5bzliV0xN?=
 =?utf-8?B?U3Z1OVRnOE1RSG8yTjAzYU1JaHJxbVZWalVkc2wrS3Btb2F5SVZuWktaUzBP?=
 =?utf-8?B?SS8xWm5aRktXVzZDNXBCNTR5aG5pVWcrazAreEVuY2FKUkl5bGNpZ1QvWGZK?=
 =?utf-8?B?dlhrd3ZHUU94UWwrODd1bk96dWZTa3lncTgyeXhReW9ueXpUS29INzJBTTBM?=
 =?utf-8?B?ZFd1dU5oTmMyZ3gvT2Y0ckFRWGRlRWFUakpxdkY2KzJDQ28vMkg4RTJTVnEw?=
 =?utf-8?B?akdGRUw2TkFQU2xMTnV0bHBESVhsVk1xWmczakttbXY4SWlNTzY2cGFkeDJi?=
 =?utf-8?B?NWFJSm5XMy9lM1hnWjZEaXlaQ05pNlV1OXRHSlJ5aWJKaTRiQVExU1RXbkI5?=
 =?utf-8?B?QUZNZE0xQ3JXK2FBdU9STkY3QkdXRFpyRXlxWG9jazJLKzRtTTBXMnlqWWc3?=
 =?utf-8?B?OG1pYm02VDlFVHlpdGRjWU4yc1dNS3pBeVMyNzdjS0FXZXBlbStjaTR0Zlk1?=
 =?utf-8?B?RG12RE9zcndzQjJ0bnc3VkVxS0FKQXB2d20ycGsrMm5VNVU4ZHVxbjM4S25T?=
 =?utf-8?B?c0l4bkV3QkRlYTFNc1V2WjBFNXdDSS9mSEJwSWxWdGNubDAyYndQYjRrdGI1?=
 =?utf-8?B?aStoY2JPdXdWQlhSdmlWYlRFTTVIY3hzYk10cjdYWk1tTFZ1NDRUYmQ4V00v?=
 =?utf-8?B?TGxENFhEV1ZZMUdvN3MrTGd4ZktsdlBCZk1SbFJ6eUxwU2U4YzI5M3p3bXhK?=
 =?utf-8?B?U2daNTdkc1pFazRSdVlKandUNU5vS3Bra05odjl4bFJVYzRPQ0YzVHduU3lL?=
 =?utf-8?B?anI1K083SGF6VnQzMWNrQ0FuT2R5NFVUang4THJucnNiY1hGSitJSW05Nm8v?=
 =?utf-8?B?alVSeDFaemphU0puaEpBNFNDZXp0L05PdFUwQ1pyOGtSTTQzZm9tdUROYm5O?=
 =?utf-8?B?Z1FxaUh6ZXlWbUdVakFqM0E2b2M4RlBHa05OZ0hIcFp4Q05JNzV6ZWFXZTdN?=
 =?utf-8?B?eVorNmxYUzloL0FtVTloSC81T0N4WnpvaUNja0l2cnNFNE1OQ2FLSTBhRDJD?=
 =?utf-8?B?UDZBMkwzSmlrR2o2dEw1T08wNm8vVkxtbkFaZHNYenYzRkNVOE5LM1c1bFVs?=
 =?utf-8?B?SEpvMGhHWHkvVnY1cVpWa3RheHEyTG4yZ3VEdFpsQ1JWb3IrRWlRM1kvT01u?=
 =?utf-8?B?NVBmaENRcERNY2RxNGQrZWZldGRqNzhSNFRNd3BEZWhBOHNpL2t1R1NIQjYz?=
 =?utf-8?B?MUtNUXNFMkxjRXo4WHdob3lvWThPR0ErdDQrUEhtSW40RVlLbG5ueDFhbElB?=
 =?utf-8?B?TEdNOUlSZGFxdUYyVmtYTHhMN1pFWGpOQzdKell3aHNlaHpKSzhxVkdzbWdo?=
 =?utf-8?B?bVRCbi9XLzFTSzIyM2NsQ1RvUHhkK21YVGJESk5rL3RSWURMczhrRXdDYk5k?=
 =?utf-8?B?T3BuM0tSaGpaWG5rT3VsWnAxRDZHMGNUclhrUVNlTk9NRmlqK0ZaMDlMWWJ6?=
 =?utf-8?B?ck5aV2dTeVdMU0Z6MXZlV24xdnYwYjAvM3NZTWlKRFl0QnIyeGdpV2t5Nlpq?=
 =?utf-8?B?Umh1VGhIaTZUVDlQT2l4ZDMydENvek5CMlhoSXRMVmowUWlpN245S0FUZ3hI?=
 =?utf-8?B?WTNVb1g4b1EvMzFTT2dZK2Rjb09jdVMrR1U5cmZ6ajhndENxWklLZjBxcHcw?=
 =?utf-8?B?eVE4dlhtSDloWWIrYjA2bzNnYjlOUGludTBiWkI4K1JEMy96UlF5UlJMMVhI?=
 =?utf-8?Q?xMElHaeayeAkSElW/CJZ/r+R3MC4BeR2Sd+Nq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fabe6e-d00d-46bf-68a0-08df41892f9d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:22:37.8917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUk/SmDZja2bkNmIxpkl2c4b+ewfA1Y8+B+on7SLZBRoAe9IhrrVBvzpEX7RQVjukR7+7FTRaWtvZ9qws5GAz6Is3GJmaiAPaT+bwScCiKMkhnvJPuTH1xHUU8A3kRsy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB007356

From: Peng Fan <peng.fan@nxp.com>

Move arm_smmu_stream allocation from upfront (before the mutex) into
the mutex-protected loop in arm_smmu_insert_master(). Instead of
pre-allocating all stream objects and then inserting them into the RB
tree, first look up whether the SID already exists in the tree via the
new arm_smmu_find_stream() helper. Only allocate and insert a new
stream when no existing entry is found.

Duplicated Stream IDs from bridged PCI devices are now actively
skipped rather than stored as duplicate pointers. A separate write
index (n) tracks only unique entries, and master->num_streams is set
to the deduplicated count. This eliminates the need for duplicate-
pointer tracking in all cleanup paths.

Extract arm_smmu_find_stream() from arm_smmu_find_master() to provide
stream-level lookup, which will also be used by subsequent shared-SID
patches.

Extract arm_smmu_free_master_streams() to share the stream cleanup
logic between the error rollback in arm_smmu_insert_master() and
arm_smmu_remove_master().

The sort is moved after the mutex section, since streams are now
populated inside the loop rather than beforehand.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 124 ++++++++++++++--------------
 1 file changed, 60 insertions(+), 64 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 87ae1acb6146..339b94f2a8a4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2076,8 +2076,8 @@ static int arm_smmu_streams_cmp_node(struct rb_node *lhs,
 		&rb_entry(lhs, struct arm_smmu_stream, node)->id, rhs);
 }
 
-static struct arm_smmu_master *
-arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
+static struct arm_smmu_stream *
+arm_smmu_find_stream(struct arm_smmu_device *smmu, u32 sid)
 {
 	struct rb_node *node;
 
@@ -2086,7 +2086,18 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 	node = rb_find(&sid, &smmu->streams, arm_smmu_streams_cmp_key);
 	if (!node)
 		return NULL;
-	return rb_entry(node, struct arm_smmu_stream, node)->master;
+	return rb_entry(node, struct arm_smmu_stream, node);
+}
+
+static struct arm_smmu_master *
+arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
+{
+	struct arm_smmu_stream *stream;
+
+	stream = arm_smmu_find_stream(smmu, sid);
+	if (!stream)
+		return NULL;
+	return stream->master;
 }
 
 /* IRQ and event handlers */
@@ -4282,10 +4293,25 @@ static int arm_smmu_stream_id_cmp(const void *_l, const void *_r)
 	return cmp_int((*l)->id, (*r)->id);
 }
 
+static void arm_smmu_free_master_streams(struct arm_smmu_master *master)
+{
+	struct arm_smmu_device *smmu = master->smmu;
+	int i;
+
+	lockdep_assert_held(&smmu->streams_mutex);
+
+	for (i = 0; i < master->num_streams; i++) {
+		if (!master->streams[i])
+			continue;
+		rb_erase(&master->streams[i]->node, &smmu->streams);
+		kfree(master->streams[i]);
+	}
+}
+
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				  struct arm_smmu_master *master)
 {
-	int i;
+	int i, n;
 	int ret = 0;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 	bool ats_supported = dev_is_pci(master->dev) &&
@@ -4294,7 +4320,6 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	master->streams = kzalloc_objs(*master->streams, fwspec->num_ids);
 	if (!master->streams)
 		return -ENOMEM;
-	master->num_streams = fwspec->num_ids;
 
 	if (!ats_supported) {
 		/* Base case has 1 ASID entry or maximum 2 VMID entries */
@@ -4308,99 +4333,70 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct arm_smmu_stream *new_stream;
-
-		new_stream = kzalloc_obj(*new_stream, GFP_KERNEL);
-		if (!new_stream) {
-			ret = -ENOMEM;
-			goto out_free_streams;
-		}
-		new_stream->id = fwspec->ids[i];
-		new_stream->master = master;
-		master->streams[i] = new_stream;
-	}
-
-	/* Put the ids into order for sorted to_merge/to_unref arrays */
-	sort(master->streams, master->num_streams,
-	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
-	     NULL);
-
-	/*
-	 * Clear after sorting: RB_CLEAR_NODE() records the node's own address,
-	 * which sort_nonatomic() invalidates by relocating the entries.
-	 */
-	for (i = 0; i < fwspec->num_ids; i++)
-		RB_CLEAR_NODE(&master->streams[i]->node);
-
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct arm_smmu_stream *new_stream = master->streams[i];
-		struct rb_node *existing;
-		u32 sid = new_stream->id;
+	for (i = 0, n = 0; i < fwspec->num_ids; i++) {
+		struct arm_smmu_stream *stream;
+		u32 sid = fwspec->ids[i];
 
 		ret = arm_smmu_init_sid_strtab(smmu, sid);
 		if (ret)
 			break;
 
-		/* Insert into SID tree */
-		existing = rb_find_add(&new_stream->node, &smmu->streams,
-				       arm_smmu_streams_cmp_node);
-		if (existing) {
-			struct arm_smmu_master *existing_master =
-				rb_entry(existing, struct arm_smmu_stream, node)
-					->master;
-
+		stream = arm_smmu_find_stream(smmu, sid);
+		if (stream) {
 			/* Bridged PCI devices may end up with duplicated IDs */
-			if (existing_master == master)
+			if (stream->master == master)
 				continue;
 
 			dev_warn(master->dev,
 				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
-				 sid, dev_name(existing_master->dev));
+				 sid, dev_name(stream->master->dev));
 			ret = -ENODEV;
 			break;
 		}
+
+		stream = kzalloc_obj(*stream, GFP_KERNEL);
+		if (!stream) {
+			ret = -ENOMEM;
+			break;
+		}
+		stream->id = sid;
+		stream->master = master;
+
+		rb_find_add(&stream->node, &smmu->streams,
+			    arm_smmu_streams_cmp_node);
+		master->streams[n++] = stream;
 	}
+	master->num_streams = n;
 
 	if (ret) {
-		for (i--; i >= 0; i--)
-			if (!RB_EMPTY_NODE(&master->streams[i]->node))
-				rb_erase(&master->streams[i]->node,
-					 &smmu->streams);
+		arm_smmu_free_master_streams(master);
 		mutex_unlock(&smmu->streams_mutex);
-		goto out_free_streams;
+		kfree(master->streams);
+		kfree(master->build_invs);
+		return ret;
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
-	return 0;
+	/* Put the ids into order for sorted to_merge/to_unref arrays */
+	sort(master->streams, master->num_streams,
+	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
+	     NULL);
 
-out_free_streams:
-	for (i = 0; i < master->num_streams; i++)
-		kfree(master->streams[i]);
-	kfree(master->streams);
-	kfree(master->build_invs);
-	return ret;
+	return 0;
 }
 
 static void arm_smmu_remove_master(struct arm_smmu_master *master)
 {
-	int i;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
 	if (!smmu || !master->streams)
 		return;
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++)
-		if (!RB_EMPTY_NODE(&master->streams[i]->node))
-			rb_erase(&master->streams[i]->node, &smmu->streams);
+	arm_smmu_free_master_streams(master);
 	mutex_unlock(&smmu->streams_mutex);
 
-	for (i = 0; i < master->num_streams; i++)
-		kfree(master->streams[i]);
-
 	kfree(master->streams);
 	kfree(master->build_invs);
 }

-- 
2.34.1

