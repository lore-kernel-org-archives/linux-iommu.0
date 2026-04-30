Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9537B02E;
	Thu, 30 Apr 2026 03:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519570; cv=none; b=l6lXhtKVYNdcBcN9e6/u2/IOc72RKJw2c2BjFdJa8TVkYA4Wi7F35RSpRm/AcBfu2e5b2JEkOVjhpQGb6CQnu9J0LFtzrLG0fssCmdj22vB0DjE+5il8ANSW/TAXAbsQK+l6clQV/OFPsTWRfiR+3IktfIG9pH5hBob4cDpuR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519570; c=relaxed/simple;
	bh=MMezDMVVjOGv9weqyAZbIsRz2DJ3hj00P7r6+llifw4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hx1lRKrGmGK+ErduXIidRWzzxCb4v3j3QIKE2JElB93mH19BAu6awdj89Ct1X1u8JjJR17t8RJz8m356PuaKJICpJE8yRwiNXQRiLDp1gVb2Ks1wd5UlYaQ9evAnL7MxVUDyKTiALPDQC6ZUJs2labXoiumT8KHJ1D9omwsF4kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRz+s+9c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRz+s+9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310ECC2BCC7;
	Thu, 30 Apr 2026 03:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519570;
	bh=MMezDMVVjOGv9weqyAZbIsRz2DJ3hj00P7r6+llifw4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vRz+s+9cOCsRHbqoqF9y7TN15mN/t4/9y/aFbWHbpYIG3rFsaAN0ZWWnZ2figYLFH
	 qT0+vFYiTpcJUDv6K5E2yw0gaZzcQqYtf0ghbw54gLZwsSfpE55l1HE/BpoB4X67g8
	 iJvxiIl2YR5VpH2ISyB7KAiTe2rsIoPsu/ewK8OPaszr9oFFOhkeMvvN6d4ZGtj2tD
	 /niHYE+0B27p8MTHXsbXjLboVTrLQyIoSFRfGpstoQGU1O/mfEHPflSpiOTAaRzp50
	 8uLjSSyzUJslLvLFg4VO8nycygv6v4kX2p17ejlhyQCsZE+Rtmu6AkyOKAywW0PcMt
	 52QngJhEtYsFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEE53809A07;
	Thu, 30 Apr 2026 03:25:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] iommu/riscv: Add IOTINVAL after updating DDT/PDT
 entries
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751952504.2274119.2285271071573350641.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:25 +0000
References: <20260122143224.25146-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260122143224.25146-1-fangyu.yu@linux.alibaba.com>
To: yu fangyu <fangyu.yu@linux.alibaba.com>
Cc: linux-riscv@lists.infradead.org, tjeznach@rivosinc.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, baolu.lu@linux.intel.com,
 zong.li@sifive.com, andrew.jones@oss.qualcomm.com, guoren@kernel.org,
 ajones@ventanamicro.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Joerg Roedel <joerg.roedel@amd.com>:

On Thu, 22 Jan 2026 22:32:24 +0800 you wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> Add riscv_iommu_iodir_iotinval() to perform required TLB and context cache
> invalidations after updating DDT or PDT entries, as mandated by the RISC-V
> IOMMU specification (Section 6.3.1 and 6.3.2).
> 
> Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> 
> [...]

Here is the summary with links:
  - [v2] iommu/riscv: Add IOTINVAL after updating DDT/PDT entries
    https://git.kernel.org/riscv/c/f5c262b54497

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


