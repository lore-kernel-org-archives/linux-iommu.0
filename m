Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A57228FF
	for <iommu@lists.linux.dev>; Fri, 30 May 2025 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603069; cv=fail; b=owOEm+M/O2EsaJmhH9w7TgDoTPuHOEE0pgODEUovQUgQb5qNgdb8YDikXpZ/zAKCgufYPD4CXWjRRxPSIig2eXNCnIt4iLoYZ9Yg3LEACr2loQyfqxXvHklh26YHXyjzCZ8rJKVS39prXtmUKxnZe7AtFablcs2U0cJKoHNPQP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603069; c=relaxed/simple;
	bh=uTAgtkEyAbR2yUeR5tgTgmiBAsudpKkbQ62pEDnai1Y=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=pjvW/pVKa+AJrMqbbg779oHESWOrWoelrASHP5hZMKQQysHEphTkLUrQ7AtiA6idpNfOK7AkGzA5hjTpOQVhPRs1QI2p1J2Xobi5530VDXUrHqIiPKE8PryHsmbtyLoSvEokfnuxXNaQ8Z0kPOwmPseU50SGtIJlXtqIHPW/4sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nh/bpcz0; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nh/bpcz0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1FBeWw9ifkbhJr350w0Fun0/kslTYrHAKvcjDZozbSW1UwRxIibJDnlzu/gKniXjqvawrD1Hv41dnAOuzIDPb7q1gwqQjd3B568iKc1VjebHh0hU6cbDck5B3FUVDu9M5T4ugtkH9RFZO2dvwlyXQGQnZ2rkDrMjZpwCw3nyBGsFvCoRnOGG7/K9FaamkEaAhNNau0LCZSDwmWv18dVQ4ahoQGDCzie++wxElToX7em68PljyCY2+HRP9pRccMas19Bh74N++l6tv7YtqVgLZqcDQmKizkczsvUHT19KNLiUCPq08WzFVxGzba7KEUA8DdPyPauba42escZh9vS5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JjTy7nzJ/cg5MPb3BZuE3nmsFkM8doRzLONn/gyG+Y=;
 b=NzjwFMTzEtaXCpFDCzDfTpKGxce3Lr4tcbYBwwhIDIXgYVDS/BcU7uPTQ8WJY59q8YooslW0ssYY5OqDUTcZKXJ2ndItkbEmsci/cNsL62g2IilFvQPBjBBBdSVc9SwflpDWogB0zCbk5//M/CnJnjPe0r1DfJTCGpn3henb9bNW1cJRV+Hp2hpYaWTFDs9xIfE0PDrCvNZA53ZmnrahDprvjLcRXgIj7YqJiqxTk91cVkiT/vzXco1RRTI+H9+uCE4yUwnNDD1yKX3fxxU1Gx6AvJzIqKk9B8JHltKFnJu9d0rz/rQyxW+MZINgdhCvREX687/Gpiwk0ER14Mn74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JjTy7nzJ/cg5MPb3BZuE3nmsFkM8doRzLONn/gyG+Y=;
 b=nh/bpcz0MViGTVngjqAi8nclvH5cn88fLppcje7lrRzaHeqxxa+Gl5ctJOt6V6ojKUptUQ98etWktNe0tAWvkLRiPrEiElKsBtHGGwMvwCgrZPT7/HgUwq0e39XqjAnJ1TrKfNm4Wdysys4bpsKWaEK5E7lPhYY/wFCwwp5lgCj3f5gFAW8ww5+cO3w3Q0SscoWOj2++EhjKDN8lEdk/AtWr3YM4/3F8qEEW7I8+sX60IzrVMXMJ1cY7vbRlAZKxW5f0ffzd1b4ZL6B55Jb4p7Nd48BqE2MLiO/xHDf813DyOsnAvYXVrcS/k6ZfXbsC7KL5uzx/mqNtQeV4KCetLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB7665.namprd12.prod.outlook.com (2603:10b6:610:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 11:04:21 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%5]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 11:04:21 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 May 2025 20:04:17 +0900
Message-Id: <DA9G1V69KTZQ.1SCVVKL43692A@nvidia.com>
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, <jgg@ziepe.ca>,
 <dakr@kernel.org>, <lyude@redhat.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Valentin Obst"
 <kernel@valentinobst.de>, "open list" <linux-kernel@vger.kernel.org>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>, "Robin Murphy"
 <robin.murphy@arm.com>, <airlied@redhat.com>,
 <rust-for-linux@vger.kernel.org>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, "Petr Tesarik" <petr@tesarici.cz>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Sui Jingfeng" <sui.jingfeng@linux.dev>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Michael Kelley" <mhklinux@outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
