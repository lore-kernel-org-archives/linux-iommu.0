Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BFB1CEAA2
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 05:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624345; cv=fail; b=lKx+KPqDfc1ySrZYhf7DKZKHz2kSqTr71GNXKBCu1rkM1NL+Kgyh1rrgFWY5yM3GDPMBZZe08311xfwZ1TpeZP7WPnAWL3ZRCWMfo8P0Woiki3fNdwRz6/XCcVDdc5Tq2ORUkleYChKqakuVbEIle+O3PWRQTmboQUm62/Ymqd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624345; c=relaxed/simple;
	bh=oeeX4dkon7H77yJqhjCzl4sl+XAbSS6diMER5UpL1qM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eJjfCmyuVVuJOe7E1jR+IXs9Y/gsS+vaKEM4jL+QcrD2m950YEsSbeN4FspO5Jb2QVJz4Gk1vrgFehp5ic5v8nmZqpjHM1GnfRC5+ObsHG5WhCvq53+po/mVaPzZyKc+5vk1wwqODJtGm8hU14jsN4jq8Y1o6ish97ZgnK3UGkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QoW9zZP9; arc=fail smtp.client-ip=40.107.95.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QoW9zZP9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kpl5MpR4oBNApXukfH/fNJRe+RMCJ77AtT40yzflU2Gcrg+eFJCC5wCb/aDo1xMMDl1btOnoyZSz6Kz5TOAVQRXtSVWth96gCjkYD89wBzEmZXXY7U6z3rpLUfSJ9S5vSd3hEh8rogXUTajyHLb41vSnSjPv0IiGYH8xRS44PORaDsCzsqQJoDJjqPJOWY/TJMJkT56ZGkS1FvCPNF8ArhYDTyYzwMH8g5y1jmvNOGfPzlHlMEbqynO6m2B0RR1K76Tf7LI+/Sc5XDwfXUnIWZs4zxSgxGeDVBqUsCXsH91Y3CTy/ryM0WhDJvxkOCJXZ6xCFpaLOWobr1NZbLlzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CaPZqyMhImTf+pIEnkJk9k8W/0gUQTfHEQ95fYuoY0=;
 b=SNMPfnJHzHGMyfiZ3XLcP3IJtCTzxwkwYbnspbUtBRD17GLSBFzrjEiKop124BrimE1YJEOiGSylnSw6C2fbjCAv1AZIw/XGuLvOl9WrZzLfCgwDr3NIvG2UQ4zMc6LWzK4XCezzM1CUcFyG0dc5Hp3vt46wAbojPYhlTa30vaC9EwPTl5upKQSQ6ddHO8OvZBdrTI9hNUtPzx1JylNIC/rM7slpouUciy44VsXqdRMle56qcjY0TCjD2XvEU4YHffBO5Q7DEmt5GAImeiJPUJqgGV05AFgjta/nNDSjEyocDa7aUmbmAdqjnXw/X9K7xE849qTDxFhX4tW0GtDk0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CaPZqyMhImTf+pIEnkJk9k8W/0gUQTfHEQ95fYuoY0=;
 b=QoW9zZP9aTtN4CYkn78sLOkLPWe55hDw2lM5Jgvj9Q6HoZHcgps1Ez9gi2eyVhijqLC4B2uGRtPFRwnYbWNsc3VsqQqCbgOcev1/Kl8mmrJ1hYXm46MgBN9COCJC17svXzpykZ/8Ul4jyhPoamPrHhEMyHVyJc/UtMBwIbmTAX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 05:25:40 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 05:25:40 +0000
Message-ID: <312be452-84ab-4cc8-b468-b6519d9abfa9@amd.com>
Date: Fri, 11 Oct 2024 12:25:32 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] iommu/amd: Introduce helper function to update
 256-bit DTE
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
 <20241007041353.4756-3-suravee.suthikulpanit@amd.com>
 <20241007140642.GP1365916@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20241007140642.GP1365916@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0195.apcprd04.prod.outlook.com
 (2603:1096:4:14::33) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 4925ba5f-0748-4f2e-9c9d-08dce9b524fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djYrVTVsdzhDcE1MMkMwQ1BpSFdrSGVBK2doRGJlendFMGFGbkJzMDVvMlJU?=
 =?utf-8?B?T3dUSURQQVVHL1BpcHZzd2UrcThlaDFvS3dOUHlGa29MNUdXMWY4YlJUci9L?=
 =?utf-8?B?TEFJc2c0MWFjMFV0ZjdSM3drQXZxOUZ5VVd5blNqWU9TdkM0dTZwREpndWtL?=
 =?utf-8?B?T3A1TE5aYTQxeXFMSTZTdFEwbjdVaHE3RHRnek53OEVUdjYrT2R0eTRpU295?=
 =?utf-8?B?WHh1Vk5MelhPT04zY0xBQkNxK2dVU2JGOWV2QnlHVDNETkY2UFJPM2RIbWh4?=
 =?utf-8?B?YlROR3dLUFhJbmRFWVBOa1JPcmdCUytiZnJmSDVGbTMwRjFkUUJKamVKOS8w?=
 =?utf-8?B?ZCs1bUxqUDZRTTNjVks4Qm00MXRiTDRaMVNVSUkrNExIRXJLY0VscGp5OHdO?=
 =?utf-8?B?Z0gxdmpSSnRPV2hNOE05b0FiQ2lydDJtUlgxWG1OZWFNU2lmbFlEMUVOVW9h?=
 =?utf-8?B?U0dFYjd6dHZvdzBCQzFXdWQ3SDZXK1hPVm9RQ3I3cGxadDVQUzlZOFgreE1S?=
 =?utf-8?B?UE9SR1FsSFB5OWNhV0g1R01DZWJ0N2R4dExmRjBFVm5ib05SQkRDbnd2YlZQ?=
 =?utf-8?B?UmVUYVQ5OVJmZkxaaFRVeW1DU3dxQkdGVkxiZGlJMG1STGdjOWY1bFhKTkdo?=
 =?utf-8?B?LzFxVFZxck9temVEdzM1NkVWWXFFM0t6UVgvUWpoTlRQV0tmYnpxMzZ0ZWRC?=
 =?utf-8?B?S0hrTkhjTGRSTmliNzFKMVB4U01wL2lxdmt6Nk1uakxLZGZ4d1FtZ0ZZQk9x?=
 =?utf-8?B?YUNNSE9BM2JxT09VQWhrNEtyUFNTZFRpaGtTdDdzN1QxUTllMU43VWhTeVRR?=
 =?utf-8?B?emFNeEVyY0IxaEREWjZIWG1NTHl3N3lwZ3c1THhkSmY0UnlNaThneEZKT3la?=
 =?utf-8?B?VlUxeXc0RmVkWGdHSnhQNnh3SmZmRjNCV2I3TTlkVytJNXdsdXFYYWFybXI1?=
 =?utf-8?B?dlRabHAwS0dYdEp1R3liKzViRWNkS2pYOGc4aXFraFVuQndtK2U5a1FMOHZl?=
 =?utf-8?B?ZmNWVGx3TU1SMmVxU0Z1WGROTUxSaWxYVUJxUDdSUlh3T25FdEFHREluck13?=
 =?utf-8?B?aTVpdjhJbnExUU5KM0Fib09Ec3NRQmhFWGVwVm5wMDRBV0NmSThtTkZVaUxo?=
 =?utf-8?B?cGRCUWJJbFg5c1JrbkxDUjlQL3A1RWZzNXYyV0EzRmNGa0dqKzVkckVjQWZB?=
 =?utf-8?B?dmcvbFJJMGpIZGRZOC9CUnR4dldjK2luTUNWL1E3S2hkajNaNUN3RVN2aUcr?=
 =?utf-8?B?MGh3U3oya1cyc0ZwVmlyNStVNGdyK2Nrc1l6V3FnT2tENFFXelMyQ2E2Z1lE?=
 =?utf-8?B?aWs3cE9lOEovV0Vla1I3OXh2TTRVWUFWeSswUHVIQ0VMb0s3d0RKYlhMa1NH?=
 =?utf-8?B?RDJsNEtvSVNzWVpYc3lacXhBK3F0a3pSTmwyWUdNekg5TnVNeG9HaU1QZGJx?=
 =?utf-8?B?aVJVcXkwSVlXUE5BaDNrbGR5K0VYcjRZdEs2NS9zTmdOQ0NYUjY1ZFc5elhL?=
 =?utf-8?B?UGxyRGx2R3VKdzlOUlBFMDFWMTZoTnQ1a29SM29mUmg1Z3BLU3RzM2x3bFJG?=
 =?utf-8?B?WFdtMFVvakI2ZWNwT1l5RUg4ZExoSnFYTldpaVBrRUgzLzFLd25ySytKUERa?=
 =?utf-8?B?Q0xyd0NEUGpTbnU2NEF4Y21RcllzNTc5NFZnTCtjZEZRL3M5K2szb1NiVmRH?=
 =?utf-8?B?WFBVZThPU0cySHN5VVlZMndKSnFQVTkvSUZVakRyRHZSQzgvdHNHSmxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXRsdnVmWmRJSHJ3bWVkQTVCVUNLZjVlTTBDeVNhVEcwWjBtejVpTGVxOG1I?=
 =?utf-8?B?bis0VHhpam8vR1F0UjZxbnBPdlZSbDFPY1BYUjRwT21mcDlXdGVDNFQxSnFa?=
 =?utf-8?B?WE1FckMvNW5hQjlDU1VIdjlJck9ZOHpaT1hScWZHZWFyZVpEOVkvaExtZVFD?=
 =?utf-8?B?QTIwN0Y0T0J0OHhPTFZXdUxUemx5cXIzVEZSblFIZXAxUEoxVmlFY0VLcEZz?=
 =?utf-8?B?Z05NNjR4SE5ITFk5OWkveWt4WU5yYnJ1Wis2YzRid1JkTGFCMGMwQmxMcWFa?=
 =?utf-8?B?SHNlUk40K3Z5OGk2WDlCNi8xM0t3T1VwaWFrY09TdnNVNmhwL0hNMU85dGhp?=
 =?utf-8?B?L3lkT0I0d1VxSFAya0pHS1NnUHhPZzlXdWVMczZjWmdjMGh4ellqbG9pekxn?=
 =?utf-8?B?UENHdWRwYWt1WG0zQm5qa0cxTXFqRjEvUHZTalZMNXBXSUpMdlJCeEpla2Jx?=
 =?utf-8?B?b3IyNHIxUm1RTUhrOFZxQlZpVTVzeUdxeHErclZYV3dGejNjVmQ4Vk1USzd3?=
 =?utf-8?B?emV2RFVIWVl0NGZvcThMSXBoSXR6dmhXL2hNcDdubWdmZW9UTXhxWkxFMjlw?=
 =?utf-8?B?THdjYlJWR1RwWGRIWTQwZS9mUlZTOG4rZ2NicEhjTFRUUktRZU1LaStVOWw3?=
 =?utf-8?B?VDN0OTgwd0cyOHc0TGd4SitpY2pPL3hDdDhGMnhadnczaEVaOW5FSHZzRExi?=
 =?utf-8?B?aVZraVZQYU1MMTBMTi9yNHlnekpxdkNqNk96TXgvaTZlaDY5NkRiUUg0T2w3?=
 =?utf-8?B?SXNrWGJwK2U2SUR4SE81T2tmb1dVQ2VMNEFkck1vNzBhK0sxaFc5RkNlVEpO?=
 =?utf-8?B?OS9nN2NydDlDaUF5Nk5DWnJweCtOL3lraThUelBvUCtBcEd6ZldKR1VIOUNh?=
 =?utf-8?B?c1BEUnoxWXJjYnpKK2F5MzB5R1IvK252SWRrWVlreVdSNi9yb2hlNnBKTC9j?=
 =?utf-8?B?SHQ0bG0xOEpyclBnYkZrdTFLcDlyaE9qNlZhTjkrUU9NU21NdjNDNXAxbXd3?=
 =?utf-8?B?ODVVbURHUE51THZiNjhtTExSQnhLWW9Hb05sYVdGd292TGNTZmtuMEFEUWhx?=
 =?utf-8?B?QlRURWtaV3JwYlB5OEVOcWpzT1lrNHp5Zy9UbUtoM1VZcW5HVmNHSitNTitH?=
 =?utf-8?B?R1N1YVZ6b0hHRitib3M4WENZYlRrZG8rOWdvdkZLTlRqN1NkSk5qM3diR05D?=
 =?utf-8?B?anJNNkEyU3UwOFBGcUE3S3dKZlpwY24yd0JoUTRzdFdtWXNVeEV6QzBIdFhG?=
 =?utf-8?B?Vnd2MzczbjlGbENWTVgvdXZLYXZXV3pkTGs0dEV2U2Q4cWtSeGh5a3N6KzNn?=
 =?utf-8?B?VHMvd25sZFBHV1l4QWt0VmNtTW1yVWNCZXpwMFRsYXlZbUNQdDlZMHVWTk5s?=
 =?utf-8?B?MXJMMGtSUEd5cUV6amt4a1g1ejdUdTBvb2M5YjhGVHZFMGFJc0NUMXpYc0do?=
 =?utf-8?B?YmdKeE91WlZPN2xSZkxmTlllUDIxNkRYTWkvMVNmWnl2QlEzWlZqZFZVczY1?=
 =?utf-8?B?cjNMKzdWVm4wRHNaVEF6V1hGN0hSNTMxSjBmK3d1bnpWNXo2d3R1cjlMa1Er?=
 =?utf-8?B?dTJEMDdsYWllNkJEdGZqclhtZTRaVllJRklGeFBFRTRtcTRjVndJdjlJRDc3?=
 =?utf-8?B?TjY4dzFlNDJBRE5ZYldVVGM0Q0pUL05BU1MrOXFxdXpYQnJyNklJcHlHbVlF?=
 =?utf-8?B?VXpHYjZIMHVVb0NDVThLNlJtT3ZjeXlnYlRXK215d3plcER6UXJLMTA5Mk85?=
 =?utf-8?B?T0Z3M3JoYi9jZ2FIRGxVZVBHbkpabVZRVlpUQWJBVG1wWUNjWHdJZVVYaDBu?=
 =?utf-8?B?NlErOTdzWGZ6bkFmVXZPLzNMRFROeGU3Z2NvL1duS0JtTHpScm1ham9hK0J6?=
 =?utf-8?B?QnFrTkFtMGpsN0dlZ0JBYWJoamNyNFFvYzc4aWhkdHAzQVNPekZQaVBZeEpG?=
 =?utf-8?B?RTkrVGNPWFpIeTlvRDZmcDZvKzhxdjZMYWJHSVNyT3pVZm1xTmRYSWFNdWJp?=
 =?utf-8?B?T0FzeGxSNkRKOFlVaGJIMkxyK3A3SDB4c2x2eDdqNEV3UnQ2cFp1R3dUWGpK?=
 =?utf-8?B?a3djdjB5TWw4b2hDdHhLWnorditOcEMyUXNQVnk3KzlNdnlFL2pBMzFpS09R?=
 =?utf-8?Q?jXedgJYZz0eRE4kYBY8aSloj6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4925ba5f-0748-4f2e-9c9d-08dce9b524fc
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 05:25:40.2407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntuRP8IZ0ZUUM5OHczXCjTOlSCY/Mp9zoCcLNRh6RCeFm7ga+HOA7DRAHuO1AwIr39MstK+SXt9kciRTI+4sZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227



On 10/7/2024 9:06 PM, Jason Gunthorpe wrote:
> On Mon, Oct 07, 2024 at 04:13:49AM +0000, Suravee Suthikulpanit wrote:
>> +static void write_dte_upper128(struct dev_table_entry *ptr, struct dev_table_entry *new)
>> +{
>> +	struct dev_table_entry old = {};
>> +
>> +	do {
>> +		old.data128[1] = ptr->data128[1];
>> +		new->data[2] &= ~DTE_DATA2_INTR_MASK;
>> +		new->data[2] |= old.data[2] & (DTE_DATA2_INTR_MASK | DTE_DATA2_RESV_MASK);
> 
> Why preserve the reserved bits? Shouldn't they be reserved by forced
> to 0? Should have a comment explaining this

You are correct.

>> +static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid)
>> +{
> 
> You might consider re-ordering to avoid the function forward
> declaration.

This will require moving a lot of other functions as well. We will 
consider this in overall clean up later.

Thanks,
Suravee

> Looks fine otherwise
> 
> Jason
