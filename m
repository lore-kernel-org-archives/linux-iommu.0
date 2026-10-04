Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B95361974;
	Sun,  4 Oct 2026 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791120256; cv=none; b=TI1u79LWeBuB2MMe3cjM6U3U9ntLSlJJrdP4QKp7pMP2JVmuUaHIMOqsEHHZowpV3YAgIujoqLx3Qed2/ZfTeyxSZdVXBuJoyIEtu1J2EBPMPOOMiVqjuNj37IgqAWsMkUyUJitsoYTvsDNpGoJaNSp5JVitr8/k6rkjtg/sbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791120256; c=relaxed/simple;
	bh=TjhqSP/9hugH5UK/zirwdV9VTHxAh57VHn+/SW9BITQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubPgFkY05Zga8IOJdJx6UWvUhEIlm9hC4J9l1JjLLmn22Vk5nZBCi1QvQDLgiKMjra0A18Dd7VkSHlcd31rHrMHFHkKI74O3v2PSCoJE/ZG5h/GL2zpdfxJqTfg3WOJKgef7w51DyG8AYexHbkBMtR3IktciiWSFR3PVLeQJgaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5LxWNWl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5LxWNWl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1391F000FF;
	Sun,  4 Oct 2026 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791120255;
	bh=zIwrdOZ9vUUfMJ0ypGfA9v49+RgdK2nVvpCJNCxINwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S5LxWNWllFLP54vZtbqa2dRKzwyvhv/wD4MTSCXD7CsPQDAxbtLik6aAdGOrxYl2L
	 Z3YF+85ISjXOBvEbKxq6pcxmwFUZMvOxDsfwFDPhmcDO9QRLo49621Nq/hwViABVC/
	 UE7qRDK02Fzn/n8JJf7pd+BgWcx7BgJH0IHFx94GuRAyXC3TzPFq612h3fVDPaGRyz
	 IN4xD6TcM+pm4T2Mf4WbmKlflnwrdEKVdkCQS2nO9ZtuH1GpOgRpEiItgHuY7Uk5VY
	 6+Iecf21u72bu/dm2NmLouEY7XR9/lN/02JvIz/wctCdx7hJunBeyQb5zShD21Y24d
	 daJkeUX4mGkkA==
Date: Sun, 4 Oct 2026 14:24:10 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, praan@google.com,
	kevin.tian@intel.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org
Subject: Re: [PATCH v10 03/13] iommu/arm-smmu-v3: Add ARM_SMMU_FEAT_EVTQ for
 the event queue
Message-ID: <asJTer4cNh4DAQMY@willie-the-truck>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <b6493aeece86f44195e8afb6fb8b3497cc237dc2.1788130528.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6493aeece86f44195e8afb6fb8b3497cc237dc2.1788130528.git.nicolinc@nvidia.com>

On Sun, Aug 30, 2026 at 04:18:04PM -0700, Nicolin Chen wrote:
> The driver programs and enables the event queue unconditionally, while the
> PRI queue has an ARM_SMMU_FEAT_PRI gating each of its touch points. Yet a
> kdump kernel wants to leave both of the queues alone, which would take an
> is_kdump_kernel() test at every one of those places.
> 
> Add an ARM_SMMU_FEAT_EVTQ that the probe always sets, as the event queue is
> architecturally mandatory, and gate the queue's allocation, its interrupt
> and its CR0 and IRQ_CTRL enables on it, so that a later change can turn the
> queue off in a single place.
> 
> No functional change intended.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 79 +++++++++++++--------
>  2 files changed, 52 insertions(+), 28 deletions(-)

Sashiko has comments about the event queue MSI configuration for this patch.
Please can you have a look?

Will
