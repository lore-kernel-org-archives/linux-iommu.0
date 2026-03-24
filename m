Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8A63EE1F3
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353664; cv=none; b=hkf8PDbd4+b0S2Gxzp4EuA3UemI8iCl2RxsFfnesR+Wr4MqpfnSoE8jQR84uMFqdNveNlyifMmikjmEeYjTiNmjqL7alKeXbdP6g1dUEirWn3kZ176AKzzgFKEACh/E2vbbe9m3kBEt2REnINBOzDVZjzhK7S+XFIcdMsCoeiHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353664; c=relaxed/simple;
	bh=LBSelXUmDdw7uStyJ/dS5KNmrXZYc6tcp0HXtRjX5cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rK165BcECvD8BrM9g3HboPLCLwcobemqmnoHKmRnN+wdWTDY9ErQRNllLAvd4lc25dyRyHE53vahnVCxxyP1AlSXpD0o83Ss8fFa3j3ZAqwQQ8g+x6iJg/D7hUSJBoUyntpCc52xsFKig9p4zyYF+7DVIUbCiFKS86+QN0cl4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=h5oLWxRc; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h5oLWxRc"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d7653db148so3016334a34.2
        for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774353660; x=1774958460; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6xGeDSaplrfa0s0FkTnYgpWTfeJHarWr6HfnS+Tx8gc=;
        b=h5oLWxRco354BwzH0HQIF4+ZCi/HrI6TDb65nsahZ6lMxHefytxEfUCpDLK/Z6zh1Q
         n3i8EwHGxCaU5KvOy0PbLJ990dY3s25e+G1zGh/Gh70u0tl13kuHouKJkpPk/DaO+Zsi
         c70BW9DcYG7ACzk/INl62JQBec23mdu1Z/T/NAg22D+UMeuqRtwiCe7LuuQdVJg3eAl4
         K/JKVF/BW13ZbJW9FP0DUWHbs/0ccwJSJupa+gXlZPPdoh4En+LMuXfWo+UZ65jGvULw
         L3k1B4a9huRq3eqOj1POw73wZUeH9sBGKWrejAW5WCnHrxd51x2TKMu3mtG3qj9K6izJ
         px2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774353660; x=1774958460;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xGeDSaplrfa0s0FkTnYgpWTfeJHarWr6HfnS+Tx8gc=;
        b=acYMRlWiA8wueu8UJG7rjhqb90xws1YRxJ2T1dzdxku+nSlANkvFQjBKZanMWiJNyk
         CdRYhBjl7jnDRQ0enzqhJFhcClDN0TRLwI7/r9lVM6s9yhtvm2saOU/lRRuvHI6/tZQg
         xoEjKHACGKmRIwig247cX/e35X37INmau6QUZbQBceM8Zt8hbtOiP2EgUsg+oVlpCMKo
         RX/mNizgtNP5nc0WBpB8kSc3s/PZxKEx144RQuy+d+F6jWOJDGQecPPXdM6/94bi6oiS
         8bh/vFxhAxbGVE6bD3w0no8kK9SC2oYuZYa5gviv4B+Q6ubhK8wbQjuWlejXgnxsMl6J
         737A==
X-Forwarded-Encrypted: i=1; AJvYcCVnGnJKWdeT0JZ2wFl3XQRTIRIacyWOMHcniez/fRaS4ptXNVPa71Uzw5jpQN2QDY/3hAOcmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhzeHnqzXOrqllvTUlV7WOsZ9j4kOSH7nhf8YwWRzBlaKdvs+j
	NZV9jHCuLv9l7AkSDxcoTLs007lKnM48jWFsGopBgjksEuoZpwJlp2ivoowlY23WBYw=
X-Gm-Gg: ATEYQzxBOQAJUfnig87ztIYS+MyjrxlSc44vZXCMNehDUX+icArM3dSbSnJYN0XHlTS
	Fy2dcH8i9poxkaZZIEJlOnuyF45ElEFC/PvlFqxH2uV9m/TAQDBWFWWsdqkXXZVFsG2+rmQbDen
	ihp1XmnEtdcO4GBq3wf8CtW0Ks+8HaVVjnDfQpYiIQBFiGqDkMswT3nS8m9nYconiIdz7L8haF8
	vavm6u1KF9u2ArmD9JqJmzsn5iVeW8Ll46ju08LWgyvRVoCIaZOH2ZLnPCDwjEDqhQbNJ7TkirB
	SWhCNl9zyRVUKKeHKBaD31rnIMwbyY5ww3Xb952UUkKR/HFRcf++G+eXkUVWChy35sLxy+wlnlg
	nieJDp3wnPWapUXPVco2QnYh2K+L7ug/umee927s2IWHuFe+3mibLHrkKW/hE1LOafFMpysqoxQ
	6sv28WZAL/0IHIW3/99Df2WFBp+K7o9vke6qRYS+4LTPt08aWcXKt/iU2U+a/j/k9+hj7mjc0R0
	WUC2ueK
X-Received: by 2002:a05:6820:174b:b0:67d:f88f:d83d with SMTP id 006d021491bc7-67df88fef36mr1271317eaf.29.1774353659590;
        Tue, 24 Mar 2026 05:00:59 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85335402sm138526236d6.25.2026.03.24.05.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:00:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w50RN-00000000GV5-3aCE;
	Tue, 24 Mar 2026 09:00:57 -0300
Date: Tue, 24 Mar 2026 09:00:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
	sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH net-next v3 0/2] dma-buf: heaps: system: add an option to
 allocate explicitly decrypted memory
Message-ID: <20260324120057.GC8437@ziepe.ca>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <ablV_f_l7wD2m63E@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ablV_f_l7wD2m63E@google.com>

On Tue, Mar 17, 2026 at 01:24:13PM +0000, Mostafa Saleh wrote:

> On the other hand, for restricted-dma, the memory decryption is deep
> in the DMA direct memory allocation and the DMA API callers (for ex
> virtio drivers) are clueless about it and can’t pass any attrs.
> My proposal was specific to restricted-dma and won’t work for your case.

How is this any different from CC?

If the device cannot dma to "encrypted" memory, whatever that means
for you, then the DMA API:
 - Makes dma alloc coherent return "decrypted" memory, and the built
   in mapping of coherent memory knows about this
 - Makes dma_map_xxx use SWIOTLB to bounce to decrypted memory

There is no need for something like virtio drivers to be aware of
any of this.

On the other hand if the driver deliberately allocates decrypted
memory without using DMA API alloc coherent then it knows it did it
and can pass the flag to map it.

> I am wondering if the kernel should have a more solid, unified method
> for identifying already-decrypted memory instead. Perhaps we need a
> way for the DMA API to natively recognize the encryption state of a
> physical page (working alongside force_dma_unencrypted(dev)), rather
> than relying on caller-provided attributes?

Definately not, we do not want the DMA API inspecting things like
this.

Jason
