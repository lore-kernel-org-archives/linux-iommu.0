Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021089.outbound.protection.outlook.com [52.101.57.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A4376F1
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886522; cv=fail; b=Rf872ON9AodvHw+D0ZoVtJs9fFqqPQgS511t1TlbFbNC/Bi5RZekJEzCwwUIVN6XWOxkpeWMMXLRNZDTDiTvGr9v2VUDmk0oOjunCheCZdQg53Q53Vr+LU1ZbHxYhjl36Ee5lfVEPX40vqD32V7RnqK6qLPjFla9WRXcT1f7diw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886522; c=relaxed/simple;
	bh=JygOhSqICgwHFr2sXLrkqRLgqyxZAP2TGz23586/5Gk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u3AgZWLGCd/BDfuyDHhMaJNQ7XO9VumV/rkOdIr7rJcgXPPg1h/Ftw+grxgAaqse9c+x7stJ5X2Rirhu78aWTvbMlZtF/dHc7tJnPSjOuMDJDvqDfsg94NMCOhbPyryJVIP3rrbi7DnYFE4+gwPgfcqKIdT/aVH+HeQKNDjxugc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QoUO+M4C; arc=fail smtp.client-ip=52.101.57.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QoUO+M4C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOq63V6SYodHKdRS2pNaJE1zIFygcLdnJJLFB4BlkT0c6gevsVnORU250EKChrKCtVmHW3xW44isU6gUTQft5Zl3Iu5tLSCtVw4arZhKAJ4XnZbl6W6DgYcOc469RaAx/sx3TYORbPV/iKPeDacjbX9KzN1Mc2ojzMf1/T2THwmMEf8ekIc3ImYHne1BguSXYVvx4s8duTM8+jvyWgDhnR38jlVCO5znsXnY5oDSZzNOCxmiNPuHFDrgK2Iqu6d8lfEUJXsAArPboAETY9DXDrPv5/Tyd6tcNriihCyKdv55P5MCF7zyReO96B6NugBKGeG82mf9VLDCR2ZzmG5ejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glQ6liqRXvPimPiajeRY2akXLCIBFzN9oL8f5otDDJI=;
 b=qWRSwslGq3bPVBKxosN+CMbMUbABOOCD67PLhuiKW56GyBJnHrlluZiDGvTxrjnNBT2ASC/lo3DUNO8IqmJqQU7Xvvd+RDKDTih0ZRkpHUHjxHzxtNfepSiF8AqVnGHCa/lfzRfy2ht1gqXrc899ooi9ZujReHnxYa5fabdMPZZqoIeWE6fNzlVRFwUX+25ars9JXvU249WiJJJv6mu3gw3b+wConvi35Qp18cdXqmDCiA5494Ke0dxI9UVw8uje4XnrVURfegxMzCkDKO/m85c5YVw3ayGb2AdyQE5oLUToDW0cVeE+oFRmCXYVj8UYUwc/zNjOoT+ALKqARsQAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glQ6liqRXvPimPiajeRY2akXLCIBFzN9oL8f5otDDJI=;
 b=QoUO+M4CPvkLLG0+k+P0DqMiiMDulIT6WVEnQnMUYCTUOCx3wBq5tWY6Ix3ZncWK92TGTZtHa48WFf6n+e+7vW6zjj5ujEo8i2ywC1rK65ThQfy4WqurQFxhflb+MjP2VAyVoyqooIgjX2fkt15Tw/vKbMSpf7jTYp8ORJXIGhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 DM8PR01MB7031.prod.exchangelabs.com (2603:10b6:8:19::10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.28; Thu, 13 Mar 2025 17:21:57 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:21:56 +0000
Message-ID: <0abe8643-d4ea-4e77-bd77-afe07399eec9@os.amperecomputing.com>
Date: Thu, 13 Mar 2025 10:21:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm64: Add BBM Level 2 cpu feature
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 ryan.roberts@arm.com, suzuki.poulose@arm.com, corbet@lwn.net,
 catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
 robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
 mark.rutland@arm.com, joey.gouly@arm.com, maz@kernel.org,
 james.morse@arm.com, broonie@kernel.org, anshuman.khandual@arm.com,
 oliver.upton@linux.dev, ioworker0@gmail.com, baohua@kernel.org,
 david@redhat.com, jgg@ziepe.ca, shameerali.kolothum.thodi@huawei.com,
 nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
 smostafa@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20250313104111.24196-2-miko.lenczewski@arm.com>
 <20250313104111.24196-3-miko.lenczewski@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250313104111.24196-3-miko.lenczewski@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR14CA0010.namprd14.prod.outlook.com
 (2603:10b6:930:8f::18) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|DM8PR01MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d23d8f2-2e13-44a1-e27f-08dd62538e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEwxMW5HWWV3L0pqRThvVUF0S2ZUZXlHeWhxRmdFRVcwazlIbUcvMlhSTGU0?=
 =?utf-8?B?T3VtUkNQMUhCNWlJTU1vSGxhUDJXcG9MS2FybWJadzV2VTEvNEt3TGtIZnR2?=
 =?utf-8?B?VjhqSUdYR0NWQkZ1bGFQY3F2STVkMDV6RGdoeG5wUFhWQ3lJcS9iZGIwUXZh?=
 =?utf-8?B?SU1TUWxTbG5pdExsc1pvRUdrc3ZuaFhZWnJac290K2tOYzFsWEVuSjRSSkFR?=
 =?utf-8?B?Wk05eUZkWVVJUS9ac1FmcEpiL2hibEt3SWZnckUvdGVJTEZxUllFTGJTSm5w?=
 =?utf-8?B?UU1XT2F6Nm9xNUNIb2VXczNSSVJ6Y0ZYNS9DTHp6d0hEZWhpQXEwV3czOEdj?=
 =?utf-8?B?dzlISEdJK2wrNnU2bDN1cWkydUhDZlRNb0FxdkFMRDdObGh0QlQ5Rnk0WCt0?=
 =?utf-8?B?dVU5OUQwa3lSNTEzMUpuYjNPWVRYRHcyVGVXRHU0QXVWT2d3UUhCWU1QMnZq?=
 =?utf-8?B?Y0hxb0hqSy9CTThNWCthS3psN3paV3hxd3ZBWlpWVFBjbHU5MDlxNW5iTlZB?=
 =?utf-8?B?L1ZBSkZFdEtWU295VEFYbkF4UUpkbEljaUEwL2VxU3JISllSN3NScnNiaE1o?=
 =?utf-8?B?bmg0M1B0SnliQW1jckFzWENUaGQxdnhUSzFsQkFwaW5DSmxQbHZIUTZBSmZV?=
 =?utf-8?B?RXFaTm1nLzVBYURCcWpVWWhnbk0zMjUrUEZRY2VZQTA3cDNKNlE5YWc3b2Fs?=
 =?utf-8?B?UUpqMWh6K2pQWlpMbklmL2NDWURMeTV0cW1QREF2Nzg1WDZDUFpUeFEvSmJu?=
 =?utf-8?B?S2xXWTRNYjVSYlprYXg1NTZseFlxR1NScTNTVDZlNHhOUXJjeWJra0ZrNFhx?=
 =?utf-8?B?c1RMSU5YUThmdGtCNVhPSmh3bjBSWjdCSG4zclQxSExKVks2L01QNlYwVXBu?=
 =?utf-8?B?Zi9NL21IREl5K3ZTY21ZU3BqYTlnek4xUHV4NEZSRmh2azFtb1pIZlRUYzZP?=
 =?utf-8?B?M2VkSmZxMHV1ZE45ZG9OMTdVcVJNN0dnUjBMWlR6bEs3aExNdmZrbEtDSzM1?=
 =?utf-8?B?QXVid1JQQUpCNjMxYkdoZFhqSnZCRWM5b2l2R090M25CdGJBbTNtMnVDRktZ?=
 =?utf-8?B?eHRGdnJzblltKzhoelpzTGRsL1Q3WFdFMEtUb2VXdnhpTXU4Y0Z0eDh0b0ll?=
 =?utf-8?B?K3ZJM3FFOVhvMkV5aXBBa3Y3L25sdXBwZEQ0MXJKSS9OYTdFSzBJM1hxN1A5?=
 =?utf-8?B?OG84bllOWDdXYXNFK3Q5UjRVYmRKUVdocWNtZ1hVdVZjbTRDTkx5U2pZYVFO?=
 =?utf-8?B?MzVIZldra3FmdjZEb0dzWlRvcUhiTjVNT3dNZEFNZ2FFZ0NhUk1IZTI2NUNJ?=
 =?utf-8?B?TzZVZWNrWVhuM0tCdEVrSVpXbU15c3IwcVdLU1VKT0QvR3M1MTNrN3R4UzR5?=
 =?utf-8?B?RmdoeEdNbUUxN0hMSEtHRzliYzJ1Rk1rRVVuLzZ3YkgvQ0psMHp2dXUvdUxZ?=
 =?utf-8?B?RFMrSHBxMjMyRDRDR0E1VzRBU0JpdUZGY1FwZm14SWlOWTRteVNkdVY1Z2dm?=
 =?utf-8?B?THFYVWdZZEdOY3VCVC85bGhQK01ZTWhMYktoVjRyVnE1NWRDT3p2VmllbnRa?=
 =?utf-8?B?eDg5dWs1MmgvUzFBODVEaGVrWVdIcnI0MjMyOE9aYzA5NDFSaEhEYVFRREkx?=
 =?utf-8?B?SlEwRGFTRWlpbWorckh3YWZZRFZmdDJVaHpqUE5HTmNRY1V2ZG1XMTF1UWhl?=
 =?utf-8?B?VjBVK3NuL3FwR2JsUFc0eFA0eHJzbGtlNVlYdW01MnFWWlRWOUhWUUdtYlpo?=
 =?utf-8?B?ampoSFN6aEphQUFqVU9ZWGUzdk55OFZmQVJpMmhiTW42YUR5cEJZelByQnFX?=
 =?utf-8?B?eEJyUlJ2SEFtQ3VvTUxvMTljb1NmTFdsVTMyaTV2Q2wwbHBnR3hXS210ckV0?=
 =?utf-8?B?blVmcDZGYkVBK3ZZTlN6bndaQUJ6WGYxMXFWMnZMLy95S2lGTkVYeTV5NEFF?=
 =?utf-8?Q?Slbhp5J8Quc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qlg3OVV6SlJlNUVtcW5zTUhveGZlMGRXcUpGL0F1ZmI5MlBMTkZoRWROKzlP?=
 =?utf-8?B?dHZadGFoOEJNT0J1K3pIMnJTL2hJRE8zUHdiemx2ZVdkbVlyQ2ZyV2FYeCtq?=
 =?utf-8?B?VUhadFE1OGRXU1krMFNSditOR3pPWWc3aWt1Z1loNUtQVFIxcEttYjgwYmM1?=
 =?utf-8?B?K0JTZ3B5Y3loTUJBZ0VsMnVDQ0lJaFRqTTJ4ekdNUzFuK2YwVFdXYkNmK1Rv?=
 =?utf-8?B?bVlYUTl3VWRQNkNya3NGNnVEb3NsVkZmaXlLWTdFeXU2c3dzUXdDSXMrd1VN?=
 =?utf-8?B?czVlSktiZ1MyT0ZVZUgwdUpDQ0ROS29nc1pWM0ZtREZMbWFtWldiYlZYS0d3?=
 =?utf-8?B?R2ZiNmJjckJJUXJ6OW9sbjErQVFPcWJ4TEtCV1hMRTVQcnpsRXN1dkVvbFFs?=
 =?utf-8?B?UEpKUEQ1ZzRubEJBc1Z1ZWNaYWgzQ2tGU2lURHZPSlBRNjV4cFhXbmtrOUJB?=
 =?utf-8?B?MWxqZXVMTTFLNWJXRVlhU3E1RFBuRzBaYU5mRlhyMzdVMzROcGFrK0c0L1d6?=
 =?utf-8?B?cUZFd2NEd1FvYlpzbGhzMGdRU2NiUnhQUGdKSU50dDBlVEhKeXp2Q010b1dr?=
 =?utf-8?B?Slg1Zmp1eDVsa3NZTVpLU2JkeSs3Y1FwSzdsZ0FPMWVwd3kzVmY2NTZXcExN?=
 =?utf-8?B?eHRkWjJhUE5RMWluVzBJNGNudm5taHdsaUFVN3ZLQU56a28xQVFCVHNjaW1v?=
 =?utf-8?B?ZmNReHVqNmRoK0VOOWRPRC9iV0d0VEJVV09IeWtLSVE4ZWRQUGZreWJLejJl?=
 =?utf-8?B?ZUF1cVpiQnFRcHkvSWJDWHVudy9IMEFEQmQzdnFDUnRoSlh5RHVPeE45RmtD?=
 =?utf-8?B?RFNQckkzWFBWeWE5MVNHWkdlWC9uLzkxN2p5Z3VIYXRyKzNwYTlsV3psVHVF?=
 =?utf-8?B?UmpLR2RnNFNBZE1oSk43bTIrdG05VHpzU1dEQ1JPYTV2SkQrK0xZSXFjYit6?=
 =?utf-8?B?a1NCekhWeHcremErZ2M5MVllUDEyb2VtUUg3cHJSRnlPNEkwMDdWaXJJMGlR?=
 =?utf-8?B?cENEZldEclo1dWppWi9mM0xQVjUxZVpaa3FWRjl4dXhHbkIwYXdyckNWaFRh?=
 =?utf-8?B?dUJacmtDdWdoelFoZWRmd1NwSktSa2p4WTF5YUsrZU9vRWdaSFZROFpxZ2Q4?=
 =?utf-8?B?WFB0T3c5bGtKMjQ2b0VrK2dtbXlFME0zYzlYeHdZdXhDc1ZOR3JrL091OGhl?=
 =?utf-8?B?Nm1WM2s5SnBLTzg2blJFZjVaYkJIb1Y1dVduVkV6cGl4RjA0bFV2d3U1c3A0?=
 =?utf-8?B?R29TeGtaRVlGcjdsM1F3bkhPN3duVzVEbHBWNkwvWlV0VW9Qa0dJdjlqRzNG?=
 =?utf-8?B?WlJZVHYxdW1QTVhvazM4VEUvU1Y5TElQWVg2bTZaOUcrbzVkeTd5SDJRQm9X?=
 =?utf-8?B?MTJGeDFCeWtEa29SVEdGQXl5K1V0UWZmK0xGNk1RajcybEd4WTFiR1pHQ3JD?=
 =?utf-8?B?aTYvZU5Ib2JXcEhLQXNONURjakRpek9JS2JzN3psYUhSMUQ5bG9jMHgyTkd6?=
 =?utf-8?B?WDhRVUlBNXV0V2MwOFhxOG1wVmdab1lGVWNCNFMyV0RHMEFLRU1way9tV0Vp?=
 =?utf-8?B?OTVocXlQU0xxT29LR2RNNHN1VlJiZXYyNmQ0VzMwcFhLV3ZtRmVKQklMRWxY?=
 =?utf-8?B?ZnBLN0pKcU1NaUZCZHZsTXl1bnhOOGN6aFVsVjdvd2RwM3h6SnhhQ2w5UHNC?=
 =?utf-8?B?M0drd3FuU1ZaYklPR0NTZmxzYlJWV0lUaEpaRmppbjhMaitadmNIU0Z1M3du?=
 =?utf-8?B?Z1RMQUVja01HdFdTK3JUa0FtQ0RkZEhncnBZTlNkaFVXN1A2UWZiOGM3Nnhp?=
 =?utf-8?B?YUJ0dE5iaVhDeFJaOEtGTS9lOFZkakVJMGxSeGxnOVBFREdWWitCWm8zRUFI?=
 =?utf-8?B?MG5MQzdUcVJJVHBUWmkzeUNHcElTR2xuM0Jibit5TkorNDJoNDZhQ0RFMHN4?=
 =?utf-8?B?ckVhcU9aNUc3VVdXTjFXVjNpN2xJcUxNeEl2VCtrbFVmcjJDbUVRa0ZJYXZm?=
 =?utf-8?B?aEJwem5JS1RRRDcxWGRVRHpFTnp5djlCUVlHSndUcFBIMGFXR0FzZzlpclpm?=
 =?utf-8?B?NVFhZlhQclVPSlVKOEVWVXVXSGQwYUFjVWtybjF6akdMYmdaSnRHWVE3dlBY?=
 =?utf-8?B?UzdhRFZKSEIxNzVQY1NVTld2VWZDbmlUWU5sbTVjc0tkbUtsV21BS1psUjVz?=
 =?utf-8?Q?Zpmb5d1ardjvcRpBNoIKZkI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d23d8f2-2e13-44a1-e27f-08dd62538e26
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:21:56.4936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjc3glM3uEA1hzyrPuMC1nyD7UhhROXHHPI1TiYmpbQoeF2Dr4untkCAI31/BY2Ij9hjgZMk6zZUcupusaylwpdF6PjBPvdTP5T8/f7kOwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7031



On 3/13/25 3:41 AM, Mikołaj Lenczewski wrote:
> The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
> and this commit adds a dedicated BBML2 cpufeature to test against
> support for, as well as a kernel commandline parameter to optionally
> disable BBML2 altogether.
>
> This is a system feature as we might have a big.LITTLE architecture
> where some cores support BBML2 and some don't, but we want all cores to
> be available and BBM to default to level 0 (as opposed to having cores
> without BBML2 not coming online).
>
> To support BBML2 in as wide a range of contexts as we can, we want not
> only the architectural guarantees that BBML2 makes, but additionally
> want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
> us having to prove that no recursive faults can be induced in any path
> that uses BBML2, allowing its use for arbitrary kernel mappings.
> Support detection of such CPUs.
>
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  3 +
>   arch/arm64/Kconfig                            | 11 +++
>   arch/arm64/include/asm/cpucaps.h              |  2 +
>   arch/arm64/include/asm/cpufeature.h           |  6 ++
>   arch/arm64/kernel/cpufeature.c                | 76 +++++++++++++++++++
>   arch/arm64/kernel/pi/idreg-override.c         |  2 +
>   arch/arm64/tools/cpucaps                      |  1 +
>   7 files changed, 101 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb8752b42ec8..3e4cc917a07e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -453,6 +453,9 @@
>   	arm64.no32bit_el0 [ARM64] Unconditionally disable the execution of
>   			32 bit applications.
>   
> +	arm64.nobbml2	[ARM64] Unconditionally disable Break-Before-Make Level
> +			2 support

Hi Miko,

A question about the kernel boot parameter. Can this parameter be used 
in early boot stage? A quick look at the code shows it should be ok, for 
example, cpu_has_bti() is called in map_kernel(). But I'd like to double 
check because my patchset needs to check this parameter in map_mem() to 
determine whether large block mapping can be used or not.

And a nit below.

> +
>   	arm64.nobti	[ARM64] Unconditionally disable Branch Target
>   			Identification support
>   
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 940343beb3d4..49deda2b22ae 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2057,6 +2057,17 @@ config ARM64_TLB_RANGE
>   	  The feature introduces new assembly instructions, and they were
>   	  support when binutils >= 2.30.
>   
> +config ARM64_BBML2_NOABORT
> +	bool "Enable support for Break-Before-Make Level 2 detection and usage"
> +	default y
> +	help
> +	  FEAT_BBM provides detection of support levels for break-before-make
> +	  sequences. If BBM level 2 is supported, some TLB maintenance requirements
> +	  can be relaxed to improve performance. We additonally require the
> +	  property that the implementation cannot ever raise TLB Conflict Aborts.
> +	  Selecting N causes the kernel to fallback to BBM level 0 behaviour
> +	  even if the system supports BBM level 2.
> +
>   endmenu # "ARMv8.4 architectural features"
>   
>   menu "ARMv8.5 architectural features"
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index 0b5ca6e0eb09..2d6db33d4e45 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -23,6 +23,8 @@ cpucap_is_possible(const unsigned int cap)
>   		return IS_ENABLED(CONFIG_ARM64_PAN);
>   	case ARM64_HAS_EPAN:
>   		return IS_ENABLED(CONFIG_ARM64_EPAN);
> +	case ARM64_HAS_BBML2_NOABORT:
> +		return IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT);
>   	case ARM64_SVE:
>   		return IS_ENABLED(CONFIG_ARM64_SVE);
>   	case ARM64_SME:
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index e0e4478f5fb5..7f5b220dacde 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -18,6 +18,7 @@
>   #define ARM64_SW_FEATURE_OVERRIDE_NOKASLR	0
>   #define ARM64_SW_FEATURE_OVERRIDE_HVHE		4
>   #define ARM64_SW_FEATURE_OVERRIDE_RODATA_OFF	8
> +#define ARM64_SW_FEATURE_OVERRIDE_NOBBML2	12
>   
>   #ifndef __ASSEMBLY__
>   
> @@ -866,6 +867,11 @@ static __always_inline bool system_supports_mpam_hcr(void)
>   	return alternative_has_cap_unlikely(ARM64_MPAM_HCR);
>   }
>   
> +static inline bool system_supports_bbml2_noabort(void)
> +{
> +	return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
> +}
> +
>   int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>   bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
>   
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index d561cf3b8ac7..b936e0805161 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2176,6 +2176,76 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>   	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
>   }
>   
> +static inline bool bbml2_possible(void)
> +{
> +	return !arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_NOBBML2);
> +}

