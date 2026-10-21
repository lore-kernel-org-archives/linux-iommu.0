Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.159.60
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792601648;
	b=ukMYut19qbU2o2o3o2Cbe2JkrLnbqHdwZa9F5JFSD5jd1Wyqx05D72uHYsQMrEh7+U6x
	 rhWE3HFPZPIND/2obobrGw3ayE19e/jUYBhjsJQefNq4sUxAWsEofgJ7m3pqFqWmG3e8E
	 cV06NrCU2eYYo7DQEmpUno8r9k2k+6wz4C5Xgw2vXNfpmMe3zKbsokV3mbbBOu1K0YBkv
	 xzivkAtcMlDTGtE20bIUNmWzHRP9e/Z9WUHHIl7ZdS256nmbng8JoSQ4QRxhetWy0dp+B
	 G4UC9ArmhiRvidVKM/NLQ/siyAZe4PmMwtwZoj9j6fp5C/pOgSYp1NzFqsns4u9bEoA==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601648;
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
	bh=15sw/LfPJw3MVZPYpKLBQcQ5dq7tSK0FVica+D2mdLk=;
	b=YvvuKXny+D2RkMjCvIAH2hKRyxkXlV5PIoxdafD7EXacjVuWflbxOsXzt8kH8bASWesa
	 b5Zy/UNqk+M4cVRLUsBc+w4X8Ebb2RSwDjcYRbu2wqVbXK2NZUwmi+ozgfpAQ8ZiqRBFK
	 JaFaC86BM0jq2/h333pUFc7qqDwHPJaJqXXfS69zM5OCurcY7jwZFJdIvTwTD7sROnivm
	 lCnxPQ1A3QJMedwJOKgbmuTOzhunQnT4ljATcBLg1lIFpwuoC7EwAEc8n7ECuUny2l/bt
	 d7NhinlTCSdERqp1Ob5Tu3FofTp/n3/2c1JrYylJ+APFFpwp6e8kd/P8y3Yffgr4Wjg==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dw4f1vGY;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dw4f1vGY;
	arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.159.60
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013060.outbound.protection.outlook.com [40.107.159.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2034606A320
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 16:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2034606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dw4f1vGY;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dw4f1vGY
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ft2aPjG+bqFfLXtCMs7jxxkt4Ow71ClX/6Kdf2cYv/wbAwl51B/qJGOP0cuf8GD03YV8ldpf5wxiHr1Am1lTxnP+W1P44iyb+b9v5wGNg/SvIhMNZGY3rZvoE5idCpdDcTEi1MWIIsOff6Wj0ZqmgtrufXwJ4VqcUscCvuCtSmoPiBjsfzGpYMdstH4OLrYTQRmUDb8anGQ+VQ3SIkIhS5dXJTYgHgNo19odbl273lit9yRpIPqX1cR/CgCmAnOXF57QekHSRrxdQM8tZn0pQPFgAUt88/aMCZ2eryDr27FiVqoLywG/zviKEucBBpyXXpLKs6t1AP2c3YbybGfheQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15sw/LfPJw3MVZPYpKLBQcQ5dq7tSK0FVica+D2mdLk=;
 b=TsGroxvWeA6VW1LqcU+y8JDFAh5sTVGhM/0MhjcNuSjPUNDVRR4eNeO0Vivc5GezOhf1Q23Gilb3jsKu/qjX/ABx1BkW2/NMMkraqF+YMBq9kgSvxkBd5rRrxKMh0DpTG3z1mJgKjIfTS7dgGAQjbyGMolO2OetVRyE4+PpFi96+FAvOlnlA6gLlIqkEn4F7eaJGMLEaj9TDawKUPKwOnnt5bdcy6EiZD+vmgag3r+f8+69kSsSMWghFrGxzkdLhkLgwhNDI3Ddb6df/ZpWVYAgdwDn2HxcVmVrLlnjycNFKbaDNRGPXCV9awqlV4DHZRNWCEBZXGHdhRn102xrNAA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15sw/LfPJw3MVZPYpKLBQcQ5dq7tSK0FVica+D2mdLk=;
 b=dw4f1vGYQu+/MSCJ079NEv5mxPYFnw7HXq5ZE7AImYJ2NBm5sAgfRsD0nTKuhEDBAttCYrK6RaAo/xk3Y4XRzBVe+z0Bvjj6r6/9cEHAzPsGy4uR3CjhvoVQ5hix4ywMUjFkyRD342ZQwOkXED5PcPOh2UBI7v1B3ttE8QbLo7Y=
Received: from PR1P264CA0192.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34d::17)
 by GV2PR08MB8073.eurprd08.prod.outlook.com (2603:10a6:150:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 16:54:00 +0000
Received: from ZR1PEPF0000E6B4.eurprd05.prod.outlook.com
 (2603:10a6:102:34d:cafe::6) by PR1P264CA0192.outlook.office365.com
 (2603:10a6:102:34d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 16:54:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6B4.mail.protection.outlook.com (10.167.241.91) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 16:54:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFAVyyYAY3FIRzOUb+qHZHdIYs421iVQ2RArVG631tag7xWmo7eOCnrOPZIlA765FQoWnpOgfE0B84hUTA8Yvaty+v9SbbT2oh6qYQicBFJ+dOoSZ16hBsqv7Kx4UimUU+b/rZtxRnd2pf3WJADnAyPj459XKV3PDs+lXxfEcLsldNrj3iFu7Hj7/0FFzXjr8iKwWmBdTcGtk0v4w3JKm3/1Xqv+12retICGFgJ2Q4goABE9QLIIpvkdClGbkcRh9r3trQhrdMJ0gltu8s9qU1LLapmQhva4gsUe/FuH8ADXKjn/O1p+7w0bSDQvCwsLg/Q41aOKMKrFGrIc8sFBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15sw/LfPJw3MVZPYpKLBQcQ5dq7tSK0FVica+D2mdLk=;
 b=aKvx4qgCNLOwCIkW9DmMlIkB5h3I5ebs9vPi0ncvc4QCDsx8trSdVPQT9XojnlBjhk4tBEfHYbs5CDLdRRtxd9w+FfFoNpF5IZSbVhl0FwD/RdhpOVJbUg7LBY2glYIZjzkd8JwaRCHGpUwtdwNIeiFT1PwWrMOhZqenDk2s4SqUj4t8J2Y/Ys0z2C7CfufvFUwhLeb7ZDANLIfL9LdDrMPcS22XRLvIuZgtr24fgn8X2rjgoty/b8mGJpFxVCLOuME7seajBftcIIdXzGn5/tr8abVbwkGhdxxeIyKqdnrBb4ddSf+lx2xlIaCmquN5KSpYVSlZ70oeq4Q7X+/bqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15sw/LfPJw3MVZPYpKLBQcQ5dq7tSK0FVica+D2mdLk=;
 b=dw4f1vGYQu+/MSCJ079NEv5mxPYFnw7HXq5ZE7AImYJ2NBm5sAgfRsD0nTKuhEDBAttCYrK6RaAo/xk3Y4XRzBVe+z0Bvjj6r6/9cEHAzPsGy4uR3CjhvoVQ5hix4ywMUjFkyRD342ZQwOkXED5PcPOh2UBI7v1B3ttE8QbLo7Y=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10691.eurprd08.prod.outlook.com
 (2603:10a6:150:162::11) by AS8PR08MB8157.eurprd08.prod.outlook.com
 (2603:10a6:20b:54e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 16:53:26 +0000
Received: from GV1PR08MB10691.eurprd08.prod.outlook.com
 ([fe80::dd4e:5d51:17f9:9375]) by GV1PR08MB10691.eurprd08.prod.outlook.com
 ([fe80::dd4e:5d51:17f9:9375%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 16:53:25 +0000
Message-ID: <4b627d0a-b802-4965-9079-44121436d4bc@arm.com>
Date: Wed, 21 Oct 2026 17:53:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/11] iommu/arm-smmu-v3: Retain CR0_SMMUEN during
 kdump device reset
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com, praan@google.com,
 kevin.tian@intel.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <e8f6f198da25cc6b00902cd61bda9e7228cb45ec.1791226953.git.nicolinc@nvidia.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <e8f6f198da25cc6b00902cd61bda9e7228cb45ec.1791226953.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P195CA0010.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::15) To GV1PR08MB10691.eurprd08.prod.outlook.com
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
	GV1PR08MB10691:EE_|AS8PR08MB8157:EE_|ZR1PEPF0000E6B4:EE_|GV2PR08MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: 92bd72f3-765d-4d6b-bbab-08df2f93e7b4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|6133799003|22082099003|261021121427099002;
X-Microsoft-Antispam-Message-Info-Original:
 S7hali6dOf6lM9N9dRYjzK+bkBnfTtjTOOChEmR/eEJ4CJVB3GoCBXTc1bsfW4d2GxyRD4kbV8+siYIPKOaXSmjXhDqJz+X/U+960AQY41Dy43jsAq0Kdnzxw+YzJOkiALKh7TXuFvtsiohg5XsRTxCspQUFShLthjOxIqD+93bK8TmYBdf2kKJHh+Dh5IhNWE8O/3IYbgcN6vA9dOIy18lDRq+mB0fqgjtGZYbSJty41S5vy4mEKjKBXmtoX5j+L/kZLf49P9oR4Sr/3K6sgObHEVdlIiquQfPYN4mjcKDtr8RUIBtT/7J6QUbDwFxAOjThDRzX/hc0en0PrF5ZAMzx90RLfyqjGdWinhOTr3ZR1vlJS/JN0BbOs0BY6xZZWgxkxAOyv6M/RuJUMS2FE8wgL0F97t8RfRk/Ja20NChCRqrMFAH5eTaCUs19uZWGBzMetW7FX4C6wWNd5duIfNTHFJYLA0ql4D+67roO28dZvD3DDJQ/6n0FvmgkZNgnwhJMuccS0GUptX6UXImRybaTTT4ra8Ka/iI2vkXBYqvvO9srbtasytHQh+3Ix24BFTeS/3lrUs+CbdzY6bBE9cc8W6K4pqE4NlL8yy38LSSSm/RXm8GgJl0zAZAeBAmXbFcieoApCpY8sAJKAVKYHUpbgA8UcdtXYZUlU6U17WU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10691.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(6133799003)(22082099003)(261021121427099002);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 d3n1ymcQ2BaLWQMom0NlXwIaaA7Y4z/5hqcaWwWCutN0fTCe2+HT8aT/guYQi/PZ8yp7l1buBIpv0QBGNDacwWKYe4ZaSn7XFIwnaoZyY9nfFiomn3ocHnkde9uOUXXdLtDjwJfd3eA4hG51pc+IFmtVWgH4ZxNKa6E2c2UxnE/4YcWck/c9u9rozFMT1+ww1waWi7uXM0Q93TSwB1Lqkc29UunZCjyFuw10VDnYcGJuEHpOMCL7rkLQWtJzlEDDVhz2V4Bppn1LZWJmneDCMmZkg/7A5SJQjfoWYP68Njja2l3bS4B7cMiXGu2i9JySb6CzjDRlw6e+BzFyokYlPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8157
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 ZR1PEPF0000E6B4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	20150143-914b-4a62-b711-08df2f93d2e9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|23010399003|7416014|376014|35042699022|82310400026|36860700016|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|261021121427099002;
X-Microsoft-Antispam-Message-Info:
	TiGADq9nuLUS5ENh8QWbrsGxZmTMhuFwgt4B7Jqgi/o9RHBpRDkQx9V6FZeraM4IOnITCTFOg81bnrqvOPZtveKmhylmpIaXaJQsYK7I10GgSZUGiatI0+d4BdcAwk/leqCwrengHz2nlqjq74BAbkeBlhIHIm+2/6FBG5NHopQq45KMSatzfj7eR5l6z7tonWrbWgSyHEVzMW7GQB2eOwBQ/MhR4cBt4WEgyn7qEBWejRMFXwpmuSnm46C8lvEOPB1wBTRo/uaCEwqMCH3nKaR2QYijR+JDphoCp/vEM79xCzOfGg1DZNYidnTBWoyFwgCBpb+DhxB6Z1+XiNb2mv1bTfqee0pOef2V5VA588bKVF03Qb9fDt6YvVTA0bgRvTy6AxvY4NxGzS+7xBg+c/rXkN5v6tmp8PbttqngZvfH3cV+Ttp538u4kdC0AqANiYvwMFZSMGQlWaKDdSjiTzd4/W0223chjuBpS0pMdkROEYpL9b6TH4ZMowhCMdVSkx2+VHog2XpSCnyXOf4RfRZvbuurd1TLnCc8uem5Wp0mazQMaHO0v04wMXXWJuo7w8ipQMKqfDoJcN1+T250WPXicZIbXWSrWzEmwV5zRKqjR5QD3uip0tv8JwfWPBzqvRJr3mRKEPWAjNAYR5qSPXhhzOHjbt94OUKJre9Ce4xVvL8WPKSyWbnyTrSbye74S3jDCp5CFxbFVxl4saJWhw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(23010399003)(7416014)(376014)(35042699022)(82310400026)(36860700016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(261021121427099002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ni8bt4jA3BztpYyTlmDchqP5fNcaNhHHWYPbHpJ39+8hTAwZGQe4EbRVfv6dY8UN/yNPe/X4f8Alfk12iOw5KvVGi7sBHazHXI8jVnvSrM+UK6LguC5BNjl5vTCFsUTVBEjBNx62XnGkebxNuNMlPWfMNTuZ+zusUSVm1+HiY6Q9qwzy2IJw3tU6W5QjTKFQ1Lsaz+wrfGmhbyPA2XApy4p3vc+5UNwhY0h8C3H0DKleQ83u/mpx4ux6FaiaaDAiJvKTmf7e+7dH5T3sWTtjFuHmt9Ik2OClgYBwgisT0061q55SEnMnD9lSiXox/N98NWEYQhi6j7nkZ+Iy52JW/BS7tq1E02DcaXWbxHSpwtFepHW5NUhEPWe6ENDlQvLFPVWvfhFhWDzeJ61y5iPS8LPwOZ+5mAWS+2it3XgWElPcablsfSuGuT0/ZiUDDt8S
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 16:54:00.2578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bd72f3-765d-4d6b-bbab-08df2f93e7b4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6B4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8073

On 10/5/26 20:30, Nicolin Chen wrote:
> +	/*
> +	 * In a kdump case (set when CR0_SMMUEN=1 and !GERROR_SFM_ERR), retain
> +	 * all the live CR0 fields, e.g. CR0_SMMUEN to avoid aborting in-flight
> +	 * DMA and CR0_ATSCHK to carry on the ATS-check policy, while clearing
> +	 * only the queue enable bits for this kernel to take over the queues.
> +	 *
> +	 * According to spec, updating STRTAB_BASE/CR1/CR2 when CR0_SMMUEN=1 is
> +	 * CONSTRAINED UNPREDICTABLE. So, skip those register updates and rely
> +	 * on the adopted stream table from the crashed kernel.
> +	 */
> +	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
> +		dev_info(smmu->dev,
> +			 "kdump: retaining SMMUEN for in-flight DMA\n");
> +		enables = reg & ~(CR0_CMDQEN | CR0_EVTQEN | CR0_PRIQEN);
> +		goto reset_queues;

nit: Is there some reason to separate the call to 
arm_smmu_write_reg_sync() under the ARM_SMMU_OPT_KDUMP_ADOPT check, below?

> +	}
> +
> +	/* Clear CR0 and sync (disables SMMU and queue processing) */
>   	if (reg & CR0_SMMUEN) {
>   		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
>   		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> @@ -5181,12 +5199,41 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>   	/* Stream table */
>   	arm_smmu_write_strtab(smmu);
>   
> +reset_queues:
> +	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
 > +		/*> +		 * Disable queues since arm_smmu_device_disable() was skipped.
> +		 * CR0 fields are independent per spec, so the queue enable bits
> +		 * can be cleared while retaining SMMUEN=1.
> +		 */
> +		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> +					      ARM_SMMU_CR0ACK);
> +		if (ret) {
> +			dev_err(smmu->dev, "failed to disable queues\n");
> +			return ret;
> +		}
> +	}

