Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.84.26
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794390148;
	b=v92XrGkFrgpuRfQZkEo/2DgYEyTbd0zxYd7/nx59UUN3Wbzzn8ZXxQy+o9bWbbmW71H9
	 J9HgiNnjP5JObQRF8yZ/PcNogWsMgmMIgwNDGp+zPVw+lJG+sIw9kfaxzeQXekzeRjiaf
	 X5zppwJnhkXDjbWW4V5oYV0Q/WihCcLHc8AlxC5lbJcoEho8g08ZURM+nu3iARQT8hIVV
	 W0ssnGfYhLOjXHsblfUbZ/jZeh6dHwsH/T1EYg/AmXORcgaw0Vs/lkItGWgRH/dwZvOfA
	 V8eMFnSpirptbBYgjjALOImuOYH83L95xvnjEVnIhHLBc4IkFaf6zwgbch5F4g99b2Q==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390148;
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
	bh=6dxdPXn7nMZJlqgohx8yLRdNARn36Bsq/Ijbq+Vc15c=;
	b=DEFCTAQApBchIOixFsuvRA6kwuNw6sB8sC29+cAfnYwhYcQgvFbsla8WZsST0WN8JrHR
	 nyqw2/2h8tDEAf9wJWPQfCj/RXzZ3Q7z6oH1m1NOe0+5Jh03Q1ICauxhQVZX9DudHG4WR
	 3+IifApNxL5RCETV3BXPTOUAtCA+7abfZf9uJP7JJnSZOFxf6xg4ieQZ4B28lrKbpQvJ3
	 8k57Xu0IEum9hQ1TsFj8jgxU3tMGbc9697n8jSfO9MClL8tik7cb3SWllxlXB1wxTtGfV
	 AlhpaGgd/o5VUXzob1Syr3JwsL5PMkgtQHDT+3ixb5G4Zkui4t2yh1p/feSsn5ZCDSw==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=GHpHT9dt;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=GHpHT9dt;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.84.26
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738FB606A32A
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 09:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 738FB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=GHpHT9dt;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=GHpHT9dt
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xA+61g/7M2KCE35JFp1D4N1bc32mWIsi+S2hTPHeeYv8z/9+/zTL6UufFOP3e5VzdsQvaXTaLf+59rJPLQlQmNVA6OS9JC1rocjQe9CyZchB56KTLe+c8qvix7zCA9Bai85FX1gb1btMfOqBrNVOVljNBwUNiKk/y0zI6j4swEsWBnLrV6FeRjTmQuZMuJCzP1aUwKQUMEQ6blgkF7k9E+Y+LMIYRul2Bgd1PKWSGMaW6zNEVJy0dcrzfpun1wtC3jMLeKq0/ffrGAr+3JI7TNozRcvakEkMQGpC1craevgZ7IU8IzUoYMuY2c02evzHmm8BPBGpeKUlDWIPrzCEmQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dxdPXn7nMZJlqgohx8yLRdNARn36Bsq/Ijbq+Vc15c=;
 b=qHQ9+jQ7LQD6h+QVqAHjPcsTAXzWXKSzEPhgqKzcXgpy84htnxqM4BCLRvyRCtFej1x2389hoiCWDww1krP9ykW4R1PX9F13n55pwSRn29cFsHFEXDgU/7fEWJR7iIcEBcHdbpJGDvlkkVmoQ4JLRC/qsnUsZmhRjEOMvifCPAU1d+9O1aBOZojDgxTUylWddxrgfZd+4ZhiDKzOTeOLtftWTpxuJgpirFq8RUJIoMFELVb6AXASUzioBXy+/WYV6355pY6Fn6nMdvfWZTRO972ob+XodjeOu2venUqKB5bKZkOiE61mNMlLTvoOwxahEwk4klk4FiKo2QZGn8ylDA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=qti.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dxdPXn7nMZJlqgohx8yLRdNARn36Bsq/Ijbq+Vc15c=;
 b=GHpHT9dtKN4AOyQp0P/7MSzkRS/DxlkuOxomsVkVctWPoIcBstsJOHXq56FRMwoH+wqeUoqFf+MvvkZ4RELp2XnZUujlI/NQq3B0HNAZhF4R98DfNE2L9XxwYYWjtiaWTKoZqG/nWRXRoLNuSYRZ2MRV+8HjyW8eU5e04C/45mA=
Received: from PAZP264CA0082.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::14)
 by AS2PR08MB9869.eurprd08.prod.outlook.com (2603:10a6:20b:596::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 09:42:19 +0000
Received: from ZR1PEPF0000E461.eurprd04.prod.outlook.com
 (2603:10a6:102:1fa:cafe::51) by PAZP264CA0082.outlook.office365.com
 (2603:10a6:102:1fa::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 09:42:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E461.mail.protection.outlook.com (10.167.241.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:42:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8uDhfrP775QCdq9COW13aPsi5i10ygQJHfD9yvp4ByP+sbJE9QT5MFcL1EptQNAI7/hd3nGqxqyGnjWz+ZnOGT+0sgVEIdT3XTnOzK20osIhrpLhr7KxUN6pobUnvX6oc4SwVC+iDmwwFxK5lcyPoL6AUQ/AQCoo2uF90CitTPIWmIvEWEFU7t+TUgw4lfFzmMKzrR4PsOnvlYQSZFgUFdTSvxuGg2tBBG6dYmE0DnPMgdlxSbPct1UQH+QmNSkDD3L2mm9ij1OWzfXTAEejdtAtFK7VJPsKyUnckIinGwpBQa3fiqVB68742PV39Kr3q0caKSPCNytE1eJ0H9hXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dxdPXn7nMZJlqgohx8yLRdNARn36Bsq/Ijbq+Vc15c=;
 b=m7AEiQNhdKAIuE89Sa99nH26rLY9nNlqn+OVgxeQRFJLZPAWKm2r8kgAeW37ZPQaSj4EwOnE8YNPSyTmB5dvkdPFIV+jifcydWhMW8rjTIwfBQpfYZwY1IFu1WeQhQyOzPdAJyzv6qy+pYnrqaPo2LrxgBWx+EFfMZEwH0VqsD2bExAjL66WAYi8Qe9BdJtIcOfhlfxAaUraCgvdGxGMqPF1oxSoJ9OqfhkiEleQIdL3x/2vCpMRC4V4ThbH7JcJNPGzyvSUumgsijd+FIPc8nWFHpq3bSwPuLuxmWpOeISPNXMAVca3AJyPKaiIuOSMXJMCpV5Arw95fKYPQygXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dxdPXn7nMZJlqgohx8yLRdNARn36Bsq/Ijbq+Vc15c=;
 b=GHpHT9dtKN4AOyQp0P/7MSzkRS/DxlkuOxomsVkVctWPoIcBstsJOHXq56FRMwoH+wqeUoqFf+MvvkZ4RELp2XnZUujlI/NQq3B0HNAZhF4R98DfNE2L9XxwYYWjtiaWTKoZqG/nWRXRoLNuSYRZ2MRV+8HjyW8eU5e04C/45mA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com (2603:10a6:102:33f::15)
 by GV4PR08MB311247.eurprd08.prod.outlook.com (2603:10a6:150:406::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:41:41 +0000
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f]) by PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f%7]) with mapi id 15.21.0592.009; Wed, 11 Nov 2026
 09:41:41 +0000
Message-ID: <88e88f7f-62b8-4dcb-8fdc-c804c85fb56f@arm.com>
Date: Wed, 11 Nov 2026 09:41:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Set CMDQ_PROD_OWNED_FLAG to bit 29
To: Sukadev Bhattiprolu <sukadev@qti.qualcomm.com>, will@kernel.org,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <avPMed8A/VIZ9obI@hu-sukadev-lv.qualcomm.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <avPMed8A/VIZ9obI@hu-sukadev-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0002.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::8) To PAWPR08MB8959.eurprd08.prod.outlook.com
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
	PAWPR08MB8959:EE_|GV4PR08MB311247:EE_|ZR1PEPF0000E461:EE_|AS2PR08MB9869:EE_
