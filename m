Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B09E20A5E5;
	Tue, 18 Mar 2025 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296273; cv=none; b=Jmuvkqo2/YTT/3jQFZQAiBsXXnbCsJ3bxA7prDmDRXUb+Rtds2Kt/FEyFvnLS7pYIVjmZhHEl6lm7XPTWBBZEgJ1pkximZyONSq5SATpBE8Yc1/b8hELkFORl3BQcbv7YT9cKrfbD2hF+scV00KlF34ElYxb86aKFUS3D60BYRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296273; c=relaxed/simple;
	bh=X7iLdIG/J2lmFfTQFSfsQQPb8yIf0GyTP4KmzMSp8BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZL17p0LsYPgD7soDwlnCzZhWU99MoVCbbqL3Y56TcvWBEs88E+AZTIREmzOachZP/65IVpEeVbyzYMvztkfaCF71t8Fsu0xzgtLJhg3odqAoZ2r/XMYbq89UZsveF3xidLED9okzHBV8eTrzg4eJDtmE4CDJkCURYdZtphIb4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atcJcEQ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atcJcEQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73AEC4CEDD;
	Tue, 18 Mar 2025 11:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742296272;
	bh=X7iLdIG/J2lmFfTQFSfsQQPb8yIf0GyTP4KmzMSp8BQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=atcJcEQ3Z9EQm+/QXwu+ucZYaef1yg6NTQd2ydRyWl6Ym0zNCq0SRV6SinYSTN4Ge
	 mravkn2EDMQ7O00tYVTH8vwFoIoF+wAgENVkpvpEq7DlIKHFJRxhEyde/f2/VNE8rg
	 ds/ewY9vf7+8OHa+4j/nYUK5pkRAtHTP7RZV7poan3hK3W74QkbvOokyay5kwPbP55
	 An1vLL1VWVmeI2CXtBDv8YRJ30p8FOCWD3yG7v6PW8fBO1BOf6QUmKPkSnEydzdrW9
	 0/iZMjjO7kjVZvFXQTef5mVuc/veG6CogpYDUK+ygvoNMuRf8GPgPOOQ1SN5Nah7XP
	 7YAipL5N/kbkQ==
Date: Tue, 18 Mar 2025 12:11:06 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	robin.murphy@arm.com, aliceryhl@google.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v15 00/11] rust: add dma coherent allocator abstraction
Message-ID: <Z9lUyphQPj0LfCMf@pollux>
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>

On Mon, Mar 17, 2025 at 08:52:07PM +0200, Abdiel Janulgue wrote:
> Abdiel Janulgue (5):
>   rust: error: Add EOVERFLOW
>   rust: add dma coherent allocator abstraction.
>   samples: rust: add Rust dma test sample driver
>   MAINTAINERS: add entry for Rust dma mapping helpers device driver API

For those four,

Acked-by: Danilo Krummrich <dakr@kernel.org>
