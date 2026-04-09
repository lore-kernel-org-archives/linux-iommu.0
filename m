Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C231C277029
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775739692; cv=none; b=LCeQpHYNzFOWAoBtzsHSu+qS76aVkkm8DOEzuACJw9LGMu6rfCyoomN2NhsKlQp9Wnlin4qTvKG3X78CNLM/IHZadZtxQonuE24H0hvPeig4S72tSJJJPH7mfnrOC+8xHJculCnaxFyD6iAP+ZpAeuqXi0gA5iT6KFtHsWDQMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775739692; c=relaxed/simple;
	bh=6W3U3VDlCLbpzTV99TmeDK4srJSBiDwBi01VNiPA8OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcTWuSDPUuvR0khm4DVC6XMqhfVlju/NrrUKBO3n9VgPDboZxfZFJMC/jp70bvXMsz8mtz52dxMrVNeG2N9ARKpDMcTb1EVqrJ26jAuREi4DMRRGcZs9R53HlyobUbHDVYeMph93M2zn4tAKMKKZdvz5u8ihxGdOOVZR0qPI5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNTx5PgE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNTx5PgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB90CC2BC87;
	Thu,  9 Apr 2026 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775739692;
	bh=6W3U3VDlCLbpzTV99TmeDK4srJSBiDwBi01VNiPA8OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BNTx5PgE72sQM0XhFtMiKA4lNNGkqsIJjPwS6keyIF2JG5iaKexAh/5vH3Sg1MIhA
	 iNXdUiqxotpZP9upWTJhDFnMKdBW+84GXhCJm/TsMVfqpjjecBKwVPBtCNBIVthyyy
	 hL/QgT5gyTrh4PpiupXhjw4xb8VskxkxKUSwPJDouEtxEeOjmQXXwPhDsDYu/1ukjq
	 0o2yiKwYjyfQh5I0l7SDfWFBmtaZjrLuS1R6XnHd5xU0lA5gJ7UI+tH5KC4Igvz9qQ
	 bZEi/cpyFh+Siq4etcU+Y54IV+bttIGayQJ9P3H34nvLJjZ89RpAIuIW1jx3R1cxls
	 wvSgHwUyjEyCA==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alex Williamson <alex.williamson@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/vt-d: Restore IOMMU_CAP_CACHE_COHERENCY
Date: Thu,  9 Apr 2026 14:01:17 +0100
Message-ID: <177573616112.3407083.9116162770642904970.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260408184443.3077333-1-alex.williamson@nvidia.com>
References: <20260408184443.3077333-1-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 08 Apr 2026 12:44:42 -0600, Alex Williamson wrote:
> In removing IOMMU_CAP_DEFERRED_FLUSH, the below referenced commit
> was over-eager in removing the return, resulting in the test for
> IOMMU_CAP_CACHE_COHERENCY falling through to an irrelevant option.
> 
> Restore dropped return.
> 
> 
> [...]

Applied to iommu (core), thanks!

[1/1] iommu/vt-d: Restore IOMMU_CAP_CACHE_COHERENCY
      https://git.kernel.org/iommu/c/ebfaf2bcc190

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
