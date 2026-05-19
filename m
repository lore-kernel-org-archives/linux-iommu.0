Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AF63EA974
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204249; cv=none; b=olHhruOF9DEkYNeu+OCF0E8t859/SlqtG5en+oJ9AyeM8D4JHLnfyC2rg9kb8YwUMErAmMaW+shSVnQar7rwbxUFSSXn4aRb9WixHUEiNXdwNurCFh4RJHcwWA8muOMBAR5WhsC51Ws1mORbX/d83Jn6s+0zzLbCHzLnb1S8DSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204249; c=relaxed/simple;
	bh=KnwGe1PHQa7+ces6Rm383lcbh4DqxvuFpwRmHyUGOIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVGGz49UiiSzU+7+rnHdeIxmQBWnOIZjmQ5zRwMqJl2nkZezqXGFC2yV05SSUrMFNPrlvqOUcj2wZNADsLKOTiE/p9NsXVLApZUEzle791NcDWOAtijoMwR4kGKXdkDrOusOf7nedd2mQ7sMbTZrr8Q4HsuucJnwee9BEm5FNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdPkl6J0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdPkl6J0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DD4C2BCB3;
	Tue, 19 May 2026 15:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779204249;
	bh=KnwGe1PHQa7+ces6Rm383lcbh4DqxvuFpwRmHyUGOIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IdPkl6J0Z0lwrY74J+6qVDWm/3tuvL1RSq9pBus1o0+aExZ9mmq0P06ogAkIf4MbS
	 SG8pJUE7d2RNyFh65wVLMXD7nFTGFw1qQKI8xcAVzmnOPXVb1c23vytstZvTClXt+z
	 m/44RL8c6mslAAf7jIKqNY0zfzmWlDxMISrokB6OpZDQ9RRcL8Osv2eGV9c8CmcKGW
	 wen/BIJ8Y3b2v9JoAelHBzkn3uQN6pL3TTWSOq8+ERqxYtF2mtYpQWaGiICF3FCGY0
	 0B7w66uxzaNwY4xZcA1Y4foOF38qTX1doanTI/ZgGF1gY9MyF3iHM5Yc0ImAAByRR0
	 rSRa3NMFzKIxA==
From: Will Deacon <will@kernel.org>
To: Leo Jiang <leo.jiang1224@foxmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Pranjal Shrivastava <praan@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Limit queue allocation retry boundary to PAGE_SIZE
Date: Tue, 19 May 2026 16:23:04 +0100
Message-ID: <177919187443.820140.8795243549242737796.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <tencent_F13723B53F68DC857410D3DBE4F6C895C106@qq.com>
References: <tencent_F13723B53F68DC857410D3DBE4F6C895C106@qq.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 09 May 2026 15:07:33 +0800, Leo Jiang wrote:
> Stop retrying queue allocation when qsz reaches PAGE_SIZE.
> 
> 

Applied to iommu (arm/smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Limit queue allocation retry boundary to PAGE_SIZE
      https://git.kernel.org/iommu/c/2b9f593dad46

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
