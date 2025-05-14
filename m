Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1820C00B
	for <iommu@lists.linux.dev>; Wed, 14 May 2025 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747211355; cv=fail; b=qqi59Pm57wxNvuP4Wgu6FgAmv7coRxLbyZ7/lTXD2Ec2wPxpPW4DJpGel8enyOJUpjU1/2WO0SB2QdYN9go6p425b09jtXAPld0BgoAsX4ukG3prxIek2PQkYduEdCHiIWpyCzhi7UAcBn0hVxbX7b/pOBaqf1JRMecb0fmplKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747211355; c=relaxed/simple;
	bh=3judP4NH8tL0Jc4PjGsw9WuZbnmmHvjV+Mrv6LhGKq0=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=CFZjzkc4A5XYwqI+KtuqffQn5Mg1SSxEy/fMC6+mEKsxm1Vzy2NiC0xw5IYjY+yBpMT/vDdtMA1Kcw4GTX8nPBPtxyjQ/HOX2r1SOj7lBvsf05eTV5D17DcjNKEh5XJoq4T8FXeQ4skWMWXwqA7j7t04wAxW2byue88h04MCYyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ilGcD/lD; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ilGcD/lD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6KCZY9SOOOZvwUYMANJ5fMk7xqZ5ALDcqP0dWT6dRffJbzDGFZnwP70OernyiXoby1C9cvsXPVG3Jx+LjQlT1K+i5JyA9s/Wch8F7MWvQkq4F2n3YqPVq77agbkNpFW2jrlCe5oeWAEVrkgRWvDB1BrMJd9uiZzyIjwNnKocpYDRfFiPTOgu1DsuJIgDPdLn/l4eVUeEGRrlxF2Cj5BI+EusXEr+VCzm2FQSaCP1ZWBgIzsIeje6+jkWqd/tVE+AJMre+6IjGgVu/FpHSYOlHp93vOU+IqvFFOqxWbiEbDDlf3Le5FD/s/ZKpdt9AkJZsZO0vMSWUDeNl9qRMt+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHMOva/xDW3lqfTTgob5PiWiV6EN3zLqf2roktWwz1k=;
 b=jYaXccFRVrSCsyQ3k7y+GDpZ+911jmDzx75AqK6A3VWNXrX0q6qY/1AtKYEfxSVfwwKrVEeJDLlDDLpvQ7Xzd09jPlh/HpKXZXGIlf8J1dwY+HXSdsbJO7eKZ80GAlDeAe4esRk3KFhTAbVfBIkJV1cyeFOBZdlba/IBiiAtNK2sY6auaHio/3CSEx/C5ZRUfTmotxnWnJ6HTKILrsII14JVMXdgBFhRM2QBeuvpJRlmBIDkteQ0ZMdEp9PlLXOP1YoQjfCTqyiSfvRT+bkLq5marpOXV3fBRrKcxV7Qr7f612AbcLhojjxCRwYKXZRanvjvGeVmfSn1hX4h5EwbCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHMOva/xDW3lqfTTgob5PiWiV6EN3zLqf2roktWwz1k=;
 b=ilGcD/lD+ONlwHaBfkwlu/gKZuJ0Mb/x2V73VqMQ0Iy4CCqybdJIKFJGslJIOX+qtvfJe/Ew+kCaVa9STZVh/Faerv3aV8LSbqYV2gpigZzrwRlaUDFbyukqIujv6cqNQNXP92t5cWrkLLnEfUBEAy7vIXOhNdeHyWUE8fuMh25nQErzOXtP3lm/w7JfCaWlMqh9kGpW4FMxjJyBm9Rg00W+V+K6l2Bo1uNZdIFFNbZoG+saRm6sbYS4FKf/bOWc/dopBiMGpU9B/A3wb7u+g7XnBIY3jImyOH96YXTuky4mb1BGaiKZRlOfPGSS6jgrW9Zd9LqFAS6j7iO16Nub5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 08:29:09 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 08:29:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 May 2025 17:29:04 +0900
