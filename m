Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D68F1AE045
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632898; cv=fail; b=W4oUNDqcj/SAFRlx3eGDK1m7dq4BCOfcQWSOAnPp7ncLJnGpfgOkz6lRkpysBYpGDdum6Rpa75/wXeJa0QKejot5KpFUv4kmwWjsJB4V5X4+XbyDUZn3yQCi+UK/A57S3UxosskcmlAytWM9ZytL6BKSbONzJzCM9EcjZUXzYwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632898; c=relaxed/simple;
	bh=1b7UgISmlPLQcDMz4AL94p1jbqbnVDnxhCzpTH8vHXA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aZ/Dw0qnNff1iqER5mXlxLViM8lBvHxr8/ARx9ciu6FXuF6OJ5cS2y/w+CnjH2nCTVd4yctT7Ug5FiHtVjdjtXer5h8hmZhkuX5py1y6uv5n5Yjn1ux3kRdbVKHgsPI6gzj+/X90f4YgT9SVrxoyPH0jZIsXdCRrg7a9n2FvZEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JgpJnKdF; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JgpJnKdF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrltyL10/5/DS1O8ut1aaawmYUCNjnvL4n101AahqhIq2l5VxYZ9HDYIbCRIxOoXDca6HdZx8zADrixsl0BKFY58OV0VLJUdVoJ/0IUQCQUJfS2P5mtZjanGOQ+OiumvcZREbq09wDMmv7LcPzrBGdub4xuBbMecYCyHY6MBC9Ux5TSQKwVdOG+/6whkis+SoxpZkQyPLuYwTUBgn/1bUw++fJGccjzu5qhDkrDm2oBXQuJC0iaXM5PHYubCaTx1TmmW1sFrFpFpzPlLKBhNYapJNPgxlce7Edrg3lKxLxp4Uu/R8BlH75vLqvaHTdTOgm8rAYpqmqPN166YlBCFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfcRCns7S7jRM2wVuKCGyOzwubXX407bDWEpUPnVkYs=;
 b=gVs3Dbg6uNt3EeHh17GqCk86K8bsEEqxVbSEAiqZd80ePrMb3YCSi8P4JHFpS6Fggvlfg9n7097OTmiuZaDH05eRf+VEkzce7pewVxHbbx6lCqtBnw2eMb/KGghCeJ1oGSJLGyFQSOZUoFDG3syhq1k0YVwEAngoGAiWHxLy9yRBJChLt0x8dNosW5Rl4GtHQuqfmHs1sR2Psnka1k0psGqPuA1KJFo5D3RN6DyAKIFfjdAoaOZqtrXgJqK3tsbaBVOukhpWxYD3IxVgE4FUGZ8jxEmWkgoSf5u7I1/dV7v4dzxelTJOGUpUhbN7zNS7j09g7cYRGlSZmEsSPr4d1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfcRCns7S7jRM2wVuKCGyOzwubXX407bDWEpUPnVkYs=;
 b=JgpJnKdF/mEJGVJKhJmjceTbFl/ApC6AckYR4e/1+nns+Eig1hCIFpfuZJt/GpH/GTkVQezRapri+9Rm20xxEjEo0V/DHjr8v/Qb3Ht1NHBtjECi6CAj5jsvaadb9lp4b1lcCBv7LUMMArISxTVws4B1R5xYLj6ZhyKF5/uFhPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 10:54:53 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 10:54:52 +0000
