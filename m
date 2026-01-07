Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D553A0B24;
	Wed,  7 Jan 2026 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767823166; cv=none; b=qRuOqUoC7T2Vy9fosKlLrZ+Is602zjYs6Uw7aBHmxxwiG2sGN7ibKrRueaytzr4fGNZ8OpcX7xFIohzDDk65lVXwCnnuazmA/EsnOTIAvgl7POdTadJ9MYnXzylPE5ecH+HrBWZ/g0QAKKoKqrwtruPtHk59V4rpOz778hG+080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767823166; c=relaxed/simple;
	bh=jkRGEmXj8A9PUTqs9joDQ6ARfY3aQfH/gvw8Rj5b87o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmUWJUpw/uJiKtAe9CBFis8s5ekWOsUBUZ3qFX3EJXxuWEBPZ4pGhK74gjtiV3utRSiPaa6o2YLR2clN85BtJTssQb+ViCtNRQnqc1uqKBdrOyP8OHRazQD5c5kL9wUIV+3sBr46mhAxCvVd9jUK7uMMrkCAWBbZe1CjxDQhEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIEI2AFt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIEI2AFt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601BBC4CEF1;
	Wed,  7 Jan 2026 21:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767823165;
	bh=jkRGEmXj8A9PUTqs9joDQ6ARfY3aQfH/gvw8Rj5b87o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dIEI2AFtMwtI1cxjEEelpcoqlQ4KJ9tYoFvYue/duTtQRU3jq2cXtmPiVjB4Dgalq
	 KsgZCwLQf6shBUYv1lhpC6u1o/t9rfL4Hr8t+vtocTliGHxg61MnxdDNUx8g6lzHZM
	 d3nxaUtpcTEJ7Ej50ib6pFP1wBm2LWFOFMUfHV0GzFG60B65Yppkg0UxOpZq/ZxxqY
	 DF0PT6RA5XbSTFIpcOcgp4XmpCTctt2+IeawTozG2etcEZEz8XXQMG69WnhUrNvHck
	 PnsRKxnvSoSo+HTn8XLprDDYa6rXGvG/8UX4rC++M05sKj+vlIztH684iJIeDy/5NR
	 AMM9FFFQWDKcw==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mostafa Saleh <smostafa@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	joro@8bytes.org,
	Tomasz Nowicki <tnowicki@google.com>
Subject: Re: [PATCH RESEND] iommu/arm-smmu-v3: Remove IAS
Date: Wed,  7 Jan 2026 21:59:11 +0000
Message-ID: <176782095435.3284849.16107001420143134229.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102205353.2725509-1-smostafa@google.com>
References: <20260102205353.2725509-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 02 Jan 2026 20:53:52 +0000, Mostafa Saleh wrote:
> The driver only supports AArch64 page tables where OAS == IAS.
> 
> Remove the extra IAS tracking for AArch32 as this feature was
> never implemented and that was creating BAD_STEs for SMMUv3
> with stage-2 and OAS < 40.
> 
> Further discussion on this in:
> https://lore.kernel.org/linux-iommu/20251130194506.593700-1-smostafa@google.com/
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Remove IAS
      https://git.kernel.org/iommu/c/5ac66ed8417f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
