Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7755FDA7
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051495; cv=fail; b=CO+KgCunsqPdG4Qm2L7/fxFikneKfuCg9RTJgRlif+tMkXA6PWFYP4wvcxy4DKf0XYOg7R56QLzsWlDAKxK0cGFqMIgIxms4Q07uVtoPEqXfU5fsScg4rOSDbCHxcMlLva2QgTIOWZBhKVMBVlg8qMHmwZ5fm2EvMH+QMHf158g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051495; c=relaxed/simple;
	bh=aNHdpg2FVdvj4bcfFzhCZgIdP/3EmpIWWkAaGG59fSg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d98g9lW8QYzKoJFDzd+xa6QfDnpiUfRjGwt2OSjj9r6BbdMgCokI8behyeOv2+8cbdiEao787mOvpqmsURbzkUbwCjU8ak9IzpzvKOF6C0w69ZCmGGus6qbhG2vcUr26CiLUbrOAQnhGMdDQmUK5BKkMiUGeOVmoojqwC1GyotE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t6VeCETU; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t6VeCETU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVo3DS0ScFQ4EmWY1Far56wKLth3t6bFUng7qcKKe/RbaWwoDbMZjxf2cBcJV7NTo3oW0tqTLWtrm/8CmkizO9VyPE4T5CAWBux2h/wG0csI3qC7ISE/RNuQ/r4NmgwUmWq5z9nBFxE4kZs8VY2EzoU7IRmd8vMogHT+Y0bsEqiovFEQu5vyq/zVEMIcxdFUTI1NoW5ANDKd1XXgrAllVwLQRZeHCweBav20Vh7RPkV0OdFDETQyXDUc2FU8whT7BJk+Gc58pUKVi/lAJ9uEdufeYMpY7P/70yqBzVZYOLytGQKKtEBrPaTmY4TRs8NduCbPuVAI4scI1DrfJpXu8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JW4AB+GBK265N+YJEsHFtsxW1AzIkfN+LcVILLkEYc=;
 b=cLH/aN9CeIS4kIEEKWhKCEXOgSYeDGd12/B2G5FE040ckYQ7qb25sIyi4VMI9AHGbAseLKWPX0cknzQf0X3qHd/6XfkkNyJ13qe4+wWl1RlcQsNld7j61eVb+0RoH+4qteUtQDbbNQmCjFZ+yiC6iP9wiuGpEGvb/PPIXsuj6pqbcz361JxWHv7bqp2A1hpU86gJlutpIQOmWFT01I08as25T5c5fv/J/Jn2elsEQmecuQG3lX3zp/krX6ehurvz5oK3LTrFGbPF9cpRlSkg8nKpbPhiz3yLQF6KaVVmNRmxz1J/BlYQb6R15+35+ttHTwqox0BxfOF0lj22LTEd4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JW4AB+GBK265N+YJEsHFtsxW1AzIkfN+LcVILLkEYc=;
 b=t6VeCETUZN/03jOzUy+40AKvB0jJST9pjzhW6mS60k+M6xXVaSieUV3kUtso+kbeNz/7Cp9MWIoWidtKzXaEOHHoZLIJkE1B6U5fDwcdDr8C4HWJn6N/Mxgv+vG4QQZ1fCIchXI/2i6DEs/NddaNgwG7/duqWZgaA0DZLPQqa+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MW4PR12MB7190.namprd12.prod.outlook.com (2603:10b6:303:225::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.25; Wed, 11 Sep 2024 10:44:50 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 10:44:50 +0000
Message-ID: <00b346a6-21b0-4b3c-9dbd-c42325bd3335@amd.com>
Date: Wed, 11 Sep 2024 16:14:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] iommu/amd: Add iommu_ops->domain_alloc_paging support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-6-vasant.hegde@amd.com>
 <20240821155719.GY3468552@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240821155719.GY3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::30) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MW4PR12MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: a72763d8-2885-4018-8360-08dcd24ec2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1FHQy9CUUkweHdjMENpVGZtbnp5UlBUNFdZeWhldU1HdFk2Z2FwVkNxTm9a?=
 =?utf-8?B?NjVDTFhQQlNuL0ExS1dCRUttb3RkYzNaR01ScThpdzNXa3BkUVBjUkpJSEhO?=
 =?utf-8?B?a1NnTlp5YXN5dGI1ZU5pY1pZNTgxWFJvZnZQOEZvaFByTVhENUhGV1RCVGJG?=
 =?utf-8?B?YW11L2FlNU1UVEtjU3g5YTN6ai9pczN5bHZmZ1FFbnVqRCswN0gxL2svdTFI?=
 =?utf-8?B?VWw4QmgwRzkvMVg1ZXpRMGpYRlVRdE8zY1JTelhWdFBPU2JoM2E5NU9FeUh5?=
 =?utf-8?B?RjkvMzk0dWhnQTMrcmJkSHpBVVNMRzJYaENTREJIY3hMYy9MSGFVb2JDYUcz?=
 =?utf-8?B?ZnFyQVFXL0lxTGxNMWQ3VXZoc1N6T1dDZkw2b1d0Z0NHU1AxanRFdHBQRmRs?=
 =?utf-8?B?bDRhT2pmZ0N3ZjJvOEE5VzZKRmppVE1IbmIvbjVjdWM5RWZhVS82L1diMTNL?=
 =?utf-8?B?bHo4UDRweG44dFAvMVFlSjI5Y1A4R2FuamMyQ0tuSFh5UmFvTG1FcWRiVFNv?=
 =?utf-8?B?UjYrVmFLVmdVWXczOVZqcDloMEUxcFJsUnRvY1FmdHZoc2xOdmxNUGJhcTdD?=
 =?utf-8?B?bTRkRkdZL2FiNnNFMFZXUEMxN3JkUXRwa1BlMExtcVFMVDRQeEg5LzdhcWZJ?=
 =?utf-8?B?bkt0ZUttTThra2NLeUZvNEFkU3REb3lPUXIyV2tRK0tDdVpjUVRsSE9iL3Yy?=
 =?utf-8?B?MHVKZmFXT2grMVZnUlVGMklXaDVNTDlUeVFPcjYxR0s5MlJkU1RlT2l4VUdU?=
 =?utf-8?B?WEI4Y1JRVU5GQTR0STJjUEN5R2RxY2VXZFZpWlAwUWxuZDUydzdCVVJBRWcz?=
 =?utf-8?B?NzhBMUh1VnZLeUZaQmRIbGpaRjdjall6NmdldVg2NXJXbklybEN4dFJCeEJX?=
 =?utf-8?B?VXJLdHNwOFZGVklmVWJwY3BXOGwzVXpUUmUzU2IrK0NiZms2bndsbE5YaTQ5?=
 =?utf-8?B?RFdHclFwR1NBTnVzWUptSXZoWHc5MEFnNm1YbmFOeVYwclBWbzN5OEtUNFgv?=
 =?utf-8?B?L1NMRnRaMTBVUkZucjdnK1JVQm12RE9kZDRyNk1BMVJCckw1NlA2NGIxZEhC?=
 =?utf-8?B?dEUwNmhZR1pxWk5BcitJS0huZDJrUVFQM012RTFaSUFGWE9ZaWRYWHJoNi8x?=
 =?utf-8?B?MjRnaStvTXdZaFF6R2RTcVlERE9RdUIxQmVUSHF0R3hrZ3B5a1NXZUdjV01T?=
 =?utf-8?B?Q3Vaa0oyZnV5NHVZL21hbEdXc1lMWXROOVJ1SW1rM3crRjdUZERVU0hQY3oy?=
 =?utf-8?B?Um9aS1BoZkJDYk1qV1ZJOE5aSVg5NmdObUpSSHRtbEZCYVVEVjMyc0ZUbGZS?=
 =?utf-8?B?MkV3elRaK0gwcWoySk1oMGo2cUZ6QzNad0RPdkN3dE5HandPMlhLWWxvcGpp?=
 =?utf-8?B?dXRVS3M5NE1aQndPSVFROWZ4aEZPRUxhMUI5SjF6cjBRMzFHUkZuNjZaY0tN?=
 =?utf-8?B?bDJJdmZObExUZUdOYm1nK0RXR1BraTJaM0VwMk9iT1loOUs4bnhKVzQ2bG9Z?=
 =?utf-8?B?ZnVhcmtpMTRFcFc4RXFMYXJROFdkTFd2djM2djM3am1KejNxczJHdjBFN2Fk?=
 =?utf-8?B?Mk5QWDljYVJ3MzdwdXpSSDd1OHdXT0VkOStsVW43YS9oM1BQTzMyQ1g1WVdY?=
 =?utf-8?B?RndZbWppdEFqNmdQWG9BZzVSb3YxVnAyU2dmQndGTFlOdFdZQjZ2OXA5aG1O?=
 =?utf-8?B?RDVUSmFlSEdVeGhhOXJqK281RVo2b2FVZWpvNnNtb1UrVzFURmpxbmRVanRz?=
 =?utf-8?B?R1hERERua2hKVGVqeE54YnN1Y2Jxa2NIMHU0VFcyTUl0SlhMbWhSWXFRT29Y?=
 =?utf-8?B?WWl6U0ZDWHdhODNoam04Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2U3OVFmeTRBYTlqWGFaZmZ4dUJuTHc0WXdITXJwT1pmeElWdEJjdGxtQ3Jx?=
 =?utf-8?B?K0tRRVpINkFvQjQ5dENWdXFCQ09na01IbkVLbExraU05TkhtMXVha2J1NFhE?=
 =?utf-8?B?MHZsTDcrVU9abzZhZ3ZmS1lSTDl6UXFoQW9DMzBnaFNleTVlbG1xaDZaMi9p?=
 =?utf-8?B?cVRLWnEvb2IxNDNzSGdOYzVWWHJaMUhjbXNYenNkaDQwSEE0Q2ZkMXJHL0RF?=
 =?utf-8?B?L0cvOVJpT2sxWFhLMGVmMDBPQno3WFRoTEg1Z0liREk3dmI5aXdUd1BWdHB6?=
 =?utf-8?B?MzcwUVprZGFDcWFqWFhuWCtzUFVNMU1USFdxaUtuTjdjU0syS292a09Gallv?=
 =?utf-8?B?aVNCR3VJcDZXWngvVFBxVTVvSElvR1I0UW5ybCs2Q1BMSDB2NDlsZkd0Q2N2?=
 =?utf-8?B?Rnlxd3E5dE1DSWpWWHk1Q2JFZUdHZkIyZVJ6UTZudFFXbldSQkRjRjBYeXJn?=
 =?utf-8?B?Uzdta1VCQjZpY0lzZjl1OFNyVGFKZzMxQ1BXeHpWRTd2SkViazJnZzVPUzlx?=
 =?utf-8?B?RUVUVDVKSzUwRFNwcFRPV3BIRjJGQVF6ZDRqQjY2b1NycDVlUnRBZ2tWUW1a?=
 =?utf-8?B?anVOaEtNUm5ocDg2TlNrc2doNkJhdGRiV2ozU3pGZVdYQWNPSUhVRUNJN09n?=
 =?utf-8?B?SjIrZWpRUGZUOG1NSEx4UWRmZFRKYU9qeG5kK2granUxME80QldqTGFzcGRI?=
 =?utf-8?B?VVliVnZCb2kveTZzSzJVVEc0VnhQYlBnRUE5Tnp5NEdWMEh0LzBzQ29kVUY0?=
 =?utf-8?B?SmVHSnhBMnhJVjhyNEFBYTBtMmlUclZROHAzdjhSK1h2b05jYWFwV2FBZzIx?=
 =?utf-8?B?blFtMnkrc2x6elhpZzRjci9lYlNSZitqaTlNUFhJTlo1Yi94VXM5ckQ5TE8z?=
 =?utf-8?B?OWdlZEJHM20wNEMvMVRneFZlcis0T3Y4d2xnSzBERGVaOW1CVkdVOWZJcDVS?=
 =?utf-8?B?dWpmR2tpdHJZUkNRR0xsM1ZUdjdldXdQQWQ1dytjZGZoSkRmYVFEeGJNN3JT?=
 =?utf-8?B?K2hXR1dWTVpzTXREalBqY1ljTzhOZk0yS3VWL0xKMmppQjdpNEtSWG9ZVkZw?=
 =?utf-8?B?dnowQTZnYThOamN3a3JGSUx3bGhUVkQwc1ZVQ0ZEalZ0Wk1qUlVONWswejBk?=
 =?utf-8?B?alBTc0NvL1hFeGJZbXA1VEVxamN6ZSsrVUw0dFRIc2dEOGVOWDdXZGlSejA4?=
 =?utf-8?B?S3JGNXR0cHUyRnJZNUhPWXNBK0N4WGZkbmxKT2cwRUlPTjRLeXpJbm5LcGFn?=
 =?utf-8?B?cGxLSTVrSGJOZXErSFpyaTlXeStOVndZcHJYV0VhSkJGWFFhWjhsSkhNU3FU?=
 =?utf-8?B?TXBuRkhGSlMxbVJ5MVBIdkFTYmIxdGJlS2wycWRaVmZhait2WG05dWVCR2lk?=
 =?utf-8?B?VkJJMzNCMDhLbkJuejZnSEpSWmJCK3V3Z2k2NmZGTVpjTnZRMDhMVFN3ZUJ0?=
 =?utf-8?B?aDhrTzk1RkJzK05OR1RCK2gwTUhTZU9HSU0wMHo4VHFYaTNaRkpjN2tZeU52?=
 =?utf-8?B?MTVpbTJJZjZtcC9rVklvMmRKZ1MrNmdHd25LcTMxTEw3OUFrNlh4ekJBcDBQ?=
 =?utf-8?B?dnNENWEvcjc1TjE0ZW5lcEhDVVN5SEl1SGI0cVFzWXV0Vmo3UDRjQ2ZVU0Zn?=
 =?utf-8?B?cWliaFN0eUJsbjlHTUdpYWJuNGJtYUpGQ1ZwUXJ2amZsWng5MzEwN2VjUkU3?=
 =?utf-8?B?SDFLaHRuRnM2bC9oVHlJWUJiWnB1R0VrczhYa0hOWUl1QzBvZGRUMlNyZDZ1?=
 =?utf-8?B?UXF0VVBSRmM4ckJGbGRybUhVVFQrT2dmSGY2bTlMMzlkeXRPaEQ4bjZmOFVv?=
 =?utf-8?B?UU9lL0pPM3hJRjNKZ1U2bHVxbkZwdDZ3cmtSb254dVJUUi9lMGtzeGUvQTUv?=
 =?utf-8?B?d20zTC9DT09oeldQbHN3ZEs5RmNCWklaZXFEcGo2Z2J1d0dGK3F4QStmUUZG?=
 =?utf-8?B?aGFJKzhROUNMb2FyRi9rTmw4T1hCN1IrMzlndS83aXhJMHZ5Zm03cnFTcG83?=
 =?utf-8?B?Skx5NC9kRUo1WkdkSlIrZHhVOEdsMGRDQng1VWY2RHVOK2EzaXdHRTJLR2VI?=
 =?utf-8?B?Uksvdmg2KzlzVmtLTlFCNytiT24yQ2pUMXZ1cnVYZmlORGVlSDZGeWxnOGxY?=
 =?utf-8?Q?RvS81krXWin4dY0aH5armyx2i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72763d8-2885-4018-8360-08dcd24ec2ba
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 10:44:49.9269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGfPswFxS43lSEKqR/MywlmVTOJb6qCu+RCOLbmYKvETdjBEbyhWsSigFEDIuh1jpstg/4ji8O66acA46/0mBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7190

