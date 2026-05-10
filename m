Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B03C1DE2AD;
	Sun, 10 May 2026 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778441524; cv=none; b=DQi6aCjXp45KI8nRl/HLYn+K4u3XUmTNmeGBXEaFmCFKLIRKwsCmSJyDGy62u8e5jOSr2il/nH8DF6EEB3XrmHipwyd4ud8r+jTIP2+iKt5gwJM7PgmQqxdJa2OGfgqFlJGRw5Ku5ynw/klbdV9Pm6K+4KcINcBaw8yghV847pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778441524; c=relaxed/simple;
	bh=oosQGewjKOseq/Zf5kpRlYqAjqUau3hSHYi43sFgkAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FDKYXoDpyJtGd+h0/qdK/d1SXvy1NTIf+QdvpSIrFN+2KdpcAgG5szBN0+PMOr/ibwooJt8DYEy/dLCTjq0gCGNsGiGY414spw0TRTil9R2gwaW7njZk/caLRKZzCU5dHFxXBNWaXDo2ZaCpBtNJuHIZ46gbE0aM+gr+hZ5VFLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyADTMis; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyADTMis"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E672C2BCB8;
	Sun, 10 May 2026 19:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778441524;
	bh=oosQGewjKOseq/Zf5kpRlYqAjqUau3hSHYi43sFgkAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JyADTMisvVNX5qwlsV0UQO/IiW9peVSs44lX9szf4Nkxsa6mNgJqBu2InpqVUUWhu
	 nqJYbyzOlwlSYlqs6SmxsJdsNVaO9vZpzb44YMH5RV8UXIB0cCpd1EeMsvue1KLoIV
	 b7O2/4EQSSJCvAHEX3k6kj+tUXoTMsCpB94Mko8Gs6E1+xC9rsbiJWewU6zAqpywFy
	 gJ7zuRiwaLPPe+iCtoE8UJsllLPSrpXvMLOqJi+XDO1fJySNyjdbCNW8S1+O6WPcxL
	 6IpObWWpKyHqZ399vvy+59K3d/NxrxQia8vhz/3TUbCD5To2e+T5ixm7gE1tjl8Buo
	 HIfAELBrUFThQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Andrew
 Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] [RFC] debugobjects: avoid gcc-16.0.1 section mismatch
In-Reply-To: <20260203162406.2215716-1-arnd@kernel.org>
References: <20260203162406.2215716-1-arnd@kernel.org>
Date: Sun, 10 May 2026 21:31:59 +0200
Message-ID: <874ikf9i34.ffs@tglx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 03 2026 at 17:23, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc-16 has gained some more advanced inlining techniques that enable
> it to inline the is_static_object() function pointer into a specialized
> version of lookup_object_or_alloc:
>
> WARNING: modpost: vmlinux: section mismatch in reference: lookup_object_or_alloc.part.0+0x1ac (section: .text) -> is_static_object (section: .init.text)
>
> From what I can tell, the transformation is correct, as this
> is only called when lookup_object_or_alloc() is called from
> debug_objects_selftest(), which is also __init.

So clearly the compiler is buggy. It creates an __init specific copy of
lookup_object_or_alloc() and then fails to attribute it correctly.

> I have not come up with a good workaround, so this simply marks
> is_static_object() as not __init. Since there are currently only two
> files where this happens, that may be an easy way out.

That's a horrible hack and while it's only two files today, this sounds
like the start of a whack a mole game.

Aside of that five weeks down the road some clever AI bot creates a
patch which marks the function __init again (rightfully so).

> If anyone has a better idea for how to deal with that, let me know!

Mark the compiler broken and wait until GCC people get their act
together.

Thanks,

        tglx
