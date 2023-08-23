Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBB3BE4D
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 12:07:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+jeJhCeKGHktsGUe/Wx//ZdfEKAHMk6qyWYCKHPzxECbz5BJYfoSkUtjlEF0WmNsj+fHXDNvtY5kymE1KjeqLeESQDqWnaUnKjyfNZkn8lojVWXVVMfq5AEu3r9c1T3AS8sC5cWF/aLROFXA2Qz67QS3pVkbpqlHD+XuRXmlRjMcypm3SV3AkPNHFh19s4N5wWjsNCApdmgdMaZMtf1Ae+RXeMekefV5wrE3wiglkgzzH7dy4v+kUJsL3E73cf5U6Jorpe7hrTq7XJW9wgJj+AVqjVR09F3DP1DKlhtrYkFlbKXa51rC57HbrNKdBeFDyJdytqpyY2pgHMkWbDuRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrNPXHiINxKXq2P2U1fVYA2kn6/9UIN/IB6ZQ86fp+k=;
 b=YjBl7S8KGv/lESYfuy4w7VSQjCTF34k6XBPVweO2ZyxmRRbqjMj9r5+WxeZkHVDTComsOgrDj7mQS+y0x9uo2P3IHJZ8FAbK/VjPXoKmFT5zv/Hd68CHqfELmTb0aJJRKeX32nfhbTKHjJv0oHOYrHRup25z4ZI8VfL2EmvLjLCSC+od6fCJiKKbNt54TeMugCSP2WBUXfCCDwqRta47JEenBeCUZoXw6vC8PbAtdY5VURnTpdkAit+H6bVwz+1dKwjFhFE5JJJyup+Du4TMFa46e+OG+mMOKF5xvt3ICR/4+fVjram3U077Rc57B92niywfj7i9taGkR2/h0k1LgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrNPXHiINxKXq2P2U1fVYA2kn6/9UIN/IB6ZQ86fp+k=;
 b=fbKt/8MBQ7YNCGM1OXTh95WEtOi5Q8PSKdjY/6PFTQuk38GntDnEk2hioEfTHm6Myh5j8IXm2aySCeEA6RNJyGhA+KNqAAJ5lyyk+8cBpcsMIWK4ZrE3dnYZnVy3HEi0Hcy7lJP3VmjNlQ9LRvCxCGsAOFWvSb7LwWMKqaJsdUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 12:07:13 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 12:07:12 +0000
Message-ID: <284961d7-15c5-5c12-b3cf-5e9256ed2da3@amd.com>
Date: Wed, 23 Aug 2023 17:37:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 00/10] iommu/amd: SVA Support (Part 4) - SVA and IOPF
Content-Language: en-US
To: iommu@lists.linux.dev, joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, wei.huang2@amd.com, jsnitsel@redhat.com,
 jgg@ziepe.ca
References: <20230823120230.727935-1-vasant.hegde@amd.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230823120230.727935-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f6f796-55d5-4cf4-7924-08dba3d17be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yo2Z3o/9elYbhMeY2EyPadg+1l5LsaDfh7SPnjfTIlS1FrnrYhl6JvrHUmwqhEGbz71zC21CX0noh915L9lfPZMponF+qKqeF2i5mu34NFm6AkgF44BecOq7St1GK18uFeVZvWeTX0DHI68dLGEECqAOuxl74ROthbU+Y10HpD8GprT66jKjxQWsUh5HI34ktS0929xN/tGnPFzzUfT+FCQfkKlobwdzdn2bWVkzb5lGhFrBdO73+k3p2Wt4+jPdkZyf3L6h+qtBIizxqr/rDl1jxmYhjQMrKeq3aIXDS4lvFV/qZDO+CpaWoYSjQRKz+/H5VRsR5Qh5+GDFy8MAPcietr9dFUU4SZ9fClIXekkDR6tObPFP+jQfh/NVGs4j6W9DSVndYl2nN5M2191oyUVq0oMuea8/B2QzmpiBH5xSneTXICUFtFFZsCE0kyckIAES/DNrY60OUvZjwWkMemuOcYP74NQ9DOUsQkt4w4tQl8tYvl8DVMe5gttd6bmKF6S++aLMHvaL8aX4ew+YrcbaA0cYUceHxAXWTFBLUCPGQFrrBYXN9BaEhD0x8uNeQESpsD60g1a5UyyBTJns462PJhM+D5Sazl52AVTI31V6zjxF/3FvccmPr74Igr50lEQGG8WkwYJXz8fLaWmQxop8EYXKQOc/ybQbezJy4vAQrM5eYbQega/+a3PjmuIV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(1800799009)(186009)(451199024)(6666004)(53546011)(6506007)(6486002)(2616005)(6512007)(86362001)(66556008)(31696002)(4326008)(5660300002)(44832011)(2906002)(38100700002)(8676002)(8936002)(66946007)(36756003)(41300700001)(66476007)(316002)(966005)(478600001)(83380400001)(31686004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzhxZUFOd2VmMDFxTGZOU0hqSjdISUJZd0s2SFlVZ2NSY2lILzR4R09SL0dw?=
 =?utf-8?B?WEpzZ2ZQS2tFR0piTTBsQ2JiaXV1WmFLT2IxNWVQN1k0Q2RMNXl0NWZwWHBh?=
 =?utf-8?B?Vm1aT1YxVEE0VmFxdFpYMWhNbHRpYm1VNVcwTGVudGJlTjllamFIaVF1dW9U?=
 =?utf-8?B?VVhhNDR5SGtzVHlnTUVINUI2Q2VJYnNFUXh6MGRLRkthZ2lRTWx4d1RIa245?=
 =?utf-8?B?bHVUS2VxMStzaWNrZWlvbnZnelZxWXFoeFk3N29MWXVGNFhYdHEwa2tpdzJ4?=
 =?utf-8?B?NS9MQytKYkQvby82dHRCYWxpQXkzSzNFWm5YU01QaWdmaTBEbjQzUzhnVU9Y?=
 =?utf-8?B?OWFPdndGVTBxTEF3YTQvSkdMamMxblR4OXllU3JUZS9meXNYZmZBWDJNdk1H?=
 =?utf-8?B?OVdKNEpqNGZkK3dNb0NBYkwzQWVocDcwUlJXSWF3WitNK243NWFZNGVGZ2NL?=
 =?utf-8?B?QmxaZzR5bjZvd29oWW9iQVcrSTNRL2kyZDh4YjhhMEJ2OC8zVVkyVkg4Y2N1?=
 =?utf-8?B?Q1o5NXBDQkt6WDc2cTJQb1ZwdDkveUw0SnVZNUpEZVhyazN3UzduMjl1TTN0?=
 =?utf-8?B?d1E5QkFKYkVJd1BOanh0d2RvcmdpRmJKYW9LZ1l2SHo1MER4dFJaWkY4OUVD?=
 =?utf-8?B?Q0lteXl5alRXUSs5Y214TzJNSW9hNEVSYk5zb0haSVdSR1MwWm1qeE1EVEIz?=
 =?utf-8?B?VTRvK2hxWEpDazIrL2R4N2Z2QkVvUjFWWXBpS2pPNmVzWDBMNm10cGZLWjRY?=
 =?utf-8?B?Q21OWjJWNFNtck9HVmtqSzltS0EwSkJoclBic3pwRU1VaXU1UGN1d1ZZNlR6?=
 =?utf-8?B?VndaMDRKQ0xEQUQwbk01czRmVFhtR1BOZDV3Q3JpQjFHQ1p5dDMwYnZoRGh0?=
 =?utf-8?B?aU56Z3I3OEV4RmJCMkI2NVM4UjROa0R1WUw2UmwwazVkUXJObklQZkpNcTRC?=
 =?utf-8?B?SVVFR0w1RGorak11R2RvTXlFN05NY1h4cyt5dVBzRDBwTElER1dVYlF2bVJV?=
 =?utf-8?B?ckF1ejk4YjJySU53QWt4dmpMUGZ4TlVRTG14dVlrQmNxcXJHVWtyN1l3YW1Z?=
 =?utf-8?B?ZXd4Q2Y5S3FoVUY5T2NQR0VGRG02a1NkVWpHSkhTMUhzZVRzTEdtK2pwcHo4?=
 =?utf-8?B?M05Hd01rUnRVM2tETG5ydVNWUjBISGlMSFJyR1cwVlRBemVyVVRMMVJsUGlK?=
 =?utf-8?B?M1k2U3FmUysxVVNudE0rSXFrNEVaU2FYUXZzaWU0WjRxQlhvb3RtZEZNQWg3?=
 =?utf-8?B?OWtUbC90a2ZTM0FaRFJocjZ2RGtodmRjS1UzYWZGMzZoSzZkNm5sUjIxKzVO?=
 =?utf-8?B?RGlheStzSmExVXhxK1llMDBvQ1lLWVd3RXp5aUZjNG1qeWVkbFRiOUpvSkVa?=
 =?utf-8?B?U3E1VXZpdHQyV3JIWVRWTTZvbXlhcTlocGJ0bGc5K0tuaGd4Ym9KbmhKM1hL?=
 =?utf-8?B?QjNYR0tCQWtwWFY4eEJhWk1EdVJBZTI5TjJ4RlhEMmYxMnhHV3BLOExSbE5N?=
 =?utf-8?B?bU1kdWwxRmljZ3p6aG9qNXRpREk5RURtZjlSUjM0K3JiQkM3Y0I5N2pVcHRj?=
 =?utf-8?B?OXFRTmJVd1ZOMWZjcVhPOGRibVdaVWFVeVN2cTZSdGdZb0lCeUN3OGhqSlJB?=
 =?utf-8?B?clBkRm9US0F1YUxIODVsRDhCcFhtYnE2MmFJQ1Bqa3FQdUVzRFRUdEtRMUQy?=
 =?utf-8?B?N2lzdkYwSkJIZ0FPeVg0TE04dkoxRGhCd1R4U2QvU0VsMC9aSlN5OWYweTBr?=
 =?utf-8?B?MlRhT3ExbjhQalc2WElQZExILzlTc1lVYUNsbVJsdVcvK0NoRkNocGY0YjNo?=
 =?utf-8?B?cGVjSDIyeXh6VGhyeXlSM1dQclozWnZDOWhYbE43WEk5ZXVNMk5Pajd1dXdi?=
 =?utf-8?B?RUhqbWJwSVN5ZXRGRkdEQ2N5dHFvaTZaT2ViNGZHYldTMXJNTDRsZmRzamIy?=
 =?utf-8?B?eEhJUm9BUFI5MldIUEtNNjZwM1c0UERLdDRhU09ZajlmTXZtaGZqQk9yeHhw?=
 =?utf-8?B?eGdXTFNWdm04RG1Ia3ZkNHErQ3p1Y3F5VFdwUTlHS3JkZ2ZjOC9YWlU5L2tK?=
 =?utf-8?B?YVNReXc2V2pOVVhCYnZQdFhNUU1neWNQV2tYOFh6dzc1cE14OTgwcGhJYjlL?=
 =?utf-8?Q?ZgzDhG0SCuUBENrTfo+waGV24?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f6f796-55d5-4cf4-7924-08dba3d17be8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 12:07:12.8934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsJjniTOhn5q1E6rg+6LuEUQK0EF9EbBfpsk3zJCUSa96jwcil9kNVVTtE+Lc0l0hkFpOjWflRRCWneIzabtMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9062

Hi All,

Please ignore this series. Looks like I did mess up while generating patchset
and accidentally included some test patches! I will resend the series.

-Vasant

On 8/23/2023 5:32 PM, Vasant Hegde wrote:
> This is part 4 of the 4-part series to introduce Share Virtual Address
> (SVA) support for devices, which can support PCI ATS, PASID and PRI
> capabilities. These devices are referred to as SVA-capable devices in
> this series.
> 
> Patch series organization
> -------------------------
> 
> This series is organized as following:
> 
> * Patch 1 - 2:
>   Rename / add support to enable/disable features
> 
> * Patch 3 - 4:
>   Introduce SVA support
> 
> * Patch 5 - 10:
>   Add IOPF support
> 
> This patch series is based on top of SVA Part 3 [1].
>   [1] https://lore.kernel.org/linux-iommu/20230816174031.634453-1-vasant.hegde@amd.com/
> 
> This is also available at github :
>   https://github.com/AMDESE/linux/tree/iommu_sva_part4_v1_v6.5_rc1
> 
> 
> Thank you,
> Vasant / Suravee
> 
> 
> Suravee Suthikulpanit (5):
>   iommu/amd: Add support to enable/disable SVA feature
>   iommu/amd: Move PPR-related functions into ppr.c
>   iommu/amd: Define per-IOMMU iopf_queue
>   iommu/amd: Add support for page response
>   iommu/amd: Introduce logic to enable/disable IOPF
> 
> Vasant Hegde (2):
>   iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_sva_supported()
>   iommu/amd: Initial SVA support for AMD IOMMU
> 
> Wei Huang (3):
>   iommu/amd: Add support for enabling/disabling IOMMU features
>   iommu/amd: Add support for add/remove device for IOPF
>   iommu/amd: Add IO page fault notifier handler
> 
>  drivers/iommu/amd/Kconfig           |   1 +
>  drivers/iommu/amd/Makefile          |   2 +-
>  drivers/iommu/amd/amd_iommu.h       |  41 ++-
>  drivers/iommu/amd/amd_iommu_types.h |  22 ++
>  drivers/iommu/amd/init.c            |  72 ++----
>  drivers/iommu/amd/iommu.c           | 170 ++++++++-----
>  drivers/iommu/amd/ppr.c             | 377 ++++++++++++++++++++++++++++
>  drivers/iommu/amd/sva.c             | 328 ++++++++++++++++++++++++
>  8 files changed, 894 insertions(+), 119 deletions(-)
>  create mode 100644 drivers/iommu/amd/ppr.c
>  create mode 100644 drivers/iommu/amd/sva.c
> 
