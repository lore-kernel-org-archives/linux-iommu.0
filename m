Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE57440628B
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364922; cv=none; b=gEM7kdaEdaiTHrHtmoCCLKTEaOMR1TAagI6mS8o2g5fvF8CfcnO0xs7dgvR3vmbo8nmnWn/NAlc1p6H0VfRhpiU0CdxGlUe7fkAp6Yj+dnHv+MClHY9LCbcgy3k9bi4gPngqAxfkUuSn1Z8QzDR4wLYV4lqtDrNEcrw49k/icX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364922; c=relaxed/simple;
	bh=X0/YDnSa1rMtuoYUi0HqHRdAZppbespWYXH/36ERwx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSdofTDnYjarvQ6UrWzZY9wN9VYq7bU7f7sj0kLXDMBmg25FofFbqTQp9uEY5mQYXy8gnynzPJ59BnX/nfWkWoEpDxEh1QSw9Tfb4jXdNkyzYYAavNy41IHmjdQLGGnzFR8xJ0F3rJvzSRtOvRFRKzMgNsipUNwNMJWa+MZvZxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeERE1Qv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeERE1Qv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5DAC19424;
	Tue, 24 Mar 2026 15:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774364921;
	bh=X0/YDnSa1rMtuoYUi0HqHRdAZppbespWYXH/36ERwx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MeERE1Qv1L2kFe3zNIlzg5Wo7fdMvF1rTdpQ7+fFdVkMYdjhJwvNhTJUFke3I/5r3
	 /oyYsuT+7i4LbZr5It1y9MgC+i2eza4JDNA4z9UeapP5n24N77gJcxKzK4ytNgCBpa
	 uQDJjvIvRrWzwcGcMnKMbXeYxHzhOlg/jN3ipFUaCp7+3DAarY6Gid24i+YYxx0W5a
	 SZ8dGCYoaMz3QW5d1MMgNJq90pAHCyhZQa/iZb0fswVfxOo/UId6RfmhAfhT/LH88Y
	 YMKBT0if6pxgkxg1gXGcbDck428VxGtWP8QUsmsPNYGNWUzxDPfG/tIbEvXNBZkCqo
	 C5Nv2BiJM23bg==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org,
	Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	daizhiyuan@phytium.com.cn
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Update Arm errata
Date: Tue, 24 Mar 2026 15:08:15 +0000
Message-ID: <177435999751.1851496.53677672093228558.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <4c4664b2427cef212a06efdd78a9faa8d9ded302.1773933699.git.robin.murphy@arm.com>
References: <4c4664b2427cef212a06efdd78a9faa8d9ded302.1773933699.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 19 Mar 2026 15:24:34 +0000, Robin Murphy wrote:
> MMU-700 r1p1 has subsequently fixed some of the errata for which we've
> been applying the workarounds unconditionally, so we can now make those
> conditional. However, there have also been some more new cases
> identified where we must rely on range invalidation commands, and thus
> still nominally avoid DVM being inadvertently enabled.
> 
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Update Arm errata
      https://git.kernel.org/iommu/c/3b793983834e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
