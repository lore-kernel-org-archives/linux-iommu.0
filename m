Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04963EA972;
	Tue, 19 May 2026 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204212; cv=none; b=WOSHviFyv7+8fN5h7dYFKnO34uw4HPKbxi4/8vbuG8OHxgrRJbX/JugwQA0BSHXEm7NQyRhqeL1l4QHfTI53OSsWslO+yBzFFsDQ8liaXv45g8KmIRh6OBP/Y1nYVarj7VcVdrZA2Qc+L09UyCCCdCtpHtpn3hMOSE1rZzFtEY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204212; c=relaxed/simple;
	bh=aMA6CgWGVgRaYAjNVWdhULx2b3EFtXV+By0rfZRxQNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvOqLwi+LPOPAAWnhANJruHkIX8t+jWnfLLKN/0ne1s3ENdfZbJ+Cb+n00HwDxKVFJZHt0MLRH0qYz7bCmF51TWuHlfPkSdsNBMYt3imAphyyDeUOFu1xC2055SKW43lOHEElEOrizfG745c6MhdN18cngz/KoV4D7kReZTp75k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0ZaDTEP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0ZaDTEP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548A0C2BCB3;
	Tue, 19 May 2026 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779204212;
	bh=aMA6CgWGVgRaYAjNVWdhULx2b3EFtXV+By0rfZRxQNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0ZaDTEPbJxRfn5XodR1rT73cXUjtKTkvkRrFMHXis/rhfUs0WjRZq2dDZuxkY/rV
	 ozAWtcwRBeVBHlElOosG77B801f8oE/LqFAPM9NZGFg/VLPUH8hCDE7S7vmBVpVBbL
	 bhCHzXrbtnk6NQRe+NIWxniNnH+/TjwTasQLNsqHrQG0ShXjVmEsPmdX/F60jfKpUf
	 iin7gCwNFll2HpYcNIn4ZKjNtftAEj7Lpg+F10Z8FiKalH0HEGCFhdT5bPjOzj/Bse
	 5ujp7zEF9QHX1a5RiUFrlsLizKutHNtETs2MY6KbayVuKYMThItsuOFQZLPoMyhDXF
	 cwJ2yPN58IQGQ==
From: Will Deacon <will@kernel.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Clark <rob.clark@oss.qualcomm.com>
Subject: Re: [PATCH v3] iommu: arm-smmu-qcom: Ensure smmu is powered up in set_ttbr0_cfg
Date: Tue, 19 May 2026 16:22:52 +0100
Message-ID: <177919116291.814652.1720687887970998122.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260507-qcom_smmu_pmfix-v3-1-af8cd05831a2@gmail.com>
References: <20260507-qcom_smmu_pmfix-v3-1-af8cd05831a2@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 07 May 2026 17:43:15 +0200, Anna Maniscalco wrote:
> arm_smmu_write_context_bank() assumes it is being called with RPM
> active, but it turns out that is not guaranteed in the path from
> qcom_adreno_smmu_set_ttbr0_cfg(), so it's possible for the register
> writes to get lost when configuring the context bank while the GPU is
> idle, leading to page faults later.
> Add the RPM calls here to make sure the SMMU is active before we touch
> it.
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/1] iommu: arm-smmu-qcom: Ensure smmu is powered up in set_ttbr0_cfg
      https://git.kernel.org/iommu/c/8a0aab012b52

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
