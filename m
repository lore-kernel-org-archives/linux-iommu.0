Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7343F7876;
	Tue, 24 Mar 2026 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364917; cv=none; b=uUhe2grBFkd4eKANVwRJbbFR465pu99w8OtNMwArng0X7yKNZSOgrcIamPoxvEb4FqBaH1ifLNd9D1c9PCFSKHImezl4VebbOJBY6nAp/Ui8xxxKSh6oZ5NHjVdKm+i5QxtwQUpbszOrN/1A7/FvxJUjwOq1oTZ57CMefdYTrBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364917; c=relaxed/simple;
	bh=IH2XxdQm/+/OqmCcBXugtqi7WO71IXZONI8fSZ9YkcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaOXOpkwYGx+gr5spQKp5UYo40WxJbBbZ4r7MVHfhpgxl8DoSGYfgnbjFqCRL9buwmtDjP4/28+GslY5CUKx/Fwr2DDHexT8k8rhrk4S5WBJF/i3Mb2EvqSXdB/R7aWRnU0asgwFOZhZCu9DIyIbru9O1u8KpNKL545FmBTVjKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2D7GdFq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2D7GdFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF59C2BC87;
	Tue, 24 Mar 2026 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774364916;
	bh=IH2XxdQm/+/OqmCcBXugtqi7WO71IXZONI8fSZ9YkcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2D7GdFqjAyEAY5wJEkAPVWAtu1GKYT8mQy/sIT6UpclZiK/ptU3Zo0tnfFDhVN9k
	 4gPS0PItjdMtHcB+L+OXd7RPosL6YhV00NVTDiGzX4GAh+JsEu252ECUs9IJAdgBpt
	 AIPlD0eaPl1O5oTArMg23jjE8rl4H7+oCWM1ttZzwW7eGPpDNhxYiJAD+jTV9tk6FO
	 r5kW8JgFR8AEJQtWURb0BxVmxgXkVu09XFBcpFXob//lcxfqqJL6g+9cynQjFZNTji
	 V3DnvXA9l5UL1bCm3ncPbYyG8sw99yM2lBwmVlVKnp/YX5jDBl36QFGpJjIIgrIHlR
	 nq4upHbDAPf2g==
From: Will Deacon <will@kernel.org>
To: robin.murphy@arm.com,
	kevin.tian@intel.com,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	joro@8bytes.org,
	linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	eric.auger@redhat.com,
	skolothumtho@nvidia.com
Subject: Re: [PATCH 0/2] iommu/tegra241-cmdqv: Fix initialization and uAPI related to HYP_OWN
Date: Tue, 24 Mar 2026 15:08:13 +0000
Message-ID: <177436107597.1856788.11362232309690054704.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773361875.git.nicolinc@nvidia.com>
References: <cover.1773361875.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 12 Mar 2026 17:36:33 -0700, Nicolin Chen wrote:
> Eric and Shameer found a bug in kernel driver that supports_cmd is set in
> an incorrect order related to the hyp_own finalization. This results in a
> unnecessary command filter in the host environment that sends unsupported
> (non-invalidation) commands to the SMMU CMDQ.
> 
> Also, Eric pointed it out that the requirement of VMM wiring HYP_OWN to 0
> is unclear.
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/2] iommu/tegra241-cmdqv: Set supports_cmd op in tegra241_vcmdq_hw_init()
      https://git.kernel.org/iommu/c/803e41f36d22
[2/2] iommu/tegra241-cmdqv: Update uAPI to clarify HYP_OWN requirement
      https://git.kernel.org/iommu/c/9dcef98dbee3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
