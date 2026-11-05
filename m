Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903545;
	b=f4QdR3NlwZwvhoSYPmO0zS8FGAazmChufOkUJA0GY2ZdMW1bDovl7JWuoVEiW7haDa2Q
	 2nO5pnYS4F3nlzZavM3gwRUu8mgbqPnw+31QnODWAgDMuJgiJb5XwwpR8Tu60uObVlhNg
	 +ryIrISXjYgTAwQhW/k9v3jiNrTtdPJNYye2DJBPgxmwD9X9vPVZgSMqltJWzf7cjQWth
	 Ph5JZKG7bOTrPcmvbs/G2k/PoA4nW4ErXwwOZpevWLV0j0vdJXCleZEWmFSgNlSs7J5db
	 vovr7Xf3VYphDH3v4Dkxae0Fj0lAtQPRVABLM9qB0/v0SqL2BnySU18cbE4nMCOmxMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZFFGdirTAMGtbCDF7cv9kKouCz6oxttoVV1PmG5xK7s=;
	b=CFIRRyKBQ3Fep0WTCTTgVp4iSbKu5ycSxinXouutIBPXwx5EgdlxYSyR/Bjocpbbf3OH
	 6maiPLsaCHSjsr7HJ+cGE4uxgKH1J/c6zPzAO0PLCrKHOJOkOf0IIIlAA7ruNKTY/dElW
	 274o+ozMuXGFUNu4u0YhyZRL+5/E89CneIn0rTKinuXYfnUGMAotN9jAyiNNmzPAQUBJX
	 o7aq3WNPv/zZCzKteTGVEEegeXwrI3sotQjZAYLywTN/D6Bgc0MsXs+ed08g9iYwtc4B/
	 DWaV1247xP9HRTU2/VJSgQN4TZsgpaUT7WcKLa5Ug/HxV1DWp+qFLzEXI16/RD7YXnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ifqinOpo;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E93606A329
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 18:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8E93606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ifqinOpo
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eae1276409so744561e0c.3
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 10:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793903544; x=1794508344; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZFFGdirTAMGtbCDF7cv9kKouCz6oxttoVV1PmG5xK7s=;
        b=ifqinOpowIhfOFIDY6ZZoETKrPQWB+O4UvMe9ogClfxO+0jFWExSRUgnMX1/gj3yRK
         ZF2MGAZDMh9M6pEMxrLKi0wf5sYeDKqdZ/6XL6ZhDUoKWfWi8NuwnEreY6jRD+Fwg9c0
         10tfCt7KlXkYW6oVC4xhgsirqsmch9lB60MpRK2ojdMSWogQKO5HW7xsYBNODbef8pu2
         X5wxKBYMyxoFlrjv4pvP3FULcaSmC5mNTmBPnxMRxkbjcm3+LMDF8DTroZ6jZvFzDAfo
         G/3duea0WhkjpKRoyZ+LXOKQkVc7yTDcWMObp7aJQr6KgFXb+KZ4C84IbVi2RWNx7wCa
         Hclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793903544; x=1794508344;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFFGdirTAMGtbCDF7cv9kKouCz6oxttoVV1PmG5xK7s=;
        b=RojnWEnPu+8vgASN27jM5oSNwjcUXQgs1stdRRghED6G5cE6EId66gfEHLT4jgSq35
         iRwfqJ+Gaydxn21WpV9O7PEKWjyqEtBjG29ZeN7rvsJTO8ZN0e3EHsl7EIIlwY+76Vsn
         Qo5I09xSzgbg4g1WV8NB+xpD1D/vWVVWbt38hZGarJRh5gVnmc68XA6viIzEkiaXNoqE
         m/qeyqMgrG9XjKPStwfgYafU9QuggiHC11HpO2vPqbNQPUQ+f+i9oS0Z6vSqfRkBu2bc
         HKPv9K1jt9Gd285zBEM8nm04dqOP3mgZsIwPOoVk7aRYqrHkXgSSEGwfFkGS4pVuM93+
         3zpg==
X-Forwarded-Encrypted: i=1; AKwUvByNMnOymaIowqOHsoy4aWLwM8eXCfJbyYtwRW/noZ8A6JveSg2a+E/FUb6ayOjWltLwcEP9Kw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+WN8JAFTLleCSLlPInnTUOoEoPjLPPlyl11IMoM3Qrg34+ynCe
	uIxJ5gPGdIReMM4ntmknBSfZ8L2j+3pQlDrywYBEnEBLqSteXxH7s4rhxVm11HUYeEI=
