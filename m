Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.66.29
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795085783;
	b=uySKtPstVNZ4jAeG8pznM4OlKx4ObexlfwXBjz8/Jvf7qtUIP7ZfN9uwW2m72rA32+Xh
	 uaIecBt3hg1G+S50HDhafDary5bwcxWL4LKpHrmev3rwRc3AmafKj6Of37J/IVc+w/E/d
	 JZTToc0emcYML/9D2KPNZFSwL40Js+bYe7kpoLSGq5TlZxhDTAb8V5G1ZA3fVr0EMlB0U
	 W78aFL2mG3OEOrXaUnzsJXrrSRTWwRiK1Hw1as8UknyZTUGH3Jzh0CuYWY/n9MhsWMa65
	 KjmSudI2ukSR77cp/iR5D2O8vAHNamqbSyNdO6LGWO3dWKGckxLYhlsHqtmIOw+ORQw==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085783;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Hwi6zMpswp/YGkcVTtaOqJo+iOVtZPKIQEoXJmfyUeA=;
	b=JFRCTZF/J9vLutuFoZluj1oHSbLW+Lq34QeWbCwUNgHyaPZXahIFU3TbWivOhXDfwjDO
	 78zNsUCQAxFBydLK4olFaKUKJl5cDsj8Q259NMp5OqR9rkuZ08FWEeJTWnlZOC9SAA40y
	 kukp6qrneaboJwoOkJfBI4UmQxdELEBjpzYRD4RaK38eJkltj/IJvd5WNT5extM+bJomK
	 y6z5MGkXfTT/Qii2Mx9r93HuTGpDSwqohoeRsmVNKCMrP7wTCfDY474VH4FX+6FAAYEnz
	 7oSUeXRjrVmfWbiu5clebi3I5SkV8FtNsjZxa6jp6Zw40Nrr3+iMOXU6b1tDZ0Wh5Kw==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="f6xMyo7/";
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="f6xMyo7/";
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.66.29
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868A7606A333
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 10:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 868A7606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=f6xMyo7/;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=f6xMyo7/
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=mcKpFozu3QKh9mV7dH8e2iyCBu+htomEvgW23PVN1weQW3EyLPA1RQ4PCgdGtX+zBdaDr9gMrev+Z2w34D3goFtP15rAHWRrUQQLesS6qGPxHj97Ub0xHLHALeW3Q6BjBJdCTheFuGyagzcgWOerYqxmoQl/SKNh7tRL//2czz2exdarZjP0InJIgIIyY41q0VShKpnLtPeW1Fa9J7lDafiYL0eAzQ8aSlMlfMPjTfw8Iewvdsvb5qmhj6Jy0UXVKm3hMWw316Cp/uvFlZE4EROTp4InljgiWOjrzfF7RyBrPbrubPS0Wf1rf1P15Ars7FLIvnOukpqL8683fEuJiQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hwi6zMpswp/YGkcVTtaOqJo+iOVtZPKIQEoXJmfyUeA=;
 b=WvtVISe6UwY1lBbXcSSowM7dKKLaUoP7lWA3y6jH2RdV2+MsF/fbbQCLK7fa+/NdtEh/f5YMBwY+TuT6YGHoyHGcYI5/zSzSSGPD7Wv2OXB+pqQluj5ff9z0eSjMl+qkv0YmBwjVzjN+uzAfewS7FFBxaS6yzN4yjAwDv3QhYEvmboGckrW0dMRpiRQnWMoai8qwspGxn11swfEeyZbZ7Gd1QsvePB5D+lXQfC/6/5pFOOs6A8+o03tkuywDWEYAfT8mBsBwF1+DsByXpy+JU5y4tBoW+bNWJs9sTJxZyYKNEKSMqzqsYCJir1DQeNICyg0lZfmDRkBDbIIG/TjkbQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hwi6zMpswp/YGkcVTtaOqJo+iOVtZPKIQEoXJmfyUeA=;
 b=f6xMyo7/cwC9Q/3ih0aJRsCsxZTr+NG7OAuIDdrgBn8tN+Rd1bV0wGo0te9RYvzF/0XyXHeL+e5t7ZmjmANpr/Q9o0CFjeEwVqNdQSnk6E62nleAw3hrSMx8VZkrG6poNF7+zeho4tyDi7GzmaEyCBijyqqTN4kwwIpYhZOUFAg=
Received: from AS4P189CA0034.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::12)
 by FRZPR08MB10949.eurprd08.prod.outlook.com (2603:10a6:d10:13d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 10:56:16 +0000
Received: from AM1PEPF000C1AD8.eurprd02.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::a0) by AS4P189CA0034.outlook.office365.com
 (2603:10a6:20b:5dd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 10:56:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000C1AD8.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 10:56:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zio4ECOV0bUxjwf43yNqAc4jhguOBFKMahsRL/7h0FybnvNPCclLnc2EGFjPNWT/BrVtbHVKZUhBjMczpUHuAxWWq/fgvEtckA2BOtW24Opom6AEiloA1LAvrvQPEUlqKJjuHguepB7rL5QcSP8QTT6Z+5pZP1PLoyz7BfnGvvoHqDOFdDAd0GDhkda65mqWHzjV5WJPRSgdu/HiY523HxDDgKudiwOylr8fr6/j9ssGXSRQObIgg5zf4sYxEQjLeaQHh63ajnL4D9z8l+u6KSNtMbSaxIujt/08fxTCa/h7nxaukdL9lVG5xt82Ym7izMKetrgfPFakEnBVwJ5KXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hwi6zMpswp/YGkcVTtaOqJo+iOVtZPKIQEoXJmfyUeA=;
 b=KZ+zYK+UeZq1jlBz5Cz7q4dtRgU6PLlJOvmFivTWOF0Dpl4hZjA/uARVvICNzTpnBMnHkPAeu3A0njvM5xDhwv+kLOqqBpsaVj9CUDHSXEAT4JAZNsGMU0FJ2BLrguzNGjaFUhB21sxN7i5UXQTdPbdNjaKgLIH49gqDxU0axMa3QqvQcg8koFzVSuTnQEtGbMcdVC9Gowww+Re4Maa1XTkziu1ygNE6fYBtWypMXjvg06PIwMnvBWk8TwirEm+MuBNHvvtgsBWHy9QcElN43KvImzmhkMSQSLB5koYOPgLn5CPVpwAq6ahpKTltidsCyQdtY3APSoOm/noapopSng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hwi6zMpswp/YGkcVTtaOqJo+iOVtZPKIQEoXJmfyUeA=;
 b=f6xMyo7/cwC9Q/3ih0aJRsCsxZTr+NG7OAuIDdrgBn8tN+Rd1bV0wGo0te9RYvzF/0XyXHeL+e5t7ZmjmANpr/Q9o0CFjeEwVqNdQSnk6E62nleAw3hrSMx8VZkrG6poNF7+zeho4tyDi7GzmaEyCBijyqqTN4kwwIpYhZOUFAg=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com (2603:10a6:102:33f::15)
 by BR0PR08MB693770.eurprd08.prod.outlook.com (2603:10a6:2c8:5d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 10:55:42 +0000
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f]) by PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f%7]) with mapi id 15.21.0615.012; Thu, 19 Nov 2026
 10:55:42 +0000
Message-ID: <dc59b81c-997d-4f79-bd95-be4981e4dd24@arm.com>
Date: Thu, 19 Nov 2026 10:55:41 +0000
User-Agent: Mozilla Thunderbird
From: John Garry <john.garry@arm.com>
Subject: Re: [PATCH v13 04/12] iommu/arm-smmu-v3: Pack the MSI vectors of the
 used sources
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc: robin.murphy@arm.com, joro@8bytes.org, praan@google.com,
 kevin.tian@intel.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
 xueshuai@linux.alibaba.com
