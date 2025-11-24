Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029C2F6922
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764026033; cv=fail; b=kPfhUkFqySnhWCiBYk9ovlIYDW0Qo/zMJ12U8I+tdeFv9m65PV27S8lQe3jFW50hNaRevr/qoO/O9nX52sa+iDxdXHJV5AVll/+SgcZgoLu+cxuMcbayCBD7gxQcm+Q0JeUH2w3/KQjNhwug8IBcarm6+rJYfFdvdDk7cb5HMUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764026033; c=relaxed/simple;
	bh=9Pj3SLFdeLhDK4HS7cswNGO7C5z1uWXnjzI8NoXBqLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ji/+uLR1zOYOmAvLzjUtX+g9BiyWuGeY7P3G9jCYMn42EUlGSHuFMy2P+IkPufPPZuUEUipvN/ykhXbipNtk4T8jMnarRxfDkr9DZB20YnKLdL1TzCvgS6OcBNQadX/u8NW5KQRh1VILTSUehPFhmyQi8B2bx+rzOdACsFpn7Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JBW/BR0v; arc=fail smtp.client-ip=52.101.53.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JBW/BR0v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTDX8OqgWJWTpwk2YnF8AdHBngjbcnDpGJO3bIldag5pgiBhK0kM4HV3lt8yqM4q0LiToxuFQoKOJp0jiL7CkR426ZCV4BtiArr757PGCeLYhaB+rDhZvtr9J12hwMW3bdMhwJ3MrD2zKfxca4VZbScu9B8kikzTdl7eZp/+bM8vCuzmBr4q9Fa2wy1B137XhNnl0Nkrh/TdhPGG4NYMLTZIYIaezQUtyqgClZvVhSx1sxEwcUuwHrStB2P+sSlWB85mhcknp+NZJQdEoV+Fnh6alNh2KCfAIuqfHp7gC6HiR//eV6wmPaQpsxajWA/tt7zd9e45ZZtOveAgw9HSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XucPl9Q/0sWV+EfaRUkj6uI9DsH37qvizUxVoZgzlTA=;
 b=RNG10jHlVHUzOdqkMXIQOShKx3nEGfRqKjJX7EaTZbvhJ6/TsRyT87yh+VR2XvV7ql3Km12ZSpFtubaTqULvNKntDwWpjw+RUm2HRxXWFMhJliDvTH9akFqc0sYwO/BhP92zaVbOdSNyrdJt41Jm5CvQftqGXYuGmMEIRmj+5xa3Ch1eEmWfhUBl7HrEJG9LDmhYGFnR43acngpxgbX7kNrZe8bfhiQqbAdhivz3DwDh5erRwV1TfYorbTUujWlXUVkePz9cYxErXnpF6rxiUxx9SI1NQ/R/TtLfmXZyx5A0a34JxEwPTghlv76fr9cKin30ZEKKq70ho07Rzdt0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XucPl9Q/0sWV+EfaRUkj6uI9DsH37qvizUxVoZgzlTA=;
 b=JBW/BR0vEFk/i2W6dIrT9Za+KDDgcQmafQslXkUeOkRvA23F3o922crr4hRYKw4nrPBwFLcdGrZEFPJ1Y1pLupoCWqij6fWmU3DsFCFI0k1umz6okpm9Ub/EJsZyoo2RYFXfsQv83nfPURfKxEtK43zYKYR+r+D9OO9Rpqmpq6bEtORLqiApYhLOWEQc4LQDPk98QU1/a7nwKzUTwvcSwb/cTrUrGefYPK67WUddYQW0bFE5mNmHpWCbY0NQ6/vpRHH/R1i8VTNjzn8WKCfCuJCyRvWrnzXpCOVomlwZKpj+nToecjKUYtQrys5OHM4oew+8om5knsx1lqmswREKqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 23:13:47 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Mon, 24 Nov 2025
 23:13:42 +0000
Date: Mon, 24 Nov 2025 19:13:41 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs
 when attaching masters
Message-ID: <20251124231341.GO153257@nvidia.com>
References: <cover.1762588839.git.nicolinc@nvidia.com>
 <ebf35fa1b2025be736475950503f0dc0612371f4.1762588839.git.nicolinc@nvidia.com>
 <aSTRdltJpMeFLDN8@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSTRdltJpMeFLDN8@willie-the-truck>
