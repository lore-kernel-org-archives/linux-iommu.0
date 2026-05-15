Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780E63093BB
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 05:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823052; cv=none; b=Ct1Ungg81LvWIQey3NbUIB6nqxoy5Gp0jvsX9tO9JyBuAtBb3WXkKxrXHQj9KL9D6XajCH09od7whwTSaNqUAR8B5zJE+PDGZuHlBLhiiRY32vXtz2qg8Dj+M9cKXckJLGyydc5PjHdnkS3HnWNb+VmoRWmMhblWz+0HeyR5RrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823052; c=relaxed/simple;
	bh=2IpOzIBA2jCXGfNmim6KazLG0KdmWCWJwUb3dW+oJaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0Zjpr0WsGsnuI+K+vLIk3fQz1nlL8i3AHYNASMz847q/tBVTaszYu1O63go1u0hoZTCgYSFypQMS+Vwy1sk4heHDg+0MPma3Pw4KIqmrprGHLFK8tX61miZwhgyO5GoMCMVgoVen1pdw/PGNl/DZ3GdBRq0Pd53HHsHrV6q1pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=N2NKJUNe; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="N2NKJUNe"
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id AB42B1C4468;
	Fri, 15 May 2026 07:30:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778823050;
	bh=2IpOzIBA2jCXGfNmim6KazLG0KdmWCWJwUb3dW+oJaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2NKJUNedWEGwoiskLnw3HF8ZLmUjPrYG6MYnP3E/OMHYu3I3EhKdoTMu2lAhJPpb
	 tId3gtOXdFOBHUiTDfXpIobGy+nn3YAmuk1MBKi/oqsWFfNRdyVvEXKKJrPyjgw9+A
	 FzhQwdaHhBcjaRJWrLnLYwCj7NuFdFYUIVDKGKYIyMCZbDbykhvDV8lggtwPFOhvUe
	 Q2UVBK0/TntlAUaTelxOofCnEs2kIfEj9L5h2C5QyHZFjrVfq73W0BrmuLHzXNi7AS
	 eTI+n8F3OjpkHpGTMTL9wHbA7K9zQib7cg2vztd7quYC2VCWFL0twK0AMYTzzcVBwN
	 OJ+rVvuzWSuNw==
Date: Fri, 15 May 2026 07:30:49 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Tomasz Jeznach <tomasz.jeznach@linux.dev>
Cc: iommu@lists.linux.dev, tjeznach@rivosinc.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Tomasz Jeznach's email address
Message-ID: <ls7fjnjajsws7f67mlyv7iwz6npq5csdrkfefy42jmuwjw3da2@7dvlladcps5b>
References: <41c3c83de6e2d8422261b57609425d43@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41c3c83de6e2d8422261b57609425d43@linux.dev>

On Tue, May 12, 2026 at 10:37:44AM -0700, Tomasz Jeznach wrote:
> Switch from the previous work address to a linux.dev account,
> as the work address is no longer actively monitored.
> 
> Signed-off-by: Tomasz Jeznach <tomasz.jeznach@linux.dev>
> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.
