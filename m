Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D82939FD4;
	Sun,  3 May 2026 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777805039; cv=none; b=GsoZKPayiQJcTg3qkvvHSicT852WK2MbPiZtboExFLlU80ZDKmxHuKFxBI5pxgO16/WSixt59F0XH5RSpL0Gk2N0byhbexIPwGNX2rnZbdMIp48cPfMNgi9ZMV1vkqHFA7LU+7fFpGJ1j2THVcX054grN5KYdvmEhv3ZORdZLGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777805039; c=relaxed/simple;
	bh=am2Q7M64SOrxoWTM6sL4lY4jwhGq9DX1WGMrXLJBM+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVb2BV81HCDCJhHXxr9Eia8BVahay4r2O5s2J4B/LBDO811sChwCA/K2AaBhO2b9tARvc62zN8FCuzpMxTShs2ErMYhJq+jnuSbLgYzvhl90uV5/DyKESRF9eljXuAPlWWGnwSCIrFWnbGHuIg4FxBt8lD+d6XGbRf+XeZrvoGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KcbUDNHy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KcbUDNHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F74C2BCB4;
	Sun,  3 May 2026 10:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777805039;
	bh=am2Q7M64SOrxoWTM6sL4lY4jwhGq9DX1WGMrXLJBM+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KcbUDNHyX2eBTmYfuqwjapeKD2UIx0Tohs0MOFS5m4JZ9vpnJlwBYB1M3V89+nVXK
	 J15oOiu/yrH2ebLKpVCjmpwXXVUO289Anpk9+lp2LPLlAcWlMooH7sphqRkPWosEpZ
	 jqVN6q6T8rqPZnEzzlpSl4IA5ISZc/bfFf3CQ7gk=
Date: Sun, 3 May 2026 12:43:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: x@2005.tr
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Robin Murphy <robin.murphy@arm.com>, driver-core@lists.linux.dev,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH] rust: io: use newtype for PhysAddr
Message-ID: <2026050347-mosaic-uninjured-3115@gregkh>
References: <20260503103050.200526-1-x@2005.tr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503103050.200526-1-x@2005.tr>

On Sun, May 03, 2026 at 01:30:50PM +0300, x@2005.tr wrote:
> From: Favilances Noir <favilances@proton.me>
> 
> From: Favilances Noir <favilances@proton.me>

Odd, this showed up twice?

thanks,

greg k-h
