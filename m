Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F3385D9E
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790854618; cv=fail; b=si/zWQ/8pXZDMiwTck5xiOrhCuUx8RF1opWVWpU+cgsDxlxJaQBc1VF2o5EquefI0FT/r1xjkw4Dg1Cd1jMoyLFVscPmX7A0S1mSQ6EqPgo/6xX0TwAEzgsXNzJYT+S9yOdkLUDSkOHIXKcCwMjAy2rsXyHwcJhdecThsbGDBtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790854618; c=relaxed/simple;
	bh=hx1iwSY/ywVLC+1wXwANk08hnZFXP4mX1n54J7wiWjM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nk6VuqSjopJvaVj+S0jc3HZFuO38TQ/mhDxXfJiRV/UXLhcE82xtty5R11eAcvyO1YDUOr6Hf9ShZd8eUmqwSL2O2t8MNDafRtsYTiDS5U36khNuTbs5i5zmGXk0GZCYvNL35SZNlTRc2eQmQ6oBNpvUS9pYKV7nqD/eyuScUpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U47CQSkJ; arc=fail smtp.client-ip=52.101.46.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U47CQSkJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5jmjga2tjVKFEyCe3qDoLl8GLEc4etlO4zCsE/18cjMy6OAKJayDjvEXtALQhsG1MisR3T4ts0Wz/JVOrkVJqOh6tzLTKMctN0ZFEC68TsEw2g/JxuxDw7jfLbA07b0QjK4+mx6yrVeLqMWkYnxkPFGJz/5FJTjPWCN3ZmeLTgqTMOEtc0JgiIn9R5eCUFUJnhTT1VVG8Ch13qKMOwqDFw35oKjFvFMXFPwAuS6G6jN+eysvhxofLfdef8YFIbaAyeOKi1aRTrGHtx9OquysGZ1gyors5m5ynEg7HTYd4rJGGGsAWzUNJ3boVGwWOBTRl3EFTafaSaLtsR6V7iBOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tNVB8bVzLxCym28ZhNyGSNAgV4QUfqwFUiur8scZQM=;
 b=Q/XX2QPrB5kG9hwEKG2w0WCAulEHuO65fJ9gG0YQfUJZsO91OOS476s99TQ/a9cgFfe7XWEYf2vkdRHd+TfjRV9PGDCRY6oH0ZetljhDDMlTkpuVqZpppMoCeo/hKwMTrQOSyMNjBVHDcZzdXYPNFKWFf9flvFcEDgI/oxqcIXDidC9sKMX5XIZDiGjcN9CrpbJiW5MuXT2k4ZYW5Ek8kMuq5cGxvB2VHfTA7LrE+fjwwBo55SIKWuIMWuQA6IWZPzPG6kHDzn22uPTOvrWJvgB9SAxvis1H9pCjt/PM2XuiW0hq/4wS5N4/Q2ez+PkQ62yVIopliZ6kQBsOE2tdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tNVB8bVzLxCym28ZhNyGSNAgV4QUfqwFUiur8scZQM=;
 b=U47CQSkJplghbbuBkbREQYNQiqX4j2Eez3p+UPsf2wM9wHYxMjJsGsfp3ZTNuD9qNLXLtQzXI6fpLmG0RcN4sK/h5Tt7WBq07vTpSEPka+Msl3QTr/CvJAe1Aybr/O9TExz9uz8LuMuvSyS6KgT3t2JZT0+LAz+rCvYbqOsfb4U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 11:34:54 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 11:34:54 +0000
