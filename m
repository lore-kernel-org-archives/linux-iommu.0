Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19621019A;
	Mon,  3 Feb 2025 19:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610124; cv=none; b=gkOuK+s7E3n1MPTciozxDTyQUc8WUP1T7gW788qBsejRNRV1UE73I9THQfTnblOcSzkXn4ra+8S4mXNu1faWgou3hx67OfAYNsu2odNLe1zYKSjaE/NjCSOxi7nuS+f5u5VFmYhSNgndFRBuHMbdNhxeVZ1yBVmpRFUIg3M90FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610124; c=relaxed/simple;
	bh=EHqDeqDddNIApfCVLPDVdinDu5ErQOOB8uPUawpqjOA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ailVdHbClBDR8TMQDDV6yc1Ilejozp3X8JODWnJ6ClAi6ZHEmfUnbSbMZgR+nyhIvpFA+5HezssD2C8qwVmGQpq58Z+xZRlVSkAif2rerJcV3Ti89Ie4kR+rd1Htsu7HgPMA6CkKjxS+XiG7UiTyRElR8VqkwpN3Urb2A1tbBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVgbLtYI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVgbLtYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B609C4CEE3;
	Mon,  3 Feb 2025 19:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738610124;
	bh=EHqDeqDddNIApfCVLPDVdinDu5ErQOOB8uPUawpqjOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AVgbLtYIrdpvCq52oUDxyK4YHXb5iofWOH/lli5LhAaiyHBvqP3CWsOW5Hy6tiW4l
	 9vuNOIg2goB/R2/vlCShLYIBOaDk6p2ocLHMvJyb3HL8EzScQRTtJ3Bn6+d8Fj5c0S
	 TtzSvNdOtLb1UNaf7MwOs/1ya8lU8UhQXGj4PyAQw9xjEFt6WooODqVkhzx+K2c5is
	 Gr0D5CsHvLosSWL1UH9pKeN1aCWNDNLGRzsVUIwy1ndfd5+7vcAr2VdK1icmGdNkPX
	 FfV7qW9d/zY836F6LxZ9KRc8+NDQrHWQgY5n6mVKrU4HbotvExgOWhRtkbe0QC//FL
	 npmInPiPK1kwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDA2380AA67;
	Mon,  3 Feb 2025 19:15:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/1] iommu/riscv: Add platform msi support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173861015130.3409359.9807283652658448466.git-patchwork-notify@kernel.org>
Date: Mon, 03 Feb 2025 19:15:51 +0000
References: <20241112133504.491984-3-ajones@ventanamicro.com>
In-Reply-To: <20241112133504.491984-3-ajones@ventanamicro.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, tjeznach@rivosinc.com,
 samuel.holland@sifive.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu

Hello:

This patch was applied to riscv/linux.git (fixes)
by Joerg Roedel <jroedel@suse.de>:

On Tue, 12 Nov 2024 14:35:05 +0100 you wrote:
> Add MSI support for a platform IOMMU. May be tested with QEMU when
> including [1].
> 
> Based on linux-next commit 28955f4fa282 ("Add linux-next specific files for 20241112")
> 
> [1] https://lore.kernel.org/all/20241106133407.604587-1-dbarboza@ventanamicro.com/
> 
> [...]

Here is the summary with links:
  - [v2,1/1] iommu/riscv: Add support for platform msi
    https://git.kernel.org/riscv/c/d5f88acdd6ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


