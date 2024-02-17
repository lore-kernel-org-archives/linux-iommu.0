Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D08F7AE4B
	for <iommu@lists.linux.dev>; Sat, 17 Feb 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708176296; cv=fail; b=G4F5uBkeRUnN7RWsKCAdGKshsy0lWgfg9y2UqP1V2dAZhfijkjh534NpNBkCk7LWc7MYnxz1Ap9UXcPgYbMzvpcWNA2RHKvZQRK5W3gcH9aTs+ILLP7qpuelzwbDbK+CuhDTi408/XvZpTB1act1K0vOa2NjDBJGESJPAeRc+KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708176296; c=relaxed/simple;
	bh=Fi8zfjGo5kZhHfiTSOzSPgyu44BQbFeMSZDjXbYfwys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VX5F5xXn2z2L8q2BZsaobZ1sYMQlOUyCpLzb/IpA/b6egWyLjZ/Fm5D3NdMHYNYF+xPQyqFNWq/2lrugSxeGFaPfJBB/gk9Cw/YBaN+WIrDZFSqD/xHAzsFzJMQIKKfb4/Wfy8BD5URoJImOSz3z6nlQVzLWA5o2gQRIaYYTjac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h1JOwI4G; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h1JOwI4G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ned31AX/jlEJ050v5ZTDRBoloqU1NYMzB3AZIb0rRBpz5rUg2WaFRJ6ibi19KDzVGP+FfupfBHbTHMiJSojnAR2BAxLYrvrAv7ZiEKgaV6UJkhXW/k0kt7WafJ5cDJE+On5XcI56lg8YvMfVTq5AEyMZQSYfEUNX6F979o6qDFwGC9YjxovF5A4j6stVm8YXM/y7YSCFWjFmf12aWvdiKUOSjU2U2qRzAyRszsJf2/L5O/Kd+jQh0Y6+3XNBISmG/8PqXBBPkypmOs3iPaiPOfTqscRogokYEN6ZIfP3QuMFQZ+DMGx5huxOjz3HcqgqoWvRfCHf++4P6hVr9gm36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0Y6J1FN9ihvHUfQc3JwMajkzGO4Cbtqrlyh3WGDW3I=;
 b=czCYSlDvUUoPn/67jTZpI2Egs/WyNFOQfiWzv5TymX/B9MqJm1M79KNAsg0Ak1cESsdDjFpNQkNFxNr/baNhf9WlLvUVcMmh1IAJdzrrWeGX7hJpfE4osJY9vZS+eey46td1QY5RetLjLuo6oQRL7lj6SolSVWWdqPDYUSAqqyN9CqdpfH+Tcb27UzEKabZiRe7kX2OLIcg9Tt7SH+9MsIXNIehipIjaK+5Sr3MEe1CPYE6syKSlF0ER/RuxGpQouREmM4pfGpcU1w5xjgFtBtjRgIJf/fCK0m4GCUJ4e5Dddhi/6abPi07mfwDrhbAIDZ9z8obkG7xT3wd8Gg3A6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0Y6J1FN9ihvHUfQc3JwMajkzGO4Cbtqrlyh3WGDW3I=;
 b=h1JOwI4GMlHatfhY9joSY9MsZAMdLlVLQ+Bj/n54QBDf3vAwZgsc/lMpuEtgd3y9LjP+oB0hvpjAKA06l3606QzSgIgnFPlS5KRzD2i3redBrFHLMRgRhXbFb887bcweFec+ynpT0hFDvTFABXcwEdDorRmnNmpRwgV6dDwLGOmyUyg2+ERsmuUrwjqEk2ycyJHA0SLUjFk49wonAyjqyJ7HLhFQT7bjLQGKTzgFVMJRVEpNJz4ZSVa7ByJeNDgnDLc9H4f7ETLRfAHlfKgmBuw8dIpkw45kJXUWUelSQmmN68kiGqp+gDWIW68FwyHb6cWps65igCUSjAXRkhl/Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Sat, 17 Feb
 2024 13:24:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.012; Sat, 17 Feb 2024
 13:24:49 +0000
Date: Sat, 17 Feb 2024 09:24:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Do not use GFP_KERNEL under as
 spinlock
Message-ID: <20240217132446.GJ13330@nvidia.com>
References: <0-v2-7988c2682634+261-smmu_cd_atomic_jgg@nvidia.com>
 <20240216120512.GA1841@willie-the-truck>
 <20240216123606.GA13330@nvidia.com>
 <CAKHBV27eBnCrnXeaoqONWksh89tfX1b0=yvLfTkxviU_wKG_mw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV27eBnCrnXeaoqONWksh89tfX1b0=yvLfTkxviU_wKG_mw@mail.gmail.com>
X-ClientProxiedBy: BLAPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:32b::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 091b0f5d-5658-498e-3dda-08dc2fbbcfe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l7xTKHv+8qDU6sa6hP9rS6pVkY8BVmXR4fzLoDum/44cuu2eD6RWAy02Vl1h08bVlYk2wpzKy4QuA6taTJ5XXQtRaQtaZqTDD65Ra+CUzI3OskMNBD14iVNwBjali8cemUQ8ICN5u9djnNaMFEh9wwB7iq84M3TQ6hhnYtMZRoaPpv2Sy/Rqo875z4WSO0TMuiNk88FxPiKNVm8opTRFdiy5r0T1CcARdQSs+Q0scImwTvQk0MYDL4tm8kzJ+BBtr4E3zySnuDDiRhxbKnRKy+xP/31u6FKxwHaxZdmwZI1yxQ+y/8d9y1PRbyPoAsr7z0vzYYeA2myWfJgzbqX6skh8A3hvy98V7vWeWvvBtOLl0qlPuS+o1wZQEThsq9u3K61vmy++axdstYV2G2uIqdzh45kzniaW33aQz7ZuLkS5sewO+E1jMkYU8wmOB17yCGl5du0VwMAIBOla6tRt1RxHjEb01YcEff1VHSGa9nMx2xihDco7nbQzJT36JIKtCvEblwnt5TFn/YoVNfKM0plFokN1n2IFFYmJJm3BxGhzePYoXsHszlP4X9SCuMPc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(54906003)(6916009)(316002)(41300700001)(2906002)(4744005)(8676002)(66946007)(38100700002)(5660300002)(66556008)(8936002)(86362001)(26005)(4326008)(2616005)(478600001)(6486002)(36756003)(33656002)(6512007)(6666004)(6506007)(1076003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JBFwzxjGRyYknoUHrNu4DpYQk2kvQaRv8PIaOmfiGBjy4l88Jb5Rdjc3Vl4e?=
 =?us-ascii?Q?jvJ+9aAaZaV6rvTyEraIJTAYoN8F109McCROaOV4og7YzbfDrZm9iEPUinHF?=
 =?us-ascii?Q?Y+eqnma8HF8c5qv6NxCu1IWsJPkXnZX222UQ0vWDMO5K/7Ya5phIWU0X2Nie?=
 =?us-ascii?Q?THnTxColzkN9cvuk9WgqGQ8w2FahcFUXPWtFWev83DB9yEjws309/bR0b+Yc?=
 =?us-ascii?Q?TZRQHHlluWmoFJMDWS6LyE9tHuoZE826RayW474cOOEcgSS0G9rWf+Agnjjf?=
 =?us-ascii?Q?WngaJXk4vcsH11XC0QoG+AYNjOSnmggSFSHUSxNZQJMzTAeAAt9Ax0DmhC1C?=
 =?us-ascii?Q?W0/8H9sNsBxlZBm1CrmVA/S/NLAiWVmPb3uPd1UqW5GtC+ufmbePUYqHhMFw?=
 =?us-ascii?Q?C77bdUwzVvBVkW4Yl2GfKbWaGp3Wrkhv7nZuhqPM5b2iX2OKsX0SWGF1Bmwl?=
 =?us-ascii?Q?aekvfTzdArFpGVkY0ZLTPmx6fkiMIqWcsr+dFBkrXfQHboezCSn9gJnzxZ69?=
 =?us-ascii?Q?py07881N5uaZYxZ8Qb2lcO07qUZSAvZHx6lRskolaD09RGhmRzpLGsjGz+Sa?=
 =?us-ascii?Q?5aBOD5x9gJsMl6Xub8E9o8hDVGBZ7F+5FCZycdSSP6lLAeRRCFoJyDGpvzbn?=
 =?us-ascii?Q?pSJ0D9AMhw2cu8Gi79/zkCgmfpfevJT77c7nsWEHcpxwWwb/XmpT8ylaomAq?=
 =?us-ascii?Q?Ji3RCx1K2Rr/pSqFnG6+DPp/N9Vi/lx/0HNAvKkS/6vzxKhGX54vXAEoTXft?=
 =?us-ascii?Q?oRC56wL6C5DmD0BCmpwTaHKgoCbfeBiHp9pictCmWFdCvBcV+c5TyIrduW4J?=
 =?us-ascii?Q?O5K9LIp5qG7qkLWRsvArJbWAf+BBLG+SHUgjL7OhgTvlRrb2Cgu/UrMwoXey?=
 =?us-ascii?Q?pHFgZbvhx4IRi3pebMpHKh7RkCWZZf4gicFW8Kzg5NYAN6MayqJm44J2uGpx?=
 =?us-ascii?Q?uY+Oxb0UapEjOV7W6N438R/TbdK6FhoWh4jIxlIvmfbOAccUPuyi23svc8TL?=
 =?us-ascii?Q?PeRgS2+gvpdXyInIe1m+Vf/DYSXSB/RsKgXxTEawE5Vyn4qqLYslGl7CuEhi?=
 =?us-ascii?Q?7deR6SVH6nVNJZ2EzRdyxqK0gfkiBic1xYNQGxRo83cG3SHTcBAVz1v0CL4v?=
 =?us-ascii?Q?W/mI4WmeLn7zkoDJIlgo1W9kEmmAh7EPbBxsFHr6iUMzbqejLlj6wIXTjpe8?=
 =?us-ascii?Q?9oD8OtM5TcUO4nx1YI4+30sfL6xw+7IiHNfkDQhLqns7l3htazeGMCFw9CQV?=
 =?us-ascii?Q?agJx/Hv4ypwxGri79S2dD/uoO0USTz2OLQikLJ6FcKNEHsm7k5g2ei8hT/La?=
 =?us-ascii?Q?3Jl8RMGoxsBheGcEyjGi8vAqIT0ozcEQJR9FA/lj08YHTh6cCBcj/jqzIAnX?=
 =?us-ascii?Q?kaL4MYOnf7WyN4kW3YzXv1i3nobXXa7ITPQBTkLF+s+csim5YR1JFDtBAkCe?=
 =?us-ascii?Q?ilQKdf/tpWSU5lu6GZNE6tiDvM1vk9AUtiGbOtenslIVJB3PbtyooFXGUwDP?=
 =?us-ascii?Q?FhLbvMW4UvIDedU4pH8SvDkvjVCiICSF95ywuCECQTNaTeTBpFZgO9VRBrbQ?=
 =?us-ascii?Q?Gr4cS50d/AjSSMoAz2k8S4LDRqTDQ+tZNPLAOa4K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091b0f5d-5658-498e-3dda-08dc2fbbcfe2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 13:24:47.4597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcVtuACRoe+ctRxskQtug23AF66g94ymodQU41VPoOckFUKRRTJZ86Nl0tglvitI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427

On Sat, Feb 17, 2024 at 08:25:36PM +0800, Michael Shavit wrote:

> Calling arm_smmu_write_ctx_desc requires the CD which we get from the
> mmu_notifiers list...which makes it a bit more complicated than
> that.

@@ -404,9 +384,15 @@ static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
                goto err_free_bond;
        }
 
+       ret = arm_smmu_write_ctx_desc(master, pasid, bond->smmu_mn->cd);
+       if (ret)
+               goto err_put_notifier;
+


> > Also Michael should look at it (I recall we talked about this once)
> > and Nicolin should test it.
> 
> Just to make sure I follow why we're pursuing this instead of the v1
> rc patch: in the non-PCI multidevice group scenario, the first call to
> set_dev_pasid would only have pre-allocated for the current master but
> arm_smmu_mmu_notifier_get would then still write
> arm_smmu_write_ctx_desc to other masters?

Yes, though noting I have no idea if non-PCI exist but it does make
the code clearer and removes even the possibility of a non-atomic
allocation

Jason
