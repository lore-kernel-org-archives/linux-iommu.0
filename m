Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D613A265298
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622846; cv=fail; b=kFCYsFECQYSw2Kk8vblKly+Wrn/sq1TAzEjPvbqp/evxDNqXIbAGg9cteCyN7yOgy1rtOO6N++NE7c2Efgs21PkRGbQkoqXecvbREB6G+JWn6vpA+WnbxvTyGe22MlL2bG5M2uTatmZNTejEDVG3wgbg5Ffwbox0POc1ufa58Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622846; c=relaxed/simple;
	bh=3f3yQiuWs0OB08YV8tmuiTXkBzRsvFgvptELvF9fuHo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EFx3ayjZKV8/0jBxDqg9LNFnW53wCmyXsOzlfQtaytBkdpvYlSR5uTXS+w1u3G4BYIyrC/YISVrrXqenVLm5Zi8mCGIqLkykFFTqrPImqHCWyGjrfqQCGMjc8sudvMXsyISSULW0l6xnUndNRD6amaNw5+T06Fu+8p9cFkch4h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FcDP0G7b; arc=fail smtp.client-ip=40.93.198.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FcDP0G7b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1DXVVQjCUHeaQ4aVHCtNuUyRMHYsmFa4dFs2/NHIyLtvl3lhFOXX+j1ptYZMN3MGVGU49epMR8sAs01OHFEEeAM76RfnRK26IwFSjuAYxDqGf14RSy7sIBRJPQe4BOCcpgodY+2cqrvxys9Xqmpa5d9Rzk/CzlXDrsAfp4gCrrGEiaOnRkTvkJuHSysb07HuM1irnqsFjW/xTEK73KkVFXU0EeaIwkDtgwYAUGKBkdUpMmXaqsDXMMrxolNMFMI4g1g0x3MB0wK4mU5FzQajSZJHeNCR1YDfARXIw9aOG/qeRv9moyAf9fv6U8a26gKAXwlvBRqxg/GPv3ntdy4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zh3J0+oevAWAZaSg3VP73AL33hnnlqY0xXPkC+ogiww=;
 b=GAz6Xkc3rExxDat41LFVdSXAxcW3XRUPPDfrY9oh0eWpY/6NjEAALuizlJEY/GA7ig990wtBIRAsgjKe4MQtytutH8QNnG9UiecG/EoyelPJ5+F+S0UJjx0pbedquFi6R6qWXLYGSKVc7+u8jeuh4yhk1fmB7NZhviHe0NJ9TFZAkFF7zI6lC0Oox18X0DV36GCNaoA/lfdkqih1cZxjwUdfAm8xBGfMDkMZWWgmA41r6rw+TpSX0pY5Q/kYjyFV7oeKBBFZvpyF3gygruUO9CHgXXpI5MunAwiXxn9uWZ2C1LqjV9TqTmv9ZmuxYrgTI10fnVfh1iPVQaTsLMc7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh3J0+oevAWAZaSg3VP73AL33hnnlqY0xXPkC+ogiww=;
 b=FcDP0G7bt3J5QxQi0PyIKXh/0cv1qPFi1WMcojGbqNRV7U3k4KTTZv3sKkSalZikeIHNw5ZVjNFmoJ80Yyylsgr0gOVtDzs0IqffxrLLtj7Zlzq4DZyNFFWwQLz3RlZuyK3M40ADs6CxY9o0kPgLeFozQfp99xR1IYNZQxOJrQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Sat, 8 Nov
 2025 17:27:22 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 17:27:22 +0000
Message-ID: <0b7c5fc4-04d5-4c14-a575-e0b18c2d35a0@amd.com>
Date: Sat, 8 Nov 2025 22:57:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/16] iommu/amd: Make amd_iommu_device_flush_dte()
 non-static
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, jgg@nvidia.com,
 nicolinc@nvidia.com
