Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD651F75B3
	for <iommu@lists.linux.dev>; Wed,  8 Jan 2025 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344799; cv=none; b=tXjLNCaJL/QkfQl1osmVi7y1nARnDsR4fEEXXn3uEYFa/72v8tz7ouSUn57BZbApOeRCWiaPeOnvubcvblL21RT6Ab8a7RKOT8PRagU+Ga0b/D5BToeSquu1ZiU2zZl6osaahOpwXt6qU/qVrE7k4JJOwEIDUqEkoue/VTHVGZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344799; c=relaxed/simple;
	bh=vutsIp9o7Vswl6mwk/1MIlwDbpqO5jwyRcWv3zTboNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlYYNg6idUZy47J53T8dLEs1jdzZS25g5bUAaEM/LF/ZuCvDgIzPyp+c0GmUfPc8SBO3fcUpMKMA9tXtuVHYJKQOK13VmyZcv1JWH7dNaCbZZ0u/NhL5G3l1gF+w1LdkVJQwZBDSYbtMVRMjrOYnDEqP5vMZDilS4LhiULOgqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5C9B068BFE; Wed,  8 Jan 2025 14:59:51 +0100 (CET)
Date: Wed, 8 Jan 2025 14:59:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
Message-ID: <20250108135951.GA18074@lst.de>
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com> <20250108122825.136021-3-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108122825.136021-3-abdiel.janulgue@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

No rust code in kernel/dma, please.

