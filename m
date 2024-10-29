Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E631D9586;
	Tue, 29 Oct 2024 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218535; cv=none; b=WtvzkIwLuA3NAoKt2Mic4VQshrv6zx63Y36avANPX0ZinmzNk8HCt9pPBoju4vHcRiFcpi9y0M9xUXeGLdXXTt9xSNwgdYaF5U4GB0r/Hm3O5VDxNMSrys3f8RMA+nxsgLmaKSXUSmQcf8VE5rJmL2SHggAlxgP+ThcVsRI4NQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218535; c=relaxed/simple;
	bh=bZ3umWUB2daTUxDUPol2jd5kvJm+C26sRYBZhWz/XMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/YZ7n5XttiXvnpkyPT1MxKaTzSDX892VOCem9CeNtjiyH9nlVNpFUBHAVzKVM9kTBZzX4Svpj+Hd2SvAqxGIMl6S+Li/Gqy9JBpRz4WzivwtLQBMvvSKDoki9yx4PNIOz2CM0eGcaK6cHmKV15xwrkYNHGGYqyazru3TSphHTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxS/G3K5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxS/G3K5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7530C4CECD;
	Tue, 29 Oct 2024 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730218535;
	bh=bZ3umWUB2daTUxDUPol2jd5kvJm+C26sRYBZhWz/XMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxS/G3K5GcU+Td77rJL/3ypn1M8aqJ1u6PegKPGZzC06zh7nvomc1EQ74nMC2xEzo
	 3T+Tw6sI0lqTLQlRKgPEaMg0GLW+72rncLuw6wDKsqeKA7xe9EaExYg1SnoItTTJM7
	 UD4OmU9BNzcmcnxnWhq/wEku7RqJsrxTn3stYsV9NXe7x8HN3SiVCsRL6vul0uPviw
	 lvewBpnjhs4t4BIN3MBkg02HM6d9kZ3kbKM5TKyy+HCmTmxa06cwvUwuz7elqzSqVK
	 pQj1Qgl3DHHczqAoutBh1qhjk+pMOyKj3km+HHxGqYlar+Dqn4iJTmNDrITZ9JB6rP
	 qE/8LLXao9m5g==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Mostafa Saleh <smostafa@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	joro@8bytes.org
Subject: Re: [PATCH 0/2] iommu/io-pgtable-arm: Fix for stage-2 map/unmap
Date: Tue, 29 Oct 2024 16:15:16 +0000
Message-Id: <173021209382.4087086.8047959157749601171.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241024162516.2005652-1-smostafa@google.com>
References: <20241024162516.2005652-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 24 Oct 2024 16:25:14 +0000, Mostafa Saleh wrote:
> The first patch is a bug fix for stage-2 handling of concatenated pgds
> that can break map/unmap for some cases.
> 
> The second patch is adding these cases to selfs tests.
> 
> While looking at that, I also noticed that the concated page tables support
> is minimal and not supported for many cases (level = 0, 2, 3), I wrote some
> code to support that so I can test further, I can send it later in another
> patch.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] iommu/io-pgtable-arm: Fix stage-2 map/unmap for concatenated tables
      https://git.kernel.org/will/c/d71fa842d33c
[2/2] iommu/io-pgtable-arm: Add self test for the last page in the IAS
      https://git.kernel.org/will/c/d64c8053378e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
