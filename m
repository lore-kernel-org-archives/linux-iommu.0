Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC7D3EEAEB;
	Thu,  9 Jul 2026 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584915; cv=none; b=lbBqOb3czB9JDb3/nOd9tlvbS9uTVhIM1TrDJVi76cM8ALRp5sKfQkgRmCoyjUbq5PMnDXtVbh4bCRxJDGBc+ReDbpP4kB04qtl/E+ojXo/f/yZSCH8JX+E0eiYUkxKovYu/ri78AWuZrGpAy6E220rV90VaGqzIcPURNRq8N6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584915; c=relaxed/simple;
	bh=Rs3JW60QJsUA7wEX6GU4ii01e56914j3KMkq2TX4Pj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qA19gTPZmwQcvle/4QKR4mGA2eHmffv9lPXwhRqVXcQ5k/gfzHVdmB0vDsG73qXmO1rX99X8I1C6vNjgKSLOTvDXKw/fZywxDLPogXdbjHANQbHXaS8HfMdgU81w5ngbeVIl6vyvNST+wD1LnZJlzlwAWBmWQR7g9SQLtRnb668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc500c39e96c98da8598f.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:c39e:96c9:8da8:598f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8D5E02035C2;
	Thu,  9 Jul 2026 10:15:09 +0200 (CEST)
Date: Thu, 9 Jul 2026 10:15:08 +0200
From: Joerg Roedel <joro@8bytes.org>
To: =?utf-8?Q?Nicol=C3=A1s?= Antinori <nico.antinori.7@gmail.com>
Cc: Will Deacon <will@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Robin Murphy <robin.murphy@arm.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Tamir Duberstein <tamird@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] rust: iommu: replace core::mem::zeroed with
 Zeroable::zeroed
Message-ID: <ak9YfZhKVRGhMtJj@8bytes.org>
References: <20260629201046.423464-1-nico.antinori.7@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260629201046.423464-1-nico.antinori.7@gmail.com>

On Mon, Jun 29, 2026 at 05:10:41PM -0300, Nicolás Antinori wrote:
>  rust/kernel/iommu/pgtable.rs | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.