Message-ID: <01dc5f6c-3131-42b6-9aea-23d8c5f19757@amd.com>
Date: Thu, 1 Oct 2026 17:04:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/amd: Make PerfOpt compulsory
To: Jason Gunthorpe <jgg@nvidia.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Deucher <alexander.deucher@amd.com>,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20260930162401.273907-1-superm1@kernel.org>
 <179080801733.122959.2048638492948411360.b4-review@b4>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <179080801733.122959.2048638492948411360.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0217.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::13) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e1205f-5514-4aca-e7e4-08df1fb00373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	HDsXBgaWLx6sbHfRz+22hTFQeROtkFZ4iJyxf8l+Wkym8FNOYh5/Fz8jO873Pqe96FUPhqI873FjvpbfwHepDQsiW1JU8OFx3iiUmsjx67UE/EO0rD2F+QfMP2W9t0Ppm38jv02+ZdJH74Y/HSoaiKyTvToOQu5tPSXnbD79myinIUHyAkbka+rb345k5rE6kIgHGB3rdSNu1v528C5EZuwh3wgfZmu95whhGax3yit9d3Pci5NqAIs0BwGya12P8oowRlzhSwV8PMqnALfW6dI8wLcQvnQcRTqyZNNXl3y0Sc416VFVAJsE5ywNcyHiVO2GSsDVvQNypBxtBw7LqjmcnbitbYwp8arrsfjS6W7mTJE0TQoxOiaqdq5c2pYD2jiE9lsKZtCrYcxTXWbKVminrsbLi9B3iauIzbO1Dds3Sf4+bFAjuiNFYdv1kSyC0mzZAwiYSKpSnvAkh6hIcPo/XRSOgl7t3klyIXuX12v8qkLJ00NsOFjtgfmi/Zk2XhBI4NffaUl3ki6/tJOcxO1mXVNI9KjR8u8oMX76ayZpx5ckn7EQd6vXIk4ay+3m0q4jyPINZkObiq42LdizyZy90R1BF8slRuPIIE+wt43yE4kG36b55MVpWwTN21KLQsa/2C07Gnr8aqRsKnwgGmhcbqX1BbHFJJDLKeqryd0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWNGVE1PVGVxOXZaYkgyenJ2cWY1MDJjZWNaVTdjZmxJZTM0Qnl6SVpGQVV5?=
 =?utf-8?B?SDZyWjBMV1hlV1ZnTFk5UkJYRmZzNm90MXNFbTY5N0k0S0ltUzdEYllpaGQ1?=
 =?utf-8?B?Yjh3c3l6K3VhNFBORCtFSVkzaVdJd3lPRXl4bTN0M242TVlncTkrTnZ3U3l1?=
 =?utf-8?B?UVd4TzA2MTYrYzBXekJWNGxhSHBrWlhhMDF0YldZNi8vZUhTQm9udnBSR25B?=
 =?utf-8?B?ckdtVjF3Nld3V1gzWE85YnMyME54UFNPV3NiWFpCLzVzRUJBbURqSTJORHFX?=
 =?utf-8?B?ZzBKa2YwdCtmV21qWTVxU0hmUlhJZlc1Unpsd1ZyNXFOZnAvaEtyOXZTQXdu?=
 =?utf-8?B?ZE5vTDgxSGZ1OThWb0pRSnh3WThTRXA3SDd3STJPNFpUUGxVU3NzUjBWL01l?=
 =?utf-8?B?c2hLTGtnb1g2QVVEdGN6WVh4aU1Na3hBR1M2bEt6UTYvZk5mMEt6c0xzS1NF?=
 =?utf-8?B?NkcydlFPd0lsZ1FrbVI2Zi9WY3drQUJLaVAvT2MwUGw1ck55ME0reHQ1SXcr?=
 =?utf-8?B?dlUzeWRQcnNjbGo4MHQyL3Jxd3VZRG5xejYrV2ozNFB0aGd4U1BKY2VIaHJw?=
 =?utf-8?B?Mmc2VnpEdXQrTTY4OU9LdHJxK1kwYkJsU3JLUG5MT3MrM2xpN2F6L0pOczlF?=
 =?utf-8?B?VHVyMW90NUQzeWlKY2gzWG5BaVBEZ0k5bElXY3dsZ0ZnNmdFWTMvTG13UlJ0?=
 =?utf-8?B?akc3aWp6UHdqZkhxOVhiLzFSSmJ0WCtuVU5aMjFKY1BWMGxla0VRS3Nja3JC?=
 =?utf-8?B?NDNRY0NuYjFXMlkvZFVlaWNxejQ5MmlzQjE3U3NtY3I0NVdKRCtCcFRLUk10?=
 =?utf-8?B?clcrZzl6MVN6eUU5U0FQSHY0VHlZUkVtdDJlK1NHU1FmNlNCVW5zK2t4TG84?=
 =?utf-8?B?V2dHSkMrQmxuQWdzWUxEY2tCYVhkK2NCSUlPZ0RJbWNNcUZ2bEtlTkNPVE5r?=
 =?utf-8?B?NkRHQUtacTQ0TkhxakIrV0k3QWVscW8vUmt2V0IxM0hyNTYyNkZVWVhSQzJP?=
 =?utf-8?B?T2NYMld0Vm9IUDJFcUZTZGUzK0laYU8zNWtYWCtKTlNPQjFQb1BxaEVGWVZN?=
 =?utf-8?B?aXV6aGdSS3JDczJwclZDQVA0YW9EbGFINVRJR0cxSVdtcUF0R3FDbFhvVDJO?=
 =?utf-8?B?QXhTcGNMZE1mK2gwMlphd0RJWkc0KytXUThKRmkyK2NwY1VoUUdtZDNKMGNp?=
 =?utf-8?B?b2FOWDdmeTdLNHFtdmdSL0QzT1NKWk94ZTBYeGVsRlhiS3RZZERqTXpraVN3?=
 =?utf-8?B?TXJZd0xpT3FEbUNWZjNKTEdmNkpoQTZvdlpYK050bVhtUEEyb3pwNC85WnVN?=
 =?utf-8?B?NlZsaUVnT2NVYjZQa20rcmlwVlA4VmdqM3A5SGJid21qdlRQT2lpMys1SExQ?=
 =?utf-8?B?eFAvVDRUOWpEZzhMNmJROHU3MnJTY053NVNkcEhkRWNhdGtvbVZuTjNwMVI1?=
 =?utf-8?B?WnltM1lTMGljTElTM2ZHeWNmYm5aL0owdnJveEVpSWJmVllSMTNLZDRhOHJL?=
 =?utf-8?B?MkIwVFdlVjg1ampWam9zUHROYTd2dm9obkFCbGZVODBLMkZsVy9BQnQvVm1R?=
 =?utf-8?B?UXVnU0VVSXhkTmNGdXRyMHVwVmQvWU9DYmtTNVRYQ0NoT0JvbnphZklhS3NL?=
 =?utf-8?B?ekFweU1UbGxoOGE0NzdzVStzZmdLQXNrci9GTFlINllsanE3L0ZoZE1WZmNC?=
 =?utf-8?B?c1N4WnBudDRSWjYxbGdyNWpFdlg0NnczWW5xdXN1dFcrS1h3ZnV1Smx2eUc4?=
 =?utf-8?B?Q0tNck5Qek9LMkVKS25UQ2RPa1NoUDdoR2VvWTNqdFlBaTR5RXFjTzZiS3oy?=
 =?utf-8?B?RmFqUkVBZ1JJdGFab3RTYUJJb2VMeDlnSkNqdFhMMTBsMUdIc0wyOVJESWhh?=
 =?utf-8?B?MHR0U0ZBMGNqbmtwaUlGMDE5R3luSlRhZkt1QVpIYXhRR1ArdnRwbXFCanJt?=
 =?utf-8?B?a3BiU09GNWtET0psS0pQL2ZCR0dGV05QbmlnQ1FsYlQvM0V3RWh4Ni8wTTdJ?=
 =?utf-8?B?Z1hZMTc2bElCT1MrT3Nsai9uZnFqYWZxMUpraGsxYUlQZDZEMERvTXdLZHh3?=
 =?utf-8?B?dzdZYVo5aFEzK3dEMlBCRWpuUDQ2TWkxS1BJT0RiT092U0pWcEJHUkNPeFlH?=
 =?utf-8?B?OTUzYjhyaUZYSDB0QXJzQXo2QUJ6OUFPY2IyaTB3b0QxVHB1ZFZ0eVF6ZTBu?=
 =?utf-8?B?WWxUeW5odkRISW9vTXh3ZFhYUzVnOTVSOUoyNzlYdzRsM0FnczVXVHB6Vjl5?=
 =?utf-8?B?eEtGQ0htdTBvMy83aTUyNlY1NHlRSHozZ3o4OVNXelFmekx2MzNRclRCamUz?=
 =?utf-8?Q?eGoJ5ae/PGo0FqHTeV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e1205f-5514-4aca-e7e4-08df1fb00373
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 11:34:54.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKKm6zNqlUprIabzCO75JNHmYVlYEI0YnDe1yYPlS5PcXz7vVVoOShQTsgHgnFsiVMd8nEzCQoW5+AYgdKZtYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132



