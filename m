Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9615E14A81
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 18:12:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO/Ws7lt78NR2e48xfpweLecCNFQ9/S//XrpAEE/03GMuNlIbsLlC9NV5xGs16+jt05r3jqo9MJT9lk4k5zOPlQ8VN9+4pHDtSANwEH0ojXwt7tJXTl0lXRWymKKY9pTv++BAOkod4J3dki9+hf3A9NUel5G2okjfgNFmCixpxsJRm6HkVf5bVjxataHXzab+9aP5Q28Wl8wPfcgLLupJV81fqQwO8SN2uSQ3bDsFz+ieyzlkjN50MDxp+qIXFUtIViChLt4Mq9bdSCRjDQ8c+73gcZDyIKFO+GAgzrDtrWp4OWiVRXX4D1mX5pih6YZhM+q02KKmSL9ABdbtOpMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcLqY9E8WHfP3A1mctwbSqbMMfU357MHHFZkw7CSLkA=;
 b=KoAUbxgfOosy+mLa0FRSUDVejLxiPYezTIw+7fMiM8XWHHTIY3Ip4YX4PMni98tGFECnN7CafiUl/2TBf4lP2YYWVAP8RayLf459bT+y/shXq6NpKHrlPgnwgK1cogIns6AhYuHZFr+kfe1Ih0PD8TQNQOIv/953QLuRKD3IKSsaFeQ3swTGItreE9t3AiHPUfvZ3hR1rSSe5H73/H3rHEZgyoqIj2SlbTXBeHpp4exNQxBD+uFHniJyV16561DuLQfweoh5W5/pjOAUyqPFA96bcJOwPCg9rYYnEWPHtNkHvceWX4dToq+fO18MTqhbSdn7NWXRK/a6Vcb2V0AxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcLqY9E8WHfP3A1mctwbSqbMMfU357MHHFZkw7CSLkA=;
 b=Pqswu3kZthz10zJQc1Pggjn/w9H4UjUUTflFmizsaFrK+UYy7R/DHxGaY81Qr4/9ivwsDRp1/6zScXb1LA2eSgBd75GyZXV1k8tX1riX1IK7p+5VLjobfCO0mmZAAo8VqUEK9ebuKltlCEcz9kMyGSpn78JzyUx3oBum0KJWrxStoN32kYuac3pMgCmmTWFtvvanwiJL6ezkXrA48NoH5z+oJWPW3LWdcfEoCSx2WZOg24PArwFs9c9dmaudEZZ/+3VexhLZjHkfnEno9gLFrVkPkCCCF5Qqz91SvtqNyyQvGHnPgZL7fqDYAKaGYanXA1UbT/w/N0Nc25dZ4YgdRA==
Received: from MW4P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::34)
 by SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 18:12:20 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::31) by MW4P221CA0029.outlook.office365.com
 (2603:10b6:303:8b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21 via Frontend
 Transport; Wed, 10 May 2023 18:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 18:12:19 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 11:12:05 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 10 May
 2023 11:12:05 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 11:12:04 -0700
Date: Wed, 10 May 2023 11:12:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: <will@kernel.org>, <joro@8bytes.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <jean-philippe@linaro.org>
Subject: Re: [PATCH 2/4] iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
Message-ID: <ZFvec0JGfbaYHie2@Asurada-Nvidia>
References: <cover.1683731256.git.robin.murphy@arm.com>
 <330221cdfd0003cd51b6c04e7ff3566741ad8374.1683731256.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <330221cdfd0003cd51b6c04e7ff3566741ad8374.1683731256.git.robin.murphy@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|SJ1PR12MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b4f874-7d22-4da7-e27c-08db5182186b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aYA2uGQ4tAdsWbIc2nZhlpel5AmwOeEYgZ8/T7ArOsnrpT1iyrgM7/f1C+cCJ/zOpOxu89xDjmlcxASZFKwz4sZEyeb9ZRrKui5VJgvjfbgOm7QU0ayJrf6LQbFZNyh3DuJjK+FidXD/cNWSGIh7TNoDUzSPnz5VKcIXSbFR6KOBtLuUPrpE3+IIDbUdAKDABZXNLp8ioj2ZuaoHWS8UqjYo13Ud4HfcArDXAzwqmT4GgvuM4H7pf8FjVhn8+JqpQKu9FDNZmNoNcJm1Dh2TVOTbnBkDAi9YxoFUMqw85/SeIRwfbRpOoXY3ZDfzYjLe6uP5h7bUoh+AZ7leCnJhjVIyxT7XZwbpTOBteRQ954/SxKjSsRAJ2UW7Qu+++Cmh4tM1DBGosNYhhdtFUQ3SYPdwMNuKs5HkVE0XisKWd4vNDyuhCkDoU54XyH9LcP4i+PzTO0nI5Fkobg1ANCVu2IC925vhEDMwMI+3PCcHbBrRusMKg7HD6/kMqXGhfK9bzxKjIFzOsQwQakuhEOarLWJgmUbrFe3gsjPyfX02gh6UEPXIka4lpCpqbhowBQKPu2O1U4lVgjP30fTj8+TPuGMMPCApPj6vJ7+JoWXqoSkjxpgRfvwD8tNuaUyNxVtdfqX3IKomm1ySlgIZAnaxoIhM/tEITTgEI/n0TZtX2dg6Uq4ZkCkc3M+006u4bmZ8s0PW0egNWE+FnhnfHMOOEg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(426003)(47076005)(83380400001)(36860700001)(336012)(33716001)(6916009)(41300700001)(7636003)(4326008)(82740400003)(356005)(8936002)(70586007)(8676002)(316002)(478600001)(26005)(55016003)(70206006)(2906002)(9686003)(86362001)(40460700003)(186003)(54906003)(5660300002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 18:12:19.8816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b4f874-7d22-4da7-e27c-08db5182186b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6194

On Wed, May 10, 2023 at 04:38:44PM +0100, Robin Murphy wrote:

> To work around MMU-700 erratum 2812531 we need to ensure that certain
> sequences of commands cannot be issued without an intervening sync. In
> practice this falls out of our current command-batching machinery
> anyway - each batch only contains a single type of invalidation command,

Hmm. This doesn't apply to the user cache invalidation solution
in my v2. A user cmdq could possibly mix different commands in
a single batch if the driver isn't aware of such an errata. So,
I think I'd need some twist when the host has a FORCE_SYNC flag
in my v3.

> and ends with a sync. The only exception is when a batch is sufficiently
> large to need issuing across multiple command queue slots, wherein the
> earlier slots will not contain a sync and thus may in theory interleave
> with another batch being issued in parallel to create an affected
> sequence across the slot boundary.
> 
> Since MMU-700 supports range invalidate commands and thus we will prefer
> to use them (which also happens to avoid conditions for other errata),
> I'm not entirely sure it's even possible for a single high-level
> invalidate call to generate a batch of more than 63 commands, but for
> the sake of robustness and documentation, wire up an option to enforce
> that a sync is always inserted for every slot issued.

Hmm. This can happen to a user space driver that does something
insane like that. I'll need, again in the nesting patch, a line
of code to limit the number of the commands when it calls the
arm_smmu_cmdq_issue_cmdlist() for a user cache invalidation.

> The other aspect is that the relative order of DVM commands cannot be
> controlled, so DVM cannot be used. Again that is already the status quo,
> but since we have at least defined ARM_SMMU_FEAT_BTM, we can explicitly
> disable it for documentation purposes even if it's not wired up anywhere
> yet.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks!
