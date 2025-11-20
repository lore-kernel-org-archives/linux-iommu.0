Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6411A284B25
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763619752; cv=fail; b=gqnnRMWp4QLtUCmrO2Je5wt+BaK5t5hVTx0t6/27UIIdK9DdDoHJ56nPJXL5EbVQYxuemCc+ZPqvFA5J9hlKKIEhWzblp2gSoT/gOaNRw/ybL9p/aJTn48d1CSr2XJnNE2x9DOLMzLdUpcHjYkJDXUbF0ePlJ3BBVVy+KqDfJS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763619752; c=relaxed/simple;
	bh=amQvSZhDaGd5H5ZVQ+IdHZWYKhgBrWQD/n9z18NElgg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EcTXlsxmK1JutnvLILAyTcVuy/Od3AfLWgoqUS3xOmqcAOFEnI9SXCwvtXrnjMg1K9Bdx070JEDcvwyLtsn0UDBcKbY3Yb0ESrQj5KHEnDhOgq5aTH7Yo3IyXkVwFuBmebIvF5qLNapjXpE0/Bt3KRlvhM6q78btrftwQ+aChBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R55SBuGi; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R55SBuGi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r62uByALRHkXTmFYE6ztKgEjc1R92pCrBKmfW6tLalvJDKl3jYZE+xwsnk3SZCKb9P4JB6xFNYNFZQZjTBuWKIuddyM6sLs+dPf5DTLEeH/PwsghaL9JBCEDJZrz9BuyzxUGyZrHbf0qpHDjXptJqNdNjac5z+eYzwnCAHC865pMM2Fl3HcXZ1iHOjVdNUDtOnNVK9rXOXCKBrnpX+69bNfV5f48UbBbXvpUFxYvJO+v2oOktKTSkwQaY8oTvV4DEYMP9mwlwFl4zRkWeUDulp7vUQjHJe/Eq4DHVufW1luE2JkGTSs+WPgsvhZ/wPV51xA5zplRedH3TwZt4k2vgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZXFJyaBgyPNNx14H7zj0z1Se09yXETq6WDjSta1xls=;
 b=oSG5PrevhHWfDg7GrcOiCCCrDAeCJl3dbK4WLJpW168Rh1kQ+CXLYoHpIn7Vg5s0kIpAGqUEVlZxP48sMRONE7OG7r0uYVd5hifOjf+xcKu9NjHL3RWuqDREiwF8hZkKTK9k99phyX4QhhgRqv0xiL6NrDf/B+Jy40Xrdmo1CVUnSFeIv6bU4EgQiAXp22ThkobD8ublNhTojnG89E4buOyOkruMDEUhGlPJlgSbIX5auAXVp34G6R4f/qj3WV/yR8kDYiOx21AekVUeZgvoAi7L84sgsWzOh1W6U1RvtBN3dBTKt+N/7Ov1tJBHw5JlrHfbhVndZHJ4aBvSs1W1Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZXFJyaBgyPNNx14H7zj0z1Se09yXETq6WDjSta1xls=;
 b=R55SBuGiuOMyg/A5tnmr4dWEVWHMKGVMaWTgPDdPmrkzA4gRsT6L1dKbKAe5XWsciy678u8RS6l2ygKgGDQy5SAsuDkpevGwDxVDVuDPsIohgt6HmOYUXCeqOZ048NqCu0V8tib6UaQr4Qls2PvMuMqqSb6KdVseA4tn7zvaj1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 06:22:26 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d%7]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 06:22:26 +0000
Message-ID: <bc7673cb-66cf-44fa-bf40-b27185e1a6a4@amd.com>
Date: Thu, 20 Nov 2025 11:52:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] amd/iommu: Preserve domain ids inside the kdump
 kernel
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Sairaj Kodilkar <sarunkod@amd.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, ashish.kalra@amd.com, robin.murphy@arm.com,
 will@kernel.org
