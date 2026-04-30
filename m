Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063D03859DC;
	Thu, 30 Apr 2026 03:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519589; cv=none; b=ivxwwpvd2/zRUPieyk1OSbT4taP5uney5O4jULUicMSkTVHmtTC/CBjcAgB9aQSi+M9vhZ8I2Vy/g73o91e+tCAhb591FPdv2zIo36l7Vn79F3Ram3OLNJBB+v2c6pot/0hKxClN+i9HQtA/pN4VS4dMJ5PfTDHtlsZpm4FWYZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519589; c=relaxed/simple;
	bh=t/IhH9m/iV8mWPsnbwCfk+wQ8phUXP0iVCLm62nekgM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TLEZz/1VzKt1+Sc5V/vtizm5QMscadO4Gm+JhizxzQD4pCD5ALf67hbp6BwvNmOGKPK0/+AmjiACZ7MtHXQVwSAXnzYZsXJRaavYzqBLR5BjKWKIKgqp1CablsEDi1lSapNoeirOj5pLMD2J3FMjvU8UQEgj14XRvghxR8kBbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpF3Vgb8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpF3Vgb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9CEC4AF11;
	Thu, 30 Apr 2026 03:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519588;
	bh=t/IhH9m/iV8mWPsnbwCfk+wQ8phUXP0iVCLm62nekgM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KpF3Vgb8vClh3eVGUOLiEjg5YMhw6Q62COWRP36faO3hhCtc6NL+f/PKVtFHprcLv
	 +cy86/Sqm+qovVDQKy0RxIUS4hmrvsJlf1Hwn9KqImRWfoBXpfJRNc9m3EcesmTi7r
	 oAIn3Rg87L/NP0ystyKJ2D18TfuHJ1Jc9La/42Kmkh05HlLK68BmZAAnBivRVHSFNH
	 JWcL4kYgvkiaBjvZCC7u3eBvwNfsbdiF7UPxJ+QBwz1mTSMR9/TuVHrJUmHW0TkPdZ
	 gAIwDMShph//h237cohxTI0tz5h+67//4L7R2sp3pIO5GZcx8bo7z8hqud0yp6dL1b
	 68f67mE865+SQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCE53809A07;
	Thu, 30 Apr 2026 03:25:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] iommu/riscv: Stop polling when CQCSR reports an error
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751954379.2274119.3865098518773080299.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:43 +0000
References: <20260227112640.20197-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260227112640.20197-1-fangyu.yu@linux.alibaba.com>
To: yu fangyu <fangyu.yu@linux.alibaba.com>
Cc: linux-riscv@lists.infradead.org, tjeznach@rivosinc.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, andrew.jones@oss.qualcomm.com,
 baolu.lu@linux.intel.com, zong.li@sifive.com, guoren@kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Joerg Roedel <joerg.roedel@amd.com>:

On Fri, 27 Feb 2026 19:26:40 +0800 you wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> The cmdq wait loop busy-polls the consumer index until it advances
> or the software timeout expires. If the IOMMU has already signaled
> a command queue failure in CQCSR, continuing to poll for progress is
> pointless.
> 
> [...]

Here is the summary with links:
  - iommu/riscv: Stop polling when CQCSR reports an error
    https://git.kernel.org/riscv/c/b2e5684558ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


