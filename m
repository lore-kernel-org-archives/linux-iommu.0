Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4379223FC41
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250174; cv=none; b=CKsRBXOgdtoQEHYZEWk/BfpP0gwxJYDLCTmgHmIt3f5CNIqFs3EsOSEvHlvST6xPYw2eE6irpHTizo1ixgYaX7dcZ+suq0yAGHSFAWaneDJ0iZbnoXyWf12RNqvPUSGC4AzDQQWdrSnUUM7wE13sxOGlbOV0HqIuJcRhwqMBt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250174; c=relaxed/simple;
	bh=vNLmMpFUnyWT3qj2Ty1BU6NWwRZIXomZm0LqGPFGWlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSwBeXhxj2I9eosM8oqOe819IROuWrzufZ7cqr3RjKjmVnYzPi9dPx3ZLzoc2r/+Qk/uvQBGuCuBWLQzpZZkP5AitkWE7OBbapgLOSmDLreIK5Q3IuNp6nF9yMuTihqprhpU3O3BKlfLZI5nkd64EHXboZW/xs3WDCrrRkMm8oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5DF211C7465;
	Thu, 24 Sep 2026 13:42:45 +0200 (CEST)
Date: Thu, 24 Sep 2026 13:42:44 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	amd-gfx@lists.freedesktop.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>, 
	Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>
Subject: Re: [PATCH v2 0/2] IOMMU Performance Optimization support
Message-ID: <arUMU5QGhb34exFV@8bytes.org>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908041207.38113-1-mario.limonciello@amd.com>

Hi Alex,

On Mon, Sep 07, 2026 at 11:12:05PM -0500, Mario Limonciello wrote:
> Mario Limonciello (2):
>   iommu/amd: Add PerfOpt IOMMU performance optimization support
>   drm/amdgpu: Enable PerfOpt IOMMU perf optimization when GPU in
>     identity domain
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  50 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 ++
>  drivers/iommu/amd/amd_iommu.h              |   3 +
>  drivers/iommu/amd/amd_iommu_types.h        |   7 +
>  drivers/iommu/amd/init.c                   |  43 +++++
>  drivers/iommu/amd/iommu.c                  | 214 +++++++++++++++++++++
>  include/linux/amd-iommu.h                  |  11 ++
>  8 files changed, 341 insertions(+)

What is your preference on what tree this should go through? The IOMMU changes
are bigger, so my preference is the iommu tree, but for that I need your Ack on
the GPU part. Or let me know whether you prefer this to go through your tree.

-Joerg
