Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6E20E6EE;
	Thu, 23 Jan 2025 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638304; cv=none; b=V04nncT6dXA1tjHmLI4g89UtduEdTlsweoJz6e31D2+wqr5wSG6C/1rztYMYMabwSb1K2QX9El/KrfSYfC6fELMwHn3fOZiMyZZPqmeDKs1BLCvnU5bma/4szqVAX4Gw7rYECKJ3VikCVwkiiaYq5v76dOZMACIbdo6ekknlQcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638304; c=relaxed/simple;
	bh=xg7PFiYeTZcuJtf3EN+o2Ajn1RHJ1rxGnA2RzY4tDqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z082TlWJztFIvI/mxsnijSNYa+iZ9MJPt9kVNGyoi5jsZ6SVb02rkosx1+La2zkpDQ4g354Kaqv3embcFRWrRZ5AUjyL7/aQUN/of+Io6OwPZIPog2Tv6dAjLnClGqYd5L571jWKg/fpJLv2MhkvtTpnX3wUqrcK3KBup+e1vmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA8TtrGX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA8TtrGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DC5C4CED3;
	Thu, 23 Jan 2025 13:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737638303;
	bh=xg7PFiYeTZcuJtf3EN+o2Ajn1RHJ1rxGnA2RzY4tDqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OA8TtrGXNpDjwM8XhK/JS+uyGJ/Q005EEnYnFK2Avd9IfoSavuoLfdN2nr6q6OWgf
	 LQ3Vx/IWbSZ5TfMhHap6ldNREAzYIfLesf9PgCz1CcvfFQaClI1nnVw7StIhg91xaw
	 pzUdmbKu7RxcH1dWZSme5LUqdfgIcVHxYevGAPioyKN0fKgXnWMCUrvGitpfMc7urg
	 iAinzlOvbrW4sgHdXdz+r//OBcr9055iKW3eEvgSIp/Ydh1P2GJQfJ9A4xwaPukygz
	 FqvmmR/sQXk0Nfh+w/Ql1xLWAlq2PvJd8zbtEqS8fueiQ/wk9fi7xfedk0rp7ksD/L
	 c1M6DzoyNgPmQ==
Date: Thu, 23 Jan 2025 14:18:17 +0100
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
Subject: Re: [PATCH v10 3/3] MAINTAINERS: add entry for Rust dma mapping
 helpers device driver API
Message-ID: <Z5JBmVQe1NtIZsjN@pollux.localdomain>
References: <20250121191432.1178734-1-abdiel.janulgue@gmail.com>
 <20250121191432.1178734-4-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121191432.1178734-4-abdiel.janulgue@gmail.com>

On Tue, Jan 21, 2025 at 09:14:04PM +0200, Abdiel Janulgue wrote:
> Add an entry for the Rust dma mapping helpers abstractions.
> 
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>