Message-Id: <D9VQQAY6G20X.RVU8H169KQL2@nvidia.com>
Subject: Re: [RFC PATCH 1/2] rust: add initial scatterlist bindings
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, <dakr@kernel.org>,
 <lyude@redhat.com>
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
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
 <20250512095544.3334680-2-abdiel.janulgue@gmail.com>
In-Reply-To: <20250512095544.3334680-2-abdiel.janulgue@gmail.com>
X-ClientProxiedBy: TYCPR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:2::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f29e3a-ea4d-466e-30eb-08dd92c16555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2hyTDlxMDc5V1JxZWE5M1U3aDErWmZTQVFLOSsraVZEdkc4Y3U0T2ZTeDVO?=
 =?utf-8?B?c2ZGMkdJd2FrZ2ZKcFpNRk1KN0p2bGtTcUcrZGk5VlpzK0VuVzducEN0THRm?=
 =?utf-8?B?Nks2cTFpdGNNbElzNEtteHJoSGtNbE5ZSEdObzJPaUp5VjhodmFmdXhpNTUr?=
 =?utf-8?B?UDJ2UlBBd2FJNkJ2Nkh4dDdLMmhNb2lLYmJORnFCMjU5bnRKVnRSUXQ1WkNk?=
 =?utf-8?B?KzlOVFlDOXRHbms5a0xJTElIOFFRaGc3N2JGTXRBeFhlcEdTTVhOMDNiaHlt?=
 =?utf-8?B?ajhHMkgrZVhaQlk0azUxaXljbkEyWEM2OXNqRzU1VXZnYUZZOUNqaGJOYU9j?=
 =?utf-8?B?MGRmaHBxdGppYXEwTWlFTlRTTW9oS1VYNkRPZy9zQk1BazIrTmNadE5vem5t?=
 =?utf-8?B?elRheWJCbjFBbnJMWllGWTFNK1dOOG96Y1JXOFp3V1N3SXNTZVVpNHdGS2t5?=
 =?utf-8?B?cDNQeERiSE1EK01yVUhncytBLzZCRHhvRDUzZEN6SURnMWc5K2phbGtUUWNC?=
 =?utf-8?B?YTV1VmhGcjZvQmEwMFI0bnhOZUlzV21jUEo4NnV3NndWZThOTm52bzdGR3My?=
 =?utf-8?B?UVBMTTk1Q2wyQnNnS2dtVzNWVnN5aU5PT1BCMERyZVNHRDREODdoRW9pMDRo?=
 =?utf-8?B?K2ZBTDdlRGdJR0ZYU3ViQzVlKzVEazB6ekFkVXNQaGcxUkJVV2tIL1dQQXRC?=
 =?utf-8?B?cDJMVnlIMEVSUUFuMytZb2hQM0R1Qm51ZGFxNmUyRnM4OUVVZXovNUZDQUVn?=
 =?utf-8?B?Z25WVkRWTnRQcm1PNzZVdkpkUnh3M090bXQ2cGgvRmE4SVFtQzR3VHJveGdz?=
 =?utf-8?B?UDNpTTFGVlpyS0xVWjR5b2RkS1BjWC82SHQrWCttNUoyZ3dsQlEzWGsvUGxw?=
 =?utf-8?B?c05tbUl1TlNvbDFtdFlFYlJvb1U1citXYmx4SFJHU2NIT0hFYnc4VXVWaDRu?=
 =?utf-8?B?Z1VvRjJ4RGlUVmlUSFg5bkN1NG9WQVhEa2kzczlJdzBCN2xKU1N0WEVFRHNO?=
 =?utf-8?B?bm5Mc3Q3czd4YmEvUGJ6cTdKaU1IWHFvNXdzYktiekE0Uk9PdmtvcittNWlv?=
 =?utf-8?B?VHFYUDN1MXFLUlpIMC90Y0ZPT3RTdlNwUGlIWFphTzRYa3RhUWhSMjVVRDF4?=
 =?utf-8?B?SHNvdytRMk9oNkNEdk1UWjRDZW55eHJneTJxZXJkVE1nbEsxTXJzYjBrQnpV?=
 =?utf-8?B?N1d0NEpRQXBnK0NiKzJwcTcrb05RdW1lRVd1SFBYYlhjb2phVStUTmVxUHdT?=
 =?utf-8?B?di9IeWE0NTNhdVRWbTd2eVYzMnk5MVIzRFE4V0JLL3Q0a3Q3eXY3eDRVcmZI?=
 =?utf-8?B?MkN1d0czNEttcXdYN05HNGhFTklFM3EvczB3RFV0MFpuQ0FXdytqRU9QeVNM?=
 =?utf-8?B?K0xLb0tDMFdBUjMyU3VDQWxlUEFyT0ZWeC91RkprVTlDa0VSL252MytDVmky?=
 =?utf-8?B?SEZwU0UrVE9DSnRZZTI2YWVjaTdWVjdvcVQvdWNxaFdRMGpmcWM0S0RHdHJN?=
 =?utf-8?B?RDV4VWlaUUd0bEFNZWpZeDJ2TVMwdzMzdjJGaUtRVUNVTUVOZW1DcDZQTW56?=
 =?utf-8?B?SC83OGFvdFg0U0svZHphREtVSlBwdUxEWUdoWEpRNE1Sak95UnloYXZicXV6?=
 =?utf-8?B?dzUwU3lWTUwzRHVJSElsWDVTV05pNVJsLzNiZ0lnR1FqTTNiaHp4Tlk0TEZC?=
 =?utf-8?B?VXdGRkczUVhBZ2E5YnkrdUN0N0J0enhlNXdUNDhzVmp2eEZzQmNXOTQvSEky?=
 =?utf-8?B?aXdQaEFyQVR1ZGpIRnJNZmJJQlEvWlJIMlBnbWt4M1NqQXRJR0ZVdFhBc0l4?=
 =?utf-8?B?Y0pqMGZYb25FdzhsQTZSUEZLcGE3ZUFrbzRQeWlDNVdJbzJrenlWaDNkU1h3?=
 =?utf-8?B?MFJYUFI4ZXdMVDRCNzRnb2x5K2tRYVYzckpBREFXSXVQTnN3ejB0alhCRmd3?=
 =?utf-8?Q?rP7hWZCx5P0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXlXZjZtQUY3dUk2VmJoZ285QTVlL1FNbGxUS2N4Ti9vMXFndENMZEhGKzc5?=
 =?utf-8?B?ejJ4UnV6Smg2U1pnTGZmV3NsUk9tTVBDTnZnTjJaR1d1RjlrNXpPUHBMeDQz?=
 =?utf-8?B?Y3RVK0hhb291NFd0RDBGNGxxMjc5SitPZ1c0OEtBWGhWa1FrRXhDODZGa0hH?=
 =?utf-8?B?SUREa3V2TmdwNmdIVE5VbUM3ODR6VUxoRytocTBrZG1wTFp5VGUwc3pXMUFh?=
 =?utf-8?B?ZHpZdk9vck1uTGsyYks4cnVZeCtGd2NJWldmUld2V2xsYWg3cDNOSTdnaXNp?=
 =?utf-8?B?VVBsN0MvL1ltM0pRcEpGQmY5cGxLSlIwVENMR3BJaTdLL0dlVzRFUWtxUHZM?=
 =?utf-8?B?WDVFT0pmMFR2bWRzRnJVRWcwcmVaQnRQK1NUM21RT283YnA5N1VJdGM3R21J?=
 =?utf-8?B?dlBzZk9GanhQOTNuRTFQbzJvVktmSnRjWHNUWE5pNmp6MnM1WEtlUEkvQ1RB?=
 =?utf-8?B?SlJQdlp4Zkx2RysvdDV3cHNTaCtzbEhCQjJTdzVOaVpzMXJwYk5iR1VoUDli?=
 =?utf-8?B?ZFkyTzcvVGQwRkp3ZXROMjBDMFNrbzkxYmdvWC9SbFc3SjFvMkhUVWtCQ1pa?=
 =?utf-8?B?MXBOeFRvMHFCSnN0bzU1OFFEcFRIblNRZU9YSmhnOXMzUk9Nc0ZxMCt5NHNr?=
 =?utf-8?B?RUlvR0dyUzFGY1EvdG5xWjZYeENvQ01ldTRIZmlkM290dUhhSXo4UzdLYmhM?=
 =?utf-8?B?NytDUEI3dXpBUHg2SlV2enVNMUFDaEUzbjNjZUtVMTE5Z1JjSVNpRnpaaldw?=
 =?utf-8?B?SnEwcUZpYldHeGZ2eFlkZUxCRlBzbGJEcEdDNStkUTVXMHVzQjZXa2NCUHJv?=
 =?utf-8?B?a3NnamNXY3F2RzBiS25QMTlsUlZnQmgyTVV0VStIRk80NjNMWGtsNDgvbEJ5?=
 =?utf-8?B?V21NWC9NU1NCYzhBMkRRbkRpbDRoTlpITmlnelpIMllMQjBHazJELzI4VTRk?=
 =?utf-8?B?TWlHN0V4aHNBY1BrTnZ3eVExOEdyak1hSERzOS8wR1I3K3lvTi8rZENKRmc4?=
 =?utf-8?B?bytmcGxxeEU2RllWS0YrT1NMdy96ZzFIamk4dmpiSUwvcnNSek80aERFYVJX?=
 =?utf-8?B?RUkxWmw3ZGpyMFZRREJyMFVmalJZcGt6WXNhRkc3d1pHU3U0YWdHallJTGFI?=
 =?utf-8?B?SHFqRGcyTUVOWFhSdFhLazBXcytnRjNtYkdXUkNGR29IMjU1T3JwMVJrSFFY?=
 =?utf-8?B?cU4zd3lsdjNXOEYrSTd0emtjNHhvdGJMM21OWFU4V1I5a1RBV3gzdkkzeTBC?=
 =?utf-8?B?eW5hSHRPYW9qdzFEdHRlczViei9BN1dXQmZxMm9qeCtGNEdMTXZIK0NCZ05o?=
 =?utf-8?B?S3JuVGEwbHUrOEEvWlc2QjhCT3ZSaTVxMjBNMmNCU0pMdlRiOEIvUXhRcW9j?=
 =?utf-8?B?bEdjWXdWSVRZZ29mY3k2NnkwblA0Z1gvUlFhTURTYXRLL3ZxT2tJdm40ZWlk?=
 =?utf-8?B?SXp6b2o1cndOZ2FoZHFuR2pMNHVIeWhkOU5NOGphdmVOZ3V3b3ZJcjArelQ0?=
 =?utf-8?B?V0lQakVYSUVpcVhSaUNCSVJaZUN5WGlodzdWQWdxMS9iTk4rLzFHdkFGZDFw?=
 =?utf-8?B?cFBUUWJwQkJsZUE0SUkrcngzSXc3dE1TREhHblZJZ3BEQXBXdVMyaUd1VkJR?=
 =?utf-8?B?c0hMWjhzUDE1NlRVdERNYjZMYVdrWExLazVlcVo3OFgzOUczYnFEVVUyOWNx?=
 =?utf-8?B?dEJLc3IvRGpiWmc5a0ZCUEVTSHlGZ0htalp1Q2lKaUMzZnlnN0NMYVo0Z20v?=
 =?utf-8?B?ZW01bmRwK0NxWkZzRXBuT01jTWxRcmI0VE0zVTZNRldqSWZsQXdKdVFEVmVV?=
 =?utf-8?B?L1hlL2ZOTGQxVllVNndLeEtqN3JUaUx1a211K0w1MXRXOGM4UWpwL1ZTUVpu?=
 =?utf-8?B?MWkySG5IbFowNnZKR2t1V0s0OVBkbmlaQXVmMlJFQ2Y3cGdJYTRKbldTUHNF?=
 =?utf-8?B?eE5tT2xGTXc5WGZJZVBxWlJNeGUzMHRLYkJEb2swOWxsZmZWR3VqTFU4Z3lT?=
 =?utf-8?B?Rk5BcWJJbEZpSXNQM2FaWk5SdGwxa1BTbzhLZUtCV1BzbFk3WTQ2N0RVR0Fi?=
 =?utf-8?B?WEhMN1NsYXhtYTBBMHhNeXBMN1NOR2F3MjZibXppUVptRzBSNnNjNitIRzRP?=
 =?utf-8?B?d0NMTUYwYWV2WjhLaVpTejNUc0g1QS9Nb1pVT1hDTjhUelZCbUFBM0VFd3ZB?=
 =?utf-8?Q?4vU/uwNM9lZtZXg7h+O40S8Y6EjEMm8xg3wIExO4tdvQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f29e3a-ea4d-466e-30eb-08dd92c16555
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 08:29:09.1788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WycQECJpyDjskzO0AayL8RmbB7+Joh5JRzg3OG5LLf4w72cKaYgIBPeZOSts3RIt7P3MYAP3LWHd7p20goQ59w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069

