Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A842922ACEB;
	Fri, 17 Jul 2026 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299794; cv=none; b=Ld2tMxsclexb+cbmrG2S9Ih7J0lev0TmYL0EoA670NpfEyOLH22rg+dXBtNm0kKSMWnbJGsYlVohRDopNtRKRTBevikhqGOz1Qz/UK47ZWqLRGw5WZnrAMD2ETBYJoE9d3VEDC2Ep8ZDN7JrW8XmxDktbQVivjQ+XASj2yKdg8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299794; c=relaxed/simple;
	bh=aXb/D7Oz5BbiMrYtYN+9dFPjqeDRgdYXF/JAQI+QVso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+tzvLcuDNV/iKLXhfu0/bIhnDZxjTle2g9mcFSmPBGoFfGBftfXKkB670fc7bT3W/+I009dGfx9TOfbzkoZaSgugSgkp0KVTz0VYP0WiflvGC8UgI+1kSBHLABmXtyx/PXftyjleA1Dh1LjCv/fJG6GlfZG1x3SgvfBA6cGFIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c69pwHaC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c69pwHaC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C23C1F000E9;
	Fri, 17 Jul 2026 14:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784299793;
	bh=thCSV6qo+j8PApZXMoK0ulbEnJBDDj8FSxAYD8Wmou0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c69pwHaCH+KUpfIHVK2nGragkFsgUaS6y5rsrz6ComUqN8do4j2ciASg5xj//ZtMF
	 A6IANyNNMpt/YyBeRGh2Qjahm8jDkGL2jvWVRGJosWjXTvL7gbf2eA9aKoCZMBZzco
	 FGCL+jlrp9raYaEn8VVRE+iGEMXlriVaZ2E9ul8oE1gpCNGOl9MAkXEXQA4Qyv3dmN
	 VOBKqvVsLEOYZuLbleIrE3iii/rQiEfRC4dLCu7bu2hcj1bordPwfbQ2Py+d8rf4Wz
	 +sxhhOzjBHfHTYk+X9wHe15mvJwUqdOlb29WeXkOVBXb8pxYBt5ffySOnm2+DNsfAL
	 60QPXLm5lC5AA==
Date: Fri, 17 Jul 2026 08:49:48 -0600
From: Tycho Andersen <tycho@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Kees Cook <kees@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>, 
	Connor Williamson <connordw@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Zhou Yuhang <zhouyuhang@kylinos.cn>, Zi Li <zi.li@linux.dev>, Dan Williams <djbw@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, connordw@amazon.co.uk, 
	graf@amazon.de, fgriffo@amazon.co.uk, David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 02/11] KVM: selftests: sev_init2_tests: Derive SEV
 availability from KVM
Message-ID: <alpBAQiqVObDf2R_@tycho.pizza>
References: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
 <4710ad35dcfd1a85a24d15fb56dbf233ac05ad49.1784194290.git.dwmw@amazon.co.uk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4710ad35dcfd1a85a24d15fb56dbf233ac05ad49.1784194290.git.dwmw@amazon.co.uk>

On Thu, Jul 16, 2026 at 10:31:22AM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The test asserted that the X86_FEATURE_SEV CPUID bit exactly matches
> whether KVM offers KVM_X86_SEV_VM.  That is not an invariant: when all
> SEV ASIDs are assigned to SEV-SNP, KVM does not offer the SEV VM type
> even though CPUID reports SEV, so the test aborts on an SNP-only host.
> 
> Derive SEV availability from KVM_CAP_VM_TYPES (as already done for SEV-ES
> and SNP), assert only the one-way implication that a type offered by KVM
> is also reported in CPUID, and TEST_REQUIRE() the SEV VM type so the test
> skips cleanly when it is unavailable.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Reviewed-by: Tycho Andersen (AMD) <tycho@kernel.org>
