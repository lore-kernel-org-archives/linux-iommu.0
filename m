Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.69.49
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794832025;
	b=dtL6SKtcF9lcAzRN5+JfsPwEx0TKnqMVjDfV7zi4vS5KQJlt5E6sIQ/UreAx6kHDkB39
	 8fc7pPDvWdPB74K1m8Y51DnOjmBx5iTPoOgms+dbUjJLA2HWUEqaA/Sox8aqbHB/ZsfDn
	 Um2ItO5F0iIfd7LzB9qXFGZf0QJ4Gba7W/XoMNa0c3lW8auXV4pnjJGva26CkgYWe1+qs
	 GNkwOAZKW+VQLBY1Yckd77fG7IJ3eIoDyuVqK/YJ8KfFfMOJaWAdY46B1kfFTwI4lok4d
	 Wqm3hMG/IvtRNgCUESDaWLojmEe5RBwQEiBhndHGIbI7YtFZTd/6Y81MrLGyA25E2Tg==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794832025;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	bh=Gb6FHfUUTcGeGCBkdYD9HQQYS+FE19BLuIb7TB5ZLAM=;
	b=XX3oACPFTaA9ugu9dQC3Yf4KTq5NOxrQ9kH5AoHbNvvsQ3gIxBOrkV6Wo1KmLjoNI0/4
	 TrQRYLjgZgGpnlYibNMgC7pJQTkhVOFaMXFSrQ2TkEb48uRvJI0cfyF5jJsPYB41hZeNF
	 CqDSnqqW51dXZObIdf8unnz+oP3lu14FTr4ramN/zPQr7k5muLZNdVbnbuLy+jhuBkxZA
	 hLa4JNmDEC7xx59JEJZ6YC0BrLYHmGsPI3tr8HHjvy52OCCRsDHBxxChGnlfU6nm1aSG5
	 1wLlrYp5io3/wPGKtB2pcAyPChDjgt/COkppiD1WyA3GMRjvxNTSzgfCZHeW0cmZK0A==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="E4ACtHp/";
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="E4ACtHp/";
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.69.49
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C886F606A32F
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 12:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C886F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=E4ACtHp/;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=E4ACtHp/
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=mYyq1uWrs4yKB9r9F7tGMBOr/pau+gmWFeCj4K6qmcDXlbNVBeyZCeiwpEY/CAX6Gm08r3GQlqH8JW/ZDJpZ9yOsK8q0RFH0T258GtTS+kKrdHqLfZrCQ4URIdBM4cX3DimEjSzcsf5qTdMnCdvFow+cExBX/t+gVNyOeTdfuz+vyCd/ArWm/9+BLacmsDHdiaNOhkDGep5I/34mhqDrOPYwpchIAOqwfysaBpO/WiW0b0IO4HiFW2wCbhnb+HWMIubwDdkKBeMEkNb9xcyBSqW75odcXahQ+9XSEGeCmUnMhDe14J6FMgVGY6QB/ACHD2jNLHG3+HiiiGVgGRbf9w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gb6FHfUUTcGeGCBkdYD9HQQYS+FE19BLuIb7TB5ZLAM=;
 b=QfhIYxe8XFauEn0r58b7waKKIxYL0DsYCWzkj75BApGO8mq1XSDYy4n4mp5v+PTk4Mju0svcpfdHbBnboXVBKiHTSc72rNwWNnJ0hFkMohrITR8GJX2KFgw5Ap0djGam5OO4jXlM+lmBO/lzV9m/RtSOpX8RMyfrLD0qPt82cgdiio0khC0QGRYm9NGiwg/g15gob1+/wgX3rs8e0qoSROfz65sdCfemVI1WT15zkSdqzMshx2QGsSJaNxpPk2XTp0iQlucA0N1zOVnIdDc7ue652070hVlMOYl7yqgy4QhKcJbj+FzSL8WZl1fcIZNYQCvvz4xsrxL3nEQO9tAbyw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb6FHfUUTcGeGCBkdYD9HQQYS+FE19BLuIb7TB5ZLAM=;
 b=E4ACtHp/U6m7O7B6kwjUS7+r6zmmo5Zn3eFxz3FkPUzIeIfemgoIqJAYsldYu+5HipbCL7Sj7039LB+tTa1BfRfzsRkGWF8FC8XxXDg1RYQAJamgv4bIa8oxgf1J3YlCKzi+kajjOMhCd+4RMii6aw1zt9FkiAuu0QR2X7smvhk=
