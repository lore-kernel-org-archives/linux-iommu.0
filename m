Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328647A61
	for <iommu@lists.linux.dev>; Wed, 10 Jan 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FtlwFQkW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GX5ZgfNWeH3SqVxugDVHyfxzYj7WeppYN1mpuNx+WSEZ+G9NoxY5Qo2xSbgF0tl6dYXUM1K99SWYZRLMijXipDsjHuDViNDFueKNzsccXQ2KR5j9Tf/Jwshn4fvLaZO8XbF2VuNbfmfevisa39MVbwZywDZzk8zbI7LgqXRZA3vqtQ5x0H8N77tZUbe1Zb6uC/CwWUaUV0pbusSyHAMpZ2HPnbnE+25gc8pjagyJIORa30sK0SXxAEMdFDjKnLd8wx0dFO/WkT7E8inC7K+XyiHU1YLQgmdiX54mzkvHyRU+3vCNNzrc8ZQWoJIql4b+0hkHE857mhFbNEpHHToupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxwpyupW9Ub45OqKlC7RbZViXxMdWyBz4YMDeLHnjaI=;
 b=WhiLlHf8y7qfUEdwmbCTAbYdDhigSE8ySCM0ELAgprN08JSMFNzLBX2V9r5j7HxwheLEm3711KIlFoKVT8ZyW9b8RK3ljtHw/RAGJkV4ZcH8ggw2q3VHkvd1Mxj9WIhp3VAAQxUJpwwRURCBjoF3io6tgPp8qkF2z7CGiZuWEX3yEy1ingT0u5KxybGcUO6mcnjwOMgCzbe1g6kZHpsLyZTSdWsE8b/BFEED5KnoQdxUBWzX2iOXovGVfNoq6v0VmvhUk2xXF26l4+cqsGStPAEyTNu9OTe2a4rX9JS0RHVTfgwwznISlUEx/uwhEGB8RMSAbWvSG7M4j3KP+Simfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxwpyupW9Ub45OqKlC7RbZViXxMdWyBz4YMDeLHnjaI=;
 b=FtlwFQkWn4mLPjDKuuWaR8YppdFsAFsHqYDNop5mN4A4UnyzxTZ6SEaQdBIHoEKJ/9+s2NyWKSg6Kv76T/Ueu85CFc4pwmWhpECHrc/pp5ax3LlOZYVekI1fthUg3DyJcdrIisvPr1QF8HljzilU6rIJAI2KGj/NTiswmjOBXElfAWBJlH6oVdu06JiOp88dLMgqOYT8DvCjTdGlU/QJ04SVSSXaB4P4/yq68laUWfJyGvxyMUSe+bH1SPfF/uuYDpDYYm1EC+KdDe5SvjTB1D+HVA6GpYnxTrNw7PTvAXa1ImXu7NoSRHlU+8ojg3xvaJoA0AvUuD05k4ucNlY7pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 13:10:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 13:10:33 +0000
Date: Wed, 10 Jan 2024 09:10:32 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com,
	will@kernel.org, nicolinc@nvidia.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Make STE programming independent of
 the callers
Message-ID: <20240110131032.GA535328@nvidia.com>
References: <20240103175043.GS50406@nvidia.com>
 <20240106083617.1173871-1-mshavit@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106083617.1173871-1-mshavit@google.com>
