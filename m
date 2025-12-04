Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4CA3093AB;
	Thu,  4 Dec 2025 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764883709; cv=none; b=aZo3Y0OaVS8JK77kl/nN/zs9NrQizuhpH98PClkYIakCk11dKbmFcQaDGMd6Sx/FfUD/qJYXnDDE6+F81ZH9/zwYaQvACLLVcawoLbWNrn6J2XcxKR3prjgJBCkuK2WH0zZslCkuUQ++sgvLhvlpUz9cGP0zaP7McZruFb9a32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764883709; c=relaxed/simple;
	bh=X8tPs9E6uh+VtgXU41XCn/OUQj8VPbapViZgvzXZmqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8UCAToenLVilt3Hs2SUHoMHYCydF4EZlB6VrLE+8DfcCaeEd5rSq5uCHIKIpasqOXw4ODrnCpsJDFKVi6mUpfVw9Do7aC2fPny6Ji5B9s1XPgPL0//wLKlLatqoAct2jqV4mapplduHELxM0puvT3DyJeiEQYbTr3WA9hwXmkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oL8AMU1H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oL8AMU1H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71998C4CEFB;
	Thu,  4 Dec 2025 21:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764883708;
	bh=X8tPs9E6uh+VtgXU41XCn/OUQj8VPbapViZgvzXZmqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oL8AMU1H9u/kQnCLhQPiR/4W7X8gevJNJMq9MHRESr5Uh3iMs3dMulOAWxAGbCajN
	 iUrgGj349WZ+JwTd5AoFpVrv17YrLe3K9ObpzkoULntZCzfHVaKCDUNZGD8pZdXj1P
	 CP42WR2GRGoCXpOgI5VX6RlzVkO3eAOZGVEnNhwfy/CkQiNhW7rADRoVbg2fQscMQD
	 JOoF+kqXoHX1Y2jN6+83sUV/tjcJLRpFq/hvgQQRE0jpf0M2x1lbFB8xTdswPc2i3l
	 1Zd2X9E0L6bckUM9WaNeEdkaa1IHMYYKBXtCzue/OWQPIUXTlBBtLuEu/I5r1WdJGP
	 BWf0N7K/D+05Q==
Date: Thu, 4 Dec 2025 15:28:25 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: nicolinc@nvidia.com, jgg@ziepe.ca, linux-arm-kernel@lists.infradead.org,
	krzk+dt@kernel.org, devicetree@vger.kernel.org,
	jonathanh@nvidia.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, will@kernel.org, conor+dt@kernel.org,
	vdumpa@nvidia.com, joro@8bytes.org, robin.murphy@arm.com,
	linux-tegra@vger.kernel.org, thierry.reding@gmail.com
Subject: Re: [PATCH V3 2/3] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
Message-ID: <176488370517.2196325.5157844880170253515.robh@kernel.org>
References: <20251201163219.3237266-1-amhetre@nvidia.com>
 <20251201163219.3237266-3-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201163219.3237266-3-amhetre@nvidia.com>


On Mon, 01 Dec 2025 16:32:18 +0000, Ashish Mhetre wrote:
> The Command Queue Virtualization (CMDQV) hardware is part of the
> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
> virtualizing the command queue for the SMMU.
> 
> Add a new device tree binding document for nvidia,tegra264-cmdqv.
> 
> Also update the arm,smmu-v3 binding to include an optional nvidia,cmdqv
> property. This property is a phandle to the CMDQV device node, allowing
> the SMMU driver to associate with its corresponding CMDQV instance.
> Restrict this property usage to Nvidia Tegra264 only.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  .../bindings/iommu/arm,smmu-v3.yaml           | 30 ++++++++++++-
>  .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 42 +++++++++++++++++++
>  2 files changed, 70 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

