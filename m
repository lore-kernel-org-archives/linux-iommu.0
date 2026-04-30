Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095C53644CA;
	Thu, 30 Apr 2026 03:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519607; cv=none; b=FwH0lgHz7xy1pmVv7BQCVYyGU6IE56T/ry42RIKJViTf0Ww2iPu4Uo2WwNeWgAj3Wv++6I7j7Qmpx5DewYaAjUDa7J247+r/XlI+/6SekbbK8XF2FkfHp1ZB2IEnzErRh3bXacmnAqV4wONnwbAycFTU9EykRAVw6TwT9eP7gbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519607; c=relaxed/simple;
	bh=ygd4/5zQwKw6HFpt9wXfhit6omZnPB1zR61IVZpW//U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ctNOp11hymX/Z9yalX3ZH6uVTgSNHtf8u3K0KaCwrpOQSAoX5IZYiJVUIiMywUMQB1v3G9/9YCg/mmM+Mzsl86DE7qwoK6xNmssyu1PuACd17Vbf8S9VD7OsKhUlExAaFkX24BFX1VV0rqnBUqyGSYJnN4RkxIBDVH007RR9zhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQoB5rFO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQoB5rFO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD76C2BCB8;
	Thu, 30 Apr 2026 03:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519606;
	bh=ygd4/5zQwKw6HFpt9wXfhit6omZnPB1zR61IVZpW//U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gQoB5rFOjfBdiU1remaLMpdCERG0XO/S8L9KIJJ46qsjLFch4mfI4GU6STXyHw41C
	 7ze0a9zZbhUANeSGx75zc5M7e0YOxOifvPyC629jtNQzIujew0tNzQp1JBUW4HU7iN
	 tF+FaIVkmMzj+lofiKmWT5Gr77I2xzI4vBfP0/ypEHDUFwTRXrb1AjlfoYeIPhni6f
	 wLeI1QiJ/Pf6Ed3MOBUrumeK/BRZQf/4xaum+nq5v49XPq3Nqofa5/UIK/mMzYpBfR
	 9kcF0QIafOZ9EtqKedkT4RUyw9D4FPpIOxjImeGpl3CLyNeYRuOXOdBjmdVsVYd5h+
	 VVc9qGak0oTiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDE53809A07;
	Thu, 30 Apr 2026 03:26:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] iommu/riscv: Skip IRQ count check when using MSI
 interrupts
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751956179.2274119.1428846442277871195.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:26:01 +0000
References: <20260130065420.16811-1-guoyaxing@bosc.ac.cn>
In-Reply-To: <20260130065420.16811-1-guoyaxing@bosc.ac.cn>
To: Yaxing Guo <guoyaxing@bosc.ac.cn>
Cc: linux-riscv@lists.infradead.org, tjeznach@rivosinc.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Joerg Roedel <joerg.roedel@amd.com>:

On Fri, 30 Jan 2026 14:54:20 +0800 you wrote:
> In RISC-V IOMMU platform devices that use MSI interrupts (indicated by the
> presence of 'msi-parent' in the device tree), there are no wired interrupt
> lines, so calling platform_get_irq_count() returns 0 or -ENXIO, causing the
> driver to fail during probe.
> 
> However, MSI interrupts are allocated dynamically via the MSI subsystem and
> do not appear in the device tree 'interrupts' property. Therefore, the
> driver should not require a non-zero IRQ count when 'msi-parent' is present.
> 
> [...]

Here is the summary with links:
  - [v1] iommu/riscv: Skip IRQ count check when using MSI interrupts
    https://git.kernel.org/riscv/c/7217cee35aad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


