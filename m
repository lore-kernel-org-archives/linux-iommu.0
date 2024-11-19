Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407CD12CDAE
	for <iommu@lists.linux.dev>; Tue, 19 Nov 2024 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004932; cv=none; b=FH2zm3OBQnLrCKExDZD5gAtNL+F5lh1ld46Gx2VXnj1BQfCsRh1xgROEaX0w9o0RjTGOpwNC412vOG3kyA5ruV42nsnKuvtQyUx37TvVolll+y5YHy9En+g4zLDDuvI75kU7JWisxwqRQx2d7w2Zm0xf8j0nv7CVzAkDOFsZmHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004932; c=relaxed/simple;
	bh=0AqPpf7RNAcBW72RiT+BB+KFARadjaWyA6dvMRHwBFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2KCkZ998A/ruziGWzxEwHeVyQY+q+QMydniAKTXdyDguZmJDLzWR7cTSkmjl0JsXfXJP7jt103eCXliH7spYzFF8tOPIoAjm3avof9waC2eu1PFiLObdpX+tAP2eXnlJJzSNbffnvGwDw0GLamkCCwVR+XwDp+5ZTsRcAQfgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CRBhh2/a; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CRBhh2/a"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3823194a879so2191782f8f.0
        for <iommu@lists.linux.dev>; Tue, 19 Nov 2024 00:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1732004928; x=1732609728; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cyUY32m7VUxlCTDLVt1b+JPHfOUSRIx7q0KXl7IQeQ4=;
        b=CRBhh2/alsEMRjkV1yApZh1yx8vUZl+xHoAQXmyaoizqKDco5JrhKB8bfzzBOVgcWP
         mRKpuZChKzK0zGYdq8NwNowH29nEFHXQ+alKjkoGB18QjhFu25xBaba8A/4Y/AfwZE/N
         NICi3iqgPIVOP/ZqLF0pUXgX5Xre8ZhbkRPjQA2EOlq4Dd4gBfF/PlPGCFDJ+Yo5wiOf
         I/5W/VYyftrWbjlAUUgicfOoDzNKOtRiKCVHYv6vfjRM6mTuo2F+WgUQsGSq2XWAZpXc
         ER+T57R7GggO1AibOfLQRDtffjp1pRqbH+euEyv49ZZSS4s7tNgk/OmE6YbMB7Xv5E52
         xFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732004928; x=1732609728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyUY32m7VUxlCTDLVt1b+JPHfOUSRIx7q0KXl7IQeQ4=;
        b=xAG5U44ThGGTcz7beevttAmtWMfNM56WzKLsmU4XM7VBPwtfiUMZ3D8/58K2EJq5C4
         n0ELz0J5pKjXmoD99xdyDgRvDVrA8SmT6yUmQvFV83Z+15bzcFcynI08AXtG6lzRcwRr
         FSmiNr/MwyVpRJu2lkb3uNIkPF+vQx9Y09/u0cSnhPMQcx1fG2Ho9+nekxVHWyF/4GKo
         JvXVq/XZq7MMhh++mxLIjOF5fcw8gT8XIxPO1QB3mFxqyp0KDc2eP6Fw4byIrA7VLJlj
         5Ib7RLnxC8kijNjcSludHN935TVi7eOH2S6pdBdrS2IdZ4RmzPe2WBDq/g0+YHClSLAY
         wniw==
X-Gm-Message-State: AOJu0YwTTtdplrdGB+SS0CQZ66fnUo99TKcWJoHVRMiqCNUV3Nqw8VjB
	uZ8AeognDPow3UyeV/KZKog9S5qt1z+V3me8klWzt4FcjSU+Q6HwlCidVJ9rD8I=
X-Google-Smtp-Source: AGHT+IHpZMhXyydhQ7Idy4ENb5ObblYkccalbUBLPzNSlCP+c5FRHdBQ5a3DSr77U7024nHK4LI/fg==
X-Received: by 2002:a05:6000:2904:b0:382:4aa0:e728 with SMTP id ffacd0b85a97d-3824aa0e803mr4138031f8f.1.1732004928543;
        Tue, 19 Nov 2024 00:28:48 -0800 (PST)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac21a15sm183138595e9.38.2024.11.19.00.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 00:28:48 -0800 (PST)
Date: Tue, 19 Nov 2024 09:28:46 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tjeznach@rivosinc.com, zong.li@sifive.com, joro@8bytes.org, will@kernel.org, 
	anup@brainfault.org, atishp@atishpatra.org, tglx@linutronix.de, 
	alex.williamson@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu
Subject: Re: [RFC PATCH 04/15] iommu/riscv: report iommu capabilities
Message-ID: <20241119-76c9ff71b8834ef886b3ca86@orel>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
 <20241114161845.502027-21-ajones@ventanamicro.com>
 <ddd40bc3-7f2a-43c2-8918-a10c63bd05ba@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd40bc3-7f2a-43c2-8918-a10c63bd05ba@arm.com>

On Fri, Nov 15, 2024 at 03:20:36PM +0000, Robin Murphy wrote:
> On 14/11/2024 4:18 pm, Andrew Jones wrote:
> > From: Tomasz Jeznach <tjeznach@rivosinc.com>
> > 
> > Report RISC-V IOMMU capabilities required by VFIO subsystem
> > to enable PCIe device assignment.
> 
> IOMMU_CAP_DEFERRED_FLUSH has nothing at all to do with VFIO. As far as I can
> tell from what's queued, riscv_iommu_unmap_pages() isn't really implementing
> the full optimisation to get the most out of it either.

Thanks, Robin. I'll drop this cap for the next version.

> 
> I guess IOMMU_CAP_CACHE_COHERENCY falls out of the assumption of a coherent
> IOMMU and lack of PBMT support making everything implicitly IOMMU_CACHE all
> the time whether you want it or not, but clarifying that might be nice
> (especially since there's some chance that something will eventually come
> along to break it...)

Yes, riscv selects ARCH_DMA_DEFAULT_COHERENT and the riscv IOMMU hardware
descriptions don't provide any way to say otherwise. I can put a comment
above the IOMMU_CAP_CACHE_COHERENCY case which states "The RISC-V IOMMU is
always DMA cache coherent", or did you have something else in mind?

Thanks,
drew

> 
> Thanks,
> Robin.
> 
> > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >   drivers/iommu/riscv/iommu.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 8a05def774bd..3fe4ceba8dd3 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -1462,6 +1462,17 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
> >   	return generic_device_group(dev);
> >   }
> > +static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
> > +{
> > +	switch (cap) {
> > +	case IOMMU_CAP_CACHE_COHERENCY:
> > +	case IOMMU_CAP_DEFERRED_FLUSH:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> >   static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
> >   {
> >   	return iommu_fwspec_add_ids(dev, args->args, 1);
> > @@ -1526,6 +1537,7 @@ static void riscv_iommu_release_device(struct device *dev)
> >   static const struct iommu_ops riscv_iommu_ops = {
> >   	.pgsize_bitmap = SZ_4K,
> >   	.of_xlate = riscv_iommu_of_xlate,
> > +	.capable = riscv_iommu_capable,
> >   	.identity_domain = &riscv_iommu_identity_domain,
> >   	.blocked_domain = &riscv_iommu_blocking_domain,
> >   	.release_domain = &riscv_iommu_blocking_domain,
