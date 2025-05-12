Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211BB1C173C
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070285; cv=fail; b=fZGmC4NSBXDuZtKyDBs/yqcfcF18fMXWQV4QldZIXkcs4WKDez0b781vVGwGpw62xzrbvBM4ZIf8F2yMmoq4PNOxART9shfV9oMOBv/rwcAwfqOJptHSk7mo7dJEhdahywSmNvizzwaXsqe153W0G+tZLqCB3jmGJFC9UtBX+9A=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070285; c=relaxed/simple;
	bh=szZeraAda7Qxi5Wrm03HY/J4K43Zb2/JF1mq5GY2ySM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FAibo6DFvMU7jXcL3XBj3ggT+TCAI+gtnJUkEYOMOlzH+eQOBfLMUyJ66mkDWUJXIYVvef5mE728MQZv26nScCEnjks4qEMfzqV96iVlPSVIrfgm9pRjcdtO5sB+4gzhSpoWUk11RWYet54Tc+pz5kGePb2L18u11rJM4qirJCk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Zt08P58/; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Zt08P58/; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Zt08P58/";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Zt08P58/"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lFn+al9RcyjPKQuD1iqmrmnGEXh5OrBJ5jYZyYVnWl6hxBdXLiRSNCxeun+wzVmHpcuBwGER1EQ+iIBICFiUWAQoCDKcdu5cAwzt0xXBfm8AAjNfYDS8wt3gzFHT+nyS+pbTcNURAeV1vXuRw+oINa9amgJKimc9jY/E0VXZ8VJImqk1PIeMdj3zxMMDfnsSsYp4k9m/0YID8JBD1rsibMQekHQCyGB/nlQBqu+y7KnLI7P26ahlnm14VujaT0Zh3BbIcTnEQtVLCR25DzZ1hLdJLBUFN8R/FzyzF5DUag8qR/V0zzbOSEcKWc1wdKc3C8sgUpFDNKwdA4dQYTGroQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg1X550YHjiGu6q/4xMkGtZzY3shpcKKRywXS71KM7M=;
 b=niUujZxBOqApt3QD0YGO7MFqn8NvMWp1WXxBP1iN56VHUVjpwGC8G8esZpNMdpsrZQBBBm+1oH8NSKGG23mGQq0Uhp3P8SuWcPPx6B3exc83cdscX/JfZO0lg7X85KN2y/d12VYRgZubAI3EvmKqvCImilWkvZ9qBcD6WXgcuX9+A36fMPmGODL254FJ2r7VNmekJvdMzQkRA+RoUk3kQlNcPQixdpc8FPHz0dCgWkahN6+X3WNIhXHjcv4zcdlpBae0Uoi8pBeKjGbmPaJXUQ+ZlNE1a1T57yVYlyq7enU9Dwj1uF1E2Sx5NERFbmH0yTGz9Cb4UO5njs6nAIefNQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg1X550YHjiGu6q/4xMkGtZzY3shpcKKRywXS71KM7M=;
 b=Zt08P58/LEMnQMrOTGuO5YLewvIquIJJcNyc2S/igtp+KRXiMdjvugmUACB9cuFlky8RhREV8kduKCYe+BFznPDAOd0qWwy6RvBOhWnhrAnRzOOHX0X++etsYvqM067u8l7cSJA4eAHQ80LQ3FsG14Ep0tHxCrq16IPgvKISaKU=
Received: from DU2PR04CA0041.eurprd04.prod.outlook.com (2603:10a6:10:234::16)
 by PAWPR08MB10166.eurprd08.prod.outlook.com (2603:10a6:102:368::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 17:17:57 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:234:cafe::82) by DU2PR04CA0041.outlook.office365.com
 (2603:10a6:10:234::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Mon,
 12 May 2025 17:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Mon, 12 May 2025 17:17:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8+7sahmcHvNoez0uZ63oN2KHI/JRsDv98WTNCLR9gXeTBpZEcmyDBjR3SbaluSnw17hZ8gh28rNl8zEa5IbRT9fe3dbOQpwayS/MprojbIXRPjYGzBYa9DeknRORbfpTAazHa6DurJXUurgb7w6jJ3pHRf80m0c2qxgfpktG/RYXH0R8GlINhW6as/pLw12sD4lm5H3QAUTW0vn3qnWKcAo48R6mwxmLjSwGy46CP/nhXu2r4ImzKZ4GPgj3guoCD1mEK8Yjfa1EVmu4JxGoJUjvzqzJp5Bpv8z96ti0GLmNHE1dqgLJHbDdnFn0zO8Gj8kOD1p5owd4nOZDy/uNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg1X550YHjiGu6q/4xMkGtZzY3shpcKKRywXS71KM7M=;
 b=M74J5wmiwiFGDb5FGBzROgzuKjibZQ2DmGFRxpv/foeF06tkNdhwoxs8yxlLrbfBdHrxcxfccrTzXc+doZz4E2XyZd9wVK2FhA/F9zNPXy6ezXnR0Uq1UGm2iF0RFAq/O2uXP+Asw5rpCApkqg4BykgGlZat5Ku8+qHNlOGJR9A//whBqnds+EdYooPR/NoO7q2jzC7bwYPLPEOOf2Db5QWpAfm+cl1cNdyL/6IIY1wO0NLSOAkCYf4SbrlHwbzFPC11l+BqLgilK4kCTKP4a24XJtgPeM/U1tezWTH6Ur1BuDjiPLLV8gVVo+z2fZWu9dXFBxInmMTkLrC1o8ylWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg1X550YHjiGu6q/4xMkGtZzY3shpcKKRywXS71KM7M=;
 b=Zt08P58/LEMnQMrOTGuO5YLewvIquIJJcNyc2S/igtp+KRXiMdjvugmUACB9cuFlky8RhREV8kduKCYe+BFznPDAOd0qWwy6RvBOhWnhrAnRzOOHX0X++etsYvqM067u8l7cSJA4eAHQ80LQ3FsG14Ep0tHxCrq16IPgvKISaKU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB7727.eurprd08.prod.outlook.com (2603:10a6:150:6b::6)
 by PAXPR08MB7320.eurprd08.prod.outlook.com (2603:10a6:102:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 17:17:22 +0000
Received: from GVXPR08MB7727.eurprd08.prod.outlook.com
 ([fe80::9672:63f7:61b8:5469]) by GVXPR08MB7727.eurprd08.prod.outlook.com
 ([fe80::9672:63f7:61b8:5469%5]) with mapi id 15.20.8722.021; Mon, 12 May 2025
 17:17:21 +0000
Message-ID: <83d1f7af-3dc7-45f9-94f3-8a0917c051d2@arm.com>
Date: Mon, 12 May 2025 18:17:18 +0100
User-Agent: Mozilla Thunderbird
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [RESEND PATCH v6 1/3] arm64: Add BBM Level 2 cpu feature
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 yang@os.amperecomputing.com, corbet@lwn.net, jean-philippe@linaro.org,
 robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
 paulmck@kernel.org, mark.rutland@arm.com, joey.gouly@arm.com,
 maz@kernel.org, james.morse@arm.com, broonie@kernel.org,
 oliver.upton@linux.dev, baohua@kernel.org, david@redhat.com,
 ioworker0@gmail.com, jgg@ziepe.ca, nicolinc@nvidia.com, mshavit@google.com,
 jsnitsel@redhat.com, smostafa@google.com, kevin.tian@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20250428153514.55772-2-miko.lenczewski@arm.com>
 <20250428153514.55772-4-miko.lenczewski@arm.com>
 <20250506142508.GB1197@willie-the-truck>
 <78fec33d-fe66-4352-be11-900f456c9af3@arm.com>
 <20250509134904.GA5707@willie-the-truck> <aB4nqtMJuvvp7Vwm@arm.com>
 <015746d7-ca46-4978-a441-09fba781fdd4@arm.com>
 <4709ff5a-f89c-426e-ae95-f8356808f4f5@arm.com>
 <99079d56-428b-4bc4-b20a-dc10032f2a2f@arm.com>
Content-Language: en-GB
In-Reply-To: <99079d56-428b-4bc4-b20a-dc10032f2a2f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::6) To GVXPR08MB7727.eurprd08.prod.outlook.com
 (2603:10a6:150:6b::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR08MB7727:EE_|PAXPR08MB7320:EE_|DB5PEPF00014B95:EE_|PAWPR08MB10166:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca1e520-cca5-4c6f-6a94-08dd9178f00e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VVZuY1pKQmZXUnJiRmJrTDdXRjBsTWpEVktFR0ZZYVFQTjZaUlJVL1NZcFhh?=
 =?utf-8?B?aDlmblJBN1F2aGVsaFVTczhKeDBWN2tyeDVFZHlMR2Z4T0tSd2VHM01ERE85?=
 =?utf-8?B?cmVneWQ1a21LOCtIMGdQOFVwWS9MSE8wR1F3YXlmajNudjE4R2JHMW1GQkJE?=
 =?utf-8?B?ZjNIaTdLNG4xcTFhZW9ZcW9CMis0VVl6RUE5bmdoYnJKb0d6WWlJcWg0VThH?=
 =?utf-8?B?MmZOSThGYzBHYi94dTZiSFhjd2VRZjFYZVFQTEdDeGpIM2hDaE9ub09tWFpv?=
 =?utf-8?B?cDQweXVnTFNVdlNkSytNaG82RDJrb1lOTUxwemlNZ3BSQ2MxNDBqWmpNOHFq?=
 =?utf-8?B?K2twaXMyQU9jUmhsbTk2eS9nWjJ6RXNxZndMS0VrWndYcjhhNWNqd1pnc1ZC?=
 =?utf-8?B?UE5JVE9XbXZucXVxZGk5ck1YOU9zZ1RITWpUNnpKaXVpVzBwTHFnTW9YZ2V4?=
 =?utf-8?B?ektTSlVvd1NzK1ZlZ1J1eEZqRytMZjVxdmNWRXZkMnVGUWVUQUhTZmRYMkd0?=
 =?utf-8?B?c2VqYitKS085TC9zNjhGRFdSaThGMDlIUm9WMmJLdDB4azBxaHZaeWxrSlJn?=
 =?utf-8?B?T3hRWGFLYm9XenpRV2g2Ti91dTQ2UmlxZTU0dEJRV043bVZaVEZ2SHVqVW9N?=
 =?utf-8?B?MmxiNGRXMnAwclcrc0w0WDBMZE9sYTBiSEpJV2pjN0xVM3NRNDR3TCtBdVd1?=
 =?utf-8?B?MlRJQXhJZGtwWC9mdXdSblBMRWgzcS9CNkExcGRuT1JVNnFmSm9GcjhIVzhI?=
 =?utf-8?B?UjAzN1BQTlA3K0plWldXeTVaVjFaY0FvQis3WUhLbWdyaDVsUGJMTVh5ZXdL?=
 =?utf-8?B?TUJabzA4NzhWRzBhYkx1ZEg0V1BDTGtqOUdHaldQQUF6ZVllcHc0NFhDK1E1?=
 =?utf-8?B?eTNKcCtwVk5IRWp6VmZvMkpBcWdtekM3Q1UrOTM2YnVEMUFGMlVnWFFZb3Y3?=
 =?utf-8?B?VFpOT3p2cWUwWFI5bTZDVGd0ZFFhQ0dhTkVNUjlCS1BIY2RmZWtUWFBVV0l5?=
 =?utf-8?B?ZGFTendqdml6OUw1Q3FWSzFNK0hSdnEzQ2NhQWozVGJ0c0lFcFpxL1A4Z3cy?=
 =?utf-8?B?Q2p6WUdFcWJENkRLVGR1U29TZ21uSk9PK0ltL3lXZmRjMVRObjNJMndhT21P?=
 =?utf-8?B?YjR6YnB2bEtpdVpmZ2J4K3NnN1QrMkRmdU5YS3Z0VmhYZFdpTVN6VzZrYWRL?=
 =?utf-8?B?ZjZiTXNtTGx1enloSEpNK1A1ejBaWHNWQ1ZkalUrdmNPUHduWGFHSlgra3Fx?=
 =?utf-8?B?bkw1UHFBZk90dmtZeURrK1hkZXhiT05ReEZwNENReDYxWDcrb1o3LzJIY0hE?=
 =?utf-8?B?Z3ZBM3FiZzJya3pHeGdTemlZVEo3b0ZObmwzc1BWVkVTMEFRUDBvVCtlaFBK?=
 =?utf-8?B?WVQzcW1OL1R3SFVsRk8rOFNjbjltV2xVcDhvcnVVYlVPbEVaODdwdVgyekJz?=
 =?utf-8?B?UDJJVTVQcGNVMW9CelJoWm1nWEtJWGxBZ1VlL0Q5dTgwMVhBWHZVa1hOdDdR?=
 =?utf-8?B?SzNaU3VNUTA0cVpkUTFRdnh3cFlYMjZUSSs2VWJQSVM1dkJOZllaUmZmckVv?=
 =?utf-8?B?eUdDSjZPUnZ4dWNtcDRlNXVrOW9LWWg2YWEvY1Vqd25YUndPQ1M2UU52cnJ6?=
 =?utf-8?B?eVFPTmNnQU1QU0RMYVJ0cW5XT2NMYUt5YjcreUg3THdIUXdCc1NYTnZMem90?=
 =?utf-8?B?Skp4TlhRYXZObTNxT2hyMC9rcm5TeG9RWFBnZ09VZXFDV1FDNFZ0TzB2U3lQ?=
 =?utf-8?B?MFBWZ0pDazgyY0VjOUNDT2c1QXBvNndnWWxjYkp1OEk1ckhyNkk4bm5VZEtZ?=
 =?utf-8?B?VGhvVHhIdEtoa2tQek42MHIrZ0pONVIreFRvTE1tRDI4ZFA1OGVmckhQK2Zh?=
 =?utf-8?B?cXpnL1V1bDhlTHV0RnpQV2NBWkpXNEVPaWZMNzlDWm8zeTVUNDg1UFlYaCtY?=
 =?utf-8?Q?6wxqBvHwzDw=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR08MB7727.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7320
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c10ebf65-ad51-46b5-bbc8-08dd9178dae9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|14060799003|7416014|376014|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXo3VWhtNDhkVFV4bDNVWWtyam1HUEhMeGZ3N0FNbHp0U2RqeFdlUTljSENV?=
 =?utf-8?B?bzJONnFVbEdkQ0F6d1ZCa1oxdGFuaXhwSGxGWWt0TlRXN2JnbDRXUzdSS0Yw?=
 =?utf-8?B?L1I1NGxmYW1yYzFPWUJTeXhha1NqRzVCM2F3L2Z1YnRsRXd2MHNCTFUyY05p?=
 =?utf-8?B?TFd4aW1SdUZLb3ZKWmlEOUFnMG1veVVpSzM3OXVPRmdUTHRTMUVoSmdHeVd6?=
 =?utf-8?B?Unk1dmZWdXIrMWEwWmgxWFhjdlFTWjZzVnd3SnhtcU1XTFlvUWxrVDJRdUFs?=
 =?utf-8?B?aGRaOGIxYVRQaDVZaFY1NzNVaGQzS0M0c2lVWjFNQzdoN3FoYzMxZS9oTTZk?=
 =?utf-8?B?NkQ1SjN1bG40NUtSbzRUWThKbm04QWRRT05JaHhwNW5zdkt2UDFlWm9FZXRD?=
 =?utf-8?B?UkNyR3MyYUZhTWczRm1temtKVmV4UlM5Y09OZHBtMHNTT0R1ZlM5YTBMQ1Ro?=
 =?utf-8?B?UjlsU0NnYlhZUUVrRjA5a2dWSGtaNnMycnZzN2VVOXNDYU9meWl4YlM2U0VZ?=
 =?utf-8?B?a09lNEYxNU9xVDBqbzE5N080eXVCaXE3VGY0bXJaMTBtMGRqOGVHMUVpV0hu?=
 =?utf-8?B?cCtSZHFFRE9uZEppaVhIWTJrbjQySTFpdG1OaDBaZ2QwaU00MjJLd3ZHRTBH?=
 =?utf-8?B?QTZUdjNib0JTREcwYzlPODMyK0YzTDlBTVdnd3JwM2RBd0Y0bG5rREJONnh4?=
 =?utf-8?B?OGVRQ3ZyeGRoSDJWVVNDQ2FqSE5NdkxaRGRMSXhISTdmVHBUOEsrOW80NkNm?=
 =?utf-8?B?dzBlUEFTYnJzSVpWM052SytUeDByZFJHcCtvcGE1VC9aNnFLNmRDRkl4TXJL?=
 =?utf-8?B?M0laRFFsVE1LRjdwRGY4R1Q5WVZxWExoSGxJWWYzbTRxckdFNTAyOWhtZmFP?=
 =?utf-8?B?STFGWnptU1B5a1lTSXhPQ1cvZlpEWVM1ZWRPbU45dlU3Q1JWWVF5Sk55dkpk?=
 =?utf-8?B?bnVsbG5yOG1Mak56OHpCL3dOV1pjRTlXTE9MdEVCVS9IbEZSRjJKQW14S3ZT?=
 =?utf-8?B?QktRN0RPM2FWcWp0Yk9GZHAzc2RGc0J2enZ2VjZ2WFNvZmJwRWI3Mi9KMGZp?=
 =?utf-8?B?T3pvdzg1c0NyektPNEJIMXNRMlhmZ0JUeDViV2Q3ekFwUFROOFFYTnByNURh?=
 =?utf-8?B?bks2cXkxdmVEUU1iQkdacTJGdTdVUlQ0VEsrWTJxVDNkZDQ0aEI3RDlYWU1m?=
 =?utf-8?B?aThGcEgwQVV6Sm80V2VTQzJ5akN0bEkrbGFNZUFyNk54elJxTDQwbkkxK0hM?=
 =?utf-8?B?U0ZsVXpkYTArRGt5RkhZN3dmdGJaM2V1U2JkRSt0RmgwdEFYUE5IaU1oQ2hL?=
 =?utf-8?B?WXNDbjRlRjR0aHNGeTlLdGpERGlXZWtJemFqd0tNNkcyeEpjaThldUUwRUxF?=
 =?utf-8?B?VEpRd1BjQ1V4MmhmSzBVWGhFMmlva1E3WVV1ZDFZbGp2WXl3VmZvR1BSR21X?=
 =?utf-8?B?aW1pMThOOXowQnVmUmhQSmVKRWdOdGdRa0pwVEwrb0hSdXFpT21ZckVMMTBY?=
 =?utf-8?B?RHBRcTA1V0JuSUJOcVY1SHpUNGFaUWFKRm1NM2NLYjdqY08vbCtNV21KeTBt?=
 =?utf-8?B?MWlXVk9sdUVFVEh4SlF2SHR4YUQ4UVV4UmZrNnpoMjdJOURZOFlxY2Z5WjRN?=
 =?utf-8?B?MG9rM0JJSDQwTUFvRW5kSHZiUHIxUVd6Sk1CUGIzeWdYVkpTdTQ2cGhpOEpP?=
 =?utf-8?B?Y3hVcktPd0IxOCthVEJ2S0RleHR4cFFVTk42RVU1Vi82K0k4L1NucEJFTTJ0?=
 =?utf-8?B?dndGSVBZUmx5eUVlZmZPNEZxaHk1L09uOXk0ejU2RVVoWGMrV3ArUlQybXVn?=
 =?utf-8?B?Zml2TWsxTTk0TG9JeVh5d1JrY0tGdnQ0d3lyY2lleGFmc1doUTg5WTQ4SWdY?=
 =?utf-8?B?TDdWZDdhMEZuaEh2MzZPZmpUT1FCOVBYaExCeFFRc2JoU28xemNyRHdhN0dP?=
 =?utf-8?B?ZmJONVZLZUZWd29ZOWIzeGFIVEJidGJuSUlLQXFTd2c5UTV6UkZvY0s5aUs3?=
 =?utf-8?B?elloSG9TWmFBTWFnTWgyT3lZZWowcEtPaDlPUDI5dlRCdkRiaUp5d1BFVGlw?=
 =?utf-8?Q?m/+o09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(14060799003)(7416014)(376014)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 17:17:56.4958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca1e520-cca5-4c6f-6a94-08dd9178f00e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10166

On 12/05/2025 14:35, Ryan Roberts wrote:
> On 12/05/2025 14:24, Suzuki K Poulose wrote:
>> On 12/05/2025 14:07, Ryan Roberts wrote:
>>> On 09/05/2025 17:04, Catalin Marinas wrote:
>>>> On Fri, May 09, 2025 at 02:49:05PM +0100, Will Deacon wrote:
>>>>> On Tue, May 06, 2025 at 03:52:59PM +0100, Ryan Roberts wrote:
>>>>>> On 06/05/2025 15:25, Will Deacon wrote:
>>>>>>> This penalises large homogeneous systems and it feels unnecessary given
>>>>>>> that we have the ability to check this per-CPU. Can you use
>>>>>>> ARM64_CPUCAP_BOOT_CPU_FEATURE instead of ARM64_CPUCAP_SYSTEM_FEATURE
>>>>>>> to solve this?
>>>>>>
>>>>>> We are trying to solve for the case where the boot CPU has BBML2 but a
>>>>>> secondary
>>>>>> CPU doesn't. (e.g. hetrogeneous system where boot CPU is big and secondary is
>>>>>> little and does not advertise the feature. I can't remember if we proved there
>>>>>> are real systems with this config - I have vague recollection that we did
>>>>>> but my
>>>>>> memory is poor...).
>>>>>>
>>>>>> My understanding is that for ARM64_CPUCAP_BOOT_CPU_FEATURE, "If the boot CPU
>>>>>> has enabled this feature already, then every late CPU must have it". So that
>>>>>> would exclude any secondary CPUs without BBML2 from coming online?
>>>>>
>>>>> Damn, yes, you're right. However, it still feels horribly hacky to iterate
>>>>> over the online CPUs in has_bbml2_noabort() -- the cpufeature framework
>>>>> has the ability to query features locally and we should be able to use
>>>>> that. We're going to want that should the architecture eventually decide
>>>>> on something like BBML3 for this.
>>>>>
>>>>> What we have with BBML2_NOABORT seems similar to an hwcap in that we only
>>>>> support the capability if all CPUs have it (rejecting late CPUs without it
>>>>> in that case) but we can live without it if not all of the early CPUs
>>>>> have it. Unlikely hwcaps, though, we shouldn't be advertising this to
>>>>> userspace and we can't derive the capability solely from the sanitised
>>>>> system registers.
>>>>>
>>>>> I wonder if we could treat it like an erratum in some way instead? That
>>>>> is, invert things so that CPUs which _don't_ have BBML2_NOABORT are
>>>>> considered to have a "BBM_CONFLICT_ABORT" erratum (which we obviously
>>>>> wouldn't shout about). Then we should be able to say:
>>>>>
>>>>>     - If any of the early CPUs don't have BBML2_NOABORT, then the erratum
>>>>>       would be enabled and we wouln't elide BBM.
>>>>>
>>>>>     - If a late CPU doesn't have BBML2_NOABORT then it can't come online
>>>>>       if the erratum isn't already enabled.
>>>>>
>>>>> Does that work? If not, then perhaps the cpufeature/cpuerrata code needs
>>>>> some surgery for this.
>>>>
>>>> Ah, I should have read this thread in order. I think we can treat this
>>>> as BBML2_NOABORT available as default based on ID regs and use the
>>>> allow/deny-list as an erratum.
>>>>
>>>
>>> Just to make sure I've understood all this, I think what you are both saying is
>>> we can create a single capability called ARM64_HAS_NO_BBML2_NOABORT of type
>>> ARM64_CPUCAP_LOCAL_CPU_ERRATUM. Each CPU will then check it has BBML2 and is in
>>> the MIDR allow list; If any of those conditions are not met, the CPU is
>>> considered to have ARM64_HAS_NO_BBML2_NOABORT.
>>
>> I guess we need two caps.
>>
>> 1. SYSTEM cap -> ARM64_HAS_BBML2. Based on the ID registers
>> 2. An erratum -> ARM64_BBML2_ABORTS. Based on BBLM2==1 && !in_midr_list()
> 
> I don't think we *need* two caps; I was suggesting to consider both of these
> conditions for the single cap. You are suggesting to separate them. But I think
> both approaches give the same result?

Ah, my bad. I think a single cap should work as long as it makes sure
we "no BBML2" doesn't est the erratum.

Just to confirm, you are proposing:

ARM64_HAS_NO_BBML2_NOABORT (or in other words, ARM64_NO_SAFE_BBML2)
as CPU_LOCAL_ERRATUM (remove the "description" field from the cap, so
that we don't report it, when we detect it).

matches() =>  !in_midr_list() ||  !ID_AA64MMFR*.BBML2

I think that should work with the inverted check.
I am wondering how we can plug in the AmpereOne missing the ID register
case. May be special case it in the matches() above for the same cap.

I think that should work.

Suzuki


> 
> I'm easy either way, but keen to understand why 2 caps are preferred?
> 
> Perhaps for my version it would be better to refer to it as
> ARM64_CPUCAP_BOOT_RESTRICTED_CPU_LOCAL_FEATURE instead of
> ARM64_CPUCAP_LOCAL_CPU_ERRATUM (they both have the exact same semantics under
> the hood AFAICT).
> 
> Thanks,
> Ryan
> 
>>
>>
>> And then:
>>
>>
>>>
>>> Then we have this helper:
>>>
>>> static inline bool system_supports_bbml2_noabort(void)
>>> {
>>>      return system_capabilities_finalized() &&
>>          alternative_has_cap_unlikely(ARM64_HAS_BBML2) &&
>>          !alternative_has_cap_unlikely(!ARM64_HAS_BBML2_ABORTS)
>>
>> Without (1), we may enable BBML2 on a (system with) CPU that doesn't
>> have BBML2 feature.
>>
>> And (1) can prevent any non-BBML2 capable CPUs from booting or (2) can prevent
>> anything that aborts with BBML2.
>>
>>
>> Suzuki
>>
>>
>>>             !alternative_has_cap_unlikely(ARM64_HAS_NO_BBML2_NOABORT);
>>
>>
>>> }
>>>
>>> system_capabilities_finalized() is there to ensure an early call to this helper
>>> returns false (i.e. the safe value before we have evaluated on all CPUs).
>>> Because ARM64_HAS_NO_BBML2_NOABORT is inverted it would otherwise return true
>>> prior to finalization.
>>>
>>> I don't believe we need any second (SYSTEM or BOOT) feature. This is sufficient
>>> on its own?
>>>
>>> Thanks,
>>> Ryan
>>>
>>
> 