X-MS-Office365-Filtering-Correlation-Id: fae66c39-7c04-4ca4-9cd9-08df3fd81390
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|261021121427099003|261026121527099003|261028144727099003|261026140227099003|261102123227099003|261009223027099003|261022105027099003|261021123027099003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 fbccw/lf0Xp68AYjtHdpeby3rTJw+nPkhu/1y+MQGvydyTGbx18L9HyIRhGCUCwcrhSRF8/pIj5TcACoB6mkpTytSGp6e732Rn5QPYtsO/w4pQSVuft6YXcKl0qGnnIW2S0s88Fje49QcWJn0A5u+myn2n8ALkjgJCr+RCWe5j+hh6ZbhGcwYiKuZkV1RF2PUMrBgEdslvAN7TSyq8Q1dtYj9Rb74dtFBPShq/RPrsFFT/WBZJq5SMh0nSGd4bPFmoNV5tvVBZYdu8HgGkl1E1UZI1uUpTpzHMv/bT+zbiAfGEoJ34rKxtkbn2VtsTvSOBqxeABKoLhegyx0+pDAVwJrR1YmX4YRCtD3Wk9ytM/A2GOCCwPs6wnGAAZtyfB7ggyqI6Op2P1VsVGa3GVbszdEGkf9uhkYrUm68ef4d7gkzI13jYc/lLAlPhCGmjI3+FVCfzZCIeqOiPGipHB31Oi4hw61qhNexDKgrTyvEcAgvgRH1wLWKjTzqXk4bqdylJ7MeOfnlAquE8orpMpuqJopbJACd+CaDLAZTb+z6JARHRFCWqC5LsFeJGzvaSSe9tbae/4GHQBlrajMD8LuRvAEuFr6xrJCUfIJnlrZhN2RW4Y4cVYMLOqJjIMzNnaN
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB8959.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261021121427099003)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(261009223027099003)(261022105027099003)(261021123027099003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 IYh4tGmSH9VS0ZIo7I0ANg2/7Y+QHQ2NdW3BSZI7DZ1arAuh9olqEWcMZTZQ7wGOcBpTSks2Ge//6EBdv7Pc2dpDBRJQsXvKiQq8y86fjgcGqIiWWcun73TOXwzRvY1N8zI3mSiiA5lNMsjIPwAB7bgIbUQGVNfEBkV+ZHOTME2F4S0teFkQv0s/yBttyf3N4hrfLL+dcnDEWue53J/vYc6cwSURzKRdDjVcliGatCSCq+ZssMrXsQwDKVMo0pzM9U0z35TazhzG4gM92+UcyRBi/txr4w0KenZZBzDWUYubLH3UtvbDENCjz6mqjX9jeZuX2zeA+Ax6ej43z6rGxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR08MB311247
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 ZR1PEPF0000E461.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8e6391b2-5166-4c87-4d2f-08df3fd7fd3d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|82310400026|376014|23010399003|1800799024|36860700016|18002099003|22082099003|13003099007|56012099006|11063799006|10067099003|261026140227099003|261021123027099003|261028144727099003|261022105027099003|261009223027099003|261102123227099003|261021121427099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	S3QPDuaBEf5nFy/P/JJsChrwXNL4IfxqGeAoEk6YMgupdun9BUqa6vUBGLDwn9ps42LgJOPPCv8T7hWjbe6EW7fxdLrdUqWrzFtvC85q0yOCQeSYKnbYsiqePIejxooilTrqXvNr6juD7pRQx6JWZShi6q4PEX0vedaetxssy7BLkXSN4ZwJG03tyNDbuaTI1WSwMtYLSlB5bopfKTfh6KvUioyGVoKqe6B0J2j9AMc2XyDoWZXgwIRdINa9l6Cb6dN1iONL4xDUCg7pq5jA55uAMJe7xGgj/n6pQ+z/fCo8iZ5/zbKWMJ2JfUQDmHtiATmH82ivUBMtwUNOQ4hww/sPiTmC3Z0GgGLmmJvdTMNq70JJuEs4GjE4oS71AiNXs3UZTWld7abhfBQBpUXwoaWzLfKWboFxUOn1XWbSy8jWKZAvSls27nVb4rHK2SH1Fg0ccT+SPtpSChnw+r0pSvHTpBxWefOMR7cFwZSWvCcxmrhCyur4ePa3o7suir9zqUKExc8ET9qmSs4pKGGxs3JMo76TD/2ZUGFulueoAQsQrxUsW6t0fnBhWwtzHL5cKRvqYH6Pbe+XqNcJjzQFz6xtZEmazpUbYaednHquGiqpGVfrz9+iOPc2vmdfrV22b6Jdo8LeAkDwTRS8NzlkLGfLOgzLsIdw6W3vwG5tnh0=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(18002099003)(22082099003)(13003099007)(56012099006)(11063799006)(10067099003)(261026140227099003)(261021123027099003)(261028144727099003)(261022105027099003)(261009223027099003)(261102123227099003)(261021121427099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bKFAAfgHSYOz4OmhbC+72NY2blABd434IanEbQ8zsk/Ed5cSOCf8bQj8MU+bXqSay9zaRI9tMfEJwdPqxmt7AESJb5ipG+Ry15YNNS9n5mHoRy4jVkpaSQ/S58e0xshX0C0rutAynv02uTseIOtKQhylelsY2eLoKWXUQe4qBAKzMUeeZMq2TLyxpB0ZczkTcAvY8ffIYANKq1cQcQccDFJGf01zYXOCUHLNVFAe1QnhXsSvzSgdIy5q+J4anjyqP8bwbLzZfyI0Ol5B1wVnHkOVIlVEsN45jJG3IwQ9geqc1YfW6gtsmOGNQZ3/Z58hNWBdrWc5r1HvBEtvOTZWuxHOC9somA1jWgQqThl5YjASYQSW4qK4MzPxR24Qv5xKaUz1WIZKzEgqwp2Q7NfdqNntAtGivjwOPtM89cvUJyOn0ZLm05GiJhozUiHds4L+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:42:18.1970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fae66c39-7c04-4ca4-9cd9-08df3fd81390
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9869

On 11/11/26 02:01, Sukadev Bhattiprolu wrote:
> From: Sukadev Bhattiprolu <sukadev@qti.qualcomm.com>
> Date: Mon, 9 Nov 2026 20:45:29 -0800
> Subject: [RFC PATCH] iommu/arm-smmu-v3: Set CMDQ_PROD_OWNED_FLAG to bit 29
> 
> CMDQ_PROD_OWNED_FLAG is currently set to bit 31 but with support for
> ECMDQs in ARM SMMU spec v3.3, bit 31 is used for SMMU_ECMDQ_PROD.EN.
> 
> Since CMDQ_PROD_OWNED_FLAG is only used by software, use bit 29 instead.

We only use bit31 for the software-maintained version of prod, and never 
write that (bit) to the reg. Furthermore, we only ever read that reg for 
the cmdq timeout and the value there is only used for diagnostic info. 
So do you see a problem in continuing to use this scheme for ECMDQ and 
DCMDQ support?

In previous patches posted to support ECMDQ, bit31 is just always 
written when updating the ECMDQ prod register.

> 
> Change-Id: Ia171b73ca7b012fc25a2a8f3d7e1dc71f4c2b528
> Signed-off-by: Sukadev Bhattiprolu <sukadev@qti.qualcomm.com>
> 
> ---
> - Would it be safe to change the OWNED_FLAG to one of the RES0 bits in
>    the SMMU_ECMDQ_PROD register (30:24)?

Since we now know what bit31 will be used for (and we think that it 
would work ok for for ECMDQ and DCMDQ support), it seems risky to change 
OWNER to a res bit.

> 
> - https://lore.kernel.org/all/20260908171712.356645-11-praan@google.com/
> proposes using bit 30 for CMDQ_PROD_STOP_FLAG.
> 
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index bb048e08d613..f79353582909 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -398,7 +398,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
>   #define CMDQ_ERR_CERROR_ABT_IDX		2
>   #define CMDQ_ERR_CERROR_ATC_INV_IDX	3
>   
> -#define CMDQ_PROD_OWNED_FLAG		Q_OVERFLOW_FLAG
> +#define CMDQ_PROD_OWNED_FLAG		(1U << 29)
>   
>   struct arm_smmu_cmd {
>   	u64 data[CMDQ_ENT_DWORDS];

