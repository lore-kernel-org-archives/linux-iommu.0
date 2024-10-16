Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60E206041
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073674; cv=fail; b=DtQ7UEG27SZLfVFiNtdt69qnA95BgViggVfmVQii/hEsPJP/n024jELK7ayBeJMOzMbA38gUhwxQMlJP9D5pgNK4C7+9IwTSFrYqTxzcxkgiOqTNDULm5arCDx4TAXUsGWa1IeXYUuHitrhV5QZsjcmvqTgeXIcCQ0q0sVgOxyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073674; c=relaxed/simple;
	bh=9KdAxixA8G18LGrCrGczxhhcln7AKBBznjxckRSW5K4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gb9PCo4RM4cFLeZ8v2nyOspDj2B5V0f3xaNi9C2XhIbblMiHQZbKKNUJMmF6fuEGdB8K1GUmYEGWR4NfKQgE5bmLq6VZMZpefLHmaGa9W1aOtHPokz3yTix2GGyB+NLgGM0Vig5BxEd4hIP6qw0J6KZLdtp6jk5WW2En2aZJoPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KRFnR4tW; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KRFnR4tW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yL/LrMUo10X+RC7qf90ljkmfyR+6j+Am46cPdaGyLLyT3pcLuTGQ69ITbw6PKG7ueXenwACj0sUoKroVW01hX2CTAnitUHUJDwnIqiu6H+vPW4eNEbbtsVjrnHlDWiEw9pi4L/bIkJP/NNud55hJIoN6k1BbB7+D8ypHgtC3JZz6Z1e/lii7MBl8RuI5Czd9pbNEupEnLbTQO4LlmDujsVAEV21NbUAfwiYqGAeK8/ZFSe3QWy9sSZe5FAN69CL/HNiPk9SAnOFHRyt3ntjZ0IVRCDjFFN454kVE38u/RI5vmPJRyBMU9NiXuNY3s0WZHEOx+e1Xg8ytA9lJMQnSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bt96JsfQX6ATfETCQvGhDbUaEfp41peiGfFMEdnheMU=;
 b=Fplz/KmUgZFrpJM/9vDR8MVlBcwvfwT927vp0byvZVX6dHuuIqn70nWUPcyOPDk5es4cs3ixxoAn5o0awiuY1zX68oMN+NuJ7cg96J1iXZrsenom7M/95uU3kbDOE1HyBh50BNXovGQd8dsBkIrXbB8HzMBKn/kxrmGpVobA8p+669NZcUsPPfXbqdIRN5MYYXQEDNutVQKPvvz4TQARMjqedViBkDDXHAStbrXxsgTjWaNrQ7G5o7NtOXcolnx9lZkB2qkzZRHkTk5MLkHVvoW3wioK0LFfHwdZP3RNbPQadgxwPW82aHbpKw4UoaS3VIyHY37pS18KFyZtBjBsAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bt96JsfQX6ATfETCQvGhDbUaEfp41peiGfFMEdnheMU=;
 b=KRFnR4tWnaC8JowKZaRKv2gyRiyFP/nLXGC1jrl0t4eeyVbkNYgvvx+/Ma9cEWOLmcyzR+Umu4G4YrVGTgxSiNHgUEhhg0BoK7kET5yINIJd6EYYC/wyHOR/fupGzK7f6mwdoir1JCB1f/CW0yualk680tNlL4HlMMMyg0gLZZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Wed, 16 Oct 2024 10:14:30 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 10:14:30 +0000