Message-ID: <838e0db6-d6b7-49b8-b893-e9891fd7d28a@amd.com>
Date: Wed, 14 Aug 2024 16:24:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca> <20240808011629.GJ8473@ziepe.ca>
 <20240808130814.GA1985367@ziepe.ca>
 <11b95737-e0d5-43de-80ba-69923ee8b249@amd.com>
 <20240809134454.GF1985367@ziepe.ca>
 <fe275b31-41ad-4d7f-89bd-bef4788f58bf@amd.com>
 <20240813162234.GJ1985367@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240813162234.GJ1985367@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::51) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: f7600844-5bb9-44e8-16f9-08dcbc4f868e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTI4c3QwMEJkaWJ5RWRyc0tJU3hvVnRSbTI0ZHVFV20raGthVzJwOFVNS0NT?=
 =?utf-8?B?ZVBEZ2o4dUVVbUx5ek1Jc2VnYUc5c2thRzFyNVd5bEZHYmNCZjBZNnN1N3Jn?=
 =?utf-8?B?M2FjeGV4UEZHQjQ0c21ZTmNzcTZzd0t0bHpVdW03Z0pJeEZMcGFnSjNEejFE?=
 =?utf-8?B?OVVqNWswOGQ3WjRLVUIwYXpPVzBHcS9DUGJOMkxCM0wzcUtaSkZrdkdFSGov?=
 =?utf-8?B?SjVJb05lWEdZQVp1RTYvMU5HODN0c0M1NjBrVmV5S0JYWXlOcktKNWtuWGg2?=
 =?utf-8?B?ekNzdWIvb3dJNzhTTGhQZFR1aVQwY1BIbzJ6S0pGZHFsa25XcXFXQnhLY29t?=
 =?utf-8?B?OVVudTFPWVRDYkhkR0h5QkdFcjJZUlRMajBCU2xHbVR4QmNEVlJPZE85L0ly?=
 =?utf-8?B?UVh2T2hBK0s4d3JzNkxDaXVwcXliRDdWVERNQlMzTW1XYnZxTEtGeXJ3T004?=
 =?utf-8?B?WnBnWXlsRmppRmFxeU1ZUFZidVFZVmIxWlpuYW9HZU9DRm82VjFLNkg0OXp3?=
 =?utf-8?B?YUR1SlhrTzBaTmY4eForc3NSY1ZpQTBmSFVYbmlrYVpCRjFzaHRyM0RFNlF0?=
 =?utf-8?B?MG41TFpNb0pJMXFab29COWMwdm1GM0h4Mi8vaTQ3UDlvUGErdFFjbVdCZEpC?=
 =?utf-8?B?d0pnbjVhOWZzNVRmckx3MHRYUDZhalI1dXJleVF4UXAvRWZaQVhOQjRuTTBn?=
 =?utf-8?B?bCs3Q3YrTjAzeXpPKzJnQTJqMGJNV3VTam1VVXVmeUM3SmduaDB0bnE0RnZm?=
 =?utf-8?B?ZkVKbWw4MDNFaGJqN1Yzb3E1K0JweWQ3SVZDaGEvQnkydDFDTkIrTENEUnpQ?=
 =?utf-8?B?Mm92Mm9PcjVyT2hCMU1BVXFSZ1F3cWZMYWpSeWg3MXgzMk81MDQxQVFJNXhu?=
 =?utf-8?B?emVaL1VxV0oweVMrV2tMbTJlalk5ZTJqQWFTNXRDRzBsQlFMTngwZ3NhdjRU?=
 =?utf-8?B?WHhJUExUMXU4Q0hBN3NvNVkwNmNuVWZOaTlTdFNHN3B5ZVRHWDFlVkk3Q2Js?=
 =?utf-8?B?VHQyUUpZa3VjR1MxdzZCRVhLRmU1bEdIdjhSeEpCNEJObGxaV1padWFwTGtz?=
 =?utf-8?B?VXVpOUxGM1VwMTc5blloNkNGVHpIc2JXajIrWUpvdVdiVUo5cnQ3ZG42QTlS?=
 =?utf-8?B?blU3cFI1R3h2a2s3UmZLTVhkUHpIVUwzT2dXc29yc0s5bzhQUzVGSnpVQStB?=
 =?utf-8?B?TXA2Vjg2aVM5aDNHL3g2ejdGN3YybzlzSE5xYmhtbnpuQnhRNW5rMVhvbldV?=
 =?utf-8?B?YXV4aCttbFJIOS83ejIzM0I5UFI3QTc4QjRpQzVNTFdTVXNFY0syZDN2ck1I?=
 =?utf-8?B?VXhqckVUYXBtbmRSbzkwc2V1WUxrQThWZVdXY25kSVkzeUxzM2NuZWloa2Zm?=
 =?utf-8?B?L1FrbTFYREJXNGNpVDVnVTFVZEJzYzYrcDNHRkpxc2NSMDEwVy92TnV5a1N0?=
 =?utf-8?B?VC9wdGRXcTdsd2M5NHhmZG9Ebks3dW1oYWI5b3hhVkh3Y0RmMXJlQkxkdzlh?=
 =?utf-8?B?cnpyZHVSRE10SUZRTlZOUVplS2xReDdqSTdLNjVTcGpnTEo2bEs5blNTM2ZP?=
 =?utf-8?B?U0RQalhoRzkvTXF5ZXlqZC8xQlRXVGpuTVBNRkpYaWhsMUJJT3ZkREZSeUZV?=
 =?utf-8?B?YnJ3RzdWa2NzeUcyemRTS2FDQ3U5Umt3QlliNENST2NGQ2dBaXRTQUtITmV2?=
 =?utf-8?B?MFRGazY4WWtNa2U1RTRxV01TUGxvWG5aRGtyblRZY3N5dWRGS1A3eWVTb3F5?=
 =?utf-8?B?TjE3d2hnY3JYS3FLcFhPS21TTUp4cjYrNndraGZNQ1hpTFNXYmpOam1sYWND?=
 =?utf-8?B?dlJ2b0JndlBkQXhITUtIQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHZZQldGa0duWXlXWkg2MytXajNEZDZXd3B3S1lRMkhLKzNUUStiZlhNa1Bv?=
 =?utf-8?B?RHJudjB4MUJ5Y3RwZllaUTc5WVN3R0pmY2I4dFR0Z0RzOXV4WDZlc1l3UlJz?=
 =?utf-8?B?YkpKdFpQaXVMUVZpYWZGQVduOGxQc0MzQWNzd2V0R2MyZU4yL3VYcEQvK2Ru?=
 =?utf-8?B?MVN1eG91cTY3bW8yVzZWblVDTVFIcHZ1d2h1bms0MUpjN1luQlFlZVNjYTY1?=
 =?utf-8?B?Y2tVRkcyQ0lPOFVyWVhBUEJpVnoyeDlJM0lsRVdkMjR2MnozLzRzUFpXTUM5?=
 =?utf-8?B?WVpjRng0WDJvMDI5bWVTT3hxb0ZhN3lyemc4bnJhSDd4K2VSUWQ4RHFPRnBn?=
 =?utf-8?B?ZGhmbFlGUzhWQzVxS2Jxbk55S2pabEFuVW1Ea3R6VXJHY2JCZFlvckIrYUh4?=
 =?utf-8?B?bnI1dmlHVVNpUDRiSzBmdEZ5M29XSWRpdmViWVM0MnNTUmEwTkNtMmhVcXNx?=
 =?utf-8?B?RS9wTXc2d25ZQ2FOSEt3S1NFenVhRzI2dlBKUXZwc0xsWG1RQmVrZmMwS2Z4?=
 =?utf-8?B?V0NhdUNhOUYra0ViSHJWRnQra2pvM0RvbFM3VXY3Tk9aOGRVa2QrcFFIR3k0?=
 =?utf-8?B?N0hGalVJU0g1OW9RTldyQWZSYWdrMS9sTlhkall3aFlQTzVDcWoyZ1l0YThE?=
 =?utf-8?B?YUFtMHdyRXhIQjdYRVhxbml4Nlk3cmIybXVjdjNQY2ZpZTg2T0FXUjJIUGUw?=
 =?utf-8?B?QVkzQlJlL2ZHU1BOTm9IZU5SdGdvM1FjWTlzK0JjZVNGTDVHbW4wSE1sUlZn?=
 =?utf-8?B?MkxwOWJmSWoxaXhnRXF6MFlOcXc2LzRGUkhWYXNOMmNVZ00zWFJNNk0vTCtx?=
 =?utf-8?B?bzUxbEU5dGtQaVlnbmVEd3ZOcWhZT0JpYUtscXJJdU5DV3BBaGpMcWpIcHpv?=
 =?utf-8?B?Q3kvZ1FUVnpIQllsbG5jNWkxL1QySjMrUjFXVS9OcWNnZlh5cFlBT3dJQnZt?=
 =?utf-8?B?RE1LVEd1ODFOcVdWRURZUFBlY0RVNEhYSk5hNTBVVFBlQ0ZSV2VGU0VRclhE?=
 =?utf-8?B?ZTZwSXMyT1U0dmJpTTc5RTlidmFZWHZMb3E0QlFCak5BcmxLV0Qwanl5ak52?=
 =?utf-8?B?elVtUTU4Z3pjd3V5QkpRV2krUW44Q1ZmTWdGVFBrcHZuUDBpS0lEZWRaU2dL?=
 =?utf-8?B?eHBBYkNBcHBRYm9uRXlQMlhORjFQZjVPNk1JMDh6Y09UWDBjb2ZzVEJYR0RJ?=
 =?utf-8?B?MjB2UTVxRmlWdTd1TllEdmVjTW9jR1dsQ0cydDFVV1hwKy80WkRkb1dpcGR4?=
 =?utf-8?B?Wkc4a0h0TGV3MVlhMFlZekZQYjVFWU1WOGltK3M4Q3pjaXlQbGViSjdMYXZY?=
 =?utf-8?B?VENPRzhwcnB0a1Z4SXhKZU9oUWc2OGVad29IYjZmQVBrOHlBREtpby9EcDlY?=
 =?utf-8?B?R2lzSFUzREJwS0tmWGgya0lzdlkrNFdVeTViUjlKR2NNK01uRVhHNkhTT2t6?=
 =?utf-8?B?VzlwZW1hRDNTSmI2cUN6Y2VTUlc2VlpsblZTWnIxWWQ2N0RBdXR3MTB3YWd6?=
 =?utf-8?B?cHpnR1RSWHlDUi84WGZQYTVSNnNQd3dGUTJNdStpSC9uYjV0UlR5SUxTSFpW?=
 =?utf-8?B?emtqbVJtR3hxZU8xeWgxSUNiNmlqdkpicXRTN2pEVGVUYm5WNTltM29pYzZw?=
 =?utf-8?B?WStLNlhsREx4Y0s3U2k5cmUvd3VsRTc3MFY4SkN2TkhvbDlZTVNTWC9VZmt3?=
 =?utf-8?B?cmgzUjZwSlFqZmtSRkdJcHZweCtsdnkzTlNLWFJaNng4Q24zSjBvZStWc0Na?=
 =?utf-8?B?Vm92Z2xPL2Zlb0d4OGRSUjNNSmtaU0ppdFgzaEFsbmY0em9NT0xsZk90Si83?=
 =?utf-8?B?akhyU1ZvMzJXQzUwY2Y1VHh2NXJNMzFrUXF4UHVCb2JUVWdSd3ZYTEEvWmxr?=
 =?utf-8?B?VjJKeVpoYUdkdWJBZmE5ZVkySE53Wm9rQ00wVGpVVzE4R0t4a2gzRVg3VVZj?=
 =?utf-8?B?VURsOFA5SWRrYXpjbzFERGg4RTZjSHdkZFlzRWY4SjV2U01oa01ZYUt4Uy9m?=
 =?utf-8?B?dEFkdUFYS25OV3pKSTdzeEdVTHpJd0EyNHZhUTRRRU4yT1dVU1c3SDJaOW04?=
 =?utf-8?B?M2xzd0pkM09WRnpyWW9OTk1LRkpLZFpVUmRZaGhzaVAzdTN4ak5qZWl4WUdE?=
 =?utf-8?Q?It1+d0p8gV7j2ismvndR5D3yV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7600844-5bb9-44e8-16f9-08dcbc4f868e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:54:52.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8t3315gL266KzY7nKLr16VqJggJTX0XLGfiJeChGsICe4uxLAhKkOSxx+XK5Qp0Di+UrodMZ+XfsSaR+eKb/5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369

