Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A09D148FF3
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725558901; cv=fail; b=nUiHDDwAFZPBnX0cdGf7kaMDPw1rRV0kN7op4+3fRuAJondRpiX7QvJUJ8bZ/cu3eujznX1NVrVByhVwsHr9VhdymJvzhL4V5vrvM6zz6HrfTYPjzIn70ksERF5WUEcyFwOPfCYFW4r4LNbkdaHLJNmBdZ9lZpmtNkYEw5916Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725558901; c=relaxed/simple;
	bh=MiNrJ0xr7X+RzyO3kQGRDT+BiUs3BzxMSF96dnIXoT0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oa4P+BFImJEt6bjrdyXrtAAKxsZeJm16Z6TqeZUdx6ITTrM+adj3HaYgPc1BHM598OLvoB87M/KCksvb3ScCljNKjf3igP4pV1I46UJw1QPl/V5DkQksDXzloKqb02hSk2HhLECbmztGe9GXT1jlKXMf+DSa9QR/WUGx7c1Gplo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NiZf3oGg; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NiZf3oGg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3OlUWrocwVKPeiku0zA0RRe+HQW2cujARo5cGKyzvAzI2WazzLqjFaPgMfdtHH24cY44k67CNO7kvs8+EL0k+fFTvszHHYQNaYEs9eMH0mzVJq2vnxVoGCQpKymJJ9A621NR2QeY9Xm0sHtOfjyD/bdv4dp/KP54uj9JdoIGhXjPpAjfqiMUErAmnsD0mJSKYVyTneW6VWTdciIrX9zIo/5ktO94oNMgQi5JYnk67iVMOjruZ4i0Fq2sDZAda5la0K+QtWm1HzpBtqHcZAs0DebK1e2RQYUvAV/fNy3bqfTfYUPvg3mZNBfjzrCNnrqewGYAUE4p6iSxYnDkq4tqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RY9N2EV2OUM0d61wm5tRouCUoplBOUbOc1cy0k4axHc=;
 b=uK1k8i4IB+XZ4/4gTfj2RKxAz28KnDZM8T0NG4xkOIFZFqZEhBHScDY/Rv4idTaV5hYqLRwLEsmEd52+wsJi3bjaGlMFh2Nj/X7SvkkXoyWt4lR12wxPCrnuhMgtW7YosGIdojx9+q03FlNW6zfIUlpErtK3kCTN1yb3OJ8G079aPj1snqOK5lscMfc1C6VZRlK3iqK4N/I2RWkogfk5l7AQpDh03jKfbvIV1AyK7HqUiJJVPO+pqX5qFZ/HVw8yCsMD3nf/cdYkx55plAbpTpv679mCJryDXFBcRW2WHnCxLqjziU+4+CjPeTgfAo5V4m94KHuVWh00Uz5BzSYeNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RY9N2EV2OUM0d61wm5tRouCUoplBOUbOc1cy0k4axHc=;
 b=NiZf3oGggpjDSXqjc3hGCaFH4taS8FGjgG5ErVZe/v93QTg8D4x8wGnBLD9Et1+z+CUi3L51S4dpfxzGM5ozSDx2H07thvav1RLD0/ZEDy2TyOKB4kE9OEJpjoHfF1sFcYMi0Bpi3xv+6g5WRE050gmdYfKKpFcVFPGUkzEyMIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 5 Sep
 2024 17:54:55 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 17:54:54 +0000
