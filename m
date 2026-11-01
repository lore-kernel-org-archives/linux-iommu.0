Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571422;
	b=GhoTqwgFwXaQVZDzA7EiW1KXm85d0d8Rz2DtPKF3s4lb8hCKbxhDygTVAsNCuw+0w3Zj
	 E+AnMLn34uUakQ1yD0QI024iaxlyCYffHwBIya1AfjAB25oXkBst5OXa6vMUjLk2uGgp7
	 8CoZ11sqbGoLfLiXe/nZaT0lv77G5F8SDvONPJJb4u6Npuxhh3nTRvt/sNOJTC1j2OnCD
	 X/Ar9KL3dZfixsoFmxW/NgNM7f51Hn7OdVp3SzK8oHw0y3DI71LpL4FE3CA0IYxDi8RCU
	 z7KAsJV0tXPbal1Gr4hrhkr5zDpK4UTgq/e5BEto4xOMKvD/PEOnoBm+l33xJLxgh4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571422;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=TlXe8GaWIxgfUN9oJ8ZkUQcX+CJa5NmDUSw16Gb5fjc=;
	b=L7C4h8mVgXtkwriQtBmn9S+uIBhHPcpKTKnWFsY1AhX/M5v8qE6pVNxneBTANaaYwTxp
	 2NY34yAe7vKmKwCn7Qq+rvqGuAP9kdnsXzviXimi73MbkVqHqOm6mpravOgNTy15Lzj/1
	 xfAZsOxFYnjfNnVkbmn2kJXjEUhqvubukGm608+xHwPJv+M8LsFHVr197+6AdNQh081xT
	 /MWOm4qCDy7zIH/yINI3qW3iHd6IZRXEYHD1Ml4ZIwafCZyQ5pTTKTdj++qS5BBbLTvjD
	 8+7OiVLgi8QOTVH/3aaYyJrnySB/+OzxoABC0IJnbohgvmjEMLdGL0/R+9L5bPooV+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZrw5s7x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2A606E526;
	Sun,  1 Nov 2026 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZrw5s7x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD891F00919;
	Sun,  1 Nov 2026 22:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571422;
	bh=TlXe8GaWIxgfUN9oJ8ZkUQcX+CJa5NmDUSw16Gb5fjc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NZrw5s7xCTCVTHEcPZ6ICCwQcLn1a+2gAWUq/xgjMGIwe62ebpNx35HwduJR74RtD
	 Wtw5mKLKuGifhjgEA6clDYtsUyRCTEfKuRo7vY1XkeSmTmXv1+e3p+HUli5e3ZTi2Y
	 i9rG4TM2uz4kteJn95cq2ahfPBpXAo1F/XJJuxWauBorD5YRiFJ6D9fY/bTnOZnYow
	 l3CSm8xldcSTJYHEwAGX80HT9M/wTRLLvM08uTOyVfY6M/fbZyBNdAOZq4LPlCSOvK
	 EYLx5PlMzCVUUQ2QdxFluRLGxcOv9MrH+Q5IPus8GLHZb/lazuMZ7S0yVjXdFYfw4O
	 hw/UwjPRITAgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401F638003B8;
	Sun,  1 Nov 2026 22:17:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] iommu/riscv: Report cache coherency capability
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357142079.2624073.16238514118211699768.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:17:00 +0000
References: <20260821112100.572037-1-andrew.jones@oss.qualcomm.com>
In-Reply-To: <20260821112100.572037-1-andrew.jones@oss.qualcomm.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jgg@nvidia.com, tomasz.jeznach@linux.dev,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
 palmer@dabbelt.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Joerg Roedel <joerg.roedel@amd.com>:

On Fri, 21 Aug 2026 13:21:00 +0200 you wrote:
> VFIO and iommufd require IOMMU_CAP_CACHE_COHERENCY because they use
> IOMMU_CACHE mappings and have no userspace cache-maintenance path.
> 
> RISC-V page tables preserve physical memory attributes for IOMMU_CACHE
> mappings. Svpbmt marks mappings without IOMMU_CACHE as non-cacheable,
> but preserving physical attributes cannot make a noncoherent device
> path coherent.
> 
> [...]

Here is the summary with links:
  - iommu/riscv: Report cache coherency capability
    https://git.kernel.org/riscv/c/3069e8f3e1e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