X-ClientProxiedBy: MN0P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::25) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f72cf2-d310-4898-0bf9-08de2baf1c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+SsLvYwtEtBPRWL+ai+THOdPa8daJmg8dQI/T02ZcdqMh5ENztFRn1c1q97W?=
 =?us-ascii?Q?C9oEYVEFj4TpDCe5hB5HZW8Y2EiJmpm12QQqJoyrucuFx189bzXIdzwgRwsi?=
 =?us-ascii?Q?hQ5S8lLVPR6ChdsHM+e7cZhedxqVd92N+v4UryH+Z3w9yZrX9aOvCFFAjyKs?=
 =?us-ascii?Q?IOS1mHARX/DyIypv+BwUj+AWCkYRC7oiOWHCeyYkO2nr4hX+kEGA0HuflltI?=
 =?us-ascii?Q?G5xpRrjKe3vKWKg15gIoJw/nZsJ3qDZSt5/o4N+K84GILcARcxf3A3/yE6C+?=
 =?us-ascii?Q?Y0xislqMpvX8OKMb9ODMoVWiUwbaxsg7CrxjshiyBVHQKThbatEcdw29kXmv?=
 =?us-ascii?Q?dlzYRktCe0vFtihXxFGvA2yqqfn77UoiEelMxYhZN2PtTfL7OZhzhOSiATYl?=
 =?us-ascii?Q?Txwu6yM3NwPgXTAB/NYhSJcq5uGwc1vEKXEayuh7bSn+rauu1jT2/fvMjYlv?=
 =?us-ascii?Q?nKSZiGQW5nIcK2KQkGuWruARwB9/pld0L8VkJL3/3bxsKoGC+nMM8euLz0Zc?=
 =?us-ascii?Q?d5uKosuGQ3GWZE3XePoMnHShtjE2Hwbik5TEvYBpGw6RGN+OpPqJimiMDoKL?=
 =?us-ascii?Q?wEloj3ofUtkYnsxTthWWyRAWVoEEmK3AIdhdW5pDBr4GuoD1E5rDU2l9V1HF?=
 =?us-ascii?Q?/K9nrivgzXK1mkxn2X812L7DfdBqTaOpTpQHhzCNQJ5E1HEpT1+qs44W+kFH?=
 =?us-ascii?Q?mhmMV5/fNQvxpWr9zEdn4KhwLBP+ZY/CCWOf5l6fU9ngIqOHj+nU/Igog2up?=
 =?us-ascii?Q?8RQkUk7OPBeDOWTYkci5qHVPpV1IftLvvS55Eok74jEcM8xhFdcEK//iEjNK?=
 =?us-ascii?Q?bCiqbb4FIPycsF+NXmiGTrKffARjW67bsOLLTUmYmJzkPT96GOdx/pRZRwD6?=
 =?us-ascii?Q?eZxJY6+AGi0uM12Ha0tFgIFQ3Li9Qqh6wawyCW/QS1wnRVkbAt1llCKxs14r?=
 =?us-ascii?Q?Rzm3BZM5fz5Z2fQ2xNwXA1GZNYcCWxEtfxS5Rdki6byRdM40OP3JeVmNh1zm?=
 =?us-ascii?Q?yDdTB2U5bQclGirlSx6MOrBxM9cdXquWl+005+5axLIembJSc446Q03am+Cp?=
 =?us-ascii?Q?/XIqiBNMcoZZIafOco7jhoWER02iRyiUY9IrvEZ8fwLy5jQXFnb5E1/1MkoK?=
 =?us-ascii?Q?ryVhFNxTQOEPsVlywmeGlZTaMwkJmM7qeZyItNuX7qnTtdEEAvBpzlBNZZEj?=
 =?us-ascii?Q?RZHPPlcHoDY913JIS5Q9+Fu+UouV8WSYNVFvCuzMyq2CzSvrYwL6JIfmttHp?=
 =?us-ascii?Q?08+DHNFr+/wvHEf2IaTKE9EWWT5lSb3ghUaknP1AV7oijvCRbLisCrppeX+L?=
 =?us-ascii?Q?toOKjWsetAtUwTeKL5Hhvb2uRcx4GY6hBBAHdWyL32OV2FN4wYlLWlQhO+9O?=
 =?us-ascii?Q?Zk7f9QcMpHKnMqz7MwvMUmyvkm0ClXw6GAEKpTY8Xb8iQBPA5XnKhD4BaScO?=
 =?us-ascii?Q?6oefZ+hC/x/8CaN2EKZKEfhRh88AhiTU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Knyww53EbQwkTPhICErk+ARGjjxpCK/ZC5LbHCNa0QUsxPP9SYZGZDUkVs/M?=
 =?us-ascii?Q?A9pBaW/rNfgiKeWWKI/HRz/XkExJSeuNFwQ/wegIeN5V+s/3drhBMEjLU9bK?=
 =?us-ascii?Q?RdwcUDl4LNDEZyrYweEgyUzLvlIxUqDCJieuUEqXv8sNPup9ELpNKnPwjsCt?=
 =?us-ascii?Q?MnfP0u0jSq6KLSyZ4Vy3Jr/VsJzOflgRw4WD7wphTppr2ilYuGVUCL67MyuT?=
 =?us-ascii?Q?VvBxELQ39JrH8Cv4OqXo+0v8d18RQcMowLymx0+1JYf8zABo6c8qaPU8VyoO?=
 =?us-ascii?Q?voa1YwjOvpiAftcoFg3oDWpZ9ERADw5btp5mAYdOcsP+A+qFpciX/PHYV6eA?=
 =?us-ascii?Q?Ytddd2MNTqu9rTpQcQIOTnz9kLl/lSY+Bj0jVYlTBqORJJYpD+Do1bvfC8R/?=
 =?us-ascii?Q?o0NCCJBq+LBfh3IiBpRkaTSgJoFCsS6DjmUKzJG7tuJIDpqVBo/5BEbGLQOP?=
 =?us-ascii?Q?pbBmZhfzeo8pmYAr9lg4IHH4MYPSeBjG+6Szz9Stm1H1SHY/OqybO6nL1+TI?=
 =?us-ascii?Q?bwpoB8CKDPe/2YONfwDU2kGHUitOuGqgxswYnXgz8oNz56WwGBnw7uPLGjJ9?=
 =?us-ascii?Q?nbzORP3I2oAXRAje10UJgkHuzpWECiizcxm7JiE7xKVdDwHrMWqBbIJXo9m0?=
 =?us-ascii?Q?gtbhAHQc89r9mI+UlNQKy3POPNzn4wz46XoK9KYFGh5S5EGy8dKN9SXtejyL?=
 =?us-ascii?Q?oYWONt4DchwsKeflD1nwV6Ly/lzqp5KWd+UJxArFM9yDL4IutChdDie7lYVn?=
 =?us-ascii?Q?DxYISZrX6xw/nQQwZkhDn0AE8ociouEKGOwHVTT+x8fWW9ApGtCcP8XXZyRv?=
 =?us-ascii?Q?+W+qTkvy/89j7GhHToZbjlAj8KE4w+ja3S+l3uxm9E3Pn78UEOLFoZU/xgcl?=
 =?us-ascii?Q?u3qfumq0HyW6Fu+7NbRoCcZ5Oy0YNlCqZQjUQ4EXHzoGfcLHwYiNmf8eLEW9?=
 =?us-ascii?Q?6hdFysm1fjTEPt3zt2LFNcGnZbxkovKFnyT2KYxOAZ454PT3iTzXEcEIY6iX?=
 =?us-ascii?Q?SUJ9OptK9uyLmd8UrXJd8dhMKoxN980KP/q34lDFx2e1iDOqlu1Cg/OLfRqF?=
 =?us-ascii?Q?fo15pAa82fg1nGRa8uyyxm5CTZRR7dF8ddXGahmCaFKUQw1rZ7qjHAtLykEN?=
 =?us-ascii?Q?7SMYpiwHBGk/RNSSMnMvKJPptKV8fY2vaWM+r6UlQhwpkWjSeX8mXN3SHs6E?=
 =?us-ascii?Q?ujNeGjTGK6D2eO2GLjDtQbcILBoJDcj6ZJxgrcDATDsAINORCRwKPqDKA0rX?=
 =?us-ascii?Q?pkZQv/YNta3sVzw9WCIkNpynPDE4k5sRZZ1dk8Gbt1HqKjsFiROuIRwbaqmW?=
 =?us-ascii?Q?c1hQGyn/mP1zl9UslgW+kItO2MpSLTYqsmNih62tEhm+gFU3Y+q3Ay7oY+y7?=
 =?us-ascii?Q?GyyojV7EObgc+rGET/Cmr9j/ttED5+i1RBBBA1CBuR96N0mT6gu8cRBKW8Oc?=
 =?us-ascii?Q?usM3AV1FmexvFGZLXNtbSfTg3pEbXzLL6s3lLVDaIn4Kvc2zBsPnGqyHCmk3?=
 =?us-ascii?Q?IhkSvaBdaSLvQ6/gEqW+uIqkQLuvqPYbjGI2pX7nhZW155K44hfxvfeliOyb?=
 =?us-ascii?Q?1SZmzmAUMlDAd6s5ypY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f72cf2-d310-4898-0bf9-08de2baf1c19
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 23:13:42.6312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 967GYtlSyMVfhuqXB3YLguzcP59BybLGc9Ukr0EB2Fi0zDOxrAfhv15cmQrLovr1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883

