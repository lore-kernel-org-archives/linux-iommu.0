Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F5A15ADB
	for <iommu@lists.linux.dev>; Fri, 12 Jan 2024 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qsy8GlkO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7Uu8RaX4JIO0/mwWVZ3o3GzSooDCqlYrWyE5khAjmxz4S1i52LJOSQ5ccuBbwd5nNdVyb3CkGCKKNGpzPPpzHjlcgfPLGp3hXFk3QkSy6Oz9F5FtJ9Pb6bx/S31KGSmp7wK2B1Cgl2bJwDXMYVxQ+/tMdFc5sMy14ROPp95ovYa3E3qdYX+ZyPm4wzzv72BiY39fID3S5c95OrMe9iectBz7knXxOyYi8cX6JYJSpFfv/O4qWHsIaNAGpFJjvUKp9/BCgBv4RmKRjBBD0r9t0t3PWtvrW8bNf7IZN2spIRaOgSOTXkbnQVa6RG9nwZ3wrWllZr4TBbbiqqWtwuFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qSkOJARtG2jkF0HMWMsTaEYvw8wKFw3Bk6F681Udqs=;
 b=ehscSxhq6qJay8C9r5bD7rewLxbU2C2oNrSl0HskhZNwMKm3Qqc9QPVku1i9GimRgniRrnTtv4Gy9rU9vDBC4FYSf8XQ5NaCTRjegE5ktAvqLK/FE5s+brYgq5BY4uxc4xbq63eIL5pbSJKaka4jfypCvoglutcpoNZMwWjR3C8wZVSl0v9kyMU+SQ9vVTz5ew+L3wVbSCMoBrCE4kPPG0AQf0nEl7sEXCerXXxA+C6O+2tQTpPMwxUQVi3EACKAo9TOmAVrdnshY5ukURXeumZF9x2zPclFXb5BzI7dqtmHcbOoSJj8EE5H8dv0y60ShCZiFL6MNMaUNvq87v55TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qSkOJARtG2jkF0HMWMsTaEYvw8wKFw3Bk6F681Udqs=;
 b=Qsy8GlkOKyF4c6jL8SEijhGqEhsD4qJX+ru9xPcnBedD/bmB3aD2RZOSgjuJkq0SPPPWgD51F9ECJTd2/4fVUSed+sR6N2qD4WYTAFw90Ss/9/WX+Pa8IVSK60hPv3QsJ67q7fXZQwdC98uG8H9ynYLM5KjwuERTrlagQrfnbbGGZiKDoe3/8+Vw+/oK9ESuGuhhjw4CdIJZNiXDcefhmaJPh4zApV6D8Y/NBZUyU6DK3nPWKMQDclm0hNqWYfPnTW6Uo/9LqNjyMnd3GCzqbpImxDnR0ZI3nKAkhzEeKfkuj15kh0WdZ3pMxvqcS+3O/7ofsubDnub63wgXh82y+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 19:45:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 19:45:53 +0000
Date: Fri, 12 Jan 2024 15:45:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming
 independent of the callers
Message-ID: <20240112194552.GD734935@nvidia.com>
References: <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
 <ZX7xu8jN/rBZ4A/d@nvidia.com>
 <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
 <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com>
 <20231227154648.GB50406@nvidia.com>
 <CAKHBV26yjLu-EUoBJT8EL_EbLE5oqLUL-_hwh2YDp2JH1EyAMw@mail.gmail.com>
 <20240102144814.GC50406@nvidia.com>
 <CAKHBV26TD-gzv3dB8VkGSJ9T8rrynPa-DL48s_VzfF1xb7xQjA@mail.gmail.com>
 <20240103175043.GS50406@nvidia.com>
 <CAKHBV27FxaSsm7nPPR9RLSfVQy6X-b63ZN-Fg88iyStkJw+uHg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV27FxaSsm7nPPR9RLSfVQy6X-b63ZN-Fg88iyStkJw+uHg@mail.gmail.com>
X-ClientProxiedBy: DM6PR02CA0155.namprd02.prod.outlook.com
 (2603:10b6:5:332::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: a7eb3d32-65f1-4bb5-370d-08dc13a71671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Lqsc4TXappc4I8nAls1jLBnulUn+KuzhFoq8/0YAS8JhmrULxiWsB/3CkiwTWsm9YahlWE6xqiOEK/sylzRTMlWTHJROO91A3Rwf6nAYI7LVBJum/LdRgIuBAREieQ2nF01qXqRhuzroI9MRbWaE+eGDhoXOC2CmmSIItV4//+BPgX+Ap/xYdOG5+JMGZ4Q9zu5K/8nsLQnCoPkyajKdf+bsYJ5Lnoq7IQJUJSGye+XehxnF9ow8bJ5L2d+RA148v2ynzc1VGMln8jELIBBaOqH6fibDSwBe174oCkD8uAbyssxtGGQ27g2LHH6LLbO/4YcvaB1JTzeNaDxFTJwmcwAxAJx8g69jk0PHny14hIx3NYLZeYugQF7PaI/+daTzfGQY8zFoieBVLxJguuRe1aoMUGLVqxRsXWLDnC9JKNehjjue4cXkAOJObeh+jl6QiVSs3DQLHtysFT3VK3tUwh4/9IrvuhaS0lFt97NvY60fsyoP5jvx8KIvvxcLBLK2SfXgSnM8Vtgw8GowflrfC+jRKzi2t2Or14aYdoDsH5LheauVmGrJlTk0tkEGA6By4c4kOmy/2caGMRT2pprJi/a97KCCaab14LrksvjB/WqH9A4pU8zRX6Wbj8Y01LEVxxodMtm/ZYSvdBuTveEtFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(66899024)(83380400001)(26005)(41300700001)(66946007)(33656002)(36756003)(86362001)(107886003)(6506007)(38100700002)(316002)(54906003)(6512007)(2616005)(8676002)(2906002)(6486002)(66556008)(966005)(6916009)(66476007)(478600001)(8936002)(1076003)(4326008)(5660300002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UOBTevgFx/e0Lbo+7b7WT2naNiSAoAvT3F7wWvINVIBn8RK1S6iXm/oXoZxL?=
 =?us-ascii?Q?u1Slj7PEazwsurZduecVg5OmWc35SuoCkaLl+h0W8O3MZkyf8MDiImc1wUnu?=
 =?us-ascii?Q?Gu9kYe2ETabEyVzrZMc1Rts1AgGILh5v8q7hTwKZL33KxEDsOc5YrAdvN7bo?=
 =?us-ascii?Q?rJScovvmXfRtsMdGKWFEiK4vOf2roPoX9JKQprtzFANRJ7bxSMkTTi8/ZSmq?=
 =?us-ascii?Q?vVvrWooLBUTLijBsJ2IeDXYg47gnds5q854fhsnND5RLYeP2DYvH39XvauCw?=
 =?us-ascii?Q?kxLdorZqvSv/qnCCnXXRX5LVmPO08vLrOeEjvfZA+0lQ1vKmFaxoSilROeA1?=
 =?us-ascii?Q?ZHJGrWLVtpQh3+uKfXromVb8OayBPYPZM3nFkkHB7FUjaV2LI+5Fu8OrPWpo?=
 =?us-ascii?Q?d7qMc7BTv/PmkA0ROwOa8IJCXyXv65ET6dKL08Q57BALtOBbamjXRcb3hD0E?=
 =?us-ascii?Q?jGy64x7XRDbft/XE9FUIk/yzBtQ7Rmmanfj8pBR37dxvvAQH+jc3GnDlbKY4?=
 =?us-ascii?Q?Mb9OEwA4jQh6uXrtGhtej+WV6ZlFnr3gR1tetVy/z46aNDqUVhHh9KKy9Grx?=
 =?us-ascii?Q?Lv2H4oMfYQ1I/TNlTXtV9ALglXdrSaA06eh3u6ST0O2+Z/judfeH+iYovML+?=
 =?us-ascii?Q?dh/LHqYBN2E3gzFVdyemZqkS0HXARWq+Hjvy71FVw2Saws+XjQ/gNrYbx7al?=
 =?us-ascii?Q?ghx7VThRI7Hm/aw02lpeoajCmFejXPKtHNNKZ4yL9s1aZqGoQU8F9BIhrFBa?=
 =?us-ascii?Q?3tdjl7Uxoge+AakcyQN03jmAvan5dkWEO60xTyWkb6sw0PXNCIBH9gBdZhzV?=
 =?us-ascii?Q?8bZblgGLh+LYCoWYhD7ONkzonTM0RfgJRpLUfR1BLoVsCS2o4Q53Bd8ZWb66?=
 =?us-ascii?Q?M20nRPClD/MfmKCw//YOlyr85bUS2rNHkyV5ur+QPiOGLIpEWXB4mOxl3d6C?=
 =?us-ascii?Q?Inf0HyZwYZKu5BXP5Ozn2ORkS2zUkhQxPfidWV2erFaSyBuH8A8NKlONUPr4?=
 =?us-ascii?Q?721jcJg/zmS0/5ph77IbOWj/Yk3ybBgc5Sej6kg1D8Uv9UeocBwj9Yk9qBCI?=
 =?us-ascii?Q?eN+STa6j4D/Ifmo1yzaVQlNjrhpqjgToyyXUeaKtTYB3uZHVJ4Wao6Vq4u5H?=
 =?us-ascii?Q?ZBPvzn2Tkk8PC/yrnvBHTe4UiPewneC8pNSOeiX07LeNDZYBK9y72NFoRn16?=
 =?us-ascii?Q?O9GV7fDHvlbZfGdpcJ1A4sRkwRlznBe2vwLWUZryLv0Ix3qND7adY5fC14Qf?=
 =?us-ascii?Q?4a4tVVO+ewYKzchWFJyFEKqLA6uP45a8+yNw0n8FEVxboKdqaYNfc49ILxIU?=
 =?us-ascii?Q?aK1ga14BC54pJ8/zUURQx4hfHpWp8Iq9K6/pF1lxYQ0RIHAiEhzyFaFj6YFy?=
 =?us-ascii?Q?e8pB2k+YhjLrSFX8CUBedzska3Tp3GY+S6/qVH3CW1vLtUSjLj9qlBW4eNS2?=
 =?us-ascii?Q?EMVOU4EedNGFfANeEOVdiEyJX+COBj+/GW0/i2h0xP08xDlJ7bg6J7y9kHJ2?=
 =?us-ascii?Q?KDRrxa6IjGlRo6d60Zcob0SFRqYDjNg+dziXT+2TouhRDL1rQanK8lQu3ndK?=
 =?us-ascii?Q?xEZoDS0uDRtrLaAso9cu9nuUtTr2SU1HC/Q5zjs/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7eb3d32-65f1-4bb5-370d-08dc13a71671
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 19:45:53.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4w+AjMGwYp6NTLD81BkRSwN4oUmTXoaXbDc5TbtEHT8eMlKe2avLOn3slAUBqC5O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907

On Sat, Jan 06, 2024 at 04:50:48PM +0800, Michael Shavit wrote:
> > I'm fine with this, if you think it is better please sort out the rest
> > of the bits and send me a diff and I'll integrate it
> >
> > Thanks,
> > Jason
> 
> Integrated and re-sent the 3 relevant patches; although git-send-email
> gave two of them a different subject so they may appear as a different
> thread depending on your email client.
> 
> Please note that I didn't update the commit description on the two
> patches that you initially wrote. Also note that the Kunit test patch
> does not yet add tests for any CD updates (outside of generic logic
> which is shared with STE update). I'm on vacation for the next week
> and haven't had a chance to expand the test coverage.

Okay, I took care of it all and got the branch rebased onto something
closer to what v6.8-rc1 will look like. I made a bunch of cosmetic
changes and checked the unit test still works. I'll post the three
parts to the list when v6.8-rc1 comes out in a weeks time.

The update is on my github:

https://github.com/jgunthorpe/linux/commits/smmuv3_newapi/

Here is the rewritten commit message:

iommu/arm-smmu-v3: Make STE programming independent of the callers

As the comment in arm_smmu_write_strtab_ent() explains, this routine has
been limited to only work correctly in certain scenarios that the caller
must ensure. Generally the caller must put the STE into ABORT or BYPASS
before attempting to program it to something else.

The iommu core APIs would ideally expect the driver to do a hitless change
of iommu_domain in a number of cases:

 - RESV_DIRECT support wants IDENTITY -> DMA -> IDENTITY to be hitless
   for the RESV ranges

 - PASID upgrade has IDENTIY on the RID with no PASID then a PASID paging
   domain installed. The RID should not be impacted

 - PASID downgrade has IDENTIY on the RID and all PASID's removed.
   The RID should not be impacted

 - RID does PAGING -> BLOCKING with active PASID, PASID's should not be
   impacted

 - NESTING -> NESTING for carrying all the above hitless cases in a VM
   into the hypervisor. To comprehensively emulate the HW in a VM we should
   assume the VM OS is running logic like this and expecting hitless updates
   to be relayed to real HW.

For CD updates arm_smmu_write_ctx_desc() has a similar comment explaining
how limited it is, and the driver does have a need for hitless CD updates:

 - SMMUv3 BTM S1 ASID re-label

 - SVA mm release should change the CD to answert not-present to all
   requests without allowing logging (EPD0)

The next patches/series are going to start removing some of this logic
from the callers, and add more complex state combinations than currently.
At the end everything that can be hitless will be hitless, including all
of the above.

Introduce arm_smmu_write_entry() which will run through the multi-qword
programming sequence to avoid creating an incoherent 'torn' STE in the HW
caches. It automatically detects which of two algorithms to use:

1) The disruptive V=0 update described in the spec which disrupts the
   entry and does three syncs to make the change:
       - Write V=0 to QWORD 0
       - Write the entire STE except QWORD 0
       - Write QWORD 0

2) A hitless update algorithm that follows the same rational that the driver
   already uses. It is safe to change IGNORED bits that HW doesn't use:
       - Write the target value into all currently unused bits
       - Write a single QWORD, this makes the new STE live atomically
       - Ensure now unused bits are 0

The detection of which path to use and the implementation of the hitless
update rely on a "used bitmask" describing what bits the HW is actually
using based on the V/CFG/etc bits. This flows from the spec language,
typically indicated as IGNORED.

Knowing which bits the HW is using we can update the bits it does not use
and then compute how many QWORDS need to be changed. If only one qword
needs to be updated the hitless algorithm is possible.

Later patches will include CD updates in this mechanism so make the
implementation generic using a struct arm_smmu_entry_writer and struct
arm_smmu_entry_writer_ops to abstract the differences between STE and CD
to be plugged in.

At this point it generates the same sequence of updates as the current
code, except that zeroing the VMID on entry to BYPASS/ABORT will do an
extra sync (this seems to be an existing bug).

Going forward this will use a V=0 transition instead of cycling through
ABORT if a hitfull change is required. This seems more appropriate as ABORT
will fail DMAs without any logging, but dropping a DMA due to transient
V=0 is probably signaling a bug, so the C_BAD_STE is valuable.
