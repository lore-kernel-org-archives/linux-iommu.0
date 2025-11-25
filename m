Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017FA221F24
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087645; cv=fail; b=JFM9CGN7htT7l4qD85vWBDMrb9RjRGZ8OwJOTSb7XDT6rNYyj7hSY32xjIjuV4UxD5/DmtqFwpFW9m0fdVahW16DpbXJKGJHs7anV3aqRuKorSswxdMPVTS28vN3ewoZR8j0gYwjRgQ5T2LEyDBLuF+abD6DbfR0RGCM8ESANjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087645; c=relaxed/simple;
	bh=7OUNQh/bwgfjp9vJzTl/Ps2bjAwUT0H8kANXkfKlhVE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJUadXKXfAvqEigdPBKuG1F3fsiEdKZdwfSp+IzjCb9O4U6sQ54yQEhfIVskna5m8rtX7+38OYMjVGHUoe7X3jAzMGkkqafTVC7BKUJUyXpuEIXbQXubNGPHn4JqMGgnBT1mW0YlWRnTE9pm9fBG1J0freAop8y6elqmhTwVD3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k62t2cg4; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k62t2cg4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O96HMEgXovjP+hjcSPv2InjvIYXLTnCbkc7MGz5DFLPok9RitsDpawClq9Cu+UPOgk2QYB6oQy9nklXeb6E58+WLcp9Al+hVxCbbZLYMtRoIgT55kPjU/DSw51ui1AWvjs6bC5mT25omx340D7rrnA/8lT7SInMya8KNY1hdkrXGHfU4nRVubMFZGJWgB88xlvGRYTWOwCOAO9Qf9ZahF6umMfZtRXYFveOBL72Jj7uJTzR1otYN6ZdCWIQdeVhuypGbo9mBCIeqWBzMGiEU6tANSvCKVPIKStgYiKjJIunyi7wAd8XietkHeJUaNyI20peHjVbqY0lunSBJSxNdpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVIQk8GmbQWblErAO4GglGFzw3dH9lR5KCcvV77+QUM=;
 b=YUCFMfJbwxjQVTYT6vIA3YYe/4dUiKqT+cR6xH10HLuESPvkg3afntC/cYqQ6fhbWqvBfFcIAJOacLjHyZaxF3zsNtyForTAchOzj422gtm01Cht6q022WBnZKChILWiXxpD1PniCmWEdk8dajQuoWmx1qbhwVj/f5mdvfS6U6HlRq+aqEaF2uF8SJk3tXwZzPO6R3NSZNVhiHjKEGWYajbhMaeRXbaEOaxjFLQLOmziqKgvf2sfMl64JlrQpE3GYnVezlZrG2VyBZVwW9bYNExCrT+wk4Tw5bVb2NYVrPYCL47xS4lQWw/i4FGH1tDx1LBVR2GlNn59N89uZZsplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVIQk8GmbQWblErAO4GglGFzw3dH9lR5KCcvV77+QUM=;
 b=k62t2cg4SzW7khlCQ2axpIYt9z+oqkwro9A4ULEr3XnEUglxI5RQHTVxid7BAyY/t3QHF9mYMDW/yQufbuMILO6Sj3/qgPRUkXtUj0ACk7T61jTz87J6Z49B4pfjRs0wRhi1+MfXg7H7Cvq9RUFti7NdDeG/wbH8Kdgy/tKRZZPVoE4c80oSa6InAe5NBeeBDxQzr6yUUIsXZ0Ps9B5sduCQDEAtPiZlEWmMg9tDYov82l0G9bvegpm7oRHQvW2XqXnoiT16QW7rC7eQS9kuzHGmLVh7AZdZuGY5gHhfcJXEUpkRjlBHgxv/KyiioiFFjgv9y2NJupwAArGZROCrsg==
Received: from SN6PR2101CA0008.namprd21.prod.outlook.com
 (2603:10b6:805:106::18) by CH3PR12MB9196.namprd12.prod.outlook.com
 (2603:10b6:610:197::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 16:20:38 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::1b) by SN6PR2101CA0008.outlook.office365.com
 (2603:10b6:805:106::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.3 via Frontend Transport; Tue,
 25 Nov 2025 16:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 16:20:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 08:20:20 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 08:20:19 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 25 Nov 2025 08:20:19 -0800
Date: Tue, 25 Nov 2025 08:20:17 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, <jean-philippe@linaro.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <balbirs@nvidia.com>,
	<miko.lenczewski@arm.com>, <peterz@infradead.org>, <kevin.tian@intel.com>,
	<praan@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <aSXXQUevF41ATX8g@Asurada-Nvidia>
References: <cover.1762588839.git.nicolinc@nvidia.com>
 <eea7bffde13574e099212e3b3823a0f192d6aec3.1762588839.git.nicolinc@nvidia.com>
 <aSTRRyTBh1nATwBa@willie-the-truck>
 <aSUtL9qxYa6/GCfP@Asurada-Nvidia>
 <20251125134321.GQ153257@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251125134321.GQ153257@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: ae382a37-74a1-4c1a-28a3-08de2c3e919f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3LX0CvvYQx/HAbQ2Q4TXj4yy3vD04cfPvN39IoAtjYElgHORD5FFvu2fbnLG?=
 =?us-ascii?Q?UZUOl73sPIlxI+X1Ey4CBrtvR26nI2tO4Hx0vPRLdr2bRpuxHNeeO5nvftAo?=
 =?us-ascii?Q?9YQPqIdCdF7nUSDGzLw8xndRUkR+ZDOAVxa01T1dwSap2rj79TWejW7b+/CR?=
 =?us-ascii?Q?08bxAnlDXu7kBz5cgqUSdQhBalEoiCwdtve8e8HPPb+pznh8+ETk5gca24M7?=
 =?us-ascii?Q?5b3rbb3OTWKDQJWaRO97MqORY54anTpFFIyfjKO79ieXB/mGqf9UI13CDKXt?=
 =?us-ascii?Q?c555oWqk4a63NpVak4dZOdFgCZsdFmmvtSa7xP+qkSTPPR8GXpUnQpsZYiuk?=
 =?us-ascii?Q?YOfALQbyrrk5Il0t80U73BTbnCIplLg3X5Zl+vcjElV53t7zSONGtPev+rsc?=
 =?us-ascii?Q?e1S/hXd6OeQSxIIzkDDk+zZVGaID4/Fiod65++q8M35yPRhESFgt9ugmaEta?=
 =?us-ascii?Q?0TpvwfMGqBtSVZJaM/Py9Ptf4QV+JWXquMINWL90NGar1ELkj5GlvOvZAi48?=
 =?us-ascii?Q?Cyn4H3+UPP+RoZcgDr03q1THv2MqzQ8F4I09t53tUbnuS8y+P9xnz49BeKF9?=
 =?us-ascii?Q?TF6QAE4TPASChHPRWkY4ro+KrZ43ekQU1gunlczhBUPp1owzwDee0/VmBtLW?=
 =?us-ascii?Q?GU0tNVTAYKiVn+ROEyU3Zl7uAPNosJPhApZYLgDI5S5MufiIw4NB8rwBWSHe?=
 =?us-ascii?Q?uI8mt2oYbBfgQ0X1BAnzErHsQkBQkRXrlGpitba+nAUdBP0Vv5LTWeJuRq6S?=
 =?us-ascii?Q?hWqJcRFB54KYDSlDtL1boJwOaJWtIC0WHy7vGtGIS+2FgUn3aV8mg9DJnBMU?=
 =?us-ascii?Q?4NT5Nirutrx+A8vixu6+7hx5Lco2k9XvI6/OLk6+Z4hZQrMcwncPuM4FQjSo?=
 =?us-ascii?Q?H1imUevHGYMivFINfJ8eveIQw6HG17x4EL0dZaKVs48F/K1DpTuVFhm8SOAp?=
 =?us-ascii?Q?QVneU4TCJPyAy5cEH2SJiy9eccA7R3+pzGJwvvbhpfjIADQinE7eeq0RSNAX?=
 =?us-ascii?Q?0/yWIAbqqF+SDi5LD7ncUEfrgz1WFAKj5pe+tUWOx/92N095THYxNwHMpdy8?=
 =?us-ascii?Q?RlFR0mxP1TWqVQK8BVMplk/DRDtTbdyh2uaptfsD8WVShzqrylaIkkwUd6DQ?=
 =?us-ascii?Q?YyFUPgogpun0HBfG1F6txUaMo7FmoYd2FYvZ35by/Q3y+pvlctNmp/zStU4p?=
 =?us-ascii?Q?6QIUijq/aX+ifsudqF/8xMp+J4AUGxxYtW4+Rn5ybY4DZxZtvixukwndyrwb?=
 =?us-ascii?Q?m7mBOy01oM58y+sUEtK3BrygXi54dAUG2yxfXzl/wPPTaHFSMtO3uC7JtTSx?=
 =?us-ascii?Q?SGE4HFbPTye0o+CsgCtPSlqECeUAY7ZxcBOLX1c+F+8feqWkg7rjZayYHux1?=
 =?us-ascii?Q?5IT1l18hr5esgzOdBOjm0j0EILcRCIN82sJUXubNGr6pRF/r99Or5NgHUzLG?=
 =?us-ascii?Q?KoPAXRHoDAf+pcEDB3A/pspfloulxUXvnTNevdf0khVvcjYOeijOKjSeOH6G?=
 =?us-ascii?Q?w38pg0HhFmY+1tf3Sofs4Gfsoiacqc6pKZtf63QKg6YjqOR5lB6PaoJMoPYa?=
 =?us-ascii?Q?DPVchWQ+7Yv7EldnNOc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 16:20:37.4564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae382a37-74a1-4c1a-28a3-08de2c3e919f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196

On Tue, Nov 25, 2025 at 09:43:21AM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 24, 2025 at 08:14:39PM -0800, Nicolin Chen wrote:
> > On Mon, Nov 24, 2025 at 09:42:31PM +0000, Will Deacon wrote:
> > > On Sat, Nov 08, 2025 at 12:08:04AM -0800, Nicolin Chen wrote:
> > > > +VISIBLE_IF_KUNIT
> > > > +struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
> > > > +					  struct arm_smmu_invs *to_merge)
> > > > +{
> > > > +	struct arm_smmu_invs *new_invs;
> > > > +	struct arm_smmu_inv *new;
> > > > +	size_t num_trashes = 0;
> > > > +	size_t num_adds = 0;
> > > > +	size_t i, j;
> > > > +
> > > > +	for (i = j = 0; i < invs->num_invs || j < to_merge->num_invs;) {
> > > 
> > > Maybe worth having a simple iterator macro for this?
> > 
> > I added two macros:
> > 
> > +#define arm_smmu_invs_for_each_inv(invs, idx, inv)              \
> > +	for (idx = 0, inv = &invs->inv[0]; idx < invs->num_invs; \
> > +	     inv = &invs->inv[++idx])
> > +#define arm_smmu_invs_for_each_idx_dual(invs1, idx1, invs2, idx2) \
> > +	for (idx1 = idx2 = 0; idx1 < invs1->num_invs || idx2 < invs2->num_invs;)
> 
> I think pull more stuff in. Something like this:
> 
> static inline struct arm_smmu_inv *
> arm_smmu_invs_iter_next(struct arm_smmu_invs *invs, size_t next,
> 			size_t *idx)
> {
> 	while (true) {
> 		if (next >= invs->num_invs) {
> 			*idx = next;
> 			return NULL;
> 		}
> 		if (!refcount_read(&invs->inv[next].users)) {
> 			next++;
> 			continue;
> 		}
> 		*idx = next;
> 		return &invs->inv[next];
> 	}
> }
> 
> static int arm_smmu_inv_cmp(const struct arm_smmu_inv *l,
> 			    const struct arm_smmu_inv *r)
> {
> 	if (l->smmu != r->smmu)
> 		return cmp_int((uintptr_t)l->smmu, (uintptr_t)r->smmu);
> 	if (l->type != r->type)
> 		return cmp_int(l->type, r->type);
> 	return cmp_int(l->id, r->id);
> }
> 
> static inline int arm_smmu_invs_iter_next_cmp(struct arm_smmu_invs *invs_lhs,
> 					      size_t next_lhs, size_t *idx_lhs,
> 					      struct arm_smmu_invs *invs_rhs,
> 					      size_t next_rhs, size_t *idx_rhs)
> {
> 	struct arm_smmu_inv *cur_lhs =
> 		arm_smmu_invs_iter_next(invs_lhs, 0, idx_lhs);
> 
> 	/*
> 	 * Compare of two sorted arrays items. If one side is past the end of
> 	 * the array, return the other side to let it run out the iteration.
> 	 */
> 	if (!cur_lhs)
> 		return -1;
> 	if (next_rhs >= invs_rhs->num_invs)
> 		return 1;
> 	return arm_smmu_inv_cmp(cur_lhs, &invs_rhs->inv[next_rhs]);
> }
> 
> /*
>  * Iterates over all non-trash entries in invs. idx is a stack variable
>  * to store the index, cur is a stack variable of 'struct arm_smmu_inv *'
>  */
> #define arm_smmu_invs_for_each_inv(invs, idx, cur)              \
> 	for (cur = arm_smmu_invs_iter_next(invs, 0, &(idx)); cur; \
> 	     cur = arm_smmu_invs_iter_next(invs, idx + 1, &(idx)))
> 
> /*
>  * Iterate over two sorted arrays computing a merge sort
>  */
> #define arm_smmu_invs_for_each_merge(invs_lhs, idx_lhs, invs_rhs, idx_rhs, \
> 				     cmp)                                  \
> 	for (cmp = arm_smmu_invs_iter_next_cmp(invs_lhs, 0, &(idx_lhs),    \
> 					       invs_rhs, 0, &(idx_rhs));   \
> 	     idx_lhs < invs_lhs->num_invs || idx_rhs < invs_rhs->num_invs; \
> 	     cmp = arm_smmu_invs_iter_next_cmp(                            \
> 		     invs_lhs, idx_lhs + (cmp <= 0 ? 1 : 0), &(idx_lhs),   \
> 		     invs_rhs, idx_rhs + (cmp >= 0 ? 1 : 0), &(idx_rhs)))
> 
> 
> 
> And then change the loops computing num_trash to work directly on actual things ignoring trash:
> 
> 	arm_smmu_invs_for_each_merge(invs, i, to_merge, j, cmp)
> 		new_size++;
> 	new_invs = arm_smmu_invs_alloc(new_size);

Cool. I will integrate this and send v6 today. Thanks for the help!

> Name should probably be for_each_.... though

Hmm, I thought it's more common to see structname_for_each_item,
such as list_for_each_item and xa_for_each?

Thanks
Nicolin