References: <cover.1794942324.git.nicolinc@nvidia.com>
 <40570c344d7fce94c4e80316503a9162bb31cb62.1794942324.git.nicolinc@nvidia.com>
Content-Language: en-US
In-Reply-To: <40570c344d7fce94c4e80316503a9162bb31cb62.1794942324.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0011.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::7) To PAWPR08MB8959.eurprd08.prod.outlook.com
 (2603:10a6:102:33f::15)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAWPR08MB8959:EE_|BR0PR08MB693770:EE_|AM1PEPF000C1AD8:EE_|FRZPR08MB10949:EE_
X-MS-Office365-Filtering-Correlation-Id: 5267292b-e399-494f-9373-08df462bbb67
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|11063799006|4143699003|56012099006|261021121427099003|261022075727099003|261021135927099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 oct/z3GNnT+jKbNVZpur5OelW8HBleIfQKN+8ZYBlEnYY9vWMRmhY63mn4kiuu/uBy+iF2uZRvxgSsdhftZJCUxVYxde5hCiePi8/nZtEYgEHw+m7nszGJbcP8jbePBtANfpwASQpEnN0mhyRzm5zwuztt92+BcjznV11Nok9y3Kwb9EmasfqHBsZEe1vympxRGZpvb1Wd6hf3FapEI0CqGtTncJ/DjHOZgotwLr13yc726N5wi2+T4IyWJ3n9LinNywdmJf7dPabVTjXM/eF3jHRFYMNaIaI1WtqUa290THnMtziwKOqx0Uk+5u5mrGG8zbC2vBHCFjqlLLudYQlf6ouJQIMN1mrbgbtDPknYoJrgDsjfFTTPxMLBo3UAcxsaadmu7+hlPdnDO0a6fkirVQFQl2Z9JKh+85il30P8cM4ehf5gHfG5PfmV/YIgABazpnvsOVkNG+1z/X5GqkgEQ9zV7G4oae3hsW/ssHam+/26HOQLGbxWEk/zeqeOyt9alqB8froBlqM3BqTvI5P8jSg2+hU3JJUFzJ+tZuLcxQ/mUYd/luoMvXzPtbMk5p4fVsakdJtM6/EDo7BgRwI23yMsT8YS7IOfdlgEMK/RLGxpKHPh1oeRAi2vE9kltaBDKxA7tTnMxXxqtWRbF6n8S8FRHkQQWiL5CHAadnLAs=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB8959.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022075727099003)(261021135927099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Zmx6ScG4SkwrLroxtYeu7E/9puy10DEBDXxvsj7prQ5o7VsNHewkFLG/rnbMWTydRFvHAcXOpvtO8krgLttlcupGac4PjI4G9tg73IIORQjzIgQHoR6j10lJsrvozNLP/+fctNAGyWf7HV+GQ+BYHNOF4nvDzYIIR0qY8Pyc3BsfTKcU+hiqdP2hfPgxo0d/GINN1jR8+Aw9SV9RUTSZvR7cWuFIh6NYjUHLCzbxeV0+vNF64bhH+N/XVgMEayj8T08nerCnO91e9QOvwAiAwIXRnugNWtb9VyMDOLm0ZeYLTp9rglLt0ecrjB/UJJ+BWgDqPiyfGLquLjaZWO+kSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR08MB693770
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000C1AD8.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a3117db0-de9c-436c-5004-08df462ba77e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|7416014|1800799024|14060799003|23010399003|36860700016|82310400026|261022075727099003|11063799006|4143699003|56012099006|261102123227099003|261021135927099003|10067099003|261021121427099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	YgZsliWtT/rlfcaWCSRX/wF8acS9yoxFA6hJ/0ZyHGLU+OE1QGxhjN9iZWiDQqOu2ZC3utPEt8JMLMdbVO6pVdHiGPNGmrUL5+6sAOzjHpFzluRAmJcILErLseKdMQU1AJ1Y0vfmq4x1fzMs1vndYrgYRFlIDtJXi7goU9+43w/FjWohyZTOdLDIfW+CU6nklJba8ZqbcFy7iyNIwByzPVOTjR/+ZXFGtOXlUpyYViQR7A+i8rKLGUNsmcF0+o6T/xyF4CAX5yHlYn3JlnmObBtdaW7YQDrpamgcHppA6Tb9T5rnEureb7u7PQDPpDfqpsClFGDBIHeQH0b/jDHO5cjp9Lt5fs1kCFSo3+tAgoFK07rgjf8lxHbYSXdKXfvzo/scuonzAkS+fbRAhOIWch0aiOfuXRQNKy64OpU9l1nG7zRba/E6Bi4vrZJLtfDLQcWu6OU/OAXTzQ9OCkCKUg71SYD1nj5FRs8B6jFrX6awxPgOBk4bpPk4fCIdhjfD5jt2ROsRiCRBJil1RkRRgG+GWzmgaNfpR9POfQo0KxbNzStq/7h0JAqZkji+h0UzQBsqjX0pgJXfKNHu4nW+GuUMG/obhK+PuzF2cfbE+VqzHcfGg/X1LE7I5WVzPNr1dup6gmvOfii4hxpXXcizCg/SITLMTYPeJOH0xJlwkuYX4zStiKNYeTtpJBVNaMeuGfqUk9cEhruv8DPc3/vXjA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(35042699022)(7416014)(1800799024)(14060799003)(23010399003)(36860700016)(82310400026)(261022075727099003)(11063799006)(4143699003)(56012099006)(261102123227099003)(261021135927099003)(10067099003)(261021121427099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0ht1TWUtLvbNV/CJftg2xzQhGWQKV7Fyl2qI7spgShZvFkSljAlMUP4kLrxP2hRRg3ZbaGkw3Pj6TdoTe4/4u8HL3TsWeEjId/7t3PdB5Bc3vDrvfIVY6nEv220e1jBnjQgGiydm55YPZwRIb6OKMEydZ9wjCVXzy0jbBngb6XgcA0tEyrk/Qwv37BHKcazHs0TTNUY3j1f4glydossWJQOd9BqAzrVw4/UlMTEIxjZUyWPh1oLfwUCBzdY14KmiyxMNvO/oFoBdj+GzNS2n/ScAxPA3I/mkoTpMkcDQ23oXxOiKbz0bwnlsrBGh1oE+VCtaH6FexuK1ftRr2FOv4b97oRlYEBlNgGajVceiSNZwetDgsTRYGlcF4Aj3KnyqzQg47M+ruvcIB0bYC/i+auVnHYTDIEujCqhYM6ExDFMV0jR/F0o/cZBVOEHo+YyG
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:56:15.0571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5267292b-e399-494f-9373-08df462bbb67
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000C1AD8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB10949

On 11/17/26 19:21, Nicolin Chen wrote:
> arm_smmu_setup_msis() skips the PRIQ vector by decreasing nvec, which only
> works since PRIQ_MSI_INDEX is the last index. A subsequent change will make
> the EVTQ optional for kdump, whose index is 0, so that trick won't work.
> 
> Pack the vectors of the used sources instead, and record the source of each
> vector in a new msi_map, for arm_smmu_write_msi_msg() to find the register
> set, regardless of the sources in use.
> 
> No functional change intended.
> 
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

looks ok, so FWIW:

Reviewed-by: John Garry <john.garry@arm.com>
>   
> +	/* Map each vector back to its source for arm_smmu_write_msi_msg() */
> +	for (i = 0; i < ARM_SMMU_MAX_MSIS; i++)

Some might prefer using brace when body statement(s) covers > 1 line

> +		if (vec[i] < nvec)> +			smmu->msi_map[vec[i]] = i;
> +