Jason,


On 8/13/2024 9:52 PM, Jason Gunthorpe wrote:
> On Mon, Aug 12, 2024 at 02:51:56PM +0530, Vasant Hegde wrote:
> 
>> Let me summarize and see if I got everything right.
>>
>> - Enhance iommufd_get_hw_info ioctl to get device PASID capability
>>   HW driver will implement iommu_ops->capable() to check PASID capability
>>
>> - Userspace will use above info and calls iommu_ops->domain_alloc_user() with
>>   appropriate flag (If PASID capability present then pass
>>   IOMMU_HWPT_ALLOC_DEV_PASID as flag).
>>
>> - HW driver : If IOMMU and dev supports PASID then allocate PASID capable
>>   domain, else allocate normal domain.
>>
>> - When attaching PASID to device (RID), PASID attachment will pass only domain
>> supports PASID, else it will fail.
>>
>> - IOMMU_HWPT_ALLOC_PASID  flag is optional:
>>   If we endup implementing this flag, then it will allocate PASID capable domain
>> if HW IOMMU supports it (It will not check device capability).
> 
> So how do you get a PASID domain with only one flag? You specify
> IOMMU_HWPT_ALLOC_DEV_PASID and expect it to work for PASID attach too?

Yes. I am thinking IOMMU_HWPT_ALLOC_DEV_PASID will check both device and IOMMU
capability. So later if we want to attach PASID it should work fine.

Are you thinking something different?

-Vasant
