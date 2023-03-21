Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9BD516
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 19:53:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2gpnVMM0zUrM7gciWhQCGJZZIAGpqO2jmFaMCOGqNXDHS9NjlLDjU/JB3m6/uc5s18CtC6bB35YRyp4CveKBzAXTnYOoSC8PiehnRbwcqcpOK/nO7QJrbNO0VHLZ3197vrHwP7BgpMFmsBOkscqQCieWFHpOlBxSJ1IffqZypgjXsAgXB27pblUpX666icoGmgcJ/sTKNSphVYsLjWtOBJZbqGYAixUsz4SQBvglUa5XC4TWxJ4gvH8hrtfhqr8xAb3Ww/IpIUwVHaLKB1XFXboBn4SJIw8Y/LUTuq5i0dCuE5EB/qkDCa6CldGIN+rl82zEsN21AqMIOFecm2BeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dmj5A5P62ZCqDOPgcdxqgm6omMAcbJZKcK4+5og32yk=;
 b=LwIR7TfhSSVo8ovnTg4Svmpz/n/WdPG0LqBxSHsmnSDAznzZyqRtUhzOHn9v/X8OFHEWpLvEKIYcDSMgTC072+1ysoCUCgXi4t9sy7ypg23qY94WDwpzXIKke5OpLv3UpWXtUmr0tRupZ9CCmInfmh7romLxzHpEb5neDumiooti8XLFWy4ekIuJ1LgGNbnq99yt2QTbirt92Hbt8EWewC/hStJd00tG0QYEzXV0LmPVSfMSSGI9hL6WMRWZwmaSv5Pvj720bDGbjtAcr6zEt9wPxEMmi15K0LSACOmURY9fIL0h75vDq4VXFj/g+U6lGQmR7dtX6dnXpbsOzEJEEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dmj5A5P62ZCqDOPgcdxqgm6omMAcbJZKcK4+5og32yk=;
 b=TSASy3TGlj9sHNH7TpdMfMEvbkpHavUukw2WuPVJgg7OvTcYb3xjhjxFSuXKRTO/kcVLwh/VbOptb1SJNo8pwS3oOQ7Kx+a5kSuEF1ZB6O5j2vmhwIPRGZ+aUy7K0enreYRj0ImUzQQbCOqrywrQJKXXE2duUaLufJRXVjoSn+K0+odWLyNtwifrbYbNNqcMRekR6SL5ydCGn3XzlmegO405fSYigo7v/5ZH85T3NIho+sjzwfsTvYtlzloYGqkGK7J9YtPsaEXtOW24bXcLvdjWKiKhN4y7Ig0vB+U8bHP8daSsn22RAV9J5QXcYdG1C+SkhgXCrNub9uGOA6e+zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:53:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:53:23 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 0/9] Consolidate the error handling around device attachment
Date: Tue, 21 Mar 2023 16:53:12 -0300
Message-Id: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0334.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 897ed26d-614c-43a7-659a-08db2a45ed71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A201DzWQahKSBYeN+AoU53ADrzWN4t0zqHfczDjfeEs92rdANWn2YaW0gDohUWL5BwmtTRZIXGOh8LFyZUujR5eCA5pHP7dWX5aIVWuOgPkBPoYRsk1jZlpax2o/3Jid9oAOnrQRGQMkUK6yD5Gjq4ILfuu0s2CnJLm/IpCts8h9QJP2HMzT7K+xpRN9ArxIzQIaPoKlkTaPl4KFgfkNBFo9Mwev/m9tR57vx93xwTaTQPtj8Yh34oodUV2ZzXjN4dyeAp51EyHUXLqpotCxzlc0M7urysW2lHzqREMgFvO9Zod+YylA/yvy7hdBdhM5m8SoAnFDZ4fY7zc5fELoaHoz7F1GKdlqaB3ntWYG9pUn+36jNAUqvQjt0NTcRFK+W2Pa0L0M+FnBrCZr+7SFJh1JcIbB06DDPIfjwsdeT27NKf1Gm3HiMaw8Tne+eBjl6jcAb/ZTpone47BOktdS+Gy0cWqE7znb6XYh1/noKm10BWIurDlV73JIu6gUS8zbAHwtz05A6rb3QUQYlvu+eaa0PRs3iGsheNCLuxH+QIZ54YCcfqBNt1fL6jaaZ7fIHr4gpLuYm6Wiyjdk6fVMnf0HevcTbmTxBMXBI2I8YPQzYIlTnazhVEM8n/Fegjk1vbOR3voWw/qv2p6yl0LV6snSkY/lpIFnsTWktemeFRy00SpUeCAFe2Wt8tthPGfC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199018)(66556008)(66476007)(66946007)(8676002)(4326008)(6486002)(2616005)(8936002)(186003)(5660300002)(2906002)(86362001)(110136005)(83380400001)(41300700001)(26005)(316002)(54906003)(6506007)(6512007)(478600001)(36756003)(38100700002)(6666004)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YUGD2vmweYhMR3zuIohLf7kn7b12BuMtA0Ebo1GYbiqfBZLxrkBNmr+sMekr?=
 =?us-ascii?Q?/28Ie0fZk/3jFQ51ipbDGKJt2Y67kuoFtqPbIam9GFaNgQ4Ky4m3DD2t9di6?=
 =?us-ascii?Q?zJOLx3gqfA+VNgMxWAJ2H7Gan/ljCd7FfthAY8qTcVsJz5xzR778QLtiCFEP?=
 =?us-ascii?Q?KdHAdEGDS4Hi9M3E1IMd9qCWHrXKNDPnUUlNynsrOxmst9mKB743PcqBMzT7?=
 =?us-ascii?Q?V1AwNu4hcd7kdj5H3Pp2hVzZ3uyjaHOCU9lnnXSqm7+SEy7QwLRkUWvBfgrn?=
 =?us-ascii?Q?yjJTylWftEAV5EkA3cfCEBUa8Tr7vXUT2MiSB4KtOGqT/z6alOKO19oG+aNz?=
 =?us-ascii?Q?wSlmfTLPOZtA//hwt26kWjdwquDc1u1iY46+qs8FEUXKW5Nd1KZPzHoIdU1D?=
 =?us-ascii?Q?WHVx8Ld2DPP6iangODVVBzSTXoTfYG5dY3sYIWjRRkobOdIGwJeIO9HE+HmO?=
 =?us-ascii?Q?TmnlvsHQUhQl+M3oh9MhaYmdKHehb/y+lgvrTmpeeLqL+EQlF+ltV33upBF5?=
 =?us-ascii?Q?Rwc8oTzBXTxjrp14xkwIhnbHNwv9akyI9UQlBAZe5fHw5adLIWXJtCEAKh/J?=
 =?us-ascii?Q?BITK6pLvte7R7v92yLcXEHgVi2eNXGdE03ygdyz4dMnTSuol61lo4ZOJPjZc?=
 =?us-ascii?Q?aw1Nc/zN0WTUm4GD5t8qwMyw/1e9w5kdt+erMFm271KegIo+FK7LwkP/SzdY?=
 =?us-ascii?Q?+MWRllkM/9nDvqFkBWXYVlapAdvLHr5id+K0WQhTXBzbA3R0fQwgrmf7o+k5?=
 =?us-ascii?Q?x1K3YuaTbdeHqBjZlQYYSD5e+2kCNj/jwtI7i2kxNyr2Hr95go+NJAbpfSFQ?=
 =?us-ascii?Q?kQPikdEPvrx56Us28z4GDwNgYiLYvt32fu8+VLyxjAq61Pt599CchSzHhul5?=
 =?us-ascii?Q?sF8wWErOdxNK5owfgrKDVO8+w7BaPRImX8V+s1QoHRWs6BPXgcsTZgqgMv26?=
 =?us-ascii?Q?HrHPuP4S3n31j2hjGN/trgf2sqO+iweyQ+tVt4LdLxUZVINvOnQrO7no3Svq?=
 =?us-ascii?Q?qAUmSkoPmnIXyWp6bxzcZw/YEBrqlesBdUUJvrk/LQ5fOFa8XljhfJc2VH4N?=
 =?us-ascii?Q?al3L0wSoKLGOVDmNn6XbO24jRCAyhmXWLKc30m2lrpjAAf7JwYNxCLLPnmEK?=
 =?us-ascii?Q?Rg/x2W54z9ievXeSa2YmNf0Yv/J9BeS92+030ZD1w4n8+KWlvwv43JlxIAOX?=
 =?us-ascii?Q?DZe9I0xaC043AAKZnOJKT8rb7SOBVGxUWtwShLMKwrMHZkKWpCvkmw/H+zYf?=
 =?us-ascii?Q?znBk1ili49cnd4TGH3y8f9dujVvSrCAkW6L23mBgCHPoDJTGCPudr6MDXi71?=
 =?us-ascii?Q?1021W9tseLFUut2bYFBfb0tZwBB+cohlxG+nNt5HtVsj9NoHKnsHu0Mbkmz3?=
 =?us-ascii?Q?tt7+kSH1+vZBuB/8fBfiF51TtU84L4NrOn/Kj31BiJfngq7jDWkdWOxlCim+?=
 =?us-ascii?Q?FZCVlOaMqXZa1szNLaHUuN8cCaa3s+qP9dFxSOf0zl9IIPxObYhAQOpHodDz?=
 =?us-ascii?Q?3hBqnylr90d+Rwl8NHhgeDc3nvuSvMPV82CYF+3SY6gx7MkUxJVivFoaCAc2?=
 =?us-ascii?Q?IDJaPDx46npUqj9SsoPtcjD2i5lHDZpzFkPTLBqS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897ed26d-614c-43a7-659a-08db2a45ed71
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:53:22.9361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjUfXXCY6jWlkNHLhzB58YtM00IHxTfs1CeUQgDjktSYdJVH/JT77zXY9I0hge3o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

