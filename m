Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CBC5477E;
	Fri, 24 Apr 2026 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777072528; cv=none; b=lAM0chK9WZaBy0qgYsV8ocD7BFvVB0ffF6Qbox9rk4v5rr6Mp4/kr3VQBGQc1r6/jSaM0YM+gG2t0/APmw4KtkNzacxNAJqrBV88f5C3xTzIjyR00ja2J2T0elhDz7/F9hgnCrq/mMzyd7FZoBigGPUZ87UrianZUywvHHxlcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777072528; c=relaxed/simple;
	bh=oLKd9v1uv4DZICMQa7d2btuR4XwM6ccabR4xaT/WOVs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k+ediDRE/7VYMCRX68+KRegtiJtXdThlE2KBmHLYjQ22oOrAZ1Z9KLgstFvGK5dYB9wGbE6EZQPjox06GB6iqnGwFs9eH3ZHA2MJrXELpSwurxvharm8BTscr/TDiFx2Dz6e3EPTK4HJWJxma17UzdHxWnfhd2mwjqzTMZHTa48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrPZzhd8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrPZzhd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07AFC2BCB0;
	Fri, 24 Apr 2026 23:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777072528;
	bh=oLKd9v1uv4DZICMQa7d2btuR4XwM6ccabR4xaT/WOVs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XrPZzhd8gqlvrlhRjmnvzAkOWZkp7z6h07lMvp5hKcGz2ymBYWeuskWexLTk/f31O
	 LWy0Qw1ac3KdNU5L9jgjuwuMaJczlwjZsBakurn2EdLA/NMWleOOtC0YQZL80rcAcO
	 Ze/NnKmoOiwyvgqozVTwRkegiEKMzTYEoeMtFeWMHAfcstN99SpNUeNOjNkuqIez7Q
	 c3FVWzCw6j7A0I1bSGqDXrPbaAGxSRBFRK+UjpjrOQ//ixN19sidlBr9aXUHma5jG0
	 9M03z7bet+WE23nU59UaAAYS21fRjHRVO/RwaKbHp59RtagmqRqsqzyxVRnhV5mkfw
	 LisnYBy+gfI+w==
Date: Fri, 24 Apr 2026 16:15:26 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Peng Fan <peng.fan@oss.nxp.com>
cc: =?UTF-8?Q?J=C3=BCrgen_Gro=C3=9F?= <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    xen-devel@lists.xenproject.org, iommu@lists.linux.dev, 
    linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC] xen/swiotlb: avoid arch_sync_dma_* on per-device
 DMA memory
In-Reply-To: <aesV0ai8SM89cb3j@shlinux89>
Message-ID: <alpine.DEB.2.22.394.2604241614280.6871@ubuntu-linux-20-04-desktop>
References: <20260415-xen-swiotlb-v1-1-de24eda3c0fd@nxp.com> <f6cf1d46-9d2e-4b52-a6b9-fb45d01b874f@suse.com> <aesV0ai8SM89cb3j@shlinux89>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1721512358-1777072528=:6871"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1721512358-1777072528=:6871
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 24 Apr 2026, Peng Fan wrote:
> Hi Juergen,
> 
> On Mon, Apr 20, 2026 at 02:19:34PM +0200, Jürgen Groß wrote:
> >On 15.04.26 17:08, Peng Fan (OSS) wrote:
> >> From: Peng Fan <peng.fan@nxp.com>
> >> 
> >> On ARM64, arch_sync_dma_for_{cpu,device}() assumes that the
> >> physical address passed in refers to normal RAM that is part of the
> >> kernel linear(direct) mapping, as it unconditionally derives a CPU
> >> virtual address via phys_to_virt().
> >> 
> >> With Xen swiotlb, devices may use per-device coherent DMA memory,
> >> such as reserved-memory regions described by 'shared-dma-pool',
> >> which are assigned to dev->dma_mem. These regions may be marked
> >> no-map in DT and therefore are not part of the kernel linear map.
> >> In such cases, pfn_valid() still returns true, but phys_to_virt()
> >> is not valid and cache maintenance via arch_sync_dma_* will fault.
> >> 
> >> Prevent this by excluding devices with a private DMA memory pool
> >> (dev->dma_mem) from the arch_sync_dma_* fast path, and always
> >> fall back to xen_dma_sync_* for those devices to avoid invalid
> >> phys_to_virt() conversions for no-map DMA memory while preserving the
> >> existing fast path for normal, linear-mapped RAM.
> >> 
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> ---
> >>   drivers/xen/swiotlb-xen.c | 17 +++++++++++++----
> >>   1 file changed, 13 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> >> index 2cbf2b588f5b20cfbf9e83a8339dc22092c9559a..b1445df99d9a8f1d18a83b8c413bada6e5579209 100644
> >> --- a/drivers/xen/swiotlb-xen.c
> >> +++ b/drivers/xen/swiotlb-xen.c
> >> @@ -195,6 +195,11 @@ xen_swiotlb_free_coherent(struct device *dev, size_t size, void *vaddr,
> >>   }
> >>   #endif /* CONFIG_X86 */
> >> +static inline bool dev_has_private_dma_pool(struct device *dev)
> >> +{
> >> +	return dev && dev->dma_mem;
> >> +}
> >> +
> >
> >I don't think this will compile on x86.
> 
> My bad, I only tried the build for ARM64. I use below changes, if it looks
> good.
> 
> #ifdef CONFIG_ARM64
> static inline bool dev_has_private_dma_pool(struct device *dev)
> {
> 	return dev && dev->dma_mem;
> }
> #else
> static inline bool dev_has_private_dma_pool(struct device *dev)
> {
> 	return false;
> }
> #endif

Please use CONFIG_DMA_DECLARE_COHERENT

--8323329-1721512358-1777072528=:6871--
