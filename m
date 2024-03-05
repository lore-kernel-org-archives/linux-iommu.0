Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A4C14286
	for <iommu@lists.linux.dev>; Tue,  5 Mar 2024 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659156; cv=none; b=CoQ0WXI/vLiCcVpDktQnNw04z2+2nPFNJVYJWtjSa4G5xwNrznEtb/mVMrjKER/oN5bKm/MjbGX/wS5T94un3THIYLwdUu68fMxo5aK9UFlS+OrXDWxau9+A9nNBQiNJRDwIEAlnrmfNoLFBvVeb6mZc/2vdAB/SLoTZg96R8sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659156; c=relaxed/simple;
	bh=35W0xkiyIW+h4I7uaqpD3yZaGe3eGIyUIL9pgPlFMFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=neiiCQQM7IQVvRZK7x1FgOK96gO4qv2asx0EUf+9l5Gl+0/Tq81bS8U0crDwaRmm/D0V5VwyjoLNnEARTyXUJYrFGYLLr9+QaSBGw2Ryyc1lFXi17xr4wV1ivc17OmkrCZv3kQd+r9+LxPrGAumtKkteXVZqBhwWHu2NKqYGof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6rsnOer; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6rsnOer"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a142375987so459745eaf.3
        for <iommu@lists.linux.dev>; Tue, 05 Mar 2024 09:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709659154; x=1710263954; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QaobAGWVH6S5E9EJzoRHvFL79d1fgtq8p8ecN7tgGg=;
        b=o6rsnOerzYUJo1A90xu7rRjY+Fe7zgsWQKNl02HtUDfhfV0azAxM80c5aUyRmrhPan
         bom4Ysg6wCryBSSkH0FqP7yR8HENhzc6flfIIYmUpUMkWxhWDDADM3Eeba1Tp8WmZj90
         qMZHrlxSIF805g5qDjwV3fPqZS0nQSOb3DkmW8QTT/e97Gxed6Ypn4osgsyxt3nFeeMO
         F5ui/ZdAfHNiRiArxInAVNMSFWqmmHj99snzyhgjq77jT6yKnaAiJcn7GWCPp4Nl/pWw
         zkP49rLoteuh174M82+Zqe2I9tDhGfHKfSlod1Q7X0W/yGSsMegfcg3fTf5i9qLliMUV
         nGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709659154; x=1710263954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QaobAGWVH6S5E9EJzoRHvFL79d1fgtq8p8ecN7tgGg=;
        b=uPHNkoKh3gT74rJ2UmqWIaxD9t18RzJRcCMznLmY0+rIBUXwrDTiuf0wU+XlxFHQrO
         wU7njqKznY8dM6oS8+BXrtnnYeLY/joCNB9/1EYi/RjBJJVXJ0aStcvf+7ITLtYkz+L0
         ZbB6NKp05pronImmiviIIJ4fk6VYLnDNhQyhZJSpMn/C76n6oFdAl2G0LyzhBGRXNS+Z
         HxLMwqpls/fYCBTN/4KELH5sHOM8l9gH6h6ebpa16IPEW1HLWSioifUlwb0LDyGSZJUR
         UTB62k1VA3zxbBam6W47GIiA+1b2m6Z5EYiKArdY86qyE4MxVcCse6O0t8FfTGf1Cr5C
         rG+A==
X-Forwarded-Encrypted: i=1; AJvYcCV1+9Y+6gdSoVuvUuHrcdNSNDVnDkCqaRVH15PdIwwDQQeMF/g0asmdL6RvHWgdssAhGoxQbgTNkSSLIwsrT0rrElpMSDs=
X-Gm-Message-State: AOJu0Ywu+r2XWb0WOKX6LiX0pt6hAAWUKzzcN9KWkYxNsGQP1WfItlEq
	Nnbe0HaPAIZ9MNc9k68oNvOJaByulgY+/oonFSByhXZkmsovjSSMiPIl0gbW16vU/0FPtoUOgJ4
	Rxb9+u0Zf/L8GK9dJVZv/ICNAo7E+vons/U6R
