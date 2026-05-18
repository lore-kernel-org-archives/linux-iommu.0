Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C64382293
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779126774; cv=none; b=MU9iQ4rpUNDFnvMKHlu4DExriMoleQaM2nNd8SWiPdIhB8P/iu1InK5DZiDVOhFGKKyVXpRKdy9pQiwUfWfRkLC4i0MfrgDK653xrU8dBHiBNPU3CBKjLWtJDuOiLA9HMDbFqR0KSNEeuGHNzv9ZWRLGp/a7lRVY7w3UY0ltjZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779126774; c=relaxed/simple;
	bh=ZSi5qfcs0lvgwM64JjJnMNw7XMa1ww7Fp1AdGrKOChw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLDs0wco2Lh8wQ1wvwz+o3K0A6tbnnxT3VY9gM1q1abJplQrZU+C96Pu9KjVwe4Yk9pFN3uNrwZdISwf3CuSRhL49UecAbwsjf9O2qN/ZmIg9FLTFe3rpJvdFHs7GA+jLAwDBf7fZ4Y5hhi+deC1GEumNIHdYrZR5VAbzgJVgwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aG4hkAmZ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aG4hkAmZ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b74b460d77so36208556d6.3
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 10:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779126771; x=1779731571; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aXTVKb/2WU7jKg8xUh4R5z6ws8fziXO1fuL1081Mb7M=;
        b=aG4hkAmZCDLCd5waLwEbf5MEmTOWbSYN65emi1b0luKPn2uiB+dhx55mnI15zeY1bP
         vhZWUrdXl4/NYKH3sJLYt6mAn3e5MiB5aPu0jXuSPf9S3NLCftQ4X48bnutrGqR+Lqd+
         iy6adpST1X8albFSIpxUvbRy3i43nc4QrL+CEuanhxTY12EeqK+0QZmhh7aMLCJReZ4I
         mfBasqUg6a8NmoxUvCmGOWg6VIm5EnWE2Q9lkb5g2j76Kur8joGqSk8YYqIbnomvj5TZ
         n6QIyDIz5ZhkmXAXHReo0TEn2SY/I75UqWypRGGQPRRMc9YFzkoN6j39Q/9MuPhe5rmh
         KkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779126771; x=1779731571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXTVKb/2WU7jKg8xUh4R5z6ws8fziXO1fuL1081Mb7M=;
        b=Wvo557oLWqCxZ1c5ZLn3QWwxkh0EWeD7qx1IAvB7CZSLlXm0hSKILZ533LcwSv8Hrk
         haFY71TQBlbraprUfS4lVQoWMiN0Z6WDIqPexXGALWDN7qXCUU+wa38p6YnlfZFNiu1v
         z8IoUh/+HaD3wt9fBHMhVji0aVr3laToGEsABWxubT0EHbqVZ3ycR+jv8r/Ok37xDWpV
         y7ogFRVNKolvFbsacj+QJgYBcItK6gYLj9zmwElkIh/0UyWFQYmLUq3l1vRgTg/lf55Y
         oz+FJYpDwK13d6VxvMs4GA+a94PiK+Jkrz2XOGvyERjVXnLZdjn3bHcn5r1uxIBKB2H4
         ZRfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bkpLULHs5IhY0bUh0I3eM7hLxXW9Q/9qa5Zhan3XEMzsn5eZPcPOs2GwcpaFYXMWy6HDV5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZof9L9cPWYa8T3ZbeyUJFaggnVMV3npEtcQ2zmp4pPeCrZIFn
	vPqQLp4BYQ2s3b4uA0M12bttbdMjChRdtyHrp3ccUDC/WjVWD+bh7by48PFScqU4xD0=
