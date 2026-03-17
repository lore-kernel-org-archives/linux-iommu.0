Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017653C3BFB
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752354; cv=none; b=u6OEzKuW3ouEGV8EmuY7KfPOjziPazVlFvr49KAUvtG5Kc9tSRspa8R546O8Srsewmua9UNJ9GIEJ6jGcT4HcvaJFOJy19tV2wuH+q2iyWYDMr4pmqOYi1vxXtdMLIY9spXbl4usgFxtOEC1JHSrjrF1jJT2EmvUrO7h+c62ccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752354; c=relaxed/simple;
	bh=VBpfiU6s8sa/6zvOD8W7e24neQSfYDIVg5PZT2IOrRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MN6MvMMNQz3X+k9UGvweJtU8ZzM45c7HxwjKcqdplHIu77sXXTOn8vui9mqbyRd0CfdQ+045EiLXl1YkEjUTjUihTM69xKkWPvqnHDcVrnLVT0F805esCNmENg4qw0hEo4iuTCXdaLmZilSpj0WlX4Y6FPIq2Y0stY1T+TFFis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=c40X5jgJ; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="c40X5jgJ"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 10A591A527B;
	Tue, 17 Mar 2026 13:59:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1773752351;
	bh=VBpfiU6s8sa/6zvOD8W7e24neQSfYDIVg5PZT2IOrRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c40X5jgJBx6DUNYiNjXPH/QO9WJ6LS2EzYXLhhZEYSjPxKUsUmxJi9VrX9wmTIv2m
	 JNUnqjunMLh3PUIsZy+ohABtNSHhIhaqkEbz7gQOAWs5iCzB7arqndKCBUXdjgV2Lb
	 0NskkF//H1AR1ujBN52oNEkc/ogYNT6uY8IeM64dpQblvBuAjLXpLJMoAyqhIK7990
	 nPTRjVrcvaxM5OpbQnyakaD9FJqRR+KrAyC3fmvoZLGQuEH/pvlufUHwsd4CJU5fEM
	 LHUmAB7emPfriPkciTAB2Rn9V8+4orpSYcNa98VZ78lZdUCd/LVh5/9WpTmD8FJOwY
	 vSKhF9yBwyUJg==
Date: Tue, 17 Mar 2026 13:59:09 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/io-pgtable: fix all kernel-doc warnings in
 io-pgtable.h
Message-ID: <jxh6cmassyngxmbbbsdkdb4e7n3knjmotla4wn4ohbqv6zqezn@47e6ldbk4yky>
References: <20260302005214.3469521-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302005214.3469521-1-rdunlap@infradead.org>

On Sun, Mar 01, 2026 at 04:52:14PM -0800, Randy Dunlap wrote:
>  include/linux/io-pgtable.h |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied, thanks.
