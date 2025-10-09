Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC67299AAB
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001385; cv=fail; b=cllbsXWTfegqAk8kOFmjIKIYYI4HpJiH8iAI5bBxt/fnwYCIF0tzrxSi8mfmovqODj1MG12bztwEvD9EHbfm/D30ewjKfXbYU8CVYA12i5xGJs0/3IMGzKik0TbeYcmfBqmpeATV9SkJ1jIkkM/hrJdn+mi1k6VvoH74rRFl/hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001385; c=relaxed/simple;
	bh=jwh53LbuLLc8q0HGTTGFSIUwMK57iD8+qFgZQ6TsSNc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=hr9CEwuaLm10rEInG2Au9irvI6YWtF05lWv5WHgsG6BgWUlajIrQ14J20XmMOm9lkocayWwqa7vTXxHfspPV4th1ejWpVcwDTKxRQPl1rrL4vsfysI0tcTTQ+ElVmpXXGyeNOQbp9yB/tVn3sXdmJXt2fNQepV2JI2p4f/LuY8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yUJXP5Ac; arc=fail smtp.client-ip=40.107.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yUJXP5Ac"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqSp4BWo83CDAPrn2tF108b8147IcR7uw4CFHJ4qsIYabDXDsVJta/ziTCfakzogFOqoWSYq3o2//1HSl5TzfIl15yELNicE/QX02AJ64qlP4GRxSzw7NyWLwM1y8z19b/80ElpByjqf060FUFex6zP4W4TBqBdTxPIGDp6NXDqkX60yQG0WammRcoO4YiUpuXBfjdzwVXXncrqSawpNJx4eNB3UYPSF0aBzoafDM6jerJKXqofyIwkpg/S4DvvXylo33+HvRriJ/vuhcM2tEEXG9nNgtUrgz4hze4yezM2MWvFoZqHdHrYOTPMpihdD0TYyrXA4MH76Ozpkd7N5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBgFONdg3r5DmXuI65rdObe8m86Svdb8BRiGtJImzwA=;
 b=KgxrwoKzMTJEHtp1OEv5lA0wO5xZXFzCRYFCPhvaBadYrYX49usKhcfCqLLjDg3qT1+TCAh2d7QkG3RcaUSAogxTfBdE7WdBrgrW4j3vYqomVCTOjWaQhRuPCC4CzMh1ioFQf8+da7WJQWqK9mUVQuNIcbRxWPhEWQxzPdVaEqHason3U1B9dEKft04mqDMzBODrrwT+6o6xZaQpIEsuY1Qmr3FohUPlTH+5ULPSWrUKO6xMEAvOPau2H8AG0gXOVFktY/pAwJ0I99kMD7slZADdYzOFf5dnZ9/F+0F+STbtqXvCNme322jG4eqkJnUNoSl7HMs9eFIvFns+elPhQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBgFONdg3r5DmXuI65rdObe8m86Svdb8BRiGtJImzwA=;
 b=yUJXP5AcQ+jrA1FkF5Q8G3W7zoodEQ3X+MLBekAzAIGKg+X3+mCYiyHi8IdMjQk+uB/gYO+tPlQ/16BC/nt9ww41pEApMIeH3fypBx6kF8JJeKslKQNSd8SSyqx0NOTHL592Bpq82L97f2QkvFaK7L7iMQgMqXPy4qHqVKKTujc=
Received: from BY5PR17CA0026.namprd17.prod.outlook.com (2603:10b6:a03:1b8::39)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 09:16:19 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::31) by BY5PR17CA0026.outlook.office365.com
 (2603:10b6:a03:1b8::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Thu, 9
 Oct 2025 09:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 09:16:18 +0000
Received: from [172.31.35.81] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 02:16:12 -0700
Message-ID: <16455ceb-ae9c-41ff-b6cf-e3a61645fbac@amd.com>
Date: Thu, 9 Oct 2025 14:46:03 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] iommu/amd: Add support for nested domain
 allocation
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Suthikulpanit, Suravee"
	<suravee.suthikulpanit@amd.com>
CC: <nicolinc@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<kevin.tian@intel.com>, <jsnitsel@redhat.com>, <vasant.hegde@amd.com>,
	<iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-11-suravee.suthikulpanit@amd.com>
 <20251006144936.GS3360665@nvidia.com>
 <fd4341ea-869f-459c-a3be-a98cd1c8ba4b@amd.com>
 <20251007233931.GD3474167@nvidia.com>
 <bff5f16e-ea25-4c59-96de-8002373f17c0@amd.com>
In-Reply-To: <bff5f16e-ea25-4c59-96de-8002373f17c0@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: e710f795-17dd-43ad-9584-08de071481bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFVYcDRXNkx3aEZncWJPZTJlTTRmaU5pK2Q1ejdTem5jSlk1eThpQXAyUGRr?=
 =?utf-8?B?bEdYb3M5SC8zWXREb2dDblRaUnQ0ZnFKS2JOZFhSYVhEM0QxSUVYT3VZVERB?=
 =?utf-8?B?RDVwQzZoQk55ZHNDbEJjc1YzMTJUajBJN3ZMUy9NWWtrZUJpOUg1cW42d0E4?=
 =?utf-8?B?K1pqdVp0MFZWWG1pclB6QmJzR2Rhc29vdFdmNDZTdE9GQjRoQlo1ZjVYTVVR?=
 =?utf-8?B?a3N1L2ZFSUlhZWhyaGRCR0VDeHRkWGNCS0k3cmlEVmZneG83alYvYnNIMUhY?=
 =?utf-8?B?MUtIdEZVMVAxSFRSTE1NdEpOWENIQmltMEYrck91R0R2b2NFWFZxOTBvOFVj?=
 =?utf-8?B?VGI2UktELzQ4VWw3bHAvMHFnV3hjemNFMjV1cmFrektWM09mb3RLTm5QSnZF?=
 =?utf-8?B?MlozYzBVM0FHZ0dLajVkRDNIbHhESk9VQ1V2RmxObU9DRERUTU1XbDcxZ2RN?=
 =?utf-8?B?bituLytwdzQ2Tm0zMkFnbVFQZ2RrOUhrdzNSa1JXYjhxTHkvOWEwRHhTSklB?=
 =?utf-8?B?bHFDWHVqTkQ4R2hkRURETjF4ZnNOQ1gvejFSYjFOU2FBTVA3V05UVUxpSEJY?=
 =?utf-8?B?TlJKVTk2QU5CTzJjVDNneCtIQWN4d0ZNZEUrTEFwd1FEMVU5bUxSclFSSUth?=
 =?utf-8?B?b3l6L3haMmxCQWFxMXdVSzZQN2RzQ0hwNmx2VWtFWVpZZVo3a1JrTXM0Y2VR?=
 =?utf-8?B?WTVQbXhqb2JLTndpdGc4dGFLQUhNQ0dzUUZrVXp3K0kvUzh4Ym00alhWUTFW?=
 =?utf-8?B?SEFmNjJDbmN4bE1PTU1iZzNpZ3Z0Wjc2NUdFRU94THpFaEJIaDhjTnNqMm1a?=
 =?utf-8?B?LzZjOWtCejBVY3BkVWpqaE5mNUxWU0JTVE5YVlo4ZDRueFdLMXlTVXBZM3J5?=
 =?utf-8?B?NGN5amNjbDcxdUhUQ0xuc2ZpcjNCUXZobCtTMHhFS3NVL1ZQYTBvUkVic0lw?=
 =?utf-8?B?ZUpCQzBidGlSRVE2VzRkeFpqTDFYSVFvekwrNi9UUkFvMzdVeHZpMFhWeWtF?=
 =?utf-8?B?cTFrenFZbG5ocnZwc3ROVWMwZ3Nnd0xibERhenJxbkxadTJvNWRaN2FNZFNV?=
 =?utf-8?B?SkNGRSsxaGRUeFJNNk9BYmVOT0o3emdwTWlabU9SbXdYV1pIc1VCMXR4MWJT?=
 =?utf-8?B?M2RuNDl5RHRtSHo3OWZGUEI4clF0Mnl2YlRPdTBRR0c3ZWRHcTVwc0w5OEFN?=
 =?utf-8?B?UjlhZmdSM3BSQm1nQkNGUk1mSE9sUGoyUXJkRWp6VDlqeHBPaWwyM2lCdWNv?=
 =?utf-8?B?ZzBVei91K1VsTXpUbFNRc3BVOEVVWG9Ea3pPbVNUWHpUQkd6WE5sanArWVJi?=
 =?utf-8?B?K25VdG5WTW5QZjNzdHc2ekhUSEFlQmpXNndyQTlYenMzRGhGc3oxbHRnc1hQ?=
 =?utf-8?B?TE5ITzdSOFdDMVFWOTlJRzVxQ1NQYmd5a0pvZWExZ0lTV2NvMU1ldVVNVFF4?=
 =?utf-8?B?cGFMcnk4ZFV0NldreDhKRlpNNEhta1NZQ20xNkwwd0FFUlNBQXJrYTI4dkI2?=
 =?utf-8?B?dnBHb1duMmtRRHdtek82MWp4QnZuemZYV0RLbGk3cXB3RjJ6UTdGR09XQWR5?=
 =?utf-8?B?ZWhiM3Z6bDk4VTUzL0ladU1TWTdUZ3NaK0l3RndkVUxnbEd6c0RQbzVTSDVp?=
 =?utf-8?B?V1VZenJjbDhBaVdiVUxtMEFZc1N0V1JFT2lhUjk5T29LeFk0QVI5RGNqelk0?=
 =?utf-8?B?eDdJN0tqMDV4cFRKR2EwblN5OUJ2U2Yzc0EwL0VZOUVVdnE0a0xXME9WNlZv?=
 =?utf-8?B?ZURRWGJuL0VDdHFBRlFYbFBiRmRSb1drVkdhNDN4YlVmYTlOODQyaE81Y3ZE?=
 =?utf-8?B?aWNhYzBwRElOd2NhbTZFYjA3VzRkc1hyWXBOZnZGZ3VwNTFOVW9hSHY5VkhM?=
 =?utf-8?B?ckRGM3JGL1ArbzNqbnRPaFRzZkd5WE5HbGNiMmtXZlNCKzhzRzBtU295bFpW?=
 =?utf-8?B?WDFkeHM2RDc3VGdHYWtMaHFtYmQ2alRVMk9QemQwY0lSQ1R5STVyUWh1cGcv?=
 =?utf-8?B?T0NlY1ZPN3c2QlhXY1BMMHErRlFrUDNPSDdpaTRWNGFGYmpoQnBEM1ZJbGRY?=
 =?utf-8?B?dTg2dmUxZnE2T2dBYzVtUy9tVmYzWkFzMTYvOGVRREp4RTE3UU1DdTNHME5v?=
 =?utf-8?Q?uSBQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 09:16:18.9207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e710f795-17dd-43ad-9584-08de071481bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460



On 10/9/2025 11:52 AM, Sairaj Kodilkar wrote:
>
>
> On 10/8/2025 5:09 AM, Jason Gunthorpe wrote:
>> On Tue, Oct 07, 2025 at 03:36:58PM -0500, Suthikulpanit, Suravee wrote:
>>> The gDTE[DomainID] field contains guest Domain ID (gDomID). The host 
>>> IOMMU
>>> driver uses the gDomId and guest ID (gid) to index the Domain ID 
>>> mapping
>>> table, and store the host Domain ID (hDomID) in the table entry. 
>>> This data
>>> structure is required by hw to translation gDomID->hDomID to virtualize
>>> guest invalidation command. This will be part of the upcoming series to
>>> enable hw-vIOMMU.
>> Sure, this translation is part of viommu
>>
>>> This ndom->id is the hDomID, which is currently allocated per-device to
>>> avoid TLB aliasing i.e. A guest w/ multiple pass-through devices w/ 
>>> the same
>>> hDomID (same stage 2 table) and different stage-1 tables with same 
>>> PASID.
>>> IOMMU would use the same TLB tag, which results in TLB aliasing issue.
>>> Therefore, we workaround the issue by allocating per-device hDomID for
>>> nested domain.
>> But this is what I mean here, the gDomId should be 1:1 with the hDomId
>> and here you are making it 1:N.
> Hi Jason,
> The guest will only see V2 page table when we are using hardware vIOMMU.
> Since IOMMU driver allocates per device domains when it is using V2 
> page table,
> the mappings are still N:N and invalidations will work similar to V2 
> page table mode in
> host.
Small correction --> "mappings are still 1:1" because guest IOMMU driver 
allocates per device domain.

Thanks
sairaj
