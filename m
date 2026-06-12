Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D182731F99F
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272457; cv=fail; b=rmTq5sgVT6nQbOKH9dd4+O9YbAn+MN1s26y7hfVveo5ARNBpLj+ALCeatu601Mo/QHJLc+D3gjsMJ+IUCo0YtnJduce1bbrnDhnF+dNp85YZtJ8a+r6/nR071K79tUeWFd+4SSsWP29FWxIdw85yJbSKFjOsCElMTwhHMvIx1cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272457; c=relaxed/simple;
	bh=bxsPTlRNRL8YHB5nRQygl09NF6EPSW0um82l872ETL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SfwxjNAVlgVMdpfcHJ/PB1uanqZQcvUFT85bFbmHp23JLGeGy2U8xhq0wG1iOWmmOvevF63fGvdxZbxaZ9DdxVxMtP+bvVznk/I9taxpWNg/lGPIeHL/CNxDzx31tTbX/uvXI5Zw9kN8vCzVXEWLPVYn6+CdfiMvVyAMH5Ubc8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bv3FKU2I; arc=fail smtp.client-ip=52.101.62.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bv3FKU2I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSeqWuh/7Uz2HBCeLLpD4dRzohoazhAweaPmeu+Gj5yvYB8FYf+0zRXs+MevXyf6jH9XSKD9y64vMwneQsXsSRAn3cqIrTcAAKyWwuyFTNCTzsuDE12Vjvb5gG17EtmdB8WBc0r72Ujx4dgOE/GM53ltxsf3Vb40ncFaNK73H3/kz8T1IlY0YBUXdT9l3fDCB6IIkLaEjtP/u72RTrYH+ObhMiAGQeWMNbgmy71cqbNHBH761ejP2gtQ1kQSf2Moo8i4IrLl2WZrEXQ1qSjcnvvRX4olX8ywrUyg5Hwyl67bW4g94XG0OMlWh3uu+hOrlyxn+Kyt4iBDEaZCxta7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ooI0ZLMQfwpPg30tBu/shSQnlBXy8RYLN55tCU6tas=;
 b=Na/kqZSVqHN4at6kEJ77nTrwtfWQGeU4M4bxNS/jto8Xs3x+n4aB9V16ecfXokilK+CSKDDqP1OrMIaBdtshllYNZSW/x5OIJwNzOy0gT7Qn4w8J8Kq7+RVNPr9oyrPsEca9x/9mnPMAYeMKfRZ3Jf2yFMXaiaYZwk3lqkM+qeQomqwXpH3tUQxoCm/lcrq+/PwTJUni3G2uCLedzyubK3Mom1X+mPZDdbYy9c+P/TSNU8UvxBFZH4rWhZ9YMLDo/cE+PPM+laihb2/JxUilTD0S9NG3ZWNPutK1hyoOLV8lOIiwK6eJPjR/Hn8LWarpy1s1E2y3x3/WJoa0tz0Kkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ooI0ZLMQfwpPg30tBu/shSQnlBXy8RYLN55tCU6tas=;
 b=Bv3FKU2IL8zvVQ9mlXFwUlwK93d4aG3xPc8re+8MSCeqVHQfqS2C9CG/V7Ql/Yd3hfc1xU3Rb3sKLYnan4f4opcZtKTD3fV+6KGYAPilTtBPQNKxIticjdUx8u5eGeYrXkLi4NkaTXGQrKyxIYLk6TIzEY3wB8x4IAYbgee2qlGzrUwbfAMGTPqiaVTjwVejt4MrmmvtC3nd9nECawQMoOgPtjZ2OICorYxIp9Y7cA6/MhR7wqa4Q8AJRkcc1AEDpLmBbBANyyQ0rFPjvB9tXNt3xe7/v1ZQ+nbwHuScSRmCnkM5aJhMXg6ecs2Uv8KnodThC4Ht00OEQ5Y4K4Polw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Fri, 12 Jun
 2026 13:54:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 13:54:10 +0000
Date: Fri, 12 Jun 2026 10:54:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Shuah Khan <shuah@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Kees Cook <kees@kernel.org>,
	Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 4/4] iommu/arm-smmu-v3: Process vIOMMU invalidations
 in batches
