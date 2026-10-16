Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040D91A6822
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109693; cv=none; b=pbNP5oWAT8Rl5hpHHJPmS/PMbqAXQtaRhhgwcNu+S4tli565w0vt8jCrlT2vAqYEbeh+0SQDvMjfvOeeRFkDI7es+3zhmRZU/eyynuucUMIssxvEO8ZmnnZSXrfIEssxhiNUfyIoVzYcxewgvFEXDuP2bJQDDAUcmsFqpzsRB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109693; c=relaxed/simple;
	bh=N3hAyy7nTu0uD6uxxEosrsvSAc05WwQLSTSIID6INNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQL4ihDAGmXWvS783iA18OArqFb6kN/OAbu65qwzlQJiTYgUVpb7l8ls0Il5N197RVMZ7Xuhr2xKyfHqH6bIqwbBfSiQyvNjfGkSVS6A4CcTgBsHE7Pj9YFR+XPoym8V80TD3jOjo6N/9xQ0hrZIBGS8zCpo/fz75ioJjAa/AAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bJzYnRFl; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bJzYnRFl"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5351d76e1baso5830001cf.1
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792109691; x=1792714491; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V2saNd2pf5xXpmgizEGMG+P83blHZRupazL/vtIJhv4=;
        b=bJzYnRFlIDxmVj0hiPhhIk0Tpjyy1Hw8G0mxbVBIu4vU0O9DXvQKwpYj4o6qxs9Y6x
         aymBEGjcgZpuZvh1GqjD9yZSAs6m8g1eyKY0QAxkhvpddBEmzS55ehGLiJQbngJmr088
         1wX9hegbOXjL9KRYIJ+Qi1tp1I6Rx4Cgh1MpUKPOBxM/YEFk3kb+Kj3lNklsjL5Pnjqp
         fniPPEYKSQVn0npdcaBPUlBGwSGR8vBxFdfSb5D/eT0odmQ+wQyerA0UX4aGK4osd2GE
         6rz81qrWRn7VRbc84MOJBMOgulrPRhegfd5NL8i3aClEUpkZ+vivifirQ6iQpmG1vy3s
         yiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792109691; x=1792714491;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2saNd2pf5xXpmgizEGMG+P83blHZRupazL/vtIJhv4=;
        b=WSSsIhdLMLO4AA1+E9FQFzk2IKk5r5XGXBFZ9TgmSuCMGgAeoe7ag3xhOMLph9xi3c
         EtytH9fNVys+/Lag9x4zPio5dI/OymG7G+ocILiRKMoEd/lmJjJkUJK1V1xMUpsL6zip
         m1Ws1sLsmOusZKYCTzYFeSMYJKWQxAEMDAaGJOWZrPzo7oHQ7i0i/QYHFN/q7NfO3vem
         /a5H7IYj+b3QhFMWqExe2t0cMFSAw+94JAlLvkN65ucuMr0PZVguxA2y96z4vRD9Qi+w
         53XrhTfdJs/3FC0s4nD45xl5IiK7x9yycs+5pD3CglLHUIL/EI7eoGo+nctIYt0w08eY
         ETkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBiVI7rp2Ka/l1nsDTgkYwWSdFKJLaHUbOhJAvlqXBcFBZA+2YS3T0v9sHHRtBddJ8s8CMvA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKQY0zyoOTrU799eqbEtGedPIiBHFBJwFhkZREVigh4B6s1/tAo
	io6RDk9LhIur98pRHKEXcg9/AcW7D4fCn/fFiOgPoKWQfe9hfWgdDCKjAlTCmK8e1ZE=
X-Gm-Gg: AYBFou3wdMP1vcyHH+O1RzFqnggX+jJMPzzUIc9lHCZVGKc0SKpMC26yoewZaMwGpV/
	JGFrAKnUp09bQnz4KGRWm87RmdFZsRNnnz9Af9osPeSFxuUmaGIyrf20QYk+Kdmc23BQuRoEsxi
	l8Ya7YfrXpq4GM7VEK6c/egBb9wqGA6owGFs3Km6PGOI6vbCgmoAPnn1FSy0v94uyaVrXAMuhjc
	FcXYr4+Os52yS0T06pLAOGErjx3Ie8UGm2nMsrTELL+tyTnSnWv8L9/99NYIXakEgN0EQCa00B4
	UXZFq51UCji6dm3a7/R2OcGfL2fU+3TYJZYjDartNFVK2uf70Nc54MQERrQhxtKhJLPsZ3JImYd
	Q9WyvsPS/3Mrx/UvGTDjCdBVnz2d8/XlT2ut4Fc9W80o+kstpf4VvBXZtXcJJJcuf8lfBePqloe
	fz4frOo06xbYtKpHcEDOUpjIHM5LiY0deJ3/326tx1AGFCHk56ehx76kEgKXdehhjF8GpRrJBkG
	ZQwU4Zx/nmSRE7yWvLTbLbPkxRscWb8Vw1cSDL4hzKeL2GxriysjRhB
X-Received: by 2002:a05:622a:990:b0:535:ba01:d95 with SMTP id d75a77b69052e-536272c2d55mr30900421cf.19.1792109690637;
        Thu, 15 Oct 2026 17:14:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa57106sm7257071cf.28.2026.10.15.17.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 17:14:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHVay-00000000IxD-2c33;
	Thu, 15 Oct 2026 21:14:48 -0300
Date: Thu, 15 Oct 2026 21:14:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Fred Griffoul <griffoul@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 07/11] iommufd: Use large IOMMU pages for provider
 mappings
Message-ID: <20261016001448.GC14213@ziepe.ca>
References: <20261014093733.90312-1-griffoul@gmail.com>
 <20261014093733.90312-8-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014093733.90312-8-griffoul@gmail.com>

On Wed, Oct 14, 2026 at 09:37:29AM +0000, Fred Griffoul wrote:
> From: Fred Griffoul <fgriffo@amazon.co.uk>
> 
> Provider pages are mapped with one PAGE_SIZE entry each. A device that
> uses a large provider block then misses in the IOTLB on every page, and
> the IOMMU needs more page table memory than the block requires. A
> revoke also flushes the IOTLB once per run of pages it unmaps.
> 
> Map each block that the provider reports with large IOMMU pages where
> the IOVA and the frames are aligned alike, and with smaller ones where
> they are not. Only the pages of the block are mapped, as before.
> 
> A large IOMMU page can only be unmapped whole, so a revoke that cuts
> one widens its range to the whole page. It maps back what the provider
> backs now, and a device may also fault on the rest of that page while
> it is remapped. The widening finds the page with iova_to_phys():
> pages that only look like one large page make the revoke remap more
> than it must, which is harmless.

You are going to need to go into generic_pt and implement cut and a
more suitable unmap to make this stuff work properly. We can't over
unmap on conversions.

> iommu_unmap() may not split the range of one map call either, and
> virtio-iommu refuses to. Map each IOMMU page with its own call: the
> widened range ends on IOMMU page boundaries, so it also ends on map
> call boundaries.

Also please don't write commit messages with AI. WTF is this even
trying to say? The subject is "use large pages" and this text says
"map each page with its own call"

Jason