In-Reply-To: <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
X-ClientProxiedBy: TYAPR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:404:15::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 22533236-98b9-4651-39f1-08dd9f69bacf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTFqcWpiNm0vb0pIYkZSdkpqdElJSjViYlF1MjFITUIyaEhCRTN0U0l5RjZF?=
 =?utf-8?B?QThNV3p3UDlFY1Q3Qm9FRVlWTFEyc0N4K28zei9LeU5xcXVJQTdLK3VqWlZt?=
 =?utf-8?B?aVQ2dzBLbEJxcjl0VmoyZGtQcjZwYUZPdTltQjNFakw0WHk0UnpJcVhwamhh?=
 =?utf-8?B?Vnl4UEo3VHZzQUhESjgwZXhtVEp0VkozVHBmWkx3bkhWREt3TU82ZnBIeG9I?=
 =?utf-8?B?QnV3YUVldmIzYXRYeFVrSmpiUkliOFlpMFYxenpNMEFEQXk2WmVSVElEQkhs?=
 =?utf-8?B?cjJkbmtkcUZicnE0aWJNc3RPOEFJdDZXcFdWQmpaTjF6bDFYNVVmSi9mWDcr?=
 =?utf-8?B?OEttd3JLaVMzTE9aWU83c1pqMGFmZms0TDlSVHBGR3M5djZ3MlhwQnU0OGhE?=
 =?utf-8?B?aHpQYWlLc2tkOFpTZk5HajBzSnk4QmJpNW5ZWTJkS2lHV203MURVN3N1YTNl?=
 =?utf-8?B?aExJQWE1RXY3ekV0ZDYyeUcwZHZldkxPN1d0bmdRUlBnbDBUQ1NLdEVrYTBr?=
 =?utf-8?B?TDd2T2RVWHdXTzNZQTBWN2QwTTFDMDZkZXd2Y1lsR0RUL0ZnZXBVOGc1QnJv?=
 =?utf-8?B?dnBCWlo0SjYvdElYMVdJcFBMOTVZd01SRmVGOG1qQ2lnaWViSlgxSE5xcThR?=
 =?utf-8?B?a2hPTFdRM1h5SDF2MFl2VE85WDYzQkt6MVMvNkM4YW9TeFZwUmhGL2JuUmQv?=
 =?utf-8?B?b2kwdDRnNzZzTHRRczZDMkorWmJJYVR4S0ZoK2tFNUNQQmtvenNjY3VoWlFt?=
 =?utf-8?B?UEkvOEpWbmk0RFpmMEdka1c0TVViVFJDdTlveEtCdnZuSVV6Mjh1OWRWdyt3?=
 =?utf-8?B?SG1LSWpUZG5jZlNYdndPY29sT0FEN3dER0VFOXdCTkYzbGhGRUwvTmtLVnJh?=
 =?utf-8?B?UXFWN2p3TGZFUjRjZFBvNDJEMm5PMmE3b3lZQThKTG44aEdvYlBuWjVSY1VI?=
 =?utf-8?B?VWNMZnJDaEF3UlRUUG4rZzVJazVpdE5yU0JCanJHWEtjckF5aW5laThzNEwz?=
 =?utf-8?B?Q3N3WmFwK3FyMHRtZ1dNTi8zRW5qODRFNWRtS1R2Y2UrNHNDWFNpandQUm1n?=
 =?utf-8?B?Sm5hSTJ2WEJKUUF2T0FOUkNmZmZiVjMrU3BHWElJQ0lWcTNYaXNva3hvNk93?=
 =?utf-8?B?Q1hOMERHR2MwbGZNczhDNzVNZ0pBZjdaNkpiU21hZnMzNTd5eDM2Y25NRUZW?=
 =?utf-8?B?OGZQcDhaalhiTzRrNFBEUDNBdldMb2Fnd3d5VmFjNzRSMGJ0aEk2T0Y3WUpU?=
 =?utf-8?B?aVJkWFV1Y3JrallZa1lvT1dDSFVFMFFNUVNFOGE3dS9UZlp5NU9SbDd2Umha?=
 =?utf-8?B?ejVxYmJwOWhOSE8wVkJKWW9odVFTOEpZQ2lJSk5ENkVvM2JFeVIzL1BtSmpZ?=
 =?utf-8?B?ZVpjYjRGb2NtTFJac01nZnFsRk94dVdEV2szVDV4SXAzOHl5dUxvc1BHbFJZ?=
 =?utf-8?B?VGV0OFQ1NzRUM3F4dFlEVjhuS3YvVms4WWxnRmxJY3BDZTUxaEo0Q05TR2hF?=
 =?utf-8?B?VFJpRmllZDhsWCtVdjVXZkk5NXFlekYxMHB0L254VmxtQ3grZ0R6VzFCVVdT?=
 =?utf-8?B?TC9kbmxCMEVUUVJIMjg4Q09aVVp0L0VnSzdjZW5IZ3EzbHdDWlVWMjNTbWZN?=
 =?utf-8?B?VXRjWjVna1pmUElLZ2huVFJjTTNMWml0VzNZK2taK1Vkc3N5RmhHT0p4SVJv?=
 =?utf-8?B?QzRZQzZiaEhwTDJ5bDFOMDdTZnlKSDB5S2FsRC9Ya3pRZWNrZzJ6bTU4YnF6?=
 =?utf-8?B?MGxXZTFLU3Zzam1TaHpYTGsxa2oxNmFTRExxaW9KSHdGSURZaUI4aTQzbVky?=
 =?utf-8?B?NTBkRG5VbzFEQkgzQmlNV1BUTWNXc084UkFjQ1EvL2h3RGdHbUFxWjRoRGZM?=
 =?utf-8?B?NXVNWEl2eC9TZ3U1RG9OQkFHZ0tkQlZibXRxdkR4cjI4Nk5ydHlnK1E3Q3Bk?=
 =?utf-8?Q?69BVF+Re6gI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVlzZE9uUlpJUGtCZ2ZydmowT1JiSzZRTm5uSXBvVVB1MktGdVBPMGJyZXFR?=
 =?utf-8?B?WVlweTdtOHdvbEZTek5TMGVCNTlGYngzQ05Sd1NwVG1NaUdPK1RqY0ZLTHQ4?=
 =?utf-8?B?Y1hsSmhVdTJueVZiNmQ2L29VOUV5QkhoenJLY1ZaSWs1TDVBM3pZMG5lUFB4?=
 =?utf-8?B?NlZmaUtIbzlhb0pWT0l4TUp5Y3hYSTlRNFM5NUlGTkh4Qml2NDgzUS9jTmRo?=
 =?utf-8?B?dGlZUFpCeWxmWnZIbWtqaHBOb28wNzl4SWozakUwMXBSWDZwYW82czVNK3Jr?=
 =?utf-8?B?RnpyME91UmJodXlxeWlUOXRBRnoweXZUaFVORVBaTjVTaFdySmwzRW1jV21j?=
 =?utf-8?B?T3ZUL1oxNmFvZldVcWUwM2w2WmhIQ2pNNFY5VGdMcDQ4dU9mUlBRVnM1Rk9F?=
 =?utf-8?B?OWZLYmZnVEFkWTZQZlpNb0YzcUJXUk1SbXZNTkpWaDF4MUd5QnZIS3Q4VE9q?=
 =?utf-8?B?SGNpRyswRU5lYWJ1MVQ4OENYMys0Z3JvV2N6UEZKb3Nlck9WUjBqb1p6d29O?=
 =?utf-8?B?RzFiWi93dlZCTkZtUnluN2srRDE5MGlXMVJrOTZlL1RVcUkyOS9zaTh4TXd5?=
 =?utf-8?B?TlorbEJyaGdaUjVxMW4zSWtWU3l6R09qaTVwVWgzeGVjK1JMQzRoYnRvSTVo?=
 =?utf-8?B?VGRzYUtVdS84bEtQQzJFWG80QmtnVldxREhuN1Bpc0R1WDQ1aEdpTkNaWjJs?=
 =?utf-8?B?U2xyTzhkdnJEbWU1OGhkeGhWYVdoYWp4UmZUaWJLYnFMSGlxdTFobWtrdnpz?=
 =?utf-8?B?cGZMTVp1a3I2dFNBSFRwQm42by81VnB1RVZxN2lWM0tjRUpCYmptRlN0ZElI?=
 =?utf-8?B?NzhjQ3pSZmJLSjQvMkIzWHkyMEdsblhURVMzb1lITVpyS09kMFdZbVFuVlho?=
 =?utf-8?B?Y1FwR1B4M3VwMklTcFhDRTY5QlBuWmVHODFzWVJza2tEZHZQcFUxb04yQm84?=
 =?utf-8?B?am4zRjd2YUF2OUlkZGVmWjNqT25lYytwcnBJekowUFZjaTU1L3BKYU1Sek1T?=
 =?utf-8?B?SllVVzdmTW5OV1dyODNKTzgrVFBVSGNTRGY4VDRVSVIxR0V1b0tqM3pRbmt4?=
 =?utf-8?B?aWxhTmtUU2JseTBNK2hOay91amoxblN4VU95QkppTVFuTDlzTlRPVFBxeXVJ?=
 =?utf-8?B?K1pzS1QrNjZHcWg3K3FnSXlzTEkvdWRVUEpRM0tRcnpNa3pldnpuRjQyQVJC?=
 =?utf-8?B?Nzlva0tyenkwL3hvVWV1cVVSN1pFODV0amZwVTl6Y29sR2NpRndLbm1VRmR2?=
 =?utf-8?B?VXhzeGV6MEJCQkw4Nms2RGk1OW9FaDh5Qyt3ak0xeTBQSmNrVjNyLytKMWJh?=
 =?utf-8?B?VnJOZ25lVDVWUHFxWVBaY3p0YXRFTndLUTFGSTdaVnJSdUIrU1IwaHVnZEpj?=
 =?utf-8?B?T2ZNbEY0bzR1YUVrTVBXS25Pd0YxeGNSU0VFYWs4c1Z3YjRqWFBYTFVOODZr?=
 =?utf-8?B?S3AyeTJqOVlSamNMYndHZ3B1T2RqQnl4QytUODgzSU92aEJZUG9QUEFRRG5u?=
 =?utf-8?B?QkIvanZQNUtaQXZEZ3oreVpUYjJoeFhLS2Z6MmJ5ZkhFRVN0c3U2akxUblZM?=
 =?utf-8?B?Mi96YnFZZEJxQ0JRSlExcjJJSzVoenR0TUJnRVVtd2dxWDMyYkZZSWtnNzY4?=
 =?utf-8?B?YjA2SUhMbDk4TXNFSU5MNmQzWXRGSDQyd3BMZ1M3eFdySFpkUVhBMHFwL3ZK?=
 =?utf-8?B?bDBzQjk4STFUL0UrOFViMlNsR3hZdzV1QjE0NkNTL2ZnQ2g5UjBaM1l0TXVW?=
 =?utf-8?B?YUY4TEorcnpBakYzNjhkS3BhK2J6L1hwQzhqQm8ySTVLRnJPN3hVYXFPU0Yx?=
 =?utf-8?B?VlRRc0NaNGNMTVk4Qis3OWdBQlN5N3VTUEFLQmhOUmN4bGl6bVhwbWpTV0Ro?=
 =?utf-8?B?dmdnN1dFWjBmKys5NjBrM3JlbVM3aW9TbXBOa2pGN3RDcG5WYWxuWThTbGM2?=
 =?utf-8?B?T2RTcXVKSVpjS1pHRUh0dFZUcW15d0JNb003ZGNTdzhLUE5mTEozOThZamI3?=
 =?utf-8?B?RGZxTE9JYVQxdFFKdERkOEQwK09YbUNxaStZaE45cHozTmJFanAwV2pEeTZ2?=
 =?utf-8?B?OEZxNmpxNmlvbGxMMmhrdTNxSWRvdzBINTIreFBlOFBkak0rSStzQnVpR1JD?=
 =?utf-8?B?cHpadzJHL2UxbW1DOUw3ZkRnZ0hHTlNqMTBZN0oyVkxNQmtrUU1yQ0t4U3Q2?=
 =?utf-8?Q?79FL7Pa315B/4Eo+Kay/SM+WwPFqBGVGId5a+GlvLR44?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22533236-98b9-4651-39f1-08dd9f69bacf
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 11:04:21.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l39REMKYeJvbNwKJmoOXHa/bBl6y8+N6ZrVPEo3Loa6YoU14+gLUo4NBMUwjFpU+QX6b/d8ahpGzzAdfDG1rjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7665

