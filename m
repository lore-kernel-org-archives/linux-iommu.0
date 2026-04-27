Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CFA39A04D
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777291201; cv=none; b=Gyg+1gdC0MpR/D8D2+vmimTAcdHuo3pIaHi/3YwokIDiJ+XcQRAm8e0ddw2d3xwwyjSpDuyntYt50H/ygkxRkv+1E66HdVTYoTuSF8AxT0b/vz3enhnttR2FSbo5SvCKXjYwMTtE0xZd2i2nQWXux+SvIS1X32720DesIGoViZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777291201; c=relaxed/simple;
	bh=OVtsjkNuq8fK/SntL0+ksQuN/IHEnxOF7yZudaEXvaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSPHwNGRl/gf0DsUD6DKgHE8TzbVh3CYt92EKTXT9wxSN+dRCA7+dW5BQaJa7nHkR3frZVcD1xehVYuh2+YQn58LzWJ/dWeNleL0tlRWue245zYLxH/dJFy5ANJkoO8qZA6UoJYnQFuKFMTwfvjybE5/MqvJRsoUKVeGA/R4pp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=lncDoVhW; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="lncDoVhW"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8A1EB2007D2;
	Mon, 27 Apr 2026 13:59:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1777291197;
	bh=OVtsjkNuq8fK/SntL0+ksQuN/IHEnxOF7yZudaEXvaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lncDoVhW2Q5y6AVK6hfV0sKo2+PFxtY8AsNLlYQsBbuhPVuwTX7rmphmWruxVKPT/
	 SwUydO9n4wfqY8mSkN6TCYEzffcfaO2Ye1PDWvhjHEHp4Hh7D8lCxmdRe+EFy0Qfeb
	 zPEEa4azxzeMNMJIwUEliuhTgPX70fXcfUdn5mjFuqaevF0KTkyht1d80fslH7Gy6y
	 EqQEC3/sU0umI94Ho4bEAvw7I2G1jtkxXob+yAiZtAyzDA1pjipOP4qrE5mNsnuEnw
	 x6zfT38ou2j0Xdiapg4LhNms+TD5bEsbHy+/JUtkCJ5u0T7GCCpWKYphgqsge9RAGP
	 kQOyFApq+mPGw==
Date: Mon, 27 Apr 2026 13:59:54 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	robin.murphy@arm.com, will@kernel.org, jgg@ziepe.ca, baolu.lu@linux.intel.com, 
	kevin.tian@intel.com
Subject: Re: [PATCH] iommu/pages: Fix iommu_pages_flush_incoherent() for
 non-x86
Message-ID: <2cs4aesyqbrbhaymsnuekrxindsnt5qdysdhfsqm6bzoo6ksol@yai62cjf47rn>
References: <20260424115051.2082174-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424115051.2082174-1-smostafa@google.com>

On Fri, Apr 24, 2026 at 11:50:51AM +0000, Mostafa Saleh wrote:
>  drivers/iommu/iommu-pages.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to fixes.
