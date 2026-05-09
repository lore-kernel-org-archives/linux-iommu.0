Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AC53BBA1D
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346619; cv=none; b=TdREJryRCjG0xHZhPd/Da9u3gFdCZ/iDIvOxdCY/Bq8qoH8YUKTlLLckrKPCakGHxwWd0dnMhNSi8WrLiiP4rY2hDmVNGgllVnEKNbW4es4tZhS3gNuQLumviQxVf8XdcjQ42Mw1sGdXYGO2bwLlbNGiX4S5avTom158tVjlkso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346619; c=relaxed/simple;
	bh=Ib4XRsG2e4tlDimBfCEgugHOngPORoyq0KGAVzHdcZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1BDlVIrdNPJCjhMXSSnaSnDLUcGPUO+cLPJEUgoN96gw62VPCHc9m1i8K5nK5PfZG+CiC6M1Tvf4Ocu8lqDLLJRRfENuZ34X1t+NIoenAEPJ+DYGH3v07BEfME9TgJK49zjECggtdMj8EfbzqNrJamblnYzKsUuF6b8ZgL0DD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oXQ8HdlL; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oXQ8HdlL"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8ef5776530bso286517285a.0
        for <iommu@lists.linux.dev>; Sat, 09 May 2026 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778346617; x=1778951417; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib4XRsG2e4tlDimBfCEgugHOngPORoyq0KGAVzHdcZE=;
        b=oXQ8HdlLN/6cbxsfxQAh9buv0RBTLh1piZ2duVk7M8MNRMLDcHe3bvBjU9h7mhK4hb
         TEYflD26WdSon4kln56fyEnMp9CmPDA7Yvvvi5qKzWTDFWK4rcx9vbYkWVjMugVCBFwk
         oswFlJfd1qT7uiumXonHCT4bIy+aQeX8l5cty6/ytb+/yMDZt7GvidhdrHqvjHfK9Nt0
         kMMRTos76R4RCtEG4ohwgMIbbH4zedxRTXtjwM77yuVhznfyQqCyiBZbVPvgr/iC0tbz
         zh7IAlqE5ODNLyfcC5LTe4gDH9E0BHiTTlQ4dd2F208t5HaT4q9AAMXwsJ+RQi52+nTH
         SHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778346617; x=1778951417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ib4XRsG2e4tlDimBfCEgugHOngPORoyq0KGAVzHdcZE=;
        b=P+THUZ5VOromZq64YWLkCCQ+6lsRg9lQxoeP+t1qZRTUkh3731uKIHtQbxhFCysdsO
         CPJLQYh5P5N34ej9VbkcpIsrl0UXdFlFXGE+BFwpKEwggd2K3dUNNEEZhjOfistLuHLw
         OJHErseqWT8c3KqlT4OA3Qz99Bs7RGeG6+2Mp8ih+YF3EjNjYgvHwecfNKDmMTus4mIx
         pnKhEd9tIFlottu7CbKa7L+v9ZyNDy1dKzXgzJY6oFrI6oZWP8tymv+Xk5czsSUVdKyL
         CNkrWUImUDH4RTh4Kx4OXQRBEcIJMwq8DH/R7qJYKcMlUhY2jYo89j6iXmQbsgiU9hj0
         j26g==
X-Forwarded-Encrypted: i=1; AFNElJ+8GFaSk0Y5Mg41KwoYrbdalA4SA/seupMUW3wPlgkghpZY/BjVl2XoNhH1v3E3/x7Clm/Cug==@lists.linux.dev
X-Gm-Message-State: AOJu0YysTH993yyzmTnZm1VVVZeaRRpx4O/6l3GX6/VnStRm8AA+BqaM
	u+Sl6j4mJ9URscnqNCagnn8SefghmzApKqDoAOASADwIWnglyrZQX/Bi/kMiJHqViBU=
