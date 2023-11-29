Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4931DFCE
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CH+q7lrO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTaYdtlyxasGO+N2TL9OMmqLu3Gwx9iMt02uE3qHDSpvTSh3KVHhxMOSXGLFsr0XllLFWhjPmcmvCxuSUoalVnqpZZSsuJ1b0jMgUjx2vYn/taE54HaxfYW4926ulokxxSCQGALCyJW3BIg8fQLWWxhhOtbONvqQCvU6eooqVrroEpXxtry3au6w7JBDhuy9OU1fOcANUNb7+DWepjgOVzmfLi4AmMavzLftHY69cFfb5Ik5Eu8JSgTKcLvONBcPKVe6o6VjACQMYb0Ju+jTlFei8qsMSwxg8gp5LBSG2W0diIyZyU62wNi3M8IyXm0L8wMRnCjDvlTnh7wOdqIbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okCUAJEQF+t23OHgKaI+SDjq74mJIcQM9kgfkhP1I1g=;
 b=VfViFKIWbhfYS+Vp/dqBY0Q44itv13he9E5dFZTctSscNtSpUkQpckjWBBn2bPt0Z9TpUe2SMSCwGG8ywQu7jIf+DqFqKIyuK/na201uM4Swc4YTFVDpG2yyqK4Hi+5yusRQmnhGDkC2tFHMgibIcpWWsIiOfSiO3MxvgfVOn1VQv1nDNfncBNdslbl+N0dD4PHELhOXfQDT8OPJnlywx/xHvSulxVCuRhL7KNpOiFNTv7qC5xQLUgMToTQ/SletIvjpoUHD/ArZvGcvVZ1S4bSxTuIXXzX9pPziFt19MdAonC/Q9TeaI7tMpjaiBupH7bd+6Tz2bB//5H8C/a65eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okCUAJEQF+t23OHgKaI+SDjq74mJIcQM9kgfkhP1I1g=;
 b=CH+q7lrOk4B5FOVcve81tbFH7sJ3lKRf/rmY8a1xo0KHpqIj9FTzNItAw72ZCnR1DEgXMGrXMWLqG0eyKQlPLcV6Bbw9ixqTjD9lbdmSTNcP5U5lq/BZiixuaJGZBAP8T4LYKF831/J3lm4aDSfEA/WKxEjzvaksJhWUEQSdCV+bDAVr0yBzEHKi6wQqZByKhT6DXRe/pXR2eK/k+gfuPptE3i/rlS7fQmjc/bJxwlUmD2/3jwvfT1jzO/Gw0WbU5wvL7e5UcG8yCSJHsCwzyCR+SRlbKhAtSTdqMaCY/MNjkCF3xUypLmnGKIBMRhWYHSFvnURUVLN3fOu3cY6tHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Wed, 29 Nov
 2023 19:48:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 19:48:52 +0000
Date: Wed, 29 Nov 2023 15:48:50 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	kevin.tian@intel.com, nicolinc@nvidia.com, mshavit@google.com,
	eric.auger@redhat.com, joao.m.martins@oracle.com,
	jiangkunkun@huawei.com, zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 5/5] iommu/arm-smmu-v3: Enforce dirty tracking in domain
 attach/alloc
