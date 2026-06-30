Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935BD3CB8EF;
	Tue, 30 Jun 2026 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817589; cv=none; b=ioxAOg/TsHAoNJxdYK13uofHHq4lImctPuC+ZKH5G1GvEWxw2KMOhWhfVde3KyQdP5sKny1Qyhj1DSg9DbOBNHj2VvBySK9yebach/gKx/r9LKAuSi/gVXoG0z5V7zP49wWVuRuSPnybHANZ1LkQOLBYfFLM3ZGAU3Ow5B8L3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817589; c=relaxed/simple;
	bh=Y8D71ksWjDUHnBAOs/hfrlKqpKuju7Vo3jhZubtX+nw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kzwccSiPUB6DmFsk5YjCi8tWZ4QOlxSn3suI7pifNKIIPU0iE+lb6/u67xH+5nTPFaqTTapNBN4qb1l1P94PNMuKOHDU6ngCHEQg3p//wvkcckMewjBXCaSS30Fbp7QsYgTukJTod2pnteY/GJ5xqUyPYsC8o9v7jbqLqEsZrr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbSReGHG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbSReGHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970C51F000E9;
	Tue, 30 Jun 2026 11:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782817586;
	bh=KziUE99JyCXJvfI9gWixTL5K4MSlxqncGllEjWQ7FFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gbSReGHGi6BBBm1jGbagqwMr3EDZYuq6/aVP0SmPh5q3XsQf2OyoXmHLpD7jKFuXN
	 rz/DuYqpdl8L3DXfBDTvQ7kL0hoqzMjWXWkW8p3niXHmRq2KJO1lhQLr2BGi+0/xW1
	 1QN7bIbJ1gjbY8koWTFN6rYpDeBENnDuuo3Di/Qb6ZxIaSfy0sRjdwCT0pQ7sNxCeM
	 zOq3PScln3ortRJ02gpXTvE3pm2Lk4DnNeyCU0ee7DMVL+uHvo0MsRKXj5dTHKpBrf
	 Xhnkz9uFlwHhr0XSswtrvXEZTcdZ9vbGyco4qHRo1JKwGuORedI6VrlOrYZTkpFs86
	 RPXDfpVVtd2LA==
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
Subject: Re: [PATCH v4 07/10] of: reserved_mem: add kdump helpers to exclude
 non-dumpable regions
In-Reply-To: <20260630074715.4126796-8-chenwandun1@gmail.com> (Wandun Chen's
	message of "Tue, 30 Jun 2026 15:47:11 +0800")
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
	<20260630074715.4126796-8-chenwandun1@gmail.com>
Date: Tue, 30 Jun 2026 13:06:21 +0200
Message-ID: <2vxzmrwci8ya.fsf@kernel.org>
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
> Add two helpers to exclude non-dumpable regions for arch-specific
> code.
>
>  - of_reserved_mem_kdump_nr_ranges() returns the count of regions
>    that are not dumpable. Each excluded region may split an existing
>    crash_mem range into two, so callers use this to calculate
>    crash_mem allocation size.
>
>  - of_reserved_mem_kdump_exclude() walks reserved_mem[] and calls
>    crash_exclude_mem_range() for every non-dumpable region.
>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav
