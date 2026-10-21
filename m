Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.65.26
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792600672;
	b=nZXeNDdHrGVW1/MdSgVf3t/MwLGomGSKBT65YqveagIEX/2LZia/UUhbv3Chl72pKANL
	 viuCef5jqzLvju/1+FBfoTMpaDgy+SBG48IWphFORED43uJmaftc3IyiVdN6vTRsfLe/E
	 lOKPIE2PU1sjTh2OU5SFn8bhBE3N0Jf0OLfXRdwOe9bbOZP+m0Xb7WvPmk4FY3oEvdsAK
	 8cxYS4I0GC14ULow7ZZOUzOhAO96vSSWUmNY38wj8Ax0nTDhMyFzXMlbe0C862aCEWSgX
	 nUbRamGfsgOWL+kHJWxQ1xFbd5OYmqBy/tTs9OG+mHfjUyyw+YvvHQ5eGia4H9Xz6MA==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600672;
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
	bh=gc63SiQq6v7msVH9OpGfgyWWLM7Q9jy+xJaGZnR6TLI=;
	b=cyrkhs6mWEE79E7xr7dNLu5K2lzP/NReaOFJ1ScTK/3+U3N7Dgjyk+twN1ZNwUkew17l
	 bcpacHd1EoI/dlELuL75IXD+2B7ShGwwf2Zd/GvRJOcYB1m4liT9Vu/xtt58N3S9bXmxK
	 k+HczB4GxLQ44pLKwegs531lZUTNuoAfJhcJlyp+6bL7WzlsCGw0GTlexaeWsVzQLJ55Q
	 LjFV1yJ6CRx33ikzsHGnfhoBNGqgcUM6FTZflHZntE4LwxW130quiQ6IH1squuhTkFr+U
	 VK4lghzf5PdjGQNkCgKS7XF+8R01OTVhxlxX51QFiJxJquJ9WGsL5MnATiVtG7kLPSQ==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NNYWRWMF;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NNYWRWMF;
	arc=fail smtp.remote-ip=52.101.65.26
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011026.outbound.protection.outlook.com [52.101.65.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAAA606A31B
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 16:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBAAA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NNYWRWMF;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NNYWRWMF
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UG9u/VmV0V6gSXzxtPPt/5UfHu4ZOvtPrdl7A71yel6gjiefFBNke3rzbyqoqEzwvSMbRycDvEwiXYofYAYJf+bTDXJS+xkCaQgwGFwJ23GGXHdMWBnd1ibPmkfPWO/5zMI+V8B6R0n2NpB8C4cOEzQyQHq9Agq7vCq2gHIEOnJqH7hsJ0svNErfbkyZL+GLCeO9+x5LRPiZnHqnW3UPhdMTctwTli/rLX3iZ1gqXSLxGMJ2IGwqM2QdBtKA6QTtAusWk31vaq3zRW/N/FgKjAsPkan2swDM55zQkSbg/14NM6wSgaDbVJTAMydc619LGLcVu+ZJOjbTTP3YzMd8Ug==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gc63SiQq6v7msVH9OpGfgyWWLM7Q9jy+xJaGZnR6TLI=;
 b=GCLyr0txxFF4diD1CnsvSAYofaFumWZq84515Dg/dlSsDKH/mPrztZaYtDT1zTfZHshMET2tISuckrvk5s19YyBcFWMXXot7P9LAEczRD2VJUU8cBv2BGylRfiYi+8i1MctTx5f8o0Ym6hilI7SArTt1kpzJKMPMpikWswO4fvQpbrBPKdaXieO3uNoEMtXQ/xDwfI/lveJ4460ZozsTNai49keWO4mf0rws9D6g58y4D2HOHDJ32+VkwrQyGHTknPznNmyGdCi1Bu+ezFsWpRMBfoCgDo+NKBWGDdsphv8oUala7OrdTfO4XBr5v8d32Yti36jjdCSxyvoAdcN5vg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc63SiQq6v7msVH9OpGfgyWWLM7Q9jy+xJaGZnR6TLI=;
 b=NNYWRWMFBwqoF27QcqIK0MmIrGFPdEKYVy3jQR1T4bRvzlq6pf/lMPrlSCCTea03niSf94wEj/kvRjI2ngd3mKjjwoz/hFfXnNTjlGmoPEwMMTu+THCDN6P0MHjl358gKrfdZwvWBX94cnPWh2nDTsEEBRABgoyGg5DrxXsgRfs=
Received: from DUZPR01CA0303.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::27) by AS8PR08MB9549.eurprd08.prod.outlook.com
 (2603:10a6:20b:61e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 16:37:43 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:4b7:cafe::18) by DUZPR01CA0303.outlook.office365.com
 (2603:10a6:10:4b7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 16:37:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 16:37:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1OEtsUzJVtfc20IDbEipyDIbjj8quUHxEPLjP8FR7Nf9P/qEaiYFRe5RMm7YfxwMD5oTUI6ljVlmkkqA4+Ie7Qi2Q+jJ/pDOihMG2sb6a6ec0MkVDZiHFhfogtGftTGZD6oP+sGtgJ2SNTTRFFe9isF9JS7dxpS/kHqBdQjvCjvZXq3L/JXjVzIcjUbqM3wXrVs9g0KXsighp+vaoyWigkhH4J+9R0F6cRO5nS/ATnxbuCDABim5f45LkSMxQhyu5aLKLHGNu+QBWdIoN20JLbJe/++UjlBtjaUeH7Lmy+vn22AC3XWaV5ttSmzwoevGlrF2gxywbFmelHpdxxL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gc63SiQq6v7msVH9OpGfgyWWLM7Q9jy+xJaGZnR6TLI=;
 b=USwML4Xe+gcLo7PFNW/4TowC+JtpsUAL4Eko7a0JYnGXRLZCKkHElbjUbr7fWxgiuomv/w3OihtOaEvfkKr7apHiL2f8m0o074eFfrINficoi+dVZ+zISCLdoNpxICKkcdX0pD3xtwApjZkGsZiR4ohkjnurUgGskCO63NNC3sOIYDAWQN+HOXZQ8XZ2quM57zKBliTNqIBN2WjuSjMb1tQte1swYbRg90PRPnZ24i0fkVzGTASidxj50ypS206NwEWiKxx4X/JHt/CLZtkv/6TpbTZW2Cs/PlH/h2FddIlAw+WH+aueHZ5NufY9fw/TGsv5QslP2UGf3AA2yK0IHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc63SiQq6v7msVH9OpGfgyWWLM7Q9jy+xJaGZnR6TLI=;
 b=NNYWRWMFBwqoF27QcqIK0MmIrGFPdEKYVy3jQR1T4bRvzlq6pf/lMPrlSCCTea03niSf94wEj/kvRjI2ngd3mKjjwoz/hFfXnNTjlGmoPEwMMTu+THCDN6P0MHjl358gKrfdZwvWBX94cnPWh2nDTsEEBRABgoyGg5DrxXsgRfs=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10691.eurprd08.prod.outlook.com
 (2603:10a6:150:162::11) by AS1PR08MB7498.eurprd08.prod.outlook.com
 (2603:10a6:20b:4dd::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 16:37:09 +0000
Received: from GV1PR08MB10691.eurprd08.prod.outlook.com
 ([fe80::dd4e:5d51:17f9:9375]) by GV1PR08MB10691.eurprd08.prod.outlook.com
 ([fe80::dd4e:5d51:17f9:9375%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 16:37:09 +0000
Message-ID: <9f500b81-792f-47b9-a8a9-1415ff11b699@arm.com>
Date: Wed, 21 Oct 2026 17:37:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/11] iommu/arm-smmu-v3: Add ARM_SMMU_OPT_KDUMP_ADOPT
 for kdump kernel
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com, praan@google.com,
 kevin.tian@intel.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <ee4257b62324aa75d7140f1f4a49aa0f78586fff.1791226953.git.nicolinc@nvidia.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <ee4257b62324aa75d7140f1f4a49aa0f78586fff.1791226953.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::11) To GV1PR08MB10691.eurprd08.prod.outlook.com
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
	GV1PR08MB10691:EE_|AS1PR08MB7498:EE_|DB1PEPF000509E9:EE_|AS8PR08MB9549:EE_
X-MS-Office365-Filtering-Correlation-Id: 223c0d2e-e09e-4af0-3882-08df2f91a11d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|4143699003|56012099006|5023799004|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 kp/QuKtmb6UkMpK1dqgbL7byACJiEhtA+ogDdi8ujqYknYy/EqNO3zTPhkdIlMoQdU1RMoireE4/CbTVV/xMhEzf/wvPBiD//nBGkE6LjDsjBpkSaSpqUiTfrc7TywuqqqIrAvHRYGbSkeTW0KiZXPmpYBkJ68qlH5TSP3gLyd55w9CiIfAVWPaC4XwS9ZGUJAHqFKoAgj7HTGR0qnJCd94odfhwDyWcUO9AipXPVvZKPZWUvBCaITxOMT4g4920B93eXmfaIdxe9AL7KrRTDLwX4xxgYmnsmA99mVu10Ptkd4IGBrotWVXiGywUWZZkDTTSHPlDERatYN9qMhRGVJMG65QZucDLS8Sfu2PyFTGAZOa8FGRg2THcuod1X0NP60i2soi2u92t4guAIqVTWcwY/qHaeI4rkCKQXZPM5KxVupiZ35qFQhDy80/BDl5YjaANNwssj6TRiHUY4LbzfsfZtHGzeZP85jWONXuDEJqUU5IW/tijKqKmCdDLpLrL70OQgpRnzj8RgYkNoK7bZGm1bsHZwetUzIdPkJp3upX5i/6Kwa1MciNAIjEL4iBoeTmu3osu+ZfsV9nlinw8va9mpWDfIWZJg4SjXwJ+BgAWl+9+RktLhu0E0IDkkloEpJ9g5/i+Php+2hqYT+sbM8EPbPnBtQZZgsWoV4+it+U=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10691.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(4143699003)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 vsMBkegRrUiuDyb13y1czRgeFoP4cdTi5a3Ww3XdSrWCY2WSZ/7JzDARaIta6LphCTfUkFQAm0oRy+oy3Ohi5m5mCRxOx51LOF762f77Rfb6Z27axysTUnN193cQ7CH7yCJOIgAk2BG7j+zm3NqW8Bd42pOnva5tYpFwafsFlj0z0Rrd8/v4vAmQHt1fqNTx0aXNVfCHsZ4AAqdX1xJqBjwq7cfzbO9Zshv9OLYa8+rS99TwlFSfTwOV2oRulx+t/HqCgrwyQ54j27RxhDox+HCUYbVqBLKlYjTkJCDc4fgz3PBUA9G1wTXkRmu+T5Vaf1fKc2pzglTUNBOtVbUyrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7498
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fb931e47-b7e6-47d6-8ce0-08df2f918cb6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|14060799003|36860700016|82310400026|1800799024|35042699022|376014|7416014|6133799003|18002099003|22082099003|10067099003|11063799006|5023799004|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	tbH4wb2u7dqhafnsjq8ib7OnxEXaToiXZ2LOhW5P/mlqtOI5zyPkmwA1o81aj1N/xnGQB2FWsADUHwIRPMTMEcvYYbgeT4UrEi8GSZPXIk6JRSXgsosSAs6LvOOt7Li/ggKjDeVE85aRb3eHT+RzGrEm2P3M0L7c0BW2KtyH1VqPPkt1Ui3VrLvXIfqBN4WiPyPORTa4+uZtI2QV3ZtxHbaMjHnZOQBamUeSYQy4lFlTFP+sTAgSOk6LY5uwgeVD1gVC5EENeKS72XR0NZnj2D1a5yohkgRjQZpzp3W6gEIUBrOf8TQnl/9ea5AsvdrXlGgnJhGz1J46MhFLVcmSLIgdP9YuujnAn6/13zn++slsaW7u5W8xkddSKtJfVrwjb0hHATlcIuXwB3mGuvfdugxtUX0l/LiU8uLZK+s+AclqGEOjZvQbaSxrncE88Jd2D9qw2ajvc4um9YZPRoLlzcg3piJ0mug4sza+YN3hp1yOfPnNGhTLYCvDs+uzPQ+1OX0cg5aaVlkbrZCxP4abDxedn5AbYm/iLYToRUwIxj18lflzidk7VjfIa2sRMTGDu7YzFc3BAttBsH1QUFSh4hZxrJuoTWvCJ0mw2SjjggY5jPqncLcUKrGYNkJwnLHik1++uDd0J9PK03Zy3OdXDJm16I0UBrKI69WRFPDk0CYeS+o5fC/neczeCMquYPy5Oimngr8/2univU79oZBaLA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(14060799003)(36860700016)(82310400026)(1800799024)(35042699022)(376014)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(5023799004)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q5sROVmwQMGRuKe1X44jojDLEWooaAEAZv7fW8kFqCNZB7g24p4ylZ3N1QU2cv6a6LP1B3cKE/knCMK5BZg4Vbho6hYHRCptzY3vfcd2enIopvPTmyO27ub0Xvn+YlYJzrV4SAykyWGlzKYijsN6FSTWHYfT226puuCzUVz+aqrvjMfby7ZcZOwUZ1OX0DZ+TX14+Gp16YGU2WSiO7BHhLORaC0ZauRmzWrRhSfZ9wBi1xSNxUUIls1IlKXItGO8hO1w6r5yXJE+yyvNdskRN1xGvh+mnNuZpQE+KQunZc1NdySv3nPzLtyWoOEoP+Wn/E7ZsZwLnpHI2BJKlnLT4p5BiyDrkFV881olmVTobsiZNFgygCFKeT0k7BR7U5LHCKw+V56SQRxapexH2qH/zJZZy2FbYyf20G2yHitNl3r7N2O6QFCG3QHOvg7pDOHA
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 16:37:42.8708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 223c0d2e-e09e-4af0-3882-08df2f91a11d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9549

On 10/5/26 20:30, Nicolin Chen wrote:
> +int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
> +{
> +	u32 cfg_reg = readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
> +	u64 base_reg = readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE);
> +	bool was_2lvl = smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB;
> +	phys_addr_t base = base_reg & STRTAB_BASE_ADDR_MASK;
> +	u32 fmt = FIELD_GET(STRTAB_BASE_CFG_FMT, cfg_reg);
> +	int ret;
> +
> +	dev_dbg(smmu->dev, "adopting crashed kernel's stream table\n");

nit: "attempting to adopt ..."

> +
> +	if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
> +		/*
> +		 * Both kernels run on the same hardware, so it's impossible for
> +		 * kdump kernel to see the support for linear stream table only.
> +		 */
> +		if (WARN_ON(!(smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)))
> +			ret = -EINVAL;
> +		else
> +			ret = arm_smmu_kdump_adopt_strtab_2lvl(smmu, cfg_reg,
> +							       base);
> +	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
> +		/*
> +		 * The kdump kernel need not match the crashed kernel. An older
> +		 * crashed kernel that predates two-level stream table support
> +		 * may have used a linear table on 2-level-capable hardware, so
> +		 * enforce the same format here to match the adopted table.
> +		 */
> +		ret = arm_smmu_kdump_adopt_strtab_linear(smmu, cfg_reg, base);
> +		if (!ret)
> +			smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
> +	} else {
> +		dev_err(smmu->dev, "invalid STRTAB format %u\n", fmt);
> +		ret = -EINVAL;
> +	}
> +
> +	if (ret) {
> +		arm_smmu_kdump_adopt_cleanup(smmu);

Why do arm_smmu_kdump_adopt_strtab_2lvl() and 
arm_smmu_kdump_adopt_strtab_linear() not clean up after themselves, 
which would be standard practice?

> +		goto err;
> +	}
> +
> +	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_kdump_adopt_cleanup,
> +				       smmu);
> +	/* devm_add_action_or_reset ran the cleanup upon failure */
> +	if (ret) {
> +		dev_warn(smmu->dev, "failed to set up cleanup action\n");

devm_add_action_or_reset() only fails for ENOMEM, so I don't see a point 
in printing this message.

> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	dev_warn(smmu->dev, "falling back to full reset\n");

nit: "falling back to full reset after adoption failed" or similar

 > +	/*> +	 * Undo the linear adoption's clearing of FEAT_2_LVL_STRTAB 
so that the
> +	 * full-reset fallback uses the hardware-supported format.
> +	 */
> +	if (was_2lvl)
> +		smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
> +	memset(&smmu->strtab_cfg, 0, sizeof(smmu->strtab_cfg));
> +	smmu->options &= ~ARM_SMMU_OPT_KDUMP_ADOPT;

Earlier the event queue feature flag was unset - should we still be 
going with that decision?

Did you consider to just re-probe the SMMU driver without trying this 
adoption method when problems occur?

> +	return ret;
> +}