X-Gm-Gg: Acq92OHC84qOO85sHJsMz9XtiIfrTkWbesuF/Pzl4xUTxuPq17U0dWE3efzza7UdCyL
	FwEkGWsYGzaognvv6zEd+xFjhfreHOiWhVzGlClmXg+euv4nMTl+w7pMpC+yySjhFEhCquFJ/SM
	9nbhtrNF+n07HxxIOif74lHW548yeIc3I+PQiyJh8EKRO/2Zx0XJ+zRcPtc/ZfjODFOo0ENnZzS
	+Gl6ZKlztTPSbvskOaZcn5O+PiEIoNNqMm0RLcd1fTCqM8EJXLHqGbgMbsl21qvsOlgbAWPFLyg
	JHs1CdTkMqX7O+66aX0xaIv4iZMfy1ZSOaVA71Q9th9EvzRnbQh+AsfQLneVfTBH6xHVlZhuLib
	rMUqgZCIsJuB3+dPiu13Sga7kypFqgpuLiS0KlPeEtzPWEOYaT5YgHcnzID6Cr3b3N2cwX1kKGB
	V7XIY0pzevCK30aPBJeXkcfN2QDB1WEJYAkIF4iNCl7WmNiQKAIVFYtNCIt6pD+kEirdAfVQ5si
	zUaJA==
X-Received: by 2002:a05:620a:44cf:b0:8ee:cbf0:8311 with SMTP id af79cd13be357-9091072fa59mr433663085a.54.1778346616735;
        Sat, 09 May 2026 10:10:16 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b8d9eed0sm552694685a.19.2026.05.09.10.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 10:10:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wLlBt-00000001qju-3hnc;
	Sat, 09 May 2026 14:10:13 -0300
Date: Sat, 9 May 2026 14:10:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joonwon Kang <joonwonkang@google.com>
Cc: Alexander.Grest@microsoft.com, amhetre@nvidia.com,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev, joro@8bytes.org,
	jpb@kernel.org, kees@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	nicolinc@nvidia.com, praan@google.com, robin.murphy@arm.com,
	smostafa@google.com, will@kernel.org, jacob.jun.pan@linux.intel.com,
	easwar.hariharan@linux.microsoft.com, kevin.tian@intel.com
Subject: Re: [PATCH RFC] iommu: Enable per-device SSID space for SVA
Message-ID: <20260509171013.GF9285@ziepe.ca>
References: <20260424133953.GY3611611@ziepe.ca>
 <20260507095851.3220765-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507095851.3220765-1-joonwonkang@google.com>

On Thu, May 07, 2026 at 09:58:51AM +0000, Joonwon Kang wrote:

> By "similar instruction" on ARM, I guess you mean ST64BV0, which fetches
> the bottom 32 bits data from ACCDATA_EL1. Please let me know if you meant
> others as it will matter. If ST64BV0 is supported on ARM, however, it
> would mean that ST64B and ST64BV are also supported already according to
> the ID_AA64ISAR1_EL1's LS64 field. The latter 2 instructions are just to
> atomically store whatever user wants to a memory location without
> referring to ACCDATA_EL1 and all the 3 instructions can be run at EL0. So,
> the userspace driver would have enough capability to designate arbitrary
> PASID as it wants via the latter 2 instructions when communicating with
> multiple devices.

IDK exactly what ARM did. IIRC on Intel ENQCMD forms a special
non-posted write TLP and the device can tell the TLP came from ENQCMD
and so it trusts the encoded PASID. ARM has to have done the same
thing - allowing anyone to forge the PASID by using a different
instruction misses the point of the Intel design.

Honestly, I'm not sure why they even implemented it. SMMUv3 can't do
the translation scheme required to use ENQCMD from a VM anyhow, so it
is pretty useless.

> We have multiple processes and a single device, those processes want to
> do SVA with the same device, and only one process will do SVA with the
> device at a time. Though, the problem occurs even when irrelevant
> processes allocate the PASIDs from the global PASID space for their own
> irrelevant purposes.

The only way to allocate a PASID from the global PASID space is to
establish another SVA, so you have multiple devices doing SVA?

Jason
