Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23808267F7E;
	Thu, 10 Apr 2025 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284124; cv=none; b=IHxySEZsWt2WIQ7FQJUvJVNFU2mgZKod5BbT/MduRikRABC8h5vUc4e5j/NQOJMGOcy9KZ9NG05yp1wm+8fPMplA7Y4OmMiot8PVufHaLobNt45TD56UJ3fTXCY04WP8eGAwMusnJbM3PkMG8NxVt9/OsEdqi4hcXyFNzUTwMUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284124; c=relaxed/simple;
	bh=PD5sRJPxkOujcV/3EkaBxNdeuNR1bNkNwh8G+5oS5rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQsIGyBdkaZ8aAO1VzlGSZOMhEjKEvQ/Vu1Yz/Nf3iEYLgh3FpShhgMcF7/YrVX6rrDcvuWoZrRSNgXqi7UC/pmH4s+uqA25MoZ3eP09hPRloVvFcX6SiyhF8RjdsUaSzlxAADn/E1DiIPHmgkWkp3S9eNuwjsVos+4gMUUByaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnnmUQA2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnnmUQA2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F48C4CEDD;
	Thu, 10 Apr 2025 11:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744284123;
	bh=PD5sRJPxkOujcV/3EkaBxNdeuNR1bNkNwh8G+5oS5rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BnnmUQA239atAQco1TjH9RGPTqGZwl094/JlVnHJfymlP4TUNhwpWtwxW745D3s1r
	 WFMAXhhS1Oo1QHw5HJxDLBXLQ7ljNwuOVqCT0W3PCr9JvW5cSvySfkDKF+/DPQoyBC
	 feYYiFQCVPJOmORVGp2IUdd8QseZr5w3nlWgWehOCGWcpUpNmv1E7dZdmEmmXUi2OC
	 6HpfaWK2mIh/gzOfKmtDFmcBq+neN4jtfBbx4y10Y+yzXbJzL9/GsAM+hM5bauRKf1
	 1VO5IdOnBsn0w87ko24NRxoP2KEH8dnZOfxj1/i4l63p5lV5Reo/iUKqP6F3tptcu6
	 wTLYpXNR3uvtg==
Date: Thu, 10 Apr 2025 13:21:57 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: a.hindborg@kernel.org, benno.lossin@proton.me,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 2/3] rust: dma: convert the read/write macros to
 return Result
Message-ID: <Z_ep1UNeZVsU9E8U@pollux>
References: <20250410085916.546511-1-abdiel.janulgue@gmail.com>
 <20250410085916.546511-3-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410085916.546511-3-abdiel.janulgue@gmail.com>

On Thu, Apr 10, 2025 at 11:58:17AM +0300, Abdiel Janulgue wrote:
> We could do better here by having the macros return `Result`,
> so that we don't have to wrap these calls in a closure for
> validation which is confusing.
> 
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Suggested-by: Andreas Hindborg <a.hindborg@kernel.org>
> Link: https://lore.kernel.org/rust-for-linux/87h63qhz4q.fsf@kernel.org/
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

I think you can drop this and the Suggested-by tag, since Andreas is also a
co-author.