Hi Abdiel,

In my review of the RFC I mentioned there are two main issues this
design should address: safely transitioning between the mapping states
and iterate over DMA addresses (the easy one), and building the SG table
properly (the hard one)

Let me keep this thread focused on the easy part, then I'll piggyback on
Jason's reply to discuss the elephant in the room that is the lifetime
of backing memory.

On Thu May 29, 2025 at 7:14 AM JST, Abdiel Janulgue wrote:
> Add the rust abstraction for scatterlist. This allows use of the C
> scatterlist within Rust code which the caller can allocate themselves
> or to wrap existing kernel sg_table objects.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/scatterlist.c      |  25 +++
>  rust/kernel/dma.rs              |  17 ++
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/scatterlist.rs      | 369 ++++++++++++++++++++++++++++++++
>  6 files changed, 414 insertions(+)
>  create mode 100644 rust/helpers/scatterlist.c
>  create mode 100644 rust/kernel/scatterlist.rs
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index ab37e1d35c70..a7d3b97cd4e0 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -14,6 +14,7 @@
>  #include <linux/cred.h>
>  #include <linux/device/faux.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dma-direction.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
>  #include <linux/file.h>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 1e7c84df7252..f45a15f88e25 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -28,6 +28,7 @@
>  #include "rbtree.c"
>  #include "rcu.c"
>  #include "refcount.c"
> +#include "scatterlist.c"
>  #include "security.c"
>  #include "signal.c"
>  #include "slab.c"
> diff --git a/rust/helpers/scatterlist.c b/rust/helpers/scatterlist.c
> new file mode 100644
> index 000000000000..3c8015b07da1
> --- /dev/null
> +++ b/rust/helpers/scatterlist.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/dma-direction.h>
> +
> +void rust_helper_sg_set_page(struct scatterlist *sg, struct page *page,
> +			     unsigned int len, unsigned int offset)
> +{
> +	return sg_set_page(sg, page, len, offset);
> +}
> +
> +dma_addr_t rust_helper_sg_dma_address(struct scatterlist *sg)
> +{
> +	return sg_dma_address(sg);
> +}
> +
> +unsigned int rust_helper_sg_dma_len(struct scatterlist *sg)
> +{
> +	return sg_dma_len(sg);
> +}
> +
> +void rust_helper_dma_unmap_sgtable(struct device *dev, struct sg_table *=
sgt,
> +				   enum dma_data_direction dir, unsigned long attrs)
> +{
> +	return dma_unmap_sgtable(dev, sgt, dir, attrs);
> +}
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 605e01e35715..2866345d22fc 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -102,6 +102,23 @@ pub mod attrs {
>      pub const DMA_ATTR_PRIVILEGED: Attrs =3D Attrs(bindings::DMA_ATTR_PR=
IVILEGED);
>  }
> =20
> +/// DMA mapping direction.
> +///
> +/// Corresponds to the kernel's [`enum dma_data_direction`].
> +///
> +/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
> +#[derive(Copy, Clone, PartialEq, Eq)]
> +pub enum DmaDataDirection {
> +    /// Direction isn't known.

Isn't it rather that data can flow both ways?

> +    DmaBidirectional =3D bindings::dma_data_direction_DMA_BIDIRECTIONAL =
as _,
> +    /// Data is going from the memory to the device.
> +    DmaToDevice =3D bindings::dma_data_direction_DMA_TO_DEVICE as _,
> +    /// Data is coming from the device to the memory.
> +    DmaFromDevice =3D bindings::dma_data_direction_DMA_FROM_DEVICE as _,
> +    /// No direction (used for debugging).
> +    DmaNone =3D bindings::dma_data_direction_DMA_NONE as _,
> +}

