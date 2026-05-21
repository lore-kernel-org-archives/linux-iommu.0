Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5C426B2D3
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386535; cv=fail; b=E70q9tGHEZ0SR5LcZxjA1Na3B530Wu+2Qd77X4jT3+nKoP97DInB9Hmw8s3uh2sC/rtDw8E5rTkuGN4FDmi6ysjc/6fga2qpxXO6Mkt5FSmwUVflZdfwbLbCiIh46MTJKe8EwFN2R/hjvwvjePwXaXWZcwVny1ITjDEJKfxge4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386535; c=relaxed/simple;
	bh=3zsvXeN6ZJYU+BdwDapbOJCZp2/F2Esr4Cjx+PxgQks=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcdHdopT6m0NjlKfH3c++8aL4UPkFaEn1Um6C/oz6XOUe6n6VrlXB1ScjLLNgqWDaGvsc3CTNfYVrnsQqNNPkfTfyvLWDrFTszoXDgSrSuD5eHgU9nAHa3Qsjdchkuwph/x8GGogP5vZ9v0Y1lNVux/8sl/Vaj7WaeUlEW9mXSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eitYcYEc; arc=fail smtp.client-ip=52.101.61.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eitYcYEc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRgopNh/YaIZ48oGICpP+Z0vqpYuhxXXdO0BuiBmojJLsJu+avDHbdAmjLwjEbsT8E+rnWOBTnq9/dLMYWPu84lvMMlX9B2g+rFnY/ac0P1+pDmKPXJN9HKAyFD84oDhSd8c7tkte358LR5TaF0mlOfVznvYNmlMAtByAhob5oH918+jpQw0U+59p7UPTtVWB+O5PR/iAyzlWsy9eJo2GcRCoIrlunIPFJDETMyKL4lIqZFOgyeajpLiGBHTrp31dVzCXXeAC7ax+Y+bY+jyEW4EscM1Z/05ye9WASZ8iZzkT6MESDaztUEn37Vvxmy9djJVyCtHnf7AGe/ir/W20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Bu9RvxjpoSQ69xilvJsfPcnkGpiW8M3oke9QoPxaUM=;
 b=Es0yxNtlXedXxY4DF9VyieRjoAdHE9piDfhJbQfuumTcCZUPI/eEC+sExUTJo+VzZsUgr+Yfa7VaswBztdAA/g4mCOD1Te5u0yJ9/fIn5JYyHy2scTPsYHXJpIoj5UbWVw+ZiBpnGl6+D8MDN5k5Kud+VFHrsPTtladyFmTnIuwU692okcDohBUAojPAeYW1MlE4/+/e+Oy8h+auEMmmRtUYRDoegcgLeES9smiPGE9ryGnnlo9lK7nYSptR9DGAqc7bPpJ8iNKNoCE0So1kcRgqRnkYKFB2ZuMc+pdV8CYVwQHIGWox98GGfhUOXcU4rzPIoTAJlOf/8XgN7ikh5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Bu9RvxjpoSQ69xilvJsfPcnkGpiW8M3oke9QoPxaUM=;
 b=eitYcYEcHARUjni3qmTxWG05A8y1z5nPofpGu5ps5Ny6lL36nJJjyjuQ177XRycqelXDEC2gi/WluqhSF+mhy7zBAXyO/x9T81ad/ETP9GfE8WeyNlkhfgrYyiAJqzpv1KF+NN7cBpl5bTbeyjWaFZkvbejopdONxs2Mp3/5fOcop3BlX3VOGChMojYDkIi3dWriuq5BVzx0QtIvhicdDXf1dgjmfnfklvk5uyzoJrSxN3XZ+BBO7fEmKAmAtNFLh8o/1wp/DK05YStGb8dRCBwkskHjb35Sd9ZnOTpUNTl45SdVW/4jxEa0ja+jPVCwB3L8p0a8oLYp92pKz/gjoA==
