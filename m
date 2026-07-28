Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798D429CE9;
	Tue, 28 Jul 2026 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237337; cv=none; b=mdZ4I6SYQfLEhiAA7zrJKN3k4hEpqDAlHgljb4FiCXeY16iVlgkvBLEc7A79uvK3DqrTYB+zgfK77ZeiZOf4octL98h+hZjLrE9W5PYj9arEu48Dz5/cfZvnDMstY2PQ5dBIiahcqV6hhNSm2XWwmcw7AUk1P1uewKzKoOgpaZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237337; c=relaxed/simple;
	bh=2YzGoUOiBWCpu1CFlEi9Uh2kzNaxNi/VgNlVwy+xycY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNyWMU7G32KoAtYd6vglrjAdedGFstoQOs6pjPoItqGu7MXYr5vXnm7tmLaAIMVh735HWI54jJyNtsBt9u37mIqLZgruFnBjxY8f+b39OCMdCe9BF1hoJEEB3PWRnAhop8tyUjH7/5LOcrGcMsY7+98OsrCauHdYlvUDITJYaNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTVV0RhH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTVV0RhH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80911F00A3A;
	Tue, 28 Jul 2026 11:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785237335;
	bh=v1UAkumH+1EWeKiYH4cUN+rYvQoUWuyKXbz54U/PDZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RTVV0RhHbnYNukT6I0Qj9A9B2O4mnKjEYZU44W0ZwfANvyMazmgbQAkltRWtdTETF
	 o4IuVxS51G3o/OhApT8JT9wZT/EmUG48xRiW2rwe++MOGp2OG9R7QiIOcDoiXsJCxy
	 +aH9bjpFxpH53MZ3WRdXvOaujugbKE8xsMFN/A59rFFaK1Uo25FNHkIC4iFCyecuIF
	 a/n256CvZAkLtUP9qCcxFCr6RAEATmSacbk5QKulpB4BQItDkh/IkjIK1KVylQZtbs
	 uCcUwzgvJMRB5fzuVM+XOJSgZoeZnniPogmLh8PYXSIuaerfr2Dr4fWBrsownqYI/a
	 dX4HLzDr1rjBA==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	nicolinc@nvidia.com,
	jgg@ziepe.ca,
	Ashish Mhetre <amhetre@nvidia.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v9 0/4] iommu/arm-smmu-v3: Tegra264 invalidation workaround
Date: Tue, 28 Jul 2026 12:15:24 +0100
Message-ID: <178523218770.339148.16144926256012413621.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726081904.1408859-1-amhetre@nvidia.com>
References: <20260726081904.1408859-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 26 Jul 2026 08:19:00 +0000, Ashish Mhetre wrote:
> Nvidia Tegra264 SMMUs are affected by an erratum where a TLB entry can
> survive an invalidation that races with concurrent traffic targeting
> the same entry. The hardware-recommended software workaround is to
> issue every CFGI/TLBI command (each followed by CMD_SYNC) twice.
> The second issue must execute only after the first issue's CMD_SYNC
> has completed, giving the sequence:
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!
But please check the comments from Sashiko if you get a chance:

https://sashiko.dev/#/patchset/20260726081904.1408859-1-amhetre@nvidia.com

[1/4] iommu/arm-smmu-v3: Factor out CMDQ batch force-sync conditions
      https://git.kernel.org/iommu/c/097bf4a02f2d
[2/4] iommu/arm-smmu-v3: Add CFGI/TLBI-repeat workaround
      https://git.kernel.org/iommu/c/95ed2da20283
[3/4] iommu/arm-smmu-v3-iommufd: Report CFGI/TLBI-repeat erratum
      https://git.kernel.org/iommu/c/d501d66815ee
[4/4] iommu/arm-smmu-v3: Enable CFGI/TLBI-repeat workaround on Tegra264
      https://git.kernel.org/iommu/c/06b15ddcfbc0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