Received: from DU7P251CA0011.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::13)
 by VI0PR08MB11223.eurprd08.prod.outlook.com (2603:10a6:800:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 12:26:54 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:551:cafe::9b) by DU7P251CA0011.outlook.office365.com
 (2603:10a6:10:551::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 12:26:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 16 Nov 2026 12:26:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNsaP2008rMbTbP5/XsohMOsalWlSIKxwa/QxBUVWSbSiMhS4qHCNjBXpLYbE3hacKHMMLOgLNu7KDmuuwstMmjGzpU8Thl0IPd8+MTE/PtmgCn4TsEm83xdTkNEx5JKN/qCRoKts5X5k4i73OgiV0b/Mj26qdfCCki88BA7pa7mp9CSfFs+guaRm95SNeG10ItV+wGgz8aJGx4qih10SZYKcZ/zuhXYxkXE4oNzgq+PwHIryiuLA7w/I9kGqtxRqgRYEBCE0SVEa5qxKKarLaXjL1l7TMyL0Ms37oDaz0hVOHei/mDEA4liykLUZjIGHQoYsS69JoGZXT36MuLbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gb6FHfUUTcGeGCBkdYD9HQQYS+FE19BLuIb7TB5ZLAM=;
 b=CA1IPiFsGMlQzwZAFZZCtAkF2L0SJMPo4lx43+L5/zGbsbuR6BuE1mJhiTXK6N/UUGZe/fotgMR64oXrWl7J5ML+8XaNwYBPH484rhDdFRB7+ZItr4JquJhDeCeiIxeLxcKL5FUIu3OIibStwyxOVhMg/SQ8m1Xin0egddH1UEx+XlEMDXR3hWCmNAZtI45LPYrtjq1x0Cce4+3OrxmoyuGv3av2LeSEYFWsfh8uGZwdURNh8kCxxLs3EDDEfqYrDhA6h0vWPFO6VmT/A0NBfffAjRDBbxIt5YqM7Z9R/qk4NaPBkYpxKOAdYAlkfIeCiR/xNjwbho/WtbDs4JxHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb6FHfUUTcGeGCBkdYD9HQQYS+FE19BLuIb7TB5ZLAM=;
 b=E4ACtHp/U6m7O7B6kwjUS7+r6zmmo5Zn3eFxz3FkPUzIeIfemgoIqJAYsldYu+5HipbCL7Sj7039LB+tTa1BfRfzsRkGWF8FC8XxXDg1RYQAJamgv4bIa8oxgf1J3YlCKzi+kajjOMhCd+4RMii6aw1zt9FkiAuu0QR2X7smvhk=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com (2603:10a6:102:33f::15)
 by AM8PR08MB5826.eurprd08.prod.outlook.com (2603:10a6:20b:1c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 12:26:21 +0000
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f]) by PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f%7]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 12:26:21 +0000
Message-ID: <4cf391ff-804a-46a1-8d3e-d0ff8442841f@arm.com>
Date: Mon, 16 Nov 2026 12:26:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 11/12] iommu/arm-smmu-v3: Skip RMR bypass for kdump
 adoption
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc: robin.murphy@arm.com, joro@8bytes.org, praan@google.com,
 kevin.tian@intel.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
 xueshuai@linux.alibaba.com
References: <cover.1793593923.git.nicolinc@nvidia.com>
 <22a06965287dd478ee92f8028ae8ac27e054555d.1793593923.git.nicolinc@nvidia.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <22a06965287dd478ee92f8028ae8ac27e054555d.1793593923.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::10) To PAWPR08MB8959.eurprd08.prod.outlook.com
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
	PAWPR08MB8959:EE_|AM8PR08MB5826:EE_|DU2PEPF00028CFF:EE_|VI0PR08MB11223:EE_
X-MS-Office365-Filtering-Correlation-Id: 769f6b30-58ee-4efc-b512-08df43dce634
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|261021135927099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 Obo45zSvFZ/2Uq+sZCvGony9CfaSBG0IwB8XGu6bi0/KbCInvDkdumWxsKUKQzOEC1Q0aH/PNuHGVToSnOuwTxTu/1/XypYho3h/8/hTYFf2A39Nx1Kgt/NUJVxFxuYY4kb26r3hSGUW91hUjE3sRRcIZEOT4mt/a/m7Ddv9Khp0OhAcOacEZmU+s2ZhVQwy2BEzs9aIAzb67rJcDI9+KGa0MY6vPQemcQSzL7u0l8cyR3SXoH06m8Wzay3DwyomJ2eig15hHkCG2H+h2ByxUy9tVnaM0OxtG9ZeY35JbDS1hwDwUe9hTLMm1V+rvYOLHZG7Nujfhsb62uhgRsG5+sGy0ODrSy5gQOmLCOyHW3fbIQ5zRL5xrcvIai3VR6cMW+LZg9+W5euXUM2Vvm3pGMW+BjaazBMwH20EnBuH3mGpiBAAiyryO7er0AuIkkqvAthI5k9tqNxxotiKFJQa81CAJbFhTEPh6X17CFqpOgco6YSL/WkT2/lHjcrjawb31Yz5o5+nTpi4cfEIUx/n0/BeYQxolqobY98RJ6oBktfjd6t+twu2yUfuTiGWOL0alMtzwVLMHtzUaXorkPzSwUaxPPeTcoGshsnjXOZ450Gd0jYPi9CszhT6DVtDpAJd1kfMoTxqQv2NLj8DB0fQ+S2N9c8TMpz/T7bY16iqbPY=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB8959.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Vxqs1SyjvG+k5/YMCBUVnR7nYryn0bhmhxpEDroaUsxcO6hN55ksWqNrL543IiTEGbh3jpn/FrvH+rrZtqwsKQucS1UX9w8Fy6Q75/m1Wwp5NRYMOpISxbrR/ccHYcBnxpRrpk8QDDHd6+8u/fJlwPmZzv5hHrbirhTRrgVontRqp/sZnm4saFm6FUp6Ok6Ry5UOE6Uc2KigDaTGzu0DjE676PrQAjaZW0faJMWND2PA81cLyoLpSKAVuBtp6XTrAfR+rLT4eiIkp7de9MjxoUhVMjcXOrIC2mjPWrF1aHBILVFX+SF0RbiyUo3StssLs5zZu7eee1JLjcdDhh31oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5826
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	72d000c7-aa8d-4c47-a9ae-08df43dcd2a0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|14060799003|7416014|376014|30052699003|35042699022|1800799024|82310400026|36860700016|10067099003|56012099006|4143699003|11063799006|261026121527099003|261026140227099003|261028144727099003|261021135927099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	vFbWKIwi+u4u4wPNB1DoynJvAA5xkVWuZ86ehL7/kMTj8HA33VGkb2ko1DnofYGefTdd/h4ufEfShokLiFcs/SNaSeNEpJKPcdHhxu3nbIVOYYzFBLzkFjLRJEW3WbwJH4GPiQh2Iz15TnBJXe/zDyDO2H0Yb1uuYqwdFZRU9wiImvTMAgcAT8VDc+7o4yZ9BQXg0XGTbXNxlYXwFM+pkYQoqy8ksKlfz9KpU2NU0dY5v5EQX+WJh5W3EHcq/Hw2hlbcgL+59J3R7TfmNlaCUFYfYBxs3IlrecMHro/goNz097mB4/tSmbr0g2h6rVhGz/OUgqDb5dPreAR0lve0mIAT3VcEHsNiSC7g35yPGMJLnCkPUWoMT2QIeQX/TO7QLKTFOrTPBdK1KyFCFBc0BhWj4gC0xBwLEH8970Qt96oChe4Gh9VBnBcQbW3iMYyG0ZBXzlDp9R2CM97oeJ076zbvKbP7EIU12T208X3rbGVdlXSstFM6lW1lN865j1bx0RoXAGi8j5tdIkcMMvJ90WBu85WQAuG9LX8jdS6P+aAom2vWN6xBYdpL5GHL52+R3RsiTYIZcfFEYty6MwY5n3/LuPUykwRVc+4E5PMGqschWqXxEVLeN1v6BobLFCMPkiYW0O40Of2LungTf82Oq4b5sLJOUcyt0Rz5dOxQtAi/B9GK7dfRORjyejuOmij7bJk6rxDkGFuoOvsKw3DXGw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(14060799003)(7416014)(376014)(30052699003)(35042699022)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3OC3smq+OYNoMMw9bQOTQfglGJ68/7+r+gKK3abFa/loVNRztGTlL2xf+Mg3zfNmkyYD/OdVX93p94St8Gw0BLLf9n/oORpyGD8rLfvKOvAhRF3JKM9NaWR2jykk3/foCV8vEbVXhRHnctt0tq7EGmq1Zf2UER27gwOnLIxLJew7gsmwhicBAO5J0VEd1+t0ezwJkbvW8mVtZISQ05n2LN+QzosmOfNd4WsbodD9D+yeaysKJsqUTUCSi2FJQbBaQCEwsMxkWb38T/127hSsZ6oXaHvcAI5BiHftsJcjcgH+qf8HiRyXuWWnuhbAPQhKR+Qemz0qKlWaP+/oBZuBxH8xdNjeKsPTzIzAg6NkWclOji+Jndtq5JlEp1rWfwU/smff1J/v1Z9ImRY5WFKn1NgEvzmITmsSUO4eZMJi/fF3sZleck7Ro4kETiMkDNqQ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 12:26:54.2910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 769f6b30-58ee-4efc-b512-08df43dce634
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11223

