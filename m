Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214D1423170
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911128; cv=none; b=DCv9a3+RMD71FH60z01hRFouoG1APJpcO3tEFEI2LqQR7d5Tfx1JGtvfAEXJlKABWmizKUlrzfxdAU7aVo0lcKaZyZquxzBslt2Bo+q2GB/V0t+2BckoZ1rA5FmZVSFbxn1XzTewnyiL6vBoQ0dtfWGHbIRMVeiQgE9+7TroSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911128; c=relaxed/simple;
	bh=fEP9ef/N1AWvi9/oINhLx5eWsJ1F7KP+teA8vEFxCQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/LwkVAem8q2l9TyRxfMiDga+przLHE1G9gn6dIg1GEqErzsE839RIAR8iuimMPQpnKGwTTJp5oUP0bW2DlcUANh/2+D7PQtmUujIO2PrG9ZtJOsbTFh4H2MMjkEmusB3Y90evOyM4xp0ymejMSiSzuKe1ueisJ1r8vllv07mLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SL1MIuHw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SL1MIuHw"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b8d99342so41835e9.1
        for <iommu@lists.linux.dev>; Wed, 01 Jul 2026 06:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782911125; x=1783515925; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gu+E2JdVa1JRknmwyrW0o138XPVwsj6HNCm/db6x0Ac=;
        b=SL1MIuHw85SJRGJ/zRtCqzqEuJ1K8Qv/0pYT6Vy2wE2a6ValDp67oZCnP4KAt4aXy8
         HLUXxkBAylrv/OdgYnY6rLS8zI22xqQeRQzCJk1V+zs/w99y1tWYYD3oQffUQZf8bLX0
         R/qcwtu7u2sZ40jYLfMYpq6cAgca50qXXFEUXfpjqswnZk0fYL7JH08XrRFufgk96Ixb
         xctwA9vJlT1nL//xyUMHJi+cWQMu/td6GfU6NeZ0vWue1gZXrsBg18lxAtRqoEnWol5u
         hFXotH2OaDLFnEsbgkZRPJQL5g0EEwoW5RxZkt00QRdnGTTtAGxnqueUb76CO1G/3i+2
         RZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782911125; x=1783515925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gu+E2JdVa1JRknmwyrW0o138XPVwsj6HNCm/db6x0Ac=;
        b=a6tWSqHt0t5kH4llz3tTF6z3z+W5Qqf/hW39uP9G7BUZXHJP12Q7XCahtes3D6MmL2
         HQ8BvAEPZuv/IT/Ss4MJYnEfa/Coyxdd4r2zhC/oGLsghznAT8G8ZUlCa7MYfrjGScyM
         Ph0AFT9ouvzUeCPDdohIk3gWaZxES2qdf2q+TfSjiZCRlhpxpMc17gymU3OHo4y8KIqW
         6V1f7rPMlUZ+DrJnRPz+uBvzazi22VwXWn4xJCJF6888uSJ7NKZ68n6PHyHOhpuQS4PN
         vK0wKTfaQtHFDaQScq0tqqtNGSQJTnx0TR4AkoQAnjSxjm72v+6HASCb37JW1UnQH098
         zPlQ==
X-Forwarded-Encrypted: i=1; AFNElJ9n3n/IYBxIYcYOSuZdC1T6OArCzoyEsGgyWy02Vu8YO/UyDnPq15G5J6JMgJkoCAgPUlOAug==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8GpiOHtMo/Ypa+DG69fD/fTM9z8S9Q1ZoIBVpj1OkzzsUiewR
	AIBkZv6NMrOAUryWI0Kp7hwoc9W/KEEImcwD4tdyhROSbUX8vk2fhD8wdK4jLzddVQ==
X-Gm-Gg: AfdE7ck7y3eCnQslPADPq9lV89m9f1FJWCV2z64xt8kVy2pnjwZP68510CrVuLdvLJZ
	lYWXcc4V1siDPHAj+EzeHdv70BWdP6kXb0e1NdMhuTHtBX6W1sZt5SvmFliWAXTBZQhG6dvGV8C
	5+aw+OuJSRoJAFmY0j8Pha249GlxEX+yr3TWWDQHLXhOsqehuv6vu9TLO8Hr59ia7hcc9pAzU2y
	KC9k8nhzH5OygDSx3t6FjHLPzscurErtT5BiehKH43l3052QOjO6oyNsNYh1QXD+EcqC5vLoleJ
	BTCSDLV/Bfuom6Zn0Emz9Z5sb0X+NCc1ykTsKHLbvTxaijQyfq+Lvgr42NKYpxvCCAH6no91cRy
	yp/qDLvKV192rowcvqvUlJ11hvN7V5c/nhMIoF3LlYjB/YkLFFYX5m+eKZm5bCK7b4J97FgG4xo
	xM/UQPMyIKEsf3cGbeCo6qHVOa9oQDo2fl6+9hveRpIf4kVQSolOo=
X-Received: by 2002:a05:600c:4b9a:b0:492:203f:a378 with SMTP id 5b1f17b1804b1-493c0bca5e0mr702615e9.8.1782911124942;
        Wed, 01 Jul 2026 06:05:24 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47566743895sm18099701f8f.25.2026.07.01.06.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:05:24 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:05:19 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, kees@kernel.org,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <akUQj2pa1W-MekgF@google.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
 <akPX_N0P2EcI_jbV@google.com>
 <akPhuF9pAWaBXzpi@google.com>
 <20260630185942.GF7481@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630185942.GF7481@nvidia.com>

On Tue, Jun 30, 2026 at 03:59:42PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 30, 2026 at 03:33:12PM +0000, Mostafa Saleh wrote:
> 
> > For example patch#1 verifies log2size and split and both are read
> > from HW registers. Same for the base address or other addresses as
> > the page tables, they  might be corrupted due to a buggy driver.
> > My point is that, it is really hard to assume that the previous state
> > of registers/STE/page-tables were valid or even consistent, when the
> > kernel crashed and did not transition the state gracefully.
> 
> Sure, and this mechanism is probably not very useful for debugging
> these kinds of errors in the SMMU driver. Oh well, that isn't a common
> source of kernel crashes :)

I hope not! Although memory corruption can happen due to many other
reasons :/

I am not trying to bikeshed, but I wondering if there is a more
reliable way rather than doing archaeology from a panicked kernel
SMMUv3 configuration, as I am worried that will be even harder to
debug if it goes wrong.

>  
> > Similarly for TLBs, the kernel might have panicked in the middle of an
> > unmap or free domain. (not to mention what that means for RPM where
> > a device reset with unknown TLBs)
> 
> TLB is fine. kdump works by carving out a chunk of memory for the
> future crash kernel. When the kernel boots it ignores all the memory
> used by the prior kernel. So DMA can keep running into the old kernels
> memory with no issue. It doesn't matter if the TLBs are inconsistent or
> not.

Ideally if a TLB is to be missed (because of the panic), it should not
point to kdump memory as it is carved-out. However, it is still a leap to
assume that the TLBs are in a good shape as I mentioned with RPM (or
even if the device resets transiently for some reason) it can end up
with garbage in its TLBs.

Thanks,
Mostafa

> 
> Jason