References: <20251114104442.23296-1-sarunkod@amd.com>
 <20251114104442.23296-2-sarunkod@amd.com>
 <78a4598d-5d35-4fd0-a830-a740076aba41@amd.com>
 <20251119134351.GM120075@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251119134351.GM120075@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0242.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c7a871-467f-4ced-c0b9-08de27fd2cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmpnSWlrT05mekpyS2dxbFYraVlIOEFEcDJjai81eEhVR2NYaDNUOUpodm11?=
 =?utf-8?B?a1U5dEdZNGFORmtvWVJWU3hEaWl0VHF0T3hMeWZNUjk2YVJCQ2pkUElHVDJ6?=
 =?utf-8?B?SWplbWNGek1TaVJKVGovRVk2SnNydlBCTzlqc1UxeDk1czlNTHBDSENCbDFa?=
 =?utf-8?B?U0VNYTdudUJEQ2ZaZHlqRmQvdmRzdy8vcnlWYjhXUHBQQXZMbjY1QkpOK0Q1?=
 =?utf-8?B?aXlhUkNlWWdYOFJtTmNNVnNwbDBaR3UvNW43KzZTSmxZTXFYOVBpcnNlcUNv?=
 =?utf-8?B?bDREbXhoRGhSVENRR0pRQk03ZW9BMnFOdFppUFZxUzZTckpMY1NIZ2EzMTZk?=
 =?utf-8?B?eHh5ODMyODAvN0xCdklaQ09keGdXSUc4SnRMTHBZeFU3T3Rad1Q2MnhuNDVy?=
 =?utf-8?B?Rmh3SzkzMmVNRzZJSnFhUmdyTWZjaG1HTUNsYUFyTm52RVZGOXFsVHY2MG5H?=
 =?utf-8?B?VVY5Y0JXdVR0TGsrdkhnNHBLWlJCL0hEZG9VYWk2blp2VTJIYWd2R1pMN1VT?=
 =?utf-8?B?czhwTTc0NGx3UVlmbzREd0sxdE5ISURZVGhMdzJvTWdDOWV1TUVBMGV4d1dW?=
 =?utf-8?B?bHh1VEd3ZGZTbGlxUVZ4bHI1UjRQV2V2ZlFlWUZtMnZYT3JidnJEMWRKOEFT?=
 =?utf-8?B?LzRZZUtHUnVSZER4Z2FXV29VSTR6Nzg0QU14U2xaYVhOeE03dlRqbUh3WGZB?=
 =?utf-8?B?WUtNckJtR00rYTZpSXNtQWJYZzA2cytwVmpkTDdtZ01zSlM2STlIVWQ3MG9J?=
 =?utf-8?B?WDRqaU9XcThteDQwcU5vcitYeEZRSGlQNytrMkhxaVNXdGpkdXUyM0RwUUh4?=
 =?utf-8?B?ajdNSTdkQmsvbXRLaUhWTXFtVmh4V0lEdlBKUnE1RkVPelJ5WGFET2RseDVC?=
 =?utf-8?B?eE5pZDRzK1o1QjlnU2ZBS3FHMjc4M01pbGRDbHBjb1BKelFsbTVKQlNnVnVH?=
 =?utf-8?B?aUZOU0dqWkc0UFZMblAwREx2YVFBVVRMWUdOSnNYcDhjakhIWkxFNmVBaUI0?=
 =?utf-8?B?Ry95OFBNdWFLa1VHSnQ4aGdLWXBHS1BRRytGUzNxNllWOStZQ21DeTdEVDhC?=
 =?utf-8?B?SVR4V2d0Mk1DbkdWRWpvcHVkaXZka3MxTEJaTmhRejVrUFhYZEk2cEd5WGpY?=
 =?utf-8?B?WElLaUI0YUNsZHR6cStocHE5QTZTMWJDRjJOZFB5UStCZnc2RlYyajZucGNK?=
 =?utf-8?B?endOYTBsOEZ4eUZJTHdLdmRuRUZmbGVmM085R2pUT2RYN0c4V2xHNEpEdTdu?=
 =?utf-8?B?Tk1ES204TForV3hZdjBSaUJ4OTBsQ1FBK3FRYm01ajdjRHp5Rm1IQUh0MGpC?=
 =?utf-8?B?VHZoamNCOE5uVGQwS3FvUDU4M1gvbkxmOXU1aXNyYmhjd2UvMFAyRWhLY245?=
 =?utf-8?B?cWlaVVRqQngwZTlWMTd0aUNyRFFreUFDelRNcG96ZS9KdFR0ekxMd215SmZw?=
 =?utf-8?B?RWhMMkgzNkd0SDBmcXgraG15ODZ0dkl3cFdWU1lrdDY5MkRBd0M0WG1jT2Fq?=
 =?utf-8?B?elZMR1kzcWM2Z2h3S2lpRWszSTdVMXlqdGVxUTNDL3J5S1RDd0pNaW5sNjZl?=
 =?utf-8?B?NnNFVVlQeHdxRWxzMEg5RUVQeHVKeHRNZmRSc1Z4MkVkUitXUDY1S2dtdVZE?=
 =?utf-8?B?WTFsL1pYdUMrckNRVmlPbGt6UjFNRlF6Yk1ZOGRFMTdPTW5ONXRwOVdEbldV?=
 =?utf-8?B?Q2VWNG0vaDJqNHFzTTFEYXpSam9pQlhHN3lkSHJORzdBRVdIVU0vRENmNVFv?=
 =?utf-8?B?MTFkMjZIckN1a3JvQWZGdVB5enQrT1FwUk94TjZVVk81aWIxcnRtYXNOOGtp?=
 =?utf-8?B?WkNlMDVBQjc2UllNRElYd0dNdzdUL0Era0U0a2IwQnVqUzFIa2dHVGpmZFdz?=
 =?utf-8?B?ZmwxemV5NGZQcVVMdmVnU2JHM1ZYdnpvazluZkcrMmQ2RkU2NEFaRU1PczVN?=
 =?utf-8?Q?0TXuozGVlQ6M6rIgtciVmwsvumI5miCs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1F2T3VxRzk3WmhvSWJaTHdvQjNxbW1HYlNRQU1Xa3RuRThJRjBKQXVRdUFw?=
 =?utf-8?B?RGJseWVxTzREZUxzVk4rdnlLYzhmR0JlaEJaQmtSOFhDUUgwNTFhcVR0bkl5?=
 =?utf-8?B?T01OT213NDFyZDRQTEkrRlQyWk5Ma1RDb2xIQm5nOEExYmc3Q1A3SFNkYlJ5?=
 =?utf-8?B?Zk9GQTgyOVVDbDczU1dsMjdIcVVYMTNGNExUckZFaTl2TW04NUx5Um1RcnRj?=
 =?utf-8?B?OU9CbUswNHlpSkdKSGcweS9zdWZFN0RhVjlGdmJaVmNiQk5NektkYkY1VS91?=
 =?utf-8?B?aER2RU85L09iNFcrY0ovSHkzYWtMNGVUWHN0ellYUld0dmZoVnFobE52TnBq?=
 =?utf-8?B?ZTNqSlUxMkx3NHU2cXBEYWRoQW1wUXc2SXB1V3NmVElGQzR6SER0MUNEdFVz?=
 =?utf-8?B?NTlyQ2tudHBmc0VWOWVhNDI3c25HU3RoeDM1WWx1ay9oTkFSb01XWVVLRnp1?=
 =?utf-8?B?azJDZGJRajI2Y2ZVLzcrQXdaYm5LMVVOdjlzRjcwNWhSdEhSRDIxT3hjdW9X?=
 =?utf-8?B?NVdyVFpqTjA2eTJvYXZLMldHZTB3SkMvZERrRXhzRmlNZE54TFMrcitZV01p?=
 =?utf-8?B?My8ySS9qQmhrWlV3VXp2dkxzYmZyVm1IdmNRNWN5NGdyWTUvdkl3VUlKc014?=
 =?utf-8?B?RUdaN25vbXBsS0NqUTNPaWIxK1BQUlZ4SlkyM2NWakZwMnVEdmtTUEV2N1E3?=
 =?utf-8?B?SkgxRis3elYvUjh2d3Bmb0pRWHFMdEd2NXNOME9VODNlQ3JFY0Zzc3ZyZGlj?=
 =?utf-8?B?di9yVmhKbHMvZUZURWt4OVJCd2dSTktKUmpKckhYTlUrZUVHWThnYXNPenV0?=
 =?utf-8?B?L2tOQ2hoVnM3SlBvZlF1T2o2Q1QrdkNZTTA1Y25UbGNkaVF4RlU3SEhQTTVM?=
 =?utf-8?B?MGpIL0Vkc29FSTU3RmJqdnVrWElzTkVkNGs1TkxCdXp2amU2b0gxMWZsWFdV?=
 =?utf-8?B?cXVOUG1RY3pRR1NGOGhwS016aUJKNGxzNmZheFhUQlZLTXJpV2JTSTZ0VVBX?=
 =?utf-8?B?T1QzcEw0S3FlY0R3bEtILzZZM3ZKaUYyZGtKSWh4TXN2V2pjdGtsemkxWThk?=
 =?utf-8?B?WWlveWxobVhEcCsrVXorS0x0ejVwTGJrMHdHOTk4UDRRR3NFRlZJMGNaZHNL?=
 =?utf-8?B?OUh6R0RDSVU3NG0wRFZnSWswVVNnajJ0OGtWZ3BDYnBTNCtPUzMzTCtnTDBu?=
 =?utf-8?B?ZVRrbmdmN0NmdEVTYWpSMldNOUMrUlpZNUwrSEkzN1hrN2NiQWx2eVJUSnZE?=
 =?utf-8?B?WU9TMWNRYUlFR3EyaGVGNEgzdDBHYzBzQnZLNHZlenZJVzNWVmdvbWdqRC8z?=
 =?utf-8?B?TStQSCtESm1jWEF5eWxFdStZWW1TZ0p5d3VoOVRKcUJlT09PY1ZXVGVEbGhx?=
 =?utf-8?B?NmhPR1pKbVBxQUpIMjlHWlVDRTV0bFhUb0JDS3VuVWdLRXZqck5UVFNVQytC?=
 =?utf-8?B?a2dvVUFLVHc0MzFSRnc4ckk2NlVqb1RaNlNONmZIQzNEMUR1WFlWT0dDM1VO?=
 =?utf-8?B?a2hMOFR6YW1qNktFOVlsRTZGU214bEd6bHBXdFpFSTV2SmRoYTZ2a1IxYUxn?=
 =?utf-8?B?T3kvL2Z6T1IvSE1XR3BaUHZaY0V5dFZWaVduSUVOM3Y5cEN2NmlpZTRzZTdq?=
 =?utf-8?B?N296L1JJR0NtVVFYSFlqNFhtaTRpUVhWZFVpdVlITlJyZVk1Vlh4WUNuZ1ZZ?=
 =?utf-8?B?YWMvUGVEVmhIU1NWdEJWc3FhdVVXVzRSL0Z3VHJoMGpKeFVPUUtqcjljTWsw?=
 =?utf-8?B?bVhWSkxmakxIRjBCNEpvbGtENTBJaDAwWXYvSFhIMEVQSXRTdkFYTnhOUlQ0?=
 =?utf-8?B?WElLOHNOT3gyVE9XUFR0NFdBZmR4U3RBSk54VHJrMDJRUElMTnArNStWK2t0?=
 =?utf-8?B?QndaQzlmTE5QdUZBck04RHlkQTFxSFU2dVhhVURjZkZ4ZXZGL2N6akFoQzc5?=
 =?utf-8?B?SG03REc5VnY2VUlNMXBhNWpIOEZUUjlEaWY0NTZITkpNRjJqaGRXUGJvdjVh?=
 =?utf-8?B?Tys1WXBKRTdIS2NRLzBKdEJCdkF3cTFqU2tMYnd2MzEzb1lSZWpNR0pEV0lv?=
 =?utf-8?B?MWtzRTVlcUw0MWcvTWUxNXAvZUo2akg1VWM4Skc1MXFyVzdCQSs2UXV0VmJ6?=
 =?utf-8?Q?JdLKZC97xF4LzM8ttWq0rWC9G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c7a871-467f-4ced-c0b9-08de27fd2cb0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 06:22:26.7289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20gOVnEthohs7369a3EsEaCQ2n0x9dFKl0Ax3W3t1lEvpPJnXs2PiO8dMLzv4oA2cKfRf8zmaDtm1o86Dq20jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420



