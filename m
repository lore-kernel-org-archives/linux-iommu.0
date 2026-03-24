Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE673EE1C8
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355060; cv=none; b=GVMxsXvwCon+Tcg54AJ55Djh4vy7nvKq3Xb8rvQYY55lSfV/VevI+GGn+eJ3JHP9i75y/mMHocJ85FNMMenfswtYqIDHNqbV8HV0Xk+IpjuUNV65Xk66eDiXktd1qk6VhBUw8jkbfCGt7SKcx37VvrCeLa9vu0XWMOInBN4kQW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355060; c=relaxed/simple;
	bh=+rZzDMkMN8DzPS73xj43TJpHO/+m0D8wC2cm/TT1448=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6E2Blc1aR0UpP3LxPixArkDdZEUYtCnPY5ujK/QIzHjATDTf98cE55bPVFg/ZdP9nThE+09fJGtL5ZZnkGkmBN9n3wsRi8iNeAZIFElpksn1OHlFtWrLA1w8VwVvZ30aWkurwu4WtVoypBIi13efOwvJgHbKjYefwLIBXb/rn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K2k5W+W9; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K2k5W+W9"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-89c4468686dso54418686d6.3
        for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 05:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774355058; x=1774959858; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MbJdAPBjjvkAIehxkYzkMUXQO8EVBsVDqYb4hAUTKqI=;
        b=K2k5W+W9UXyiN6+fzim0wbANSnnCT64pj/tDMbJRfmvEVCWOP9FUs39GnwZRYmenc8
         ZKoaMBQCEP05h68eHDHTafQsmMRbfHxeaI5QcuEMnSyLppRpfPqgCao3ibSqWsY4POj0
         2QZrQtqHkBcpamyHtbJdxH8GSzyLHrNJHO0zSy4iqjnz5uR0R9u/QAtavbkQfrbMKBGe
         neGpiiZ27xH1vgO8He9jhanTPCLSO9gjro0XGuoNReURcbV9gZKRw+LWVkw+wWpyNcFa
         qyqSO1cBTm4/7FV9Cw5sl1sm8kpwvv1d4ELLKI8UnxF17e2XzO5Q99DeB5vro0YWcEJq
         G4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355058; x=1774959858;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbJdAPBjjvkAIehxkYzkMUXQO8EVBsVDqYb4hAUTKqI=;
        b=fpbWeDk0zpBVygkjYuX0xaNnCXI/+BgGa3qTAawwqTt7nmtDh5zIvuW1BbpVyS6f/q
         zAEbsSykMZeP2Qccirgo5Is+tQfiRboHOAW9kdAqGVw9HeV3QSyNILF7DaxnHZ9pUiYV
         UiWNJ9wIKJCZhUuhkRzTjpHQQTwGtJwWoz2MEru1oTQOa3ePHR8+SBirHETC6DrqW6Y+
         P0GVPKLrW+ZbJbtJwHSABZ05VU3uO2IyLIYT5g7qXFuccuCU3g7YmP+fX04O49USVZau
         XKjqnp1Y4W7ucURtUb23Tv5wDeEBnKftTb4mQi27YUUBTVDrUdbdUBjf3K8WdEvuxgjs
         oQiw==
X-Forwarded-Encrypted: i=1; AJvYcCW0WTd+GlRCSG2DGoZ43mkuVP3qUtqvMGhGMY50zYRC32IffGzvKAEyORRtvBPXqH+tVS7MfA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/ROcv0Avxqy1AzrGe2JPEG0ilSsf/bs+vzegHypk6frRzbHY/
	bp5TSsZ57/yfDtOf4uuxD/5HaESgBkNc/Ci5n7HyYEAi0lCy4oLglOGYcegtCApmIbY=
X-Gm-Gg: ATEYQzxBfOss/nF0R/BPuBxmnP20hVb2JQksmG/50Sx5JES2YWmw92xrW6VkwNy62Aj
	q26Yr/d7VcCAI1ATdpMUgrim79lV+cMDt/4X9vfKijWikXPEEq+7dqBUJ81EgBZRWfik2VaDlFH
	2PbrkNDHJ49rjw3g4qEM0HMA8tEdwJeedWevYorPJIkB7wP3hN9SQCxugcweugzEdNpDvEymnW9
	dMa/H44Qa5ZjAjl23vXWfR4Eq8iFTIyUa3hjYrV2WOhj8VKcAIFZNWzysZx+W8jSoeEkwACHIuF
	0SzI5Xg5sZWf6mF6W7/fWd523EB0aN8kkpu35HQMv0LCdagsX0L6o5nqaPRe+/1/Xq5Qtd0e4zC
	7dtohV9s+TEuEnXpcBH+8tDvTSxC0+JgIGiv0FRTkqxRN6DalG9XoTlf/3ni9bugwSGnnviMdGC
	Z22gLq3h31RgotCGMG7uJL7mfMWWzO58pkINrv/IsBB5YWzCxSixJUfVB9ElYQk8Jp/EF1Zg==
X-Received: by 2002:a05:6214:27c5:b0:899:fd64:1b72 with SMTP id 6a1803df08f44-89c85a5bebbmr256219296d6.41.1774355057813;
        Tue, 24 Mar 2026 05:24:17 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c8536afb4sm134637326d6.42.2026.03.24.05.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:24:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w50nw-00000000Gf5-2Wfl;
	Tue, 24 Mar 2026 09:24:16 -0300
Date: Tue, 24 Mar 2026 09:24:16 -0300
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
Message-ID: <20260324122416.GD8437@ziepe.ca>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <ablV_f_l7wD2m63E@google.com>
 <20260324120057.GC8437@ziepe.ca>
 <CAFgf54qoFhvVR2yfROGaTJmLcjuLACswVFv=trqgJwGb_DB3zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFgf54qoFhvVR2yfROGaTJmLcjuLACswVFv=trqgJwGb_DB3zA@mail.gmail.com>

On Tue, Mar 24, 2026 at 12:14:36PM +0000, Mostafa Saleh wrote:
> On Tue, Mar 24, 2026 at 12:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Mar 17, 2026 at 01:24:13PM +0000, Mostafa Saleh wrote:
> >
> > > On the other hand, for restricted-dma, the memory decryption is deep
> > > in the DMA direct memory allocation and the DMA API callers (for ex
> > > virtio drivers) are clueless about it and can’t pass any attrs.
> > > My proposal was specific to restricted-dma and won’t work for your case.
> >
> > How is this any different from CC?
> >
> > If the device cannot dma to "encrypted" memory, whatever that means
> > for you, then the DMA API:
> >  - Makes dma alloc coherent return "decrypted" memory, and the built
> >    in mapping of coherent memory knows about this
> >  - Makes dma_map_xxx use SWIOTLB to bounce to decrypted memory
> >
> > There is no need for something like virtio drivers to be aware of
> > any of this.
> >
> > On the other hand if the driver deliberately allocates decrypted
> > memory without using DMA API alloc coherent then it knows it did it
> > and can pass the flag to map it.
> >
> 
> The problem is that the DMA API currently gets confused by this; it
> can end up double decrypting the memory or using the wrong functions
> as mentioned in [1]

I fully belive there are bugs, but the API design is sound. If you use
the coherent allocations from the DMA API then it knows decryption has
happened when it generates a dma_addr_t and there should be no issue.

Now, if drivers are using the DMA API wrong, like trying to double map
coherent allocations then they are broken. I also would not be
surprised to find cases like this.

Jason
