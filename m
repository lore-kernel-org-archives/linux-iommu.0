Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1BD2135A4;
	Mon,  3 Feb 2025 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610140; cv=none; b=oDP3AU3f1ikJDhKKqHjckCaPrLyMpc8Shd804MvpUDx3vSk7CadpvDm9qYPCkakHlTyf1eXayonJdxyTPjQ2qS7C1Aj/03GvT5flrbwOe27pNkP7kjBCr1UoJeFrgsju/878VUXXUhjfo9I5/xAPeEJXz5+qriNHzD1ESdyE+QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610140; c=relaxed/simple;
	bh=58SXSSPdlErlCwG+s7CaTtY9cSDWI83jJUTdeosf8KA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VUl9ITrzbP6mkMcSoRMGEV0MnCHEjau7x4N1twt5XKNcMR2WLxhWL5g1j3j5yEWZGatlxm5UA0GcWHzTqKsea/bupBfRt+Ih3XBuczVUJP3epxLYMANN+iygguDSJ+Qnbe0lHxKsRtovZ7dhh5QbS5t0GLnV58vC/wgCy1z8/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrEUNtaO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrEUNtaO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927B5C4CED2;
	Mon,  3 Feb 2025 19:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738610139;
	bh=58SXSSPdlErlCwG+s7CaTtY9cSDWI83jJUTdeosf8KA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XrEUNtaOJN5MXxCswdaiqB30AI9L+r2EoBDZTUI0h0qr2kWuX7ILEFCoU2lPJ1dvX
	 Iq/PN6iF0o7dF9vciEkwQixbV994GecHSUn1ML0Id5p8aoJokk5PP72OPqDcUqAeZX
	 mDymnnSBD8T0LEhh1YnTMWfDmL2LYIjgXXOJOVm9HNfL5Q+r9T8k/zP7UOUUvOl6by
	 OLM50qa7KfZ+kcNfZAEYnTwug5/+fWWMMmCyso0K/70vK9gOY/RYsxcptspzBaZ6fu
	 DypEOim+J87Il06Vp3rqRTJ4yIr76qx9Gptl69PJ5poZCH+XFBwoVLJxfsV6wAobeP
	 vuW122wVimvAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF0B380AA67;
	Mon,  3 Feb 2025 19:16:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] iommu/riscv: Fixup compile warning
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173861016650.3409359.2529057243523266807.git-patchwork-notify@kernel.org>
Date: Mon, 03 Feb 2025 19:16:06 +0000
References: <20250103024616.3359159-1-guoren@kernel.org>
In-Reply-To: <20250103024616.3359159-1-guoren@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: linux-riscv@lists.infradead.org, tjeznach@rivosinc.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, baolu.lu@linux.intel.com, zong.li@sifive.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, guoren@linux.alibaba.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Joerg Roedel <jroedel@suse.de>:

On Thu,  2 Jan 2025 21:46:16 -0500 you wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> When __BITS_PER_LONG == 32, size_t is defined as unsigned int rather
> than unsigned long. Therefore, we should use size_t to avoid
> type-checking errors.
> 
> Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - iommu/riscv: Fixup compile warning
    https://git.kernel.org/riscv/c/10c62c38b073

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