Message-ID: <20260612135409.GI1962447@nvidia.com>
References: <cover.1780521606.git.nicolinc@nvidia.com>
 <00748c5cbea95a938d032269001a598203b06bbc.1780521606.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00748c5cbea95a938d032269001a598203b06bbc.1780521606.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:208:32e::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7ffce1-ca80-4bbb-ecee-08dec88a1465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|6133799003|11063799006|18002099003|4143699003|5023799004|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	Vkq1BZk/TnwKzZu6J5uryPblD7vkja740g00dhLZ9OfsPIFrpU62PSTPyaQroMWN35/F2BeQpeynFURS+Yt2qULRhkf/QOjWVGfrRt1vHqROkk2KWSJXr4PFn9eB9kO3HBYwVqwKAuwW3P4eo18F4lQU5ySUcXN2MDnPvkTbBHaex2wyxQXbQHAFetNC69To1ypBOHYx06L9wH2EZ7FQmdoUR0xYLiBq4sg+ydZn0ktQb9Ds0S2gaNTmxY/sZmOhu5JiEzHjVfRdtIPBO45gQBbrVZCr4UhEsFIlXNUAPn5HiN7UTSIqKGtcl5DReMmHZ/rJHuEBY/aF7X6DO5DU6nY57+UVsVI9JeCRhmtE0gaq2IvrVYTwO47efJQAz+YjJRC349lvt9TQTOpyrHa5WVwJmbkaQXFZ4cROPQOdZ/8zq6r3Ziylb4I+q4nwVex9f5rtFKwDgi9v4gYRwHtBoM8FmxrIcc8S+LdpxFrqG0QQxfaKp1twTlbDlbLaEhqOEG90+Q65RBzeBefb1hAdna+botgufbRRxqbK2oVixpQ3ORHaHD4+aTleEw3sUqbcPCpF96uxnPdEEp+wpYfGVbSrwFxw4c3+ZqNnJqianecm9BqMRxMDxbHDAHuQdclNP/FbvObn+pW4dQN9TZfUi9yuiFSNtCOMkufRjCUpjKuR6h4tbqyQaudk6iltRalR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(6133799003)(11063799006)(18002099003)(4143699003)(5023799004)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?usZeOdSU/4oQy5L6m0cAXaAPvh2rYKwrE2oFPjVuEG2iasCG2YJYTqO2kDwd?=
 =?us-ascii?Q?hgf8MMihf5tPxro3L+7OI6YajBp2ltv6JxO6GVqTmMpJBSvo5e3VAziQWkbu?=
 =?us-ascii?Q?dXhqSd7LQkrmNwS1JkpRSUQbvp5Tkwntund271fLBDu0KD04ZFlgdW8q0A4l?=
 =?us-ascii?Q?y3FOYtOQN4X/wE82XgfKASfe6QTvZOgJTg+lOExLsnHg1DOraOwAgbbid9Vh?=
 =?us-ascii?Q?vugrczg7lULeDXeY1mhhvUBNW+Yb1aJsBX+deOIpGe0oV5DfzR10UNuEOY23?=
 =?us-ascii?Q?ohrrCQIRyEQv8QA/Ep3COc5nuqbhIj+nHbd7V2bAItG3koeqDaH1nCO/vRbJ?=
 =?us-ascii?Q?+/isU47bnDzKGaofLJlqsA9yJNvPVScSTyteUz19RnMNpYMnKnygUYHhvmEH?=
 =?us-ascii?Q?/vqCgHvESTs7jy1boJin5BmqDCa5TECCH3+iAPjV+rjmYkKnGAPvTKm8IvwT?=
 =?us-ascii?Q?O6LOUkjC7QmubzYiVAui/AK2O9TLRwi7GkPPRZTC8prfCjaK+dUeNDCNPYpI?=
 =?us-ascii?Q?oSMqOGS4cbR19AYkqXaWHgA7aRKLJmKUVNSwKgYI05yXI8JNsNFd/mNbmDSj?=
 =?us-ascii?Q?tOEt+7nT7uXC9Vd33xiC6VyLOW6BznZDDPhGnlM4NSFLH4i5JBfwCSzC2dp5?=
 =?us-ascii?Q?BsBuSFXxdon3ytfeEH8o2AuQUthz0E2TYSJmjlS2obn/VGBT+RMGb3Srbg80?=
 =?us-ascii?Q?Y8MXutxsBhWPcWkOhqH9JrCTNY3voqFCM06OboFmITO1MPcPFK7fgUUovA6y?=
 =?us-ascii?Q?CpGT2nNODIfHDXdA8681iLp3St85fcfUqRr9DcZoWFWZvaP2ZR29ecPoWMrD?=
 =?us-ascii?Q?QArmmCNi93ZFAOBv+VUdWQwtLNB/R4jxwymywjLQP1mpkqYJ7DZlm0uvS0la?=
 =?us-ascii?Q?TYTiEpU9zkZtXSwaYEZKLO4AzjGW81Orj4p0btCo+J9Uo/H55eeAfnyGyCjW?=
 =?us-ascii?Q?bWvM/1Bv7VTShgp8VShXlwWsBukpz4DYK6YLp5CtsmQxWFYI+2+IfINIHG2y?=
 =?us-ascii?Q?l3qERXGvhOJ3/TNcMlHjUCgo7ec0/BHpPLIR3kgE3qIBMDsZlwcN1CD4X5f2?=
 =?us-ascii?Q?6zTVm5wU2Y10zRrKNjOSNA5AcvGv8Exy1cBaZfrVASvkVtpWZCJfFlJL7kB/?=
 =?us-ascii?Q?QZCQyjDCVV3R1XxeH5OZBtbp1tGpxdCDcszCu7b51p4dyywetcRYUHdJptpg?=
 =?us-ascii?Q?s195ZP20Ake4e2HrV7Dm2AsBKQryBj44l/EDF364GY3qicH5G6PpyC6cI4PZ?=
 =?us-ascii?Q?86ENU19Us48MouTgMwT2jBqeEUWxThXH0yrhzWd/dawniQyAAVQ3ydYQJK1R?=
 =?us-ascii?Q?5gYyyLDpKdvM49C8YzpweFNf6aF8w2TdRtHh54bEjLNG9hZPuHe4aMn2W844?=
 =?us-ascii?Q?e0UHFNF3+49be+E0bc4UnNbb7nON7g8oPJP4o3WUmBgGqyahNIzWeZeyNMw/?=
 =?us-ascii?Q?FBpGVIy2WWOKN0O6yc8T/llG5Mu9wyRg1cxV7yOQhodq/O3u6mg6tH0mVjb7?=
 =?us-ascii?Q?2Rk+PefrJ0ZWvk6ByHF5of+Fh1lmAZCWDrn8zzwPf8DbhWtaklC//5ljFoWd?=
 =?us-ascii?Q?URG9YABUmA9z+9dMmW3U9jX8RKqs4fPHlST49MluSZCX/llVu11Kgw7YW5Ud?=
 =?us-ascii?Q?eTSRkTjR8Z9AWypJWx+2pRSHMhXIVGVU0TRVudkQZjfsU1canOUsJEhL/HZL?=
 =?us-ascii?Q?fEVOagfq4fMacoY06Q252uCK/Jg8SywpWFnDxEdbCDq61Uqm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7ffce1-ca80-4bbb-ecee-08dec88a1465
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 13:54:10.8601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEDgI1YSg3BNOI/rzCe/wQqrm6yrv7mj8VLMaSl4oEMjG1OUl8jiQj9i+BaCoBVx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065

On Wed, Jun 03, 2026 at 02:26:56PM -0700, Nicolin Chen wrote:
> +int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
> +			       struct iommu_user_data_array *array)
> +{
> +	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
> +	u32 issued = 0;
> +	int ret = 0;
> +
> +	if (array->type != IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3) {
> +		array->entry_num = 0;
> +		return -EINVAL;
> +	}
> +
> +	while (issued != array->entry_num) {
> +		/* Process and issue the command(s) in batch */
> +		ret = arm_vsmmu_cache_invalidate_batch(vsmmu, array, &issued);
> +		if (ret)
> +			break;
> +	}
> +
> +	array->entry_num = issued;
>  	return ret;

I think every driver will have this same problem, how about lifting
this loop to the core code?

Also not sure I like the validation flow, I think it will be easier to
understand for everything if either num is 0 and nothing was done with
an error code

Or num is non zero and no error code.

Like it doesn't make sense to fail immediately if zero pad is nonzero
in iommu_copy_struct_from_full_user_array() but then to try to
partially continue if arm_vsmmu_convert_user_cmd() finds illegal data
in the very same buffer. Be consistent, validate the user buffer, if
it is not valid fail immeidately. Then execute a fully valid user buffer.

Jason