X-Gm-Gg: Acq92OHcnjZ6EA2LBuqbnveIH33ECnETL3bT6MBwsfPBhQAFpZcWduGtWUSJoNBZ6jX
	srGAkjDn6VTvfY15I0XKLX8IpWwNwTQkXM4+zjnbogI5L4oyEIcRG9MmtRSu6Nk/GThkFcfQ4Nh
	LHSv7Ry63cOQkwCgRjhDt0+J/l1pnWu0dlj05AXljaww+6THZQ0KG5VEiaNJAju3buB61F/IFz1
	8RQSpKrtrzYjIvzBiT/6eniavlJ6bTu0xKKoxNJ6ZPJygRFLJWprmONHX+WlZdWmfMQIozKBnKI
	ofMws3omFF5eorO9KhVmYmssXLIW+ri31kcVdIjD9hdPwDSNWsopPwqKMSR1lmuhQ0Nws2Xy3P4
	pHKvr+IbdNDsNjYbgDiWQ0yTfTpba1uhn5nOzCNY5FHuAB6w5ShCzNXX43xUz7xkvMq6UKhHe29
	fdKRQJ3PBaj1wKpsf0e7q9ou751MbNRVjrbKMqMGRtFXY6c0LySTceUqgE33jh4z2yk1jNfXz7a
	roP+A==
X-Received: by 2002:a0c:f109:0:b0:89c:cf63:438e with SMTP id 6a1803df08f44-8ca0f5f236bmr214082166d6.14.1779126771326;
        Mon, 18 May 2026 10:52:51 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36086a61sm63262406d6.4.2026.05.18.10.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:52:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wP293-0000000DUnE-2ZCv;
	Mon, 18 May 2026 14:52:49 -0300
Date: Mon, 18 May 2026 14:52:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joonwon Kang <joonwonkang@google.com>
Cc: kirill.shutemov@linux.intel.com, Alexander.Grest@microsoft.com,
	alexander.shishkin@linux.intel.com, amhetre@nvidia.com,
	baolu.lu@linux.intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
	easwar.hariharan@linux.microsoft.com, hpa@zytor.com,
	iommu@lists.linux.dev, jacob.jun.pan@linux.intel.com,
	joro@8bytes.org, jpb@kernel.org, kas@kernel.org, kees@kernel.org,
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com, nicolinc@nvidia.com,
	peterz@infradead.org, praan@google.com, robin.murphy@arm.com,
	ryasuoka@redhat.com, smostafa@google.com, sohil.mehta@intel.com,
	tglx@kernel.org, will@kernel.org, x86@kernel.org, xin@zytor.com
Subject: Re: [PATCH] iommu: Allow device driver to use its own PASID space
 for SVA
Message-ID: <20260518175249.GS7702@ziepe.ca>
References: <20260515231808.GQ7702@ziepe.ca>
 <20260518090654.730478-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518090654.730478-1-joonwonkang@google.com>

On Mon, May 18, 2026 at 09:06:54AM +0000, Joonwon Kang wrote:
> > On Fri, May 15, 2026 at 09:46:05AM +0000, Joonwon Kang wrote:
> > > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > > index 0ca3912ecb7f..61e2e52105e5 100644
> > > --- a/arch/x86/kernel/traps.c
> > > +++ b/arch/x86/kernel/traps.c
> > > @@ -864,6 +864,8 @@ static bool try_fixup_enqcmd_gp(void)
> > >  		return false;
> > >  
> > >  	pasid = mm_get_enqcmd_pasid(current->mm);
> > > +	if (pasid == IOMMU_PASID_INVALID)
> > > +		return false;
> > 
> > If you do this then probably you should get rid of mm_valid_pasid(),
> > mm_get_enqcmd_pasid() already has the NULL check so the two functions
> > are kind of pointless.
> > 
> > You also missed the other place calling mm_valid_pasid() that should
> > really be sensitive to this as well:
> > 
> > static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
> > {
> > [..]
> >         if (mm_valid_pasid(mm) &&
> >             !test_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &mm->context.flags))
> >                 return -EINVAL;
> > 
> > Make that removal a prep patch
> > 
> 
> Thanks for pointing this out. I think mm_valid_pasid() is to check if SVA
> is currently in action while mm_get_enqcmd_pasid() is to get the PASID for
> "ENQCMD instruction execution".

> Since it is now possible with this patch to activate SVA without involving
> EL0(for ENQCMD-like instructions),

I see, this thing about which is about LAM should remain, yes

But all the "EL0" machinery about trapping and enabling ENQCMD should
be moved over to mm_get_enqcmd_pasid() and never call mm_valid_pasid()

Jason