On 10/1/2026 4:10 AM, Jason Gunthorpe wrote:
>> [ ... 336 lines skipped ... ]
>> @@ -2370,7 +2370,7 @@ static int attach_device(struct device *dev,
>>  	if (ret)
>>  		goto out;
>>  
>> -	if (dev_data->perfopt)
>> +	if (dev_data->perfopt && pdom_is_in_pt_mode(domain))
>>  		goto skip_caps;
> 
> This should also disable PASID support since without a gcr3 table
> that's broken. Set the max_pasid to zero during probe device.

I think we can add it inside amd_iommu_probe_device().

> 
> The flow is weird like this because the driver still hasn't cleaned up
> the identity/blocking domain flows. There is no need to track them in
> lists and things because they never need invalidation..

Right. attach_device path cleanup is in my list. Now that _probe() path is
settled (thanks to Pranjal), this is probably next item to pick up.


> 
> This is much nicer if the above could be written in side
> amd_iommu_identity_attach().

I'd say for now its fine to keep it in attach_device() as it gets called anyway.
When I rework, will make sure its moved under  amd_iommu_identity_attach().


> 
> Also, I'm a little confused, I thought this had to be toggled on and
> off so it is only set while in identity, how does the DTE influence
> what happens when in this special mode? I was sort of expecting it was
> ignored entirely in HW. This version seems to lock it to always on,
> but still permits a blocking domain to attach.
> 

Mario, Can you check what happens if we move device to BLOCKED domain (DTE[v]=0) ?

-Vasant

