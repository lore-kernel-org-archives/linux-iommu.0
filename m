Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AAE1BA26B;
	Fri, 30 Aug 2024 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034355; cv=none; b=YzRxBaVomUU6q3+jbXM0CVMai0pT5a0/eq8FULrinfMQLBKAYkXgNTIotPVpeIBEmhIXSW4QYx+kwcGhrKljtDMU6a7R98eb4gVTT6Y8+OOuIeqHviD3XNoEeEx11vu8n7wVj6WGWVIm2GTO/B6958W76sVPnxdvPTsmwY/Fp3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034355; c=relaxed/simple;
	bh=h8V6mV7LznJSDPyytvtdyWN5LAbvGTbX2O+Xvk3aerI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmNmM40+kZmBQ8aYyR5ywUFyPLVe/CtUa1QXU9AbH+Rj/3N8D4pWqKJ3fa/QzpwCwGIuMJ3/V1VqIIP4V1WvQ4OQcxE2huliRNW8n3m7DdMokLwx1FxsRZC2Fsmh9itNCVmzQ2EqduhLmoFKlq4dhNUGwbWPZPuU1JoTbhb6htY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbTayib2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbTayib2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4323DC4CEC5;
	Fri, 30 Aug 2024 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725034354;
	bh=h8V6mV7LznJSDPyytvtdyWN5LAbvGTbX2O+Xvk3aerI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bbTayib2CLnzHLij97ZEpbG3xHLjfxKlFwFb9XMzATn4uyCG7CqbjkZkQy4xlyRRc
	 bG4FfnqrWpoqQZPWkcTvGPvphtaB/NX+dPEXo7xtJsI9Gsvn3fG6895TJWRTrAVp6q
	 CgBXrH39O5UrVdR+ZzIKXAZdNj6LioiHnLRMUh6bE8UMu5MMLcXDgLi03d8/FiCdaN
	 1UcvDVJleF5WnAT8uN8kTLIlDQCOjHyBUrlAkQ8hOui0WZ/Slw49vAXuRIgR7xSYZo
	 RNFe1oYAh5za17R1MnNa4ShFdl+t82ZvLM4tqH6Ue+of3hdzmaJ81bjf5F15nditOX
	 7JDGhcLJ0+fmQ==
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	joro@8bytes.org,
	thierry.reding@gmail.com,
	vdumpa@nvidia.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v14 00/10] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Date: Fri, 30 Aug 2024 17:12:12 +0100
Message-Id: <172502752365.3788306.13276843969148976864.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1724970714.git.nicolinc@nvidia.com>
References: <cover.1724970714.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 29 Aug 2024 15:34:29 -0700, Nicolin Chen wrote:
> NVIDIA's Tegra241 (Grace) SoC has a CMDQ-Virtualization (CMDQV) hardware
> that extends standard ARM SMMUv3 to support multiple command queues with
> virtualization capabilities. Though this is similar to the ECMDQ in SMMU
> v3.3, CMDQV provides additional Virtual Interfaces (VINTFs) allowing VMs
> to have their own VINTFs and Virtual Command Queues (VCMDQs). The VCMDQs
> can only execute a limited set of commands, mainly invalidation commands
> when exclusively used by the VMs, compared to the standard SMMUv3 CMDQ.
> 
> [...]

Thanks for this, Nicolin! I did drop the 'default' statement in the end,
as I think it's a bit overkill to fail the probe in that case.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[01/10] iommu/arm-smmu-v3: Issue a batch of commands to the same cmdq
        https://git.kernel.org/will/c/56ae8866f3b4
[02/10] iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_build_sync_cmd
        https://git.kernel.org/will/c/2ea1f0120f90
[03/10] iommu/arm-smmu-v3: Pass in cmdq pointer to arm_smmu_cmdq_init
        https://git.kernel.org/will/c/e736c895c45b
[04/10] iommu/arm-smmu-v3: Make symbols public for CONFIG_TEGRA241_CMDQV
        https://git.kernel.org/will/c/a7a08b857a32
[05/10] iommu/arm-smmu-v3: Add ARM_SMMU_OPT_TEGRA241_CMDQV
        https://git.kernel.org/will/c/b935a5b1c670
[06/10] iommu/arm-smmu-v3: Add acpi_smmu_iort_probe_model for impl
        https://git.kernel.org/will/c/6f3f9ff43d00
[07/10] iommu/arm-smmu-v3: Add struct arm_smmu_impl_ops
        https://git.kernel.org/will/c/6de80d619203
[08/10] iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV
        https://git.kernel.org/will/c/918eb5c856f6
[09/10] iommu/arm-smmu-v3: Start a new batch if new command is not supported
        https://git.kernel.org/will/c/f59e85490712
[10/10] iommu/tegra241-cmdqv: Limit CMDs for VCMDQs of a guest owned VINTF
        https://git.kernel.org/will/c/a9d40285bdef

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
