Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D02AF03
	for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T3W6ijOK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUuxuYKYuvPfGCUqlE7uTVOJavpsJG0q0yep4WPMCd9c3tY05+JDg7+LU5kk8IsaQmIoJ/UimBIaEovKtXSvl19YBxeTYs6+7ELvKpoY9rtvtkUvJk2B0WxyBgYlDo5m2V1VUrrrYzW85Uex5DQfn4LzqvlEKD36o62Hx9XLxb7pnFwi37TOyir1wyDB7HhH/v5QFSXCBNBSGawHNbLbhSCfEZbDAQlVCR5jTPWdY3i8J3kqjKgPjTyVL+y5Fe9xJXPqJ7rRviHk6AeLPI/2dHScW54EniEFFRBIP/kGOL2JOpZlNpZ2FjMHQjVdwivkveFn80mmXOHyWVWgMUkAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqHoztN9CvDB7FgInh9galK73GUqZgqADUAJHZavhe4=;
 b=V0XjiChWsAOBZDnCHqZhP/5My4XsDa2Ovtj9wr0LdbesWBqc23iT2aJ/6L/0YqCbeuKrHOO+FLdJG77u+fuZGq6XiG7Wo2hIn5FaGFHNmDkcQhV37Z/iVqW7ZQicx5/2/udYwX02v5VkLH9HY/adLGHuw95Np4S7CcDtBKgCO0blflml6XmMqBpattScLN1cAsLvSTcGqOU9isIc/7ekkLR/ZjXWONg9hFDoNIXMuX8D94oXI/NfuVYCmBnTBOY5xTH/6oTMbCzAhWYtM+qfmxpwFyOzUTHm0OH/sDJXyETRSnnDCcz3tJvmFBmg5ODflyJCbE48TlIgAM8+PlttQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqHoztN9CvDB7FgInh9galK73GUqZgqADUAJHZavhe4=;
 b=T3W6ijOK9LQHOlYwrpy68DOa6/SsOFF0fnmxucyFahxjS8+r425Wz9NPp903ahsccox2rG6DVbUvDqFPwNJ0NZsjft0r3yaeJ/ZYWrzHSWBnlmlEObelkWu1yzH7XDvv8JXbM48EorUelEyTzwU/jGJ1WnSBy69UECzc3YAKAJaVHv1IT4Dsz+gRJJTcs3zXXD9MfQxST4irQ7oq2HbSJq9BB8kupWrEWduAmqNR7lpBsr+6VpW6/ZEGXcbF06cp2bYeNqpnAho4MoVCyfToXJW6XVIQT3tbSuCuqfLgoKW95F5jWAFI7jFe0w/gzaLMrmz3ypUYRB8VUyXC1dtU8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 16:27:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 16:27:48 +0000
Date: Tue, 14 Nov 2023 12:27:48 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Rob Clark <robdclark@gmail.com>,
	Gaurav Kohli <quic_gkohli@quicinc.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] iommu: Allow passing custom allocators to pgtable
 drivers
Message-ID: <ZVOgBBEetWf1PFxX@nvidia.com>
References: <20231110094352.565347-1-boris.brezillon@collabora.com>
 <20231110151428.GJ4634@ziepe.ca>
 <20231110164809.270f82bc@collabora.com>
 <20231110161229.GA462657@nvidia.com>
 <20231110201652.629b7228@collabora.com>
 <20231110194215.GR4488@nvidia.com>
 <20231113101103.1cc05c8c@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113101103.1cc05c8c@collabora.com>
