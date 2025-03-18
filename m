Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72181E515
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300392; cv=fail; b=VvvlbbUY3TtSAEpkdrxGkOY8zGT9MzGdUQB1ueoNgufhifSVQl9MnyNimOF5Sc19Z23pDZEsZ95gTrDDiCMYyqMbkjczo3YwOMc/CytqkCoSbRMXhQ603jAW5kPym131z0B5el6StljgCs0CDuTjvTEdDfR4kNLavpwJqleURq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300392; c=relaxed/simple;
	bh=06CCa1Km80S/SexPPkWC/VSWx8s19rKD7stJgC6LafY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u5fj9Rn0fIYBV4rP89TZV/YflHzlby7jIkdwNjVL96xRt+gyoFUltxlwMmuzCU2Nq7iQfZE4/rYzHGilYJovlH+7KDuw9yFwpoKP3iagcsjZQTg4rOWoluTBoxTltctQOfpoCgYrojlgUJMoIOKroCls9JCFimulGQwcZNc2RxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cLSYPMB5; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cLSYPMB5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJgS2doIhibhdivjuc+sYl2+/mmQL7I+ZKSe7ZQ/MqaSOPcDITEKwzcZQTB0YdbNor0FhVj6beI9I817KANZt9ut4l7G0ORJfDC3xnnh2fCDm2zxCMuFJBS+I/6bLvihdzHuoZ170ehw/mjCbg8ZN6PTeQnycY+o0pAJfPwGIL2xmpvh52tNLVoR7QeK877RZ8P75N0H7x6AXAazcF8lMjDe1yjY81QJ3XJ7PrKlGVGp/ycFLRXVN0eQj9JXnxPBNRzDsjPdiEx2ITQIjzn6KNXO0lcZE58V3vJm7wW4PN3tFs/NbhiJzUWhyIlSgiX+xd3yJy426UcjkJX7juyKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ct6t7r7qy5PoICSxy9n9DYmbY9JFFtB3WvcEQJQ8174=;
 b=UnAxvO5AyT7wqVHaWjHNQwZcvvce9yiRWQZFYB6YIPIzepJq+OMHynuC43+R5Ba0hoTqlEFyke6dBppGsDmYPzjauYwzBzrqwbvCu1XT9AeWqb7Pp0rm6ItR9UlL+kyOCbFV8n50iIyRZtrQz1hfSYHyWo1KlIZgK1pGyNg3tRvc34g2uYZB5wg7GMjSwmr1tgmiEdJgPQ5M1jcwKxYy9LPPB91M/iCQuGqjDuJqDBG/JzPO4MYk25Y/e1y4RQEXwd4xoZxUMyKDYYhLce8yvjL5IAX/jv17O9z+h2HgzDIlqVb34KRcKXv/UI3La9PsbVbAII8+AQReO8BCCE2V1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct6t7r7qy5PoICSxy9n9DYmbY9JFFtB3WvcEQJQ8174=;
 b=cLSYPMB58myPHnMFzwXBs5gtpdmbYnX+9Cwwkc9fN9aKMRj96mzAMiK1XXHfOLf/4+s9GFUG4Zae7eUd1YgWLBmGnwwueBd/llFetQZnOM+VTF83Znv3RyhIP2JI0imDKMSMJFBwuqaePUAe/bVjda7PhSxySAub8cHWgjN81mHT40d/AhHPSp8dULeLfm8NFLkzFMe9yAAArnhkrYbUmNDiCYE2RcOV0/zUEJLWT/Hk3ph6i7+z2f1Z66HG0xJR4uKZEpLRi/1hk+/NL0VKxdhzv7S9NmA0VE/1K/UCYir7Nx1f/z/zgUDPYIEg3cYeNPAv/1DD9XbwwlPH9U+W/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:19:42 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 12:19:42 +0000