Cc: linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
 joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 iommu@lists.linux.dev, santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
 jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
 wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-5-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251021014324.5837-5-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::26) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b201ae-5799-4779-f482-08de1eec134f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlNoRmh3K1lMdVp5TzhSc2V5c1hJK2VNRk9YdUJqS01xTk55LzB3UjZHSncz?=
 =?utf-8?B?cUtvU0RMYWdGTmwzZk9JSDFoRHVHaDZFa0Z6U0F1Y0h0OVk2b252Y1N3MkpV?=
 =?utf-8?B?eVk2bTdhRG83K3lPK21GRkJyanQvUVQxcTNRSWhMTTBnd0RIckNpZG1rK1lR?=
 =?utf-8?B?aGwvZWkxWkcyVm50bGNjaTR2YlJKMnVxL3FFdFVkQTR4RTBQWkR5V2VpaW1Z?=
 =?utf-8?B?ZmhMNHVoWmRuaVV5Q2laVFUvZENhV3hZZExMcjAzdE9XSzQzL2F3bmxlYmdE?=
 =?utf-8?B?ZU9nN2pTN2p4SXRXMnFldHR4R2NxZm5PQWpuZE5CdWNwZnVqbGFIRnVTRUdP?=
 =?utf-8?B?Y21laHlSclNWbU1kNytGL0dLQnlwNWQ1RWQzZUQwcXpOS09NQksvUVZMcnlC?=
 =?utf-8?B?aGxxVzBvMHVueFVCOXFxTXQyRnRDMlcvMlkxOTMvQTY4RzMvbExNb2JxU2xl?=
 =?utf-8?B?UmRHWDRyY3pqcTkwMytDR0JUSWkrQXp1eENMMEI0ZlYxYXJiaEZZSkJJczV1?=
 =?utf-8?B?RjVTNlRDZUJTQjZUOEc0SlBLRVVockRLZjhRQm5aQ0QxemdMcndnY1BtbmJE?=
 =?utf-8?B?d095Slh4VUphZ2czbzNHY3ZZTC9XUzlNdlpkYlFLMENubHVKYktHZDFIMGRH?=
 =?utf-8?B?anR5Wjl5cGZCd2dPbUdCTGdTRWdwZUlTZHBmZUZ0aHlLVkMwc0Q4N1QzQWE0?=
 =?utf-8?B?VllJUFRKbnlOaDA4cGhuVDE0QWpRWFJtWFAxU1BHdlk0ZnltVjBuMDE5TDVm?=
 =?utf-8?B?L3J0bGJoRnBPUXlqbFhySDhGKzUyNDlXSXlKQWwvcHVKaXFpbzdCazQzM3Y1?=
 =?utf-8?B?RWQ1aEs3akxhTTM2TnFjdDdGQTM0WkpLb3krYkQ3UU8zVVBuaHFXWmo4Unpw?=
 =?utf-8?B?TzA3SHlGQXRLbmExL2RpMGJzeGxDL2dqUmxTRGE4YXpFZUs4RGMwNUpIQ3Mr?=
 =?utf-8?B?NnlnTXhQQ0kxS04wTU5tcGdjeDFSU1ErRzFSbm1IcWFmSldMdHEwUG1MdEZr?=
 =?utf-8?B?T3RXTnNqYlZHaWFJcWRUMTdIbVM3Mk9PeDVHWHQzdjlaeHJhcFVESEFNS3E0?=
 =?utf-8?B?UmxiWmVmckJvRlFObWowYkRKRzA3UWtoZUNHdFJhL0w3T2ErSDJSRkdwcmZH?=
 =?utf-8?B?R0RoYW56cWxNdVpwbGc4bUI1U2FxT2Zpb1ZPSkRBUWxEaVg3cTlVRlEvNFVI?=
 =?utf-8?B?UXpuZytaYjBPeWNGUVo2U0loNFZYQ3JIUitzcGMzdEJJVW5ib2FKRWQzSHZL?=
 =?utf-8?B?ZkdqSVorazc2cVh1ZWpxaUs5M1RKd0tPeDR5WFR6TTYyek9FZCtKY250NHNn?=
 =?utf-8?B?WWhSQmE0V3l6ai9BVEs2cVRYcnh4S01Ha2pBS0J0M3lMS3l5dXk4UkNaWVJM?=
 =?utf-8?B?QkkrVmgxL2R1ODZDRlRrOExoalg1NEpVcjRvcHpRQTFhYTNWNTlBa3hhTk1z?=
 =?utf-8?B?V1ZYSFhVOFYxSnV6SjVrdlE3Qkc5V0loYi9zb2ZlVHIrWmd0bG9LK3YvOGRU?=
 =?utf-8?B?NlZOYUIzUTRJNlBvRXI1TnVBQzFOaEtKMGs4Zi9BOTkwNGljejRCZmhoMFFs?=
 =?utf-8?B?djdpRm9ZQUJPR3BZSmxzZ0hDZTlmMkMrL1Z4K1h2bi9oRVB6MllaaENEWmty?=
 =?utf-8?B?VktYNkhhb2tVRTlNTGMwWTV6Vm1vazViTHJxNzc5NmFzaHVlU3FacFd0TE1M?=
 =?utf-8?B?cE5pOG9Id0NVblFJOWttSlRGajZsNy91UjZFYjFPMkZzOGxIWDBJeUpXVDNQ?=
 =?utf-8?B?WmpndXhzWVpGMnFHUms0dm5nNGxGSmZZZHVuQlB5Q25uVHhURU5BWnNSU1ox?=
 =?utf-8?B?Wk01MUVBbWIvOUpYY1ZEbWhIQ2R2ekxkVWZTaXN5S2JiT2MwR29DNHQ0Tjd2?=
 =?utf-8?B?UkZFVTVHWVZ5V0dYa29sNEQwK01RWmdPMVI5NmVRcnBqYWREeXlZeWhwUUdj?=
 =?utf-8?Q?C452BLJuQ42RNyVb1L0kqM4CUEhXI98x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVU3WCtsRFY4UHZoWUUxa2NLUkgwSlV3MnpPYndWZlJIaTV5RDZuSkdNK3Zy?=
 =?utf-8?B?czdlVUY4cUR5cmk4Q1ZVTUtCblczeWgya2dNODJPKzhNMmNqVGg1Y1J4ODRR?=
 =?utf-8?B?Qy9qU0VNbmxmTzZkTUltTWlMUmVwcFZOb21ZczlsTWtwZ0JZRURDTzFSSnVs?=
 =?utf-8?B?L2FHZEpPclMvblhUcFphUHAxMVNzWUhtZHNYLzRPL000Qmo3MnN2Mk52TEdQ?=
 =?utf-8?B?U21GSzdiaHpTN1Z0d3JrVEM4dTVBV3l4QkJSRDM0NHBBSVI4cXBaSjJVVWlu?=
 =?utf-8?B?WWhNQWwxZGJ5Um5ibEY2bHhJMTQxSGloWWlYZmx5UFhqMmp4Z0lWYkdxNXFQ?=
 =?utf-8?B?UndVeWE2akhDYU1EaDEwT2RDN2lPeER2NWp5d2c5ZzlnaytSTXdIRXliaEtz?=
 =?utf-8?B?aEVoaC9lQVRkTDE5c09nL0pkZUZiWFBuOTZuajRaSzNVYVQ5MUhwRnRvRGZx?=
 =?utf-8?B?NFc4T3h1VDkvRnV6cFIwanNSWVVLOVJ0NUZ3R1MxY1JHOWYvQXY3bnN1aHVo?=
 =?utf-8?B?TnNDVW5SZWErSEFNTE9US3czaFpOQkNYa2ZGTG1GSVc4dFpGUE82RzNxMVV4?=
 =?utf-8?B?Kzl0bWc5UHNHb0RPZnM1TEpRMkt1VFJoMlNFS0xWdkUwdDZ0YnM0TE5odGFr?=
 =?utf-8?B?QUVMK1NRYy85SnpVVWc3aUpaYlZ6cm5MTkNxUHZqa3FDSEVQOTgxeVlsK2RH?=
 =?utf-8?B?V1RYQ1liNi8weU1sR3JTdlN6eU5icTJCZ0dtTHNLQUNpT0x1RHVrTmhjTEZJ?=
 =?utf-8?B?dDY4U3ZRb3piMExyQWlnRUlXdEk1MUVMNitRN2ZLV2w2R0w4dGtVbGRWeFhJ?=
 =?utf-8?B?YitEcEpDQlVMMjIrbGI5Mkx5NysrVzUxYmMwY215d25IY1A0M1JISGRTTkpB?=
 =?utf-8?B?S1UyYVFHNi9BUHBoU1hmM3liVFpEYXVUYmNpS05iQ2hmeTJla0JZdXZvUzZl?=
 =?utf-8?B?VUY0SzNvSWZ6Wnl1alZjVlFPaEhNa1QxYnJWbXZpQU1KRzZUWDAyUlRScDEv?=
 =?utf-8?B?cSs0d250L05vQmtNMU4xNC9wMXVkUlo5bmxGVnpKVFU4QUJsbHBQK0o3TWxq?=
 =?utf-8?B?OHc3ZEZTbTk5V1JWVStsM2VRZXJhNzB3ZEYzcENlRC9EbGNrRVc3ZE81Y09a?=
 =?utf-8?B?bk9CTE5WWE9Fb0tXelVpV0t0d3NkTHNScEdydVZwQnZIaWdpUVhGdkUvaW9H?=
 =?utf-8?B?aUhzbGVUZ1F5QW5hVWFORGNucThrMTkydHlYNW1qMEo0VnJYMGphclBEVUFx?=
 =?utf-8?B?RmhDQ2Z5QStXQXBxaktZUWNuRUdxaytmQ3FsNndEWkJ1bS9zZUM4dWxNUGMz?=
 =?utf-8?B?NlZtRHVTZlNDcFhOM1hya0Q5V2k2eWY4c3IrNmNlQm5BRmtGT0d1cGI2cWdw?=
 =?utf-8?B?RCtSa1hDMkpSNUIzYXdaeFVOMEdlRmFYNEEyczVqampFWWxXRWRlcTI3ekdG?=
 =?utf-8?B?U2VjUk5yczBDdC9zZE5abnBhMWd5Mm5zcGtnN2p5WWg0M25oMHpvZ09pTGNx?=
 =?utf-8?B?cGwxS3JPSjQ2QUN6M0Y2MkdjTVhQOS9PUktDa1haNEhOZlZiOWJ3NGhhNyt1?=
 =?utf-8?B?MTFYb0FrSjY4dmNhWGxJa2pHN0VtajQ1SEhWYVhDcWdWU1dnSW5INTdub1RC?=
 =?utf-8?B?cUE4SEVBSFk0VldPM2U3WnlvaURlUUZWR2J4dzlJaThPWklBTlJVVEJUMmgv?=
 =?utf-8?B?VFFKcHNPUVNpVE9JSlRMbnBQNmhhRGJCRE4rakJxM0o4RzFoQ1lLenRQbE50?=
 =?utf-8?B?U3ZBbnhjb05LcGtLZUhhNCszYURwam5uRDg1L2c2b21oaUZpdkZqRVg1R0xQ?=
 =?utf-8?B?dEhoMWpjb1o3clNWdXVBWTBLaVRWaUw4N0pLRjUwb2NKT0NBWW5vQVliZHdU?=
 =?utf-8?B?LzcyWmxkOC93aVpLZG5xR1hQWFRoN1lmS1Flb2VVVmRHWTZqRzBIaHFuSUFC?=
 =?utf-8?B?bzAyYmdYVG9lVHE1L1AyZE92dTJ2ZFBFdHRxd2lER2JoekxUcmZuT2tiWUFD?=
 =?utf-8?B?WkppRTZIQzl3TFlpZVpXNk1SRWhGdkk1ell4TnM2bUwzTHR0VkRjNVRoeUc2?=
 =?utf-8?B?dXpZd2YrNE54QUZQMVA3WFFZWU5qU0hpbmU1Z0MwSDYxSS9KOXdyYlhUdG1n?=
 =?utf-8?Q?o1sNYpzpn7npoPo5rFdg/KbTV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b201ae-5799-4779-f482-08de1eec134f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:27:22.2169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZXjlgqt8shkDtjjezvLQd7ozKeSkcHoyWbVhe7PCJeBhnj1lKSerboAqKlCyvLr+FnXigxZ3StuppjgcveXGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992



On 10/21/2025 7:13 AM, Suravee Suthikulpanit wrote:
> This will be reused in a new iommufd.c file for nested translation.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant



