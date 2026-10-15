Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2AF30C159;
	Thu, 15 Oct 2026 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792099929; cv=none; b=oyWth02Lscpa+5AnP7nbuRJd/jE/ByKTwU7myrptVF2njvgeF+mrnIo4tgNxGhUV4Yede0zMPQR4FkfxNtde7AOmwykil68Ys0fyV/H1uz8RD2Xx3Kh2OyLDzENTzlMlEuy4M+KY/aE4aIUMCeFS/2qeCh/mB2tvgU1qmruosLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792099929; c=relaxed/simple;
	bh=YE1MtNRwJfcTNyZjDrwuFEDJnSop9M2Es5vzVnWdHI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bVuyE4sL8ct1vRagLRx8EcZYnGyDBPnTaxug9WSH8VUIR1X6qCLFa3hroFTOaS5zgqbptYoa1HzetjTQBvvdcEgVcT1bcxZeilMR1KQYrGZaJ3srXSFcB8VXNOhQaTVTuv7eWwqWU0eoCDKj7+/APihdK87PZgB93f6xslpHdz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLgi3bNj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLgi3bNj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391AE1F000C4;
	Thu, 15 Oct 2026 21:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792099928;
	bh=YE1MtNRwJfcTNyZjDrwuFEDJnSop9M2Es5vzVnWdHI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=iLgi3bNjvKJoF3GRUGVzHWzOUI0bgKHXJbxWDI2ybTFrqfss4Y7/mGhyMmOTCOLn2
	 Mnyz8OBcO6JOBY/yG9jMZhH03LeO0T75ASpV9KKDbtI/s7CcF2TBlGeTp9xNlUzaTH
	 WDsi/sUYzS4bbT4DPhBKS+xmVQ6lCgGomh8gSWtmRww7PPLZz/GpM3pZLL+oG87xAA
	 6ey2igX/EiXfHGuUgKhzMjHyaI0qB2hMGbv+HsxJjwk1gZtk1pEwrEUsz/GXP31OA0
	 t/gU9utCOxn4i9a46dTtNbNP1Ork6ykRdeC+dML4l5vMCz4x7G8EGzDQ1d6PPcWBtR
	 sd++OEkDTX3Kw==
From: Thomas Gleixner <tglx@kernel.org>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
 tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 anup@brainfault.org, kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v6 10/16] irqchip/riscv-imsic: Add MSI address list
In-Reply-To: <20260925151659.419512-11-andrew.jones@oss.qualcomm.com>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
 <20260925151659.419512-11-andrew.jones@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 23:32:04 +0200
Message-ID: <871p9qejl7.ffs@fw13>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 25 2026 at 17:16, Andrew Jones wrote:
> Upcoming RISC-V IOMMU interrupt remapping needs to map every possible
> host IMSIC target into one contiguous MSI IOVA range. MSI message
> composition then uses the target CPU's position within that range.
>
> Build an IMSIC physical address array indexed by logical CPU.
> Require every possible CPU to have an initialized IMSIC page before
> publishing the array. This preserves physical address zero as a valid
> target and guarantees the array has num_possible_cpus() entries.
>
> The array size and each target's index can therefore be derived
> directly, without storing duplicate count or per-CPU index metadata.
>
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Acked-by: Thomas Gleixner <tglx@kernel.org>
