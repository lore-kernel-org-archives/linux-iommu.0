Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEDD388
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 00:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VZbzGUwu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+C5eznAx7w6N0r9pHcFD9wdtIGhlM1UeLMXUdrVLSfteVP734Y3jHEaocAES+j5t3KyDXEffzX45salntZM1jqM7/Pk8I+Ut7sbWkBF1TgFQRdC/GHMgYUWArn3lLal1qmgw9PeyQodXt/hxqu9vhrTtSorGU0D8+ydtXXPuP4Sw7BW/SOCnpalzLgCOnkT0vM+nsodUo5ZmohQnQNFFQBF3Oeb92/B9wzvvHTUcIW8qbFVv4qpbpEgvo44XndMB4AwJMQVI8m0o9/qSE0BnzuXBbdt/V2HvFd58cyuCDJnKXECbpBvT3aHds9sQS+C8EM82Pf/WStHR5SfUd8z/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdW3eM//RWIk66a3BRXogARmcUvehF83O3MXiqbA4pI=;
 b=NgM4J4ReGuUWwdG4dPEXP2JpOdYAgLojJuU5HHZIQ5oYOZbfCzfEAgIhgEM6axjAkrX+/Z6kU/zA/HXWUHmL/dV1JkdRmtSsJY75NpV9xhwV8uqjqVPbZQz3Z+lS1efHsadj1nIK4RHONOepzeVaVCiFUwXrkpSB8OudiLx3cCmU949aVWECqX6zz7Xe/wgJAuzytv9tN5LFtxNZOqzM8gGwXTQZniuNZGdZY78+W5lkcOUUc3dPPZAuStQt89yBoGh7sVHSh+FPcWv9gRqkAP+8ndDmLeGWeggskitPPh0tKQLLnCeEnTt5X7JqPGxXE4fEk0bzBhgGwR/f3ZqE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdW3eM//RWIk66a3BRXogARmcUvehF83O3MXiqbA4pI=;
 b=VZbzGUwurmudWn5lwtYrarLalpM1DCog2dTvKYMrPCf/HvZHuVzGnQBAJQ//N1oZaxPOP8Pe6C2nicWUR0xlpos6k1Joerjy9Eqjc6PK9Q4BJ0fyKVc7B5TjeQzLXZ1qfcRTQlROXwyc5uGgSPhiS52t2x4Z4JRe+QgxMu/D4rYQHO2NdA8HYlHv3sW4FNXStVJ46kl7j/qEhGEcrb/2WxoHGKnBCLw93JSzY4kKO/+/itCcxw5jQ7RHTHCZo3dUaSCOuVMXKPCw+VadbhDHL1hV+DekNzwlfGA7gsNv2+jT0QV+P2bdVjq3wM2jL5c1rQJAgDDRWWdSyt6W+PU5qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Thu, 30 Nov
 2023 00:49:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 00:49:07 +0000
