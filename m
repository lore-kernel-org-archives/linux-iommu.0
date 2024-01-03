Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C091C683
	for <iommu@lists.linux.dev>; Wed,  3 Jan 2024 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T7Tr5j4l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfodpJrBMwZgQGHxslCw2/2X+PN6RAQylWO+0pkRpTy4m5yf5WTJpqDqfRBHYAJw8wwC/WVWKoIg8urMfX7q5J9noT1/9T5oy2cVxIU9vx2YAXoY22qEAxOwnPWAzA5yzXAhadft+2X9QcJwXP2f/Ye6sMKTYdt4Sd3T3g+VZNq8zXpUVX5+km3al2y/BUba2pgPDbWK1WnUJGtortI6QLW4UC8NV6rcTTub5E/Q0zFe0HqfQ3TJDGo2NMLpaaO0Y9/op0gga/25sFCaDf/i4oBxZYPdwghy3gXuisuV6QiDjYqW5m4aLqDukOWHmXCZ6lU9ORa+JxnIOfONQkcdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4O0YyfE9gwZODKIYkjihtIR4ZQDQSqpQdhGWCIXUgZQ=;
 b=jqPbLXneDki/JunrRb2dzBxPbtJNrZpn0vv1SFU6AE1cCOAcz5jbzvt3u7gm/7Zu9Hxm/PqT9DvevEuYqsu3yUGIy9KDr8/tnm8Zb7hS8z3hSQ5dIomLM7olSgtJaLsnefT6Rgv5XRsNs7iUL6Y+PeSnnZrOf3Eu+CumeNauu/Z6gGLLFmw2AeJf4MV9sqx/5oCS+ClehFWm+56uHuuFlV0DdWsRjfSp1P7YwhWfoF65pVqC11qE/WzQxifFp2r8jmIQPQ8cl8bu/gSiwaYHmvQULVk6a7sHs54XTDY8G0SWrM6uXWN7x+RGTd6HkAMvQQrwicd3Gd+/cYphhQW9xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4O0YyfE9gwZODKIYkjihtIR4ZQDQSqpQdhGWCIXUgZQ=;
 b=T7Tr5j4lxUeHyRQkbmNVygBqkAkAWyi3Cl/a3ZsUPYl43pxj43epxaKnVkusCKalQs5ATJi8gwRagZDmQxOdeSz4OdlCpF+JQ/T4R8fQtXu4LgHgHxnp6uwe1OZjFYH0RyzVjxpJkLNoMROegl18pBaQK+S4FC9XNkDjraXMsSSVCGch3RHyY691Zh0liseDeqECCol3XNuFv7bWQ0vHcdnS01ObfYmJBuoneJCutBqWeO7yvHfX2hn/UrCIeQSXwxnn7Zor5a0wZtNJN4l37LuGTEiyibO6ERBteF4fsMtjR0ea+X7dUuwY903Kn1Nr4WWPKo9aNcCPfsQTI4TFPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5194.namprd12.prod.outlook.com (2603:10b6:408:11b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 17:50:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 17:50:44 +0000
Date: Wed, 3 Jan 2024 13:50:43 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming
 independent of the callers
Message-ID: <20240103175043.GS50406@nvidia.com>
References: <20231020113918.GD3952@nvidia.com>
 <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
 <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
 <ZX7xu8jN/rBZ4A/d@nvidia.com>
 <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
 <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com>
 <20231227154648.GB50406@nvidia.com>
 <CAKHBV26yjLu-EUoBJT8EL_EbLE5oqLUL-_hwh2YDp2JH1EyAMw@mail.gmail.com>
 <20240102144814.GC50406@nvidia.com>
 <CAKHBV26TD-gzv3dB8VkGSJ9T8rrynPa-DL48s_VzfF1xb7xQjA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV26TD-gzv3dB8VkGSJ9T8rrynPa-DL48s_VzfF1xb7xQjA@mail.gmail.com>
X-ClientProxiedBy: BLAPR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:36e::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a86e1b-6a9e-4b33-ae5f-08dc0c8482a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oNpWDRJ40bLbgSsoGM6VitwuB560RrRxZu+JQ/GIZx6bcCBahoZIW9J4kh44MG/VpvG9zdYmU1n1vL4Io3abiJKQoLjsd29ip0G9XnapvHkwHZ8WdoWKJqJX2lOQWcfIK6udo3a6raz0o1USxF8TzOZotRpQy0B/FUw3zqlERPzx0v5dqaWWbDSRsxILBbGoFk4+AXcIHjCjlwkM6xFN7p/MobMszyCIAPn9CoB/a7WrENrp9+XiQvL6exbdqFEIAInmU2zF12QBXI3qblPnLyStvm3UELKSZqZWqIjfSlDa7OGScosm7L0btq8NM6evRmse2y20eBkfU4XCoUhcL/wXuU/MlL8iLyV65WS/MSgR88SLrLqaPAZG78Oa+jpC/vJdwX4oSCrOLEhZyE9B+WbB+Ogz+EFG3pZEp7owWWHlkmm45L1R9IXXxRkmQ8/2txNsrPttKukFkWDUxkj72R7v0gknbz/Sr92n0dial8Pz8YpgWQjw7RCVG7tKFWSLm/9AUDId9nUyPEvtL0kmcnOcg5Gh7bWpfcl0PmgoqTvz5jWa4hC3RTiUVfrvMmMz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(5660300002)(36756003)(41300700001)(86362001)(33656002)(83380400001)(478600001)(6486002)(6916009)(54906003)(316002)(66476007)(66946007)(66556008)(6506007)(6512007)(107886003)(2616005)(1076003)(26005)(38100700002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kqthrr/eCSqNEENdX8A6bnFfCSQNw8GuzQCAkRUg1gDYSvtayUddaSRJtwFF?=
 =?us-ascii?Q?itYxAqZ6lq5P7nIQqnUGNkB9uvAfDlwEJOv8CezGzDvRzqG9QyBcbrY9LJtd?=
 =?us-ascii?Q?ZiQi5tqs0GYnJ4n5ZYGZfIXJPCf/h0z/D/hbPp7/opkPUMFoFDXi3yuYILup?=
 =?us-ascii?Q?3T+m9BOta9sRPWYosDwWnNz1+BMaN+pD1/XeNk6XUr1FpRf2q9HqvAMMknBh?=
 =?us-ascii?Q?S9p76OWg5g+4UPlr7gkHo4R+zkK+Mxinn6K88tyNdamLAdjG1qbF6Q4q0YYb?=
 =?us-ascii?Q?rSgcdJawezpXLiHr+TgSckDivi5cc2hxKTDNyzfmPp/v8O+sCIgJaH4MBXU8?=
 =?us-ascii?Q?WJ61LcS2inZSmgOqOq9Bpzk2V0kMKp6j+tnMxwizeEGJhzhu6K3QoUv92gyL?=
 =?us-ascii?Q?hiUCR2T0cf9Q6hEwF4LrhKbXQZBlwmXNXw+2iiKfrOGGMMr8H7mFJQiSxUpU?=
 =?us-ascii?Q?KbATSCrIH3PlsvHVXs5zwmlbcZnEnYuZ7Mg8kKi+3nMUOlF3Ps5ggMEN3y5J?=
 =?us-ascii?Q?dnkpomVkz+MgkQcCkPIhTu9KV3/gnIU3zFL86JEQl1Ixfg/MyCJ9La/K/p4h?=
 =?us-ascii?Q?pq8SY7/9OSCev+1qa0iGwLi2ICt76fgNBSz3vhGokkclU2XyIraUyXh6yK0H?=
 =?us-ascii?Q?ljfv4g2mAfPWBYljPm2QnkfYj5fsviFiaZ/a4ZaxwFvRiDnatK+ai58E8xvo?=
 =?us-ascii?Q?+xrxnO+zMBcOShIeox53SEjPb1mFaIk3rD+z652gGxAR+8Obq2V13dykzOrI?=
 =?us-ascii?Q?xK1OOsO6zxWK4+o5+REyRGvxyGr826yP3LT69KUGXG0WmyppH9wZ2mehvbLr?=
 =?us-ascii?Q?Ih16lxKGBwtOOjDxZV9sF5ZzpIkzzit6EQTd/NaSa6Yush5/pLBhYlx8tjI0?=
 =?us-ascii?Q?Gwwj8VVrNaKplLo10Tf+qCq43BQIukfC6Sk3g0/56L9Uy/SVfkmufakJWBNm?=
 =?us-ascii?Q?jLXVHac2tX2obWbWTntakDz2JQJuLVIJby1r7G89hVJvnpxj+DCXV85wbqk9?=
 =?us-ascii?Q?a3Rq8hgfNrqgVe87Zdw4PP6KNQgwQxxWWhbBBC1ja+Ga3vupkWq+JTYpUWP1?=
 =?us-ascii?Q?XtpBpTSUK1+Pdmut8LoxdCT8JeBOBMrcTcuDaF3FNAuC41ieVbMM0ZXoCCkK?=
 =?us-ascii?Q?zpzMX9UEXWqEtr3UeYesgoUzR3FwORUDLnr4mV5KCiN+b5Go57P/260yQwUS?=
 =?us-ascii?Q?j+lIqkKEfufjgaZb0Ed3+g7ICugu6w5Gkov5NiQ1QPueLQoexVrQRZOYSARa?=
 =?us-ascii?Q?WPfTPpPSZRdQGhtZCxDIIrDKghUXkDfyJb11Yh1mkY8L5WSRKXrQl0o1BTfS?=
 =?us-ascii?Q?njqFpNqCvHg6U2WtXg3jk/b4zrp8CJ+z/bqQmi+iFyP+AJZkJKmJoQVbz6ok?=
 =?us-ascii?Q?YRMGUUUl+UxE1En2s93s1H0vNm1aX5MaTsn2SfC18BOs6liLFdj09Dq6cJ0N?=
 =?us-ascii?Q?D1KgpD+xalgOv1G3r2OeMk5LxNW8hAKrRYE/sBNNIRYHCq2//iYLTEhXEO8Y?=
 =?us-ascii?Q?yFC8K3dYS8i8NXiCaP67C07mu2hyrxFj1bMbsszlcNEocQzKumrCJy+iX9ex?=
 =?us-ascii?Q?iXQYKHf3K50Rzi3GKyPStFq1RsZY7YCsdlrvv3sJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a86e1b-6a9e-4b33-ae5f-08dc0c8482a8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 17:50:44.8835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7X2MInnQHTzr3Sh2oe2ByR8cBdeKKvG+y964H0gErYtgyyiqFgeZL0gYNiBEpRq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5194

On Thu, Jan 04, 2024 at 12:52:48AM +0800, Michael Shavit wrote:
> > > And then this branch is the case where you can directly switch to the
> > > entry without first setting unused bits.
> >
> > Don't make that a special case, just always set the unused bits. All
> > the setting functions should skip the sync if they didn't change the
> > entry, so we don't need to care if we call them needlessly.
> >
> > There are only three programming sequences.
> 
> The different cases (ignoring clean-up) from simplest to least are:
> 1. No change because the STE is already equal to the target.
> 2. Directly writing critical word because that's the only difference.
> 3. Setting unused bits then writing critical word.
> 4. Installing breaking STE, write other words, write critical word.

Right

> Case 2. could potentially be collapsed into 3. if the routine that
> sets unused bits skips over the critical word, so that it's a nop when
> the only change is on that critical word.

Right

> > entry_qwords_used_diff should reflect required changes after setting
> > the unused bits.
> 
> Ohhhhhhh, I see. Your suggestion is essentially to move this block
> into the first call to get_used_qword_diff_indexes:
> > > > > +               /*
> > > > > +                * Compute a staging entry that has all the bits currently
> > > > > +                * unused by HW set to their target values, such that comitting
> > > > > +                * it to the entry table woudn't disrupt the hardware.
> > > > > +                */
> > > > > +               memcpy(staging_entry, cur, writer->entry_length);
> > > > > +               writer->ops.set_unused_bits(staging_entry, target);
> > > > > +
> > > > > +               entry_qwords_used_diff =
> > > > > +                       writer->ops.get_used_qword_diff_indexes(staging_entry,
> > > > > +                                                               target);
> 
> Such that:
> if (hweight8(entry_qwords_used_diff) > 1) => non hitless
> if (hweight8(entry_qwords_used_diff) > 0) => hitless, potentially by
> first setting some unused bits in non-critical qwords.

Yes, sorry it was unclear. Here is the full thing for what I mean:

struct arm_smmu_entry_writer_ops {
	unsigned int num_entry_qwords;
	__le64 v_bit;
	void (*get_used)(const __le64 *entry, __le64 *used);
	void (*sync)(void);
};

enum {
	NUM_ENTRY_QWORDS =
		((sizeof(struct arm_smmu_ste) > sizeof(struct arm_smmu_cd)) ?
			 sizeof(struct arm_smmu_ste) :
			 sizeof(struct arm_smmu_cd)) /
		sizeof(u64)
};

static bool entry_set(const struct arm_smmu_entry_writer_ops *ops,
		      __le64 *entry, const __le64 *target, unsigned int start,
		      unsigned int len)
{
	bool changed = false;

	entry = entry + start;
	target = target + start;
	for (; len != 0; len--, target++, start++) {
		if (*entry != *target) {
			WRITE_ONCE(*entry, *target);
			changed = true;
		}
	}

	if (changed)
		ops->sync();
	return changed;
}

/*
 * Figure out if we can do a hitless update of entry to become target. Returns a
 * bit mask where 1 indicates that qword needs to be set disruptively.
 * unused_update is an intermediate value of entry that has unused bits set to
 * their new values.
 */
static u8 compute_qword_diff(const struct arm_smmu_entry_writer_ops *ops,
			     const __le64 *entry, const __le64 *target,
			     __le64 *unused_update)
{
	__le64 target_used[NUM_ENTRY_QWORDS];
	__le64 cur_used[NUM_ENTRY_QWORDS];
	u8 used_qword_diff = 0;
	unsigned int i;

	ops->get_used(entry, cur_used);
	ops->get_used(target, target_used);

	for (i = 0; i != ops->num_entry_qwords; i++) {
		/*
		 * Masks are up to date, the make functions are not allowed to
		 * set a bit to 1 if the used function doesn't say it is used.
		 */
		WARN_ON_ONCE(target[i] & ~target_used[i]);

		/* Bits can change because they are not currently being used */
		unused_update[i] = (entry[i] & cur_used[i]) |
				   (target[i] & ~cur_used[i]);
		/*
		 * Each bit indicates that a used bit in a qword needs to be
		 * changed after unused_update is applied.
		 */
		if ((unused_update[i] & target_used[i]) !=
		    (target[i] & target_used[i]))
			used_qword_diff |= 1 << i;
	}
	return used_qword_diff;
}

static void arm_smmu_write_entry(const struct arm_smmu_entry_writer_ops *ops,
				 __le64 *entry, const __le64 *target)
{
	__le64 unused_update[NUM_ENTRY_QWORDS];
	u8 used_qword_diff;

	used_qword_diff = compute_qword_diff(ops, entry, target, unused_update);
	if (hweight8(used_qword_diff) > 1) {
		/*
		 * At least two qwords need their used bits to be changed. This
		 * requires a breaking update, zero the V bit, write all qwords
		 * but 0, then set qword 0
		 */
		unused_update[0] = entry[0] & (~ops->v_bit);
		entry_set(ops, entry, unused_update, 0, 1);
		entry_set(ops, entry, target, 1, ops->num_entry_qwords);
		entry_set(ops, entry, target, 0, 1);
	} else if (hweight8(used_qword_diff) == 1) {
		/*
		 * Only one qword needs its used bits to be changed. This is a
		 * hitless update, update all bits the current STE is ignoring
		 * to their new values, then update a single qword to change the
		 * STE and finally 0 and unused bits.
		 */
		entry_set(ops, entry, unused_update, 0, ops->num_entry_qwords);
		entry_set(ops, entry, target, ffs(used_qword_diff) - 1, 1);
		entry_set(ops, entry, target, 0, ops->num_entry_qwords);
	} else {
		/*
		 * If everything is working properly this shouldn't do anything
		 * as unused bits should always be 0 and thus
		 * can't change.
		 */
		WARN_ON_ONCE(entry_set(ops, entry, target, 0,
				       ops->num_entry_qwords));
	}
}

I'm fine with this, if you think it is better please sort out the rest
of the bits and send me a diff and I'll integrate it

Thanks,
Jason
