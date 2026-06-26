Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC3B3E44ED;
	Fri, 26 Jun 2026 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462086; cv=none; b=tXs21IPNQO7ZIBojGeKK2oNJ6xY2nVsde1eReLlYWiFfEdxCP0Olb0h1VYsFdDpNG+g8Wn5CrEEhALLJDbLkfojE/E0YKSE5rZfxX0M7zzURQIicY3TBb+YqXZda/tSJ7xg02qYbgv3F6wCa4MmY3CkoA0wp3yP/64WonOw896w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462086; c=relaxed/simple;
	bh=dSaiTT1rGFr8qpEYcgO8/FtYUP+SfgT2MBw8poSyEyo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CSDd7OCCR5usxP8Q/zpn3NuxLNKr/o6mujqbzt8OTXcWsANYSicL+ofdLuR8MDwyd4XfnRSujCoMPnvyyodTV8pakK8ougJeB+1MigkXweZy+wP77fipKz8t47e0tYo90KTcERzRyUyqprl9kP3b0qiZb1ujXRA6XnWkLSWXOQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMYx1Gto; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMYx1Gto"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCA41F00A3A;
	Fri, 26 Jun 2026 08:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462073;
	bh=JvPo55g3eS2w4p/tC+pRBIWpmLSFQYMnnMNilcteyYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aMYx1Gto+N0bypalZDoOlr81wF/uH5UhY0QLhvs3GfbDwe5bOFn2glLQH8D+H7Nev
	 0Ha6rhez+fSUCy/wkeqZ3/bg7F7Ed9gH95xZyZB4l4cOrd6O06o1PaxzzmD5RkMEEK
	 Oj8M+q3f+yWMfsAPzd/3h1rE4oaTY7Nv5DjHgJFBAFox7DT9p0wZgwni9qaHDUM4D8
	 11J5ZTpZfXRQJodF+odR4kikxgiW5zjCjdReouqymf/4FfvtZCcwCnMGG/C2ik6cSI
	 FyRPycWIgCmEPNB4nTJ1B9JhyFj57Rv4Su4SabrWN+t+hc9bhF6FrvcKRIVT00h1Sv
	 XXokDVsnCNwzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5695939389E8;
	Fri, 26 Jun 2026 08:21:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] iommu/riscv: Support Svpbmt memory types in
 generic_pt
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246206005.3816447.8810357368655365502.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:00 +0000
References: <20260512074142.16356-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260512074142.16356-1-fangyu.yu@linux.alibaba.com>
To: yu fangyu <fangyu.yu@linux.alibaba.com>
Cc: linux-riscv@lists.infradead.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, tjeznach@rivosinc.com, jgg@ziepe.ca,
 kevin.tian@intel.com, baolu.lu@linux.intel.com, vasant.hegde@amd.com,
 anup@brainfault.org, atish.patra@linux.dev, skhawaja@google.com,
 jgg@nvidia.com, nutty.liu@hotmail.com, guoren@kernel.org,
 andrew.jones@oss.qualcomm.com, kvm@vger.kernel.org, iommu@lists.linux.dev,
 kvm-riscv@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Joerg Roedel <joerg.roedel@amd.com>:

On Tue, 12 May 2026 15:41:40 +0800 you wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> RISC-V Svpbmt adds page-based memory types (PBMT) to PTEs, allowing
> mappings to be tagged as e.g. normal memory, non-cacheable memory, or
> I/O.
> 
> This series wires the RISC-V IOMMU Svpbmt capability into generic_pt
> and uses PBMT to encode device memory attributes for IOMMU mappings.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] iommu/riscv: Advertise Svpbmt support to generic page table
    https://git.kernel.org/riscv/c/f196a8668797
  - [v4,2/2] iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V Svpbmt bits
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


