Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.66.56
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794831625;
	b=UKoGdS2uEVBHrwX7zIfr0k/hSQ4ybOUZnlj0HB+pLzcis1OUrEeFdAdD+NrSNIppVF5T
	 Qj1NyOydFy6+sTHHv7t4OuEpZTmt6rBIl5x7rWwQ+S6nKMmtod01biakOYg9gVPaUGDKi
	 pyJCO8HN0jNehDcwzSwzv7ptFhSqYzyxYk6/wkcWp8tzk2S+OzJKb3mRhsRJXqQ4XcBuk
	 qJSAAyyOn0nvm+GXZtvOhjC5krJs018+IpawNHmLXfRhrp+z8BfUjvlCZHwSLJ+/UmBIb
	 hebwNYpq0E71H9s5QhYLYE6H8R3koN2f1D2PsKbBn6IHwDrE/uHKu/+jSeQlgCKevYw==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831625;
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
	bh=CtwGAOEJHOdLBLYPLu2UI6rLMOJWNbfWdKQEmMj9pUw=;
	b=HGSMGrte4ItZI36IZSWIHHBz/aBUKSOtrE3zGPUubi/qg1z1z5IqTYwk12i993UhlcPb
	 plUG4SYKJ0mt+UmblQ9w6zGrq99XT/6gXiFhOJocXWFOIPkrOpFxsVVk5rsZ/99HlFwM1
	 dO62IJQkXSQ0h7jeZxSi7guxgLdblb3K3g76wD6zJSxicnohcQWVRJzGOPYKnv6ZHFgsu
	 Rqh1WUcFk8EGHzGuaGk2g//5V6uNVFXqebvzhtmKl9lC2959qIiY5kOPTEBHqLVqK7a8L
	 kM7JT+U2T6z+kmCJZmxy4AcDhuQ0bHcDAIOESflCDsEX7aYWDR/Cw1tiIhyNu7URE7A==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=li2IM+wR;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=li2IM+wR;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.66.56
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C511606A32A
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 12:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C511606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=li2IM+wR;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=li2IM+wR
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cyPtIrVMxBcNX6r06PONWQDcS7Mew9DNTd4ldblMxBkvoatZ4UyEROjQwq0IXDC39TkiUM5sJAF1+FWtmcOb9d4kZ6J7/yESOQ7pV9yXP55a/Co5+sdDiTJlZtuBkXCAIBHz/dKj1RUxQmRlFpf996pD6PPPvOqiGEo8DlIad9ivMwiKaS+hurxUNJIkKjEh5ezY7opnqRiARMYzh2tlIm2A/CDACvgmtyaCWI3NzN8l5IkaagFy9KWr0t7A7X1Ej8XBlehCzPD4+GhU2S7X68YPfOO3dMiuePzW7YCmbg6nTRzwPo0RGw1EVVZrCbDkLf0kixBjy/p/KalxtAfblQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtwGAOEJHOdLBLYPLu2UI6rLMOJWNbfWdKQEmMj9pUw=;
 b=yXet4nUZ53LF/mrejURYREzypeJZIAASu/K2JBhNqTVHFQ4Y64uTBhY4H0fG3+mkgadDh+xQ+qr+x3iHDvDSyNpF7qUpb4etPquMAcrRtG1gNcW+/uSNHP8T/nd1TkBPJXvVSZxQNVg3ooxao3g+sLlJOKkGKtEqDf8tcKYkCqptdiTF+mcrjHtSz/9tHHsMwk1KrHEqCFUvCa6hltM/5zNehk9fvEmWy1GN1U0m4z9VyIm5eqcFx2MRJDdY/BkseO5N3oGEKT7T89mfNrfjQ/eveuNUsJzzuJx0cYqwGWzoG2/pKuyP5FnBJoJ7vZBYpYqw33PvdFpwpaZzIP/6lQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtwGAOEJHOdLBLYPLu2UI6rLMOJWNbfWdKQEmMj9pUw=;
 b=li2IM+wRUY03CbBi8eK1Bq9ejnkXigVaXuRI+fDKAzpuwPw98RItnmX0hyb6ik1BgP89vJt+prjehuXDKBQBxJ2lpsNU5gSTY2s3h7G1EqhlGpix8u00V9gnFNSCLH/wQFUaa9dAsteOcpvioR1bokKCpKf0hbk1UFNMIF1RKBE=
