Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B112D1F1;
	Fri, 17 Jul 2026 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299772; cv=none; b=gSkPPQzQFNr8GnS4+Kp55WiSRJWM8ZJpIH0nwxZcKB45DkOy9u6NbdvOHVz+LoEDxwc6ebQ3hPRv0kW5Z3ITqQGIAjrKOkMuRh8gFs2d9Bjh+ZNzhFn6r8SfZmZY25FLMszI3jNOJx+ti0naYa6GeRDVj9XfoVNp2gPHw1bXiEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299772; c=relaxed/simple;
	bh=qa/81JIfcQybn4akAYQX/T13BkvL3/0IoNUaBDJcq+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/a58uBnUEVXV6gV06+PvZNtDwOiIWzkzumm73Qtx46glmJ8SkDGdzwXxfCxZx/ToivUbgqOFAZ3v89wmeyPp9BEpgeDzghwc2UXEjZ2jbQPZLGIUW0rthhM7kCYN/W9IuBIGVFX/oPlMkRuKOa8OGc3hCIVKa3Z55D29ASGmJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4a2x4gI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4a2x4gI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B84E1F000E9;
	Fri, 17 Jul 2026 14:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784299770;
	bh=+q8YiWXqmTGRkRi0w5HPuLZXGyFgeLZWZr5ZctekBP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d4a2x4gIkZTEk1CE5Hsyf2XDeER920GZ6ahZHtyGapAoOhoKiNOivRAi6YlPVNH0t
	 XgKt3Qirf0rU3OAZQl4n3mCv4VH3dgm8EJ8xXCdaCet3iKwxxRXpcVBnEcxdOQdo+k
	 Y6DyVb0KqVQuZ9ELZYaWC3x2PGk1SZ0VIvHPnXXaOpIN6j3/m72psCVSpa5XYuGKoi
	 cOg9HJ29PuK9ouPW/9885t08Z+JZgcUI+xOeJdr14jq9HgD0pk2/UlgQj4oSEE4AUN
	 Ehs/91MSiTBfa6TDC6k6QP0fAZPaHMoCOWkKPPaNd56uRJTVJtbCxm4+coGu33ZR5J
	 6MYtS4kKEwIyg==
Date: Fri, 17 Jul 2026 08:49:25 -0600
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
Subject: Re: [RFC PATCH 01/11] KVM: selftests: sev_smoke_test: Only run VM
 types the host offers
Message-ID: <alpAqex9iHS2rk8b@tycho.pizza>
References: <20260716151706.244987-1-dwmw2@infradead.org>
 <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>

On Thu, Jul 16, 2026 at 10:31:21AM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> sev_smoke_test ran the plain SEV subtest unconditionally, gated only on
> the X86_FEATURE_SEV CPUID bit, while gating SEV-ES and SNP on the
> KVM_CAP_VM_TYPES bits.  CPUID reporting SEV does not mean KVM offers the
> SEV VM type: when all SEV ASIDs are assigned to SEV-SNP, KVM_X86_SEV_VM
> is unavailable even though X86_FEATURE_SEV is set.  On such a host the
> test aborts in KVM_CREATE_VM instead of exercising the available modes.
> 
> Gate the SEV subtest on KVM_CAP_VM_TYPES like the others, so the test
> runs the VM types the host actually offers.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Reviewed-by: Tycho Andersen (AMD) <tycho@kernel.org>
