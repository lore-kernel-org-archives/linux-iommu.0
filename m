Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F94B4889;
	Tue, 15 Sep 2026 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474623; cv=none; b=J8WshAGfW6gbs/hGF/QJjb8YV5sMqGGWdT1q+10fGDaa1g/S1Evq6gNXsKm1e1Nw/A/XZDSY4iDmdTfNf1HyPniERj+SpDG7cxx2cQLgDrOtLj5frQotmWXCl3N5X2vDQ7yLOMAI0FCXo5cz7avR7b6WOFL8EAXDsVOm9WzGrOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474623; c=relaxed/simple;
	bh=myXobxlmtj0XqK63OH3Lw5zvazHQzXT38AfB8WNFm+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gk5XNjdLSiqbF+Z8lEYlPHHtvpRPajwBQjTub+PLdvmvGZLVzVuCqGUBjBnkLFerxnbgiz7gJEFB6TXMz24FbPptq6VhV1QXvbOteVdSjuPrbOlePuAI+EKhSJqQGUdKq4N70ITw4HAhCuBq5yj3Dw6DB/zWGxuWhBFphJy0N0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=D/aI1tex; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="D/aI1tex"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tz3AZMGcxx7KEDHkQDwBIzmCVSV/P8yGMrcOOooV8Bg=; b=D/aI1texgnZkg/xRoBRNqdwpEZ
	tffyZ6F1NuQ1p4eAo4OcSVI8Xn8jEwqWNrkoK6x4hkz6tPH9kynX9SU7GPVS1McyJXK4rg35C0HlQ
	1jxWXcZxoHDXcF7MsB3TlvhYdG3liQdyKIVUYT+nRt0lzXYpCl8O3GacUidkg9XMoEZ682Z5cDWBm
	DhlYhaSzdJL9lAUTvq5Viju6oD2Lo7muIDoNst3duu+8lPJ6s7dsdA01MyqgX9y6OvgXc8rQ+OfWB
	8A0FDcy+Hwd/QSp3XoDHlQ1VxWJ8eSm9SB80K/CFnsaYoFBBqv+s8TXE6w9jhDTehkKkEsPTJLwfY
	jUFQRcBQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x6S5g-004NqD-14;
	Tue, 15 Sep 2026 12:16:48 +0000
Date: Tue, 15 Sep 2026 05:16:42 -0700
From: Breno Leitao <leitao@debian.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Kyle McMartin <jkkm@meta.com>, Usama Arif <usama.arif@linux.dev>, kernel-team@meta.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] iommu/arm-smmu-v3: Add a cmdq_max_n_shift module
 parameter
Message-ID: <aqk207UQxQF1leEm@gmail.com>
References: <20260909095228.2174031-1-kas@kernel.org>
 <20260909095228.2174031-2-kas@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909095228.2174031-2-kas@kernel.org>
X-Debian-User: leitao

On Wed, Sep 09, 2026 at 10:52:27AM +0100, Kiryl Shutsemau (Meta) wrote:
> The command queue depth comes straight from the maximum the hardware
> advertises in IDR1, which reaches megabytes of coherent DMA per queue.
> A system with several SMMUv3 instances pays that per instance, and the
> Tegra241 CMDQV pays it again for every VCMDQ it preallocates.

Thanks. I've seen this issue while investigating another SMMU issue[1].
Thanks for fixing it.

Link: https://lore.kernel.org/all/20260911-smmu_fix_aws-v1-0-75870bf9655b@debian.org/ [1]

> Queue depth only bounds how many commands may be in flight before a sync.
> A machine driving a handful of devices, or one with a tight memory budget,
> has no use for the maximum, and no way to say so.
> 
> Add cmdq_max_n_shift, a cap on the depth given as the log2 of the entry
> count, the form the hardware itself takes in the LOG2SIZE field of
> CMDQ_BASE. Decide the depth in arm_smmu_cmdq_max_n_shift(), which caps the
> IDR1 value for natural alignment and then applies the parameter, so the
> queue is allocated at the requested size. The Tegra241 CMDQV sizes its
> VCMDQs from IDR1 itself, so route that through the same helper.
> 
> Floor the request at one page worth of entries. Without the floor, a small
> request trips the CMDQ_BATCH_ENTRIES check in arm_smmu_device_hw_probe()
> and the SMMU fails to probe. The floor also costs nothing: coherent DMA is
> page granular, so a shallower queue occupies the same memory as one that
> fills the page.
> 
> Assisted-by: LLM
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

