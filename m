Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF4E4CA779;
	Thu, 15 Oct 2026 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792099950; cv=none; b=clOveKCGSP3ol1wQyVOeTwSTgA4/PR9hDnrtZzepBB+Lfv5n7sn9YisdWZaIu/+emT141CEcKUuTFjQ+/mJwQfWeAYVhaVCcK/NA14buTQdRiYsAFCmLvPulxiP4FOEe0XNhwKCArXiiDl/4aYFIyWjTdl5vV4Y3p7xotU6pGHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792099950; c=relaxed/simple;
	bh=VJ/EuIc4xnUgkZ0HNak5wE/85JzasmjQLU9DlimpWik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T3AxEc4zstijgJ7VgWSW+Ii+KruvhJfyV6c8j0J9ns/ZlNYc4a/5ENap2/CnRrRwvV2xufL0wd18hbjxAaJGkU5h1eQzKBWBUvWS9zHENSpvENufj3EPbD2nY6qdTjHNUFym8WSv5GSvAChFtm4DhwKtM8brorbfkzNvCf99W1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVC8jHQB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVC8jHQB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D5A1F000C4;
	Thu, 15 Oct 2026 21:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792099949;
	bh=VJ/EuIc4xnUgkZ0HNak5wE/85JzasmjQLU9DlimpWik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=BVC8jHQBBG50dSiZRBEFnjLvlb2bWBoXvw8jWKzK8mjUCK+k/z7dWqiWRjOZ44KKn
	 PudYgtsQQ+RpRKZeN34BhaK/XnD7xDHp0qGjkyuS+yAAIt9pxaNdH+PTv9TKAl4oGW
	 R3gJIEHqVVDwuH1+wN0Szi3PoyA0UtiTMbJVsusO2TgyrUPLh/YgNAM2zZSpypa2sB
	 VHUlFm0ZLe/yza94LaLmVnnzB5m4zF8TwqngdsmAzvOUsTw0do4vQLMXZtKjlkdgdX
	 Ziq6VW63idGionqiq/u7CSrzyRqxixu5kfD4hZsalXoNy/WVCr/VZM5aQnfnZGaNWA
	 uVhgxMAXlFTKg==
From: Thomas Gleixner <tglx@kernel.org>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
 tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 anup@brainfault.org, kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v6 11/16] irqchip/riscv-imsic: Support IOMMU MSI address
 lists
In-Reply-To: <20260925151659.419512-12-andrew.jones@oss.qualcomm.com>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
 <20260925151659.419512-12-andrew.jones@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 23:32:26 +0200
Message-ID: <87y0byd505.ffs@fw13>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 25 2026 at 17:16, Andrew Jones wrote:
> RISC-V IOMMU host interrupt remapping maps every possible host IMSIC
> target into one contiguous IOVA range. MSI message composition therefore
> needs each target's position within that range.
>
> Prepare the complete IMSIC address list while allocating an IRQ. The
> list is guaranteed to exist after IMSIC state initialization. The IOMMU
> backend maps the pages and caches the contiguous base IOVA in the MSI
> descriptor when translation is needed.
>
> When the descriptor has an IOMMU MSI mapping, use the selected logical
> CPU directly as the page index within the IOVA range. Use the same path
> for initial composition and affinity updates. A zero iommu_msi_shift
> means no MSI address translation is required, so keep physical messages.
>
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Acked-by: Thomas Gleixner <tglx@kernel.org>