Message-ID: <20231129194850.GD436702@nvidia.com>
References: <20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com>
 <20231128094940.1344-6-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128094940.1344-6-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: DM6PR01CA0012.prod.exchangelabs.com (2603:10b6:5:296::17)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea14cae-201a-45ad-3c23-08dbf1143689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cij3BcBfWbmrDQWlBeNjOKno9nh0NqPmEDeyVO8UwvTklergR8JN97TZ4xPVORY/QMFmJg3auqQSFhoXI7SQCD6FFpB8gj9DpoSaUlmlAg9VZn8j2xVkFaQ7Zm7royQcFhsRY6PIwlmN0vwmj33hD4vXxkYN69sDFB9mZpCsOYXi9TA6ULBzvi0Pq4FawtPorvZXyKCy1+Sow8m3xUUU20FeRqsYUrTBC/TqTvJidG2t+k69UN6ClQZKuALVu55evsL1cQVQN6gXxuixzljNhZfRB3OQHoPoJ4IE7mPomitFb70Zj2dTU/1j5ZF0GzUwJ16r/hpUjTWmbT6AZjBC4qMNErWldrK7azx6pINXI2yuXap1SwY7mLwrjTfH6MtVeVtmS78bu83BvnccyIHgGheBBW092WCVOzycXtbb7geiBBsimBKlpqMkSZHcRd9yV57z4nc2rHofvyxw5DWKPGJQPc0HOjprwGRlJyTUyK/WoQusGN2k7VxUpxngejTahRWXJhJSccYy0kYYArYb6Z9RugumjWsfmB5QEyuyDhMhST+wLSN4lqsxJH2cf+hOG2LPs57WFZ9cjC/rJOSHNuVsBGPRBziIENjzecO2lH0+qjBygtG14B9fSy3jQvd7j3LgWF+dqX4ZdalmxhubwhKmi+v/XolGrZBlDC65tnxQJdwBdnbhLOhPqp9ffk1d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(478600001)(5660300002)(7416002)(4326008)(8676002)(6486002)(8936002)(66556008)(38100700002)(66946007)(2906002)(66476007)(86362001)(202311291699003)(316002)(1076003)(26005)(33656002)(41300700001)(2616005)(6916009)(6506007)(36756003)(6512007)(27376004)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Om3a/831TL4EUy2tiz4Q/CzJNkKeN/CbIyL4H569anl9MuLoEEjDuZC+vpDm?=
 =?us-ascii?Q?NJprfyZJxkhf0J8bos5xSyLFDHQrPtSN/u6kpnvXSCdDsVBGV25WIO3TPTAT?=
 =?us-ascii?Q?UAK/i/f8T0MrvcYBOprbmYJDwRiPlCdqYL27P12bwcYoAmIt4nya4C3u+MSG?=
 =?us-ascii?Q?vf2ScWOmgtiZ1C3rwsuCm4gCxWUX11gh+2rDpsR4knrmHb/peiSgndh9Wffd?=
 =?us-ascii?Q?59+zv4Aux9pml+0w9XDMuppjYjjsP5DK6qlLY1QisXJidqhNhKB7U8hJsj39?=
 =?us-ascii?Q?WT21n9b0KNN0t2efitEpXYg5keVa6joZe7hFKtDOCtGP5aTmEVsbuM62HQSC?=
 =?us-ascii?Q?X1C7qg9YPOBf303vt4CNG1idSFkVtmKGDTGuRRInw5Sn0ZE8HebZdENAYH7r?=
 =?us-ascii?Q?g4rqqsQuxl4se9a0QcrfFA8Sq1coLaLTV8BXbUgleNxw2UQ9CAFDNG83NIlr?=
 =?us-ascii?Q?W+vFWOkUjbVzbam9MOzGY3vjSQUfAYmu4ydb8XLXREUCMKDrQYSdP+l4i7iQ?=
 =?us-ascii?Q?wuG5i6qlPqJfSnTSyKidIgbNo8r31T6MpuZjs1y9EavhCGLl46N6yGuHGCXv?=
 =?us-ascii?Q?YAwJTUGByaPNFeSeP6OQsaGgY4Dyo2nfVDHX09Jz28yeSPR4MN73kG258/Fw?=
 =?us-ascii?Q?ALC6L+8Ck8qmxrML6Mo2vJXodar2eOmZ4OUz8iUZy+1AYpVhr8pI//dssFNW?=
 =?us-ascii?Q?q6JkUCCulPmvOqhVX2iLghwoNK2BJudM+b7ERgrBft958Wr2CBk5/Jj1YlEf?=
 =?us-ascii?Q?U165Z9hHgHyZpFJNYrK/nmGygDKCzqF8GW3aAvkGZiAXQlufxaL3In2fCMu9?=
 =?us-ascii?Q?0oNVTlc9BMtY+TJmdeXCtS3/lbQRDZgVXuGnTlgof+kIk6xXh8pGvwqeCCS4?=
 =?us-ascii?Q?5rxKpADCm0xZYhT2NjDajf4GDOB2nadcH9D2oMI2B/KvDvhrIQPd2lxQTAHT?=
 =?us-ascii?Q?bVhuQU+ma+95N8Sqq0wyTp5EGqGOoeksqJV2V6P4HSIOfChf9UJTed1O8sRv?=
 =?us-ascii?Q?w32hIuAIfc/CaSV642imUt8uGBiF0Z+A+iDntGEAsWz0mVA+fBkpAU9pwNMV?=
 =?us-ascii?Q?rSgf2A/nIsxKdi55V+g8qnvr9xH4+R2qgnOxRZrGvUJw9EYcbn+Q0IbPFIMC?=
 =?us-ascii?Q?XBm8UCv2lMl8zUI6lOqegQdhtAKKyEb48ji0JMw8SVbfcG5Flfxi52Zw1P99?=
 =?us-ascii?Q?56BnKeRh4DSRdhK2o3jSXwaVnPJMoE5aq1sfNhAhRvPzGkYqsRBbwgewXBDO?=
 =?us-ascii?Q?L9Mi9Li2ldoefIuExn0P+MmqgmPGD74BMN6F1beYGUfmjziE07QJviUBPGv5?=
 =?us-ascii?Q?suP+G6vyIZrwipllC23Dye+t2+clzKm6P1qkOrFTt7DBN3+1ZNvVn5cS4+P6?=
 =?us-ascii?Q?8/qD/0Lw0geI2/VOjgIgVr0/Qms4deYCGSLcRKg9F1r2skFZC9xUidwpVRVi?=
 =?us-ascii?Q?83lz+jWj56ZDURyty+V1xwvV5VpWvsqKNvAOyIYZf8WmSfU+pS13Kkxnu2Gi?=
 =?us-ascii?Q?eK6XNbAkUDjHvwZUgALE+qHc9X0EEoPHJXu5xUAh0oyQoO5cGgHFJfPIkuBV?=
 =?us-ascii?Q?QIXCLUtUmdSYPlN4HcbO+B4/o0OYvZ2BAAKzX9eT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea14cae-201a-45ad-3c23-08dbf1143689
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 19:48:52.0947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkYYy+wFQoO1RusAljsjkvnscdxL5EFD4OoMppfyfymByUpb9xRU8J5GfE58GRVu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803

