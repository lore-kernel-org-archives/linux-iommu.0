Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.65.39
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792666976;
	b=Ap7cn4tJg6tmuQaHADYzu9fox0N1r26BN1WtdCPWH1U5EWSSa+e5WZgCdANC11e56lrQ
	 pVD7Ic4elplGRakwE/PG6coRX680oOvi3eLF71IOyfNpVZ76h1ktKV5VymWn7w19Ppn0C
	 CrBxZI+guLP3fZvl6ToAwuTekmhnlzXIlMpzSeofWoGWshh4S4qyYUVFlf9zxh6p2Cw10
	 RoQKZD7EMC9/u9ixatLkd1I1Kd/Lsc1Kmpx5n7RsjnxkWbJi8f+X8NFUp2iJCsaGrYROt
	 UxkwPrVP4e7gdrcUieXCl/D403BNQpYrZ2JLdhhQsBp8sGZAoUlHFmzQxSX+T4n5upA==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666976;
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
	bh=uONqxSLeE+1AB9ZIW8bcopFgfihyxTAeIZ7I6LnfO0s=;
	b=ZMcvl4AAsalJzfR+AhH29JjSpwCvspORDlbiUk+Qm7gLY+wSPw4fj5b/rwZQGGorBiwn
	 PLbtiGrk5PGMHYBUX3yyRdtZ8yUPayAyrc+ZUYkgc17NJuKXsm1Zh9XBFVoSLAs6aTRK+
	 ijpmQ4Zl1ixdcoUkfd59mYQgEQr1imaj6sjy3gng9w+HmuFOgAV64Hg2rEJkb071q/mMl
	 LYrvVaxh0aApj+Qbqsx1Te0vyJMlPMOLkfdqjaiM9qBTy0yX3vaNXDVxoTIZA/hgJM9+X
	 KhJbWx6NppTp0YPOIJSE83dSA/k+QulrYbwpR2/4lBKDt3BFJlQGAqZzwNlQfnOzepg==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=r7UjtQvf;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=r7UjtQvf;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.65.39
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011039.outbound.protection.outlook.com [52.101.65.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5702606A31D
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 11:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5702606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=r7UjtQvf;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=r7UjtQvf
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xYlrDLVTLK3Lueaqfgi8lYzLuOGNsg/AShYct8FN0Rm91oUsTixD6dkSbAo3w5oMlYB2miXLQGIR6j+xmpNvfC5tCW1WjgcaHOGPnaTv92J6YVAsTyTY60t5vsvismQh050tMMC4iAU3tGfjtwRao/rTb+G8mL1g9vDqYyFQEtoxAG0UmZvzZ87bhudg/LkhLQNoUYVLJTFHCLm06MmatQOkmW25t3CrrsIM63Glnxpp33NbekaNC/eiieuI2kn8wXEwPhhxsK3LtAg9XTdkMuWfrygR5xd7/pr/564WQlujxe1RVmH4LDitPvrI0J42TqcmlOsS/od5QP6X2JLh/w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uONqxSLeE+1AB9ZIW8bcopFgfihyxTAeIZ7I6LnfO0s=;
 b=AfEqE45x/U4Hgpi5Dv2wjY3rC0uZtsXFlrdUzc+73Uvmpm32Tym7K60oba+53kuR59SBL3D2BNJICq4LGMcPh9XhEv9F43GdgKomYWGY3O9J9pbIjUD8Oxscrz0O8ZgBguWHVxiiiso3O4FPIDBcsbX4HOSdUI8Llor5VU/nRcopKWs464GcsZ6i+Jwojjn3bgbv8L4gTpyxKE9GqeW93LojMaKh8xDsvbRK6m0Eit4MiXcUB0ldlVTPE8O3TK351XBPMgV5f226R10ozQ93FtLV4BAivp7tt64+URfdZG7aaCWMPFjC1n5BBkHYiJryiHtRQneQ81cRzLU9zyRWUg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uONqxSLeE+1AB9ZIW8bcopFgfihyxTAeIZ7I6LnfO0s=;
 b=r7UjtQvfaGYFjF6DTnXkE7nPG6WDIbcmSGsQajT4xzE9we+AkxafzwJ+Fu+zqxSGUrjEXJPMtNdxyu4nKRGP3xlV7i5t/YuIIM5tY+HP6YHuz0xtSGbaOnsguPjWXLslGJcJ2kPjEVII8OwqczQPhh0u+FHu0eF2hGsTbMJJn68=
Received: from DU7P251CA0028.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::12)
 by AS8PR08MB10097.eurprd08.prod.outlook.com (2603:10a6:20b:63f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 11:02:51 +0000
Received: from MA3PEPF00000407.eurprd04.prod.outlook.com
 (2603:10a6:10:551:cafe::a9) by DU7P251CA0028.outlook.office365.com
 (2603:10a6:10:551::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 11:02:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MA3PEPF00000407.mail.protection.outlook.com (10.167.241.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Thu, 22 Oct 2026 11:02:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgOuWKceV8OKGeerV8oxwITSkKxESb1L36d+X04DrMKhsq9/SvhDEByI0Ia9AS19dG69nCxDFA/WcTIiUE+oZh9/4kCHHGKEvy7WBy7x/JC1lftb2F54hcmGuh4RiSqhlZLgGfahTZCQKjzbtofh+jZITirlcWo7YkvlRvZyqVmE2j0IS05Ns+u1g5Rl2Z44rVsIW5Tvy1bE41JUf6yJcDGbUlLZkykyYQ5lPZxFLf+jJhEwJbcYorJqiSLuHSwC78wP8N2vYmRQZNYU3vD3eM2wkKz0XbpyML0NuUdzne4D0k+eKw7NfZXMfLTDaFIcyfYqEm2RT3DicCH/7ZxvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uONqxSLeE+1AB9ZIW8bcopFgfihyxTAeIZ7I6LnfO0s=;
 b=F84PHveiHeDmDPMvPOutWoN9zu5bIAD4ZxvGD4pxrLavtoJtWdx4zHxWBsKdG/cnhnGWUeDxtGMkMBCR8bXAem1P+dRd8x5Y+uoMqTZLCbeDhb44GRCNuaeXQIMRw2oFd47T98YvH3ZGgfj/oofRq3fpUaM8yoqUbQjI0TVDr3YuLhBvD0kdL1vL9EhxfjMwGZm71m6gS71Jrj9ZNCZJQj+faiKOPiA+7yvPdbjgdCu/3HnuH/tXTUmZVSYTW1b9cJ85Bc1R+rfud69/C8AHg73manHM6kwR/PcI/z7cIDhCFlzDSKReYsYV0F8fEYXF0DuZNSLLYZiNW6K0kGGQsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uONqxSLeE+1AB9ZIW8bcopFgfihyxTAeIZ7I6LnfO0s=;
 b=r7UjtQvfaGYFjF6DTnXkE7nPG6WDIbcmSGsQajT4xzE9we+AkxafzwJ+Fu+zqxSGUrjEXJPMtNdxyu4nKRGP3xlV7i5t/YuIIM5tY+HP6YHuz0xtSGbaOnsguPjWXLslGJcJ2kPjEVII8OwqczQPhh0u+FHu0eF2hGsTbMJJn68=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10691.eurprd08.prod.outlook.com
 (2603:10a6:150:162::11) by GV2PR08MB7954.eurprd08.prod.outlook.com
 (2603:10a6:150:a8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 11:02:15 +0000
Received: from GV1PR08MB10691.eurprd08.prod.outlook.com
 ([fe80::dd4e:5d51:17f9:9375]) by GV1PR08MB10691.eurprd08.prod.outlook.com
 ([fe80::dd4e:5d51:17f9:9375%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 11:02:15 +0000
Message-ID: <a65c757a-04b0-43e2-bd2a-5c07ab4f61f8@arm.com>
Date: Thu, 22 Oct 2026 12:02:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/11] iommu/arm-smmu-v3-kexec: Implement
 is_attach_deferred()
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com, praan@google.com,
 kevin.tian@intel.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <a80c74a629ee31af4dead1e9c263cde81abd5c1f.1791226953.git.nicolinc@nvidia.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <a80c74a629ee31af4dead1e9c263cde81abd5c1f.1791226953.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0496.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::10) To GV1PR08MB10691.eurprd08.prod.outlook.com
 (2603:10a6:150:162::11)
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
	GV1PR08MB10691:EE_|GV2PR08MB7954:EE_|MA3PEPF00000407:EE_|AS8PR08MB10097:EE_
X-MS-Office365-Filtering-Correlation-Id: f686c424-c79d-48db-a68c-08df302c03ed
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|22082099003|18002099003|261021121427099003|261021135927099003|261009223027099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 sD8qX3rQiG0uTmaRl60Uv0ADbeYKL77lVKz1/9p/4se1rhw+YOsVX08VSSDpELFojEnAYM2WW8dCE8fwe0RMZqunaqX/sXmHyiUe/r9knqFqxoVISxfdA08+YHk2f2f2WyvwlHJ4VMdP4NhBwwQ1uOPJTQmSQjAgNArOqdrlyO1NkJ3qZwt/u7b8L+BAmDgkXUaIpB3UzocI/3J4J7Z++553F9lKvhAiCczkKVxBPoMuH9l45UjcJHKAnW8TqmQoqFuMFCyj61Z7Yi1R8WNtTbrQ7kKgSE8OfLAM+wL84lW8HO5gqB5a2LKtG7oKDM/nFwrxaMMXAm+HK1lZW2lAJkvKBGN2v1ZwSAvkEdFZoww80kVLDKceyHHY+4DIl9JR33aLWI2Q1ZovtbU39fGyHOKkPYc4KR/B2bni1GcUSvE49neSZRQ8q8EpjW6UdW4yp+KUxFtC2dM1BK/KMLh/+LEDWzhBHQpshKdl6wMpLJZWWQf84SJ3r6Dmv3QYf4/22byfKzwNzvsUxvJFE2QVjqS1SzZxkh+ZT5YkZnL30Cts1SnCdVmgkq0rsbLdM9IBWgO0NR39F1XMUfaOUEX78rffB41P4hi+qp5SfrVVJHeQA/UioZJh7h82LIVekS0CVWgFojrghgZz1YDFMuOpgtgqg8Opfrd9henmPnYo4LY=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10691.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(22082099003)(18002099003)(261021121427099003)(261021135927099003)(261009223027099003)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 GI62moBtJlGMcS4trDZmv+AThJBN3QF3zOfrXiuiSZjIVX30wI3YcqM0dLEwqRrNyAuJzoNTyBFxz5PTqNFc9+P4L/30F4/YCws4086yMepvZT4bwRiG+EXEcmEx/YwfBgvry/46MGcRhZf6/Daq2pv/AyV0rhuHrZhBdw3koMav4DruLhkxSmzKhCnPFRKz4L8Flnht/sJjCQymVrOKhTnpjJZ9dVPoiwa09p0wvmgJqFxE1DaAD4vzAFKEgfPQp0ss7Qy4y4gKP6DGv2o6sPhA0+VPTUy15SXLeLADnSbS4TBKp4BqSFCq0MhEKTKnMaet6xMBLPDqEeHWcXsO0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7954
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MA3PEPF00000407.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	bdee4171-d366-4a09-26df-08df302bee29
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|14060799003|36860700016|82310400026|35042699022|376014|6133799003|22082099003|18002099003|261021121427099003|261021135927099003|56012099006|261009223027099003|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	6fxUref94SKzCVdfKqz6rS5oUwcTB456Sh4BTZYSUFBkxPmNcyaWKVnTlxPUm2Q1fhLW6kkLh7q0Hu3q5Q0kscNEo8w79qXMuKGl1aigzuEcwhA+2qCpiIY5iwFHhQepTi0wtiv6DIjtV0d7iwDeJs7QAMjkDHVrpEuOWodPhwRGJBNzy+lo8VKk8WEuiAks+M7XGqSc91BgwqhNJbC27tXfsajre1rNEjVPidMc0LAHMDhh5NRQLZIYfzqeWO/NnhtRUJtUKVoRjxHg0U8O8+Y9ikNaAfYu2XnioJtL19qsZ02KKJZuO2tBRJxdwceGoNGAbmf/eQLmnA5qRpZJgm0liwyUQq27LXmj3PXgepmIFyGyy5u8xt0Itsf4KcUzsxxm0Mtzm3wcQUsV3Cdl1FxOOwAaqfXTZVfGvehzhfw4LQF6hYeUrH3K3dOuTdEAS9U5WQRxtkNiWUavSWLGIOBsTiv9b0C8lJfr/P1OuUl+1DyGUePhrS5AcMJPQHQ7E0r1Nep1aBu6kvz78CQ6pGeeZVxORXq9Y+Yyh51OnmhnJxNrzDC/BQ7gQhCNYhj8HUFH38JaVYO1LqzZlyD2BkGOcgyPGwwI4cdiNPL/vB0eaQ4MS0dekpAqCuVEKmme2EMMBV38Q63/ziO3+UuT1+Lq2qcXsGagUguLheHmOCRFJXkTlw4kYf/w+u6jaMFKUQ3fZ07RrF4uWFRoVerNvQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(14060799003)(36860700016)(82310400026)(35042699022)(376014)(6133799003)(22082099003)(18002099003)(261021121427099003)(261021135927099003)(56012099006)(261009223027099003)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ibEYh26OJu8/m6q+RUFxdpNMY1ZN7nL73mCStev1wsF7IQ1QHV+68vG16eP1R6UMbm/RicffAXQcc+0S+IcQ0EqXvX2Z0HFNvnaby2osiUXco1g01t/vThLwgmiVuh9GfXdEulQjHX0iUSucghfwxR9JRlrDLrhRnN56uq/asKj9SdDG2MKNm3rzMFgESopgsZeWY9EK1vxm8yLz+bbSydXwaiThw/s+WVGHRVX3nQcxLLNPwyO/+foPSXuSMyloV3vpAZcOfF/Oe+HL/6Jw1AqSU9hxeUfTvtnZRe+i7cmEQUn2HmArbx57WOKmrvmXfVeq/lX9LNAxqtQ54w45Ww/Ba5rWzD8qMFCJz/KakVauGVmjtp2F8nsxjbGGMV3KxMqT+xK5VphnMVb+9cZmhnx+A7uwLx1ZqpQh2UybqH+4p7ao5s4N1P/wG/24Lznc
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 11:02:51.0872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f686c424-c79d-48db-a68c-08df302c03ed
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MA3PEPF00000407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10097

On 10/5/26 20:30, Nicolin Chen wrote:
>   					    struct arm_smmu_strtab_l2 **l2table);
> +bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master);
>   #else /* CONFIG_CRASH_DUMP */
>   static inline int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
>   {
> @@ -1331,6 +1348,12 @@ arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
>   {
>   	return -EOPNOTSUPP;
>   }
> +
> +static inline bool
> +arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
> +{
> +	return false;
> +}
>   #endif /* CONFIG_CRASH_DUMP */

This is really a comment for 06/11, but I have already commented 
there... anyway, I am curious - why use CONFIG_CRASH_DUMP and not 
CONFIG_ARM_SMMU_V3_KEXEC? If your kconfig for ARM_SMMU_V3_KEXEC changes, 
then this would need to change, right?
