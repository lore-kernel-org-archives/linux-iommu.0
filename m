Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01EF4921AE
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999409; cv=none; b=HQ6HPcsG4SKCY7u6Vnp4l10/uj6v5Nk1aml2DclEryWE0t7xm3fJ5x65+YlaKN4IuKYrdwuIEv7z23CkMOqE+fenZ0l2l5fsgY1SdtOmCPgGVzRiCgA6r76igPBJc8ybeend3JR3jSb+ncwkP4hbX5btOxWiiygsSxN1rnVKFvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999409; c=relaxed/simple;
	bh=faS2CkT9BSZJpclVo/IT6hgfVCE3Khrz9KkbYaXxOUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQrkyrvw1Dt1WTAVpSKK6ZV70q72IPTSA1FWZsIFWcrRv9nnqz+ldP+C9WOQokHnQy3n6kwF44IR8XSvpzfKzboj+9FIIN59mgnFNesuvC3CiG8e5HwYBmuY7chbu+1M5xm+d6UQMcXEIePmz2jfZawHsFJT86WsORqB8ThnYlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XS6YWTLa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XS6YWTLa"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so255e9.1
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 09:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777999402; x=1778604202; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HIyq5XxnZOa3QCDQC431jNPLKmCFh6Pbs13KNByKE/o=;
        b=XS6YWTLaXQPikDElvq/UAeLboFtkWOJ/4z7s7UK6s1mXpokN/LV0pe3Fxw3xQIkWV/
         aQKfsdvsIVzVbZKkqVj9SD0m/M03KabKR3GhbAex0OPTAh3CrHoIXzO9faj8eGe6G35o
         RJ/Gt6GvgvYmtp7j1Yy0NoVAsvArjsrWLcVN77mN3H77iysBhM9IUSkBf9zrUqeohadX
         O0iMWxPNzMOCoB+z1eyjsXU9MZpFjux0MSprARPfEiiIR/JLFJUvbOKVr4pVhiqfYA51
         /SMz0rkd0/Hm+JcsBbFvcLbte9W88gvUo0bni6KYBj+hKkp2R+l73uAmy3uS5D5rxlL5
         NyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999402; x=1778604202;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIyq5XxnZOa3QCDQC431jNPLKmCFh6Pbs13KNByKE/o=;
        b=STuV68oWBhVfR9/VhYxVVg1x4z4Vh1/rRntJMdPKECFUh+55OIJm7JuyijcdXD91oR
         Cd1OktDTIWaOJY8ZDQzhLTzcV0JJMn12u/S2A0+hiiGy+95jojhGnTj98non2hhaMa1F
         F6+0boFgLcgy/j9VC8TZzBRr0QaQigCDEyAjmPcC8TSFPivcSBo7kPx8mHHuG7wFa07v
         YTdbXTJRgsOthkfCiZNholFGNpIybrDRi6KNpR2MEvzYxeHLlJ/1fLWqV0KghlZ/DD/F
         qGMQqs/ADaVBMe582JdUz3f+Xh3Y23d26pFyTQbPusTfy/1n2T7TAxW8v0PxbzXMVGdw
         VmiA==
X-Forwarded-Encrypted: i=1; AFNElJ/eJp8swiMpfkF4hQEtBuXR1okyQVRSthXofQLiQ1FKzgtIx0d2mHWadiUUWPa6Cv1Xze1qAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvN+gwBaXryMGxc2aGeQCQJlKXZcb9bsWQR+5aMNVp8ZSElGbj
	dl7fFkOi0o7D8AIYpXSHlftuT6ljZGbt1UuQqJ5RQL2S0RtsF8Nw4eyi7I4LoIpiSV6LDK/2zvJ
	YamOQHw==
X-Gm-Gg: AeBDieuGu+BcA1kE70UVrcCXnBmiar8RpdicOEuS82Fdm3aeIzYy6pj2L5TyZiLbWEe
	niqPNkhkI/nzOrbtfuP67VXQMkV2G9XY/snNhFA6USLkmy0AYnEA5WkIr3Atumo80LHXwYdSYNg
	Xk1HCReSDguJBZiz6Q3v/AqR4HbfmMyBB7TzY+jHu9Bfj7cgai2JyJ9nijqM9cWYZ1iObZPZyIS
	uCcXxclPvNyYJ54E7wf1OVuSebQTA31lTZpmlUM3W2jEeFXikMG9N7VI+BCwaL0a+ihBE9epK/K
	ZllDei9CYaKeP01GRSIufOVEC14YfMPPff34C9cDlrIJs3ZyAFzFiCNeTqjgtZp6EF0Am+VeC0x
	OnjYqR4dpEmt7jq6hiznxM5Do3eMK9bs3kcTT4NmfxglSusDR9gT2qAqro5ZQlHo+T6siJzHKJW
	hiAP4i23faIVPr6XTqMateyQbd1OK2lPEUUvX67AAUd3KBkr1S4+GJ3HA5ghnLY+Le40avEF3lq
	T2deQ==
X-Received: by 2002:a05:600c:2214:b0:48a:6321:87f7 with SMTP id 5b1f17b1804b1-48d147423acmr907145e9.8.1777999402201;
        Tue, 05 May 2026 09:43:22 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d14e15ce9sm22679075e9.13.2026.05.05.09.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:43:21 -0700 (PDT)
Date: Tue, 5 May 2026 16:43:13 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 04/25] iommu/arm-smmu-v3: Move TLB range invalidation
 into common code
Message-ID: <afoeIVIGE-JjYy22@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-5-smostafa@google.com>
 <20260501124143.GB6912@ziepe.ca>
 <afiN1UwS9q6F6A_v@google.com>
 <afoYBYIJOTClsdLS@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afoYBYIJOTClsdLS@ziepe.ca>

On Tue, May 05, 2026 at 01:17:09PM -0300, Jason Gunthorpe wrote:
> On Mon, May 04, 2026 at 12:15:17PM +0000, Mostafa Saleh wrote:
> 
> > I am not sure if it’s worth it, the hypervisor is much simpler, there
> > is a single page table, it’s locked (also identity mapped), it’s
> > updated on VM boot/teardown only, we don’t even use iotlb_gather at
> > the moment, although possible but I wanted to keep this series as
> > simple as I can then we can add more features later.
> > So this patch is the least intrusive change, as whatever the main SMMUv3
> > driver does, the range tlb invalidation logic is the same.
> > But I am happy to experiment with that when posted.
> 
> Okay, then maybe just always push a full invalidation?

Like full address space invalidation? that will not be optimal and will
affect every device on the system, why would we do that if we know the address?

> 
> I didn't like seeing the range invalidation lifted out, especially how
> ugly that will turn into after my next series. So, don't use range or
> use the proper full gather flow seem like the right two options.
> 
> I'm not so interested in minimal change, but maximum forward
> maintainability. It is much easier to manage if you double compile
> more of the driver exactly the same, and call functions in a fairly
> normal way vs make special cases and special functions..

Let me try with your series, but the core range invalidation shouldn’t
be changed often as it is tied to the hardware and wrapping it in a macro
is reasonable (just like the CPU tlb invalidation)
The last time this code was changed was in 2023.
I am happy to use higher level functions to improve the driver maintainability,
but I don’t see what is the problem at the moment.

Thanks,
Mostafa

> 
> Jason