You probably don't need to prefix everything with "Dma", e.g. `ToDevice`
looks fine. Maybe the type itself could also be just `DataDirection`
(the same way `Attrs` is not `DmaAttrs`) as it is already in the `dma`
module.

The fact that this type is (correctly, IMHO) defined in `dma` but used
in `scatterlist` makes me wonder whether `scatterlist` should not be a
sub-module of `dma`? Are we using scatterlists for anything else than
DMA?

> +
>  /// An abstraction of the `dma_alloc_coherent` API.
>  ///
>  /// This is an abstraction around the `dma_alloc_coherent` API which is =
used to allocate and map
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index de07aadd1ff5..0a4f270e9a0d 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -73,6 +73,7 @@
>  pub mod print;
>  pub mod rbtree;
>  pub mod revocable;
> +pub mod scatterlist;
>  pub mod security;
>  pub mod seq_file;
>  pub mod sizes;
> diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
> new file mode 100644
> index 000000000000..46cc04a87b2f
> --- /dev/null
> +++ b/rust/kernel/scatterlist.rs
> @@ -0,0 +1,369 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Scatterlist
> +//!
> +//! C header: [`include/linux/scatterlist.h`](srctree/include/linux/scat=
terlist.h)
> +
> +use crate::{
> +    bindings,
> +    device::{Bound, Device},
> +    dma::DmaDataDirection,
> +    error::{Error, Result},
> +    page::Page,
> +    types::{ARef, Opaque},
> +};
> +use core::marker::PhantomData;
> +use core::ops::{Deref, DerefMut};
> +
> +/// Marker trait for the mapping state of the `SGTable`
> +pub trait MapState: private::Sealed {}
> +
> +/// The [`Unmapped`] state of the `SGTable` is the table's initial state=
. While in this state, the pages of
> +/// the `SGTable` can be built by the CPU.
> +pub struct Unmapped;
> +
> +/// The [`Initialized`] state of the `SGTable` means that the table's sp=
an of pages has already been built.
> +pub struct Initialized;
> +
> +/// The [`Mapped`] state of the `SGTable` means that it is now mapped vi=
a DMA. While in this state
> +/// modification of the pages by the CPU is disallowed. This state will =
expose an interface to query
> +/// the DMA address of the entries.
> +pub struct Mapped;
> +
> +mod private {
> +    pub trait Sealed {}
> +
> +    impl Sealed for super::Mapped {}
> +    impl Sealed for super::Initialized {}
> +    impl Sealed for super::Unmapped {}
> +}
> +
> +impl MapState for Unmapped {}
> +impl MapState for Initialized {}
> +impl MapState for Mapped {}
> +
> +/// A single scatter-gather entry, representing a span of pages in the d=
evice's DMA address space.
> +///
> +/// # Invariants
> +///
> +/// The `scatterlist` pointer is valid for the lifetime of an SGEntry in=
stance.
> +#[repr(transparent)]
> +pub struct SGEntry<T: MapState =3D Unmapped>(Opaque<bindings::scatterlis=
t>, PhantomData<T>);
> +
> +impl<T: MapState> SGEntry<T> {
> +    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the `struct scatterlist` pointed to by =
`ptr` is valid for the lifetime
> +    /// of the returned reference.

Something like "Callers must ensure that the `struct scatterlist` is in
a state compatible with `MapState`" seems also needed.

> +    pub(crate) unsafe fn as_ref<'a>(ptr: *mut bindings::scatterlist) -> =
&'a Self {

I suspect this method can be kept private?

> +        // SAFETY: The pointer is valid and guaranteed by the safety req=
uirements of the function.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Convert a raw `struct scatterlist *` to a `&'a mut SGEntry`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// See safety requirements of [`SGEntry::as_ref`]. In addition, cal=
lers must ensure that only
> +    /// a single mutable reference can be taken from the same raw pointe=
r, i.e. for the lifetime of the
> +    /// returned reference, no other call to this function on the same `=
struct scatterlist *` should
> +    /// be permitted.
> +    pub(crate) unsafe fn as_mut<'a>(ptr: *mut bindings::scatterlist) -> =
&'a mut Self {
> +        // SAFETY: The pointer is valid and guaranteed by the safety req=
uirements of the function.
> +        unsafe { &mut *ptr.cast() }
> +    }
> +
> +    /// Obtain the raw `struct scatterlist *`.
> +    pub(crate) fn as_raw(&self) -> *mut bindings::scatterlist {
> +        self.0.get()
> +    }
> +}
> +
> +impl SGEntry<Mapped> {
> +    /// Returns the DMA address of this SG entry.
> +    pub fn dma_address(&self) -> bindings::dma_addr_t {
> +        // SAFETY: By the type invariant of `SGEntry`, ptr is valid.
> +        unsafe { bindings::sg_dma_address(self.0.get()) }
> +    }
> +
> +    /// Returns the length of this SG entry.
> +    pub fn dma_len(&self) -> u32 {
> +        // SAFETY: By the type invariant of `SGEntry`, ptr is valid.
> +        unsafe { bindings::sg_dma_len(self.0.get()) }
> +    }
> +}
> +
> +impl SGEntry<Unmapped> {
> +    /// Set this entry to point at a given page.
> +    pub fn set_page(&mut self, page: &Page, length: u32, offset: u32) {

Random idea: use Range<u32> to replace `length` and `offset`? But maybe
we can drop this method altogether, see below.

> +        let c: *mut bindings::scatterlist =3D self.0.get();
> +        // SAFETY: according to the `SGEntry` invariant, the scatterlist=
 pointer is valid.
> +        // `Page` invariant also ensures the pointer is valid.
> +        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, offset)=
 };
> +    }
> +}
> +
> +/// A scatter-gather table of DMA address spans.
> +///
> +/// This structure represents the Rust abstraction for a C `struct sg_ta=
ble`. This implementation
> +/// is able to abstract the usage of an already existing C `struct sg_ta=
ble`. A new table can be
> +/// allocated by calling [`SGTable::alloc_table`].
> +///
> +/// # Invariants
> +///
> +/// The `sg_table` pointer is valid for the lifetime of an SGTable insta=
nce.
> +#[repr(transparent)]
> +pub struct SGTable<T: MapState =3D Unmapped>(Opaque<bindings::sg_table>,=
 PhantomData<T>);
> +
> +impl<T: MapState> SGTable<T> {
> +    /// Convert a raw `struct sg_table *` to a `&'a SGTable`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the `struct sg_table` pointed to by `pt=
r` is valid for the lifetime
> +    /// of the returned reference.

Here also the `sg_table` must be in a state compatible with `MapState`.

> +    #[allow(unused)]
> +    pub(crate) unsafe fn as_ref<'a>(ptr: *mut bindings::sg_table) -> &'a=
 Self {
> +        // SAFETY: Guaranteed by the safety requirements of the function=
.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Convert a raw `struct sg_table *` to a `&'a mut SGTable`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// See safety requirements of [`SGTable::as_ref`]. In addition, cal=
lers must ensure that only
> +    /// a single mutable reference can be taken from the same raw pointe=
r, i.e. for the lifetime of the
> +    /// returned reference, no other call to this function on the same `=
struct sg_table *` should
> +    /// be permitted.
> +    #[allow(unused)]
> +    pub(crate) unsafe fn as_mut<'a>(ptr: *mut bindings::sg_table) -> &'a=
 mut Self {
> +        // SAFETY: Guaranteed by the safety requirements of the function=
.
> +        unsafe { &mut *ptr.cast() }
> +    }
> +
> +    /// Obtain the raw `struct sg_table *`.
> +    pub(crate) fn as_raw(&self) -> *mut bindings::sg_table {
> +        self.0.get()
> +    }
> +
> +    fn take_sgt(&mut self) -> Opaque<bindings::sg_table> {

Even though this is private, a bit of documentation would be nice.

> +        let sgt: bindings::sg_table =3D Default::default();
> +        let sgt: Opaque<bindings::sg_table> =3D Opaque::new(sgt);

let sgt =3D Opaque::new(bindings::sg_table::default()); ?

> +        core::mem::replace(&mut self.0, sgt)
> +    }
> +}
> +
> +impl SGTable<Unmapped> {
> +    /// Allocate and construct a new scatter-gather table.
> +    pub fn alloc_table(nents: usize, flags: kernel::alloc::Flags) -> Res=
ult<Self> {

Is there a need to separate the table allocation from its
initialization? If not you could turn `init` into e.g. `new` and make it
allocate and initialize the list by itself.

The problem I see with this step is that you can very well call `init`
with a closure that does nothing, or initialize the entries incorrectly,
and end up with a table that won't map (or worse, that will bug).

> +        let sgt: Opaque<bindings::sg_table> =3D Opaque::uninit();
> +
> +        // SAFETY: The sgt pointer is from the Opaque-wrapped `sg_table`=
 object hence is valid.
> +        let ret =3D unsafe { bindings::sg_alloc_table(sgt.get(), nents a=
s _, flags.as_raw()) };
> +        if ret !=3D 0 {
> +            return Err(Error::from_errno(ret));
> +        }
> +        Ok(Self(sgt, PhantomData))
> +    }
> +
> +    /// The scatter-gather table page initializer.
> +    ///
> +    /// Runs a piece of code that initializes the pages of the scatter-g=
ather table. This call transitions
> +    /// to and returns a `SGTable<Initialized>` object which can then be=
 later mapped via DMA.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::{device::Device, scatterlist::*, page::*};
> +    ///
> +    /// let sgt =3D SGTable::alloc_table(4, GFP_KERNEL)?;
> +    /// let sgt =3D sgt.init(|iter| {
> +    ///     for sg in iter {
> +    ///         sg.set_page(&Page::alloc_page(GFP_KERNEL)?, PAGE_SIZE as=
 u32, 0);

Technically all the SGTs must be initialized, so instead of leaving the
burden of iterating to the user, we could make the iteration part of
`init`/`new` and just require the closure to initialize a single SG.

And since the only thing this closure can do is call `set_page` anyway,
and we really want it to not omit that step, why not make `init` take an
iterator of (&Page, Range<u32>) and use that to call `set_page` for us?
That way no SGEntry can be left uninitialized even if the user tries. We
could also allocate the sg_table, if the iterator's `size_hint` can be
trusted (or maybe we can collect the pages temporarily into a vector to
get the exact size).

The usage of `Page` looks also very wrong, but let's discuss that
alongside the backing memory lifetime issue. :)

> +    ///     }
> +    ///     Ok(())
> +    /// })?;
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn init(
> +        mut self,
> +        f: impl FnOnce(SGTableIterMut<'_>) -> Result,
> +    ) -> Result<SGTable<Initialized>> {
> +        f(self.iter())?;
> +        let sgt =3D self.take_sgt();
> +        core::mem::forget(self);
> +        Ok(SGTable(sgt, PhantomData))
> +    }
> +
> +    fn iter(&mut self) -> SGTableIterMut<'_> {

Shouldn't this be named `iter_mut`?

> +        SGTableIterMut {
> +            // SAFETY: dereferenced pointer is valid due to the type inv=
ariants on `SGTable`. This call
> +            // is in a private function which is allowed to be called on=
ly within the state transition
> +            // function [`SGTable<Unmapped>::init`] ensuring that the mu=
table reference can only be
> +            // obtained once for this object.
> +            pos: Some(unsafe { SGEntry::<Unmapped>::as_mut((*self.0.get(=
)).sgl) }),
> +        }
> +    }
> +}
> +
> +impl SGTable<Initialized> {
> +    /// Map this scatter-gather table describing a buffer for DMA by the=
 `Device`.
> +    ///
> +    /// This call transitions to and returns a `DeviceSGTable` object.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::{device::{Bound, Device}, scatterlist::*};
> +    ///
> +    /// # fn test(dev: &Device<Bound>, sgt: SGTable<Initialized>) -> Res=
ult {
> +    /// let sgt =3D sgt.dma_map(dev, kernel::dma::DmaDataDirection::DmaT=
oDevice)?;
> +    /// for sg in sgt.iter() {
> +    ///     let _addr =3D sg.dma_address();
> +    ///     let _len =3D sg.dma_len();
> +    /// }
> +    /// # Ok::<(), Error>(()) }
> +    /// ```
> +    pub fn dma_map(mut self, dev: &Device<Bound>, dir: DmaDataDirection)=
 -> Result<DeviceSGTable> {
> +        // SAFETY: Invariants on `Device` and `SGTable` ensures that the=
 pointers are valid.
> +        let ret =3D unsafe {
> +            bindings::dma_map_sgtable(
> +                dev.as_raw(),
> +                self.as_raw(),
> +                dir as _,
> +                bindings::DMA_ATTR_NO_WARN as _,
> +            )
> +        };
> +        if ret !=3D 0 {
> +            return Err(Error::from_errno(ret));
> +        }
> +        let sgt =3D self.take_sgt();
> +        core::mem::forget(self);
> +        Ok(DeviceSGTable {
> +            sg: SGTable(sgt, PhantomData),
> +            dir,
> +            dev: dev.into(),
> +        })
> +    }
> +}
> +
> +impl SGTable<Mapped> {
> +    /// Returns an immutable iterator over the scather-gather table that=
 is mapped for DMA.
> +    pub fn iter(&self) -> SGTableIter<'_> {
> +        SGTableIter {
> +            // SAFETY: dereferenced pointer is valid due to the type inv=
ariants on `SGTable`.
> +            pos: Some(unsafe { SGEntry::<Mapped>::as_ref((*self.0.get())=
.sgl) }),
> +        }
> +    }
> +}
> +
> +/// A scatter-gather table that is mapped for DMA operation.
> +pub struct DeviceSGTable {
> +    sg: SGTable<Mapped>,
> +    dir: DmaDataDirection,
> +    dev: ARef<Device>,
> +}

Mmm, so the transition graph is `SGTable<Unmapped>` ->
`SGTable<Initialized>` -> `DeviceSGTable.` One would expect
`SGTable<Mapped>.` :)

I think you can achieve this if you move `dir` and `dev` into the
`Mapped` typestate - that way `SGTable<Mapped>` contains everything it
needs, and you can do without the `Deref` and `DerefMut` implementations
below.

> +
> +impl Drop for DeviceSGTable {
> +    fn drop(&mut self) {
> +        // SAFETY: Invariants on `Device<Bound>` and `SGTable` ensures t=
hat the `self.dev` and `self.sg`
> +        // pointers are valid.
> +        unsafe {
> +            bindings::dma_unmap_sgtable(self.dev.as_raw(), self.sg.as_ra=
w(), self.dir as _, 0)
> +        };
> +    }
> +}
> +
> +// TODO: Implement these as macros for objects that want to derive from =
`SGTable`.
> +impl Deref for DeviceSGTable {
> +    type Target =3D SGTable<Mapped>;
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.sg
> +    }
> +}
> +
> +impl DerefMut for DeviceSGTable {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        &mut self.sg
> +    }
> +}
> +
> +/// SAFETY: A `SGTable<Mapped>` is an immutable interface and should be =
safe to `Send` across threads.
> +unsafe impl Send for SGTable<Mapped> {}
> +
> +/// A mutable iterator through `SGTable` entries.
> +pub struct SGTableIterMut<'a> {
> +    pos: Option<&'a mut SGEntry<Unmapped>>,
> +}
> +
> +impl<'a> IntoIterator for &'a mut SGTable<Unmapped> {
> +    type Item =3D &'a mut SGEntry<Unmapped>;
> +    type IntoIter =3D SGTableIterMut<'a>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.iter()
> +    }
> +}

I wonder if it wouldn't be less confusing to have an `entry_iter` method
in `SGTable<Unmapped>` directly. But maybe we also don't want this at
all if we agree to remove the `Unmapped` state. Is there a need to
iterate over unmapped SG entries like that?

Overall I think this is starting to take shape, the typestate seems to
work here. But there is still the big issue of backing memory lifetime -
let me collect my thoughts some more and throw some test code, and I'll
come back to this in the other thread.