Can this be moved to cpufeature.h? My patch will use this, anyway I can 
do it in my patchset.

Thanks,
Yang

> +
> +static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
> +{
> +	/* We want to allow usage of bbml2 in as wide a range of kernel contexts
> +	 * as possible. This list is therefore an allow-list of known-good
> +	 * implementations that both support bbml2 and additionally, fulfill the
> +	 * extra constraint of never generating TLB conflict aborts when using
> +	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
> +	 * kernel contexts difficult to prove safe against recursive aborts).
> +	 *
> +	 * Note that implementations can only be considered "known-good" if their
> +	 * implementors attest to the fact that the implementation never raises
> +	 * TLBI conflict aborts for bbml2 mapping granularity changes.
> +	 */
> +	static const struct midr_range supports_bbml2_noabort_list[] = {
> +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> +		{}
> +	};
> +
> +	return is_midr_in_range_list(cpu_midr, supports_bbml2_noabort_list);
> +}
> +
> +static inline unsigned int __cpu_read_midr(int cpu)
> +{
> +	WARN_ON_ONCE(!cpu_online(cpu));
> +
> +	return per_cpu(cpu_data, cpu).reg_midr;
> +}
> +
> +static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int scope)
> +{
> +	if (!IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT))
> +		return false;
> +
> +	if (!bbml2_possible())
> +		return false;
> +
> +	if (scope & SCOPE_SYSTEM) {
> +		int cpu;
> +
> +		/* We are a boot CPU, and must verify that all enumerated boot
> +		 * CPUs have MIDR values within our allowlist. Otherwise, we do
> +		 * not allow the BBML2 feature to avoid potential faults when
> +		 * the insufficient CPUs access memory regions using BBML2
> +		 * semantics.
> +		 */
> +		for_each_online_cpu(cpu) {
> +			if (!cpu_has_bbml2_noabort(__cpu_read_midr(cpu)))
> +				return false;
> +		}
> +
> +		return true;
> +	} else if (scope & SCOPE_LOCAL_CPU) {
> +		/* We are a hot-plugged CPU, so only need to check our MIDR.
> +		 * If we have the correct MIDR, but the kernel booted on an
> +		 * insufficient CPU, we will not use BBML2 (this is safe). If
> +		 * we have an incorrect MIDR, but the kernel booted on a
> +		 * sufficient CPU, we will not bring up this CPU.
> +		 */
> +		return cpu_has_bbml2_noabort(read_cpuid_id());
> +	}
> +
> +	return false;
> +}
> +
>   #ifdef CONFIG_ARM64_PAN
>   static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
>   {
> @@ -2926,6 +2996,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>   		.matches = has_cpuid_feature,
>   		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
>   	},
> +	{
> +		.desc = "BBM Level 2 without conflict abort",
> +		.capability = ARM64_HAS_BBML2_NOABORT,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.matches = has_bbml2_noabort,
> +	},
>   	{
>   		.desc = "52-bit Virtual Addressing for KVM (LPA2)",
>   		.capability = ARM64_HAS_LPA2,
> diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
> index c6b185b885f7..9728faa10390 100644
> --- a/arch/arm64/kernel/pi/idreg-override.c
> +++ b/arch/arm64/kernel/pi/idreg-override.c
> @@ -209,6 +209,7 @@ static const struct ftr_set_desc sw_features __prel64_initconst = {
>   		FIELD("nokaslr", ARM64_SW_FEATURE_OVERRIDE_NOKASLR, NULL),
>   		FIELD("hvhe", ARM64_SW_FEATURE_OVERRIDE_HVHE, hvhe_filter),
>   		FIELD("rodataoff", ARM64_SW_FEATURE_OVERRIDE_RODATA_OFF, NULL),
> +		FIELD("nobbml2", ARM64_SW_FEATURE_OVERRIDE_NOBBML2, NULL),
>   		{}
>   	},
>   };
> @@ -246,6 +247,7 @@ static const struct {
>   	{ "rodata=off",			"arm64_sw.rodataoff=1" },
>   	{ "arm64.nolva",		"id_aa64mmfr2.varange=0" },
>   	{ "arm64.no32bit_el0",		"id_aa64pfr0.el0=1" },
> +	{ "arm64.nobbml2",		"arm64_sw.nobbml2=1" },
>   };
>   
>   static int __init parse_hexdigit(const char *p, u64 *v)
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 1e65f2fb45bd..b03a375e5507 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -14,6 +14,7 @@ HAS_ADDRESS_AUTH_ARCH_QARMA5
>   HAS_ADDRESS_AUTH_IMP_DEF
>   HAS_AMU_EXTN
>   HAS_ARMv8_4_TTL
> +HAS_BBML2_NOABORT
>   HAS_CACHE_DIC
>   HAS_CACHE_IDC
>   HAS_CNP