Received: from BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::6)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Thu, 21 May
 2026 18:02:09 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::1c) by BY1P220CA0017.outlook.office365.com
 (2603:10b6:a03:5c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 18:02:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 18:02:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 11:01:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 21 May 2026 11:01:50 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 11:01:50 -0700
Date: Thu, 21 May 2026 11:01:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH rc v1 0/4] iommufd: Fix veventq_depth boundary
Message-ID: <ag9IjD98g2pHiGlE@Asurada-Nvidia>
References: <cover.1779070992.git.nicolinc@nvidia.com>
 <20260521143004.GJ3602937@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260521143004.GJ3602937@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f7c2da-7e0a-4649-7edd-08deb76313aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|11063799006|5023799004|4143699003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CDuQewjXScSeTpJCeR8qwogl5uzpSH7s7cmwa1FiTCcOrtMAE4E+qUuN9i9fZMtOrSnQB0/i6XARflG6cmy/UFNRe7yqBryCncQBrL/uT12k3Gs5+GnIuT7LZJPzUxGGd7z68157rNhhj0rSwIB4l8o45GEtqOqiT+nwQRGcoREjKG+koxb01fSpqDWFfPgWQC+wfaQIGJvd+EAhQM/ipSlzpmtJ8YpJsJRJpdpqD/Dwo5tEpLo2s5SGT1ChPB53tQ+vfiFJ8Pv2j1YeKDRKz3BDsE3F4VUXOblW4h/Uhx5VVp1uAbrVOtJo7CcGvQcW4R2+FjhbhDj5Lgxls2oJ7N3CiTN4lwh6sgNDI9AVk/9abXIp6tMe7rm+XI+8NC64Nm5Ktfaty5cQiiG8wjw2SYpS/2xK1Jxb2AaQPG/miLrYJtjOtEEZER+tS/c0ik5tLB1TNAJknUtYVOt84H9B4/lFnkQ67tqxxFd9TbcbE/cYEWTvJUxMWgCDp3dmjwdXZ6UCV3miszp4MDmW3xHn8IfnNdq83PgghgsYqSIFZuLDVbAn01D/JgxrAwP/O9n/J/zSYDQcpcCZn4Z2GfjksqX5nCA18Lr48JFD15B5xIMOfR9+ogl8GSLBNBf5NGINLohsESRwF/4SJbmwRwgea0y+9tJGGGdeAwuRXNQXAZNLN7aYdtvh52OXsf4Ey9NRGvnltfKD9pGoDmZFQrI7vCLQ9kAbKerX5P1pBe0OUMs=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(11063799006)(5023799004)(4143699003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TIUK7RqAAkV5ZVORrXekUFrqHZyZ4PE3M2iEqY0E31lUfQNLMuIWuHCWFzeWVgt4zX87wmUFy8efelzgVimnzqVGgfa8f0GxqZRkEFrsXjOS0x6fxsPA+rp0knNYKyzPxwg2ztshNdR7m2Nad3CCfSLAhSWKV4AhfH1e6dDExv1bvGAUkwbT4yX++ykQ97XQHWJFSDmtD/AnuH0t9d6/N3wumYGEYjjcdwwQbvnQNt29cp4o85w+jpOSu7DHHt1kq8k/JrEszVWobw3DHihS/g9MzG5HaDc8TWgvW4pvVHaMkCCn3SIRCGTdc3GGT1ApoPX64JvO89ODxjpD66KMpb70uTXfGh/pX9RSaqDfXqlmsnszqrGtAw4kkdaXZ36oE/mL9J6H3Tu5MUSbk9aAQrxw1RTFWEir1v2qW6ZIgz+G1GxMDheqyjJ5UdBUGIVj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 18:02:09.2541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f7c2da-7e0a-4649-7edd-08deb76313aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865

On Thu, May 21, 2026 at 11:30:04AM -0300, Jason Gunthorpe wrote:
> 1) Put "iommufd: Fix data_len byte-count vs element-count mismatch"
>    first

OK.

> 2) This "Returning -ENOMEM for allocation failures but 0 for queue overflows treats
>    the conditions differently, which seems to contradict the stated
>    intent." Seems bogus, I think adjust the commit message. We do want
>    0 for queue full conditions.

Ack.

> 3) Let's fix the "Will this lockless read concurrent with a plain write cause a
>    data race?" by removing the optimization, just pre-allocate and
>    fail. We don't expect this to be a normal condition worth
>    optimizing

I can drop it.

FWIW, it was added to address a Sashiko review also:

  By moving the allocation outside the spinlock, the precondition check that
  skipped the allocation when the queue was full is bypassed.

  When the queue is full, which can be common during a hardware fault storm
  if userspace cannot keep up, the code now unconditionally allocates memory,
  copies data, acquires the lock, and then immediately frees the memory and
  drops the event.

  Can this tight loop of wasteful slab allocations, memory copies, and
  deallocations exacerbate IOMMU fault storms by adding unnecessary CPU
  overhead?

  Would it be possible to add an optimistic lockless check, such as
  READ_ONCE(veventq->num_events) < veventq->depth, to bypass the allocation
  when the queue appears full?

> 4) I'm OK with ENOMEM here, leave it, EAGAIN should mean it is
>    pollable and it won't become pollable..

Yea. Sashiko would complain about an EAGAIN as well :-)

> 5) The sizeof(hdr) has been fixed in my rc branch. You can rebase on
>    top of that and also ensure to send a base-commit trailer to help
>    Sashiko apply the patches properly

Oh, I forgot to add base commit ID. Will use your for-rc branch.

> 6) What do you think about the "but done has
>    already been incremented by sizeof(*hdr)" ? unrelated issue? If it
>    is simple lets add a patch here to fix it

I added a patch but didn't include in the series -- Sashiko would
raise more questions against that patch...

I think it's a separate bug; Sashiko pointed out another in fault
queue as well. Both bugs are at failure (corner cases?) path.

I'd like to address them separately.

Thanks
Nicolin
