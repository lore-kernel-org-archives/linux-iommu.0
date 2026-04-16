Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141203126B2
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776328520; cv=none; b=qTc8hHEljc/8IDTdgQ08tKuTNbOU61aZH07VD6SAyMRZgCfM4pZ7Y5iqHnMyeNXjqhofkQPsDOU3Td6C+pOekkzNO6jtLOihifMXS7PDPRGtd5+OU1XhGmrilUzpLs/zwZt7gG9UznqVXIZ7IPZQ4ihhHDAVaTFqyrfSR4pOsGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776328520; c=relaxed/simple;
	bh=QVuygGU1ff2sGxNC8lLE1OKZw6HwO9c7JdEGE3NC6jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtqEzcXwqUjtcEW6/KOIYGdPrCduOPQkVeQl7PT2Hi7OKfqKrE7TN4B7eRPU37FzF79QOKkgxd4c0cM0+mpJeYk+M9jY45KyQaD7e0y/65p0kJEpM5/EsI16Z/CVJJUIe/VJHY4ngbsmjIPoCdkK3YmJIvZMAgVMhR3+odA1icw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ds0fQLi+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ds0fQLi+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4887ec3d8e7so63485e9.0
        for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776328517; x=1776933317; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dj+m4YQEsurZA/e5WVnm4SkE+PtyoD5FKV7SijMxVME=;
        b=ds0fQLi+DeKdoI8P0wPENcPuXpAEVF074gehBBgkLRYZJXzNKcfQGRgXVtlLDqgHBT
         yqszkJJVhQpyeDtGU+zMp0SyIiP/hC/X9uF40gXofPD7j6BdrxEQfdGSJi+PEGnV8Sax
         8ujSXG/4pCTrJcRgLe6+gMVt0cRRtT5iyv1zvJ0XfkjSy8IrEXWV2fU13ujPJsDvZMZL
         UXFTbOHxhfgrZQqoymHZQ//cOKz5a+DpNwguyywSxsgi/fmIyvyIZ5v7Jp4VeZbsTjL/
         tAj08f1CQqiFpw7FzlvbuzT54u095KdZtzd0FY4+9wPBA0bTW477ZyxRpE4U1xii6w+9
         LmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776328517; x=1776933317;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dj+m4YQEsurZA/e5WVnm4SkE+PtyoD5FKV7SijMxVME=;
        b=TNJnPIdmyLuujy+qNkristGfAeYfu/A0hs3SpYdvk+ghvxuLM5fop6t7mecXd75xS9
         I61pA4Rx50rz6sOHEvjck5wj2jCatGGsAAlV5l8ZiNGix/Kpi1EjXdFKx7lhj4aDul1D
         RTf/U28oS1ZzOSA0tPRSDVHfkaQmsShmbOAYks8M4RxULSbROzvTpS8aK2P9irtkF/Ht
         /SbtYk/9CAx2j1eLreithiMWLnsk1wMDsH9nsuKVhtNYVq+nj/zT9LrM5rDettBETW85
         VoIYxFZyDiTPDVWcP8TZpXzMuSxufs25Q+JhKxavFQj9RN62v99jO4iDIe0uwNi9YxwJ
         Xbxg==
X-Gm-Message-State: AOJu0YxwKv0p63+b3b/asvJzl81EDHAjMMCpvCMkD7mGxR/lAQ6wYES1
	x1qeQYtBo0ksSx3JVyidQI0lPOKlFvYHkB2xT1Qc2fzLjzkkuyo6hpRsb9jbztjtfz6rUGD5/hz
	SKlBCpg==
X-Gm-Gg: AeBDieuIr14/IGjerqivB6lWAXaeFAMP/LxQBFgBsPgGt5yz/g7QGZGy0qx72qKgviY
	AQcxVhe4f/nhM68X1vMJEpftXv/ah9Ra8JrrfNGuEeRrCxQpbbwilYndT+phZadRMJD+TVeQR6R
	6aKUDZLbe3IqEP1ynhqr9C+xwmqesDMWlQ5WpHZIH1Yz15yqt5kPC7J+T7Z/65AAE8b8/KTlQvy
	/fBG6FFX6pI2QPs3eFE/SF3GGOUaBrQMRGakkz4444chmLxTF1Z39FaeenVQpiP7BaqUOdrE2v0
	owBzwMVo+jQ33OSuLSi6cq7EU0Xu44ou8gmIMGu12ip3Tto8ng/kKGo5o7I5h1engQTKeAAZwxV
	5lyf9a9DlKRjoSB+OVRcb9pU3Rw9gu6KPfBtGJxt+//jwR+e6w0mIQFuJLy65qqm5hGVUnaezBt
	4s4YlzBhzMmu+Qsyv2u2B7k+Gs1hD85VmElRCEHLBKHHca6VmGHIx9CEpHM7RpWAzniJvQrlvtS
	Io1kchvW33z+ifO
X-Received: by 2002:a05:600d:640f:10b0:47e:dbb0:fbcd with SMTP id 5b1f17b1804b1-488f4ad95f8mr433145e9.6.1776328517140;
        Thu, 16 Apr 2026 01:35:17 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f581652csm37377315e9.3.2026.04.16.01.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 01:35:16 -0700 (PDT)
Date: Thu, 16 Apr 2026 08:35:12 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, jgg@ziepe.ca
Subject: Re: [RFC PATCH v2 2/5] dma-mapping: Use the correct phys_to_dma()
 for DMA_RESTRICTED_POOL
Message-ID: <aeCfQNI4IEiK1fx2@google.com>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-3-smostafa@google.com>
 <yq5abjfnbdej.fsf@kernel.org>
 <ad_0pqI0uWZH7D8k@google.com>
 <yq5ah5pb9z6m.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5ah5pb9z6m.fsf@kernel.org>

On Thu, Apr 16, 2026 at 12:20:09PM +0530, Aneesh Kumar K.V wrote:
> Mostafa Saleh <smostafa@google.com> writes:
> 
> > On Mon, Apr 13, 2026 at 11:38:36AM +0530, Aneesh Kumar K.V wrote:
> >> Mostafa Saleh <smostafa@google.com> writes:
> >> 
> >> > As restricted dma pools are always decrypted, in swiotlb.c it uses
> >> > phys_to_dma_unencrypted() for address conversion.
> >> >
> >> > However, in DMA-direct, calls to phys_to_dma_direct() with
> >> > force_dma_unencrypted() returning false, will fallback to
> >> > phys_to_dma() which is inconsistent for memory allocated from
> >> > restricted dma pools.
> >> >
> >> > Fixes: f4111e39a52a ("swiotlb: Add restricted DMA alloc/free support")
> >> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> >> > ---
> >> >  kernel/dma/direct.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> >> > index 27d804f0473f..1a402bb956d9 100644
> >> > --- a/kernel/dma/direct.c
> >> > +++ b/kernel/dma/direct.c
> >> > @@ -26,7 +26,7 @@ u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
> >> >  static inline dma_addr_t phys_to_dma_direct(struct device *dev,
> >> >  		phys_addr_t phys)
> >> >  {
> >> > -	if (force_dma_unencrypted(dev))
> >> > +	if (force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
> >> >  		return phys_to_dma_unencrypted(dev, phys);
> >> >
> >> 
> >> So what kind of device is this? Is it a trusted device that needs to use
> >> swiotlb in unencrypted form?(is that a valid use case?) Can we add additional comment
> >> explaining the type of device for which we are allocating the DMA
> >> buffer?
> >
> > That’s used for devices that use restricted-dma pools which are
> > currently always decrypted, typically virtio devices that are emulated
> > by the untrusted host.
> >
> 
> Why would those devices not force unencrypted DMA? Sorry, I may not be
> following all the details. The pool itself is decrypted by default, but
> the device does not force unencrypted DMA?”
> 

That’s the case at the moment for pKVM guests; that doesn’t use
force_dma_unencrypted(), and just rely on swiotlb.
When I was trying to enable that, I ended up with the double
encryption issue fixed in this series.
I believe that swiotlb and force_dma_unencrypted() are completely
independent and the code shouldn’t make any assumptions about those,
ideally force_dma_unencrypted() is a property of the device in a
protected guest and swiotlb is per pool.

Thanks,
Mostafa

> -aneesh