Hi Adbiel,

On Mon May 12, 2025 at 6:53 PM JST, Abdiel Janulgue wrote:
> Add the rust abstraction for scatterlist. This allows use of the C
> scatterlist within Rust code which the caller can allocate themselves
> or to wrap existing kernel sg_table objects.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/scatterlist.c      |  25 +++
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/scatterlist.rs      | 275 ++++++++++++++++++++++++++++++++
>  5 files changed, 303 insertions(+)
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
> index 000000000000..5ab0826f7c0b
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
> +	return sg_dma_address(sg);

I believe you mean sg_dma_len()?

> +}
>=20
> +
> +void rust_helper_dma_unmap_sgtable(struct device *dev, struct sg_table *=
sgt,
> +				   enum dma_data_direction dir, unsigned long attrs)
> +{
> +	return dma_unmap_sgtable(dev, sgt, dir, attrs);
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index fa852886d4d1..a8d5fcb55388 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -87,6 +87,7 @@
>  pub mod print;
>  pub mod rbtree;
>  pub mod revocable;
> +pub mod scatterlist;
>  pub mod security;
>  pub mod seq_file;
>  pub mod sizes;
> diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
> new file mode 100644
> index 000000000000..122a6f94bf56
> --- /dev/null
> +++ b/rust/kernel/scatterlist.rs
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Scatterlist
> +//!
> +//! C header: [`include/linux/scatterlist.h`](srctree/include/linux/scat=
terlist.h)
> +
> +use crate::{
> +    bindings,
> +    device::Device,
> +    error::{Error, Result},
> +    page::Page,
> +    types::{ARef, Opaque},
> +};
> +use core::ops::{Deref, DerefMut};
> +
> +/// A single scatter-gather entry, representing a span of pages in the d=
evice's DMA address space.
> +///
> +/// # Invariants
> +///
> +/// The `scatterlist` pointer is valid for the lifetime of an SGEntry in=
stance.
> +#[repr(transparent)]
> +pub struct SGEntry(Opaque<bindings::scatterlist>);
> +
> +impl SGEntry {
> +    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the `struct scatterlist` pointed to by =
`ptr` is valid for the lifetime
> +    /// of the returned reference.
> +    pub unsafe fn as_ref<'a>(ptr: *mut bindings::scatterlist) -> &'a Sel=
f {
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
> +    unsafe fn as_mut<'a>(ptr: *mut bindings::scatterlist) -> &'a mut Sel=
f {
> +        // SAFETY: The pointer is valid and guaranteed by the safety req=
uirements of the function.
> +        unsafe { &mut *ptr.cast() }
> +    }
> +
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
> +
> +    /// Set this entry to point at a given page.
> +    pub fn set_page(&mut self, page: &Page, length: u32, offset: u32) {
> +        let c: *mut bindings::scatterlist =3D self.0.get();

You don't need to specify the type here, and no reason to use a
temporary variable, so might as well roll `self.0.get()` into the next
line and make this a one-liner like the other methods.

> +        // SAFETY: according to the `SGEntry` invariant, the scatterlist=
 pointer is valid.
> +        // `Page` invariant also ensure the pointer is valid.
> +        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, offset)=
 };
> +    }
> +
> +    /// Obtain the raw `struct scatterlist *`.
> +    pub fn as_raw(&self) -> *mut bindings::scatterlist {
> +        self.0.get()
> +    }
> +}
> +
> +/// DMA mapping direction.
> +///
> +/// Corresponds to the kernel's [`enum dma_data_direction`].
> +///
> +/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
> +#[derive(Copy, Clone, PartialEq, Eq)]
> +#[repr(u32)]