X-ClientProxiedBy: BLAPR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:208:335::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b22483-e50d-4ce3-52c4-08dc11dd8766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3CTp4SkbWvzvQMXNrl9SQiOYmu5kkxLhivqrcTZGhBgZJ+EChXxnNwzWtGuG9QboIQcuRloVZiK7IHiXxaj3h9egOhXqYRO2Fwm2CEAGakPxW0s83CDtcusGJNq81Vex8cNNZQC+6xxkI2pm5kDA8l45g3m1wyvTNRERKr5aeX3raiL0gDClQcSg32yYudEt2ftFpdwuMR9yvziEGbJXH+bhh0GWh6/0GwwwtY811CH+UEbWi2+SIcKDKzJu1KOX/wQ/8z1zUrgnnVC/Kuq2vTpcPw0Zs0+MMGrwKelN+jonbmdAjjpLt5zk+Bkv40GmRpAvFs0bkJqWHdFcT/6IphTeQeS3uNNpukC/BFIg8Mn9VFXiVLnVgbyubOVLguQWWrB+x3fxED4U++9MNOWNEPsjA2Yeyg0Pt4LyiHi1dvblY9mKA4XLjhD0iP7UHLJKWkaOSMl4JjtcKF7kmnNbmgiax5Om30JanmxsocribQbQ+nafE+AnjuJdwI+gwCbncxRBQELgkn3E/O9y3+4Xi23wwCwFeRV1AdGJ4tdkmJJolcxLb7YThXq+xdxlGagZyO5PulxchKsld+DHcap1NYhj6Y97aLL3mJBA7SZe55JoHqc9zEE2LjKERAMh4FxA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6506007)(2616005)(478600001)(6486002)(1076003)(26005)(6512007)(83380400001)(107886003)(41300700001)(66476007)(5660300002)(8676002)(66556008)(4326008)(66946007)(6916009)(8936002)(316002)(86362001)(2906002)(36756003)(38100700002)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DVE85MfSl2U3k6PmN6ANFJ18+VrOjaaKhHQb1XK/lM0Cotiuq8MNxntD0Cua?=
 =?us-ascii?Q?ExIDnjZGMeFNe2K+77NQ75H7EZmLOHfAWP1zpQG3mdkzTYJ2evjKzkXmqUDF?=
 =?us-ascii?Q?CSCbJQ8RO63Z5NRubo70Cxawvmav6hNhd7H173Rn6h4HikO/6xwmFSsIGh9o?=
 =?us-ascii?Q?uqDfbNUhZvtPDNMhmE7tzOQx2lypRUlHDdarvUTPTx11zq19b5lwGcb8pexb?=
 =?us-ascii?Q?sgynoKu8jcCCk+jav0oR0HPEFI/caefoKFyY2k/rTuYLh/JX2ZB6RN6l0Ibu?=
 =?us-ascii?Q?AViTm6apNyWy7Hz/PYQJHzZH384pWq0i1bH4jLMUGR4XJCJ0Qe+blOHjH2YF?=
 =?us-ascii?Q?iWxny5dPndlsVXXfcG/KBvfOGosq18rwlwC5eGbJO8KlZhY91wc5O9JkRAja?=
 =?us-ascii?Q?dVSziG3Ty1p0rLJVRNyZe+LGfoPC8RhEC8/pwbTYYdLaftct6VqEGCVHn+7V?=
 =?us-ascii?Q?4fkAghGznzm/eMO8gOPryKqHXEXNeY7HOtJTmcvJ5uQZ8wUzGgB2uKXnRq83?=
 =?us-ascii?Q?OL+Y+YW0PUqh1jt1F3PtDfUFdln6SeiHBEgWG+cGdQSs3bv4cuixEGpQAsd/?=
 =?us-ascii?Q?yAXYc2XRz3IAu0JAT67tqL/+k4bkQq+oYgfay7xMcitvfOEkuqlgSWryOph/?=
 =?us-ascii?Q?s//b8u+LvHfemoE5DIiUf9hnMqQgW8XDvIqhaHdfZkD4C4pNZsBJOxo5n8Ss?=
 =?us-ascii?Q?yV6iGpSthyuN28stWdIqoykACXus1ER/vw7UlIgLx0I31ks+aC9Ck1YG8HMe?=
 =?us-ascii?Q?MdtW1Levpl2ThKlQK+DYGJV4gVq1y/hRdkU1vyJXn1+vHpVvzZZJBSFE7WH4?=
 =?us-ascii?Q?VFv4yS7jBEIg+7tKEQQWK/cwboPRMWqTE/6ONs67EaA47Az5Dz1e5jsDezu1?=
 =?us-ascii?Q?cm3nTroU8rRvSBnG1HnH8BERftexogB21lujWK55927XZFutj1sSDtrLgjFt?=
 =?us-ascii?Q?4c2ONFkvSncJi2Y5Sf5t52r00EZMyutCbreSVAOTQ48ETSH2ObkS+ffU/g5k?=
 =?us-ascii?Q?ZGwqzpw9L6O5twEhBj48yEdXmRdtfl+XKNaFVs04nr82/r6uGiK/9caeXdSj?=
 =?us-ascii?Q?VR2EKp1KgaMSznka8TGGAt8t80aCF19uwr3QrHQsa1gBNk9cwzYk6FiQnYAn?=
 =?us-ascii?Q?H6TK9FO/SRQm2uYDpce1XOanuRwX/BSArIKOF80WVmZw3zPKONak+9eebM8y?=
 =?us-ascii?Q?OTAQ7vplRHNdZ6iMUZafAYdozvujPmt9Rh8PP6b+F+WSJazyorq9Cn7TILCT?=
 =?us-ascii?Q?+DmICAu3eWOClf+x7Fvutir6iUEYzLNy3FhsIG9UcldMc5ZYTJjgIF0piNQz?=
 =?us-ascii?Q?MFUt7UQxOJJIx7A+ylH5JhzCIs4LlifV1ek05RhZbAxSjoXMT1SYsEfPrCGk?=
 =?us-ascii?Q?vgV+4W3hSbinFFgbEhnOjM27nu+nf05yTU6jgqkcOI/RjdGdwWyT+GEDkxAu?=
 =?us-ascii?Q?0cglwZrEu0M2gAfJlt3OS9vNDyrLboqKOCUgeHxroSPBJF6A9x/3uFl+sXdO?=
 =?us-ascii?Q?BArxmCMTSagvPacjJn/zvgfslJJU0/Cdeq8hHg4eKmQAnAr0HUWKJHqI7eZb?=
 =?us-ascii?Q?8QGomlCIPCtfL9oWMMCjdcIENYzQlOiqTRUyTT+o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b22483-e50d-4ce3-52c4-08dc11dd8766
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:10:33.8667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfP24wpyRFjlnzntjxc7zIh7mHveYAgaN4oY1WaR4a1yxLexBbBd6qsW958sqAAI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867