X-Google-Smtp-Source: AGHT+IEFsxok2qYjPGM8WG7zzaRYUAHjkHuadWtw7qIkVbdF0GYy27xbG5BOekp2bznsc7bcEKBI8II7uSjtyoF/Gzc=
X-Received: by 2002:a05:6359:4103:b0:17a:d4c0:d59f with SMTP id
 kh3-20020a056359410300b0017ad4c0d59fmr2914394rwc.4.1709659153881; Tue, 05 Mar
 2024 09:19:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com> <20240112055251.36101-2-vannapurve@google.com>
 <etvf2mon464whscbxqktdd7bputnqmmwmoeg7ssixsk4kljfek@4wngbgzbbmck>
 <CAGtprH-95FEUzpc-yxQMo87gpqgMxyz9W8tiWtu_ZHhMW-jjuA@mail.gmail.com> <8a6dabdf-dc11-4989-b6b4-b49871ff9ca6@amazon.com>
In-Reply-To: <8a6dabdf-dc11-4989-b6b4-b49871ff9ca6@amazon.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 5 Mar 2024 09:19:00 -0800
Message-ID: <CAGtprH8LOgvtO_rjFzASbp240P=yBvODCBU22sN_+uhdumueiQ@mail.gmail.com>
Subject: Re: [RFC V1 1/5] swiotlb: Support allocating DMA memory from SWIOTLB
To: Alexander Graf <graf@amazon.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, rientjes@google.com, seanjc@google.com, 
	erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, peterx@redhat.com, vkuznets@redhat.com, 
	dmatlack@google.com, pgonda@google.com, michael.roth@amd.com, 
	thomas.lendacky@amd.com, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, andrew.jones@linux.dev, corbet@lwn.net, hch@lst.de, 
	m.szyprowski@samsung.com, rostedt@goodmis.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 3:14=E2=80=AFPM Alexander Graf <graf@amazon.com> wr=
ote:
> > ...
> > The issue with aligning the pool areas to hugepages is that hugepage
> > allocation at runtime is not guaranteed. Guaranteeing the hugepage
> > allocation might need calculating the upper bound in advance, which
> > defeats the purpose of enabling dynamic SWIOTLB. I am open to
> > suggestions here.
>
>
> You could allocate a max bound at boot using CMA and then only fill into
> the CMA area when SWIOTLB size requirements increase? The CMA region
> will allow movable allocations as long as you don't require the CMA space=
.

Thanks Alex for the inputs, I wanted to understand CMA better before
responding here.

I am trying to get the following requirements satisfied:
1) SWIOTLB pools are aligned to hugepage sizes.
2) SWIOTLB pool areas can be scaled up dynamically on demand to avoid
pre-allocating large memory ranges.

Using CMA to back SWIOTLB pools for CoCo VMs as per this suggestion would n=
eed:
1) Pre-configuring CMA areas with a certain amount at boot either with,
   - command line argument to the kernel (tedious to specify with
different memory shapes) or
   - kernel init time hook called by architecture specific code to
setup CMA areas according to the amount of memory available (Possibly
a percentage of memory as done for SWIOTLB configuration)
2) SWIOTLB pool dynamic allocation logic can first scan for CMA areas
to find the hugepage aligned ranges,  and if not found, can fall back
to allocate the ranges using buddy allocator (which should ideally
happen after depleting the CMA area).
3) SWIOTLB pool regions would need to be allocatable from >4G ranges as wel=
l.

Setting up a suitable percentage of memory for CMA area in case of
CoCo VMs will allow larger SWIOTLB pool area additions, this should
help alleviate Michael Kelley's concern about spin lock contention due
to smaller pool areas. This will need some analysis of shared memory
usage with current devices in use with CoCo VMs, especially GPUs which
might need large amounts of shared memory.

>
>
> Alex