The bindings were `i32` on my system and this caused a build error...

> +pub enum DmaDataDirection {
> +    /// Direction isn't known.
> +    DmaBidirectional =3D bindings::dma_data_direction_DMA_BIDIRECTIONAL,
> +    /// Data is going from the memory to the device.
> +    DmaToDevice =3D bindings::dma_data_direction_DMA_TO_DEVICE,
> +    /// Data is coming from the device to the memory.
> +    DmaFromDevice =3D bindings::dma_data_direction_DMA_FROM_DEVICE,
> +    /// No direction (used for debugging).
> +    DmaNone =3D bindings::dma_data_direction_DMA_NONE,
> +}
> +
> +/// The base interface for a scatter-gather table of DMA address spans.
> +///
> +/// This structure represents the Rust abstraction for a C `struct sg_ta=
ble`. This implementation
> +/// abstracts the usage of an already existing C `struct sg_table` withi=
n Rust code that we get
> +/// passed from the C side.
> +///
> +/// # Invariants
> +///
> +/// The `sg_table` pointer is valid for the lifetime of an SGTable insta=
nce.
> +#[repr(transparent)]
> +pub struct SGTable(Opaque<bindings::sg_table>);
> +
> +impl SGTable {
> +    /// Convert a raw `struct sg_table *` to a `&'a SGTable`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the `struct sg_table` pointed to by `pt=
r` is initialized and valid for
> +    /// the lifetime of the returned reference.
> +    pub unsafe fn as_ref<'a>(ptr: *mut bindings::sg_table) -> &'a Self {
> +        // SAFETY: Guaranteed by the safety requirements of the function=
.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Obtain the raw `struct sg_table *`.
> +    pub fn as_raw(&self) -> *mut bindings::sg_table {
> +        self.0.get()
> +    }
> +
> +    /// Returns a mutable iterator over the scather-gather table.
> +    pub fn iter_mut(&mut self) -> SGTableIterMut<'_> {
> +        SGTableIterMut {
> +            // SAFETY: dereferenced pointer is valid due to the type inv=
ariants on `SGTable`.
> +            pos: Some(unsafe { SGEntry::as_mut((*self.0.get()).sgl) }),
> +        }
> +    }
> +
> +    /// Returns an iterator over the scather-gather table.
> +    pub fn iter(&self) -> SGTableIter<'_> {
> +        SGTableIter {
> +            // SAFETY: dereferenced pointer is valid due to the type inv=
ariants on `SGTable`.
> +            pos: Some(unsafe { SGEntry::as_ref((*self.0.get()).sgl) }),
> +        }
> +    }

I think Jason mentioned this already, but you should really have two
iterators, one for the CPU side and one for the device side. The two
lists are not even guaranteed to be the same size IIUC, so having both
lists in the same iterator is a receipe for confusion and bugs.

I have an (absolutely awful) implementation of that if you want to take
a look:

https://github.com/Gnurou/linux/blob/nova-gsp/drivers/gpu/nova-core/firmwar=
e/radix3.rs#L200

It's probably wrong in many places, and I just wrote it as a temporary
alternative until this series lands, but please steal any idea that you
think is reusable.

There is also the fact that SG tables are not always necessarily mapped
on the device side, so we would have to handle that as well, e.g.
through a typestate or maybe by just returning a dedicated error in that
case.

