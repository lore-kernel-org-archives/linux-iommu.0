Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4243210A1F;
	Fri,  7 Mar 2025 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357099; cv=none; b=Cxd60MlzRJmBEFHnfoMBKxFsFOOu3iax+RIe/zQtImTbxZjTJStZCgJSof+9y8isl8Udeb3i8TCPyESq0L1rmLw6cJXsouMhrTWs9qaQrXyS1b08IKHlon5ZYiOvTc+FwDvEa5Pmr5zZqe3QxC9Ai0NxK8vPwc+23V6NK2w0fHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357099; c=relaxed/simple;
	bh=CaYpY4vbIxytc/5j/MsKL6cyDxxha5GvlS4uEkQ4TI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Llciou2Jh64jdy1DflsrvTTS3/1Re16LqdvOeWwCQEid/OH2nSTHlWoBATSU8dsLl7JmztM7wjsP2BMo2X0w83RyMySDCiAStY4UdRqWOrW/ukTk1g4QMGycsxBizI0i6y+0TjLE6l73rViPHNzk0gMjjc/MZW7i7EU8PSAm9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G8heCVhF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G8heCVhF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C072C4CED1;
	Fri,  7 Mar 2025 14:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741357098;
	bh=CaYpY4vbIxytc/5j/MsKL6cyDxxha5GvlS4uEkQ4TI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8heCVhFrq417GF/9/ysmdQ+ijEASWM7cP8Fk7kzKO5HysRX/O60TCoX8UL8pA3HS
	 vU1OS1qmyGvn2N25ECkFvonYmXQRB2pPKX/jJNdVw8ITTfQ0xrN5sBea0ee3Rafqbx
	 Xf1tytOQrKfWmxWoKoJbmEsj8EP3TEK/gRTKG7Lc=
Date: Fri, 7 Mar 2025 15:18:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com,
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
Subject: Re: [PATCH v13 3/7] rust: pci: impl AsMut<Device> for pci::Device
Message-ID: <2025030747-caramel-blade-4b8a@gregkh>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
 <20250307110821.1703422-4-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307110821.1703422-4-abdiel.janulgue@gmail.com>

On Fri, Mar 07, 2025 at 01:06:20PM +0200, Abdiel Janulgue wrote:
> From: Danilo Krummrich <dakr@kernel.org>
> 
> Some device methods require mutable references, since they change the
> underlying struct device without lock protection.
> 
> Hence, make it possible to retrieve a mutable reference to a Device from
> a mutable pci::Device.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Note, you can't forward on a patch from someone else without also
signing off on it.  Please read the DCO for what this means and why.

thanks,

greg k-h
