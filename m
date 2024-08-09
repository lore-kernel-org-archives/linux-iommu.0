Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A9133CD1
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723185842; cv=fail; b=QuryIyQ4IoHyK3y9js5hbQUTTQ92s3sBWFFimb6zhuOqBB5oP6mPaeQd5JZMxVlD9DFMkleGgnw9hotnzh9OXLxqfo0cFOryX2h1OCwElGlhxzIKHLjtf1hiVs9moHW3+OMAI84214v0FUAF1H8JTuwquGlq4m2HvnLx0G7VmN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723185842; c=relaxed/simple;
	bh=PLgy/5NWaK+Zq213OAh4AE5mkBXQyI4NDFepBuh++PA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qeZlwe/1qU57V+Ci7zNw3XBoFOMHmsCR+wGCnFtRHovqcCFxEpg4QF8xHhf9gozCgU9cN0ZvoyTb5EiMtLVSE1l9ypYZ30IAFhlRKv6t6xROcYCNBOXQvcfPRXMqQU9np/DkLYHDcudRXK5f46aNo2aWy5kM9XJr7Xc0y8y+9XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EfmHVT2c; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EfmHVT2c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpxcSPLFGjVZ3adDNVmBMrvvMIdG+2CrBhCoPCxVybNbAn4Pam8hsurSwqfvDIiJ9Rj9F+QZ4bVPZRpxX1AIxWZoYFwmITPuoJDcUZtsfvmaWxoHNy2+SjDpSkcTDwkmaHc26c7G/K3ToHlcf34kBDaAPscZQkxHyef1LW7Wq3Q50ZkTZ1KTzz1+SYdmJQkZXDDOJwZCnrwUeOIRLLGTWLU5e8tQ3ux1ZPz027wMJ6gzWXI6IOb5rQ7EIEOcfVYUHda1bSpIPVMLveqpiQwUbDh5RQv1Sn0jrdQYi5fk9yPn8Yqb7rGHzH6lYB2gDQ7LbBaFwXqCFWjyvFpVVL6LuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8tQdpTZbUk5iM6aDyVSYVTxH0J37gSrRLGn5D/YJk8=;
 b=Pu+QctD5du5ie1ya9UsCOdfehQn+zszykxvlzJGhlMTRvaxxIQ2JGgVkU5i5WSafM5shGT3bw6Ezz/HCyoYTG+kj5HsIk8WfZnO2KCWOfdYEimMB3eTfSMi78IBwvSa8UTUQc+pJPPO4EoSvHXykGmcEhUPrxklJAv2YeN0BmBXMry0I0IQBFAtKAGdX6c8L8/XD4H/f5hKqYwXPg6i0LUgGHlLtRuX5hel51BsYQ/t1OCz6ZjwhoYIBSEhZ2OrKQkHdn6oi/ivOSUfj6ZIUxe9+2rnbLmUPebGF6wt1n/oNjQ+7lO7jQin3X8pk5yiPLpsSc8WtoVo/cV09XyycBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8tQdpTZbUk5iM6aDyVSYVTxH0J37gSrRLGn5D/YJk8=;
 b=EfmHVT2c3zknUKMJiM//z/G4rzAAYv30oC1KhQH0ueBobDCsJEHAvh1ARZj+6ty1z24CH8LurJJsLikQ4Up04fdTj1ov3rjm9PRqD5j/4xWTLnoU62hz2XwLzJDpXh8a8Xumdzy1g4E8Sj3OjJn+JAgJQa1zUNW3h6JwVfXOztM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.15; Fri, 9 Aug 2024 06:43:58 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 06:43:57 +0000