X-ClientProxiedBy: BL1PR13CA0423.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ca780b-8bed-4d0b-2466-08dbe52ea41c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TTO8x2Bv4hLt2t9rZr+VJjeGlPR0hc6syULN0WLvhSHOaAfoeXhyknoLP6ktocLj3sY6mZfp72j59+novOiMtRjkthaUw++imj+8vOeTGgSb4NM04poFTu3PvcwopR4W4fADGJc/QuVkUObvkyuGsFNog8u3Xq9ydFYx59FMWudhKzxJLbWbIAnLTGdRgS1gZl2vlBXImx5Kq0RP33sLqBseqkxPcwuUOrNwJs3Npz6K/1M/2Rn1aiLq391S+A3KUxLuSxvH4gRjUDlYoR121YWOjSq5qkKVVVt5Usn1d/w8MaRk/JXX3SZ7kuz36xTcS9umi1peErEY3ixRUecsuvOiPqscgMouC5GCY1UoFQvCPSOOmgyoy6FuOvvBcaz2Gp3NVT9zw8jD3s+J4AsrZ6suTiaZFMeBMaLrpAbNIAx+jH6Bb1f2f/ez3ZgC8h68d28fKDqBbW/HSnoIUXQoVgjlQNrIc6fDmcHCZtiduRoYNTwBOs7szFfMG2cMItT9/QjbAP09X2/pWmYY03Kkt8+KigUu+lx7daVUv/O3DTxfPEArParPzK3yPrET5kUw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66899024)(38100700002)(41300700001)(6486002)(86362001)(36756003)(66946007)(316002)(6916009)(54906003)(66476007)(66556008)(478600001)(2616005)(5660300002)(2906002)(26005)(6512007)(6506007)(8936002)(8676002)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y1hVT8L5cvoSvKnFxyPi9RYwiGwqD3X2kezky9S9ihfHuooOlkT2frpSxMNy?=
 =?us-ascii?Q?WOFWbIUtxzBq2a/jGO2oQcbvOGx+cD2cZin5cyei/LF4bc8jQ0g0/NM2BsLG?=
 =?us-ascii?Q?47C8IiEitAhDzbBsWUI/tuA2ZDltWqTf+WnZnZn4Be34+BaIWF+PS2Y9jKJK?=
 =?us-ascii?Q?PoLeVsd10aHaJJ6rwM2QmO0oGia0I+NF+q0aSvL9CYtrGUoLovwcLoIREgTm?=
 =?us-ascii?Q?Y7yyqgeEV7rq8t2bJYLDpe72UC46c1ZXZfviW00nrETUmkkKI1/PLZKoWKUl?=
 =?us-ascii?Q?Xik61nnspXSjyTbr23m/aE8O9dS9m9vHF8htzQhV9RulBntOWialOyr6L1wK?=
 =?us-ascii?Q?OnbyBk/+/DJ3dcgpcp9YscZ9WQdKzTlDOUZclY5avbfbrqP52kRh8vUCw8Nr?=
 =?us-ascii?Q?We4EMqyJ+gc8eTsU4y+G+kS+46TWSDtLvNmUv7J2C2xjhlptXYj2pWHmN7Vl?=
 =?us-ascii?Q?vyNSFPKfm0JsjUgyC2Xy7zRlnf30GH1W+orJE/VaKOhJMcH5hVAL1oT7abHc?=
 =?us-ascii?Q?NbxBDfAN7ZLJVXH8qaf7kb5bKIFr1VeQSuqHY00WUnXxjpjXmhtfxmXCwjod?=
 =?us-ascii?Q?8tCEySQeS/Eei7eRSQb1hImiveJGETIXs14nx0Xx4aAUF6sHG+qdXsLZ9mof?=
 =?us-ascii?Q?Min+WLOxIXCTYDV+qs1894MclXoUHM/lkxfnbmIpdkA89eAptPn5N+e/o9Ey?=
 =?us-ascii?Q?VxbiNjIdJ3I8kaVPZKMCYcKJ6Cm+safNibml0fdSnNCNw/CQHNp2N91vYHxh?=
 =?us-ascii?Q?8oYZFEHaaUn+b8KSu3MEtxEoTAYscWMsiZXw7Qehcfp8qjKdAfVByePu8zCV?=
 =?us-ascii?Q?DWCnMznfOYTQSyxEoUvfJVloyzoTj2tgLp/wTMV3F8BWzqUc8zDSQ8U+r8Yj?=
 =?us-ascii?Q?ryPgrWhvo/Az5ON48tNs20GtlM/QynkvWiAAkLdMYH3u9KVU/sWv+ZKa0U8m?=
 =?us-ascii?Q?037Lp43TbQf1FgKfX/+5Z187pbWxxZ1rv3kfrIJhrFADbKKvVVBgfL+ULwa+?=
 =?us-ascii?Q?gw6QGmTzqc69vfeIoMjtQbrqZXrNb9XckIA5tpml8Z4VqlymvFJhzQcKuePL?=
 =?us-ascii?Q?Pu0Y9Xh2ndYXKlBL0CuyW6tKwP/WrKs2a/tPi4hAiR0irPrU3U7IleYlv9IE?=
 =?us-ascii?Q?W8Y2r4LJwu7c8oqD45DF71/ZEivF99kmILUoV2QUQMQ2OorMGeprQP7AZpj4?=
 =?us-ascii?Q?F34Fq8TqTN3khxrnb7cCiu5UVQKzYaZe9YXZ3uKzzAiIsRwoPWNWrHtZAt/c?=
 =?us-ascii?Q?+oMcCh+udgcQFDji6NoQ4mreiC7mKurkAmYzNr2a4fC9gY9KrtFocMcXZOTR?=
 =?us-ascii?Q?LEKa4GSx8k5G703XghydArdHGBxl9mSigs6HnOh4qEGZ6ohupyyx7hoMYR4S?=
 =?us-ascii?Q?gZ2gSp0rHlVkr9IH6a4ZrF8RcmqiSLl2RJhShGhoeD/vpBHdXnbdqaJGsTEw?=
 =?us-ascii?Q?rUYb9kYf8B0Acseo8QEWxJ6qe2jy0ELDbc78ydqDCm8EsMZ6wZ/j397vbycX?=
 =?us-ascii?Q?XSs9P9ym6t/VoxJDEqdejh9pmTg/icQq5rX2l8P94Ulfp8OOzdfuK+w+ZwiI?=
 =?us-ascii?Q?bSNvSjcgPWq+bbIjqoc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ca780b-8bed-4d0b-2466-08dbe52ea41c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 16:27:48.9479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RO8WbOkm+Ih3ZAu+T5YLn5v2qfDBVZugN7ao7Hb6QYMSMqthfynLhtdKT2ZfqfpL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449

On Mon, Nov 13, 2023 at 10:11:03AM +0100, Boris Brezillon wrote:

> > The IOVA allocation would pin down
> > all the radix tree memory so that that any map in the preallocated
> > IOVA range cannot fail.
> 
> Question is, when would you do the IOVA range allocation? So far, I was
> assuming that every BIND request was a combination of:
> 
> 1/ Pre-allocate enough resources for this specific map/unmap to always
> succeed
> 
> 2/ Execute this BIND operation when time comes
> 
> IIUC, you're suggesting doing things differently:
> 
> 1/ Reserve/pre-allocate the IOVA range for your higher-level
> entity/object (through an explicit ioctl, I guess)
> 
> 2/ BIND requests just map/unmap stuff in this pre-allocated/reserved
> IOVA range. All page tables have been allocated during #1, so there's
> no allocation happening here.
> 
> 3/ When your higher level object is destroyed, release the IOVA range,
> which, as a result, unmaps everything in that range, and frees up the
> IOMMU page tables (and any other resources attached to this IOVA range).

I don't really know anything about vulkan so I can't really comment to
well, but it seems to me what you outline makes sense, but also you
could make #1 allocate the IOVA as part of the preallocation??
 
> > > > Now you can be guarenteed that future map in that VA range will be
> > > > fully non-allocating, and future unmap will be fully non-freeing.  
> > > 
> > > You mean fully non-freeing if there are no known remaining users to
> > > come, right?  
> > 
> > unmap of allocated IOVA would be non-freeing. Free would happen on
> > allocate
> 
> Does that mean resources stay around until someone else tries to
> allocate an IOVA range overlapping this previously existing IOVA
> range? With your IOVA range solution, I'd expect resources to be
> released when the IOVA range is released/destroyed.

Sorry, I mistyped deallocate. Yes when the iova is deallocated then
the pinned down radix leaves could become freed. It would be a logical
time to do the freeing.

> > My experience with GPU land is these hacky temporary things become
> > permanent and then a total pain for everyone else :( By the time
> > someone comes to fix it you will be gone and nobody will be willing to
> > help do changes to the GPU driver.
> 
> Hm, that doesn't match my recent experience with DRM drivers, where
> internal DRM APIs get changed pretty regularly, and reviewed by DRM
> driver maintainers in a timely manner...

If the DRM maintainers push it then it happens :) Ask Robin about
his iommu_present() removal

> Anyway, given you already thought it through, can I ask you to provide
> a preliminary implementation for this IOVA range mechanism so I can
> play with it and adjust panthor accordingly. And if you don't have the
> time, can you at least give me extra details about the implementation
> you had in mind, so I don't have to guess and come back with something
> that's not matching what you had in mind.

Oh, I don't know if I can manage patches in any reasonable time frame,
though I think it is pretty straightforward really:

 - Patch to introduce some 'struct iopte_page' (see struct slab)
 - Adjust io pagetable implementations to consume it
 - Do RCU freeing of iopte_page
 - Add a reserve/unreserve io page table ops
 - Implement reserve/unresereve in arm by manipulating a new refcount
   in iopte_page. Rely on RCU to protect the derefs
 - Modify iommufd to call reserve/unreserve around areas attachment
   to have an intree user.

Some of this is a bit interesting, like reserving probably will
ideally want to invoke the batch allocator for efficiency which means
computing the number of radix levels required to fully populate the
current empty level - that should be general code somehow

Jason
