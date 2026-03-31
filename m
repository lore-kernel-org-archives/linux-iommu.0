Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE7E3E0256
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961465; cv=none; b=LWAB56T2qk0jtx3J9o3UGAJx2MVa3Sis6Zntpoi+/lNRlXCe/D8MRtKcbTSxuurM1z7vhdbFJkiEAqhV/UHBMavdsi+Jt+r92qbBB7Q13KWKA69qXl58cSGoHq25VTUtXiccu514Ra2UhQezYDZPAR9w0m9SWMNsUMj4sJCaUXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961465; c=relaxed/simple;
	bh=PhWHQAsalpJUOajAMVUYt4T89J+QMIgFT9bSZZbALvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJs+fseFnPAcsGOoq0tVm1qI1BwZQHwvFn6rcWjPhQU2ch6Su8V2CJu8Ov5exMnJQ6bb5xt/bxy3S2AqmjZXLD5iimav5HMr3CBI9peH7lUWieynnoiJwmtckqnjpVRVudO0yfJegDdtdy+7WFkJFKyMssPIjpwvN2hpnRNMr5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rb0EJu06; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rb0EJu06"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48569636800so67595e9.0
        for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774961462; x=1775566262; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ue71QgAGqVXl1HhFnm1R+HbJwv6JK/eX4X1Rzy7qR4U=;
        b=Rb0EJu06J79EOFt9OSZNvGTEyGxuoYJg9Cv1DBZzwXUF/yx5XjYvXWSMqg0OZaZ8Zi
         pm8cBV3u+UN3dIgVkNdYhH1RekVexXPNWWff9s5MiB3E3jWCc9I0/khdbP44sSRZPrFW
         AawTA7wb33BdOwAZFeIoBw56Gz7szKEHipOi+nBo8bEcuAAAT1ndKby1DOr502mPfZij
         ZWkvQkgMnPUjr2P9m9/dN5hSIL/IW+8iRIzDevCW5H0kpG1b3U4y+nFHX1mSBz7c+aMo
         h/PdAlATyK7wCS0Ibw1bydY+uH/x70x3wTTZZnRaW1nIK8F1t2p2nDghOLJnRLK1be5Z
         xawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774961462; x=1775566262;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue71QgAGqVXl1HhFnm1R+HbJwv6JK/eX4X1Rzy7qR4U=;
        b=C9IWurhXczD+3aAXaroygYUTAx1OwhfIneLfwGAGQWIDdIVJu13QJ4fyQCQ+1qilwm
         FD8f756nT7mKOwH51C8gzHxj7I6t2XguU5OXRiqwHRFNaKSPAHdj0C5vCJcQyiPhGB6N
         4v2YFk2/VyTkKeNYspdMRufcwxWKhyqUQQnA0Vwoe9qkcvKDjv8P3Nr8oG7tWGcBSHel
         wQVMELxv1CVp1He8oZQJWTxGvi1V+TATEraAy3JzHNPPNHSIbyr/PD/1jrXnKUd+8Wid
         oIMlwJ6PY1uYODnECx81sJ5p3sCaREWDbFjfQAFZvqgBEWWGBvFBj8n2lipXbkNtEqMs
         eLkg==
X-Forwarded-Encrypted: i=1; AJvYcCUWCqYAM63xEg1Zo+07OINuN9AX5uIrHDpP0Darzwa9m4zMw/tXJgjDaJ6b+stuDqycsYhWUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjnN90MExVpp2LP2OwohTwXD6w6gwuwl0bNeqOx8Dqc5NtxFkg
	A5oawT98muPOKLcxLyclMz62nkIouqoEJ5IoMBHJz2V4kgPH+5GuigBpoqEMjnRR2g==
X-Gm-Gg: ATEYQzxUpyoVcDndyNAn/InnGi4tTU+nkDUktvpeg8bS8CM9JkD8i0jOkiM4ff9pD7x
	omp4LkojB84XqSmXjFVouEOtDjzgNssvWSq+ySWcQosP4UathbDC5xBKIZa0ZA/5wyvcMt4h1ib
	J4eIlY2GDqiKwZQnppF74Clq+JJocNsPcyDEJAs0eyVMorhP+nccyifvVD1vbcJ5NeyDAt1Yp9c
	98wmBpb6omfyDs9YBFidYcCFcdxn0wjPCl0xPtPWrQ+DiFXNUBdG87UrbT1czm/TU8SkjfN1BCT
	z/wvUV7drL+h7o//25hukRd12TTyCuY8820xW00eSA0FdMacB38tYuKhThp9/mcQL4wlI85tJsl
	pLwBbuyYiNIU7AzRiAWNYBlrAY62IJYDERCvRjxjXDidumZFxFLhBTE1jvKKbglIl4mKCa+ipnm
	SokxdQPI/ZuYuLZfrUS0wNU8XuGsWtddcLr7Ti+isWT32GG8K+1s7uYX/Y
X-Received: by 2002:a7b:c845:0:b0:485:2af4:9699 with SMTP id 5b1f17b1804b1-4887b19ebaemr598405e9.3.1774961461647;
        Tue, 31 Mar 2026 05:51:01 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf90424fcsm22394257f8f.32.2026.03.31.05.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 05:51:00 -0700 (PDT)
Date: Tue, 31 Mar 2026 12:50:56 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	m.szyprowski@samsung.com, will@kernel.org, maz@kernel.org,
	catalin.marinas@arm.com, jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v2 1/5] dma-mapping: Avoid double decrypting with
 DMA_RESTRICTED_POOL
Message-ID: <acvDMPash7-twyxS@google.com>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-2-smostafa@google.com>
 <20260330150654.GA809900@ziepe.ca>
 <acrgYotBExJhEJkK@google.com>
 <acfded81-f04e-4be0-af98-6ed43b8409ec@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acfded81-f04e-4be0-af98-6ed43b8409ec@arm.com>

On Tue, Mar 31, 2026 at 12:34:20PM +0100, Suzuki K Poulose wrote:
> On 30/03/2026 21:43, Mostafa Saleh wrote:
> > On Mon, Mar 30, 2026 at 12:06:54PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Mar 30, 2026 at 02:50:39PM +0000, Mostafa Saleh wrote:
> > > > In case a device have a restricted DMA pool, it will be decrypted
> > > > by default.
> > > > 
> > > > However, in the path of dma_direct_alloc() memory can be allocated
> > > > from this pool using, __dma_direct_alloc_pages() =>
> > > > dma_direct_alloc_swiotlb()
> > > > 
> > > > After that from the same function, it will attempt to decrypt it
> > > > using dma_set_decrypted() if force_dma_unencrypted().
> > > > 
> > > > Which results in the memory being decrypted twice.
> > > > 
> > > > It's not clear how the does realm world/hypervisors deal with that,
> > > > for example:
> > > > - CCA: Clear a bit in the page table and call realm IPA_STATE_SET.
> > > > - TDX: Issue a hypercall.
> > > > - pKVM: Which doesn't implement force_dma_unencrypted() at the moment,
> > > >    uses a share hypercall.
> > > > 
> > > > Change that to only encrypt/decrypt memory that are not allocated
> > > > from the restricted dma pools.
> > > > 
> > > > Fixes: f4111e39a52a ("swiotlb: Add restricted DMA alloc/free support")
> > > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > > ---
> > > >   kernel/dma/direct.c | 4 ++--
> > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > > > index 8f43a930716d..27d804f0473f 100644
> > > > --- a/kernel/dma/direct.c
> > > > +++ b/kernel/dma/direct.c
> > > > @@ -79,7 +79,7 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
> > > >   static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
> > > >   {
> > > > -	if (!force_dma_unencrypted(dev))
> > > > +	if (!force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
> > > >   		return 0;
> > > 
> > > This seems really obtuse, I would expect the decryption state of the
> > > memory to be known by the caller. If dma_direct_alloc_swiotlb() can
> > > return decrypted or encrypted memory it needs to return a flag saying
> > > that. It shouldn't be deduced by checking dev flags in random places
> > > like this.
> > 
> > At the moment restricted dma is always decrypted, also it’s per device
> > so we don’t have to check this per allocation.
> 
> Doesn't the initial state depend on platform ? For CCA, the Realm must
> decide how it wants to use a given region, which for the restricted DMA
> pool, it can be made decrypted. Could the VM OS decide to make this
> decrypted at boot ?
> 

At the moment no [1], the pool is decrypted unconditionally.
As mentioned in the cover letter under "Future work", I believe
giving the OS the ability to have undecrypted pools is important for
confidential DMA.

Initially, I thought that can be a per device property (so the
platform will keep the memory encrypted for physical devices and
decrypt it for emulated ones).

But, that might cause runtime issues as a pool can be shared between
multiple devices. So, I beleive it's better to have this as per-pool
property(from device-tree for ex) and then the platform can do any
validation of assumptions it needs in the runtime.

This is a bit hairy, as I mentioned it would be a good topic to
discuss in the next LPC.

Thanks,
Mostafa


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/dma/swiotlb.c#n1847

> Suzuki
> 
> 
> > I can change the signature for __dma_direct_alloc_pages() to make it
> > return an extra flag but that feels more complicated as it changes
> > dma_direct_alloc_swiotlb() , swiotlb_alloc() with its callers.
> > 
> > I can investigate this approach further.
> > 
> > Thanks,
> > Mostafa
> > 
> > > 
> > > Double decryption is certainly a bug, I do not expect that to work.
> > > 
> > > Jason
> 
