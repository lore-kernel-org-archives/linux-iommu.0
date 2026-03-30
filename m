Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6613E322B87
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884436; cv=none; b=uRpQE7dYExY4jDEIBhsZdf206bGmQMNxMBvzEXd7Fy8vmglnilWIdBdKaaQAqRMJL2Nh4pss58RJ3zk49sMIs5kTu6wCAUTrYhB5XcvmCPj2yGUHZpR3K30G5cdEVIzIkGV61jAUByfHkeaEj+gCCdyaZtqE36HJ5Vx+Iayvbo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884436; c=relaxed/simple;
	bh=oIYwPCUTeaq503GoqCcrgdU/d71ypzxo9n4oPWrPllU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oANbtM7E+tR+1EhrcowxncPKTXmxcatX5Nvb+WN7GdMuXJ/+AEFFqgOob/oBFnZswwrMLGKQQTVsj+L/G1+MtPNuUjrggmuJO1HBb1snQpMT6YfJ68G9/0PIgsnrgP6mWMtY4P8aj9Qnuq9lOz2ZxcKtoFE8WfB7XXfVLWexfqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jyXcamMj; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jyXcamMj"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb3bae8d3eso477609585a.1
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774884434; x=1775489234; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v9C6Jq63vgWqSjlbaCEq8eF8GLl626VKV7hFMNLufRI=;
        b=jyXcamMjMiA2gHBRjhsdxj0wJlx+wiNFzfp/DAugJZImlY3t/nHngEXBW5O0sxlsnX
         sdeE02B78aGUiLbk0HZ3ub1K8t4yKcnPctwHzWdX0vICtR3xTEjQViiIM/hBPnNid1aK
         nUDbwc9QJNpdMiRq1qiXem1OarA3PDw9g++AiXq4fG8HmSVFl1hSjkcF6HUfLJh+ds/9
         cnIAz4WNkAks3OSWCsvPMTxQpsMrWkmS1vuCIsBHDzIkZ9VQy1+fT5dyV+fPRL/dwFob
         5PtPETaCtQt85/prch0bgWlOWE3SokYfhN8df2HOlYgxOHE0D7GgylLApj5CwY1qFc6n
         AB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774884434; x=1775489234;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v9C6Jq63vgWqSjlbaCEq8eF8GLl626VKV7hFMNLufRI=;
        b=NtUuSbGXuPEGmJ3CSb1bZmBLlHuBInYmh9f1XzhrsGpoDtxPO+tiier+EDggOq8bue
         bV0Iq+sQ81e7UXn5rCFZhQ692PAnTupvCO40/+5zryJ2L7BKgpgrgUKyeNo86AOsPHvG
         XdVkj7FvbVy+RSOyfEp5BiQTvo82qomJaURf6N/rtzyDDhn2Ii2TTFyjVofQV3y71c8H
         RKTLe+37UIihxkvWyyufPc3bCscu5u6D9sOXhXDQgwzmytdQLMvo8Jf5uuhg0c+L2ESp
         BSPZablWeS6htEeh3vpSFzFvTCqlzAV3QPfw4KRTStj9VFhxkNwQUqDvNUxo2zKbj0nZ
         5aFQ==
X-Gm-Message-State: AOJu0Yy4X3tvV6TBBbi1v0RBCjvNByyBnw5jj6T6CEPWVk9BFrLQsJNo
	LvNAksaeEMP+KBtWlZPncHzRVQE069dkl9dSJm1xrZUuA6gxIiQ8O5xxXqFZlssEMjw=
X-Gm-Gg: ATEYQzz/jN4Df/9BfNTMvQ3CK1lkO5N375UiOCIQrWgwdA6AgUtwwWDT56s2dvBY/MQ
	rIVFl2oXuMKoKWc+xFWnRiEnHTymigw2egzg7HANyOvFZDRJ/8TRIrI7s+6q8t/kjWpoN/0WhMS
	Tza3gCiHOiS9RjGytRcyvARiXYfoLjqKg/EtnjJRpDPM8IrL15JLm/MKTDeODFkKgZMLfQNz9GU
	JxubDLb+HVM7AxOP2EaaOs423Hnxh/nl5WTwLN48qC5T+LN/IaaLm3lYZtkEAJLiZj4NHBybAou
	vQvni7zrY8iBz1/cmXL2c0WDhyN/Fo9q0a9S+FCoX37LyUKVtD97L88no/c/WP0EkLxnhbM3EmQ
	Qhqv98Z2hoRT+keTdZgKENfrDVt4A5kCHq+l7uQlFvhGGZ6vUVE1Vvz8n/+nWUIefRy7S/N7N9Q
	exnsH4E+WBeAXCDlFshlRkjQjvGCTedjT767HFSICthnZNdepuCDISd32RiN+mhcbGNXuo9g==
X-Received: by 2002:a05:6214:528e:b0:89c:5e33:2cc5 with SMTP id 6a1803df08f44-89ce8d93406mr169503266d6.20.1774884434097;
        Mon, 30 Mar 2026 08:27:14 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecb5cba4dsm64471366d6.9.2026.03.30.08.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 08:27:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w7EWG-00000003UmP-39ia;
	Mon, 30 Mar 2026 12:27:12 -0300
Date: Mon, 30 Mar 2026 12:27:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v2 4/5] dma-mapping: Refactor memory encryption usage
Message-ID: <20260330152712.GD809900@ziepe.ca>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-5-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330145043.1586623-5-smostafa@google.com>

On Mon, Mar 30, 2026 at 02:50:42PM +0000, Mostafa Saleh wrote:
> At the moment dma-direct deals with memory encryption in 2 cases
> - Pre-decrypted restricted dma-pools
> - Arch code through force_dma_unencrypted()
> 
> In the first case, the memory is owned by the pool and the decryption
> is not managed by the dma-direct.
> 
> However, it should be aware of it to use the appropriate phys_to_dma*
> and page table prot.
> 
> For the second case, it’s the job of the dma-direct to manage the
> decryption of the allocated memory.
> 
> As there have been bugs in this code due to wrong or missing
> checks and there are more use cases coming for memory decryption,
> we need more robust checks in the code to abstract the core logic,
> so introduce some local helpers:
> - dma_external_decryption(): For pages decrypted but managed externally
> - dma_owns_decryption(): For pages need to be decrypted and managed
>   by dma-direct
> - is_dma_decrypted(): To check if memory is decrypted

I can't even make sense of what this is trying to explain, talking
about page management along with 'dev' is nonsense. The management of
pages is intrinsic to the API, it doesn't change.

I think start with adding a direct flags annotation and then come back
to figure out if we need some kind of helpers.

I would expect any helper taking in dev to only be answering two dev 
questions:

  'dev can dma from encrypted(dev)'
  'dev can dma from unencrytped(dev)'

At each of the points in the API flow the phys under consideration is
known to be encrypted or decrypted, and those two helpers tell
everything needed.

So I'd expect the restricted flow to look more like

- phys comes in to be dma mapped, it is encrypted
- 'dev can dma from encrypted(dev)' fails so we go to swiotlb
- swiotlb allocates from a restricted pool, and learns through flags
  that the new phys is decrypted
- decrypted phys flows through the rest of the machinery.

We never check 'dev can dma from encrypted(dev)' a second time.

Jason
