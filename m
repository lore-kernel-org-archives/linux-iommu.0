Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADD3323B
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K33y5T3F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eO54kZ/O1MHx+A5NAe1n83uS3eB9pF9sWrFldIaGNW5+qCPH8EaCpTFij353CyAaQs/YkYx/XZtUO0cctCue0fb+zyCLT5Azji/GrsNVt4kvztaClRS9AsUUHd+s75Tkb3NwEgJKFFiJgFRkDiAENsI1uPV8izd/nheAVePryvYzkebfkXLUSzztjUOymiwwUBoSrpJevjqmOB2ACxu51G8xdEoSAJdvOfUdDxe3EqoIJ4m1pBACP8QsCjBmgDMr6CIEUbz3rKkc7l1/TCKZIZWKnM5jPoN3elplN3HYpZO0WWEIfSDFNHZy8+m42fsNVIP4rQ5nKPNU1qj8dYtQJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn1TcJ1EdwtqppeFVYuds7/tGW+kXftauYK6dlRUIM4=;
 b=Ww22GSTCIZvhEe5VDUMMb8HuK3ECon6Gyj3k0O4vk4CdemuvG3gnrTS4GPABloCfUn4oohnW4SzV4VGZBJ5NBvArueky9jRnqSib6xPdSOQV587aqJRrK0oFcYxxZbXPkHcRhLHMJtyT/GYn2xeS9tPOOrfiE9dPceTXr4b5Zd2R7IOu+Ca7TXRwwiWE5z2VRwDQPLqaFx+KRKss2NvEulJVNAKj2ilcPeKbMHvqDEdebGZCWBo0rEMlGTlbmmH9YUzxP8wHgncJ2vno/QtsvdskxIZEuNuappfFnIg9J2ot4PL90+C+eBccXzqVcsi/Ywdg4ouMPWqsD+QoawJZ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn1TcJ1EdwtqppeFVYuds7/tGW+kXftauYK6dlRUIM4=;
 b=K33y5T3F1ORvviSSk7PeOgO+brFDmg/G0nbh2FpsI7yttDgddCB8dk03JOp8jWKfghB0do1iAnIrnufWTNSJg8aY8bBdfFPxeEglxJbgFkoqyGlWG9O1hUBXmMD8Eg1lyT/PV+WWt2GCM2vM67ygj1bkZk9EcTd/wFF73GW8AbI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 06:42:40 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 06:42:39 +0000
Message-ID: <60a594a3-4b06-91e6-d2b1-17ca0ff58e8b@amd.com>
Date: Tue, 7 Nov 2023 12:12:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 11/12] iommu/amd: Add IO page fault notifier handler
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20231016104351.5749-1-vasant.hegde@amd.com>
 <20231016104351.5749-12-vasant.hegde@amd.com>
 <20231106232059.GW4634@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231106232059.GW4634@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::36) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: 28006db8-0cea-44b6-5261-08dbdf5cbc7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4ygRAgN2tvWKPqMtAqjLi1Ww2e7fy3BZG6ufuxDrhEp00SskS0MyVfGKQubQte33BXJaNf+r+5b19jsfcmAwTqGl6Z4+SaXbJJgBriqnvC1EzuVojz64yg1YFLCkgcXOnWkQ/JEQOaWOlNQ2sP26AFiKgdeGqANJNCQlMDse76DfJkDjV2tUiXc4j6ZqMRM1+Vi7d/sv/7Vl29qSy1r8+Jzt9lhYgpqGtLfVm5S971dS9YNMXoFAAH4Mm7rF9Rn8LlmhLQ3P9Eyqn/u1DzP+5cjMhkhaxl4Lx0UA2niC5TX+LIVqFWGw3Cy+QuGoh0UfdiTT7i62q7xiVRCas/mDN0Wwhcs/eCfx0QJgTbeGd/3MnjVQuziBYOjurcZMqjQp07jeuH2DaHazFvEkjwF3vLRxwU56KnGlKfNMv/zc85FXL9CwdsP2GEuduKIroRRwxiSYdowoccwmJTLGAnyRNECCCmuX8KB6KwRqoV33pf3U9Sihr1pPwRdTLevqFIWVC4+pM/x0L55JjXgBZu4tppjJqNujPEpnmAsm1D9ebiR07jVRcX6DKIvNGQgWGROGgcs8W9Km0Kd1pKODunjlsmSuty9Wl6bm8fBjpnkike+ghV3q0zJjbsxt4DVE7yvIGI8hWjuxonHfgfQ712Fqfg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(83380400001)(316002)(6916009)(44832011)(4326008)(8676002)(8936002)(5660300002)(6486002)(6512007)(53546011)(6506007)(478600001)(38100700002)(41300700001)(6666004)(31696002)(31686004)(86362001)(2906002)(26005)(66556008)(66476007)(2616005)(66946007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEJ3R1p5c2pkMEtyZFd0OTNSYzJLZkNIR0k4b0ozSEtEbmpFdzFtU1VxTEpl?=
 =?utf-8?B?QjJnODlSRUVmNUZuZXJ6anI0ZG10ZE41Rzgybkc5Y1FDUnMyajh4bldNZ0pC?=
 =?utf-8?B?MlFLSlltNzN2UERqYzVBY1lJZkdPeS8yc1h0aWpibkJFdFkwM2l5VzlJcFBl?=
 =?utf-8?B?SXJTVW5JUEFVV294L3lJQzVqbUdpdnRITVRkLzRDMmlMUVFkZ3lFNWdlV1FS?=
 =?utf-8?B?MDlnTXpYbWF0QkU5Q1hoU05pYUdQRUtCSEJ4Wlp2Ym9RcTRSVnNEbFVGaGRl?=
 =?utf-8?B?UHoxMmVQZFBGZzB4dzljdmRpWVlMOGx3WnQyV1huei9RZCt3OTJyWkNtRDcz?=
 =?utf-8?B?NGZwblYzdnR1RE4wcW1QNGZzUStpNVp3OWlmcjUyemlpa1ZCRmp4YmJLdTVH?=
 =?utf-8?B?a3p2U0JpSm83Y2VQMi9Qc3crSUZUcHhkZmJYbkFjV01IcGhBU3MybHRvSXlR?=
 =?utf-8?B?dTR2QXIvMGduN0tVaFZYck5iVnV6TUQ2bXZwRmE4RFNldkNpeWtMNC85N3VQ?=
 =?utf-8?B?ckdwTDh5VGJYbVNHb1pXRG1nOFFJdFJ6d29rRHlMVXlyMjFxNXdJV1J6T2dl?=
 =?utf-8?B?ajFsM3pDU28vcDZoV1VjakpLSC9qeXhHQzcrWnNRM3diNk1mVGsvaVFwdWRj?=
 =?utf-8?B?aHloQWlLUjlmclUzeExSbXBwOGFOb3hMSkFGbzR4RmhGbUNZRmZHcXc3Zk5V?=
 =?utf-8?B?K1E3alRPRmJLUjJsZ0RaRU0rcmZwNFJPZjBHSWppNkdNMnptaEpWbnMxbzl3?=
 =?utf-8?B?TkhFa1EvbDBaM3JXQTdjYi9paFlVaTdLU3dYL1pUMFpTbDNaUDRCOXhHbEVV?=
 =?utf-8?B?YXVqU1VsNkxTTlFqajFuUzJIRzRJZWFQWFBhU21VNjhaeTlqZUdWT2hRcWZQ?=
 =?utf-8?B?R29kTTVoQWRVWk1ObkR5bHFOVTl0Ui8xa1YyTDJkNmtXSHB3UjBPNlNZSmps?=
 =?utf-8?B?alA0aFg5anRjaFptY3JzTkswbE9EcE5TOTZVei9ERHFNazIwTUI1T1dKd2pk?=
 =?utf-8?B?SGV1Tm5yOVFsSDF6SlVod29NVG5WTW5uNWJCVkQ1S3U4c1kzalQ0eVI4WVdq?=
 =?utf-8?B?YnRGQU1vcDhhZUN6blZBKzdaamFBb2xWYXZFRTZBUHRQNW15UzdVSVp4V0VZ?=
 =?utf-8?B?VGZXTUx2bituVnJCN092RXFBdmZVYmVoRjVXR2hNMHNYa0lzY29pcUxBT2Vy?=
 =?utf-8?B?a3pXdXBzUGhydDZvK3JWZ0I4VXJvcGQvTWJINm9JZ2xnTjRtamVET09zcHQ3?=
 =?utf-8?B?NXpMRzJlS0hYL1dBcnZPd2ZQMlFORmhKQUJteUNvazhKL2Z4b2M0cWN5Mytj?=
 =?utf-8?B?d2NZN2o2bmpmNnpGMFVFdWFqYmRVd0thSFlNS0xHSEdMdDZlR0d5aTJDK0I2?=
 =?utf-8?B?cmhWTk01djRTU3R1Q3RMOXdmdWlXVlV2RDZ2OFpzakdqc2l0Y2M5UzZvK3Iy?=
 =?utf-8?B?S2dSWTQ4RjFMRHJiWnpvMUM1dGswc0VRdlEzc3FEaEZOSGNUY0VZWC9UNmZv?=
 =?utf-8?B?c3JxeUdDaUI1WVBEN293SlR5M1lmb1B3RytMcm02czJLT2hqNzltNEZkc0Z2?=
 =?utf-8?B?Y0lrRFU2Y1I3MkhvNzMyLzd3RzgxTldTbDJ0OHhHRTRUcVB3VmhOdE54K1dS?=
 =?utf-8?B?eXlFZ3hHSDdvTTdPNzlrWDlMMzZneWhhWW5FaWpJaWpLQm5RTCt1SFNBWUN2?=
 =?utf-8?B?VTNtbEFsdGp1dlNQVzU1OGhYcmxaMzVDOWdXV2gxN1FRNG5GSjU1SWFMMUFH?=
 =?utf-8?B?TTNLZWE1YnRlNnhqVjh1UitHdGh5bTFHL05Lak5Rd2VCMWhLU21jNEtpTmFU?=
 =?utf-8?B?UTZ0RG9BOG9iUkZWaUlsY01XUms4ZWdoM1VPd0pORU1KSTZJTWUrdDVNREo0?=
 =?utf-8?B?YXR5cDREK3BxVzdla2pnQi9acElGeVN5dG1IcnNxa3NnZ2RiQ2FycHFHUTZH?=
 =?utf-8?B?SHdiL3k0YnMrY1hTbnFUa2hCRU1MVUthdXVWdUVCTXZFc3pWViswVG1PaEN4?=
 =?utf-8?B?SDdzTjRUZTd2NzlTQzdSOU1nT3lSSVNrbHEyUzh4UXhTU2FKQ2RXRGJFN0k5?=
 =?utf-8?B?SUhPbVord09aTjhPRGVMenpNSVdETkdHblAxVjNjeFdOWG9CMWZOZ2EwVnl1?=
 =?utf-8?Q?q0s9qvGXdOFzV9nVUHxhXFfQS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28006db8-0cea-44b6-5261-08dbdf5cbc7a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:42:39.8733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5xzRz33i4qhEfURyOft2uW8saCdxTdf4WswdlUav93AeuAjs5Qy9kqIHw+u2OHcdyL1FUeKMt4jyvN4lSoI+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243



On 11/7/2023 4:50 AM, Jason Gunthorpe wrote:
> On Mon, Oct 16, 2023 at 10:43:50AM +0000, Vasant Hegde wrote:
>> From: Wei Huang <wei.huang2@amd.com>
>>
>> Whenever there is a page fault IOMMU logs entry to ppr log and sends
>> interrupt to host. We have to handle the page fault and respond to IOMMU.
>>
>> Add support to validate page fault request and hook it to core iommu
>> page fault handler.
>>
>> Signed-off-by: Wei Huang <wei.huang2@amd.com>
>> Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu_types.h |   8 +++
>>  drivers/iommu/amd/ppr.c             | 100 +++++++++++++++++++++++++++-
>>  2 files changed, 107 insertions(+), 1 deletion(-)
> 
> These patches don't seem ordered quite right, the patch creating the
> SVA domain should be last, it should be organized so the SVA domain
> doesn't work then following patches fix it.

We support PASID without PRI support. Hence we have SVA related patches first
and then PRI enablement series.

-Vasant
