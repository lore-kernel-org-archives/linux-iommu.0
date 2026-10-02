Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04604EDCAD;
	Fri,  2 Oct 2026 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959428; cv=none; b=ewBsG7NgMIbeG22CfTIarKYqddEP8GZQwVT7AVN9KmJ0BXiKKspN3Zekk6WBPbWcGkd+OaOwg0Bo/OZEPrMExaECay30hJvqvMkscTI+LSpUaE8FBVkj9J35Y9hfeh0XAVK7AaQSYUcsZlrEQksyV7V4k0ztt6vnZLZln8SgFC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959428; c=relaxed/simple;
	bh=ANnzqIE88PpAbXvMgNi1vRap06Y/mTqIF6czgADO0g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vrla6UOYBCJ8ahG2b4qjxjj8bIy8o5IH9YlreIID6ixNrdNumRNEX9djaQgQ/OZXzOzKabFmrVOYbRnD7Afm5m4PaHRvrPtZjXa8kCivZCmfV1Q9XsICKhzIeRhpA/logKNX/hUNR3oqt0+8v2T4d5qWOJ4reOpmIaPsclzRQ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVkvXH4M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVkvXH4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9D71F000FF;
	Fri,  2 Oct 2026 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790959427;
	bh=y9MRhlz4pzaoGqz6XBjvYnXMN79/O0P66ZDWtWt6Lv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QVkvXH4MIkXiJq0i0bW6Gqqdu15m800MonrF8VWPSFxRDFxCfnKP9lVLCvJHIlwDF
	 DuUH5d68DiioC64U3/jjVHOkJyKYeMLCRpsowq7friAXvljxxrtfWWhjSHP84YnWoB
	 LD4qMtBBoJ+UWRUhpZssXzxjN2AhJ5QxKPUxF0AhDaplBSpuy/fYSIyGrW7BXGRyaj
	 5erZhJi3pLpFiENetIzPd/QJOvb5fNVhWkMBsRJLtrcEKxIhvG2Cyl+4ercWd1CieS
	 uV/oEuGTs+oBCAgQMruT/CBXs+6Bn7Rj5cJwF4dJ+VWLIsbfue0LQ0+c+Qe7Bfp990
	 eRlT/l+AABUeA==
Date: Fri, 2 Oct 2026 17:43:42 +0100
From: Will Deacon <will@kernel.org>
To: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Subject: Re: [PATCH v4] iommu/arm-smmu: Use pm_runtime in fault handlers
Message-ID: <ar_fPnbFMJQK69pZ@willie-the-truck>
References: <20260806-smmu-rpm-v4-1-8183d007331c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-smmu-rpm-v4-1-8183d007331c@oss.qualcomm.com>

On Thu, Aug 06, 2026 at 03:52:41PM +0530, Prakash Gupta wrote:
> Commit d4a44f0750bb ("iommu/arm-smmu: Invoke pm_runtime across the driver")
> enabled pm_runtime for the arm-smmu device. On systems where the SMMU
> sits in a power domain, all register accesses must be done while the
> device is runtime active to avoid unclocked register reads and
> potential NoC errors.
> 
> So far, this has not been an issue for most SMMU clients because
> stall-on-fault is enabled by default. While a translation fault is
> being handled, the SMMU stalls further translations for that context
> bank, so the fault handler would not race with a powered-down SMMU.
> 
> Adreno SMMU now disables stall-on-fault in the presence of fault
> storms to avoid saturating SMMU resources and hanging the GMU. With
> stall-on-fault disabled, the SMMU can generate faults while its power
> domain may no longer be enabled, which makes unclocked accesses to
> fault-status registers in the SMMU fault handlers possible.
> 
> Guard the context and global fault handlers with
> arm_smmu_rpm_get_if_active() and arm_smmu_rpm_put() so that all SMMU
> fault register accesses are done with the SMMU powered. If the SMMU is
> not runtime active, the fault can be safely ignored as
> arm_smmu_device_reset() clears fault registers on resume.
> 
> Additionally, disable fault reporting in arm_smmu_runtime_suspend()
> before powering down. pm_runtime_get_if_active() returns 0 during
> RPM_SUSPENDING, so without this, level-triggered fault interrupts would
> cause an interrupt storm while the device is being suspended.
> arm_smmu_device_reset() re-enables fault reporting on resume.

Separate patch?

> Also call synchronize_irq() for each context IRQ after masking fault
> reporting but before clk_bulk_disable(). This closes a race where a
> fault handler that passed arm_smmu_rpm_get_if_active() before the IRQ
> was masked could still be executing MMIO accesses after the clocks are
> cut.

Separate patch?

> Fixes: b13044092c1e ("drm/msm: Temporarily disable stall-on-fault after a page fault")
> Co-developed-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> ---
> Changes in v4:
> - Add synchronize_irq() loop in arm_smmu_runtime_suspend() after masking
>   fault reporting but before clk_bulk_disable(), closing a race where an
>   in-flight fault handler could access MMIO registers after clocks are cut
> - Link to v3: https://patch.msgid.link/20260630-smmu-rpm-v3-1-f69874a580fa@oss.qualcomm.com
> 
> Changes in v3:
> - Add arm_smmu_rpm_get_if_active() wrapper that returns 1 when pm_runtime
>   is disabled, ensuring fault handlers work on non-pm_runtime systems
> - Disable fault reporting in arm_smmu_runtime_suspend() before powering
>   down to prevent interrupt storms during RPM_SUSPENDING state
> - Use pm_runtime_put_autosuspend() in arm_smmu_rpm_put() instead of
>   private __pm_runtime_put_autosuspend()
> - Link to v2: https://patch.msgid.link/20260313-smmu-rpm-v2-1-8c2236b402b0@oss.qualcomm.com
> 
> Changes in v2:
> - Switched from arm_smmu_rpm_get()/arm_smmu_rpm_put() wrappers to
>   pm_runtime_get_if_active()/pm_runtime_put_autosuspend() APIs
> - Added support for smmu->impl->global_fault callback in global fault handler
> - Remove threaded irq context fault restriction to allow modifying stall
>   mode for adreno smmu
> - Link to v1: https://patch.msgid.link/20260127-smmu-rpm-v1-1-2ef2f4c85305@oss.qualcomm.com
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 101 +++++++++++++++++++++++++---------
>  1 file changed, 76 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 0bd21d206eb3..2b692a5293a2 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -79,11 +79,16 @@ static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
>  
>  static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>  {
> -	if (pm_runtime_enabled(smmu->dev)) {
> -		pm_runtime_mark_last_busy(smmu->dev);
> -		__pm_runtime_put_autosuspend(smmu->dev);
> +	if (pm_runtime_enabled(smmu->dev))
> +		pm_runtime_put_autosuspend(smmu->dev);
> +}
>  
> -	}
> +static inline int arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
> +{
> +	if (!pm_runtime_enabled(smmu->dev))
> +		return 1;
> +
> +	return pm_runtime_get_if_active(smmu->dev);
>  }

Can this race with pm_runtime_disable(), perhaps via
arm_smmu_device_shutdown()? If so, then we could return -EINVAL, which
doesn't look like it's handled correctly by the caller here:

>  static void arm_smmu_rpm_use_autosuspend(struct arm_smmu_device *smmu)
> @@ -462,10 +467,20 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  	int idx = smmu_domain->cfg.cbndx;
>  	int ret;
>  
> +	if (!arm_smmu_rpm_get_if_active(smmu))
> +		return IRQ_NONE;

^^^

Is this assuming that the irq is edge-triggered? Is that guaranteed?

Will