Jason,


On 8/21/2024 9:27 PM, Jason Gunthorpe wrote:
> On Wed, Aug 21, 2024 at 01:35:54PM +0000, Vasant Hegde wrote:
>> Add support to allocate paging domain. Note that core will call
>> domain_alloc_user() to allocate PASID capable domain. Hence its not
>> checking device capability and allocates page table based on
>> amd_iommu_pgtable.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index a4e6789f0487..7bd1ce5469ae 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2437,6 +2437,12 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
>>  	return domain;
>>  }
>>  
>> +static struct iommu_domain *amd_iommu_domain_alloc_paging(struct device *dev)
>> +{
>> +	return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA,
>> +				     dev, 0, amd_iommu_pgtable);
>> +}
>> +
>>  static struct iommu_domain *
>>  amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
>>  			    struct iommu_domain *parent,
>> @@ -2879,6 +2885,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
>>  const struct iommu_ops amd_iommu_ops = {
>>  	.capable = amd_iommu_capable,
>>  	.domain_alloc = amd_iommu_domain_alloc,
>> +	.domain_alloc_paging = amd_iommu_domain_alloc_paging,
> 
> Can you include the identity domain conversion too and remove
> domain_alloc entirely in this series?

I have included global identity domain in v2 but deferred removing
domain_alloc() path. Once all these changes settle I will remove domain_alloc
and some more cleanup of domain free path.

-Vasant
