Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDFB41B347;
	Tue,  9 Jun 2026 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012673; cv=none; b=jFn+IPk8tZ4c6yUwBamkGZ3shES/G2+l7xA+ZD2BEol7CyJAQBXXzVhzx6BYnUHe6mlL/bTamFgDX+RGRArqr1rmOQ/82oYHjMUqunL88BNmbgUoh2+WrOdDk+r0g+NOij49zcSdE4CpFig+f59IyqsiceUICOp05iSgFc6RIlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012673; c=relaxed/simple;
	bh=sAi/28Ft7rUbm6jJKXWvzjgglgd9xi220pLzfWlK/Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HawkaK19KPdUoiHpYUjY8tkTDt/Ywmzmfgmlw2PTizkBZvRStH3uoYxUafIA05THp4M1pxc1P8kGv9IF2MArM3rg7OE01tDpAUfB0girr/gI5LU2BPd4ur5LKj+K1TNmKNH+Scn7UdcSgQXgbVIunwx/igXBjwJuxX27pZYI+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gKioAK9A; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gKioAK9A"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CC782680;
	Tue,  9 Jun 2026 06:44:27 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E49E23F905;
	Tue,  9 Jun 2026 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781012671; bh=sAi/28Ft7rUbm6jJKXWvzjgglgd9xi220pLzfWlK/Hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gKioAK9AfWzXIl8F+KIX30lllhvxwMiVRvIFqydsD0FsElstjxRZAfMI51W33L2KM
	 GPIVct1Y43GhET5ugQ/BxbruZ05sXnpwZnMPS8+Yqkf2/gPN0mjEdIyCnScHgQyqqN
	 ilwpJkC/4+BPsJTt/AyPUC1vxz8ON2m0+P4pPjsI=
Date: Tue, 9 Jun 2026 14:44:24 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Halil Pasic <pasic@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Jaehoon Kim <jhkim@linux.ibm.com>
Subject: Re: [PATCH v6 01/20] s390: Expose protected virtualization through
 cc_platform_has()
Message-ID: <aigYuHoKHPJPCGjz@arm.com>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-2-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604083959.1265923-2-aneesh.kumar@kernel.org>

On Thu, Jun 04, 2026 at 02:09:40PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Protected virtualization guests use memory encryption, so advertise that to
> the rest of the kernel through cc_platform_has(CC_ATTR_MEM_ENCRYPT).
> 
> s390 already forces DMA mappings to be unencrypted for protected
> virtualization guests through force_dma_unencrypted(). Add
> ARCH_HAS_CC_PLATFORM and provide the matching cc_platform_has()
> implementation
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---

Nit: just drop the --- line if you did intend to cc those people.
Nothing wrong for them to end up in the commit log (proof that they've
been cc'ed if they did not reply ;)).

-- 
Catalin
