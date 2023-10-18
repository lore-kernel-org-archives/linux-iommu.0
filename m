Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44345171BA
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p2pnKSzq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0KMPUz+P8mrVnTf2ESlHPyICisKZ5bHfmCYGGNUlIYQJ8qg3B+ptZC2VUoeTMPkPb7rkJaG8ltfDBiq+x9Jw+AqbBUmhBWlE0+EFlIEB3Qs8SZ8reDK6P+967PMU6zJ0nhAXz3UKSVWGTT9DJyQPVUY0BHTgAcdL89+ehlU6ashqo/vaiDDQ3OADHi1jR+zKKo5Z8iJ6r1RRuDA2HAZIka0sxSCxIR2BE74mtI9de3/jppDzEfncOgIyS6D39aUVlbnQAjI+zkeIzGJEvEwYtgKPrzm2xuivBP6ugoeylAPp/n2MVdBVBh+5+5k9nfcEqNjmPJUXKxnTajBTGXhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0ug3wEw+RMfBV5Dq23UzJeZ7TMiPT3+pHoQZoG8R+s=;
 b=Yr9zTPc0nUgVKyIPsrxTUyGziCNhhGk/VH1gPvLLSEhREPhcFNrdQfUMerjUxMC2yHmf2KN9chCSdIJLwjT1jC9KFc4nRYJfxt9Ke+uTjb/+Qde5FbV9z4nZAbPXFrO4oy3tj81FL6x1lwqhIzwfkFToBsjGTcNuAF4QZFoCxeAQZ3hhnTxIkFsHWjpAhM1h9/Z91G3gYN+KCSCLuSR9oIMm6j/Fotqaevf34Rj31f1aUw5zYpAqVFbpAHblOljmUB6dGTMXqs1p62kIXiWQXPZ41MYzbNgb9vQHmwgZVWD44mVSmySdqwhKaQjLdxVaFxLF3W4Ym4ViycGcnCBO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0ug3wEw+RMfBV5Dq23UzJeZ7TMiPT3+pHoQZoG8R+s=;
 b=p2pnKSzqDwSjLW3w/Jq2vXXLTzyqXFOqmqIotkIiYbmjzZjmheOPnqe9hO2cGEPIRdMfut31WUO8I9fKRWdSAGyr3p35vUyxd1gTLasl8PXK3OD6Ijg89aLWT8nAUAVVXvkgPd86rRehtziVoEHClbJ92V8+6aElmzLRxT4CRfFiwo6+ysZg7rKlbF/oimGtMrsZplHBqQY544TO8oXS73UN7u2E0fe4DQ16D7ugPlX3m9njdt0pJgAk3vp/pzZmasFtMwWa1fMQDpMgR6LNu+RY9Qedz1ZjHNH/KJzTr2PfbyE+Lo1+FM+R6ifczYyUaGhCMCLatNDPOXmostz2cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB4897.namprd12.prod.outlook.com (2603:10b6:208:17e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 13:04:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 13:04:58 +0000
Date: Wed, 18 Oct 2023 10:04:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming
 independent of the callers
Message-ID: <20231018130455.GU3952@nvidia.com>
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <CAKHBV24UGZuG6+J4cybadJCTyf9hN+e_VgAC0NVOPotmEur7SQ@mail.gmail.com>
 <20231012121616.GF3952@nvidia.com>
 <CAKHBV27G1PLZ5gkYkOOCZdD9waZOZypkWqk4_HSR4XXGFT-+LA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV27G1PLZ5gkYkOOCZdD9waZOZypkWqk4_HSR4XXGFT-+LA@mail.gmail.com>
X-ClientProxiedBy: BY5PR16CA0029.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB4897:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e14f994-dfb9-4c06-a019-08dbcfdad4cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dBR4qwMmCRhbDFLXL254Y6vPTecdLwe69NcCVKbYxQ5HH6JzjB0UPwZ1uap/s2Ai5y3OsshA7DaOYdFeEKg2/xKDehIrq75WFasRGyj+1das5sy8pzjIyZKTkXgAa/EiWnbPJyfVd9Uq8pWTWYzybmLtZ1hLJMsxgjicBY5eNw93cRtwtTsoVLO+MJW56xZO/RnJuseNv9vAogPk3T7E/udjLXm3E4oRGdW4gJensy4N+89oiJUrrdc/h+2olQQBLwwwkzOdS3jIGuEfME/aHQZfisRIGv2QximusLfDx2QCPDL4ICuTOWkCMBh3dI0i7u29VhbhxhMCKBYzwilCP4BjegPgBTkS/eE4ldAkgmW6hemzBLkVulODUzGA1PS1nk4bhO80XINZXgbQwZE64dQDDZmQhOylrnk9xKVjNlbyd/TbSFG+5pKYtax3BoEJf5cCNcLxsod+8oIcfXzJv8vl4rzqzxk2sIUIBXaLQcFtZ/WfWv1WBRwE2UtrKLafqvkyMyaQMPr5slu1zRJK6cQ7E538Cx77uluAREsMe/9SNbdt0XFbFgWKnsH4KHOr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(316002)(478600001)(66946007)(54906003)(6916009)(66476007)(6486002)(6666004)(66556008)(1076003)(86362001)(2616005)(26005)(6506007)(36756003)(6512007)(107886003)(2906002)(4326008)(8936002)(8676002)(41300700001)(33656002)(83380400001)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rw3M7TC/fKi5RTbYQLL1U9BMcwPH3EHFmIY92cTZNBpzlgPXC3s0oLLvqEzG?=
 =?us-ascii?Q?mTn7HbmcM5jWxZBWOOC0FhMusqhNVBsr+rwWYFEXLPyPGANfWmSvKRVDFea1?=
 =?us-ascii?Q?HQplypxSdTWBbVkI75b8H+Ex7YcXUop5NlmYduo49WCgj975tp8uOqBg07st?=
 =?us-ascii?Q?8CRrY3Ku68/dbsBAPXtUctIo391bnUa15x+Pj7KutqlBxJa1S91PClZ85TZB?=
 =?us-ascii?Q?2kfGm4r9NSIg4JuXYXryEPDVHM7JU5UdOUIQ6rvmVyTAd7qDIgQl2r7wcQCn?=
 =?us-ascii?Q?2al2u0krXu27XchJzxaWEOtoLLJ7MgmNodazSkhS61tpa/t9eceqSCoYosyo?=
 =?us-ascii?Q?wvdU3bXGWuaKNqNR8L5ADdVmb5Pgum4/jXwwMR4rv0UrsherQMXAtSC59To2?=
 =?us-ascii?Q?bZm0XS+xAMAlX6vOvk8lDZYue1GaoAAvQKSWUHs5v88l0ThxRD4om6zdMqJh?=
 =?us-ascii?Q?oLEbPpIr6ZDa/ORi8f1+RnryHAjlnSOvg6OOozYUoYfsKGsJ68pvRLR1WkM+?=
 =?us-ascii?Q?Bh0Ss8hVO2zj1g6MccOyBCCsxL7b9HwqKQUbBkwcWE0W0QJDC4atgW4P2skI?=
 =?us-ascii?Q?5VzH+YtO8tSVynkuqPY4Q3phYFSZRCqZNnFQiMIwPHyqi7wN4cbvUMUtgECM?=
 =?us-ascii?Q?48ahubk40MdHOzRSw0TUH5nC4bOHpZcS8il4A246WXJXQvkSjgqGom9k39d/?=
 =?us-ascii?Q?r8VEtRdWOYRBJgDJum0TJJ5QUFSmyhMOFL++26x9Ko0jikNG6y7DoQJhkFwv?=
 =?us-ascii?Q?XoAIeHbmmKzfJiby3w89Zk4f7YOSgdnB5gdLI307nWD/zs38ih0OGSbc2NIo?=
 =?us-ascii?Q?00JwMvWR07tsiuEVkiefyXHpZTPyW7VZQ8nwy1K7ugDqDQOfzcM6Q9CHhDLm?=
 =?us-ascii?Q?SuE5xwbOxwXEQzofigdlQDgxC8AtKw8pkwjTyqd6BSJrwWELnwDHK/O4vlNO?=
 =?us-ascii?Q?YvgLL9g10TB/TWtXlNgan1h5cBbYDVQ+af/D7Gz1+MMyl3bDElTQXSqGyyTX?=
 =?us-ascii?Q?os6x1CHryEkhz1ZJC+na4vUFh5Zif7VD3kGF0rtW/VqCRa/HmyrDmgcYYtcY?=
 =?us-ascii?Q?xJ2aNqUauVLSKHP6ozOiltR5UaWEa1mVWNyoVKE29EGoJGlaoC1NhfS9yZ3R?=
 =?us-ascii?Q?b9MCM8LWXSYX55cnNBjJSHF+uVVg6qBa4RMggTuNPNtIOsC3C9OIn0ReEMY2?=
 =?us-ascii?Q?39sbOxCgbQ1tnzRKPEhLWro9y8nCBwTNPnG7zVVbBT8TomSShmQ61Ebipu+A?=
 =?us-ascii?Q?xKtO8ThWI1wbL1/8Qm9MxccJbKTnp45BGeN0nyonwnj7C2ravHXsO1TDUljK?=
 =?us-ascii?Q?JQ6RNuQ0sIq+UYPs4y+8AtRCVCwL1oxoINfDXJk4zKGg6zIIcdj591+X/E9L?=
 =?us-ascii?Q?UTdW5HE2qkfKP528Rer3ZIaVr4ao0wsvkEj11R7VbKHnyp6wI1FCvHGF5rP9?=
 =?us-ascii?Q?+/n0jVZTqHW6IcO7lbkfpd7uKmvzvY5Z+POIdqEGvSrg3XNuxvIayrn2kcCd?=
 =?us-ascii?Q?vyvWew4cHX2E72ivI4TInThRM5j4HodhQN0odkSrIn6AJr1oW5EM2L579uYP?=
 =?us-ascii?Q?X4FZ09HfdFXEN/pN73YkqYFpLbu+pHEhJDsSG6go?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e14f994-dfb9-4c06-a019-08dbcfdad4cf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 13:04:58.4644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLcLW6dcWZOOC/aZk+7CrDdrOwutsHf3PmcbEz/0a8EcQsDulbLuw8VpwvI6Y94z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4897

On Wed, Oct 18, 2023 at 07:05:49PM +0800, Michael Shavit wrote:

> > FWIW, I found the most difficult part the used bit calculation, not
> > the update algorithm. Difficult because it is hard to read and find in
> > the spec when things are INGORED, but it is a "straightforward" job of
> > finding INGORED cases and making the used bits 0.
> 
> The update algorithm is the part I'm finding much harder to read and
> review :) . arm_smmu_write_entry_step in particular is hard to read
> through; on top of which there's some subtle dependencies between loop
> iterations that weren't obvious to grok:

Yes, you have it right, it is basically a classic greedy
algorithm. Let's improve the comment.

> * Relying on the used_bits to be recomputed after the first iteration
> where V=0 was set to 0 so that more bits can now be set.
> * The STE having to be synced between iterations to prevent broken STE
> reads by the SMMU (there's a comment somewhere else in arm-smmu-v3.c
> that would fit nicely here instead). But the caller is responsible for
> calling this between iterations for some reason (supposedly to support
> CD entries as well in the next series)

Yes, for CD entry support.

How about:

/*
 * This algorithm updates any STE/CD to any value without creating a situation
 * where the HW can percieve a corrupted entry. HW is only required to have a 64
 * bit atomicity with stores from the CPU, while entires are many 64 bit values
 * big.
 *
 * The algorithm works by evolving the entry toward the target in a series of
 * steps. Each step synchronizes with the HW so that the HW can not see an entry
 * torn across two steps. Upon each call cur/cur_used reflect the current
 * synchronized value seen by the HW.
 *
 * During each step the HW can observe a torn entry that has any combination of
 * the step's old/new 64 bit words. The algorithm objective is for the HW
 * behavior to always be one of current behavior, V=0, or new behavior, during
 * each step, and across all steps.
 *
 * At each step one of three actions is choosen to evolve cur to target:
 *  - Update all unused bits with their target values.
 *    This relies on the IGNORED behavior described in the specification
 *  - Update a single 64-bit value
 *  - Update all unused bits and set V=0
 *
 * The last two actions will cause cur_used to change, which will then allow the
 * first action on the next step.
 *
 * In the most general case we can make any update in three steps:
 *  - Disrupting the entry (V=0)
 *  - Fill now unused bits, all bits except V
 *  - Make valid (V=1), single 64 bit store
 *
 * However this disrupts the HW while it is happening. There are several
 * interesting cases where a STE/CD can be updated without disturbing the HW
 * because only a small number of bits are changing (S1DSS, CONFIG, etc) or
 * because the used bits don't intersect. We can detect this by calculating how
 * many 64 bit values need update after adjusting the unused bits and skip the
 * V=0 process.
 */
static bool arm_smmu_write_entry_step(__le64 *cur, const __le64 *cur_used,

Jason