Device attachment has a bunch of different flows open coded in different
ways throughout the code.

One of the things that became apparently recently is that error handling
is important and we do need to consistently treat errors during attach and
have some strategy to unwind back to a safe state.

Implement a single algorithm for this in one function. It will call each
device's attach, if it fails it will try to go back to the prior domain or
as a contingency against a UAF crash try to go to a blocking domain.

As part of this we consolidate how the default domain is created and
attached as well into one place with a consistent flow.

The new worker functions are called __iommu_device_set_domain() and
__iommu_group_set_domain_internal(), each has sensible error handling
internally. At the end __iommu_group_set_domain_internal() is the only
function that stores to group->domain, and must be called to change this
value.

Some flags tell the intent of the caller, if the caller cannot accept a
failure, or if the caller is a first attach and wants to do the deferred
logic.

Several of the confusing workflows where we store things in group->domain
or group->default_domain before they are fully setup are removed.

Cc: Nicolin Chen <nicolinc@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Jason Gunthorpe (9):
  iommu: Make __iommu_group_set_domain() handle error unwind
  iommu: Use __iommu_group_set_domain() for __iommu_attach_group()
  iommu: Use __iommu_group_set_domain() in iommu_change_dev_def_domain()
  iommu: Replace __iommu_group_dma_first_attach() with set_domain
  iommu: Make iommu_group_do_dma_first_attach() simpler
  iommu: Fix iommu_probe_device() to attach the right domain
  iommu: Remove the assignment of group->domain during default domain
    alloc
  iommu: Consolidate the default_domain setup to one function
  iommu: Remove __iommu_group_for_each_dev()

 drivers/iommu/iommu.c | 444 +++++++++++++++++++++---------------------
 1 file changed, 222 insertions(+), 222 deletions(-)


base-commit: 771ad306397838108f264e180e31188136907616
-- 
2.40.0