On Sat, Jan 06, 2024 at 04:36:14PM +0800, Michael Shavit wrote:
> +/*
> + * Update the STE/CD to the target configuration. The transition from the current
> + * entry to the target entry takes place over multiple steps that attempts to make
> + * the transition hitless if possible. This function takes care not to create a
> + * situation where the HW can perceive a corrupted entry. HW is only required to
> + * have a 64 bit atomicity with stores from the CPU, while entries are many 64
> + * bit values big.
> + *
> + * The algorithm works by evolving the entry toward the target in a series of
> + * steps. Each step synchronizes with the HW so that the HW can not see an entry
> + * torn across two steps. During each step the HW can observe a torn entry that
> + * has any combination of the step's old/new 64 bit words. The algorithm
> + * objective is for the HW behavior to always be one of current behavior, V=0,
> + * or new behavior.
> + *
> + * In the most general case we can make any update in three steps:
> + *  - Disrupting the entry (V=0)
> + *  - Fill now unused bits, all bits except V
> + *  - Make valid (V=1), single 64 bit store
> + *
> + * However this disrupts the HW while it is happening. There are several
> + * interesting cases where a STE/CD can be updated without disturbing the HW
> + * because only a small number of bits are changing (S1DSS, CONFIG, etc) or
> + * because the used bits don't intersect. We can detect this by calculating how
> + * many 64 bit values need update after adjusting the unused bits and skip the
> + * V=0 process. This relies on the IGNORED behavior described in the
> + * specification
> + */

I edited this a bit more:


