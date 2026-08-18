Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013000.outbound.protection.outlook.com [40.93.196.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4003D667D
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 06:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033236; cv=fail; b=iMMARoEVVMZcLGWByi7DBrCbpap4jgvuxD5rUqOlJvB/y++E+/nwr29Y5bfMqGlvX3lPdTeanEYb4VpjTF9Ivh6mYxUihEzzcXGiyK4jqRtY1zSj4QLW8QdEimC+AXbScNi0sGPaqBz462O+Mk1ZpCzrQLSxeVtGBRXBbj/SSuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033236; c=relaxed/simple;
	bh=o2tsb7z1qBZXJiC2IGohtG3BCdpTA+0RAq/uvDW7S5Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kCsKFnAr3+kPGe3aJ/GzhXtVWiV5+6e0qW9pWt2kRqd0nXjr5JdEAiwMfTcdzI1kYiqfMKOB2a2J/XZ0cma3vEaJ0ClMnwVF9iRSE944aIVVzL1TPeuIke5o1kKL5SmesgyDkgofJuCoRvyGlTAgu3sKDJH2M2kvSCHrndIRi00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tFJnIM1Y; arc=fail smtp.client-ip=40.93.196.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tFJnIM1Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRKlOIXo8YuNNvPDZiYo3nFezSGw7sNj1mh310Auk8/U1NjpF1ysH9rGXmzk4nJ4RGbB3vXYaLB5sD4w02piL4QdE4YEwoSbeRlgZFaPXBrzrVrS2gG3/jnMUToQQ2mnZ8tpn9afOmBOlT+y1wIPdc7Mgf4MpLqC1bOIr/6UUlZ0+IpZJIql6846dlph82nc4j5coY03BCOaQ+SPJWF1Uq08oyE2pNDUwGLw0JOBWweoNhP12/a4JcrbbjNlqzowdp7VWkb4xlrG+T5W8p0xWaeMucTqyOoItTXaWVc22D+9dPnEvPzKqqHq6ZxBaE8M6IL0oIcMzRLHEqj51HFrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpObD8jNEhb1Caja1aEwcb7gSFdw2Mk9gFrpPlFvX9A=;
 b=kAM2ejY14SnPfXOS22JzVKFMTGOEbRGmvBPjIo/fT1JLj4ZGu6KZ6ENua4U78uzJoRPlBiQFN8itG1hRdk7TAPcQBwkAgoWPQcx6JwlQSw9sAj7tzmHYkrbIJBty8IS6Hpcmm7Gxgps34Ue1T980BzfKNVkxljoTfqvmxxZws0rhzw2O9INaIF3eepQYgq9MFRZdWeW6ojaFazWNROHqbxNkkNXVeEXT0Ujllqj4FIAb5zrvb0VS1USvOA+fGX7UYXd6U36hYEidNUaCS5EGSO4HY4quc9vIil+vRzT6L51aOWN5H0hlRehwzhuwfQwCpq1H2RcL59xlkEI8PuMEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpObD8jNEhb1Caja1aEwcb7gSFdw2Mk9gFrpPlFvX9A=;
 b=tFJnIM1YV8e+JGWoeY+JP2OisdddziUDt6q4gCAElmMrN0WhSwRlM3CYJ7FNFgW7mO2tyb90tFM7j1Zr+Ln6nr4r+kKryblvDfWfqqOBsFBbZ00tBkCB2DZfL6eJ/e0S3XEmydLPunU7UADxJ5PbppkYoKnXD8qH/yJKgmZuOAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) by
 DS5PPFD22966BE3.namprd12.prod.outlook.com (2603:10b6:f:fc00::662) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 06:07:09 +0000
