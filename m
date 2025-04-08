Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008188462
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 03:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081738; cv=fail; b=eD0aud8AJFrO9sM9MQNzU3HRh3jtzX6KXWMjFVfJvlHfX4FEXj/rDUiBKHHjOeKfzieKhy1VMMal1pGKHNy5Zvh4bHXq36PJDO6xUdET8wLZkoDm306hCeid8vvfWX252QEYe+rONEPNN0q1sjCvLAxRomi+tD4t3rZMMCsiXLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081738; c=relaxed/simple;
	bh=9epIaHHQK8o6xLQqKwNqVSnzZZoZ860wB9KRjeQFiyE=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=TJ90i0FJ2TLKIwNiumzqe/rBRyJwLSctsJU7mWvYh8uQILeEuv1yYJhYPu9Yyz/IurPAw42aY2JDJxhaCP9Vr5oAwA4yJV3f8aJAhXdmTecZHH9zXHn9gKo3IZ/6hBSeFzptpxNMexEuJwL7DgJFUAIv4A3ztJKB4qiNj1p7XJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MonFW/qQ; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MonFW/qQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvjcNenitswRaTjfCaWHQ8kfrDQy6hImPMo53XINtTY+FrCxzH/lHeqE42jLHjcyqsMkEApQjJiz15fbc8H/R1ZdeaZ7+H7cizidokVttYv5wjzDfBY0cxw5IGLuiB2UDTwznxie6m/Ak9sOgR8yzisjuIOpHuRcMgTuSvj7WxkWhQHXGVInOqW/CUNbWh2N/4Px+lqIPzE0bJNXVbxqLvBvovrz6i0ycNfwR7mlS3DeADlzzoeyBluTAOntlPARRMXW1DJ3O+7ZLFy6wONQJVSscngmMUDlAcOeYZYyaFmT2MQnFDCMl3ZjGQHdD4w85oZFH5CFbqPCMmDkBsrxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZKKTRRF54mKXbKEV/KV8MFAD/i8fH+HycaO6HC1MSg=;
 b=SyhAJQJ8fiuxyoh3jmnurhRimn3Xr8P2coR1qP6kUkhfes5PXypvDT0MhlFYvVOIGbhCRxjCW7aVYeTytWW3uuFqxO9q5sbctUHH1TI5URnMEiyi0dXTZSirJ0f5yUyrTyVnAkjMSEhoe0PJGmmVeKIWBwhghq+uMDMzXyes2PjYLJDn3KPyDqc/pYJCr8YLt+HnFu3Pv4gu/pEIoPjDBWA7fVgs24c7xsylWodFVI1MPCFEuxIywOCYq0FiMJGgPA67TmwPAGsrGB75bczX+R5BeXxRclVFz10OCBIi1Vhn66qoMtPo1ncC0eIDfH+Yzct2mJHO9gj2qqBVhdgx2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZKKTRRF54mKXbKEV/KV8MFAD/i8fH+HycaO6HC1MSg=;
 b=MonFW/qQIgOaFpoasjakN+nM0TsklE1e7Bfq4/urXY/mYQmHc8+ddOT3ehnRxbnjyxGZcQZrSkI8pJ+9knPUTzASg5xE2mj3LVjpLrKK2c2H4fVrjhRAR6yAagvAu5nJCVkncONOHC2/Bpvnl8gRmpl8WhXZnaNbHdqHWWDyczOQMBy7vIdw77yZlqiXh7jG46WJUSMLcimvSwZoMYon1xou8S4oWgxAA29l1bif5u+/n79b5ZD/uBTUU4jnie5mxReQwgsy9qkPZ+iUBemRumEcJKgwBiADztf7g/9M5eqyxKFIYilGInUpJQ6P3ZxSLgkTCxNxhaR0u9ltw4WPtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Tue, 8 Apr
 2025 03:08:53 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316%6]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 03:08:53 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Apr 2025 12:08:49 +0900
Message-Id: <D90XDHJWABTC.1VM2A3KYOT0UL@nvidia.com>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, <a.hindborg@kernel.org>,
 <ojeda@kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "open
 list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]"
 <rust-for-linux@vger.kernel.org>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] rust: dma: add as_slice/write functions for
 CoherentAllocation
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
 <20250326201230.3193329-4-abdiel.janulgue@gmail.com>
In-Reply-To: <20250326201230.3193329-4-abdiel.janulgue@gmail.com>
X-ClientProxiedBy: OS7PR01CA0191.jpnprd01.prod.outlook.com
 (2603:1096:604:250::10) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 795f83b3-2eee-4c8f-bc83-08dd764ab13f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnBTZkdSa3g0dndrTmpZSkxqVkU3M3VTalVIZ2dHODZNUjBOLzhjUjdpdU1V?=
 =?utf-8?B?ZThCSXlSZE40TEx3cEp5SVI0TUczcjdHNXpnZ2YzVDBKUVdqUlhrSUxGaFVK?=
 =?utf-8?B?L3FRTlZmMG9DU0wxWW1wNTUvYVpkSjFsMUhmZURuTFNlcFVnMlVzbThYYkdE?=
 =?utf-8?B?eGFuOUg3UGZQT0VibnVvb09aM2NVRjRtNytDcUkrVTUyNzhSQWgxbzFzRUVW?=
 =?utf-8?B?dW5pcTliL1NCODE1MXFDdVQ1aTQ2d1NJTkNkdlJKeHc0QU1VK1lBVVh5em5O?=
 =?utf-8?B?Q1oyd2FRd1dSNDNReFZzbUhIVDVoUFRXV1Zka3JaZEMzZHRQVGlhU1pzQ29l?=
 =?utf-8?B?emZZRUFOT1h2clJlYlJIclY0QjNqZzhQZWZEekxRMDZJcDJGK1orblN3dFl5?=
 =?utf-8?B?aURkek1hN1pQSWVDaGZmc1BQVHVRaWl3MWVhMmNyL1FJZEtwdWs2TFYycmlS?=
 =?utf-8?B?UmtqSnF1c3YyNk9kWXlza09VUUEyVkdVeFN0Z1NjcDZBREViUmdsZzVOK2Rj?=
 =?utf-8?B?ZFhva0I0M1g0MHNHcnJLM01TRlRBNDg1NjhnSVJTaXZOT2Zaa21aeUZYc3lk?=
 =?utf-8?B?ZmNSa2ZMVHJvdUpNYmZwcXBWbDlJbWI4dUM0cmp2ZTRyNTc0NlRsVTlwblBo?=
 =?utf-8?B?TlJ1cUxDNFd6dzYzZEtjUWVuMXhNWWpOcm45NnM5bjFJQUpGdnRoYmR0NnBN?=
 =?utf-8?B?dzZGcnJRc1g4VjQ0ekdGVjgycmlZYjh0dXEvcUMrb3ZrYWNuU2d0cXdZQmlT?=
 =?utf-8?B?RjliQVZjNlRUMGxnNzc1dndteENKeHl2cHhpbHBzMXk1RnhJSEErYkpncnk0?=
 =?utf-8?B?RDdVbGNsQXNLMDhkemdHdWRkNEU3K2x1VkR6aFlHUE5NUEprRHh6WVhRWlQr?=
 =?utf-8?B?UlM0UlhnZS96UWRsSWhkMEgyRWp1WlY3dFMybWNrQXVUR1BWdlJnYkFqTjlI?=
 =?utf-8?B?eDQ4KytOMVBoUXF4eFlES1c0OVY0ODI4ZkFMRm1PNGRoVk1jMVIzOHpXcWxN?=
 =?utf-8?B?L2FkRGR2UHdXcDAvYWdMemN5bUZsaFdpRkF5a1BuVmJKNXYzdExlNDNReFFx?=
 =?utf-8?B?eHY1RS9Gb0l3QUVrRHVGT0RDRDhBQVIzOEVMSWtwT1A4VkM2ZzZLYUpRMHF5?=
 =?utf-8?B?aStzNnY2Sk15RENYa2hVc1psZ0FLN3pUeVM4U3VmcmRFN2hYSUc1b1p0Wm9Y?=
 =?utf-8?B?RmxCZjlvUjVpbjdwaEJYb2x5ZFR4aEM4VmxHc092V0lWUkorNG5JOXVPNXBv?=
 =?utf-8?B?V3ArQnI0MHpnSENKTERBU2JNNDg5bDNpRHdkSG1md1NKN25uWlVycEc5R2dW?=
 =?utf-8?B?Ni9DS0svdk1Xa3pNejdkZlBLNFdScFZ1UFh6THZkSGVuSXg2YlNubnZjSVo0?=
 =?utf-8?B?d1VxdmRlUFN1TzZPMDF2QmR5cWZmaG1ZQzQrVWZYUlFTa09EU0xKNWRwSTli?=
 =?utf-8?B?WmdlSEt4aEVGUjd1WVhGZDMrK2RQbHVxQkZVZURvdjhFeU53U1BVQlZKMmpP?=
 =?utf-8?B?enFKSmNRbWpJajVKN0FNSWNNaVBwSHNUa1Q5bWNyd2taeWNJWmYrZE9MVmFp?=
 =?utf-8?B?RGlIUTVXUGhra1lHQUFCTUxOWUVRb1FRcTRoQ0tvdFIzbklvQVRNdDd2blpx?=
 =?utf-8?B?N1hZL2ZXOXNlaTNhWFVHRlhKRGQzK3J2TG9RNUgrU2czVFZ3TmtRODhwY1lS?=
 =?utf-8?B?ems0U0Z3WHFhcERKcy81MjV0MHVYMHd3UE10YmhObHltdmErdTNyaHBvRnNH?=
 =?utf-8?B?SE5LSUxaMmR2dmpOMnRmbEl5eGVlUkRGYXFlYWFhZ1NwTTdhcmdndUtPSHdP?=
 =?utf-8?B?ZU9RSnZlbzhnOWdYalhjUjF6bzlSVVdZOE5ZT2sraGhEaHovcTRJTGk3NGRG?=
 =?utf-8?Q?1jbUzLnwJ/H7C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjJGSmR0bUljc3lDUWt0TWZqRnZyNG55UUliaWJieUlUNWIrU2R6TjRla1hD?=
 =?utf-8?B?MGcyZTg3dFVkUXQrSEFHdWJiNmdJa1N0QmJwTmhuUXNFQTRKbVpoa20yN2Fv?=
 =?utf-8?B?dTQyNHY0cUJMVXVQenp1WkJYZ1VUWHp0VmxkTDBIR3ZlK244dnZ6MXFJMXYx?=
 =?utf-8?B?OGVEKzlySGYzNStRK09BamF3NFFibU5TMWxpM0RsaEdWdXhBUHhwbEpEU3NV?=
 =?utf-8?B?d3dXaktPbXBqTTlRM3JpSW9yOStINUw2ellpUWpHUWZMNk50cUtOK05ablJO?=
 =?utf-8?B?MHJ6dWphV2xpa2xwSDRjTlFEYWFQTlNIM2xHdmY1TGxQdzVkdGZRQkdSakU3?=
 =?utf-8?B?aGVYRlBhUUNaalVLL2RjVFFybG1xUk9mYUJCNFFxVGFrejNMSHVDUXNxaTRF?=
 =?utf-8?B?WUVHcHZVRkg5UlhWMEZBZHMycWJKOUI5N0VRaXVCcVdlSHgxWlM4eXRiUzNE?=
 =?utf-8?B?NHFkNmF5Nm5HZ25ub3dMaWZlVjZWUU0xWXVrc3NvS1UzREJQOExqWTF2SGhk?=
 =?utf-8?B?KzZ4aG1SRWdnWnI0aGI1cHdQOTY1cmVMaU9SaDB0MXNIRWFSVyt3ek1PUjhv?=
 =?utf-8?B?VkJtMXR0a21TTGFrWk01aXN6alpINUhodzFXV0ZiZExQWFY0cGpOVW9kZ2Ux?=
 =?utf-8?B?QXBQb2hvTStyTVhtbWJXWHhkajJDTHZRcXArRWYvZ1JzNG1SYzk3ZXVoNGFv?=
 =?utf-8?B?dWpJekZuWGJSRjhsd0RNMzgvRjlxWDI2OUxvS1FCNGp3SDc0R2NDZithMGFn?=
 =?utf-8?B?TzM2djl3OGtkbEtDZU9ISXhmVUx0VTBWbDRXc1dDZDB2ZWs4d0tPQ1NrRTJQ?=
 =?utf-8?B?WHdHNHdmQmp2TXhIL1FEVnRXVHpWdWFoSGtWVm15RS9ucXV5Y0tSeEtoSTE5?=
 =?utf-8?B?VEdOZUhKQ2w4WDhSbmNyOHhsTis2V3laaWt4Q2tJZFFIblVsb1RFc3Q2Nm5r?=
 =?utf-8?B?T2VpVVpKTkFkSHZOQWh6TXV5UEE5d1VaL3l0WkJzdGpkd0duaDRqRzBlYkJx?=
 =?utf-8?B?a3hBUktvVU9OR3Jvd05ubEdKTGxsNjR5QVlEdEppaG5xYlRQdWtyUHJnalhk?=
 =?utf-8?B?SytkTWRGcExVMjdab2JRYjlXd3NodUxkTHRVVUZsalNVMjU4Yy9pdjVPR1hF?=
 =?utf-8?B?cHB4Y3FhRk4rVGNMeHQzSFB3Y0pxMXNKSTRpSjZWVVR0ZHkrSk5kUHZxRDdL?=
 =?utf-8?B?SjdVbi9QQ0tSNWVJSUNSSE8xRy9DN0NyRW5OQ0tvK1c3WmFIVGZ1L0VSaWlZ?=
 =?utf-8?B?Ni9QengzWGtOeU9TQk96WEYwaG4wbEZCRnN0bVFBYm9sdjdUNVU4OUdOL1cv?=
 =?utf-8?B?ZGpLSnpzTHVuOHV1UzVvOTNNUUxmNFhFSlE0ZG9ORk5PbTJPckxKNVJkcWVX?=
 =?utf-8?B?REJjVDZRUjhkV0hUWmQrdXgxeGJiNW1DUURqajVGQUpVSE9PWnBmWlU1cnJJ?=
 =?utf-8?B?c04zZ1Y5OGMweml1Ym8zQjRFQ09kZ2F1aVFwT2lneE5IR2lodXo4bWZEcUFx?=
 =?utf-8?B?cW8yM3dPRkczczJoWmM0YmlHUUl4SVlNZXJ3eTduWFVjUDlqeDc2YmlUNGFV?=
 =?utf-8?B?U0FIY2ExeUc5S0xjQnhZVnFUYlB1ZW9lLzRxZXFBT1h5SHdqVkNDUUxLSWNm?=
 =?utf-8?B?S2ExbVBmd00wbmJVOSszZU5aSkNGYlJqbnJhVEFHNnd6dWh5eDl5QkZkNm4r?=
 =?utf-8?B?MC9hUjBRNVpEMTN5WFA5UnJXL2F4UHV1cC8yMUhKeWFHajliVmtpSERyQ01G?=
 =?utf-8?B?cE5BTUFGcHIxWDROaWNlczNHR0l5Z1R6Z3F6ZEVncTU4NndEZ1djQ3NodDg3?=
 =?utf-8?B?SHFCek8xaisxSE4zN1Q0RWNPQ0U0d25HYlJ0Z0EvcFY4QUp5OG1zKzhkM2ZE?=
 =?utf-8?B?U0xUMVREQWlDWm9Xa3lxSHZBVUU0bExhSkl6bmYwRGphZzgzaUFxbzFQUGcw?=
 =?utf-8?B?NnNFN1N4RHhhd1AzYTEzeDlxU0RkMHZnK2p6N2xCZW95S0JXTThtbGY4aHc2?=
 =?utf-8?B?Q1VHYzBYbE9DbUNwOHptb1pZNnlnd0FHamFOK2RRcGRYZjRBV0FXUzZUZzlo?=
 =?utf-8?B?U1kvemFxRmpqb2pPeVpEOGRuTmw0TGltNWNyYWVLcnhucDJIZE50SGpJaFNp?=
 =?utf-8?B?dThxaEVXcHJkaTF0a2lsbXlBa0o0emVETERQZG5GcG9WekFlcjlYc2kyZXhM?=
 =?utf-8?Q?cnymGL/Ra9+R2YETrH6HE5b7cSF+8I5y02y5GDI3QdaA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795f83b3-2eee-4c8f-bc83-08dd764ab13f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 03:08:53.2953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxIOGyOAJplypZb/HPmGPjAjG9mjXQBd0o55BtdUuwZuT6lxt7Ef4vJq0e7GGDSIlpAAfco4g7Alxd2BOtomDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443

Hi Abdiel,

On Thu Mar 27, 2025 at 5:11 AM JST, Abdiel Janulgue wrote:
> Add unsafe accessors for the region for reading or writing large
> blocks of data.
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  rust/kernel/dma.rs | 87 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 24a6f10370c4..24025ec602ff 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -218,6 +218,93 @@ pub fn dma_handle(&self) -> bindings::dma_addr_t {
>          self.dma_handle
>      }
> =20
> +    /// Returns the data from the region starting from `offset` as a sli=
ce.
> +    /// `offset` and `count` are in units of `T`, not the number of byte=
s.
> +    ///
> +    /// Due to the safety requirements of slice, the caller should consi=
der that the region could
> +    /// be modified by the device at anytime. For ringbuffer type of r/w=
 access or use-cases where
> +    /// the pointer to the live data is needed, `start_ptr()` or `start_=
ptr_mut()` could be
> +    /// used instead.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that no hardware operations that involve t=
he buffer are currently
> +    ///   taking place while the returned slice is live.
> +    /// * Callers must ensure that this call does not race with a write =
to the same region while
> +    ///   while the returned slice is live.
> +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result=
<&[T]> {
> +        let end =3D offset.checked_add(count).ok_or(EOVERFLOW)?;
> +        if end >=3D self.count {

IIUC this should be `if end > self.count`.

> +            return Err(EINVAL);
> +        }
> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllo=
cation`,
> +        // we've just checked that the range and index is within bounds.=
 The immutability of the
> +        // of data is also guaranteed by the safety requirements of the =
function.
> +        // - `offset` can't overflow since it is smaller than `self.coun=
t` and we've checked
> +        // that `self.count` won't overflow early in the constructor.
> +        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.add(offset=
), count) })
> +    }
> +
> +    /// Performs the same functionality as [`CoherentAllocation::as_slic=
e`], except that a mutable
> +    /// slice is returned.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that no hardware operations that involve t=
he buffer are currently
> +    ///   taking place while the returned slice is live.
> +    /// * Callers must ensure that this call does not race with a read o=
r write to the same region
> +    ///   while the returned slice is live.
> +    pub unsafe fn as_slice_mut(&self, offset: usize, count: usize) -> Re=
sult<&mut [T]> {
> +        let end =3D offset.checked_add(count).ok_or(EOVERFLOW)?;
> +        if end >=3D self.count {

Ditto.

> +            return Err(EINVAL);
> +        }
> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllo=
cation`,
> +        // we've just checked that the range and index is within bounds.=
 The immutability of the
> +        // of data is also guaranteed by the safety requirements of the =
function.
> +        // - `offset` can't overflow since it is smaller than `self.coun=
t` and we've checked
> +        // that `self.count` won't overflow early in the constructor.
> +        Ok(unsafe { core::slice::from_raw_parts_mut(self.cpu_addr.add(of=
fset), count) })
> +    }
> +
> +    /// Writes data to the region starting from `offset`. `offset` is in=
 units of `T`, not the
> +    /// number of bytes.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that no hardware operations that involve t=
he buffer overlaps with
> +    ///   this write.
> +    /// * Callers must ensure that this call does not race with a read o=
r write to the same region
> +    ///   that overlaps with this write.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// # fn test(alloc: &mut kernel::dma::CoherentAllocation<u8>) -> Re=
sult {
> +    /// let somedata: [u8; 4] =3D [0xf; 4];
> +    /// let buf: &[u8] =3D &somedata;
> +    /// // SAFETY: No hw operation on the device and no other r/w access=
 to the region at this point.
> +    /// unsafe { alloc.write(buf, 0)?; }
> +    /// # Ok::<(), Error>(()) }
> +    /// ```
> +    pub unsafe fn write(&self, src: &[T], offset: usize) -> Result {
> +        let end =3D offset.checked_add(src.len()).ok_or(EOVERFLOW)?;
> +        if end >=3D self.count {

Ditto.

> +            return Err(EINVAL);
> +        }
> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllo=
cation`
> +        // and we've just checked that the range and index is within bou=
nds.
> +        // - `offset` can't overflow since it is smaller than `self.coun=
t` and we've checked
> +        // that `self.count` won't overflow early in the constructor.
> +        unsafe {
> +            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_addr.a=
dd(offset), src.len())
> +        };

How about leveraging as_slice_mut() so this unsafe block can be removed?

Cheers,
Alex.

