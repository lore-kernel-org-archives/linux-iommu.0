Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.130.49
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794822436;
	b=fYiv8LJ/uplS3bU8YYDfVQDlNWErmub/pm4f5JY270nTxV7v5HUNg4FzrWrM6WShLo2c
	 tjrvxjrxW0dt3DWAE93Zmd6oL6/kaPJCOiU6LD6qZLl8epOPuZbZi2et91v/mEBmj84Nv
	 CELLTRDKX4N7cDPNm0vDz9OXXnpfN03qp6HCpqh6tQeA1GaF5BbL2vinOP6MJ8mdbof/k
	 Rag6mcNASZx2IcpRnK14vstx67ImbriVwq236Gfa7s0ZOk4j6cBsrLvFrywS5HrRmQNWC
	 junKxDWYinTDdgx4Mf0Qd/meRaBEHNP/KMyOlFV/l2Q9Xvm9ftL55ESUUvX1jfvmJIQ==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822436;
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
	bh=43tnXVGIZmmwym1bR0/GXb76Re9TuDuUi+Mxzw8F6Y4=;
	b=aWQ/3aBOOPTAJUgTctIl30G0fka2htoEzBcH+FZ8aBw5DGKeIax3APOSHtQaDGsp4NQu
	 WbGlm389eOsxtT3w05lkAeOCScgRAsSW3goNvdAUuBk9fEMh87+CD2sTeKtuJwaU6g+bH
	 3E2/HdnVT0S4zM/sj7N3AnHX0SUokrFRpNklqdglYuZvOQJS+DA4jKNfKoMMcfEx1Tcs1
	 XWqGWWGDBWdrj2vjgKms+lKhxdcqtKHv8+7lHgpJd62XX5N968a9xo3Nby6qliJumGw8Z
	 tO/rtCVvanGub4Z2Ayax8D/6njSGpa8eNadimDXRKuMiLZZfZsP480QV865Qqlmy6Mg==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FA6Ws8pe;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FA6Ws8pe;
	arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.130.49
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011049.outbound.protection.outlook.com [40.107.130.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41944606A323
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 09:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41944606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FA6Ws8pe;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FA6Ws8pe
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DdkcO6KrbZ0HqJnKZy4VuZpkT5ytBw95CBk7uo4Yk/oUQGSvXjqIwxt9/fmNhJ/SUb9DaLiF7LpulH0cnmjojsVd+/VarCzcy/glvwPiZyax0aqwwDeeQqR/simzjPVmNG8aMiloQa7UNvCn0cDie9bK4hx92YoF0jfEkQJNsmevqfh/wnnsEoz06fd7Qsb82RIJdBvb0Y1SinPmNdEq4YS8fOzdxlr9LBkXY3fEZ5iXjGyocZpnHoBdaOn0+VU6E5A33me95Ztn2DHykNoxA/k9Qcut2SBQmpygZOsgYbVv9FfHF7asVHk2n6N3RHlsiIYL9XAbBV24p8luC4ybYw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43tnXVGIZmmwym1bR0/GXb76Re9TuDuUi+Mxzw8F6Y4=;
 b=DvbtkD2XDnq+qejolnb+XpfYojz4yCNawOc/oYEyswrNaeSotOvEsowfjC+fplh0pd5ddbIsMIJDbmHZSqqKO+17WqvzgFjRoma/wRae6G2twL705USr1rdSUxMYn6jeLghhYO8z/fn7s132LOTj/PCXnG/2jG1UEUr/XJv8U/yA9fzrQiJ1jDH1HQGPlbX/dX5cwQjB0s44/LVQYoJGA7bl2/3n77icfts881w4BpduEOV09xk3eLU+4sMuyKsy2dwnQJDS6vV0RB0Wu35oBYSrz5tJD9pKq4Vo+/tcQ0O9x7IWeo//rFV4+aVb0sC1uf9DFaf+Ts79nRAH8AQtrw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43tnXVGIZmmwym1bR0/GXb76Re9TuDuUi+Mxzw8F6Y4=;
 b=FA6Ws8peMlFA/NmiY14Q6M/5eUYoevD/+u+IJp1grpkOH+4Neu+UXw7AHIjLrIoDM0/na9XAj6Z4rLKGmVIGvGsujQ+oZIUVCwt7RK6LTI1c+XFNdHCDygkt0Z4/X0YtDRaN40ssdaBjrlleGttgM8AjJjLha/ZtZBZjP7Bx5YY=
Received: from PAZP264CA0143.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f8::14)
 by DU0PR08MB8115.eurprd08.prod.outlook.com (2603:10a6:10:3eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 09:47:08 +0000
Received: from ZR1PEPF0000E45F.eurprd04.prod.outlook.com
 (2603:10a6:102:1f8:cafe::57) by PAZP264CA0143.outlook.office365.com
 (2603:10a6:102:1f8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 09:47:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E45F.mail.protection.outlook.com (10.167.241.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 16 Nov 2026 09:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sf6NXXNWX03mUgmxbnvS/J1Yj4nqk6YqWRjGueugmBYZOtl+GFMcFVdXW66sxRLoo37El95onI9H8ZL6WT60BNxpMlYK11R1sQlYUnaEz6vYtD+ZLal9UAb0sjNTMzrMJs/VsPJ6SWm6Je37nWYScJc8WyF0ip1vf8YIwiltnTFfBZLSi7Y1ctCxwyXhVV0UGZn14dLOezdCKUbsQ+FKksWsyzHEuUmYafrQ8ZS6+crP//kUSWFHr2cuo6ScauXL9H2ZLlo0pfi/WcdED0f4Y2Jo/0/lBkFpnEt48/kjn9j/SyCDNjC0ckLuOnmn6v7WB1eEIWeq4BHlkFz6CAKMJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43tnXVGIZmmwym1bR0/GXb76Re9TuDuUi+Mxzw8F6Y4=;
 b=lssqPaAnqjyVlGHNPFM+tBuRb0TpLqQ9jBFLiQVjsWFrX6h8PQVuEZBl5UCFhoo+OsQdHarsoTvoJHQyje5VArZ+Y/uvD93lyxE54X6yE5AVxqnshRteef97zezcOYsiz6Nb/BjfmWLDnmwiwb5Pd3mpDry8d9HwxY4NWSDOTbthpmm8HS8Ao3fMmN/hD/EDN7kNzUwxs/wBJQ1x8m2BIkbyiwdoszu9LdvioWLe7LUMGMM6chFXlPyHP3LfL5WtnKgRTP9C+KjtspfvgxzlAaQDf5RoEkGv9eMMXflBLSk7gINv92Q8MyxPG1fOxEqFt6G5ftx2ZQJvWyW8zo9wgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43tnXVGIZmmwym1bR0/GXb76Re9TuDuUi+Mxzw8F6Y4=;
 b=FA6Ws8peMlFA/NmiY14Q6M/5eUYoevD/+u+IJp1grpkOH+4Neu+UXw7AHIjLrIoDM0/na9XAj6Z4rLKGmVIGvGsujQ+oZIUVCwt7RK6LTI1c+XFNdHCDygkt0Z4/X0YtDRaN40ssdaBjrlleGttgM8AjJjLha/ZtZBZjP7Bx5YY=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com (2603:10a6:102:33f::15)
 by PR3PR08MB5674.eurprd08.prod.outlook.com (2603:10a6:102:81::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 09:46:33 +0000
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f]) by PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f%7]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 09:46:33 +0000
Message-ID: <9d39ed4c-f19d-4504-8c59-0e2336185a7c@arm.com>
Date: Mon, 16 Nov 2026 09:46:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 03/12] iommu/arm-smmu-v3: Make the ASID space per SMMU
 instance
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc: robin.murphy@arm.com, joro@8bytes.org, praan@google.com,
 kevin.tian@intel.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
 xueshuai@linux.alibaba.com
