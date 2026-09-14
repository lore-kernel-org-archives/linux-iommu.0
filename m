Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD452475E3;
	Mon, 14 Sep 2026 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789363228; cv=none; b=gMt5yQiSOgj8bhPcYGajrevRRGCV+ds9B7N3d474qij0W8GBgJM2cTzcY/LRxDHfmKlVR6hKbYvhM/zCTp28dneXPDcXp7HRUn3vRiS4pR2YOPAjdJhPMiqmzJyGqaz+kIxrBr3+qaq3I7yUK/YB4H3X1VHJz99yfigNSuP8L8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789363228; c=relaxed/simple;
	bh=TE6lnEedq9AEX81sCvjlzrnKeWus+zLHddFN4XOUUJ4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=iXewhPblM9evkvgG7NvxL9+5MmdjEVzPEf8KnbNpVjwxNYVRx5ekMf6SAOEVeldT7nCrvW7SbPlVZxhXU2NdeYAQzfhu6ouDnO4zkgvHZxYbwFVs11oJYNFdrqqFla25lsgwbdYnuPbEc2HL+/Ro/eDRhW4NDEfPCc8Zw2+AS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkTExBz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkTExBz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998861F000FF;
	Mon, 14 Sep 2026 05:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789363226;
	bh=o779dzepK0mFhzpZscdSpSvYUsF1kQ6qSiTkadkPzf4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=CkTExBz8pPEMBf1jk73HqRy9cRVhv5/C+/iPCXbOYp6XW7Lzx+sQ1dPL4vfhzGUKD
	 1Qo4YLuCVLvhPKTxzUqjNbUy1Uvh7gG1I3nHUUqHzs/WEJuNkr9qBqahooT/6T5ZVm
	 oR6CnuJc3DGdo2E3oDlVtXriiCz3rzEwiOys5VH0cgx+ZEDK5FyJNz90827TMmdf6G
	 W2CcXEXQKcYkcl5oqdBHkuIsqpx+QgJgJl5qBheg0r2tbsTh9PXCq9NF/SX2bSEv/+
	 2xV2YnJfUQF8bV7GrpUBqRvCECLrzr3MeGPvYWJKa4h381dPopjrSfvVE5ZktcPrKV
	 K+Ef5ba1feaow==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 01/10] mm: memblock: add missing HugeTLB flag name
From: Mike Rapoport <rppt@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org, 
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
 robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org, 
 baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, 
 pratyush@kernel.org, m.szyprowski@samsung.com, mark.rutland@arm.com, 
 kernel@xen0n.name, alex@ghiti.fr, hpa@zytor.com, ruirui.yang@linux.dev, 
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 kexec@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev
In-Reply-To: <20260902073116.802752-2-chenwandun1@gmail.com>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-2-chenwandun1@gmail.com>
Date: Mon, 14 Sep 2026 08:20:16 +0300
Message-Id: <178936321614.3691424.10386784926753862087.b4-review@b4>
X-Mailer: b4 0.17-dev

Hi,

> Commit 7d163a75f821 ("memblock: make HugeTLB bootmem allocation work
> with KHO") added MEMBLOCK_RSRV_HUGETLB but did not add the corresponding
> entry to flagname[]. As a result, memblock debugfs cannot report the
> flag by name.
> 
> Add the missing RSV_HUGETLB entry.
> 
> Fixes: 7d163a75f821 ("memblock: make HugeTLB bootmem allocation work with KHO")
> Signed-off-by: Meijing Zhao <zhaomeijing@lixiang.com>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Link: https://lore.kernel.org/lkml/20260821020910.3428585-2-zhaomeijing100@gmail.com/

Can you please send this as a separate patch, I'll pick it to the
memblock tree.

-- 
Sincerely yours,
Mike.