Message-ID: <4c72db01-448a-4bda-89e0-9c92a2f89154@amd.com>
Date: Fri, 6 Sep 2024 00:54:25 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] iommu/amd: Introduce helper functions to access
 and update 256-bit DTE
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
 <20240829180726.5022-4-suravee.suthikulpanit@amd.com>
 <20240829192804.GJ3773488@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240829192804.GJ3773488@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: fd900590-c6ae-4d52-f6fd-08dccdd3d8d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzNNNzNjTVhtUjlLQkhiSHljNkhsYUIrZUZ2N3lHcmprYlNqeURnNWd3MkhE?=
 =?utf-8?B?TWovSmo0N1Blb09ZWUJEZ044MzYxTGhpNHp1R2FWN2tTVEdKb21hbVA0Mmw0?=
 =?utf-8?B?THVoVWJrWWh3SytPc2lmWUN1NCtUQWNUUXF5QUZDazlUK25TMmdmaHJHM3F2?=
 =?utf-8?B?aExnOWxtUUJoTjlzZDFvTVJZTGVpUXYxNWRpeWN4aDZkVThEeEhqeWhkWEdG?=
 =?utf-8?B?RjNYeUR0ZnA5d1EySURMUnBaT1hZYUVRNi90VlVuV3pmNkpZMnZscjI1SkhZ?=
 =?utf-8?B?N3dRSWduYy9YRVBzV2RYK2JnYU8welVGODl1ZnlJVjIxWWNQZUdhUGFoakwz?=
 =?utf-8?B?M3hybHpGdFZhbWJUMjY4bEpkSWorR1VKOUc5dnJSYzdWK09kYUlSTFM3S3k2?=
 =?utf-8?B?NXdIVU5FR2pSVDhsNTQ4ZWdJdi9iQUQvRDFGNjFvdDJydlhpQTBNcEpIOUt1?=
 =?utf-8?B?SG1IUmhsWS8xQ3kyN1ZRL1hOVm1qbmRkc0hTL2FmWE4vb0s0RGRSaDJQNXhM?=
 =?utf-8?B?Q3M3bzZPcDJDdmJEd1JnczRRM0dnNG1iOTdENjFDYWVvVDNEK04rT3g0a29Y?=
 =?utf-8?B?N0Z6akpjTS9ROThmaGVWcnVCRkJITzhSZlFESTlpV21MaUlnNDZLMjVqLzRj?=
 =?utf-8?B?NXRYZDFZaVFMdzNsd1VwMXgxa085dWY1QTBQSUxtV2d6NzQyVnZqYzFvaEVu?=
 =?utf-8?B?Wmxrb01reVFRbEZWSmNkUmVHdGMyRVo4L24yL1RzUlIxYkV3NUMxSk1LQWds?=
 =?utf-8?B?ZHJsbVFCK3V0alVGY3MvRzcvV0x5SmcwbmxaOE15b2FabTdMbEFWY0pzdmFv?=
 =?utf-8?B?dzRUa0FjS1M0ei9wbmdDY3NTcWFlM09nQ3kzdVdTOWMvSkdoNVZ0UWtlcVB2?=
 =?utf-8?B?SzFtTjhaK2dkdzUxaTRmTWxtRUprNS9LSDBZVTY3MWdwSnVJVG0wQnZFSXhI?=
 =?utf-8?B?Tk5UamU2WU1TUElIeEVwWE5XVXorUmhNRWVRQzlrYjRjMmJRZWlnYkJUZUlu?=
 =?utf-8?B?VHV2dm1WWnNSczZDWXVVUVhpOFFXMktyYUliWG5tc0lvMlgxdE12dkdWbjRj?=
 =?utf-8?B?Yk9CQ21TREZkRnQ5cXQ0M1BWNjJHNnpJd1dBS3cvOWE0VWx5aVpaazRaYXAy?=
 =?utf-8?B?UVVYN2ZhNUcyaytGT1dwbEcyN1BPZWp2Y0kyT3plVXk1S2FuY25pT2djNkNn?=
 =?utf-8?B?WVBucU5YS29wUVVBMytzSGJxUW1Zd2tjMzJqY0hLam8vU2JTSkdQSVVLYmRK?=
 =?utf-8?B?TFNUdmtqbzJWSTZ4TnlDMjA0cUhLM2tuWTNCemNwTC9ZbFdzbzBoaC9RUmVP?=
 =?utf-8?B?S1FaNG9raUFIUUp1bnd0RzVBcFhxcW9jL2IwSVdEeHRGSXdCSFJWNFVoTkVl?=
 =?utf-8?B?anNxWk5tQzRySU5Ib2k1L0I0cXFIMHBSZUxZeWFYd08wL2ZKN2FWZFBWUEls?=
 =?utf-8?B?eThVS29jL0t4QWhOb3BiWnZwZzVYYWxZaGJ3ZWdzZHdibTg3dlJxR1VEa1ln?=
 =?utf-8?B?eDdmU2pLYUNncjdEcnhPalRjanptWS9uQk5jNEVDRjFhZmVDRkJCWjBPaXc5?=
 =?utf-8?B?M0wxVDJaNEhuYkxzUjhJWk9JRUxoU0VFME1VVXJITmpsckE2OW91WUd6VXYr?=
 =?utf-8?B?OFcvNzlucVkvZDlRM3FEc0pIL0orbW5Ha2tyb1ZVOHVsMk8wRHVaNjFFMm1P?=
 =?utf-8?B?dkNmMm0vcm9pb1RnUlBYYmRFd1JHM3dCeEYyOElad1dscDBSMlV0UURWSUxZ?=
 =?utf-8?B?NFZtY0Fad0srY2NGQ3JYZkJXTHNKeldoVHRjaXBJdlZCSWR5Q2F1QUYyYVBw?=
 =?utf-8?B?WnhLM2c2bkZibXRCRFF5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzduSEpYMXB2SmY4S3pPZ2xaaGxzRnFXOHBscWFORzBnZjVmYVJtODdDSzFW?=
 =?utf-8?B?STZnRy9SRXBJMllWblM5OWJnWVJZV09OZTl0VEVkcUFIeFEyS0txZWlTWEow?=
 =?utf-8?B?eHQyTXl4VktReXJnT2hzTHRYeGl4d1BsYXlac1pHUEIxek8zclZ5c2N3ZXFl?=
 =?utf-8?B?cUJXSzVhWnJIdzNHZkJ2RjNZTDhMbUJYZFhVSHMxdWF4S1lCS3VvZldaaGx6?=
 =?utf-8?B?MXQxQVNaNlAweE1DYlJiVXBsaWRGWDhpN0FkM0Y5RTVMazBHSXRVL01SdjJ5?=
 =?utf-8?B?bWZkM0t4eE9aWHVrUzQ0TERwU1F3dU9IVVVUYjdCMGo0QTRRWElqalNuWERv?=
 =?utf-8?B?VHp4U0ZKbjMzUU1rQU1ZQk50U0JVUk5NcFN3ajZsbDdxVlZUSGZIbjZ2MkV4?=
 =?utf-8?B?OG9xRTNXTGd2TnFBUHZDRStjOU1oUVZSN1lCN3Mxc2ZMZU9XTExITkhxY2ls?=
 =?utf-8?B?TDRsbEdqMUJmRDBoWjlSK0dPbVFXL0QyMi9BTXJNTHpUYk1zOTl0ZHM0UEVv?=
 =?utf-8?B?SUIzcEtWaHNlUzN4Rmo0cEt5a1U4ZFJmNWJQZ01MakdEV1RSTjFEeHJkc2t3?=
 =?utf-8?B?NFRLVVFJN0RyZ2lFWHpxUEZXWDU3M0RFc3Q1M3lrYzl4VXMrYWhzcCtzK2Jl?=
 =?utf-8?B?VnQzaFJwL25tQVFoeGMxdkIra1JLY2p5ZW5OcjhNeXZnd3F1aFJwNUsvWWIw?=
 =?utf-8?B?KzVvVDBXY0FqQ3JYTXFOb3dud1JQeVpUZStDWm1LNHlwbG5YUGE2WGEwb3o0?=
 =?utf-8?B?cXB5cTZSQWFRUHh3bm1tMnZLSDAzNllWQWtMWW9YVDVCYlR3VmF0cW9LSzVT?=
 =?utf-8?B?SHNlM3VrckxGRlNyeEtKNmtFZ25NeUNTdEFEcHg4NEZtNXFBTFF6UXFhMEU0?=
 =?utf-8?B?L3dGQkMwVEpmVU9uV1pvYnVjaEEyV25wTlg0YXFaSVNHNEVwV010dURRdVJV?=
 =?utf-8?B?ekw0TGp0VkxZT3NpM0NIMk40V3lLS2J5U1lseCt4aGRjVEdLclZiWU8vSkl0?=
 =?utf-8?B?aWRlQk9pVlJkZjRoaG5MNmtlaU9GWmhNSElTMWk2T1Rlc0I5QXNVSXhUMDRt?=
 =?utf-8?B?YkpDRlF1Q05vQVRVc3hCNExhaG9zTU93SzdyaTB6TnZtUHVzTFE0Z3AxckNK?=
 =?utf-8?B?UkxkL1hTbzRXRTZsK25qb3dOWWxoNy9lTjNkdGNPUkdJSEVDc2lrcGlKTkZo?=
 =?utf-8?B?eWpOc0dQT0tCMXRna3E1UEVETUw1VlF1aTJvWVljcWNIeDVwTlFZM054d0Fj?=
 =?utf-8?B?TVdJZzVXeUtwdWhtU3d4VzRWaVU2NmNWTkNyemRrcTh1THBKMGMraDlHalQz?=
 =?utf-8?B?WWp4RDRCdm1NUGNDd0lmUkxGT0h6VldlcUFlMThEZUlXZWtHdk9MdGpUN2g5?=
 =?utf-8?B?NCtpeW04Y3JIMGZLYnJ3aUFCYkFqRlhCcjVWVEFvaGRFVzRhWkhxVGdmNnY0?=
 =?utf-8?B?TGZLVStHdEdMYUptZFFObU5hZGl4b3ZJUDRFTnIwUndkSzVjMGJ5TW5mM1g5?=
 =?utf-8?B?MFNnd0VJSEhBWFpCZHdmOHhzYnpDcWdFeGQ1RkhCcW5BMCswdkliKzR0SUNt?=
 =?utf-8?B?bHlJUFZ2OGt4ZXI3WVRUYmVYRTMyclVjcDN3R3dsaWY0elZTalVXTTROWUlt?=
 =?utf-8?B?Qzh4SnRTaGRLa2ZpRFJnRXVxWkRhWVo0UEVRaGlubyt5YWYvNzRVSng3K09D?=
 =?utf-8?B?SXlDK241b1pvTG1ZdHdlWFdqaitOVGtUeVdqUS9QcTk1NDJ0bFdmVnRqTldK?=
 =?utf-8?B?TGV0UGYydTFwVFdWSi9lci9ic1ZqRno1aTFaNHZsWmhRZmNaSGNrZ2t6WDkv?=
 =?utf-8?B?S2ZpRDFaeDVFUEpIc0xLaVROWkhVWU1RRjMxelFPSnY3cWU3S2RlT0FuOVpY?=
 =?utf-8?B?V3JUZzRTMmxpYlJKNU9jWnBSdUZldERCSnlROTZBd0VJSzQwT3B0OHhobEpV?=
 =?utf-8?B?TVBVQTdyV3c5NHVSUFZYVXN4RTlReEVlSXVOUzNDYTNHMFRISGNEUm5NbW5u?=
 =?utf-8?B?RU1hNEVoSnlqOER4MFhMT0lRTUxLYmRZVUVkYm9uYUVTdytxMVBWRGI2QkVD?=
 =?utf-8?B?clpOaURib3NJRU03eGIvbEJTMjlBZXJqRkhCc0RVZkMvNFpUbkRwT0o3Ly91?=
 =?utf-8?Q?BW2mt0D2SfKZgPQjBuXCOKoIP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd900590-c6ae-4d52-f6fd-08dccdd3d8d1
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 17:54:54.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVvFsJYfdjnbd8PuNdcVmZwOKSSKKLPLM3ySavCTknP1ujsz0EJN93QUdTvuKxiw4eNXzWHQq/D1cBvfAWEMaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284

Hi,

On 8/30/2024 2:28 AM, Jason Gunthorpe wrote:
> On Thu, Aug 29, 2024 at 06:07:24PM +0000, Suravee Suthikulpanit wrote:
> 
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 994ed02842b9..93bca5c68bca 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -85,6 +85,47 @@ static void set_dte_entry(struct amd_iommu *iommu,
>>    *
>>    ****************************************************************************/
>>   
>> +static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
>> +			  struct dev_table_entry *new)
>> +{
>> +	struct dev_table_entry *dev_table = get_dev_table(iommu);
>> +	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
>> +	struct dev_table_entry old;
>> +	u128 tmp;
>> +
>> +	down_write(&dev_data->dte_sem);
> 
> This locking is too narrow, you need the critical region to span from
> the get_dte256() till the update_dte256() because the get is
> retrieving the value written by set_dte_irq_entry(), and it must not
> change while the new DTE is worked on.

Ok.

> I suggest you copy the IRQ data here in this function under the lock
> from old to new and then store it so it is always fresh.
> 
> Ideally you would remove get_dte256() because the driver *really*
> shouldn't be changing the DTE in some way that already assumes
> something is in the DTE (for instance my remarks on the nesting work)
> 
> Really the only reason to read the DTE is the get the IRQ data..

I plan to use get_dte256() helper function to extract DTE for various 
purposes. Getting the IRQ data is only one use case. There are other 
fields, which are programmed early in the driver init phrase (i.e. 
DTE[96:106]).

>> +	old.data128[0] = ptr->data128[0];
>> +	old.data128[1] = ptr->data128[1];
>> +
>> +	tmp = cmpxchg128(&ptr->data128[1], old.data128[1], new->data128[1]);
>> +	if (tmp == old.data128[1]) {
>> +		if (!try_cmpxchg128(&ptr->data128[0], &old.data128[0], new->data128[0])) {
>> +			/* Restore hi 128-bit */
>> +			cmpxchg128(&ptr->data128[1], new->data128[1], tmp);
> 
> I don't think you should restore, this should reflect a locking error
> but we still need to move forward and put some kind of correct
> data.. The code can't go backwards so it should try to move forwards..

In case of error, what if we pr_warn and put the device in blocking mode 
since we need to prevent malicious DMAs.

> On ordering, I don't know, is this OK?
> 
> If you are leaving/entering nesting mode I think you have to write the
> [2] value in the right sequence, you don't want to have the viommu
> enabled unless the host page table is setup properly. So [2] is
> written last when enabling, and first when disabling. Flushes required
> after each write to ensure the HW doesn't see a cross-128 word bit
> tear.
> > GuestPagingMode also has to be sequenced correctly, the GCR3 table
> pointer should be invalid when it is changed, meaning you have to
> write it and flush before storing the GCR3 table, and the reverse to
> undo it.
> 
> The ordering, including when DTE flushes are needed, is pretty
> hard. This is much simpler than, say, ARM, so I think you could open
> code it, but it should be a pretty sizable bit of logic to figure out
> what to do.

IOMMU hardware do not do partial interpret of the DTE and SW ensure DTE 
flush after updating the DTE. Therefore, ordering should not be of a 
concern here as long as the driver correctly program the entry.

>> +static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
>> +		      struct dev_table_entry *dte)
>> +{
>> +	struct dev_table_entry *ptr;
>> +	struct dev_table_entry *dev_table = get_dev_table(iommu);
>> +
>> +	ptr = &dev_table[dev_data->devid];
>> +
>> +	down_read(&dev_data->dte_sem);
>> +	dte->data128[0] = ptr->data128[0];
>> +	dte->data128[1] = ptr->data128[1];
>> +	up_read(&dev_data->dte_sem);
> 
> I don't think you need a rwsem either. As above, you shouldn't be
> reading anyhow to build a DTE, and you can't allow the interrupt
> update to run regardless, so a simple spinlock would be sufficient and
> faster, I think.

Ok.

>> @@ -2681,16 +2732,16 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
>>   	}
>>   
>>   	list_for_each_entry(dev_data, &pdomain->dev_list, list) {
>> -		iommu = get_amd_iommu_from_dev_data(dev_data);
>> +		struct dev_table_entry dte;
>>   
>> -		dev_table = get_dev_table(iommu);
>> -		pte_root = dev_table[dev_data->devid].data[0];
>> +		iommu = get_amd_iommu_from_dev_data(dev_data);
>> +		get_dte256(iommu, dev_data, &dte);
>>   
>> -		pte_root = (enable ? pte_root | DTE_FLAG_HAD :
>> -				     pte_root & ~DTE_FLAG_HAD);
>> +		dte.data[0] = (enable ? dte.data[0] | DTE_FLAG_HAD :
>> +				     dte.data[0] & ~DTE_FLAG_HAD);
>>
> 
> And this doesn't need all the logic just to flip one bit in a single
> 64bit quantity..

Ok

Thanks,
Suravee