References: <cover.1793593923.git.nicolinc@nvidia.com>
 <9295479f55d247961b25d913b6f4de1d7a72e0ad.1793593923.git.nicolinc@nvidia.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <9295479f55d247961b25d913b6f4de1d7a72e0ad.1793593923.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0381.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::8) To PAWPR08MB8959.eurprd08.prod.outlook.com
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
	PAWPR08MB8959:EE_|PR3PR08MB5674:EE_|ZR1PEPF0000E45F:EE_|DU0PR08MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a6482e-3491-4151-91fb-08df43c6944c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|6133799003|261009223027099003|261009221227099003|4143699003|56012099006|5023799004|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original:
 QScRqYlO77oQ2/ryGkooDg7wpowTH7Rn9EfhFyjMDEh7p1MOulHZ1l3W/wbpjarQZO4gPWKS6Mp4MIF7YX3IvlyC0UTChKpLATKABozQuzhCNkdBtoRIGqZlxHKWEYteM4U8whn/Rq4SYO4vLvrfkMAX5tMC3dP6uQ1S+WIof79K7aBBESGS/5Di0vumcU/UdsmpxGP2kDOHVJHGWSLuoY/rpmWMnnxpyr8CDrHUrSzZUMe5girZLsXir5a2t8TJft4I/jrUoYqQI6ZWL9d8Nf2GGZqO2OjQu5GSXzYhJV8C0Fcd0ZpgTp+EO6uabhopT6J4m0uwEMuTi1+uTDM4Rbt0+qzs5si3feaB4ibwxvG62igjWZo++vHYQeXLpgvb9vKNXGtIercWYm3bZ4mNptYBy8KDfNjW3IXCjCjgdj/cNwqXlIJVJtJtJDnj4oexsl1EgoIOBb6xauVKIr4ySfkjdAxNptsvxb00gN3rh1ycMmRhCiUULbYcTlvEGW1Snyb7aJaf/sen57iXnvSW5d1wBgyDAG9KwbVdLWRjZxhRH5Jr+t0124OlAk/oCfJQEMZbF+bsNIJukveXW6dlLllj5OsLduXIlxczDg0Bv765eYjIT0P3x+fAU6kWCLOC
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB8959.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(261009221227099003)(4143699003)(56012099006)(5023799004)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261021135927099003)(10067099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 JfObE3/RwyrFsCc2mnDjpd83kl3JPcs4Bu7zxWoOA07wQo2qH/7QHfSApJ4NaYKo+h3D8s6TsiqNaXbRqxr6TLvEeCYKycDGTWrlDldW0YBr+9r06DYA4kotFBa5uxxa3ZspAWtXQymEjs8n3WBpul9P42+/89mGk88Y2e+bdXN4JkjJ8GItiGg4d2lhtf77oIvQCwNi3DkBPrlThLbzMqkoP2CenPlj8JuTgDPMZFwaTQ2oX5UgYYUUYClm6USoIoQ4WijVlDAr6ucxdlJi5EerjPLKfNWDAPKzNe1WOq5f1pyWc7Ee7ZKoZa4K0PRjXPD9TrvwO1SdkPmUY3ThiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5674
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 ZR1PEPF0000E45F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	616a4f39-d80e-4d74-1f4e-08df43c67f4f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|23010399003|35042699022|376014|14060799003|1800799024|22082099003|18002099003|6133799003|261009223027099003|261009221227099003|5023799004|11063799006|56012099006|261021135927099003|4143699003|261102123227099003|261026140227099003|261022105027099003|261028144727099003|261021121427099003|261022075727099003|261021123027099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	IOONdqGgsRLYV2CKfQnsIAHubAS2e/ZTx0wponPsgjoxFter09U8VReqaOKMuFvkLnEBi3S5+Y8JVuygsmXS8nOuHY0zOy61YYuavpBv5y71WMS5DSr0e0vIE0aZfzeY5WofccW8pdOmGYZ4edsD1qdRddS9lP5Io0d28M9I8S8XbxVXvZ3Jvf3R2qaNC/oK1TGSLKb/HdF81pdxwjbcc8aFQMXKyz8FEcdwCRYyJQ0F8wRGe4RVUhVnItKAD42otogL/suUteG1M/Fs4c/SYIVoQ6iM+fgkUC6ngpBkyiRm1yF5DQQS5kt0CIxH8LZIjac0DeZwd0lV04D5A699xDT7DI0ysRweI1QFgzis0eS5zv58gfud7vJL6tn8ii/8FTwzY9v3Cy1LqBsazR2kgJUdOW5e6T3FWnxvmW4152cqej/JTfmcUDEFaqvqPhgBgnIMhu2SSOApcwK0CN4mY3cP8X2dF2kKSf97nYTdMiJ2WVGcvj9UmOB0dVIEYhguWNvTeRrxPuRxph6RF2qjPKhRJU7SUxYQnmvFP/wTGPbzem9SlgeUdiUCeBxySsNkM7FFajaiMUYmSUNYWmAVWqZGtcSjQcpCZRuRSDA5vbmwpY0OJT7KUCVlsYRMUvQ1MddjXHyZtKbakhfsREu0Uw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(23010399003)(35042699022)(376014)(14060799003)(1800799024)(22082099003)(18002099003)(6133799003)(261009223027099003)(261009221227099003)(5023799004)(11063799006)(56012099006)(261021135927099003)(4143699003)(261102123227099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261022075727099003)(261021123027099003)(261026121527099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L0CqTbnJCRT3maPGYaNebIh3VgBXnid5NDvSj4qw13jMPF2DttrQcPbtxKcTP6j1GQj54RjbildKzy5rD6VwxGddNn5gFVxIiYaAowZpGnWg+5bjkZJqK8K+EfTfod1m6W0W0+8zObPJr3g8vhxPyamb+YBr0WtYDYK6TpcH8nCzxS4LdEyZ23dClb6dl4DuM+H1o39W4dGWkqFkcu45tHZt0f/Ru2ENm/a4P9P3a3PUQj2MFt4gaj14GKda5y8EYBBiigtpNvJqxYopAdXnAdcDkc6+42iN4TmefMnjNDZJQwchd0rhT538KPLg0lS3hgicrXeVVf7FeiamwImu7UN53HNtc+m6xD1IOKNj/4hkaAZ2DEBGCk7HzOByfcqtRig1SaTFibFLj2hhvHhWoOY7WkRfcHJmWImX/9ESiL1H3y/1hmXBjP5v9OYoUU0Z
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 09:47:07.6942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a6482e-3491-4151-91fb-08df43c6944c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E45F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8115

On 11/2/26 05:19, Nicolin Chen wrote:
> An ASID tags the TLB entries within one SMMU, so two instances can use the
> same ASID without ever aliasing each other. Yet the driver allocates them
> out of a single global xarray, which makes the instances share a space that
> the hardware keeps apart, and lets one instance exhaust the IDs of another.
> 
> That global space is a leftover from the BTM support that shared ASIDs with
> the CPU. Now ARM_SMMU_FEAT_BTM is never set, nothing looks a domain up by
> its ASID, and a domain is pinned to one SMMU at the attach.
> 
> Give each SMMU its own asid_map, mirroring the per-SMMU vmid_map, and clean
> it up with devres, 

maybe you could use a single devres for both vmid and asid cleanup, but 
I am not sure if it would be neater.

>so that both of the ID maps get the same lifetime as the
> SMMU device structure that holds them. An upcoming change will need this,
> to reserve the crashed kernel's in-use ASIDs in the new map during a kdump
> kernel's stream table adoption.
> 
> This also eases the BTM work that Jason's working on:
> https://lore.kernel.org/linux-iommu/20261004162219.GA4064@nvidia.com/
> 
> Note that arm_smmu_asid_lock stays global, as it serializes the STE and CD
> updates against any ASID change rather than guarding the map itself, which
> does its own locking. Giving each SMMU its own lock looks possible now, but
> that would touch every attach path and belongs to a separate change.

That seems a sensible change, as using a global lock for a non-global 
resource locking is not a normal practice.

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Tested-by: Breno Leitao <leitao@kernel.org>
> Tested-by: Cristian Prundeanu <cpru@amazon.com>
> Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Regardless of comments, FWIW:

Reviewed-by: John Garry <john.garry@arm.com>

> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h    |  2 +-
>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  6 +++---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c    | 18 +++++++++++++++---
>   3 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index bb048e08d613d..8f2c0b1cc4a8d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -1003,6 +1003,7 @@ struct arm_smmu_device {
>   #define ARM_SMMU_MAX_VMIDS		(1 << 16)
>   	unsigned int			vmid_bits;
>   	struct ida			vmid_map;
> +	struct xarray			asid_map;
>   
>   	unsigned int			ssid_bits;
>   	unsigned int			sid_bits;
> @@ -1180,7 +1181,6 @@ to_smmu_nested_domain(struct iommu_domain *dom)
>   	return container_of(dom, struct arm_smmu_nested_domain, domain);
>   }
>   
> -extern struct xarray arm_smmu_asid_xa;
>   extern struct mutex arm_smmu_asid_lock;
>   
>   struct arm_smmu_domain *arm_smmu_domain_alloc(void);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index faeec656da9e7..489531e0027bd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -311,7 +311,7 @@ static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
>   	 * reused, and if there is a race then it just suffers harmless
>   	 * unnecessary invalidation.
>   	 */
> -	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
> +	xa_erase(&smmu_domain->smmu->asid_map, smmu_domain->cd.asid);
>   
>   	/*
>   	 * Actual free is defered to the SRCU callback
> @@ -352,7 +352,7 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
>   	smmu_domain->stage = ARM_SMMU_DOMAIN_SVA;
>   	smmu_domain->smmu = smmu;
>   
> -	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
> +	ret = xa_alloc(&smmu->asid_map, &asid, smmu_domain,
>   		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
>   	if (ret)
>   		goto err_free;
> @@ -366,7 +366,7 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
>   	return &smmu_domain->domain;
>   
>   err_asid:
> -	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
> +	xa_erase(&smmu_domain->smmu->asid_map, smmu_domain->cd.asid);
>   err_free:
>   	arm_smmu_domain_free(smmu_domain);
>   	return ERR_PTR(ret);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 5cabbe5652dc6..cb45bd154c9e5 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -90,7 +90,6 @@ struct arm_smmu_option_prop {
>   	const char *prop;
>   };
>   
> -DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
>   DEFINE_MUTEX(arm_smmu_asid_lock);
>   

Ignoring what I wrote above, it may be worth adding a comment that this 
global lock now covers per-SMMU instance asid maps.

>   static struct arm_smmu_option_prop arm_smmu_options[] = {
> @@ -3015,7 +3014,7 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
>   	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>   		/* Prevent SVA from touching the CD while we're freeing it */
>   		mutex_lock(&arm_smmu_asid_lock);
> -		xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
> +		xa_erase(&smmu->asid_map, smmu_domain->cd.asid);
>   		mutex_unlock(&arm_smmu_asid_lock);
>   	} else {
>   		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
> @@ -3035,7 +3034,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
>   
>   	/* Prevent SVA from modifying the ASID until it is written to the CD */
>   	mutex_lock(&arm_smmu_asid_lock);
> -	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
> +	ret = xa_alloc(&smmu->asid_map, &asid, smmu_domain,
>   		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
>   	cd->asid	= (u16)asid;
>   	mutex_unlock(&arm_smmu_asid_lock);
> @@ -4741,6 +4740,13 @@ static void arm_smmu_destroy_vmid_map(void *data)
>   	ida_destroy(ida);
>   }
>   
> +static void arm_smmu_destroy_asid_map(void *data)
> +{
> +	struct xarray *xa = data;
> +
> +	xa_destroy(xa);
> +}
> +
>   static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>   {
>   	int ret;
> @@ -4848,6 +4854,12 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
>   	if (ret)
>   		return ret;
>   
> +	xa_init_flags(&smmu->asid_map, XA_FLAGS_ALLOC1);
> +	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_destroy_asid_map,
> +				       &smmu->asid_map);
> +	if (ret)
> +		return ret;
> +
>   	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
>   		ret = arm_smmu_init_strtab_2lvl(smmu);
>   	else

