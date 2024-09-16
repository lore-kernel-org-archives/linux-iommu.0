Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBB15A84E
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503121; cv=fail; b=STzgvovz9cnLR/8y2UInjoK54LeX6/M2cMq7h/30UshLq04Ed7SwfHV7+8vQQAFBG0PI/h6ZTFekhYbyLG00j8rCoXf8oYBe7dL+5t4WTXUo6ICTjZ9kuQ/8+pZZ3obZKEl99uIsZ7Gv+/efmFxtsBXzUoHkDkmD2vObWDbHNp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503121; c=relaxed/simple;
	bh=+uN9ld4OeoPLCWgWtPqaxS6RJEHvV0wP3aF36PXs7UM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZCWv9juB42z0vsvzDqMa+SYXGNw58Ut4YMGJDaON87uQS3q1ChBBOZVysElgVlQuccpbOK4oMb7/ALZqirkLtPvLx/BAsP7uPqdasHqEidioO3tkPCkmVVDypww1FIFqi/3RG1gees7nghwrRmQj1IyztiefQFfTV73Y8+g6Yjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zdI8MWaK; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zdI8MWaK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EY0mJB6rowjMtMoXDlgLm7J6ZtYndyoWGOhL/vSvlvLbWfxig52smnxER7rcpF+rPoRtqsfKTVHNrVW6cXzfj5ZTQggoGCty9H69CNIWh+Bt+g141IKs0gZ2LUfcm9qzYG2ttQGCgLFU1cZTNA6q+NIg2wPvULgdOd03KZVU7Y+gAcffHYvuUZ7VWJpXgb6dTrrH+S/ncQxwnmeeIpQ0xBqNTNupoUvj9DVAXemjUQBvG/QL4xhEOu1fLMAnlSU99/KNfyLGIwqa2xaogMOP2k5ScDmWudA8ioYiIAnisMRzaPW13E5YnbyD4+7WJHnwULukA7wBCp4P+aKn5nJ/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts9Y6o9P6bjLFDf8AhpS+QcKDyxX/j2k9ffRoA7jEo8=;
 b=N2YZg36sFCUFtjvYnHuLkMsAZJMeslJUC1hXaWG52NSCSoN5L6kw7qup9neZVGPPNhkSwAwy6Gz5CA6NKKNp6DkwK82JbEd1wbLaXNsLTNLsZWwbe0eWI2ZrVzIZsLVTPlOBreDhFdAw6tfmlPjH2qWzGXw1zapg6o1hSzrfUuD59BhkdVZecrqpjxyA8dSn2Ano63QK13kP9ZnPXGRrMt1V5vc3CnScWEc1oE3fWPgnBUnTjz7iLwHixhyZ7aMn02GrRYJPFBlPxqeFvvtE6uYJxZ3UHq+BMSxgqupxn+e4PKEhbuNOEOmTiaroTD1UEVORU8qxvD6I/USWSPu/Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts9Y6o9P6bjLFDf8AhpS+QcKDyxX/j2k9ffRoA7jEo8=;
 b=zdI8MWaKvdEmtOy1Uono0m45pCXqKMtd7qVNiMMclEldVEVQiDKIv2xWwo3aUkT050E/+C+tuPPrbnpMgyHa+z9HjOuGnIrzFTWIezsL79wQiKKfP1QWwGMGruLQ+hZiABSwDjba2eMoIeYydvlfpyS3tGf8wKpUKku9te2tue0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.24; Mon, 16 Sep 2024 16:11:56 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 16:11:56 +0000
Message-ID: <5ff8adab-42c9-403e-9822-8f4fbc259d07@amd.com>
Date: Mon, 16 Sep 2024 23:11:46 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature
 is not supported
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
 <20240906121308.5013-2-suravee.suthikulpanit@amd.com>
 <20240906163818.GK1358970@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240906163818.GK1358970@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e51be1c-bc25-45a4-2b74-08dcd66a4804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHN2Y3FqT3VRTWV2VVdndlg3ZmxZWGhMZlVOTURLZDhwSGdEd21ZZGpFVXZG?=
 =?utf-8?B?RC8vQXNWcUFta0lNR3dyek02NWF5ZnVzQ2hRNk1PQWlZMVdFaks1V1NiTG5l?=
 =?utf-8?B?UlNyMDBsajBTdENET1JmSTdHdG4vdEhKM2dweVEwUTNxNVhKZWtHZlBpekt2?=
 =?utf-8?B?TVZtSUZXakZtZnNTRndMMTdqSWVzUHdGY2ZaamRrWXlNU2p0dG1BZUoySG9R?=
 =?utf-8?B?VmRJdmVWanRuY1RRenhvV3FGd29laGRDLy9jL0svSUZITkxFVXJxNm5OOCta?=
 =?utf-8?B?Zy9RVE9GRFMyUDN2a29vcEt1d3IrbkhBTkt0QklueVdaOWR6cjZQa2E1Y3gw?=
 =?utf-8?B?dlJiSkpYTitMM3ZBWXVWNHFMWmUvR3lDbDdMM2JnN2pGMnRZR1hiS0ltR3ZF?=
 =?utf-8?B?MXNtOVJ6bGFCMDJaRHZqSk53cnYwV3BycXlNU1E5bVM2Mkp0alQxYUIreE9y?=
 =?utf-8?B?UDE4Vi94ZVBNaUdmOGFENm4raWwyelBTZm5sMkh5MjVwR0dBc3JGSGRoL2p5?=
 =?utf-8?B?ZDhNSkNwOEVtMDJTTW9hZ2F0U3EvZXZOVW4vMzBzaXkrcENCbXJlcWhxRW5H?=
 =?utf-8?B?WTFVdkxNM052TzVFbzdRWVVtVDJPMnE3bWVCT0o4WEF3ZVphQ3Eva3hvdklT?=
 =?utf-8?B?dXl2TVplZk53M2JsZ1NJRW8wczFMbEdVVlpBNTY2VllGL01CY1pmWmVUUi81?=
 =?utf-8?B?ZzhwVllNMTZlMlNJOGVNQll5emtaL1NNNGdEMEtNdUpDRXRhclllaW5rMXRq?=
 =?utf-8?B?NVVHK1grc2M1MWlvRnZNK0J6bmNVTE0vL2xTdW1zOTBieFlpdmpLWGdXOHBs?=
 =?utf-8?B?dlhRMU1LVUtURE5tMi9IekQyTUxVK2V1L3NqUFd2YWc3VUREQ0gvN1Q4bWlz?=
 =?utf-8?B?b2hNY1BxaEcxNlVwdEdnVVZkMi9RYXc3dUZzMmowS1VSSXFaVFhtekRoUWRR?=
 =?utf-8?B?cVJkUTdVc1hVOXZ4UmhZbVh3WmMvWk9rbGZTZHk2dHVONW4yMndiNHE0Wndm?=
 =?utf-8?B?VEF6NWRQWUx0WW5aelU5eXBqYUlScWwxOUxhZUhnNHpRZG4xZm1KbmZ1bmcy?=
 =?utf-8?B?aWI0bUNoVjFtWWNqWEF4ZU1EMURrQW5FSDAxOE5CNUpSN1JYMFo5dHJISElU?=
 =?utf-8?B?M0o2V2QzSGk2L0pHL0hNWXExT2pmcktaRk9vWXZUYllWQnFKYVAraE84SnJi?=
 =?utf-8?B?VDVKRHhtQlBuUjZZbU9WbVpENU9hY0pVUlpmYWEyUnRQK2RSQXJDZWpzR1FO?=
 =?utf-8?B?bTFCYVVTWTMzUHl5Yks2SE8zVzdRUkFlYjkxcG0zU2VMUXRYYXAvRDJsYXVP?=
 =?utf-8?B?RC84VXE5VTJORlVmQnVvVTVvL09TN1o0VGdBejhPYURNZ25zdXhYZXVXMWky?=
 =?utf-8?B?ZWRJZlR1eHM5dGlEbGtxUkZCZmJHZ3BKK1ZJQjZOQktpMXFOaVIyOTJtU1V1?=
 =?utf-8?B?eGowVU9NRCt5eEM2NFRtbEdTZ1ZhMHVGbGZZS3EzN0pvejlwdlpMZ0VXckF4?=
 =?utf-8?B?TXRzdzZwNDFHRisyZFIreXhjWmlDQm1idUlBK0tBeXdNNDh6Wjk5UHFBeVM4?=
 =?utf-8?B?VXd5VFVkOWhkbXNTV2VEQVZzcDNsNEQ1NzNpbUJ0Wmp3bWVUekllSHlWK2lJ?=
 =?utf-8?B?R0VWdjFGT3RJNU5OZTNLZjExcG5mNFd2QnVtalN0T2VvT29xRmVUN0g2aDkv?=
 =?utf-8?B?V2lBMUtReEErdVdYNGxMdVVlZFVsMEE3OEdzOXRjTnFjQ1pvUmRIMzlHZ3RT?=
 =?utf-8?B?UWVuTnpIVXoyQ0dzZUtRRTFpY25oQzB6MWRoYnY5ZGhqL0hOelFpMHRVakRY?=
 =?utf-8?B?UDRnL3lCNE04TWZpL1pOdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVlsNTNDa3Izc3NHWExZR3hIcFFaM0pCYk9kbXBFYnp0UTJ2b2owSXVnTUtV?=
 =?utf-8?B?RDhvRW9SUXY2alNRRWw3eUk3VVRHRnRhQ3QxR2w4QTF3R2lsenEybVZMY0Nr?=
 =?utf-8?B?OVoydi9oSllJRVZ1c0lXRkhsKzRVV2t6UlNKMittYU16aTRzRVlpdVJJdVVx?=
 =?utf-8?B?TlhMQ21KK2l5RUtwbk1OYit0V3dheTRMQjZzRVpzZWo4RG1Ecnd4L3lPeGpO?=
 =?utf-8?B?bFd2M2YxbG9JWWl1K25nbGtqZE1xSXhUaEtLT0lTak1BUE1YclRsWGtybExV?=
 =?utf-8?B?WVUyR2ZBVmV1T1hSRXhKSVpsKzdXd1hHVncyTjZtOXllTVVPLy9wU2ZQL0ZS?=
 =?utf-8?B?ajBMYXFjWXBONUdSRWdGUTZrb2R6OXlUbmNtd1RSVDhJQ2Y1dVVEaS9oTTRJ?=
 =?utf-8?B?TzZxV3VlWDV3Y1JjcHpOa05nZlFFV3RBNDE0SUN6NlJKSGUzRzNQU2hIaE44?=
 =?utf-8?B?WnhGNVhMZlArQ1ZSWW9yZkhibUZFbUs0WEwzZ09qRldUblRyRjBwRnBjZ1Q4?=
 =?utf-8?B?ZnZLTldFRUo3SWxuVW5DcGcvVHVtMHhUOHJHTCtDaFN3cDlXSXRQYVRKVjB2?=
 =?utf-8?B?SGpPK3BYQ1VHTVhJTjN4TU04dVlFUGJVS2JwU1YwbGd1LzZlRjRaQXFCdTY1?=
 =?utf-8?B?cC92U0hzY2tYTmNTS0lTK1hSd2JPcGFVTHNtSUFGUjQzUVh6M0VRaVJZUmd1?=
 =?utf-8?B?c1Q1c0E1Yk5rUERIYW1hVi91OGM2RnpNSm4ycG1JSVM5bzVHTXQzNCtKMTJp?=
 =?utf-8?B?NVRYbW9qSDhhbVVja2h5bGFaUXhrUmxhcHhBL3ZJblRRR2doTXpXVEtIN0I5?=
 =?utf-8?B?U1FRK3dHblJpT2NYQXgxT0lyUC9RWlppVXNSVFlDZmxmK1NxOGRPOFRvN2pY?=
 =?utf-8?B?MjZlbW94Mnh1KzBvQVRIbTB0N3ZUcVFpWVo5Y21CbnZZMXhnTGhDTVFuTkJY?=
 =?utf-8?B?YVIrTFd4KytPWWo2R0QzU01veXYzUzVtYjFEMUdoL2ZhTnB0czFUVlRRZE10?=
 =?utf-8?B?S2tnN1k1M1NmQUdXK0RsSnU1am81ajJyaTdkZUwzSnVUUGhTVjJ0QmxXVHpI?=
 =?utf-8?B?N1dUb29oU0h6Wk0yLythNnhrTGVHWFVOVmYwVk1xOWVYbnAvZktHVEI4TWRM?=
 =?utf-8?B?a0M5NnJaM3dHQThQL2hDRzA5NmNLTjV0TDdsNnZxeG5MM0N3OXB1R1NwcWdz?=
 =?utf-8?B?cmNwenkwZHRpaXpsTVMySkwxTUovaEJsNU4zTUpzTVZWUXcrU3RpaXAvSWZP?=
 =?utf-8?B?Q1JwK3BMdHYwdXVtTzZBU2l0TkFaVFlYK2t6RnV1KzhqSENPTFMzeXl5ZWJB?=
 =?utf-8?B?ZXMzS2RVbXl5RlQwOHJSS2V5aVl6SDM1RDRHeDQ3bXVqcHFwM3BIbVdrSUV6?=
 =?utf-8?B?cnhFeUNqY2VBOW1NemxucHkwNm84emhITVhPQlNoQ1V4eHJ3SzJPQ2VjQmtu?=
 =?utf-8?B?SVJaOWxSY3JTcHJ3OCt0Sm03czAvWkhhd3AxbEtDU2hIcGxZYTJjOWRieDRJ?=
 =?utf-8?B?eVVZSkowSjVkTytBeklhSERsVjJuZTRPNlhGKy9VNTJFa0RBUFdmNmVIYWNa?=
 =?utf-8?B?bndRYytUTzJlbnZqZGdyb0RuQnQxWGRLV1JTdGNGNG5NczJuV2xSOW5QSHBh?=
 =?utf-8?B?ZGFPUGxPemVYUm9GLzNHdWQzcEJoT28vN0xaMS9tZW8xTE03Q3Y5YnNmNEtZ?=
 =?utf-8?B?TGxodk45c3ZLdk9wWTBpK2EyL0xodm02Zklwa1RacGRHZkVKaEVwQ28vcW5C?=
 =?utf-8?B?eStOTEdCdithdnJBNkpjNkt0RmpuNGZ5eU5ncm85NE1iNlAzd00xZDdibDE5?=
 =?utf-8?B?OVllcmI2cmVXTzJvbGVFTFJZNFBXcUdlZGZVSGJacmJTcXV1cVRreVlQZkwr?=
 =?utf-8?B?b2VDM0phMkZ0cFhkdDgvR1NJV2d1TUV1VGVIWVh2Y0RiZUh2c3FhMHJQT0Rr?=
 =?utf-8?B?YUtNVGo5WXYyTEQwTm1Uanc1Y1hVVXhVVWZlY0g4K3crWFppV29KYm5xWWdE?=
 =?utf-8?B?TTVCMEhOM3hOQlE1cHdDVzlvRHVEbEpoSUpGRlVNMk5HMExHaUZJSnFXSTc4?=
 =?utf-8?B?ejFvcytSQlRnWUNnbGwwUWlzRmNiQ05iUndPQ0RlUVpaSGkvSlpvVEFnWHpZ?=
 =?utf-8?Q?gkuQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e51be1c-bc25-45a4-2b74-08dcd66a4804
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:11:56.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFQ/baXg40Eb9WRVRRXdPY3C0uEgjwHLaO3sDq0gkIq9re1j7FPs+UmK2Pn546M4lwdRBlH0hE4SRZ9oo7FnyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582



On 9/6/2024 11:38 PM, Jason Gunthorpe wrote:
> On Fri, Sep 06, 2024 at 12:13:04PM +0000, Suravee Suthikulpanit wrote:
>> According to the AMD IOMMU spec, the IOMMU reads the entire DTE either
>> in two 128-bit transactions or a single 256-bit transaction.
> 
> .. if two 128-bit transaction on the read side is possible then you
> need flushing! :(
> 
> For instance this:
> 
>    IOMMU         CPU
> Read [0]
>                Write [0]
>                Write [1]
> Read [1]
> 
> Will result in the iommu seeing torn incorrect data - the Guest paging
> mode may not match the page table pointer, or the VIOMMU data may
> become mismatched to the host translation.
> 
> Avoiding flushing is only possible if the full 256 bits are read
> atomically.

I have verified with the hardware designer, and they have now confirmed 
that the IOMMU hardware has always been implemented with 256-bit read. 
The next revision of the IOMMU spec will be updated to correctly 
describe this part. Therefore, I will update the commit message and 
implement the code accordingly.

>> It is recommended to update DTE using 128-bit operation followed by
>> an INVALIDATE_DEVTAB_ENTYRY command when the IV=1b or V=1b.
> 
> This advice only works when going from non-valid to valid.

Actually, if we change the DTE when IV=1 or V=1, we would need to 
invalidate as well.

>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/iommu/amd/init.c | 23 +++++++++--------------
>>   1 file changed, 9 insertions(+), 14 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason

Thanks,
Suravee
