Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D20213235;
	Fri,  7 Mar 2025 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345968; cv=none; b=f3mRJigaX4zCVFrNI+S9CLRIUjfa17EFYJvRcn8iqayYolTTdrcUpYYnsdxM3BkJZAjBG0SQtuiK7v8n+pwJbLJI6Us2ngsm0/TBlAKDBjXEkrLBPQ6hLZMWednRgQ75OYGJAiI+DHoy+oBN4cTjQai4xOOxUaymQlPvSY1Zflw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345968; c=relaxed/simple;
	bh=tuBimbXzow4XLFdHKQOIDyWxfYReI29nJXDxbtX0wQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l90BHZPE0XA7/2ZcVUvQ1IwlmYBlR3v6Vqon+ACPGcWBXgBx6OGCo58Aw3u3z5RhJGpQbOcj6pBsJlLAVdZJHTBhGAyRLDHwiE5gzT53cQ4+iK3iaTjIpDfzM70dln47DDvOPZ0n9cDi5zbSCyN/DENmvWRUU4YvCOMvSISQiZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbyaXTdu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbyaXTdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB2AC4CED1;
	Fri,  7 Mar 2025 11:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741345968;
	bh=tuBimbXzow4XLFdHKQOIDyWxfYReI29nJXDxbtX0wQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BbyaXTduJSAKQR6VM9d02MU9GQ/F1EI5qLMiVNXQFo5fwuCOCMbS13x/xEe3Lm958
	 DjHBUpPUYYeKQfPmCGtXXznUFND8VMO//j2D6IEGWTxEyfCbxqk5To2IgSZ7XrA+gz
	 WoCmOEbRtC1Lfrz8XF5as8VPIIU0F2kOl6FIOWIQHQQRQTfBMtPIz3uagwNvShvPQR
	 tpdD74e/6xJxUGDJGdTAkMFgF0cVBH0jcOWZ1qs8/+fuOIHgSN6ZQIAeOcLZYmUhcL
	 4PiEDlZLD0/lTHcJbO0qQp2OVgil2bZW9M9XQTzz1raqTlrhcm947VCCt6j6/j3VYV
	 OBXLnc0LzxxgQ==
Date: Fri, 7 Mar 2025 12:12:41 +0100
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
Subject: Re: [PATCH v13 0/7] rust: add dma coherent allocator abstraction
Message-ID: <Z8rUqc1N2K37Xkzf@cassiopeiae>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>

On Fri, Mar 07, 2025 at 01:06:17PM +0200, Abdiel Janulgue wrote:
> This series adds the rust bindings for the dma coherent allocator which
> is needed for nova-core[0]. For v13, the biggest change is to move out
> the as_slice and write helpers for later discussion. The object is also
> now wrapped in Devres to explicitly tie it to the lifetime of the
> device[1].

Just to clarify:

What is meant here is that a CoherentAllocation can't out-live driver unbind.
This is not equivalent to the lifetime of the corresponding struct device.
