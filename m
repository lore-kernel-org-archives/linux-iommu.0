Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB1AAD24
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789871; cv=none; b=LOxXnCR0rMRW8ZmKPZ5W27Xs664UPgl1XZOkFlbCxU+RHLLKDLq5WOw2QVb8mYHbKaXdUiU0Cm/pC84HT6pKvERDZ+4kBt50b9TlK9/5kiCEe2riuic1xCOhVN9BwM6aPSdHeg2Bb44wa4r8rhADMQUUmuanJkAAjLX6q4Iq6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789871; c=relaxed/simple;
	bh=BW1fpZ2eE11MnLUwuGiY1eXfukovEfxi8eg26Is0Po4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/4G5STzVt5JAZub5MuDtYiAsaAnw526chXwsDeoxUrvhR8IKW7ljpKcgIkZNheGV3NaNaSqfKWiQjwrMTrf/d/rS7X6igJotGL8vftdgq2MRO9rZ8VNZzwD3RduN4E28QIb8M7evaGxKmwJ4z0WUtuqIyAFQj8CWwYuPUstAho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tf91pXqk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tf91pXqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD62C4CEE2;
	Tue, 10 Dec 2024 00:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733789870;
	bh=BW1fpZ2eE11MnLUwuGiY1eXfukovEfxi8eg26Is0Po4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tf91pXqkgLOxZ1uTzpc09SuWes85x1ft5/rr1kHFH6lWkEMz2SgYPgu2oxFfAg3vX
	 F0NTXSySKLgnUv2w/p6Ysxtb2KWA3G5P7KVnx7egsvIuojqJg+3yhNys+rdOEdAeQb
	 FfS3w2b4gWueOY5ZCYb11OetdGRdWUFUnt2cXH8WhGtrolPJyPhqXBvpzHGH4aHxe/
	 KqTUuasmVZTh9p5n0vL+aAgBYI1kHW8v48YaR96UBC9otc05cHIdDLtzRUFSJHw1IJ
	 GeJzlDEEJ9TKpKCtxs0Mb325kjNMTiFnhpcqAuBtUsTHKHRUML6xwQot1DcshOpUDH
	 j/CZ68/Qv7PxQ==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org,
	Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	quic_pbrahma@quicinc.com
Subject: Re: [PATCH v2 0/4] iommu/arm-smmu: Minor probe_device related improvements
Date: Tue, 10 Dec 2024 00:17:31 +0000
Message-Id: <173378441488.4186336.14522482976618451984.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1733406914.git.robin.murphy@arm.com>
References: <cover.1733406914.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 05 Dec 2024 16:33:54 +0000, Robin Murphy wrote:
> v1: https://lore.kernel.org/linux-iommu/cover.1731088789.git.robin.murphy@arm.com
> 
> Hi all,
> 
> Here's what I probably should have sent instead of rushing v1 out
> earlier, now rebased and polished :)
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/4] iommu/arm-smmu: Make instance lookup robust
      https://git.kernel.org/will/c/7d835134d4e1
[2/4] iommu/arm-smmu: Retire probe deferral workaround
      https://git.kernel.org/will/c/97cb1fa02726
[3/4] iommu/arm-smmu-v3: Clean up more on probe failure
      https://git.kernel.org/will/c/fcbd62156742
[4/4] iommu: Manage driver probe deferral better
      https://git.kernel.org/will/c/46b3df8eb9bd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