/*
 * Update the STE/CD to the target configuration. The transition from the
 * current entry to the target entry takes place over multiple steps that
 * attempts to make the transition hitless if possible. This function takes care
 * not to create a situation where the HW can perceive a corrupted entry. HW is
 * only required to have a 64 bit atomicity with stores from the CPU, while
 * entries are many 64 bit values big.
 *
 * The difference between the current value and the target value is analyzed to
 * determine which of three updates are required - disruptive, hitless or no
 * change.
 *
 * In the most general disruptive case we can make any update in three steps:
 *  - Disrupting the entry (V=0)
 *  - Fill now unused qwords, execpt qword 0 which contains V
 *  - Make qword 0 have the final value and valid (V=1) with a single 64
 *    bit store
 *
 * However this disrupts the HW while it is happening. There are several
 * interesting cases where a STE/CD can be updated without disturbing the HW
 * because only a small number of bits are changing (S1DSS, CONFIG, etc) or
 * because the used bits don't intersect. We can detect this by calculating how
 * many 64 bit values need update after adjusting the unused bits and skip the
 * V=0 process. This relies on the IGNORED behavior described in the
 * specification.
 */

> +void arm_smmu_write_entry(const struct arm_smmu_entry_writer_ops *ops,
> +			  __le64 *entry, const __le64 *target)
> +{
> +	__le64 unused_update[NUM_ENTRY_QWORDS];
> +	u8 used_qword_diff;
> +	unsigned int critical_qword_index;
> +
> +	used_qword_diff = compute_qword_diff(ops, entry, target, unused_update);
> +	if (hweight8(used_qword_diff) > 1) {
> +		/*
> +		 * At least two qwords need their used bits to be changed. This
> +		 * requires a breaking update, zero the V bit, write all qwords
> +		 * but 0, then set qword 0
> +		 */
> +		unused_update[0] = entry[0] & (~ops->v_bit);
> +		entry_set(ops, entry, unused_update, 0, 1);
> +		entry_set(ops, entry, target, 1, ops->num_entry_qwords - 1);
> +		entry_set(ops, entry, target, 0, 1);
> +	} else if (hweight8(used_qword_diff) == 1) {
> +		/*
> +		 * Only one qword needs its used bits to be changed. This is a
> +		 * hitless update, update all bits the current STE is ignoring
> +		 * to their new values, then update a single qword to change the
> +		 * STE and finally 0 out any bits that are now unused in the
> +		 * target configuration.
> +		 */
> +		critical_qword_index = ffs(used_qword_diff) - 1;
> +		/*
> +		 * Skip writing unused bits in the critical qword since we'll be
> +		 * writing it in the next step anyways. This can save a sync
> +		 * when the only change is in that qword.
> +		 */
> +		unused_update[critical_qword_index] = entry[critical_qword_index];

Oh that is a neat improvement!

> +		entry_set(ops, entry, unused_update, 0, ops->num_entry_qwords);
> +		entry_set(ops, entry, target, critical_qword_index, 1);
> +		entry_set(ops, entry, target, 0, ops->num_entry_qwords);
> +	} else {
> +		/*
> +		 * If everything is working properly this shouldn't do anything
> +		 * as unused bits should always be 0 and thus can't change.
> +		 */
> +		WARN_ON_ONCE(entry_set(ops, entry, target, 0,
> +				       ops->num_entry_qwords));
> +	}
> +}
> +
> +#undef NUM_ENTRY_QWORDS

It is fine the keep the constant, it is reasonably named.

> +struct arm_smmu_ste_writer {
> +	struct arm_smmu_entry_writer_ops ops;
> +	struct arm_smmu_device *smmu;
> +	u32 sid;
> +};

I think the security focused people will not be totally happy with writable
function pointers..

So I changed it into:

struct arm_smmu_entry_writer_ops;
struct arm_smmu_entry_writer {
	const struct arm_smmu_entry_writer_ops *ops;
	struct arm_smmu_master *master;
};

struct arm_smmu_entry_writer_ops {
	unsigned int num_entry_qwords;
	__le64 v_bit;
	void (*get_used)(struct arm_smmu_entry_writer *writer, const __le64 *entry,
			 __le64 *used);
	void (*sync)(struct arm_smmu_entry_writer *writer);
};

(both ste and cd can use the master)

Jason
