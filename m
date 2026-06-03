Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955F43D75C4;
	Wed,  3 Jun 2026 04:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780462678; cv=none; b=tSeMGze+CXgKHsANNEgXc5vIXxoBgSdK+4kO3Xwole+rcpGSahzp9Bn9Ra1f8zgrktvkX6X/aFm/yO5cl2ypGkzwtdfXimZk3pV/YFBI240A2ICZpObBk4+WMo+ZA+WKjX9qIfw5Tb/ycwF2G7rRZepkZxkYu5TlKR3QcCTbVNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780462678; c=relaxed/simple;
	bh=12Ym84RqEfIRXvO2G39Cj500j/Jybx5Hx+kLiVCcd70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P3JYHKcb7wyTD3Zv0pTWzAhHZkMh2OFcgZgDjfEHNJsg/ttEqZs03w1tRyoZ6BtFZnH/gvMkPU+32cDp2IFTEPqDBZn4A1PnzHeRymE67iopC3EzTSCgwn6Cdne3g7VntB0Ozst0zIs4wh6LxpRfG2u34G0wHVI8dS9DhjjVsE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z86/JPlx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z86/JPlx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CAF1F00893;
	Wed,  3 Jun 2026 04:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780462677;
	bh=jD4w6wKjoxHSfozFu2VYiqc04aG0h3bgsraRgh04z2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Z86/JPlxzrkaiIL1Qdqcxys4g6wmJJEoYmwI6Addxo8+X+psox7igTdWThf2Kqder
	 /KNKQ5ZoGd/5PRcjzp4dCD9aCRZA1Qf6oWyHwW1TnwiDDeURXXE+BC2bmfGDx4YzqP
	 S/g7WHtRz8P0KVPJhGw4TIC+uRMfzxLvANN6b+aMJGiTvIcrJ4ZOt5r6kDQ+9ID+7P
	 UAtLt+X5VvEIxx0KdEWL9aJdLJY1L4iIpSE7MQkYlpujaxjKoUV6+dVnmsAdWSGTga
	 G8gpNiSqdAPLJtaXYAR59ut4NKzQdCLS5sBKMeNaFLaqaj8eIwJh/WxC+9i99/Nl90
	 vreR8vLoROrYw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, jgg@ziepe.ca
Subject: Re: [PATCH v2 0/8] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
In-Reply-To: <ah7nyK0-XVUM74rO@google.com>
References: <20260420061415.3650870-1-aneesh.kumar@kernel.org>
 <ah7nyK0-XVUM74rO@google.com>
Date: Wed, 03 Jun 2026 10:27:50 +0530
Message-ID: <yq5a7bogrzjl.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Mostafa Saleh <smostafa@google.com> writes:

> On Mon, Apr 20, 2026 at 11:44:07AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
>> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
>> are handled consistently.
>> 
>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>> shared/decrypted buffer handling. This series consolidates the
>> force_dma_unencrypted() checks in the top-level functions and ensures
>> that the remaining DMA interfaces use DMA attributes to make the correct
>> decisions.
>
> I tested this series on protected KVM and did not see regressions.
> Tested-by: Mostafa Saleh <smostafa@google.com>
>

Thanks, I will pick the Tested-by: for the v5 series.

>
> Next, I will:
> - Send the pKVM CC patch separately.
> - Review this series.
>

I will send a v6 dropping the pkvm patch

-aneesh