Message-ID: <11b95737-e0d5-43de-80ba-69923ee8b249@amd.com>
Date: Fri, 9 Aug 2024 12:13:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 Alex Williamson <alex.williamson@redhat.com>
References: <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
 <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca> <20240808011629.GJ8473@ziepe.ca>
 <20240808130814.GA1985367@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240808130814.GA1985367@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: e1131a4a-1acf-4c88-1427-08dcb83ea4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1BvWCttWS82UjZ6ZUVvWDdodVArdjM3d2UyYThEUE54a09Ya1lFbitCelhs?=
 =?utf-8?B?eUp1eHZlbEdNaVZmYXg2TURqZ3NsTW9SSUM0QVRWZUlNQ09qT202aFFBY3oz?=
 =?utf-8?B?WWE3V2pzOVVpRUIyWjE3dTRnY1Jlc05ydGhmWWRKTnczanRtTlZsSHhkWlk5?=
 =?utf-8?B?Mmp1NE1rd0tnRlZrOHZTd203T2JUS2twSTFkallnai8zNnVTSTRMbzg4aDBt?=
 =?utf-8?B?L0xVMmRuS2xyMU42bmdmS1pmVnpsYTRPYytySkVLTVJMVjg0V1Vpd3E4ck1J?=
 =?utf-8?B?QmY5REVRZDJLR0NrOTN0Ym0zdlJDMW1oMW4vejdjcWxOcnQrbVk2TW13WmtF?=
 =?utf-8?B?NEw2ZkZxY0FVVjJjQzdRNTQ0aU1sRS91R0c4TlZ6N1Yxa0xjandKVmlpbEps?=
 =?utf-8?B?cGhiRUZVNEM2ZFg4bXRhaFduL1RBWDNCQVB1QnBqWGFUczFYOXVYWk1kUTBy?=
 =?utf-8?B?TUZwNW5SWDhwcmhGT01vY3F4bi9weEU1NkhESlRwWGRUTXM4SVVmNkhnZGlL?=
 =?utf-8?B?eWtnWHhHWW1sYm83UW5ybXlOT0gvY1cyZVpQcXZKamxBOU4xREpsWG5TN05w?=
 =?utf-8?B?aDBaSFBMUzYydlozSkRhV1JWeFdFRTE4blY0dGU4cTBPcVZPOSttcmQ4WU40?=
 =?utf-8?B?R0t1Q2k3VGJoUEZ4OUFaV2NjcTM0Rjd1dWVMS0tzZnoycjNyeUVTKzlxWXRw?=
 =?utf-8?B?NmlRN3F6NUdNbmJ3Kzg0Wm9kaHkwWVJpZHlvMzh4eUxNdnY1diszRjJ6eEIz?=
 =?utf-8?B?YmJxci9laGJXMDN5WkJHWFkzQlRyV2JJRmVYSHNpTlY5L2NRQU5sci9teTRk?=
 =?utf-8?B?dHplYzJ4WmkraG1ibFo0WVRpZUhwZEQ0UmxXcEtUUmFGbm9Xc3ZhZHl6WC9P?=
 =?utf-8?B?V3FFQjRuU1dueEFIK1lpTlZNRk1XWHBVbm0yNEZOc2pIMWMramNUUkJpYlBY?=
 =?utf-8?B?U0FBUDRpelgxczl4NnpaSG1wbndIUGRBUTJqNkpTcnJ4V3RrbkJnM0xvTWo1?=
 =?utf-8?B?UU1qRlZ2Q0hFR21ZT1FOb294dk9LV0ordUNYUmlFL2pic0lyZlljTm1vWk9z?=
 =?utf-8?B?dmNGYSs1eUxvcmVOTXIvcWdXcGFBbnFzNGhWY2UxcWdMajQ4Yy9EZU14blRB?=
 =?utf-8?B?cjBQVXlYOGpWczBiRGN1ZUxON2R4VHNtUEJhZWo5VWNIeGpKcEMwMTNCVi83?=
 =?utf-8?B?RmR2LzRIRmxQMGtiN20xbWRocUxOU3UzcFFkYk16NzFOQ3owQ2d6WTFmOUZa?=
 =?utf-8?B?NTUzSmdHdHZCUUJQdHVnUm9Ya29ZT3dtRWxHSDhidkd1M3Z3OTN0Tk14Q2ZW?=
 =?utf-8?B?R1dRcjdjeGlaK1lEUjJJbU1BSWVnZXpZTHNYQzkxdThDMzM1TTFzN083dlpM?=
 =?utf-8?B?MW9GdU5Hd245VVZrUFY1cHVrU0s5cEszbTUrVmp3VmpSWXMxalVOUTY4QmFl?=
 =?utf-8?B?NGczb1F3SWtOZkd3cFdNNjBwOHZ5bFh5MHRwWWN1Uk5WOS94MWtXL2JsRENE?=
 =?utf-8?B?MDVzalQwYlFWUkpoNGpJZHI4UUNNUkZPeGVzWEJaeXQ0Uzh3RVNoM0xsUlFH?=
 =?utf-8?B?TU0xOURkb3JueTlySGxnMEtjWWZyQ3BHTjhBL0RLNlNGTTBRQ1RlOGpxWGJD?=
 =?utf-8?B?WFErRWUvVzV2b2pac0I4amtIVjRGekxhMmlVbUhmZHBER3BieE1JM3pUYnhG?=
 =?utf-8?B?ZXR3OU1UMnA3T3BCNzA3R1Z6djNxanoyanV1Um5yK2ZFRjIrLzhxTkN3RDN6?=
 =?utf-8?B?SmlIR01QNEhYdjlFYVRzNmI5cFFVaHZXT2ZLR3V6NlNvcHNGYktaa2Y0aGtU?=
 =?utf-8?B?cGU2RUNDeFJVUGtPQzJndz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXVxeThwM3N1QmVFcDVRaldkR3E0MjhnT1pibjAwQzd6NHd5MW5CamJkaS80?=
 =?utf-8?B?V2Y0UmlIZldtbTJxYWZRS01wNE9FR015TnU2WWxCa3M1VzdLNjNZNVlySmpm?=
 =?utf-8?B?U2VtbzBoZWVyeVRMcUN1T2FVVDlabDQxdmVvY0Yvc2k3a3pOaDhzM3U4c1hw?=
 =?utf-8?B?Ykt3ODJ3Wlk2SjhuakN1NnErczJLQ3Y5SWJzalhYV2dtQUNyYzlCbWFXNjMy?=
 =?utf-8?B?cnBzc25EbVVCSHMyeUsrODNIQ2hGT1hwbXhjU2gyM1kyanNsT3YvdEpJdTRD?=
 =?utf-8?B?RTJPWENNK2hMNkdyelpXODgwbHB5OHZhYmxNUjdjY0V3ZFp4RzZ0MUxtVDA0?=
 =?utf-8?B?R29CdGc4czdvMzZrZ0tLckNoUnJZTjlIcEw5aFQ1VFRDTUVFZmIwbmcya2l4?=
 =?utf-8?B?U0lQWHdRMzNyeUtkVTlKKzZRc2xTOHc0NUdzeWdYOFlXNUNrSzJ2eFQ0SWgx?=
 =?utf-8?B?bE95ZXVIMHBIMnhuNzFVVzBJUmVpTC9wTVlJdjd4K3NLRHk0M0wrd1NEZ2xY?=
 =?utf-8?B?OXdLb2QwZk5VeDRCajRPb0h0RlJ2NkJBTkFxZHh4c2dydURUV3BzclFUM3hC?=
 =?utf-8?B?SjNzQzdZSzhrcy9SQ3RrUzZrODN4TDBsbGNFRUJGSGpqVC9UKzZxNHJ5WUVQ?=
 =?utf-8?B?MVRyQzBFZVNOZVFlOTZwRGRoR0RqSWlpNXJwbXc3QVo3alg4VDJhWFJoTmVY?=
 =?utf-8?B?RklJVWVEZTlGcXVXbUZya3R3cjhjR3loNW54bHJpaGxBMXJDTTVJWGE2MTAr?=
 =?utf-8?B?dU9iTlRVWW9xYVhGOGFhU1d4emxhRnJ6WWllS0pGbFJJRXpNbDFxS010Zjho?=
 =?utf-8?B?Q2E1S2U3cGoxZW9aOTlQOXkxTDlPOEJwNmJnbDdGWitxWkwwL2gwa2ovLzdR?=
 =?utf-8?B?UUtEYktjOVkvMTRDWnhFZzBvQjU5d2NncFExdEpycTZqRWVyZUZlNHVNdW9r?=
 =?utf-8?B?dkh5L0l6WXF3NEtaT25NWUhlZk12bC9wU1NDRkcweVpDQUhxMlpKQldydnZF?=
 =?utf-8?B?MVZRNGd2KzRUNE1hUXhWcEFiMFAyV25IcitsaWpNL1haaFdITXIvcElqeUpz?=
 =?utf-8?B?UFE1R2NJR0NBVStna1RvYUhWYjBSZjl5dUJkbzJFcW96clEzS2VEMTkydUpL?=
 =?utf-8?B?dHVEQ3BZN2E3NHkzUGFaajNwU1VHamFEeHJsa0hzZFFobHVPdFBQeEpoblQ4?=
 =?utf-8?B?M1RwVlZDQjZobjVmZmdaUkNZcTRVUEpqSERTVjdPOG45dlJ2cE4xbTh2amY0?=
 =?utf-8?B?RXdrOStsVVdZaEE5ajZNWS91ME1KQm4wRkNvczNKdzduc3hSUktiWlE0aWVu?=
 =?utf-8?B?VkdoSTUrMjE0QVJkL3ZNamRocVBkQ1JkVkpNOTVKdlVSaW96RGwzdGpJc0dr?=
 =?utf-8?B?OWVBbkNLOUJITlltby9xYWV0cWZYNEc1aTlGY2xhMWh3b0hsbGdEbHpFaWp5?=
 =?utf-8?B?L2w2TE5GYWdQQzlNVTVvTlhRMHU2VVFCR29QUGZPeDM2UHE1TXozWVp5ZjR0?=
 =?utf-8?B?TWpTc1JMVWc5cjFFY3Erd0VuekNsdENjQmgxL1l0dXVoQUpJM0lYenVqTGdw?=
 =?utf-8?B?NXRVaHVuTFEyT0JvOWhVa2U2TjlSdDRDdGpRNUdwdTZjWXdFTGFCZXN5RmtV?=
 =?utf-8?B?WTNWNWJST1lLM3laZ1FhOVE1R29oMnROWWJoWFJMSlNaM1FpM0N4SkQ4L3JZ?=
 =?utf-8?B?eURRalVHaHBOYUVpb1JhU1ZpeEdPMTdRcTV1TG9MWW9IMCtpYnlVL0hVNEhW?=
 =?utf-8?B?RzVvTWdoNkF5Y29oS2M5TkZxK2ZvMDBiWEE1YWswa0laUkh4Wk5heXpvbDlT?=
 =?utf-8?B?QjdQRzJzY1ZaVGg2QlFIdWtTdHFKaVJYSmJKMVVNc0dUL1gvb0JQMDRZbUVW?=
 =?utf-8?B?TnpTMFUwcWNUczEwcTgvT09KSXhkN2d1R2JhY0tBdHIyRzRiOS9pd2Z0R0NX?=
 =?utf-8?B?cGllMXpmMmNRK0xJNjMwOTdORXhMNHE2eDN1TVphbGhBalhrY21tSDM0eEpz?=
 =?utf-8?B?dU1wWkZ0MU4rMVN2THRUM1pvNXlCbXhLdEV3Q0U0VDVCbi9SaFdMbmhPUTBH?=
 =?utf-8?B?d2dVK2ZwT0xJam9DdEdHYy9UY0Z2a0tnT2M5Zm1FcmVUQXF4RHhLYTFlRURs?=
 =?utf-8?Q?cqkDrOdoaLjh1nLvaF4hGWzp7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1131a4a-1acf-4c88-1427-08dcb83ea4ad
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 06:43:57.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dx+IcXX171t22x+txEDrhBnmIX6mVrvwPwXPMqOHTGJFnA9gZJoGSnsO040jLpkxbkv6fmn4oWmzbVGl3RjwlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514

Jason,


On 8/8/2024 6:38 PM, Jason Gunthorpe wrote:
> On Wed, Aug 07, 2024 at 10:16:29PM -0300, Jason Gunthorpe wrote:
>> On Wed, Aug 07, 2024 at 03:29:47PM -0300, Jason Gunthorpe wrote:
>>>> @Baolu, Do we need to make any changes to intel driver?
>>>
>>> I think Intel ignores this issue, they have nice HW and their RID can
>>> use both of their supported domain formats in all cases.
>>
>> On second thought it does need to accept, but ignore the new flags..
> 
> And probably HW that does not support PASID should reject the
> IOMMU_HWPT_ALLOC_PASID flag at least.


You mean error out if IOMMU or device doesnot support PASID?


> 
> Maybe IOMMU_HWPT_ALLOC_DEV_PASID can be reasonably ignored if the HW
> doesn't support PASID.


You mean make it as optional flag? Meaning if HW doesn't support PASID then
still allocate a domain without PASID capability?


-Vasant

> 
> That would mean the SMMUv3 hunk I sent doesn't have quite the right
> validation.
> 
> Jason