On 11/19/2025 7:13 PM, Jason Gunthorpe wrote:
> On Wed, Nov 19, 2025 at 04:20:28PM +0530, Vasant Hegde wrote:
>>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>>> index f2991c11867c..9375fba1071c 100644
>>> --- a/drivers/iommu/amd/init.c
>>> +++ b/drivers/iommu/amd/init.c
>>> @@ -1136,9 +1136,13 @@ static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
>>>  static bool __reuse_device_table(struct amd_iommu *iommu)
>>>  {
>>>  	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
>>> -	u32 lo, hi, old_devtb_size;
>>> +	struct dev_table_entry *old_dev_tbl_entry;
>>> +	u32 lo, hi, old_devtb_size, devid;
>>>  	phys_addr_t old_devtb_phys;
>>> +	u16 dom_id;
>>> +	bool dte_v;
>>>  	u64 entry;
>>> +	int ret;
>>>  
>>>  	/* Each IOMMU use separate device table with the same size */
>>>  	lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
>>> @@ -1173,6 +1177,25 @@ static bool __reuse_device_table(struct amd_iommu *iommu)
>>>  		return false;
>>>  	}
>>>  
>>> +	for (devid = 0; devid <= pci_seg->last_bdf; devid++) {
>>> +		old_dev_tbl_entry = &pci_seg->old_dev_tbl_cpy[devid];
>>> +		dte_v = old_dev_tbl_entry->data[0] & DTE_FLAG_V;
>>> +		dom_id = old_dev_tbl_entry->data[1] & DEV_DOMID_MASK;
>>> +
>>> +		if (!dte_v || !dom_id)
>>> +			continue;
>>> +		/*
>>> +		 * ID reseveration can fail with -ENOSPC when there
>>> +		 * are multiple devices present in the same domain,
>>> +		 * hence check only for -ENOMEM.
>>> +		 */
>>> +		ret = ida_alloc_range(&pdom_ids, dom_id, dom_id, GFP_ATOMIC);
> 
> Is it really an atomic context? Why?
> 
>>> +		if (ret == -ENOMEM) {
>>> +			pr_err("Failed to reserve domain ID 0x%x\n", dom_id);
>>> +			return false;
> 
> Please don't print on ENOMEM, there is already a print.
> 
> I think you should also keep iterating as other dom_ids may still be
> fit in already allocated bitmaps. Though the system is probably toast
> if this happens anyhow.

Right. No point in continuing if it fails to reserve the domain ID. Things can
go wrong. So it returns error.

-Vasant

