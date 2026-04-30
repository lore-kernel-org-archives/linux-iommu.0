Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508B7346E46;
	Thu, 30 Apr 2026 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519556; cv=none; b=n0yvx/obuzn8hBkeIKFFKa4VwfKWqxEz8gtH+JrZrThLXfDO/CGV8aUfTMfsdoEo3UBHfy/LQyFgot8x108Ot8jDvxrRgTR0dmpZSVIouVdhz/V0jMI/S3MPLCM60PT654EnHOL90x5HUN1uSmrnrKNCqZquhmDor9wl08kVJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519556; c=relaxed/simple;
	bh=szPW1uCqeNjuxpRKf35c7votk+r6wYXFiCCMDEk9F+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O4nmc99ROLXT1+ZC+zYaPJ1WSBSxdS244rlakmuatcDDXxmufEsrp1dCMEn9f3bAFpyGsqO5PIxri7TnRrDdm9m1ycEJYd1ayamVIn/5M4i1LYGPpucP2paCaBiL8U2boyzOVoJy4b0AuFwQ1bRWH+RGPxfdGZ+ffW9KqFSd7bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcVHchma; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcVHchma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEF6C2BCB8;
	Thu, 30 Apr 2026 03:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519555;
	bh=szPW1uCqeNjuxpRKf35c7votk+r6wYXFiCCMDEk9F+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TcVHchma7Ti4f25Tb42Qdy4/B1aY4IMmqDmHeKXgGQMHk0Y/XDu6omLd7HMot4nC2
	 qqkgtNf43wEE57ObFah4MpQYx/iUsBoqoXiwt9Q2FRYP6LvmRILJK2xLJ1+YojoLd+
	 W95luRnZSz1lkUJ9y8gVDNvsG7hOZvZXmcX7UMbHdE/HM+uGsgnDUwbUKCy0Q3zvJM
	 T0sklUqkyCFPWpTMDY3aWOY/V3Nes2YnTvpRDTLKV34JA8fvOImVss4J1wqmY68GSQ
	 DFQNLS3NZ7NK+idIVzM0QFnoMRtUzXEGf829i7BOqEfJ2TS3hMl7jx2rqfnoX60TmQ
	 +Jx39aV29qTbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDBE3809A07;
	Thu, 30 Apr 2026 03:25:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] iommu/riscv: Fix signedness bug
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751951080.2274119.8369417517084133049.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:10 +0000
References: <20260326175738.750060-1-ethantidmore06@gmail.com>
In-Reply-To: <20260326175738.750060-1-ethantidmore06@gmail.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: linux-riscv@lists.infradead.org, tjeznach@rivosinc.com, joro@8bytes.org,
 will@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 robin.murphy@arm.com, alex@ghiti.fr, mick@ics.forth.gr, seb@rivosinc.com,
 andrew.jones@oss.qualcomm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Joerg Roedel <joerg.roedel@amd.com>:

On Thu, 26 Mar 2026 12:57:38 -0500 you wrote:
> The function platform_irq_count() returns negative error codes and
> iommu->irqs_count is an unsigned integer, so the check
> (iommu->irqs_count <= 0) is always impossible.
> 
> Make the return value of platform_irq_count() be assigned to ret, check
> for error, and then assign iommu->irqs_count to ret.
> 
> [...]

Here is the summary with links:
  - [v2] iommu/riscv: Fix signedness bug
    https://git.kernel.org/riscv/c/553a127cb665

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