Date: Tue, 18 Mar 2025 09:19:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v9 03/21] iommu: Introduce a replace API for device pasid
Message-ID: <20250318121941.GF9311@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313123532.103522-4-yi.l.liu@intel.com>
X-ClientProxiedBy: MN0PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:208:52d::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 8142c333-eb94-4dde-1e8f-08dd66172983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?odI7T+Oxga3MzbElXWtWjxtURVxn2Rfeik8vA4pbZRnE91gHBqbHYYI06Vu6?=
 =?us-ascii?Q?eSnO19xp9eWoRVS632vhJrNA1p1o2MzoxvkVhQ46tRzlJyfYnxssZGjYNzlp?=
 =?us-ascii?Q?gkrYctccVjTST8QF9w1abhjeqF4jcPY2wMDbo51hbVHZKY0egsXcl6Be5gv4?=
 =?us-ascii?Q?xKnsp9dWIOeDFV/xA07dxulyMU9hyku3WiMUtjKf2zrjCt37C2uUFCUhH6Tj?=
 =?us-ascii?Q?+eOUlvSWlTxej479cBI6KtR/skAgD9NlyP5mIrWNDZPm2uex5Ps9pD1UdmY9?=
 =?us-ascii?Q?WTi68MnISh5JO5YDr7GO3NGZavJ6VmVF4eVN70pRirkVe35WgA706/ewIJXg?=
 =?us-ascii?Q?Y31bqTTYlNzu9VC22j4rpG0wxq0E37dp+twxbyoyZsK2P0a9GsYo8lpQkPcv?=
 =?us-ascii?Q?8KLOb56JkcuvGC5dozJ/6Lb8kIIR+q8pxmczpWfUyyqcegZMd8WKJK7cgaEH?=
 =?us-ascii?Q?/2eqS4IYqJoeLACofbdnpxgNTTD/VxOUQLyefav054Uy4bZBfrDr+eQZphIS?=
 =?us-ascii?Q?avrPscm43bJwpmDNM7l7KVQ/GWaFFMDWGqUkZPwWVvmngJr+LEG4uV+FZM2V?=
 =?us-ascii?Q?3rysH/vu5t6++eIS6QI0+VNUYIOoKR7/HaLb5bW1xYzRFyo6LGQTKAJckg6p?=
 =?us-ascii?Q?4dqjMXTy5gN6Z9YHKCjcn19IFyZtYNOC/pCJ1zgWtLzBs61oANTBRS5B6ksQ?=
 =?us-ascii?Q?WzrqPfQNJ9BniX+sL2tB3JEZoyy+rLIYTq/zYdibEzx+5NniQtg2oVsUoe96?=
 =?us-ascii?Q?JTh/3dAiEgArnHvoLv1tj8thLEFBu2WeUO1fhaKqpxeLcWTaxZJ1CGwlsYal?=
 =?us-ascii?Q?3/U/Oi8Gf76CXL5swA1IU1UD18UvOvCFdqxKWofdj+RvB5L6rJ/hgLXsOqvH?=
 =?us-ascii?Q?3nHhlIiYkyhVhfsm/ZdUT9FQnIKjz4p9aHkW3Xp9JjsPfAIDXMMuLhhngdhN?=
 =?us-ascii?Q?UzsELp0tZ5lDwf4F12qRVoFqXC0ksToDHxW0bPFpaw6Ktf5mMx3h+GGML9G9?=
 =?us-ascii?Q?og+sE+zlZ2PGf0e7VqlgiOxbE0rS5WmOe5xFXz9TC1AEy1UasK6YWW4HVjru?=
 =?us-ascii?Q?cZj2Lccr7fUtfVs5+RYXs7PnQZKLT5oTtHk45KRUTwyoUQHaQgLlXylL3spn?=
 =?us-ascii?Q?35oZrhWqwZZ6+YlxqR9U7u9xL/0wRvPm1EgRFh0BJ8KUhfXJqdu8JBAwl1fY?=
 =?us-ascii?Q?L8IIvx87NSCIU4IV9s9SsNr1tlGdNiDGvUUdAlUCQckDbDusZLRZGn5zi/Ng?=
 =?us-ascii?Q?aaTvViAaRYg+GB919z9L7ZbYuDlccV4PYeoGVRybz928zjur3pRK3XWMF8nF?=
 =?us-ascii?Q?ak0ZjbPPgfMswz5N3Lh78ez6WaTC9X+SB3pZcwDMygFpbzu5CsEXAiJ9LGTT?=
 =?us-ascii?Q?JNp9NC2Y8tKlF5hyWqBYI/tJVyuJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oUMumtx9EA3LLa8Got9WrJBwquwZWWTHO19J53/ELgAJpmEj6l2BRPvBmJcO?=
 =?us-ascii?Q?yUtDg/bsPjnlABJVBMgX+mPt75QzUcS8xwww5nPeGi9xn2DzHgi4Vg2pL28I?=
 =?us-ascii?Q?d0G8pK6/PzVM1jmuleDkIIgGth0jzSJRHEZnkPaF0hfsYtsCTFUo0y1f8MuT?=
 =?us-ascii?Q?O1xh0hoPfUyLeq/2vkkFJR0TKpmZiktFLZ/FpnP9mJhbGYxRDYA9MNO91Lae?=
 =?us-ascii?Q?ownSRypvTR2Ev/fVdAonLVmv1ZLu7GTAMuRVz+/qz48XjzXsBg4JeS03SwS/?=
 =?us-ascii?Q?MXNCfNP6M9NfVMRN+zs4jSTGCCZp0oSFo/VGxTro8wm+J+9SsYsDDUGYeCtz?=
 =?us-ascii?Q?1hO8VAJYj80m60DjRkAu4uxnA1gNKG1dFpzaoCWxXWripAB+aMUmYV65EB6L?=
 =?us-ascii?Q?kRvOyMoB8X0q5/KQdcg1AJGesF3OO0XaXAHG0SYMHbz5goJK3UPJXinIM/vA?=
 =?us-ascii?Q?pYgXKYcuG8hAj0I5Ba2ZyTrGmtpzLamZCmxbUNAthrUuY1syNS6FfiZwx3+R?=
 =?us-ascii?Q?EQOaPiPaGjxgaQ2RURrYUJuPH6KiD+ie/eGAoXuEAhEzzkXwv9Fs1/nb7WBu?=
 =?us-ascii?Q?4DEvdRBBgkY+PH3kLJE013HQMmVAbbq/dDZ2kZ1HBU98gG1WQRyAswnyeH9v?=
 =?us-ascii?Q?O1inDuz3CGQzR55j9061i3wXoF8YCm3qPwAoEKQyVH9D/6TYGL89Q3oH6CrO?=
 =?us-ascii?Q?8WTh860s3HR+FYzPKRAGsxSC38AHk3vbha21UkLFro82nqxp7NMyqAsGJdnT?=
 =?us-ascii?Q?T6YUOos4qzr48hLg+BBJMjBoXFuPu/zFFTT5CGZmAGyuE3jPkqKis1j6QJ+1?=
 =?us-ascii?Q?+8pGiNhTffZG39fj6mXH8Lztll6U7VjTLycwQMpT91dS967pyu/mXcbiBXma?=
 =?us-ascii?Q?5C12lU4O8k+unGat3Gg+aLDDJuc9TqFj5YPpQ/WB48yAYcIIekucT+6sRvau?=
 =?us-ascii?Q?kI6F+JQgEvrGz4s5X0PkTEBUJxTJa+wT1qXpLn4uNBa46ASrNMtnJfvh1pdi?=
 =?us-ascii?Q?Z7jz8AChLPAChYpdMmMq9+adSZyRPjH9DXulvQeMisO6mM/2Rtj3dVAM8MYq?=
 =?us-ascii?Q?U/Lq3x17lHbxe3RiMYheA8gjLKYS2tGcPnoYvHr9zNRQgcAlNcyrWYtCDc/3?=
 =?us-ascii?Q?QzWtD9eneLXHjb2dGbMtxNHuqZtzTTz/zr7GgtQsbqX/YFudOWZqU+XBpYu+?=
 =?us-ascii?Q?m5N9AzMQuj5hFtLBfY3/4EYkkwpnXyxmN9sV2whKAZDq+0CM0nZvdCefr6WH?=
 =?us-ascii?Q?FC5+TzoRe4Lf+wFQfxdSt10KG4oXRipQJ/Oq9bHLv+bF2SUPx8ACqrhGUVqv?=
 =?us-ascii?Q?jwLkQF+4E0CJ+56o9gDwKxCVXzpdKhhu0FV8IzvjLwRpEjy77yOA0xx276R/?=
 =?us-ascii?Q?J8jEvI0CKX785+wIDZKs2P1fMHjs+nrpEqX7N5BHcsm0nL6nRNjlb2OJAO1f?=
 =?us-ascii?Q?52KERWUI3a7Jb878aqxm6ZQmJCvyqTudII99r7wq2iEmtL89NWsSSmTPLs3Z?=
 =?us-ascii?Q?VgUkxwHYd4CPT5MDjvAgS2hG2X/DLD6NZwmvalhAiUt87EsXiC4q/2lzo22W?=
 =?us-ascii?Q?gCTCPeza+GdcNwG8mDdD8ACQJ4moFWy2q+NQ1yG6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8142c333-eb94-4dde-1e8f-08dd66172983
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 12:19:42.4833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YM7ukFasNaybvCiiPw39YwiHiPO9EtyyhI17nRB/BaZnYb35LTU+ZsqWLZBUQrLf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774

On Thu, Mar 13, 2025 at 05:35:14AM -0700, Yi Liu wrote:
> +int iommu_replace_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid,
> +			       struct iommu_attach_handle *handle)
> +{
> +	/* Caller must be a probed driver on dev */
> +	struct iommu_group *group = dev->iommu_group;
> +	struct iommu_domain *curr_domain;
> +	void *curr;
> +	int ret;
> +
> +	if (!group)
> +		return -ENODEV;
> +
> +	if (!domain->ops->set_dev_pasid)
> +		return -EOPNOTSUPP;
> +
> +	if (dev_iommu_ops(dev) != domain->owner ||
> +	    pasid == IOMMU_NO_PASID || !handle)
> +		return -EINVAL;
> +
> +	mutex_lock(&group->mutex);
> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
> +			  XA_ZERO_ENTRY, GFP_KERNEL);
> +	if (xa_is_err(curr)) {
> +		ret = xa_err(curr);
> +		goto out_unlock;
> +	}
> +
> +	/*
> +	 * No domain (with or without handle) attached, hence not
> +	 * a replace case.
> +	 */
> +	if (!curr) {
> +		xa_release(&group->pasid_array, pasid);
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	curr_domain = pasid_array_entry_to_domain(curr);
> +	ret = 0;
> +
> +	if (curr_domain != domain) {
> +		ret = __iommu_set_group_pasid(domain, group,
> +					      pasid, curr_domain);
> +		if (ret)
> +			goto out_unlock;
> +	}
> +
> +	/*
> +	 * The above xa_cmpxchg() reserved the memory, and the
> +	 * group->mutex is held, this cannot fail.
> +	 */
> +	iommu_group_pasid_store(group, pasid, curr, domain, handle);

This has the order problem as well :\

It is really problematic to fix since either placement of the store is
creating error case bugs.

Maybe we need to give up on having the driver fence the PRI hidden
inside attach calls and directly add a new fault fencing op. Then the
core code can sequence the fencing as required to make all the error
cases work and the driver doesn't see the complexity?

Jason