Message-ID: <f6f3bd00-6bd7-48da-8be3-fb9b24bd164b@amd.com>
Date: Wed, 16 Oct 2024 15:44:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] iommu: Introduce iommu_paging_domain_alloc_flags()
To: jacob.pan@linux.microsoft.com
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, jgg@ziepe.ca,
 yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-3-vasant.hegde@amd.com>
 <20241009141414.1ec7441a@DESKTOP-0403QTC.>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241009141414.1ec7441a@DESKTOP-0403QTC.>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0242.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: d610180f-dce2-4673-f188-08dcedcb52ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlBhOVM5c1pVR296MzQ4b0lxK3M5TlBXMDVMNmp6Q3AyejJOc251Y1lnbGVI?=
 =?utf-8?B?NG1DWFNXd1hLbTFFVkNPaUFCQ09hei9rTnhWcEcrTVgzUTc2dVlXQll2VHEz?=
 =?utf-8?B?amh3UUtLNnp4YjlsbzVsZytKMTVRK1N0MXdXejFmcGlnZVNRYnVTcGlmR2h2?=
 =?utf-8?B?aUpvTUhuOFpFcWdHdzJFYUg5S1RzU1VQTEhrZ3c1VHlkaVkrTGFSTDVtUkVo?=
 =?utf-8?B?cTlwUmhJT2tEbXU0emVUbzFRQ2FoaTNVaC96dnBhV1dpeUdiTjRibXdVNnBt?=
 =?utf-8?B?TTdwaTFaTFluUDBFbDZFQTFRZlVwaFBxUUZtRUtKLzlGbzNXSW9Gek51azFH?=
 =?utf-8?B?M3M0SFNiQXNmcGl1VlBhZ0JFSEhwZDhHZkMyWjVraGlqUXNYbXpoU3hnWklK?=
 =?utf-8?B?bVRCeGpSc3kvTlQxY2FoSnlaUG1kSGpTWHVhaUlJV0dBblZEb0dJWnhYcTd6?=
 =?utf-8?B?NEhoK3NuMmo1alVqMEtpdnp2U1dxZm5WUGFmNGcvNG1IN3pZZ09MWjA0RVZP?=
 =?utf-8?B?dmhIU2RmTVNVbWMreTgwMEV5NHpEcFAxZVFONHdsem10eTVweGdWTEhncURy?=
 =?utf-8?B?ekpoNERDKzlpNHZST0FpN09vdDJoZjMzT0paVWp1R05vaXhVWWJPMTF4SFlF?=
 =?utf-8?B?Q2Q0QjZZNHFLWmNZODNwSE9lNlA5WlZRb2VSVWtGNG4zd1IxdVZVWVEyV2tn?=
 =?utf-8?B?MnBGNkRzeGcvdGw2bFJpUndsZVlMNXVRc1ZKbUVOQTVGQmZQZU5zaC9YeXlo?=
 =?utf-8?B?Nzgva0x1YkhVaEh5U082bzMxMjN1TVYxWENteXZ3K3Q2eTA4T2NyRDN5RzNw?=
 =?utf-8?B?QnpmVlRadG0xL1BheWpId093VTFYK0JtdGUrMmtpeDA4c3dkR2lQeFdIQXA4?=
 =?utf-8?B?SUpoeEhPWTdTTDlrS0o0TnNFV1QybGo0OEdRWmp3WW1oY081ZGl5NW5VWDhM?=
 =?utf-8?B?enNDSzJyMmtlSEhvdmxMWFpKUHkwcDk2YTRUdDd1aGV5MkpOdlk4ZGhHSWR1?=
 =?utf-8?B?S0xpNS9lQ3Ird1d5OGNQSzZZcGxMSjN2Z0ptYmpFUUZzSkExN0kzU2duYjhi?=
 =?utf-8?B?b2xiM25pRnVLNCttQ3J3U0l1NDlCUVRoL1hpS3hsVkRHRTZISjh5akc1VXhC?=
 =?utf-8?B?d2tuNlgzZ3JCZ3FvM0RHeGg4TXAzSS9DUFQ4eTgweWtYbVdTcjlJc0dSdDMz?=
 =?utf-8?B?Wlp0VWRFZHd6SlY3aGR0TVNYQ0hlM2g0QXg0N0wxTkVjamdyc0dwMVdJbDNY?=
 =?utf-8?B?YTBSVjR5QmJ6TlZ1U0dwQjJsZTI5M1VyYVNlS3ZPbWowMG13U1Q0Z01Lb3py?=
 =?utf-8?B?cytJdlJhL1ZyWHVGdkpwQWFNa0JMeGRaN2dlUmtoV3ZNQ0cxcFZFZ1hzUzh5?=
 =?utf-8?B?VWlFOTd3dUNKc0hFQ3FGRFR1REVvbGZxRWJDUlJ1Y1VkWEt3dGx5UVg2WlQ5?=
 =?utf-8?B?aXRlYWdjZUMzTko2RGlvL3pxcXlEMXZqcEVzZ01ISlpWbGx3NzEvKzV2TnEx?=
 =?utf-8?B?N0cwTU1nUGdDSkJ5SmJTai9WQ1dlT0U3MHU1VTluZXpodWdibmFSUnNNaFcw?=
 =?utf-8?B?akdVcTROa0tWaTZiSXNYazFiTlZGbFI1eHZKVXJWeDBENm9Mc0pRcmkzTGVE?=
 =?utf-8?B?Z0x0OUdDS2ZVREN0QXFoRTdpZlJqUERZdHBMOGlRRnVGRVZlUzcyZzF1OUhr?=
 =?utf-8?B?amVhQ24xSjd0U2U2ektuZW5PRTJHSEhsY2IyTEQ5SndJdUlieHVIRDlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2NiZUsvTldzK2lpSFRkUURtWE1rUU1wSUNUa3pmSzNadTh0Q29hTk1DZ0cv?=
 =?utf-8?B?YURDR0ZPYlJMK1p6ckxtdmxvUHA1VWs5L2djV3NiNjZ2SFBocUhrR1RhMTA0?=
 =?utf-8?B?QU9SdktlNlVvYW41SzdsNXIvR010T1pYTEhCdFVOSHNMc2FtdjVBeC8vaEdl?=
 =?utf-8?B?N1MxM2tIMkQxbG5MWENudWJQRk9rL3ZlY05pUVo4aGh1Um1CSzhraWoybGYy?=
 =?utf-8?B?UFlzMFEwMkpESUNYQmo1T0hwWXRma05IeGdVL0pZK013T09VWTZHUnE0MDd0?=
 =?utf-8?B?cnVuZFdGTUV5eW5pVkwwa0FzN05VVVBqOEVGSm05eDFqT0Z6UU1qWVhPcVhN?=
 =?utf-8?B?RkkrdGRFMnFGN2YwVkFnYTl3SUJGdXlMN3Z0SzVmUGdBL05MSFNlajNvZS92?=
 =?utf-8?B?UkJSQi9ORnVSZ2hNdC9vWTg0TGNhd2ZJc3h1NGtLQnlJM3dmMXp2Y0dMNGxi?=
 =?utf-8?B?QWZvR0tpWGI3L3J6V0NhUTZ4cktVSnErczdYZjRmaDVuZnJXMHVrd1JKNXNW?=
 =?utf-8?B?bkFxTmdyZkJpU0J5R3hlNzhOYXppaFRITEUyejZqYmhuV0lKSy96NmRwZ0Yv?=
 =?utf-8?B?RGJKamp0cmpmb1VNTWxhYy9qVjZ6bS9UZWN0UTMyUHRkYXlZcnNIa0Zic2pn?=
 =?utf-8?B?Sm1KZ0NmMkx4NVBKYi9yZkdOK1U1MDN5aER3VU5PYWM2WmNNaUw3bEk5WXFt?=
 =?utf-8?B?V2pHLy9teE5LYlJYb0J3eTlXT0VHVHd1VFA5Ri9mUzZ5aDQ0NU1vbUJnbUQw?=
 =?utf-8?B?QzR2LzZuV1lEWkhTczBSWEJaM1Zudm5jcTZXUzFlcDB6WTdVRlNHekZkSEg1?=
 =?utf-8?B?bHVXdTM1VDFtMUI3dTYwVkZHMTJ2V2RlV3doTjNhTWEwdHJ0T2JkRkVndWw2?=
 =?utf-8?B?TU8yYlZaaG81aUZLb0ZWdDlZMG9nZ0crbDh3Q2N0eThabjRicnJjL1BydWdq?=
 =?utf-8?B?V2hibW1uOG1MaE1IaWdVU0FueGk3b212L0pnbFFzUkRpcmdTc0VqeEJVRGV5?=
 =?utf-8?B?dFJJTHdnRFBNb01yaG1qSzhUYUhrSjBDU1FXdXhSVmZxQU9pVWtGVXRkMktt?=
 =?utf-8?B?TXMwTW9xL3BYeGtOK0hEc0VObjlud3lGYXBFTExqUHIzM1R3ZHV6MURxZmxh?=
 =?utf-8?B?cHJXeUJIeG9nZklWM3hacVBvdzlVZE16VDMzUncxbVQxOXN6Ui9TOGNFNS95?=
 =?utf-8?B?anQ3aFZETGVlQmUrS0JRaUdFV0gwSW95Qmdsd3RTZkFLREUwdG5qTG13cHF3?=
 =?utf-8?B?RTVkRWRMTGg3TWpMNHBUbkZ4R3UvWGl3Q2xXTWVXK3VwcmQ4MTRNeFlLd29z?=
 =?utf-8?B?NEttc2o2aGZEVmNjbnI2ZDJKQmNDTXR2RGJxNkhPRzhCbUtIenYxWTE5VzFE?=
 =?utf-8?B?WVo0K05qLzRJTHJTeTNrV0VWM0ZwTmNVZE9FUVhuTkVOMVVMczZuVnl0bVRF?=
 =?utf-8?B?TXJ4SHdGU1R2eUNPMkkzVWZKbkl6UHkvN294cnFQZGJGekxmdEV0Vll0eDVz?=
 =?utf-8?B?VlpZL0dHRkREenZJc0t6NEl0Tkl4cWxkdDN3QTdxN2tsOGtNYTdDTFMxMW5O?=
 =?utf-8?B?RitQc0M0TXYwbGVreUNUVUYvVUxRN2RlQWNMVTRpeEF6bHVhMkNSd3Q4R1Q0?=
 =?utf-8?B?UHVQSG5wR0k5ZkRuVW9zUXFCS3ZkN3lkQ0NWYUl0c0FzQVVQREdLMkF3VlNr?=
 =?utf-8?B?NlhPSFg4bkk4N2k4VlFLbzAyREtrZlBoNjJycm5wMVJBNkY5cVpPRHlNVkVS?=
 =?utf-8?B?TmNPWHpHZXNtbzMrNUxEdTRDRDF3YnNTbDBhbXlDKzUvd285cjlhdDlLY0Js?=
 =?utf-8?B?NmNWckYyWG4wRDRrMXBXSzFZM0lWMnBGRU5KaVIxUlhjUzRKclVGSWpZRFhv?=
 =?utf-8?B?bFIvMHFWS1RDTklaQlR3MkNraGJVNngwMytwWE01WTFpTi9aT1greEFMMXcy?=
 =?utf-8?B?T2s4VlZ3eE9kMzJLVWZuZUtEdURNMWgxeC9nSFExRHB0eEpIU3pBTlJSY1Vl?=
 =?utf-8?B?ZHlkWDRiZVlLY0NPU1hqdmlFek5xQS94MElkMFlac2xBODQvUTBIMXV3bmsy?=
 =?utf-8?B?WnNtQ0l5dFVPN0ZMaGhzNHAybGZSN2s0dHl2NzdqVmV0UTQ3NUNiVkt2SlBt?=
 =?utf-8?Q?FU7eZNuL6QflLtWpvdC9+Y4Ab?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d610180f-dce2-4673-f188-08dcedcb52ad
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:14:30.4288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dwgtECrU5Bz55+/85KY8ABtCy1wusR7PmeBR+hRKDYZcIlukEyy8Xu3M8qTIvvkSszjcH85zbI3PhftDitb+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031

Hi Jacob,


On 10/10/2024 2:44 AM, Jacob Pan wrote:
> Hi Vasant,
> 
> On Wed, 11 Sep 2024 10:19:05 +0000
> Vasant Hegde <vasant.hegde@amd.com> wrote:
> 
>> -struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
>> +struct iommu_domain *iommu_paging_domain_alloc_flags(struct device
>> *dev,
>> +						     unsigned int
>> flags) {
>> +	const struct iommu_ops *ops;
>> +	struct iommu_domain *domain;
>> +
>>  	if (!dev_has_iommu(dev))
>>  		return ERR_PTR(-ENODEV);
>>  
>> -	return __iommu_domain_alloc(dev_iommu_ops(dev), dev,
>> IOMMU_DOMAIN_UNMANAGED);
>> +	ops = dev_iommu_ops(dev);
>> +
>> +	if (ops->domain_alloc_paging && !flags)
>> +		domain = ops->domain_alloc_paging(dev);
>> +	else if (ops->domain_alloc_user)
>> +		domain = ops->domain_alloc_user(dev, flags, NULL,
>> NULL);
> Since this can be outside iommufd, the following comment needs update.

ACK. I will update.

-Vasant

