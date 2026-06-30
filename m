Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06739903E;
	Tue, 30 Jun 2026 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817607; cv=none; b=OXMdy10p5OSQ7aZkUqLtnoqcS2+ImRzo4nZOVUyKtFSwhO0smw9j8xZNOGJ40aHlpzrGp9QCEn7gceanNxeMsQkdxDBShDZHu9tufEvVWfeYe0ZYLXI4GgPD2s+FrMm6lax8NjhrZvs2quhw39Dcpbm+E2rk3t10jIniYu6anG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817607; c=relaxed/simple;
	bh=maW5QmNbvWJ3DKwXLaa9uHN3yb+oFv9LznK2661BZSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p75yS+2ccXO7W9DaHFFqoKfLKlxdt+A4oL4EmAFgVhVdGoyOuRamLO+Jf5al3d0o/nzRPnY4P1u13X7i3izJ6eQgOO6elARotCTCMwmo0NPGSX2LLwFVDMMWozIoaLXVGsb3hgrQUVjoWuRCOnboYX1U4nVpn5OoxoHmaB8Yi1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQIEMpuU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQIEMpuU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C171F000E9;
	Tue, 30 Jun 2026 11:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782817606;
	bh=pkBGpLmtsEEeRaJhMIRqkL1GKSIf2XGxguwcqieH/g4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZQIEMpuUmQZkczHS1IWJqPDhkgBj56796odq3/JvTLVjcNHHc31D/nttFgIixltDD
	 fvh/NWoOmlY1pRVfm4kSh17IeHaesxP4GLpUn/HExfYszLJWNcgrt7bQIPBs1VJ9ie
	 E+X/tXsHlnOljHy/HM6tm2+dq7ONAjO6ZtbVU4IbwuQuU2RjR27PHLYoftDiigEuLR
	 YlNl5z2+Y+CDger9PLjYw/Yd8Kbz124TcBuYx71ie/F4xSgfGU6bbg5zzSVPHwHufU
	 /JR39e288Aj2Vg90vyf64D4pAv0ul+QBW9QTUOyCPHglNRMUMMKm0Ot02y5ILAMhI4
	 hzNU9Pif1F/1w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: chenhuacai@kernel.org,  kernel@xen0n.name,  pjw@kernel.org,
  palmer@dabbelt.com,  aou@eecs.berkeley.edu,  robh@kernel.org,
  saravanak@kernel.org,  bhe@redhat.com,  rppt@kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  loongarch@lists.linux.dev,  linux-riscv@lists.infradead.org,
  devicetree@vger.kernel.org,  kexec@lists.infradead.org,
  iommu@lists.linux.dev,  zhaomeijing@lixiang.com,
  catalin.marinas@arm.com,  will@kernel.org,  alex@ghiti.fr,
  akpm@linux-foundation.org,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  ruirui.yang@linux.dev,  m.szyprowski@samsung.com,
  robin.murphy@arm.com
Subject: Re: [PATCH v4 08/10] arm64: kdump: exclude non-dumpable reserved
 memory regions from vmcore
In-Reply-To: <20260630074715.4126796-9-chenwandun1@gmail.com> (Wandun Chen's
	message of "Tue, 30 Jun 2026 15:47:12 +0800")
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
	<20260630074715.4126796-9-chenwandun1@gmail.com>
Date: Tue, 30 Jun 2026 13:06:40 +0200
Message-ID: <2vxzik70i8xr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 30 2026, Wandun Chen wrote:

> From: Wandun Chen <chenwandun@lixiang.com>
>
> Reserved memory regions are excluded from vmcore by default unless
> marked dumpable. Honor the dumpable flag to filter out device firmware
> regions (e.g., GPU, DSP, modem) reserved via device tree, since they
> typically contain data not useful for kernel crash analysis and can
> significantly increase vmcore size.
>
> Use of_reserved_mem_kdump_exclude() to perform the exclusion, and
> pre-size the crash_mem array via of_reserved_mem_kdump_nr_ranges().
>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> Acked-by: Will Deacon <will@kernel.org>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav
