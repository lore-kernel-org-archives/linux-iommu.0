Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012031.outbound.protection.outlook.com [40.107.200.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF452135B8
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766041447; cv=fail; b=tDjvCcyTy//YFanrQSW4YZwCMi8O5Hspxx9726abaL0fDjeVGAO2HcvmVRvfHglLTEFv6m3W6hmhGE5B9de7/DTAVniDRXgTQhDIwvdeX+bpmSDfAckV9P/7ZM8sBkoDZbeC7ylhqNyZUD8vWxffxHuuHUMQbbtDmXyu2mEE+9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766041447; c=relaxed/simple;
	bh=4hyhjeuu7dKHvr8tpYY8pTkykYBn1ruD45XsY6u/8rc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mWWC1ioUu1qaulrHkR5tVTM6hBEmWpaoDRyx54TPJy8JH+ylDTr27w7d3Tuxk1QuacHeFWeFtwjg9NgHj7+ivxejgjIxD56aQsq8zE95UT5wn4OcdMc0dmoxHRwk5PhzK/zpzSQj80jMvf950NupqmVhpnkuso9ANtcFr4Dur8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rwaWpl+/; arc=fail smtp.client-ip=40.107.200.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rwaWpl+/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVqVSWWZoX84a+oUTXRQbZ1POqRNBAQcrmOlGZFiFxSMZUzsUb9bFyqmrmJgqXB+bKr1IHmtTgiKO+vgNdbyq8HZ5j7x5rf6IKtqE/6mrJFHNNIEzcEl5gkCzVPYZF7y3Z91hoTugWHrnEn6485pV5jKHKujerbhEPWylP0Vl/0plKxbxYGDmdH5XBz5SNO+pZFUkz+gIQNKl06EaoRp906T555icQhfEYQ/52RlzrKLdVgu01DAAbAO4IoMYJgqEttc8ebFyaPgGjrDMdzc0g4FVUKGHPgclSj1GdNG5kWIwu4Fe60gD3I0NgqJCXBIaYLNdannv7eMO9tVCf+6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3iDcDW/tN19W7Tuk7XKRW+A526is9Lvl88X2E/BnkY=;
 b=Xwdf7iFrtiUHoIHkz7tII29ug+Ff87hSPnuo/6djsXdoHoqVMFtyt6DZKOyLOEmdbBLqIP0MnJjfJbYZVOwXZZOzINnwvWk4G7+OCNbe6i27nvxhLdzBKHQ7SFDEpdzZ/4xNIcgaXvcl6+3oia+eif6vU3rwd9FFBu3eguTwKHBBUHPYV4H+SzS8LIDUFueHRtvHnPh59kdjeaUEMPiqOMRL5T0WCGF5ab46o557n6br4H5XjytC+oIrDOHbXIadKYI97mOsy6+6m+oh+dAVzpjnftHbXmI7JmMyWYBF8Gr0SmvDFlg6EFykA28GbDizBgN/0pIAeRHj18sKmYmS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3iDcDW/tN19W7Tuk7XKRW+A526is9Lvl88X2E/BnkY=;
 b=rwaWpl+/Yzo9C/yCwETRJ/kxk/pBoBbIl+MLMRYA2h5/sAfLzwwhdhIRSz27m6xveeGy+Zy6pesYfMEOssK9KFnQCgRrufdzi4UTpktI3bMOujIGoRR7F+r3MRarNC5FUgJMnzcPdmOtBQaCCyXWYzy+O0WZfv3iRe9W7Vrdg8CiEflwAN4Mc3rAFYun5+6N2QFO3t7DhnFxDv9kDZ0RnkP0KGcHXcRKR52acbWnDXLrT4Yl5W3Pz/meYub8w7pcCyUgp0AOLthmFuvHTY+oZ/SftzTIW6qHmZtAzlD5CzkTtZqpZRJuVE+93h9PWXA7KAWNXMlhl2VWmIt3GkU7rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 07:04:00 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 07:04:00 +0000
Message-ID: <38364cfe-8fc9-4ed7-9034-4e67584ee965@nvidia.com>
Date: Thu, 18 Dec 2025 12:33:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/4] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
To: Jon Hunter <jonathanh@nvidia.com>, will@kernel.org, robin.murphy@arm.com,
 joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251215064819.3345361-1-amhetre@nvidia.com>
 <20251215064819.3345361-4-amhetre@nvidia.com>
 <fbde672b-611a-4d81-ac05-44e434bf70ae@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <fbde672b-611a-4d81-ac05-44e434bf70ae@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::29) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 91af632b-154e-46b5-df28-08de3e039ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHg1NStSWTUyZFBpbFpweGxLYjY0MVNXNkxpTUoybkRuUEdzWlduQ2V5OFdi?=
 =?utf-8?B?a3BLYnFKc0dRWldlc01oMXVTcmRtcVpBRnNWOG9WTitJa1N5MjRPbjVrRDFN?=
 =?utf-8?B?WkI2VFB5VWVKbHU3NDNOREZsbWJJMDFueHZGRUFiVlpuVG5LczZPNzBtQWZJ?=
 =?utf-8?B?eEVVSEdSU1d3SXlIV2cxZGRJU3Q4M0gwWU9ldFhSaGNYanNMcG1oemxKTGU3?=
 =?utf-8?B?VEVzOE5VQ3hyc1dEZ2xCY0ZaK1psaWFsKzBtWVNWeHBEYlFuYTloVW1DbnRQ?=
 =?utf-8?B?NUdCQlU5cmxBWVlWcGhyMitRTWZpYi9oNE10NXFCRnhDcC9QRDZURkFkYnVy?=
 =?utf-8?B?V04rZXlRZVplVnIxelAyV0tUejQyUjBRYU84WVlCT3FTajdjNFZodnRwRWsw?=
 =?utf-8?B?bVlDeUlZakIzZS9oMEVJajNoSDB2bE9jTjRYMDdJRm54Q1ZwSHQ3V001bmlU?=
 =?utf-8?B?Zm9ELzFXendzNU5HWUZ4SDkyOWlKVG5Fb3c3eWFpMkVKRk5KK3phRE5kaW5G?=
 =?utf-8?B?WFVXbjVzbGhlWFlBSGt0YU5WRjNEek5QWXlaaTlHdmtoTDRtRk9zTThwMjRi?=
 =?utf-8?B?bFZxNCtnR1A2NkZudnUyTkNCTTJiQ0MxS00vQVhLKzRrQXpkN2k3bW85TmdC?=
 =?utf-8?B?Wll0bUFaaE1SLzVucDFNMHRvb1lJUjBKVzgyd0JSRDBrV0pWb08rVVRUanFB?=
 =?utf-8?B?blVuV0VDRHFSZWRiQ2IrL2o0MkZSZFgyenlGTFVEZEJ6MDlnU1JBV1ZnY0dl?=
 =?utf-8?B?WThNYnQ3bTFTVFZSSlZoK3luZ3B0Y0QrQSs2b2pib2ZRSWhnS2Z4OUpxWTdK?=
 =?utf-8?B?eWQ0YWJybWw0eXgwUGpiTTZhQS9FMkhxWGpDN05sR1YzRDFkNFRzQ2lIRXo4?=
 =?utf-8?B?Mi9uV0pqZFpNUGJUK1JBRzU0dXBCbmRMeDR1WWtFVXU0dUlTOUE3S0ZEZEl3?=
 =?utf-8?B?TlpQRzBqNml1ekZROGZ6RjltTGlxZjhMMlpvNzZCcmNFcjBURmRTT0tBaUtO?=
 =?utf-8?B?ZnpHV0htWWdYOGNGY3NBSW9IdjFNNDdZc0ZvdzFXU3l1OERsU0ZSQkFGRC9a?=
 =?utf-8?B?SnhkY25EejFqSDkyRDYzNEhyYXh3YXlnRnFnZlhwMHdnTkZJM1BKVzYvNUpm?=
 =?utf-8?B?QzVmMEdYc3E5RkMyQlBFQ2lEUGx5dDJVK3ZLREVtTS9NL0hzSXRUNUg5dFVk?=
 =?utf-8?B?VjJHMTdzbE9sOTR2Q3NWVk8vc0xiMFExMkREMEZncUVidER2cDRPWEVPckN2?=
 =?utf-8?B?dTRhbW52emorVGU1TzBhZTRwNW9rTVdWZHhIZ0wvOEhBY0RDaU5ZMmJuVUJr?=
 =?utf-8?B?YnhwU084UW1ab3ZHb250YVdWd0RyL24xeUIvamNwYk5iZHU3Y0NPeXB4RFUr?=
 =?utf-8?B?VVlhd09FaGVBd0Q0RjlZVm9SMWpIVDVyVys4aWU0S0lmK3NNRXcrTTBkb1Zq?=
 =?utf-8?B?TVlHOXcxc3RZdzVhQURXZnZhLzk5dkNic3djSktxQmJ0ZEFXUjkwT09oMHpu?=
 =?utf-8?B?RitDSUlSZlhHR0J1cktmTjRWYWRRNFpuOGt3UEFFN2h4VTFRT21TUXJCZHFx?=
 =?utf-8?B?SDlQOU9RQ2k2STROekRZYVAwQ0Q3cU9XNFpwYW96cTVRR1pYK3NpS3d0Vkoz?=
 =?utf-8?B?VHkrakNlbFV4cENWNHNQYmYyeVBMa24vRHBCTzlYVjM4bThUSnpuRmd3blRr?=
 =?utf-8?B?U0VUY29XalpiWm1qZmxCOTk2RnQydHkzajZGZHhIYzFGYWpTREJLOUlKZ1I0?=
 =?utf-8?B?STN0ejlKNnRVMDZ1NjgyR1psWjRNWG5TbE1uUjdrTFc1dXVpTjZSSml5Q2tK?=
 =?utf-8?B?cU5LdHpnQ1FweXRaY2VsdDNJVTNuSFZ3WThDVTloaFdFUHFZZE9XbTY3ajBX?=
 =?utf-8?B?MlB0eTl0T1kySTBqSWNxR05FR2VtRngzKzhiMHlrdzIrdm5OQk5qc3pvR2ZP?=
 =?utf-8?Q?e55fBmVcM30aRN7FhdFosHA25sOXT5a9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzN6c2dWb0ZoU0o2OUpsRDBEemkwenlCMm1ycXBsTkk4MzROdnBwaytwK29a?=
 =?utf-8?B?Nk5ndFBncGczYmNwcFRpOCtDN3lUWjY4QUp2QUdRSUdaK3o4MG9EU01INWlJ?=
 =?utf-8?B?Q3dPVWZsMVNyS2NuMytCOGZydEpiYzdGT3V3UGswWVp6dVN6TVFhTWs3RjJK?=
 =?utf-8?B?M01EclNOTlJxNE9yZE9sRzh1Y0owOXFYMFM3dTEvelJJaTJkb1AwcVFWYmJM?=
 =?utf-8?B?Y3d3ZXR1MlJ5bXZTWGVWNWY1OWkvSndhVEVFVi9wVEdmWHdtcTZGZmUyV1NO?=
 =?utf-8?B?QmhtT3pMU3ZxcElNNWE4NkhySDUxems5aEJJMWVvUHdjYkROZmZnRzFuMjlT?=
 =?utf-8?B?OFVpZFpTOGE0SlVvbTN1enhVMjlmMkMzcWhZTk9SN2UwQW1XcW85eHpyMnNF?=
 =?utf-8?B?dTk3aWRGRExRVTArQzJQcDBCNGExS28xNHlMRlZxWkhEaVlzOHRLajVBUmJI?=
 =?utf-8?B?bWdDVlZWeVdZcUlQM0owRjVCK0hoSGppNHBFNmtQNXd1RUhWSVVxSDJQYzF0?=
 =?utf-8?B?YmllZENCVVJrYlB6RjU0N3E4ZUZBYW9NYWVuODNWS1dEd0pvOE55T05aTmVv?=
 =?utf-8?B?M1haMElsV1BGL2NpRHFGUlJCdUl5ay9wWHA2Z0pNS3lLcW41ZytZM2lBbGpv?=
 =?utf-8?B?ZDJXT2ZIMUVIREU2cGtjRnErTko3bkVVR0dmNEovWDduTnAvd1ZmVDFZSGRi?=
 =?utf-8?B?RDdRanU1dzlKQzNOOEZQTyttclRhYTdrcmt5Qjc0SE03MENmbnFFK0hockVq?=
 =?utf-8?B?elhDeDQ1UVdWYTJKL2VmTU13c0laZ2QraHFWdU00VHpJQmdlQjhrVlJVaFJX?=
 =?utf-8?B?WngxUWFFeWNrQld2NnNmVnhvMzhhaC94Mk80L0t2RVhFeC9TWFU1cWE5QkFv?=
 =?utf-8?B?aUJ4NnRHaHlWeFo4Z1JBNDJXcXZheGNrNDlZbjNKZzdYZDd4S09Xc255MG5O?=
 =?utf-8?B?R1NscnYyNDBKanNZODEwK1pnVjV2QnVuMWs4SkJDcEFlMHVoTjFWVWh2NGNr?=
 =?utf-8?B?N3RyR2Eyb0RWOFJCeUZXT2V5SW16OVFpbnk1dzZra2loZUZsWitHRzJ4QmVv?=
 =?utf-8?B?dVFxVVlja0lBT1VyamxCdTJSZHBReEx2NTNzWFVYNzVWWXJBeHBiblZDQ1J3?=
 =?utf-8?B?Um5Fb25DVFhtNFBWV2RTTk5xT3VudFdxeFlRR3NSZTdWalArYUVZUWVjNWdI?=
 =?utf-8?B?ajdpNlBPQnFEOUQwcTBxNlZQT2pkWTF2MkpRa25OQ0JmWXp6UlJyWWNBVkJ4?=
 =?utf-8?B?UTR1Q0pMaFRtZWRydDdKREQxSENlbWRLdW93b3pWNnhicXdJeml6NWNaTnA1?=
 =?utf-8?B?ZWttaDF1bStReFM1QS8ycTNsbDd0ZGhOSTh0c1UvbFBoVUlIL2o5dVlObzcv?=
 =?utf-8?B?VHRkS3lEWkFkUG9INmxwZFJMTDZqTGhRUWt4UGVrbjhFN1FGNVhwaHBBRmlD?=
 =?utf-8?B?NDBGVDY4SGQzZFRyNHpiRERTQ0FrUXZQVE5TQ3RseVpyVW1qbnRHMGkxaUkv?=
 =?utf-8?B?SzM1NXR6UFMreTNBRnJtbjlIa0FPOWp3UUl4YURPam5xZmVNUVgwUnl5b2Zo?=
 =?utf-8?B?TXlzMWxPRThMRURKV0dIUWovdjhFYWlXNUd6TDZWb0dzVHpFVFUyV090NnBt?=
 =?utf-8?B?ZjZzYnVaRTVwUTdyVm5kQ3ZlM2J6WWhTV0V2YTBPeGpsSUlHM2tDdU4yV2hi?=
 =?utf-8?B?UXNkWkQ3OUs5TE93RG1TdHlNUFJSaFlyUUd3bk1wWTBGMjN6RFRHbzJaSXJi?=
 =?utf-8?B?ZFhmV1c5eUVHRzBzMENoRUM4MmVFT1lKS3dDSVFxOXVSMjN4bzExQzBORTBS?=
 =?utf-8?B?bWhkZDh6R2xiUXJkVjdNMVEwZHlVeHdqN09sOUlqdmVWU1B3TzQxV09XRTEx?=
 =?utf-8?B?a1p5eEQ2b3hTNHFoNDkzS1hRN2VqQ1AxYmpiUVNmWnJIOXhPYnpVTm9pSXRI?=
 =?utf-8?B?MTBBbkw5TEkyOUozazlETkNQeTVHMDZUNVkvWkZibjdHZHFmTmtoWGM4MHND?=
 =?utf-8?B?MVBMZ05OVjJWSEg0Z21MTHN4ZkxLT3crY21DNFZIWmlTUXYvN3RQRnArTHFa?=
 =?utf-8?B?M1lHdUtYQXB0cnlPL3FYUlA3VCtQa1hIeTg5a0w1ek1NQm9DaFJnbkg1TkRz?=
 =?utf-8?Q?FRxb3BbKzepInrL6ZuSbD4QHV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91af632b-154e-46b5-df28-08de3e039ec5
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 07:04:00.5692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAHsHtWt4cr31+9dDKFf7dkSwHzZHR21MWPVhcHrtrJRJaIzctCAxtxqyTQzOREpJPXe16E8YjpP00AoKPoo3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128


