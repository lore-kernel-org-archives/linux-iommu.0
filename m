Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C702472B9;
	Mon, 14 Jul 2025 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494095; cv=none; b=S+iP7xOmaiKDbe5g/H5IeTdtfMfQaAyZpkaDkaqipuOrYeZ5CM0KI4mN2FZdgVpa09vVkgid+71e+/wfd1j6yJT4PTMsX5/tVZXqV87jw/nnNnddFT3D0XBLWvyltY5BvAJ7X6Sn3WjkFEdrqfkbSxdGzDJoz2DhrZ0Ci0vSIac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494095; c=relaxed/simple;
	bh=9etceTQrDiG/4TwcUBP2A5qBFbh1SJbzXRtcmAbMXfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6Ew71uJWsNifDPxgNkfssFtwTaVjrZ+AoJIzomLfeBwbR06xBjNs5Rd7q4DiZpUYtXx1s9eO+g4YxIWIzrIw94hOKUv+C4bita09PNxwNIPzIiLEBU/ZyCMBEyY+57Co7SgBblETn1H5sgDg4qjE3tl82C/7WcbLJOOt9/omu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVeGyHp4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVeGyHp4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE31C4CEF6;
	Mon, 14 Jul 2025 11:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752494094;
	bh=9etceTQrDiG/4TwcUBP2A5qBFbh1SJbzXRtcmAbMXfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VVeGyHp4je8igGVFU4cjlFwF287zWb61XRApApIO3BlqVgL4IOklbt6CxHwcJ5NoQ
	 B4Xk1Qb8YJbg+kaHi0yNW23wvpAdTvl0AnTOcd2nrPTHVvjZZi6Q5bpggB8fZE42rg
	 MsGWouFDqiXRkLlZF0cbJOFyRtTZfkD9zvi+cxnDeywS3N6PywkSmNcBqHq4hy/zWm
	 oeT8V7gHCRjMy5YuWZNHOeWz36IUvH1sOxPabDchjZ6Ci3kpgpaf6D2qZSFHkOOIkt
	 qGwGfsIQGkvAtiMqwz6pMt6Hg7+NV7eGYEfAiEkT9+VG2qhiqEQZTY1vG5N+HABZpD
	 KGUhIhZN1+RMg==
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	joro@8bytes.org,
	praan@google.com,
	baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Revert vmaster in the error path
Date: Mon, 14 Jul 2025 12:54:32 +0100
Message-Id: <175249171897.1454370.6706876035622030720.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711204020.1677884-1-nicolinc@nvidia.com>
References: <20250711204020.1677884-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 11 Jul 2025 13:40:20 -0700, Nicolin Chen wrote:
> The error path for err_free_master_domain leaks the vmaster. Move all
> the kfrees for vmaster into the goto error section.
> 
> 

Applied to iommu (arm/smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Revert vmaster in the error path
      https://git.kernel.org/iommu/c/49f42634e805

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