X-Gm-Gg: AYBFou0quYcRgI6gzfJDd6EZ2jz9HjHIH+SCsofbERtFqBmSiGKLNqJKzEM7EhdtyZt
	Cv8D8AeLJIZvkdoCTaTjCvznAaQiN3xshYScMVTj8YtQuYUGbmqzlTVzQdFU9/kFlq4YmFqGsZq
	N3ZtBwAmoq/mql2k4r53aJQuTOEPoK16czjRXKqOHtCPm5tykizxRFqe4X1Tmvb4PZq259Dg733
	ZtlGtBtNxNkyYAzRueDKWg9Rlh32dK9rpXDlPE/9PjmXEab086jM65LK+L4eHxqfhF/qWQ12dRT
	Tab1W05yAXojHNxWLkwIIUz7ML+9+OQK8l3rMgHUXIjbAJA7mnig6r4SitNuHXc8GnkE7bQMtJy
	Aa8SIKbbSBHXg3diW2llxf62iLpf+pC1LC/mxbw9sBlQVbr1BAAo/R4Csq4UM5W9ITUemJE5dDv
	FKMs94XBdFcTEGq4HP+/kZ1byqrMB65Ib0qnqeV6fEhwJJ2/Atj+A3I4HoNyAlwrp5WGeCWF3rS
	bdPoBW9KpoZK+mpWSoiEf5o0ONfhtKRN0rCU8D5/VNXPxlViLS983MIuLHNs2L0WDIyIkR01VeS
	ijhV+Qk8sd3CRaTLIirWt/uSP+DBzerJmUAZBLOI73D+tEwlVTwHukACWjDgqNJyehH/YZE+ltn
	kopsoITi1zQ==
X-Received: by 2002:a05:6122:1782:b0:5ea:e1cd:6e4a with SMTP id 71dfb90a1353d-5ecc446d6b1mr99753e0c.23.1793903543539;
        Thu, 05 Nov 2026 10:32:23 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d77c6esm5043981e0c.6.2026.11.05.10.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:32:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP2G6-00000003Ng9-0h1l;
	Thu, 05 Nov 2026 14:32:22 -0400
Date: Thu, 5 Nov 2026 14:32:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tan Chi <tanchi25@mails.ucas.ac.cn>
Cc: gong.shuai@sanechips.com.cn, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	anup@brainfault.org, atish.patra@linux.dev, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pbonzini@redhat.com, seanjc@google.com,
	kevin.tian@intel.com, andrew.jones@oss.qualcomm.com,
	fangyu.yu@linux.alibaba.com, wu.fei9@sanechips.com.cn,
	zhao.qingye@sanechips.com.cn, gsh517025@gmail.com
Subject: Re: [RFC PATCH v2 9/9] iommu/riscv: Add riscv_iommu_attach_dev_nested
Message-ID: <20261105183222.GE663069@ziepe.ca>
References: <20261029061131.584453-10-gong.shuai@sanechips.com.cn>
 <20261105144944.10193-1-tanchi25@mails.ucas.ac.cn>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105144944.10193-1-tanchi25@mails.ucas.ac.cn>

On Thu, Nov 05, 2026 at 10:49:44PM +0800, Tan Chi wrote:
> Hi Shuai and Fei,
> 
> I noticed a potential issue with fixing the physical DC's PSCID to 0.
> 
> In QEMU, different VFIO devices can have separate stage-1 HWPTs while
> sharing the same vIOMMU and stage-2 parent. This means two devices may
> have different first-stage page table roots but the same host GSCID
> and PSCID=0.
> 
> According to the RISC-V IOMMU specification, DC.ta.PSCID identifies
> the first-stage address space when PDTV=0 and the first stage is not
> Bare. Could this cause the physical IOMMU to reuse cached translations
> across different stage-1 address spaces? Even broader invalidations
> would not prevent such cache aliasing.
> 
> There also seems to be a related issue in patch 6.
> riscv_viommu_cache_invalidate() unconditionally forces PSCV=1 and
> PSCID=0. However, an IOTINVAL.VMA with PSCV=0 also invalidates global
> mappings, while PSCV=1 excludes them. This appears to narrow the
> guest's requested invalidation scope and could leave stale global
> translations cached.
> 
> One possible approach might be to use the PSCID from the guest-provided
> DC.ta when allocating the nested domain, and preserve the guest's PSCID
> and PSCV settings during invalidation while substituting the host GSCID.
> I'm not sure whether additional considerations are needed for PSCID
> reuse or domain lifetime, though.

If the guest is issuing invalidations you must always preserve the
guests "ASID" or whatever your HW calls it. It can be virtualized and
mapped from a guest view to physical, but it must be preserved and
physical must be 1:1 with virtual.

Jason