On 12/18/2025 2:01 AM, Jon Hunter wrote:
>
>
> On 15/12/2025 06:48, Ashish Mhetre wrote:
>> The Command Queue Virtualization (CMDQV) hardware is part of the
>> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
>> virtualizing the command queue for the SMMU.
>>
>> Add a new device tree binding document for nvidia,tegra264-cmdqv.
>>
>> Also update the arm,smmu-v3 binding to include an optional nvidia,cmdqv
>> property. This property is a phandle to the CMDQV device node, allowing
>> the SMMU driver to associate with its corresponding CMDQV instance.
>> Restrict this property usage to Nvidia Tegra264 only.
>>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   .../bindings/iommu/arm,smmu-v3.yaml           | 30 ++++++++++++-
>>   .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 42 +++++++++++++++++++
>>   2 files changed, 70 insertions(+), 2 deletions(-)
>>   create mode 100644 
>> Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml 
>> b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>> index 75fcf4cb52d9..1c03482e4c61 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>> @@ -20,7 +20,12 @@ properties:
>>     $nodename:
>>       pattern: "^iommu@[0-9a-f]*"
>>     compatible:
>> -    const: arm,smmu-v3
>> +    oneOf:
>> +      - const: arm,smmu-v3
>> +      - items:
>> +          - enum:
>> +              - nvidia,tegra264-smmu
>> +          - const: arm,smmu-v3
>>       reg:
>>       maxItems: 1
>> @@ -58,6 +63,15 @@ properties:
>>       msi-parent: true
>>   +  nvidia,cmdqv:
>> +    description: |
>> +      A phandle to its pairing CMDQV extension for an implementation 
>> on NVIDIA
>> +      Tegra SoC.
>> +
>> +      If this property is absent, CMDQ-Virtualization won't be used 
>> and SMMU
>> +      will only use its own CMDQ.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>>     hisilicon,broken-prefetch-cmd:
>>       type: boolean
>>       description: Avoid sending CMD_PREFETCH_* commands to the SMMU.
>> @@ -69,6 +83,17 @@ properties:
>>         register access with page 0 offsets. Set for Cavium ThunderX2 
>> silicon that
>>         doesn't support SMMU page1 register space.
>>   +allOf:
>> +  - if:
>> +      not:
>> +        properties:
>> +          compatible:
>> +            contains:
>> +              const: nvidia,tegra264-smmu
>> +    then:
>> +      properties:
>> +        nvidia,cmdqv: false
>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -82,7 +107,7 @@ examples:
>>       #include <dt-bindings/interrupt-controller/irq.h>
>>         iommu@2b400000 {
>> -            compatible = "arm,smmu-v3";
>> +            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>>               reg = <0x2b400000 0x20000>;
>>               interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
>>                            <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
>> @@ -92,4 +117,5 @@ examples:
>>               dma-coherent;
>>               #iommu-cells = <1>;
>>               msi-parent = <&its 0xff0000>;
>> +            nvidia,cmdqv = <&cmdqv>;
>
> So I believe that this is a generic example for arm,smmu-v3, and so I 
> am not sure we want to be adding all these NVIDIA specific bits here. 
> What would be more appropriate is to add another example under the 
> existing example specifically for Tegra264.
>
> Jon
>

Yeah, makes sense. However, I checked arm-smmu.yaml (v2) binding docs
and we had separate Nvidia specific compatible and property
(nvidia,memory-controller) there as well. But we didn't have a separate
example for showing this compatible and property. So, I wonder if we
even need to update the generic smmuv3 example for cmdqv property or
add a new example?
Can you all please share your inputs on this?
If required, I'll update the patch will the change below:


diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml 
b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index 1c03482e4c61..6b07ca9928a7 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -107,7 +107,7 @@ examples:
      #include <dt-bindings/interrupt-controller/irq.h>

      iommu@2b400000 {
-            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
+            compatible = "arm,smmu-v3";
              reg = <0x2b400000 0x20000>;
              interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
                           <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
@@ -117,5 +117,26 @@ examples:
              dma-coherent;
              #iommu-cells = <1>;
              msi-parent = <&its 0xff0000>;
+    };
+
+  - |+
+    /* Example for NVIDIA Tegra264 with CMDQV extension */
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    iommu@5000000 {
+            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
+            reg = <0x5000000 0x200000>;
+            interrupts = <GIC_SPI 12 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 13 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "eventq", "gerror";
+            dma-coherent;
+            #iommu-cells = <1>;
              nvidia,cmdqv = <&cmdqv>;
      };
+
+    cmdqv: cmdqv@5200000 {
+            compatible = "nvidia,tegra264-cmdqv";
+            reg = <0x5200000 0x830000>;
+            interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+    };

Thanks,
Ashish Mhetre
