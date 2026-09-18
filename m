Received: from mta0.migadu.com (out-248.mta0.migadu.com [91.218.175.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768664B7A3F
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719466; cv=none; b=OdTUTqa+dfNs5j/PJhDtddG9T+qzxMkR22jUTk72o7gg9JHvcjgmQKJ6wzu/FVHDOI6zNOfsyTVU8yXiWOqem6NHWGbR0nW5gXre/3kl0gzNE/LQ3jW8lVVjN0DQBQPVspqMXdHJNT4L7X/T0x4iwHh9uz6kG2pGyKlQoOdeU1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719466; c=relaxed/simple;
	bh=j93Rw5e85f6pY7eCSjFAVhVix8y2aM8tStuN+RPXRkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i51czIXd6rW3dSSJgwEq1cd9Yw1bKq2/BX1CdjBPYXfJRdqXqcNI2nTI1O8wlDMZZmGGUp8w597uYYhEEIDae1urPQknBEKU8IAmQCovzzK57UOSIxsorecFXgP+t9iB7D3wYIFTNaHiLxNX515c9rPVb7ZJg8lEEOka7XaKCcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OiC8qhaW; arc=none smtp.client-ip=91.218.175.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OiC8qhaW"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=j93Rw5e85f6pY7eCSjFAVhVix8y2aM8tStuN+RPXRkw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789719462; v=1; x=1790324262;
 b=OiC8qhaWNDJzjEhthmyQFnc4uzYwiPYNtFNPfXa9HpOYVFbaRC91p32pnH+cv2Jp3gpGwyAn
 xUyvX0qNGfK98lkix16baIzuwWun/ft2uEwgm+w7nRG88jPCcsqOb/szmglVZZ/h7WrXVJq6XWC
 vGpsrDM1EjJ+uAjhB6cNQIRI=
X-Envelope-To: iommu@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id d0581680cb0ed85c;
	Fri, 18 Sep 2026 08:17:42 +0000
X-Mizu-Trace-ID: d0581680cb0ed85c
X-Migadu-Flow: FLOW_OUT
Date: Fri, 18 Sep 2026 16:17:32 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, robh@kernel.org,
	saravanak@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	m.szyprowski@samsung.com, mark.rutland@arm.com, kernel@xen0n.name,
	alex@ghiti.fr, hpa@zytor.com, ruirui.yang@linux.dev,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v6 00/10] kdump: reduce vmcore size and capture time
Message-ID: <aqzznOgILX2pZg7b@fedora>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902073116.802752-1-chenwandun1@gmail.com>

On 09/02/26 at 03:31pm, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
...snip... 
> ACPI systems already filter reserved memory out of the vmcore through
> their existing path; only DT-based systems currently fail to filter these
> regions, which is what this series addresses. The flag lives in memblock
> itself rather than in a DT-only structure, so the mechanism is generic and
                                                                 ~~~
The patchset itself looks goot to me, while I am concerned if it's
really generic. I raised that in sub-thread talking with Wandun. Imagine
I tried to exclude many driver regions and split memblock regions into
hundreds, cma could yell out: cma_declare_contiguous_multi()?

IMHO, withdrawing the claim can fix the nit concern. If I am wrong,
please help point it out to let me learn more.

Thanks
Baoquan

> both ACPI and DT systems can benefit from it (suggested by Rob, thanks) [1].
> 
> Since the reserved memory regions are filtered out, the vmcore is
> smaller in size and faster to produce. 
> 
...snip...
