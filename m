Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008943E2AC5
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887092; cv=none; b=JRAYnKlV5UrLdZbHDPI5v0E4SoLym+FHfblOv8KjW62HddvDz6c79+S91ODh+yyb7LYci9Xfh7ltlEPhnIeXU5alslu1ld+/yMrtaqpVwBUlG0E1FADvQvfvJRRi7P/g2E6OaTDWtobKPEPjfwD1jnbnvzWoQ9dLK9ACY7kUq4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887092; c=relaxed/simple;
	bh=Ct+wga2dofIdnDx++8UUU0g59OUMQeyIdPpze5o6s5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DA7citJALrMZZt0Hb428SoN8d96NG6pjECq7tmJaURC01L3C1KPRbbjqCViwoev3SoMNqTIZnUWNtXcG92oUT+G9K1rVwDhoHutO4cICTUFNpvYCIHSjOnnUOORYBi9bU8aHS5yDCeOSZMaPQdauTPU8DM8ByubRDFsSArb2rIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WQjXHsKq; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WQjXHsKq"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b4eb1fd5d0so5486816d6.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 16:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778887090; x=1779491890; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8jUKJi5Y22AXfRJ2QMuXqI6SMCVq8sgVEt+NQLm6AGM=;
        b=WQjXHsKqbM56IRwQwTyAEcEg6Dw4cZvS53S9wvbIBulOu7S89q+4LorxpQSYju9fGo
         nj1NMog1msqzzgAgXaLq1ewqgD5LRLJw7UGTqXRWvcmjtjAb/09IEQ80J+yC5YM77995
         bkpZsTQ0+nezYHCQoVxHboUXONe6OudqMZSMxPgBaWHcUWY2yNnNidwRcprD2l92MzYV
         gAIrj4fjcsr8qpRMVoFMu2B1/JUPWKBFsimbdGNUiiG8Z8261MPmT9ExBjJRanUYKeSQ
         vy6WSU9jDLUq3Y1I+3xMeljQJ5GxTbY9gtMvCpOFdbtca58dRMBCJmgbQKaRd0C3cWCC
         p78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778887090; x=1779491890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jUKJi5Y22AXfRJ2QMuXqI6SMCVq8sgVEt+NQLm6AGM=;
        b=qgumFNJPav5Dkomjjhbqni9KWPZXpmilh1MfYpLheg7ZGa/JyB4pXPTY4k/axOiqFH
         c1C+ihf6i0Rwh2ufjOjHBFVFbFamHdQjpltupHxx2i2KUMRFw3vJv8QVyyDfNZS/9frf
         Nqw3hP5oVnHLCl51HnTDBT+cUNBZHXYWVHcE21hxw656ag7UMz4bso9BlGx5kGrp8akd
         2KBGxfzcxopiefIQkJuFQdOlkFeIOZUKEqVHPdbGvFxALeWFFjnbZ5NolQKY5MYv8dpS
         /01rFXJXhvMFUtF7gLmDBaKcmiPC5/ZVTzmSne64JFpluClgGxnBDx4Bz2lvnxVzkLzv
         w8fw==
X-Forwarded-Encrypted: i=1; AFNElJ+Lbk5MsAVhCw+WliDLk+UCXUKC3gEaR8gyY/KMCU5CZBQiVXNge/iLIx5I4ETYltWPMJYHUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmRQxGjCqyg2MWYwQOYk82HEgsQE17zbEJCkuCF5NSfnGk0odl
	0oF1/ijAzzDtWKviw60RWgccxXto5GakAbuMLOXzHIB3Zl4qmXgdzMgIQU+j3wW1RtE=
X-Gm-Gg: Acq92OEvBPfIcqvzih+549M57FskUslCTvyBfqjS7K4GLdm4c7j/c708sqJcmaXR0ly
	CvBLKDvdkl7hZvHmLZuxzlSdbB/FsDqJf3c96/TlnwAejeQORYnivJnaCbSxboCc8tnPByaNaqE
	fXsMjAChSoz/TSfVVFHCIeOgOXRIokoJCXFiD/UlstkOSk2jfSIDZx5muq7EpLG5mSzpTRDMjQh
	S+hLIakxNg/EkO5QEYB8sRtTYqHTf/y01yEa0UbQpay03KrqngevckJQi8sXEZsowVAoEYa8pxE
	KM3UEITZyclK2HAftBKnwcQLYG4tOQBb9PDmfQCT4Kv1aKyREbqojeY0sAXw/xODP5lt8Uy3k3l
	ZvxZlzXhPyqOrqxzX+wgeExA8M532ogyo0UAeucnD9Q66IKM8B6N3oCLGiG1d4VkWV7bAHROfYx
	g0YXxUE/BknzgvCvIqEZi1zuprUjQNNhq2WW3ZvSVSOlvcdhI08r5X7/G2HJXH4hwZ+MvR1TaYN
	mukmw==
X-Received: by 2002:a05:6214:ac2:b0:89c:4b7a:6a6c with SMTP id 6a1803df08f44-8ca0f6d5599mr106885406d6.46.1778887089958;
        Fri, 15 May 2026 16:18:09 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90b2db7fbsm66749856d6.28.2026.05.15.16.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 16:18:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wO1nF-00000008IBY-019X;
	Fri, 15 May 2026 20:18:09 -0300
Date: Fri, 15 May 2026 20:18:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joonwon Kang <joonwonkang@google.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jpb@kernel.org,
	Alexander.Grest@microsoft.com, amhetre@nvidia.com,
	baolu.lu@linux.intel.com, easwar.hariharan@linux.microsoft.com,
	jacob.jun.pan@linux.intel.com, kees@kernel.org,
	kevin.tian@intel.com, nicolinc@nvidia.com, praan@google.com,
	smostafa@google.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, peterz@infradead.org, sohil.mehta@intel.com,
	kas@kernel.org, alexander.shishkin@linux.intel.com,
	ryasuoka@redhat.com, xin@zytor.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu: Allow device driver to use its own PASID space
 for SVA
Message-ID: <20260515231808.GQ7702@ziepe.ca>
References: <20260515094605.3195841-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515094605.3195841-1-joonwonkang@google.com>

On Fri, May 15, 2026 at 09:46:05AM +0000, Joonwon Kang wrote:
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 0ca3912ecb7f..61e2e52105e5 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -864,6 +864,8 @@ static bool try_fixup_enqcmd_gp(void)
>  		return false;
>  
>  	pasid = mm_get_enqcmd_pasid(current->mm);
> +	if (pasid == IOMMU_PASID_INVALID)
> +		return false;

If you do this then probably you should get rid of mm_valid_pasid(),
mm_get_enqcmd_pasid() already has the NULL check so the two functions
are kind of pointless.

You also missed the other place calling mm_valid_pasid() that should
really be sensitive to this as well:

static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
{
[..]
        if (mm_valid_pasid(mm) &&
            !test_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &mm->context.flags))
                return -EINVAL;

Make that removal a prep patch

I didn't try to check the rest closely but the approach looked sane to
me

Jason
