Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9573EBF19;
	Fri, 23 Jan 2026 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190604; cv=none; b=LactAyGwazVaYSV1XfZ+JpBZialpfCz1WoHAr9ZFPJ8o7vqTIMV8WwP4P4iCw6tdQQbkvl6MvKDxaAOdlqM78VyZ8qSs03fQy926Ht4VDi++v6sCuWfs3oF+FnB3myMb2QShCe+QCI+XFjPl/FCQiW/6ZvJh3pVZSmpx6Hu0cEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190604; c=relaxed/simple;
	bh=fHofxdA4Da+uHbx0Jzo4Cli3qCrobNFBUWfODVZIbdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6VgqxkdvGkfBkwvqe+ZYSfPgn+uK7qSx/w9DjO2CF0V+OlEEOzAiYwIpYjBz9XQu6pV5nHo3aVnb8SsibpqNauDrvMqfMQS7XcrxaOhM5VFp0E/d6p63rq7rzXvX7GOtuvRJvqYAuPptirZFeSOIdfAYntO3aggzz/DCP1vM6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ+Kk6+i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ+Kk6+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E6AC4CEF1;
	Fri, 23 Jan 2026 17:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769190604;
	bh=fHofxdA4Da+uHbx0Jzo4Cli3qCrobNFBUWfODVZIbdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PZ+Kk6+i/H35MZX7IQ11IdK5j1taCX2GD+WS/jO6x5WPgxEU1aE0PPKSHhyR47QR6
	 I91he+l6WcqQh729FX0398BvrzF9+ipCKwrhom2IOc1wKqeu5kT/ssQQNLlx8xlZEc
	 9COTqa49RVK2yjdUoBqWVLlZbdaSzjMvXHw//wWgz8TvthtbQ3qzBuwgGFWXJ78qma
	 ImoDnucxd9DiOaqDYxHgez6cM7wXiEVJAM3DgiQiJuPyZJ4x4dpu7Hqc/RoFMm0G4l
	 CLQCMR1rg370cnsga8w4C7BP28aiY0if23v6K+LJfKaOPqcjKtmyy7+U1wak1Tg4MK
	 3v4NRgS1/7v4Q==
From: Will Deacon <will@kernel.org>
To: robin.murphy@arm.com,
	joro@8bytes.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolinc@nvidia.com,
	Ashish Mhetre <amhetre@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	vdumpa@nvidia.com,
	jgg@ziepe.ca,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH V8 0/4] Add device tree support for NVIDIA Tegra CMDQV
Date: Fri, 23 Jan 2026 17:49:48 +0000
Message-ID: <176909472941.3000991.9335608927808259220.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113054935.1945785-1-amhetre@nvidia.com>
References: <20260113054935.1945785-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 13 Jan 2026 05:49:31 +0000, Ashish Mhetre wrote:
> This series adds device tree support for the CMDQ-Virtualization (CMDQV)
> hardware on NVIDIA Tegra264 SoCs.
> 
> CMDQV is a hardware block that works alongside the ARM SMMUv3 to assist in
> virtualizing the command queue. It was previously only supported through
> ACPI on Tegra241. This series extends the existing driver to support device
> tree based initialization, which is required for Tegra264 platforms.
> 
> [...]

Applied driver changes to iommu (arm/smmu/updates), thanks!

[1/4] iommu/tegra241-cmdqv: Decouple driver from ACPI
      https://git.kernel.org/iommu/c/eb20758f8672
[2/4] iommu/arm-smmu-v3: Add device-tree support for CMDQV driver
      https://git.kernel.org/iommu/c/ea69dc4e207b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