Received: from AS9PR06CA0145.eurprd06.prod.outlook.com (2603:10a6:20b:467::27)
 by PAVPR08MB9282.eurprd08.prod.outlook.com (2603:10a6:102:305::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 12:20:09 +0000
Received: from AMS0EPF00000567.eurprd02.prod.outlook.com
 (2603:10a6:20b:467:cafe::ab) by AS9PR06CA0145.outlook.office365.com
 (2603:10a6:20b:467::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 12:20:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000567.mail.protection.outlook.com (10.167.242.117) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Mon, 16 Nov 2026 12:20:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzMm6Bjf+H/5FpS92sYjzymMwO44nxPXOoEs9gU+Fu4Ud0iOLcHtjblwLVPyoHE3lykEeZEHyiNVEkO+PcFmoHHZ6YQp6eJY6i8kfoGo31ro5rL3LpUc7RHDIiFYenjnfdkXUYuiaySdZrBfJp7GL5cCsjRqoD9pxqclL9oOUHcyWOnyYlNgE4JxSsIccHWe1BPfjMNTB5dGPoimtQYumVSJDZPKXK4PV+XdYqQ0qFsijDz7GBmcy8RboNaLDwqgO+/9Er7aP1XCSk2QHz+gYokIXv6B7enuM+ZdMMqVuuZTj8XznFRCP1F6V5NtZQi5yPHUrcQFV8nfwNs547vW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtwGAOEJHOdLBLYPLu2UI6rLMOJWNbfWdKQEmMj9pUw=;
 b=nM/xTLZ0DDyW3j0NdXwlItfrWF+TNG3yJrCVctDQmezTe2V8G/izgQqRfdJEt8OzSGX0WTwv0WnEmjUR84ZRlJwtQPJ+MWUruPBoY9OfoBQVqtx2kQWI12vFF+1HixVb0ah4cDtVKaUyDBNAnL7c0yRVeYQZHU2/AxskaqajBqnxIblLQss32TZfvFF/TRdCq0nnSyYumC9QjQuHpV8OqPx+52Wzq9Qk2wcfwiUzVOwhYmHodT0ZD8YwostJBuqlAryi3ZzarLnZYWT97o1pQstse38zQZdj8ntmLDZr5DoNbpGSwFQNoiuLL/r6lIlNaBzfrJU7MBZBSRo+YANTVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtwGAOEJHOdLBLYPLu2UI6rLMOJWNbfWdKQEmMj9pUw=;
 b=li2IM+wRUY03CbBi8eK1Bq9ejnkXigVaXuRI+fDKAzpuwPw98RItnmX0hyb6ik1BgP89vJt+prjehuXDKBQBxJ2lpsNU5gSTY2s3h7G1EqhlGpix8u00V9gnFNSCLH/wQFUaa9dAsteOcpvioR1bokKCpKf0hbk1UFNMIF1RKBE=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com (2603:10a6:102:33f::15)
 by CPH1PF402BC9893.eurprd08.prod.outlook.com (2603:10a6:388::508) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 12:19:34 +0000
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f]) by PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f%7]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 12:19:34 +0000
Message-ID: <1ee06735-d651-411f-bcc9-783e9c016c84@arm.com>
Date: Mon, 16 Nov 2026 12:19:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 10/12] iommu/arm-smmu-v3: Retain CR0_SMMUEN during
 kdump device reset
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc: robin.murphy@arm.com, joro@8bytes.org, praan@google.com,
 kevin.tian@intel.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
 xueshuai@linux.alibaba.com
References: <cover.1793593923.git.nicolinc@nvidia.com>
 <f458ce5587ad991c85e65ee12e8f5b271e5f6745.1793593923.git.nicolinc@nvidia.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <f458ce5587ad991c85e65ee12e8f5b271e5f6745.1793593923.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::22) To PAWPR08MB8959.eurprd08.prod.outlook.com
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
	PAWPR08MB8959:EE_|CPH1PF402BC9893:EE_|AMS0EPF00000567:EE_|PAVPR08MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1215f1-b7c3-4ca9-890f-08df43dbf45c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|261028144727099003|261021123027099003|261021121427099003|261021135927099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261102123227099003|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 /FIjxPAkBSF/PdW9jfn0eyOsE2LDtVs4qAfAjC5tRlsTcx3Dsyvzb81meEg7hOo7ENw/+XAQmq27FVQMbLH6ovrkVaJeXRpFS3l1kGK9NRfB3Yko6dE6xlvJAqIL6poEyM5kWjIM36n/XkZ2QmeyAQStSUfMax34cBPCONsSP6NiCS5yDMtbJl833WnwKlhFNcd5wQI4KUl+KWoYl/VRSrxRaRfH9V2Msq8q1chHm5FncLsRrZVyv2ggADBE1ABowgjIAisR+zhnB5cwSFuMvtmjY1bMM0PNhnl4R8IgnzVs6sCc2+4PqZqIR+dJJAUWQ1jiW1DjPVsA42Fl4o13yuTp5uZBv3aDtqyU4Jl8wweN8EhYhZnI9EDlnOkzyq+FZRNSpoc4FhjAAYkGCba+GNKDwGrsnMcwndCtVmk2odTwNX0xap3tdzoRFhYK3fYnUELxXPY5VYDaOVSunFlOhi6BIol9hN2JamF5+6BNn8MNVsmAC+vazlsb6PbOypHlKZtjgsFA8Y5gddB4HInV8U0Z0IVsD+td0eascsyI8iuDAZOoHoScOr+dBmf0XpK2u+8NA98M0TJnfVwq707C87w4+TSBoYuFw+b4UPoyrs4++QDxOP/i4hnN4hYPLbPczfBUDLWMk8+g8iZIWMppxWVL3x+Mtq2gDQE3PJ+Dl5I=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB8959.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(261028144727099003)(261021123027099003)(261021121427099003)(261021135927099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261102123227099003)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 PmepRdGXtmKadd/PtnroK6gF/z2gjrxOHW9wZhU+GzkLziGlwkRBa8mghNgkmAgdmW/nFxAaHkhix8Cc5IEXDwYWsE38sWpXAnao/8lzo/HARvd3zeuPNJlxjnSFJbFRbVZzDzRTqmRJk6AZiJZaQjylyMShZAFkI3E0WP9OFQwrnkPEQlcQmlIz40T+UnyRJe+jf1e3Hh/FoUeOlBjiEVJRKWDyIBFGPYRaf+0iHSs27iTNZ8v/s2TM31jADxgNBJu9Q29CIrPgK4dU7IeWQp32zacNJXO4Uq+4PhHzC5kObJz2NQCHCmrwKBaVq7vOaagZpS5RyN7OZk5lpLEL9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPH1PF402BC9893
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000567.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	62fbaf4f-04e9-4265-9010-08df43dbdfa8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|35042699022|14060799003|1800799024|82310400026|36860700016|10067099003|4143699003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261021135927099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1oWmZSIUFFkMjS1oLKXAqvNTvmaAwCKFBQSUVA5je8kHbMvONW6uTsJY9SXRVxQVQfEod1QSm1D+V1h2gn9v1qKTyszwFRbTMfMXZttdZEWnLqW0+OsuCPWtwjsjyyYaAmvGdF2/eeACS8pjJElp4zqpdblO+DrFY33iyThy2QLwb6D76hRDzPt2Qc7zU8EWENmg3Io+nlsYokri1/0M8bPV39/Lf0rRNtPAjK3YFe9dW5XtNZozH9TU68S1+9Y2sWEBduLo28Dfp7kE5DKIfYnDW9952L0zYpv12CPg+SyI5i92Wj3KPXk9Po9aehmKaex9+4NbsQe6a+B9NTI3G5IsSoVgGo/GuqqKFHvNuH/wUCFFy5rtc4HsUkq0850cr88tYKavIj2flONJWeVPTjSGRvPEj82Hb2dB1EEaPGqVmT+jsijsVCnfgiAcuF30cwdK+UWVWpGNzJVpLbII0jgA4iVVL8k9ZT34/hXGV4nyqMWaYLzeBBlQKezZqwRZFVIesAoBQcBIBfWqDiefZ4W4lHeFzvG33fN58QZbtq8MfN9/vP2UN+9QbY5F9fy/WKsqoD89CsECSo47YoFrvIkZvZLSezK/AinL8C85crnX4WB9IC/aNXUjvCMlPgVkckH8p1uiCoWoXLRXG2Yry86nvGfq1zzT5utQxSaYQU938ego6adXppSLJojSWROoVewUG8yYhjPCw15XwOSsbQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(35042699022)(14060799003)(1800799024)(82310400026)(36860700016)(10067099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Vz61M07g7Eq1Xg4gCYjcG/6TQN1zvEMWOEGQGnZCKFjLxMP353KbgLvhpt2scynAGgDfe1D+QINw9X8RGf75GLsvyM3/K0EYTVRZMflaV3lxxB8AZlorCLsOpFwtvyzjHrJ3T4TFRVfTG8+exyypxkTLyN+Bip1OPdN7IEZnG5QwAhtrNaqdFM7iw9X02i+RYxFXTN+qxoAGzupY8FaSJwXEZ+eQ/e4zh0XMVO0gomX3+dkIZbLHwM9qiwuz1AgKLUbVTonISCGuowdYG6sFfmC1WOxBJmBokH6rIpbcgMXKgPFUx7jjgsByShmPWqA2cGxRMdXKtjAfLH2EUPxK8Eugq9UU3sWuMvgYG3v1sIifT7w4Q2jbFDopsMeIq1G2IGR7kgHgyr5lA/B44rEA1h71G64fJw/qWWwOGndOf9aa7Oe3QHx+eet8rZeND9n6
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 12:20:08.5473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1215f1-b7c3-4ca9-890f-08df43dbf45c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000567.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9282

On 11/2/26 05:19, Nicolin Chen wrote:
> When ARM_SMMU_OPT_KDUMP_ADOPT is detected, do not disable SMMUEN and skip
> the CR1/CR2/STRTAB_BASE update sequence in arm_smmu_device_reset(). Those
> register writes are all CONSTRAINED UNPREDICTABLE while CR0_SMMUEN==1, so
> leaving them intact lets in-flight DMAs continue to be translated by the
> adopted stream table.
> 
> Initialize 'enables' to 0, so it can carry the retained CR0 fields in the
> kdump case, clearing only the queue enable bits. Then, preserve them when
> enabling the command queue.
> 
> The retained CR0 keeps the crashed kernel's ATSCHK too, which selects the
> fast (0) or the safe (1) mode for the ATS translated traffic. Switching to
> the safe mode would start checking the in-flight traffic against STE.EATS
> fields that the crashed kernel never set up for a check, aborting the very
> DMAs being carried.
> 
> Clear latched gerror bits if necessary.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Tested-by: Breno Leitao <leitao@kernel.org>
> Tested-by: Cristian Prundeanu <cpru@amazon.com>
> Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Looks ok regardless of small comments below, so FWIW:

Reviewed-by: John Garry <john.garry@arm.com>

> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 57 +++++++++++++++++++--
>   1 file changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d45ce33334ce2..1c53c690a2b02 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -5145,10 +5145,39 @@ static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
>   static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>   {
>   	int ret;
> -	u32 reg, enables;
> +	u32 reg, enables = 0;
>   
> -	/* Clear CR0 and sync (disables SMMU and queue processing) */
>   	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
> +
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
> +		/*
> +		 * Disable queues since arm_smmu_device_disable() is skipped.
> +		 * CR0 fields are independent per spec, so the queue enable bits
> +		 * can be cleared while retaining SMMUEN=1.
> +		 */
> +		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> +					      ARM_SMMU_CR0ACK);
> +		if (ret) {
> +			dev_err(smmu->dev, "failed to disable queues\n");

"kdump: failed to disable queues\n"?

And it would be nice to say or hint what happens next.

> +			return ret;
> +		}
> +		goto reset_queues;

nit: goto could be avoided, but that is a taste thing

> +	}
> +
> +	/* Clear CR0 and sync (disables SMMU and queue processing) */
>   	if (reg & CR0_SMMUEN) {
>   		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
>   		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> @@ -5178,12 +5207,27 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>   	/* Stream table */
>   	arm_smmu_write_strtab(smmu);
>   
> +reset_queues:
> +	/*
> +	 * GERROR bits are latched. Read after queue disabling so that unhandled
> +	 * errors would be visible. Ack everything prior to re-enabling the CMDQ
> +	 * as a stale CMDQ_ERR would halt the CMDQ and new command will timeout.
> +	 * Acking SFM_ERR is defined too, although it would not exit the SFM.
> +	 */
> +	if (is_kdump_kernel()) {
> +		u32 gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
> +		u32 gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
> +
> +		if ((gerror ^ gerrorn) & GERROR_ERR_MASK)
> +			writel(gerror, smmu->base + ARM_SMMU_GERRORN);
> +	}
> +
>   	/* Command queue */
>   	writeq_relaxed(smmu->cmdq.q.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
>   	writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
>   	writel_relaxed(smmu->cmdq.q.llq.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
>   
> -	enables = CR0_CMDQEN;
> +	enables |= CR0_CMDQEN;
>   	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
>   				      ARM_SMMU_CR0ACK);
>   	if (ret) {
> @@ -5239,7 +5283,12 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>   		}
>   	}
>   
> -	if (smmu->features & ARM_SMMU_FEAT_ATS) {
> +	/*
> +	 * In a kdump adopt case, retain the crashed kernel's ATS-check policy
> +	 * captured above rather than forcing it on.
> +	 */
> +	if (!(smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) &&
> +	    (smmu->features & ARM_SMMU_FEAT_ATS)) {
>   		enables |= CR0_ATSCHK;
>   		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
>   					      ARM_SMMU_CR0ACK);