On 11/2/26 05:19, Nicolin Chen wrote:
> RMR bypass STEs are installed during SMMUv3 probe for StreamIDs listed by
> IORT RMR nodes. A normal boot switches the driver to a fresh stream table
> whose initial STEs abort, so those RMR SIDs need bypass entries before it
> becomes live. This preserves firmware/guest-owned traffic, including vSMMU
> guest MSI cases built around RMR-described SIDs.
> 
> ARM_SMMU_OPT_KDUMP_ADOPT is the opposite case: the driver keeps SMMUEN set
> and adopts the crashed kernel's stream table, so RMR SIDs already have the
> only translation state known to be safe for active in-flight DMA. Replacing
> an adopted STE with bypass can turn translated DMA into physical DMA, then
> point it at the wrong memory.
> 
> arm_smmu_make_bypass_ste() also rewrites the STE in place after clearing it
> first. While the table is live, a concurrent hardware STE fetch can observe
> V=0 or mixed old/new state.
> 
> Leaving the adopted STE unmodified keeps the kdump kernel using the crashed
> kernel's translation. That gives the endpoint driver a chance to probe and
> quiesce the device.
> 
> If the old STE was already abort or invalid, installing bypass would create
> new DMA permission; leaving it alone is a safer failure mode. Later domain
> setup still gets the RMR direct mappings through the reserved-region path.
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Breno Leitao <leitao@kernel.org>
> Tested-by: Cristian Prundeanu <cpru@amazon.com>
> Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

FWIW, regardless of comments below:

Reviewed-by: John Garry <john.garry@arm.com>

> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 1c53c690a2b02..3696d11c852a8 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -5810,6 +5810,14 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
>   	struct list_head rmr_list;
>   	struct iommu_resv_region *e;
>   
> +	/*
> +	 * Kdump

mega nit: "kdump" could better better, as it is a keyword

> adoption keeps the crashed kernel's table live. Rewriting the
> +	 * adopted STE here could expose an in-flight fetch to a transient V=0
> +	 * entry, or change Cfg=translate to Cfg=bypass. Must skip here.
> +	 */
> +	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT)
> +		return;
> +
>   	INIT_LIST_HEAD(&rmr_list);
>   	iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);

Did you consider if we should sanitise the adopted ste against what 
iort_get_rmr_sids() returns? I suppose that would add even more complexity.

>   
> @@ -5826,10 +5834,7 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
>   				continue;
>   			}
>   
> -			/*
> -			 * STE table is not programmed to HW, see
> -			 * arm_smmu_initial_bypass_stes()
> -			 */
> +			/* The fresh stream table is not yet live. */
>   			arm_smmu_make_bypass_ste(smmu,
>   				arm_smmu_get_step_for_sid(smmu, rmr->sids[i]));
>   		}