Date: Wed, 29 Nov 2023 20:49:05 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 0/7] Convert SMMU to domain_alloc_paging()
Message-ID: <20231130004905.GA1395649@nvidia.com>
References: <0-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
X-ClientProxiedBy: SN4PR0501CA0044.namprd05.prod.outlook.com
 (2603:10b6:803:41::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f1827c3-557a-43cf-6f2a-08dbf13e2860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5gDmPA5c89a7IYJBUZ2/6vu8XAjpLoZKHzwhfPmgOqxEDJxHPZhoH+cRqKToFTNUoeOI4q7JhHyZveX3b9EdPwzpgzwc7wsy9w1q4nsBv8hrJ9T2JKYWDiqX7lSbeGKkg5adTIhrjrblRB+f373aQQcxJzGoFC4NGJ2fU3Ezemz4oQztA54Jcjal3lObY6c6K9pHRDHcl6wrFDshhK6z/+1Lwjx+rcbl5MsJKp9YzwZF2DhNab3fLiW+JteqmFY0wMSCtMqQh9gFQpGKm5dEQm7mLqw4CWJwkzezIrtZ3mu9l7XhfaUTGeervuNXigkptPhfUzRDKRa17VSmPSq3enb6GO5HWcN2ueqxHCyHcdQBrkMUFA/XVJJNXyBVjjJAYKW0Baelaa3lyrHSEe1t1jpnMci1CB/fnwUCKQc91n4ckwqsrObwoHITRcfzvGqUaBsVqFb/3i/c+Ct5fufTar9oeuE7ymc0GTZGzkTSTl0NOnslKnpg0LDOFyianHKpfrmBzN5wv/OoGlBMXoZbArIAv06goLJfeYfi7qk+HNaRTg6nEY3sW+8rAYqFEofh6gA4hgPqoJTIF0vkZhjjuqMykxZpYatcPAvSbPlQ+bRIoWvhAy0rjxjPcwHNrEzeHOFgrIQJX9rbOKmFUZSF4ENE8WS11OqPJsiB/OjzhTk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(4326008)(7416002)(41300700001)(2906002)(2616005)(8676002)(8936002)(966005)(1076003)(54906003)(66946007)(316002)(26005)(66476007)(110136005)(5660300002)(6512007)(6506007)(83380400001)(66556008)(86362001)(38100700002)(33656002)(6486002)(202311291699003)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bTCUoORC8ZYcUvgNdPu58qYvSaegXOaNmcPSKtAMpLtiUpvQML8wa+rgTSBX?=
 =?us-ascii?Q?8F6oDe0Qi9pCtyAWTqMP9tF+kISPf28Id758hIoU403pL/PTAJIVHD1LJV1t?=
 =?us-ascii?Q?C8q9xiDLtSvACuqcRpUw73rdG+/M7VOqa912BDJ9WNs62+8uXao+SAGGy8TM?=
 =?us-ascii?Q?ruN8IHjrqVM9H9abKryiDcTR0bI4FvXmnKUXVARIYUc3KWohL9cS/c9QCyTE?=
 =?us-ascii?Q?yCPKDWyWpKnO2y4EWxuTmlrJhx/ay+Y1vKB5vKhYfvXqxJ+FbQPZQqonbXyV?=
 =?us-ascii?Q?1arE1rr/F7f24SvLvT/PsBPKlXvgIlnyc+huMvQ00KDtbbsDcVpWHfwyMo5u?=
 =?us-ascii?Q?LEzGeMO3Z3E8W8u6nYlnFTNe3oSG/x3q0zT5bJ62pIa52E3A2AomQfHEuoIX?=
 =?us-ascii?Q?Dim+QQP8Qh3CX22MI85IbZI0lxH0WD3ivYqpYabV9YV05PZO7xFZmI0rLO1r?=
 =?us-ascii?Q?W1TNv4rdybeS2pIAP7ydsuRY2na9vY951bQYAHPhbi3KjPiwYn9oZYJPMUcy?=
 =?us-ascii?Q?zrfbAYIhr8X2vkXUvHJmht65CgMCBZNW7q1tbBFV+z51i1gsWSfoYKYglXFn?=
 =?us-ascii?Q?9M3TmR+SGMWPrcBuF4hA8fbcSnjuGm5nBxzvr7TP00l8DoAvgNZ9h+Exj/89?=
 =?us-ascii?Q?ykAMnBOYMK1RBmG5zFAKHY6asl62Om/2dqv+KAQOd20e/SML+oR+/UwEk3qx?=
 =?us-ascii?Q?Y6FfdrWvo5oACm36v//dm3j0quO9Q2LGUTgz3pluvnxiXvQEKdkrtIERXRO0?=
 =?us-ascii?Q?PUFzjZeFcbpy0ePfzdccTd3ztdxSdz5a3q6lDLzoS179qcSFGWogJ61XaANk?=
 =?us-ascii?Q?XlDUkIS67cSplFuwoM7VwM+P9KJniWuOtmAd8NQnrCHHFFtIY4fzOOwC5Ucr?=
 =?us-ascii?Q?UXwYIcwpftgtusJV4m3eGlevxI41L7jl07C9M3XfiGt5JLMzAQ/T6Lon2iMX?=
 =?us-ascii?Q?36bDdOgXbucJnjVA7pO0Ik0d8u5nDhyxi511wYD6F03c3p3D4KC9qHQLlGnu?=
 =?us-ascii?Q?2HG9kFEzyxTh3P2QwPEjYX6Km0Zk9wObCKLBx9DVcxTPFTmTbTQxz2eGkRzo?=
 =?us-ascii?Q?wMb6hqiJEW9H1mzs8Ak3lyuk1Fq/Mu+RcxAljiLRbV/cAKXAWRUnHdOYkHYg?=
 =?us-ascii?Q?97GQnDOqPUBz9XskEvVzipRvUByvWAwqbE5462MOMqlqhWQnrpcj5gd+lGzx?=
 =?us-ascii?Q?neGobekZah+tpQbjtpFLVLq7jiGQzqdZ1P75g6pKdyDfYIfL8UPuNPOlQT4/?=
 =?us-ascii?Q?lBaSFsFoJOggT095DKjWBBc1CXK5+idnuzdG6b7OchZndvotVreP1q660coW?=
 =?us-ascii?Q?0ZFN3NHdpfRm7eBC4c4w+mriC7ei2eQ9RFAYadNfMm16WeGsfAdinFPAfshv?=
 =?us-ascii?Q?WR9psESFSHnIsImrl40Y+B/pCT9Mkekv30WeHit5C4niKgS40/9QsWv1tDD8?=
 =?us-ascii?Q?Z3q62bx7HqDNCBSYwVlXF+IdkFgLne/7eU0OTXxyF7SYoCBGRoxNzZYlfdA7?=
 =?us-ascii?Q?Yn59Wc/B5bLb+Ay4XQKPDVPl08ymzAGKU+SSApNlWf4UtjAP9fyP/OIGclKx?=
 =?us-ascii?Q?f0TE+YxTJxmdP1SW3r4FW9nlezfbXCwiz3R7j0xN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1827c3-557a-43cf-6f2a-08dbf13e2860
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 00:49:07.1829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vYlW5d1uE9xV8cnfdOpUxIjScppEHawypeHxY2S2bhkxqzDXCwLlLuIGrLrOXEu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972

On Thu, Oct 05, 2023 at 03:28:11PM -0300, Jason Gunthorpe wrote:
> Add the global statics for IDENTITY and BLOCKED to the SMMU driver and
> change to use domain_alloc_paging(). This allows SMMU to finalize the
> domain during allocation.
> 
> This is a bit more urgent as I noticed while looking at Nicolin's patches
> that the disable_bypass module parameter no longer works. The system will
> boot fine but the domains will be set to IDENTITY now. To fix this the
> core code must request BLOCKED domains when using ARM DMA ops with this
> module option set.
> 
> This series fixes SMMU, which seems like the more important one of the
> two. SMMUv3 needs a similar repair, but it is more complex to get the two
> global static domains into the SMMUv3 driver. As SMMUv3 is primarily an
> ARM64 driver this is less important since the normal DMA API flow already
> substantially establishes blocking domains via empty IOMMU_DOMAIN_DMA
> attachments. Regardless I have addressed SMMUv3 seperately.
> 
> This relies on the first few patches of the dart conversion series:
> 
> https://lore.kernel.org/r/0-v2-bff223cf6409+282-dart_paging_jgg@nvidia.com
> 
> To enable the BLOCKED global static.
> 
> Jason Gunthorpe (7):
>   iommu/arm-smmu: Reorganize arm_smmu_domain_add_master()
>   iommu/arm-smmu: Convert to a global static identity domain
>   iommu/arm-smmu: Implement IOMMU_DOMAIN_BLOCKED
>   iommu/arm-smmu: Pass arm_smmu_domain to arm_smmu_init_domain_context()
>   iommu/arm-smmu: Convert to domain_alloc_paging()
>   iommu: Compute dev_iommu->require_direct sooner
>   iommu: Restore SMMU "disable_bypass"

This is still pending, it doesn't need rebasing on v6.7

The DART patches were merges so all the dependencies are in v6.7 now.

Jason
