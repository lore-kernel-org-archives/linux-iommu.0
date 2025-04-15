Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6CF2957A1
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744760784; cv=fail; b=FuZ/lItkwsiePF+3e5lq89lVmCi+umeVriHX/jJCQW4KoUhD8pT9soqYSbOYCAk5UyUSYaFiKMSzNWO7l+MEDkssyCYYBLOBbnmIdJ3DtLcqP5eMPsjjQ9qHEjBW7dIGdXCSjz5J2PXO+ReYu7HRs+8j4789WyzorC2dq5vCyWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744760784; c=relaxed/simple;
	bh=fgwN5h34JWY9hTmfBLE2e2Tq9B8Vemc55XZE5KwMbqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AK6Pkg9C/3HMIfyeHAlakYz0NuKJyFOJkyYdsDHBMahsxNs+KIaVnBBTKTPc9aFO4varrd2IprwedopOom7gBJnxlVwa6w7uI1QHkEV8JZd5qUTnXF2jTigvNj9KaEPC6x7C++y218651swWILwgd1wjaKajCxIyUn3H1Dpo8JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FKPfVdOM; arc=fail smtp.client-ip=40.107.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FKPfVdOM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytPoFUePS0dIgi5n8DjgYdaeM3ydETfYh10sj/mRYu1Hf+R71kWIko0ohUxOvgLJrE75Nj9lEEARMsiksmRDHa/vkj+oyvFDbDtge/+0mpIY4ykKHlM2GioGZEacYP2+V0bkB8o481GOhiGuC6LQ2X7K33ogeMu3yFA9H+U1witaEOveeNwTmbGEepeZLziLHCbekcXF9mKklPi8Ur2VxcwsHUdLGFjnAy+NWG+I8wHpv6FhWyQ1zPSr9OVAcsGlqYm1c3/94BTTYKLSu+ItIrP02ZG3P4dWFmrflI8WMG2k4IiIw564a1t6rju0UXTRGwliXow5Af/jsSKImQnMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSUzlV4gyKWwOByFtZB+s/MgPqd/YfFY19BkHIRvW44=;
 b=rD3PKqWORW12LHuF2vMneUwhiiNOvJLpgpwkbIa+KNsbMwutxJDD+ibYuuKBGm+uVXCkeEqyC7zvA/90MNRvFKHlFtoBTHy1GESZN+MnyOLH4fA/04cgPQv+E3awW4qvx7dWG4PIsqD1vNmJEQ57EJng9FULi0B2kDiS+TsQ5hgWiDq4Pw6/Km5+tVH9s5VLaXD9yFRWF9RPyDQS3rx7qBa3gocvZ+4pZKqVFrbwC7zZantXQbabfEf22HH0JPih4uCe6qvIYDT5PvNqq12fFOSzvN8AGMdYKQSLT7VJe8DZv37IT8iklHMg+sYNWjOZTN+9hPWMkpNo74Bt6BgpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSUzlV4gyKWwOByFtZB+s/MgPqd/YfFY19BkHIRvW44=;
 b=FKPfVdOM1rSl9dyKz0vsyVoUNUxku+Vd8/St+QIKUk652/3PHBfiRrrFcuwDRrRPR11bldMc1Ej53Xw1ERJApyn4MxUFajR+YXOJfuBKxzd5JX476vo5ro46AnlF6fwqXijKxdlxi0WPjr2JnPFXGSkEn1yh8aPahX47sgeRSSembiSYWML81kAyZERkWwD38zU8cdDzcjQS+ERfx6KJDzU9fyJVbCapSoHL9gaBMh21W9OSqiNWEVds5CD3aMn6FvJVyyX7FKaHrnsdfZNt0+do9qu3MmpLskAywXpJVXTCHV7U1ktQeCLofcaNEIwpVcyC1CBAxMteXFSAzMr8MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB5639.namprd12.prod.outlook.com (2603:10b6:806:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 23:46:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 23:46:18 +0000
Date: Tue, 15 Apr 2025 20:46:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	kevin.tian@intel.com, praan@google.com, nathan@kernel.org,
	yi.l.liu@intel.com, peterz@infradead.org, mshavit@google.com,
	jsnitsel@redhat.com, smostafa@google.com,
	jeff.johnson@oss.qualcomm.com, zhangzekun11@huawei.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v2 06/11] iommu/arm-smmu-v3: Introduce
 arm_smmu_s2_parent_tlb_ invalidation helpers
Message-ID: <20250415234616.GB823903@nvidia.com>
References: <cover.1744692494.git.nicolinc@nvidia.com>
 <61fef9052b2034e5b4ffa1fa6ce481667d8ea6b1.1744692494.git.nicolinc@nvidia.com>
 <20250415125042.GA517881@nvidia.com>
 <Z/69PTDANYagKX3d@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/69PTDANYagKX3d@Asurada-Nvidia>
X-ClientProxiedBy: BN6PR17CA0035.namprd17.prod.outlook.com
 (2603:10b6:405:75::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: 6200c17e-49a5-4bc7-2d06-08dd7c77b773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gU0ez/v0O0ZXoDMMsnb3bc6U+aohdX63t+cVZxm57X3XnXduwWI+wYh4X0+w?=
 =?us-ascii?Q?tDLjb6ArnE4sssNUVuRkGBmKvG8afYh6Q+vzLgtrR2hUvPMwwXFC7Y3/xn1D?=
 =?us-ascii?Q?oh0TVVPL13nGWSOQTPTqOx4j9Z0uOiQZI+hCRAYARjWtTjhKaH8NYZRA7Oa3?=
 =?us-ascii?Q?F3pvJ4WjMBAI29feqPFbupwZ5/q8UBwKZCWFdCL0o0LgKswJTy8eRiWe9UVB?=
 =?us-ascii?Q?FYWA9GA7A8wzNnvuC/t+9k+ZL0ydoyxhZ+xnJxvBb43qtdiVIUps9Wj3L28C?=
 =?us-ascii?Q?DSGsFXgfhSfx7BksfcT9+/AWvvOBF8IihkzGWMzUEcbf4u8MqaG15ahb5jJb?=
 =?us-ascii?Q?QQfkLEmCCtcZuP6fvnBS3Bmy6hzoaffn31HsPjuOW6Nkb896uN4jNUTv2UZc?=
 =?us-ascii?Q?HDc6dyZTY+tRBBIzU+H6Gj4z75sBOzXQBWQfgA0Hymv+fGtKX5imrUjtibb6?=
 =?us-ascii?Q?M28mP/uh/G08r5KcjIkbDDRJ/pXGgWWZcTTyZElMKdX+HcjDXE6xSi4yU1rg?=
 =?us-ascii?Q?lukt+GuShsvyLUluVF5WO/M/XnT5ohV42KuMTgn/eB+75thOclFM9en2S5bo?=
 =?us-ascii?Q?AVuBLeb2/jInffUw3YjtEXH4xeDgSy5wh7PTamAoXpQsr0FFqpbYnLAaiOQw?=
 =?us-ascii?Q?wNjUBaUxuNo1OSt67IWPyiOwOvSEZjRnXaeuDmielZcaSDQMIGtHcTHsL3M7?=
 =?us-ascii?Q?8fCjOigHSUGASJz0ZMysMX3YJKGtClvyG38dQud0/rvGW0SdAOu4hha7Svjd?=
 =?us-ascii?Q?sIr7WZxFbc8qkCOtv7zqdMNR1T0+iARtA5tcocIAmKHwIGY7ALqDmbf8LuN2?=
 =?us-ascii?Q?uQgTmnDrDHMEXxsgPw40qAE6ZStVJ6zYetr3l8H0qZabRk+dTbie84Z/FKPB?=
 =?us-ascii?Q?aUl/Jn3gSSYITEs2mSJS9/gdMMu1/f0q4CeQINsfgs72qfFySgPE6f7yGDcH?=
 =?us-ascii?Q?SmX5xJvJ+1l3bResdJp1aNKL2zaG8og3D6Jiy6Zr+CVSaogiIgFdkuW6Dan5?=
 =?us-ascii?Q?TtZRBDtluP9bs4hKV2PNwiLpqRPg1jJw25cmCZWlwtKJjT94AYqldv1n6qXz?=
 =?us-ascii?Q?HRwXi8pkqqmWtJ03lxZqh8CYcUWW8DJUF8MLVLUXrtxUUIQIm5/zKsims6/m?=
 =?us-ascii?Q?qrNQ1MXV3z4bJBN6cdFrmJdLD0XWj3P/TCdJLtRvuwYOQ+THyc2X2uJghLG2?=
 =?us-ascii?Q?zZfPuKPPb9Y/WABOS3ER3AP7aKNOqJEjQr+sHAyI0m/08xboNlOdnXmJgO/J?=
 =?us-ascii?Q?CDvADbm8fo5hDDLxp+pNwB0VFs1CtWtvid6z2UXF5bwi35hrYEqKAgmmmGAU?=
 =?us-ascii?Q?bnuiZVNPchZmsgs26pjd2YPg0R8Ty02MCqYQDzaSb2G4soFSlDq164ZkT9Kn?=
 =?us-ascii?Q?OqUuLN1Naw79MMqx71NGbFfwJM92r0Em254pyrmU4U0eypw/wfdUCxyGRQ3P?=
 =?us-ascii?Q?cGyzGJsSRgE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YtcFLMP6dciOWnR/4W39uRmy/YY9L2VLAwPWkFnrSBfmDe4/YfXe6Df4+4aT?=
 =?us-ascii?Q?7HEyGezFvMkC/j3z7bQtQkTLELw5ge1QMqsbOgbKyLU/e+vYthzAwtZtV76R?=
 =?us-ascii?Q?14ivmR6ZBWhwrvQfhfEYaSUmAl6ym3ej9FOySY/Ljif8Rd6hRfp5dx3NkmGV?=
 =?us-ascii?Q?76DWZPlSCc+yKBjF3LPESBBMpU7Df+ntwYF08mmH7K7ATBxv5+oE2pGVyjAp?=
 =?us-ascii?Q?qRbfMtfjvdKDXAssxVREiABtibQoQEvPAFII9JpzX4halkWe1cb59ijlIec+?=
 =?us-ascii?Q?mA2FAU8bxeLkrXToneetYH72Yig4KTfLz39GXf/MEUG3cpXOuEA2P2nwS6PE?=
 =?us-ascii?Q?pCpkGwk9bq2iXgb41tt9KckJgWr2CQQQVP6Q9sdVuikqDavbTY1d1Z+nKUjE?=
 =?us-ascii?Q?kNy+i2joL6XXS4QouRonkY9gZoywEgCrwTWe1R9UVdzxJ+FXndwO9AxPEAT6?=
 =?us-ascii?Q?cEDjDvBhZQv6KekVAR7byun6NIKVPf3vXpYmjeNEgiH2sn8aOYcBQR9tFlVK?=
 =?us-ascii?Q?PAPxgSENKK8QXeBFxfibLFz87oTaU6sX6E3E5iMHQ7G59NWCJ30r5J0y1EYl?=
 =?us-ascii?Q?kxvQYAX2016TCLZCLp2+N6HNWPVy9R3nlwJiJkK9xa0G5ngp60IDT2WOY5qa?=
 =?us-ascii?Q?99lfoCfGa8GcaVkHM4+zDpmYNEjkz/hlF5jnjsnAZGOmr6pu+XMxBC9CLjiL?=
 =?us-ascii?Q?Aj+YRhsSzF5z9Guurxh8vgczkmV+a5aDyGj5QXMfV7hTye2rNZ67+8N2I4PM?=
 =?us-ascii?Q?LM1ShlIjx0lY/heVsH/Tng29D4BZ4Hfc/7tR9kCfZUQE9oexsJUPoLTt6Ogg?=
 =?us-ascii?Q?akEIkvbyQ4RlFfZfp4oaqP+JYNzxnDsw12wgjXhwUcBCP+11pZdApIFX9jcY?=
 =?us-ascii?Q?KaE1BrnymCM3KUR5RxonqJz7dmX1lpfWwI8ZuO9i6sPsplQFWB+GTmA5fikh?=
 =?us-ascii?Q?j7UjK9dKxevnvj2sZrKgg7GOKe8ycIcDwZupCop3FmBB+VvbBpJIiG4fbYYa?=
 =?us-ascii?Q?n3oOGfFpsDLWD5J0yr8lFrtcPDS02JhWE810sf14am7YJVd9/978Adpnbt2j?=
 =?us-ascii?Q?qLXMRo1iY1EE4lmuM9GE4YsceGsJrlpOzcUsbSJM4wQE3Sv5Kp6vRUsxmkQB?=
 =?us-ascii?Q?aGa6goQEfoxrxwLh37Pym8zWpZ4ASQbt7lvYx+uuqNJRA55dV8DXy65pdzwo?=
 =?us-ascii?Q?AgcWE2Wx4reTJlmhxB/ahgNa1OJDk5HcJwikW+gVMC13vLRYv7OaVrIe2+FO?=
 =?us-ascii?Q?zKEPSRMSpqk7c67NxjFwxy//eDOte4WeEY7oMkRvKCqysLUNqgoOq7FpraxS?=
 =?us-ascii?Q?BtXcVBGsoI1H7iyz1JnqsSRTnGMQm//R/jSJmDuhB0u9IJXvzDjy2mYRtliX?=
 =?us-ascii?Q?yDwKGDzAiVsLRq73a/MgcVYFuRYzgnDyZ1S+VlfMYCM9gxbY2x9EScZX0/TA?=
 =?us-ascii?Q?+Lf47oenNeEzlBGKD7QBEQNbYeIyMtWCjar0oBE8Dxaeoc8GA5tY3jFkRWiT?=
 =?us-ascii?Q?39xuqtaQXNNco6UcdNnjXsKzpxYHsSIXDpzjNGP01WtVuSNnJgEfjeh3E1Hg?=
 =?us-ascii?Q?GiErE0e5zJWzdvlEmnTb/NST85se1YoDnZID46Tx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6200c17e-49a5-4bc7-2d06-08dd7c77b773
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 23:46:17.9447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlpkSiPdAfVfe7b1eHnVsH6h+zSZdshvKr2SW1PHv7JzuCVQxfU/Pzbx5C1tRj8s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5639

On Tue, Apr 15, 2025 at 01:10:37PM -0700, Nicolin Chen wrote:
> On Tue, Apr 15, 2025 at 09:50:42AM -0300, Jason Gunthorpe wrote:
> > struct invalidation_op {
> >     struct arm_smmu_device *smmu;
> >     enum {ATS,S2_VMDIA_IPA,S2_VMID,S1_ASID} invalidation_op;
> >     union {
> >         u16 vmid;
> >         u32 asid;
> >     	u32 ats_id;
> >     };
> >     refcount_t users;
> > };
> > 
> > Then invalidation would just iterate over this list following each
> > instruction. 
> > 
> > When things are attached the list is mutated:
> >  - Normal S1/S2 attach would reuse an ASID for the same instance or
> >    allocate a new list entry, users keeps track of ID sharing
> >  - VMID attach would use the VMID of the vSMMU
> >  - ATS enabled would add entries for each PCI device instead of the
> >    seperate ATS list
> 
> Interesting. I can see it generalize all the use cases.
> 
> Yet are you expecting a big list combining TLBI and ATC_INV cmds?

It is the idea I had in my head. There isn't really a great reason to
have two lists if one list can handle the required updating and
locking needs.. I imagine the IOTLB entries would be sorted first and
the ATC entries last.

> I think the ATC_INV entries doesn't need a refcount? 

Probably in almost all cases.

But see below about needing two domains in the list at once and recall
that today we temporarily put the same domain in the list twice
sometimes. So it may make alot of sense to use the refcount in every
entry to track how many masters are using that entry just to keep the
design simple.

> And finding an SID (to remove the device for example) would take
> long, when there are a lot of entries in the list?

It depends how smart you get, bisection search on a sorted linear list
would scale fine. But I don't think we care much about attach/detach
performance, or have such high numbers of attachments that this is
worth optimizing for.

> Should the ATS list still be separate, or even an xarray?

I haven't gone through it in any details to know.. If the invalidation
can use the structure above for ATS and nothing else needs the ATS
list, then perhaps it doesn't need to exist.

> I will refer to their driver. Yet, I wonder what we will gain from
> RCU here? Race condition? Would you elaborate with some use case?

The invalidation path was optimized to avoid locking, look at the
stuff in arm_smmu_atc_inv_domain() to try to avoid the spinlock
protecting the ATS invalidations read from the devices list.

So, I imagine a similar lock free scheme would be

invalidation:
  rcu_read_lock()
  list = READ_ONCE(domain->invalidation_ops);
  [execute invalidation on list]
  rcu_read_unlock()

mutate:
   mutex_lock(domain->lock for attachment)
   new_list = kcalloc()
   copy_and_mutate(domain->invalidation_ops, new_list);
   rcu_assign_pointer(domain->invalidation_ops, new_list);
   mutex_unlock(domain->lock for attachment)

Then because of RCU you have to deal with some races.

1) HW flushing must be synchronous with the domain attach:
      CPU 1                   CPU 2
    change an IOPTE
    release IOPTs
                              attach a domain
			      release invalidation_ops
    invalidation
       acquire READ_ONCE()
			      acquire IOPTEs
                              update the STE/CD

Such that the HW is guarenteed to either:
 a) see the new value of IOPTE before seeing the STE/CD that could
    cause it be fetched
 b) is guaranteed to see the invalidation_op for the new STE prior to
    the STE being installed.

IIRC the riscv folks determined that this was a simple smp_mb()..

On the detaching side spurious IOTLB invalidation is OK, that will
just cause some performance anomaly. And I think spurious ATC
invalidation is OK too, though maybe need a synchronize_rcu() in
device removal due to friendly hot unplug.. IDK

2) Safe domain replacement

The existing code double adds devices to the invalidations lists for
safety. So it would need a algorithm like this:
   
prepare:
    middle_list = copy_and_mutate_add_master(domain->list, new_master);
    final_list = copy_and_mutate_remove_master(middle_list, old_master);
commit:
   // Invalidate both new/old master while we mess with the STE/CD
   rcu_assign_pointer(domain->list, middle_list);
   install_ste()
   // Only invalidate new master
   rcu_assign_pointer(domain->list, final_list);
   kfree_rcu(middle_list);
   kfree_rcu(old_list);

As there is an intrinsic time window after the STE is written to
memory but before the STE invalidation sync has been completed in HW
where we have no idea which of the two domains the HW is fetching
from.

3) IOMMU Device removal

Since the RCU is also protecting the smmu instance memory and queues:

       CPU 1                      CPU 2
    invalidation
      rcu_read_lock()
                                   domain detach
				   arm_smmu_release_device()
				   iommu_device_unregister()
      list = READ_ONCE()
      .. list[i]->smmu ..
      rcu_read_unlock()
				     synchronize_rcu()
				     kfree(smmu);

But that's easy and we never hotunplug smmu's anyhow.

> > But the end result is we fully disconnect the domain from the smmu
> > instance and all domain types can be shared across all instances if
> > they support the pagetable layout. The invalidation also becomes
> > somewhat simpler as it just sweeps the list and does what it is
> > told. The special ATS list, counter and locking is removed too.
> 
> OK. I'd like to give it another try. Or would you prefer to write
> yourself?

I'd be happy if you can knock it out, or at least determine it is too
hard/bad idea I'm trying to push out the io page table stuff this
cycle

The only thing that gives me pause is the complexity of the list copy
and mutate, but I didn't try to enumerate all the mutations that are
required. Maybe if this is done in a very simple unoptimized way it is
good enough 'mutate add master' 'mutate remove master', allocating a
new list copy for each operation.

Scan the list and calculate the new size. Copy the list discarding
things to delete. Add the new things to the end. Sort.

I'd probably start here, try to write the two mutate functions, check
if those are enough mutate functions, then try to migrate the
invalidation logic over to use the new lists part by part. Building
the new lists can be done first in a series.

From here a future project would be to optimize the invalidation for
multi-SMMU and multi-device... The current code runs everything
serially, but we could push all the invalidation commands to all the
instances, then wait for the sync's to come back from each instance
allowing the HW invalidation to be in parallel. Then similarly do the
ATC in parallel. It is easy to do if the list is sorted already in
order of required operations. This might make most sense for ATC
invalidation since it is always range based and only needs two command
entries?

Jason
