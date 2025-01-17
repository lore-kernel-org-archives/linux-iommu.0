Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E9B1F76C0
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100719; cv=none; b=bHHv1HGLmgp0c/7uun29sd0qhXM4xlnd5Jf6fitp6nFQTIG/tXGuG183ggR3bYz2cGfo5xydF9XdNiJDqTEl01AJb8ZiC66oeuZ6nCkjPtNstllbbrEUhHEyaRt5Z/nnGXuEWSmwrQ3Etg9ub/n7TRolMfEzR0tWtd8YSw2b02U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100719; c=relaxed/simple;
	bh=PULZRdCZlGiRvZavm17XV79zU7zWTlHm51izt14vnvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Owuoiox8XaCSh0eEba7TMGG/gYS8H7/FnZY19PmbVoNooKIFs+OP4jVfqm5mloNKrDhBlga6k6nH76p1ghT9qi0f3vy0dF2ui8mocQiXHInSMzEh38kiw0LDIBcLL9yff52NZrE0/4uUG2sRYLmxbitFcLnzsfNVQqFZoDiz8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=kxzPQY4P; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="kxzPQY4P"
Received: from 8bytes.org (p54921e31.dip0.t-ipconnect.de [84.146.30.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B334A2E002E;
	Fri, 17 Jan 2025 08:58:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1737100715;
	bh=PULZRdCZlGiRvZavm17XV79zU7zWTlHm51izt14vnvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxzPQY4P6WmG74fnXedBUfNBWyGy78LNlSlx25pEgRXFFgYfLvcw2F+LThrWKuEeq
	 KAvLTazTse/eG6CiUzTViPXbuigS2/4uwSW7xWBcJKqVvYudv5/Azoy4lqhWEXeWss
	 7iGZXnkn4gfNbfWjV1SW0KnEsQaDzAHhIK7cI9Mz2GBPw4Fcx/EiH7fsa6LQkaSPqc
	 75Y2+UA7YOICBQPLgtn9JJGJsp/zMtq8HzR4380tQvTHSysFgpQyRWhQr098tJayw8
	 C4gC30Rz11RbZ5z+jju/SVDJ5Q+v4GwLnyPTkjCHt5JmHaMBNJJUnUVMUllGwwOyYO
	 1X1cCPX+GkeTA==
Date: Fri, 17 Jan 2025 08:58:34 +0100
From: Joerg Roedel <joro@8bytes.org>
To: guoren@kernel.org
Cc: tjeznach@rivosinc.com, will@kernel.org, robin.murphy@arm.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com,
	baolu.lu@linux.intel.com, zong.li@sifive.com, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] iommu/riscv: Fixup compile warning
Message-ID: <Z4oNqjtzYkjRJlYr@8bytes.org>
References: <20250103024616.3359159-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103024616.3359159-1-guoren@kernel.org>

On Thu, Jan 02, 2025 at 09:46:16PM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> When __BITS_PER_LONG == 32, size_t is defined as unsigned int rather
> than unsigned long. Therefore, we should use size_t to avoid
> type-checking errors.
> 
> Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  drivers/iommu/riscv/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