Received: from DS7PR12MB9475.namprd12.prod.outlook.com
 ([fe80::4371:c924:8800:2587]) by DS7PR12MB9475.namprd12.prod.outlook.com
 ([fe80::4371:c924:8800:2587%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 06:07:09 +0000
Message-ID: <28ee8c39-1c30-458e-952e-7b02b2ca0998@amd.com>
Date: Tue, 18 Aug 2026 11:37:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd: Fix NULL deref of area->pages in
 ioas_change_process
To: Deepanshu Kartikey <kartikey406@gmail.com>, jgg@ziepe.ca,
 kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Cc: steven.sistare@oracle.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 syzbot+48637757323884de77a2@syzkaller.appspotmail.com,
 Peiyang He <peiyang_he@smail.nju.edu.cn>
References: <20260818033650.21443-1-kartikey406@gmail.com>
Content-Language: en-US
From: Tushar Nimkar <tunimkar@amd.com>
In-Reply-To: <20260818033650.21443-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0183.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::13) To DS7PR12MB9475.namprd12.prod.outlook.com
 (2603:10b6:8:251::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9475:EE_|DS5PPFD22966BE3:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d9fa51-b15d-4888-8cbf-08defceeefca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	tLo7XO+zLJIZfTXq4IY31+DiS1bR/m7nEg1dnhlsPOzvC/FqKncISWdxgd6hHsjiRa1hPlh/2MAK2lcfI2q9iuLWZSrtzNPClKFvn85zONFL5TZ60KftM1LA/g6n9WsiJIPgVRIvS99hX5sSDMsTWGYjofD70xVgsmc7ArPJlIwDxyQZsXXQ7kx7nzzJF0PFEa+2V8cFW5BJgvPQmxTyAxqu/ziV6C3PJanZy0efhjtEPA8Bu8wtPR+BP6bnDZGFjCMAS0kJZpdD4pw+monjI2Zg2gfy1n1g7M/BFLywtvroyZW9xsqFiJsRI8I+d+YVQoJKNdhwpvhHi0LZkOBJMv4PZVfKIdeLkapw9la7sGrAScjbE5Xx9RgRBiW05Df5SylyMZiI7R1CrSoI+E7DVJ9JlRpaf0hAHN2Umr3Lbrku/B8ejmxKmClaZwmWivEOaKIQIF8TR77ZdD4wjJaz5cKIL0r92nkrBEiqeERxC0Htj0KxApwQ4b/h+O/i2Ivmn4geA9AAnUzR572/2X9ExlsPigS8q6YB/IdETQ3pS9DjQugC+mSm/+D2/+CeU+/Pd38k6AZsLrGmL3TGKI3F6xRFbXoTttom/f5FRmWEylRtV0N6yg7bQr4BE4coIHqI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9475.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkxtK2NoVUFjRDFVQ3FiMExkSWNQQXdTNDNMbEVBL2JwYUhpdzF1eVFLR0tl?=
 =?utf-8?B?NnpRSGEvVlN1cnk4L0lEQ21abFo1dHhUTHBPODJJNjVPQ3J3cVhGblpxMlFD?=
 =?utf-8?B?Y0xkZG9GRFV1dmIwZDNGcUJqc2NNL04yVCt5TytnR3lmTUhLN25mbElOQmhM?=
 =?utf-8?B?YUtkWGcrc1AyYnN0b2FOOFRnZWZyNkdYSmd6Zjl1UTVvUUdTNEJuRTFJNWg0?=
 =?utf-8?B?QVV6SWlHWDhBVms2ODlYSlV3UVEvdEFMWjh5ZXRrNlJBUzFFVnhsN2phMG8y?=
 =?utf-8?B?bHZVeWhRNlRiNnFZQStUd0EvdW5ScDA0aUxXNlVEOEhETHZlSnY5TzFsRTUr?=
 =?utf-8?B?dGozSWZVY2tnRmdxb1B6UW4yblBzWUZSUml5TUVjdy80RXlqQnpTTThnTXFp?=
 =?utf-8?B?ZytPdlowdWZlZFdabnNGRmszZHJXQnpuak5md2tkSnQ5aVVjNXpobmozZWRa?=
 =?utf-8?B?cDcrYlg2eTRNek5MeEhHS1M0VVcyeUFaYlRTOWFPUVZBcUFwS3FNWk02d0dX?=
 =?utf-8?B?NHdNYTJFVERsM3RFUXBuT2orTktOOWpIVk85dGd5eG84WG5hL0R6RlB0TFRp?=
 =?utf-8?B?VmpFMzhiY3RrZUNCcDR6SVBQb3BwSThXaEEzM05kd1BSVmxLUGtoT3d2Y29k?=
 =?utf-8?B?eU9GTDExQlVEclh3NWFkY1kzTzZaVStVbDh4KzFzbDF3b29vTWdBZ2YxbWVx?=
 =?utf-8?B?YlN6MDJjRlRFYmlxemxPYXF1b1dQSFBPZTMxbFlJTGtjYWgzRFVKVFF0QlhY?=
 =?utf-8?B?VGZ6TVlsSS9LOUZIUVFPVVltbGh0dnN5cCtYMVJZeFFHSXV2bUcwdVpQMUpo?=
 =?utf-8?B?eldCN0NDaStJcDg5SjdGMnNmNFNjTkZuOWdiaTBRNEIveFFqVlUzbkh6TFly?=
 =?utf-8?B?R2VMVnhoMmhVbU5QUkcyTHBqRnJTQkprNFpwZmExWTUrL0V6b2V2OTIvcjhv?=
 =?utf-8?B?Q09PNVdQY1U2dlBjR25wMExwOWowR2x6blNkaTZXZDNNSllrcjVYQUVNTk8z?=
 =?utf-8?B?RlJmcVBKNXdNOXkxUnFQWjg4c2c3R3FtSzFtQktxbUQxdVBNVDg5NTlQRHI0?=
 =?utf-8?B?THliRjluRFZhTDZpTVlYOTZyNEM4eHc5Rmw3Y0dsVG9meW1aUDRVT1Z6N1V6?=
 =?utf-8?B?RWNMUjJrTFd0YnNabFoyRmd0am1Ib09qQ1puSnY3NDFNUCs5RTJZdFEzZFpj?=
 =?utf-8?B?UTZQN2JBTXpBYlYzNW43ekorSmV2MnpJRjNmZ1dSdXNjcENHSEhzNGswc2FH?=
 =?utf-8?B?THljNWVqSGZUcC9UZDZJVkFEVjR3MGRqaG1VOEwwMVl4ZytqdzdZU0V3T0Zh?=
 =?utf-8?B?RzZhVHp3SWVTb21HR1BnVm1GeU5oZnJZckZDWVFKOTBaWHU4bExlUHdianlu?=
 =?utf-8?B?Y2dnZG9ESldUWk13WE52bzVGeU5vVmhKK09iN3hpUlRYbXRDd2hCM0ZaZk1l?=
 =?utf-8?B?WitKaFhoK2p6QUhNR0s3VExVTk5LT0s0R3ZueEpmMm14NE1maGsxRHZBeTZh?=
 =?utf-8?B?TUd6M0lqTlcwU0wrTzFTNzRqRjV6c0ZZM3hEdHZLSGdsQkczdnFLaERybUMz?=
 =?utf-8?B?dzJ0L0VoY2diUU95dUZUMFdYWXgxSytZWDZnMTNqVzRVbFphQWtGcTJiL2Z0?=
 =?utf-8?B?Y1RsRm4rclV2Wjg5WUF3b21XOE5qbFVJcUU1M3NhSWoxcTkwVEVrN002azJ4?=
 =?utf-8?B?NTRRTDZ4a1FjSVd5TE9nb1djaTI5c3RjNFI0QmZGNzQwVU9nck13Y0RYVHRU?=
 =?utf-8?B?aTc1UlY5T3FOSkZmajUrQ2RTb1RnOUJ2Q2pZSE05anZvT0tIdmFSZXZsWjE5?=
 =?utf-8?B?bG12c2JZWlNFczlTejFuVkhhNEppT3pJbVRQUDl0ZE1tRGRaRGNYZkZMeDkw?=
 =?utf-8?B?Q1ZKc2d1Y2dQdmVKLzNPWTl4SjlMZ3NkbW9McVRScDRGd2FPSC81Z2VxVENE?=
 =?utf-8?B?ZStyUXVRK3RwR0duRVVLZG95YUJOb1VGZlZKM1lSMnAvYmRHOGlXeE9VSzZs?=
 =?utf-8?B?cm9HSCsvU2VXcVMrRHV3VGFUUDZ0NmpEUFlsV0RMWUt6WlRwTXc3RHh1cVRM?=
 =?utf-8?B?MWw3eTdpM2xsY1EvQUJnYlpuUCtmOFVEQlc2VHF1RkNLQlNTd0pPSE9GTCsx?=
 =?utf-8?B?YXpCdXloZ09WVXQxNXh2cFVVR2xRVFRtWG1GQndFTzRWR09PSFdUYmVyblA4?=
 =?utf-8?B?SFhyQzlZNW5tQnBoRjV2SU9qQW9TZHZtb2I0bkNBKzNsazZyTUZJenhCeDJE?=
 =?utf-8?B?VUQvZzd2Nm1lK1dGOHRUbW5qbHJaR1pLbjFTTVk3MnZPNzkvejZ5Vm9YVXY0?=
 =?utf-8?B?VCszT2lSaXBBRWVlajdUUXdsbTlVaG5IV2phcjJIZ2JZVENPdStwdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d9fa51-b15d-4888-8cbf-08defceeefca
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9475.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 06:07:08.9771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzhNfo7HXyQZ/tw4waWA6JoR8Jap5pOpMtSDkq2dNEI9X3bDjyGkb4DF4OHEFUFadzKDxaHE3Kdmpmi7uIKQAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFD22966BE3

Hey Kartikey,

On 8/18/2026 9:06 AM, Deepanshu Kartikey wrote:
> [You don't often get email from kartikey406@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Areas are inserted into the area_itree before area->pages is assigned,
> so an area with a NULL pages pointer is briefly visible to readers.
> iommufd_ioas_change_process() walks every area and dereferences
> area->pages unconditionally, which oopses when racing with a
> concurrent IOMMU_IOAS_MAP_FILE.
>
> Reject the racing case with -EBUSY, matching how
> iopt_unmap_iova_range() handles the same window. Checking in the first
> loop covers the whole function since all iova_rwsems are held for
> write across the call.

This is same as submitted by Peiyang

https://lore.kernel.org/all/7344B7A7B9957A65+20260806045059.1884737-1-peiyang_he@smail.nju.edu.cn/ 


- tushar

> Fixes: 829ed626499c ("iommufd: Add IOMMU_IOAS_CHANGE_PROCESS")
> Reported-by: syzbot+48637757323884de77a2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=48637757323884de77a2
> Tested-by: syzbot+48637757323884de77a2@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>   drivers/iommu/iommufd/ioas.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
> index fed06c2b728e..71bffece84b5 100644
> --- a/drivers/iommu/iommufd/ioas.c
> +++ b/drivers/iommu/iommufd/ioas.c
> @@ -535,6 +535,10 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
>                  return rc;
>
>          for_each_ioas_area(&ioas_list, index, ioas, area)  {
> +               if (!area->pages) {
> +                       rc = -EBUSY;
> +                       goto out;
> +               }
>                  if (area->pages->type != IOPT_ADDRESS_FILE) {
>                          rc = -EINVAL;
>                          goto out;
> --
> 2.34.1
>
>
