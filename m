Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8071F4285
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737492483; cv=none; b=cg8WRR12MLIdMFdecxtcOhG8KuMk6emjdOQUF9qT1+732sDPlqdT3FW4vs+5U78w+4HVrd5Z1RV28YafmjLwJzFmgv3YHflgpXCiV6szPDJyZYn/ZLBEqfMSL5L4RSfZjUrZGRhOppAiaOo3jig+WYT9/CJzM8pYR4HeJI7dUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737492483; c=relaxed/simple;
	bh=g6gsRKJh7V7n8xwdh+JPKCk0Lq/C+rb/lPQNDYRoAx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmEcN7DZKLOdn9U/TKauhLBzlbAsCbdHuzYajb/wZY/c8A9VFfvAV/uVW2LCZCKsX7D2c+g3aHKxlP+vwpMEETqp0gVUeTIw/3cT9AgLAZM1D5Z+R7bDE0ewh8h/RPzWoBzuq3fXBY8RYBXfW9vuMjbiwdO9ef2bufeYH/5RVR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JEhWvKTA; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JEhWvKTA"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso91232536d6.2
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 12:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737492480; x=1738097280; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ow8OnSOBUAvF1sR6NsRcQ1mD4Budky7KnwU2LvfpPWA=;
        b=JEhWvKTA2RtqImJBth342XGO8Yipu0nNyEwWLFocuhNBIkT26CXV7dXGHJacYBi3XF
         uRg1EfkeQv8Z4GZYbWjlvCj3mMdKIPhcb0bzrF68PwyAoP+yIt1Cilr7pz1hROEj68OF
         iLz8vqrn5KjxgfFVyC1dxUeG9sGjCoCmojsouBCbCWTiApdXvZ20amU12qsSouGq4ABs
         K8o2NJD42cuvxUjhnzS70ya/ebWY4s2BXgJczUqwpp/URtijyRZVWw63FAONB7W2xTNy
         lQO1aChwhcBz84zTVGxk3fLxiF2pphVHIiuhhH3VKnR22LD3+o39+qC8obt1kfQt1Jbn
         VwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737492480; x=1738097280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow8OnSOBUAvF1sR6NsRcQ1mD4Budky7KnwU2LvfpPWA=;
        b=GKVhr6lhsFW2+I4EE5LEZu6MUP6kcHbwfNVzAHjYEdnefalY/zc9+8i2wXfALEZaTY
         ZLiLlg+PWIog3kafBzz8VW1jOge7prDUyMaFJ5xvjAiO0BCD33ePb8GqlmOGKkXf++xT
         M20JP9Yv2g6caoIECSPLmR7VR92QYNHXa5K7LXNlZFv//+4Dxporeq+ZR25W8f0H+9x5
         0PqO7PcHFLohUjR3zf5C3NADmxjAoRuAXo07uuAPOb4GGwJpLN4Q2ktm4n+6wOjOxXpW
         UI7sgS9wKJ3XGfQ/lpCGx+uLYkt53WdeawiegNRvHjSDsyCVxHmIlwBlusITDJwOfLvE
         DK+w==
X-Forwarded-Encrypted: i=1; AJvYcCX4kz5bXvheV7C708paU3jsG8j7zSkG2AXj6/3ySK1SpRsegisYaF02qICGfqibEYsHFhFSVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzBJL5z5Oq5FDT89Ww47Vn8xlVlk7vZPM0QC1l4KYW+Kb4qVuG
	CFAAzzd+7hO1JJmzFSHufYd0LoV4bXKPT3tu31U7uaZRvSVrmwgUopos45zfc6E=
X-Gm-Gg: ASbGncuwumIVysEGq50nExWRGzNWW2gsnx/va78ORIP6AFB31fNemZR+tFuUTFN/4XY
	yXYSeEU1r2Go+PrF6vd7Tyj0bNlCDcU4m+AT3Yi9skLyCZjkNtuztJRq9x6SLB5rjooCIwrC802
	VZZB9Ajuc24qJXUQGqsjH6NCOfK7nJKH9F0jL00WvLmxw3gSle+wiB70ulU6+q/Z3ivycurGgwk
	Jul3VbtTZz1um+OTaF3uKOEOIkdwjeTWkd2O5sNX3bM
X-Google-Smtp-Source: AGHT+IGpzHbNEy913KwGqLDga7j8XCPTIu+0UlJOC0stjfVReFdRGhjNtDFMtiwPVLFCCekg9fkq/A==
X-Received: by 2002:a05:6214:1cc7:b0:6e1:697c:d9b8 with SMTP id 6a1803df08f44-6e1b216efb9mr307486706d6.9.1737492480304;
        Tue, 21 Jan 2025 12:48:00 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afcd388asm54445966d6.92.2025.01.21.12.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 12:47:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1taLAE-00000003k34-2XRy;
	Tue, 21 Jan 2025 16:47:58 -0400
Date: Tue, 21 Jan 2025 16:47:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Wencheng Yang <east.moutain.yang@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2] drviers/iommu/amd: support P2P access through IOMMU
 when SME is enabled
Message-ID: <20250121204758.GR674319@ziepe.ca>
References: <20250117071423.469880-1-east.moutain.yang@gmail.com>
 <20250117084449.6cfd68b3.alex.williamson@redhat.com>
 <CALrP2iW11zHNVWCz3JXjPHxyJ=j3FsVdTGetMoxQvmNZo2X_yQ@mail.gmail.com>
 <20250121083443.3984579a.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121083443.3984579a.alex.williamson@redhat.com>

On Tue, Jan 21, 2025 at 08:34:43AM -0700, Alex Williamson wrote:

> This description is unclear to me.  As others have noted, we probably
> need to look at whether the flag should be automatically applied by the
> kernel.  We certainly know in the vfio IOMMU layer whether we're
> mapping a page or a pfnmap.  

It is not page or pfnmap.. When vfio is using follow_pte() it should
extract information from the PTE and then relay it to the IOMMU. The
iommu page table and the CPU page table should have the same PTE
flags.

So, a pte that is pgprot_cached() should be IOMMU_CACHE, otherwise
IOMMU_MMIO.

The encrypted bit in the PTE should be mapped to some new
IOMMU_ENCRYPTED.

I suspect AMD has created a troublesome issue that IOMMU_CACHE
conditionally implies encrypted depending on their platform features
(meaning cachable decrypted is impossible). Arguably a higher level
should be deciding this and the iommu page table code should simply
follow IOMMU_ENCRYPTED always.

That might be something for later, but I would note it :\

> In any case, we're in the process of phasing out the vfio type1
> IOMMU backend for iommufd, so whatever the implementation, and
> especially if there's a uapi component, it needs to be implemented
> in iommufd first. 

Since iommufd won't be using follow_pte() it will have to get this
meta information from the FD, eg through DMABUf, and there is a huge
thread on how to go about doing that..

There should be no uapi component.

Jason
