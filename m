Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0ED13D891;
	Thu, 25 Jun 2026 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782414611; cv=none; b=QdncEeiBSm/SHcSmn3cc9dEJVEGXi1+naTsMRsKa1tZ/D+t3ICqDBvzEcXokgRrWD6ooFJ+ocWROJ8ZQ9cm7CFNfVgIwqG4JJpeK9LPN9XDI9o/ukMYaROD3/sFtrTJ8Cdly0V4fniyZznGHBa2jL8EkQm8T9fpEnn1/AwCbME8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782414611; c=relaxed/simple;
	bh=ZdgL2Lc0ryUA0ibB0pjtTZsYIu5fUd/Jd/cxW+XLZbA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MXM3msikMfDtSPbYlM3o0jPDGZKpo/0eWzMIAOoK2chiL+TxoHGkQP1yT0S7IIi1Rk5JDHLFO+avrxiWl+CpcN0yWMipOQWmuBEKFPcTQ9Db/s+LSRNGctebTHBnLeSAXR+r7vJC5V3SlOzs9BoVzK1jOGQaCuvrEYO4iyiFLL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhkW32Ur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhkW32Ur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DFE1F000E9;
	Thu, 25 Jun 2026 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782414609;
	bh=LyHwI89PwTTZzRxgq2rdQ5zV3fciS/lmKH9dk7gb0Q8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=dhkW32UrkT5rDdGocO9RtnOj1cYeB+4/hhudpM91GZ8p0UQrshZyyFnWwRA4TxZnk
	 /yN0pgLfyMbp1JWv0GkbLeeqbc9zkStPvfxpx5OYlt8ijUiB/mKbm2wNB9KfR/Bdls
	 DfGJis2oGwDXT1/1Z4iYEVIFaVunhyHVCf3OIWIIBL0YPHPyQpKepDfZGMvcRm19Rc
	 NvsduIZ2vaeech95Cw9qLS8SY49fPaY2n3oPNZdRcX50q5XvTVoguacBKFvr0ozwTu
	 wlaPIT/AIRZ9lD+A/Gu5Smnjt/UnRYF2UFbV0YNIoeN7blTiAh4q9+PI0G7GB5/KPA
	 z//+0sMmBEWsg==
Date: Thu, 25 Jun 2026 13:10:07 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: XianLiang Huang <huangxianliang@lanxincomputing.com>
cc: tjeznach@rivosinc.com, markus.elfring@web.de, joro@8bytes.org, 
    will@kernel.org, robin.murphy@arm.com, paul.walmsley@sifive.com, 
    palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
    iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] iommu/riscv: check pte null pointer before
 use
In-Reply-To: <20250807033252.1613-1-huangxianliang@lanxincomputing.com>
Message-ID: <4264ac5c-8968-24f7-4829-cfe30e8ac372@kernel.org>
References: <20250807033252.1613-1-huangxianliang@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Thu, 7 Aug 2025, XianLiang Huang wrote:

> The riscv_iommu_pte_fetch can return NULL when the provided iova is not
> yet mapped, the caller should check if the returned pointer is NULL or
> not, but riscv_iommu_iova_to_phys missed this, which will then lead to
> a kernel panic.
> 
> Check the pointer before using it to avoid the bug. Now, when
> iova_to_phys is called with an unmapped iova, the kernel will not crash
> here.
> 
> Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
> Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: XianLiang Huang <huangxianliang@lanxincomputing.com>

Going through some of the Patchwork backlog.  The code that this patch 
changes no longer appears to exist.  Care to take a look to see if 
something like this is still appropriate?

thanks,


- Paul