On Tue, Nov 28, 2023 at 09:49:40AM +0000, Shameer Kolothum wrote:
> @@ -2701,6 +2703,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	master = dev_iommu_priv_get(dev);
>  	smmu = master->smmu;
>  
> +	if (domain->dirty_ops && !arm_smmu_dbm_capable(smmu))
> +		return -EINVAL;
> +

This is not necessary, a domain can be attached to a single smmu and
finalize was run on that smmu already. So dirty ops should only be set
if this is a S1 domain finalized ona smmu that was dbm capable.

Otherwise none of this makes any sense.

> @@ -3104,6 +3115,9 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  
>  	smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
>  	smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
> +	if (enforce_dirty)
> +		smmu_domain->domain.dirty_ops = &arm_smmu_dirty_ops;

Ah, this seems in the wrong place, perhaps that is the confusion
everywhere?

If the finalize actually enables dirty tracking in the pgtbl_ops then
it should set the diryty_ops, they should not be set in alloc_user.

Specifically, a S2 domain should never have dirty_ops set.

IOW if domain.dirty_ops != NULL then pgtbl_ops != NULL && pgtbl_ops->read_and_clear_dirty

Thus no need to have all the other prints/etc then.

So I'd move this into finalize.

> @@ -4152,11 +4166,13 @@ static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
>  
>  	if (smmu->dev->of_node)
>  		smmu->features |= features;
> -	else if (features != fw_features)
> +	else if (features != fw_features) {
>  		/* ACPI IORT sets the HTTU bits */
>  		dev_warn(smmu->dev,
> -			 "IDR0.HTTU overridden by FW configuration (0x%x)\n",
> +			 "IDR0.HTTU not overridden by FW configuration (0x%x)\n",
>  			 fw_features);
> +		smmu->features |= features;
> +	}
>  }

Is this hunk misplaced?

Jason