On Mon, Nov 24, 2025 at 09:43:18PM +0000, Will Deacon wrote:
> > +	switch (smmu_domain->stage) {
> > +	case ARM_SMMU_DOMAIN_SVA:
> > +	case ARM_SMMU_DOMAIN_S1:
> > +		*cur = (struct arm_smmu_inv){
> > +			.smmu = master->smmu,
> > +			.type = INV_TYPE_S1_ASID,
> > +			.id = smmu_domain->cd.asid,
> > +			.size_opcode = e2h ? CMDQ_OP_TLBI_EL2_VA :
> > +					     CMDQ_OP_TLBI_NH_VA,
> > +			.nsize_opcode = e2h ? CMDQ_OP_TLBI_EL2_ASID :
> > +					      CMDQ_OP_TLBI_NH_ASID
> > +		};
> > +		break;
> > +	case ARM_SMMU_DOMAIN_S2:
> > +		*cur = (struct arm_smmu_inv){
> > +			.smmu = master->smmu,
> > +			.type = INV_TYPE_S2_VMID,
> > +			.id = smmu_domain->s2_cfg.vmid,
> > +			.size_opcode = CMDQ_OP_TLBI_S2_IPA,
> > +			.nsize_opcode = CMDQ_OP_TLBI_S12_VMALL,
> > +		};
> > +		break;
> 
> Having a helper to add an invalidation command would make this a little
> more compact and you could also check against the size of the array.

Yeah but it makes all the parameters positional instead of nicely
named..

> > +/* Must be installed before arm_smmu_install_ste_for_dev() */
> > +static void
> > +arm_smmu_install_new_domain_invs(struct arm_smmu_attach_state *state)
> > +{
> > +	struct arm_smmu_inv_state *invst = &state->new_domain_invst;
> > +
> > +	if (!invst->invs_ptr)
> > +		return;
> > +
> > +	rcu_assign_pointer(*invst->invs_ptr, invst->new_invs);
> > +	/*
> > +	 * We are committed to updating the STE. Ensure the invalidation array
> > +	 * is visable to concurrent map/unmap threads, and acquire any racying
> > +	 * IOPTE updates.
> > +	 */
> > +	smp_mb();
> 
> Sorry, but the comment hasn't really helped me here. We're ordering the
> publishing of the invalidation array above before ... what?

"concurrent map/unmap threads" means other threads calling
arm_smmu_iotlb_sync().. I think the matching comment describing this
and introducing the pair'd smp_mb() is in a later patch.

Either the HW observes the latest page table and needs no invalidation
or arm_smmu_iotlb_sync observes the invalidation list and issues
invalidation.

The smb_mb() is intended to make one of the two statements true prior
to storing the STE.

Nicolin maybe this barrier line should be moved to be added in the
patch that add's the pair'd barrier and description?

Jason
