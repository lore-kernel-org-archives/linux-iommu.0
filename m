Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F7B3161BF
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 02:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787278863; cv=none; b=pfqGSQ2qSu/JzsfnUbg/QYiMg5g/Dk64GipkFTOSDDiXa1KaVHjiWJ6Hfari5/TAkIexjsuGyYfXAVpK35olyI6vsqFp0vf8et/Hct4HRH+jxbQi+2mJoCHCaYBjw4gJxl1F0BiBfxkKiG9idyJiP/THepMaIox+yLSFVyk3K/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787278863; c=relaxed/simple;
	bh=ODEamyaNinz8ndZY25u31wy9kg0XuQk5tLuO7i1Q1AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sk3wc8kCuGUhu9+i4pQhYHn8dW2bEOHT3eX/5M3ebJxT8uEloLoT16TQyngGOqdM8UMlPu2CZSO12qZcsU+j0U1Xya/CsVca/rQddExnE7jcelGN7ZczvozkBklt4+68QYdi3dd1+seUC3xx4tUPAMoRpU5HzQocHiPsuk879d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=syW99dfu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="syW99dfu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d3b445a84fso20805ad.1
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 19:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787278861; x=1787883661; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vTISns22lLz3uE6OmdCyn6vQB2Si1JaLhFBQroGqygQ=;
        b=syW99dfuttVHP7+xFW8rDpDQpoKQUVyLouuPl/Rbqxl4Wjvc9JO6dVw36ovWdLsi7i
         OYV0R9ga1Kr/0G2VmRO1WZmXUzprZM8uyEahh2WZUs2YHzS9KsbqcXTVovb1hR14frDR
         K/0t+/EmzixDHs/3B8axEHuPXkFIfv983XR6LRBAm/UMzhd5d1ioo6qtmqMzG16yZXYW
         AEvSOjzYe9mlr32A92kkr9z3xmGfRgVlzCZeHDjR0uOX/7Qo/87JU4J21b45uoO2fihw
         +Y9JZypL2TuNyM47TPJSDI+mZQT2i+Ye8p0vAtuUxMR7saT/jMEocCCEiMJPmy2TASj3
         boig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787278861; x=1787883661;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTISns22lLz3uE6OmdCyn6vQB2Si1JaLhFBQroGqygQ=;
        b=OxXDlGEmyEy3PYnTFB6qtJ9DmEYy4XOAj5HWhYEbtH8lF0Xp2kqqCYV2iCwy9PdUrm
         NkXzXXMQ1HOC8yYYYuWoPEqlp9Xzd41mw1jK49NMbr9j8WrSqf5U0J6aRRbkAcivcy9X
         SVvOwWKsa39tnkdoiJw0a/zG5zYwOtNty4izMx03B108rG/FTaUOUO9upGZHDGLrsejq
         rAzCfWkRbdVibm2n4wuoS+ePaze97FpWN5m9vxnxEHvtT6t8Upepqa9jsto1Cf2Bu37h
         XpIm6VxpZr0NQevBZmNuohgsJt1D6xjl+8A4DhzZl/kJjklPQmsUiIQiFQEyjwFNpNt3
         n03A==
X-Forwarded-Encrypted: i=1; AHgh+RqOl7IrdLi0HCRVtlg4O5sLO7LPtrxk1rFn77D6TQkUbOu+1lTK6LIA8UW6jDBBHEYBt2uA3w==@lists.linux.dev
X-Gm-Message-State: AFuF++lb5AsfuM0FcxUUY7gFPTPanL0UMGqXe8DUAlGtRtaHBrJKL6hh
	kEso7WL3JAf6DOvtizEmh1kRSA+42icap6Izt1SUqAD/rkwh57YD4qUoq8b83W+deA==
X-Gm-Gg: AR+sD12WNhwRBxBgQEsUrIhHdwZQJGpNQGLzcJrOTqpIRjIhN7Lmak4ffiItKfJ5+N0
	cbEBsq5E9NE1nhxhLuOX6b8dAW3VjlFpfNv2hvyUJm4bLfM8opm5uuBsAVazc2wyVjOpV6fzbVa
	GzbxXu4X3QmiXsncfpUKWrevzSQWPOdh2tT1iK+7Lh0FtHtV2pUMd2DiPGCN3E4tuKr6jnZ/3lr
	pju0/GwMuL91gfz8cdBwnXSk59RREDU14v2ih8+0md38xPOO22oaDFahUFj5idwOcuQPXEVg+86
	BgFkgw6VLMhZHQhRWnYNBOkh/NM3D6kzHjr2WwDBI1zypQdmI8eiaI63xHeleP4qqSJf+63fsol
	t6UUQ4Bg+h9GhkCC82F+q3jd2u+3VnscHuP8O3XG2rBE+JPZ8iazm5AL6InDOWgG1G+PMGrUmno
	ZzXj+3/Fxx9EZqa7noVOsLB2iPzkVB+6I7A2K6Sk3k71uSxTWHh76/9MT12+kOeZByxIdtDgnle
	/rUF/I3pH11yr/et0reTUcGENHTMz8ZzRUQ2AyHvSvipCpP+4CjnjrwUXg=
X-Received: by 2002:a17:902:f552:b0:2c7:f688:f22f with SMTP id d9443c01a7336-2d650dacb5cmr1955855ad.13.1787278860193;
        Thu, 20 Aug 2026 19:21:00 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4b82e5csm1054937a91.16.2026.08.20.19.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 19:20:59 -0700 (PDT)
Date: Fri, 21 Aug 2026 02:20:55 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, 
	Alex Williamson <alex.williamson@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, kvm <kvm@vger.kernel.org>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <aoeffe1v--CgRK0a@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
 <an5JbIzz40svS3xe@google.com>
 <20260814083737.66bb83fb@nvidia.com>
 <20260817121810.GC933791@ziepe.ca>
 <CO1PR11MB48354AC2854C4D8E9984FD8E8CA62@CO1PR11MB4835.namprd11.prod.outlook.com>
 <20260818140304.GC5482@ziepe.ca>
 <20260818143906.1f58aecb@nvidia.com>
 <aod22_H66eUth9av@google.com>
 <20260820233722.GA1110819@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820233722.GA1110819@ziepe.ca>

On Thu, Aug 20, 2026 at 08:37:22PM -0300, Jason Gunthorpe wrote:
>On Thu, Aug 20, 2026 at 10:38:07PM +0000, Samiullah Khawaja wrote:
>
>> > The blocking domain operation looks like it might be simplest to
>> > implement in the IOMMU core.  We can set a flag for a default blocking
>> > domain on the IOMMU group when we take_dma_ownership of the group.  Then
>> > release_dma_ownership picks the blocking rather than default domain.
>> >
>> > This is then unwound in use_default_domain, called via dma_configure,
>> > attaching the device to the default domain in probe of the next driver.
>> > Therefore until probe by another driver, a device used by vfio would
>> > remain in a blocking domain even while unused and unbound.
>>
>> The devices are expected to be attached to the default_domain even when
>> these are unbound and the use_default_domain assumes that, and it only
>> checks the ownership and doesn't switch the domain to default_domain. I
>> guess we should add a WARN in use_default_domain() if that is not true.
>> I will probably send out a patch for that separately.
>>
>> I think we can move the device back to default_domain after reset after
>> unbind, maybe it can be done in pci_dma_cleanup() based on
>> driver_managed_dma?
>
>This blocking domain stuff sounds very similar to what Nicolin
>implemented for the per-function ATS issue?

I see you are talking about this invalidation stuff:

https://lore.kernel.org/all/348c50ab6e95b5ec6d48ee3fa05d529a784a34c3.1765834788.git.nicolinc@nvidia.com/

But this was the case where the device is going to be reset and to
prevent ATS issues, we attach it to blocking domain before doing the
reset. But of course, with the PF reset here, it induces the same kind
of ATS issues on the VFs.

>
>Broadly we must setup a blocking domain in the iommu if ATS is
>available across reset or you get these ATS related issues.
>
>I think at the time he looked at doing SRIOV as well but it was
>tricky..

Hmm... doing that for SRIOV also, by allowing PF reset but attaching the
VFs to blocking domains before the PF is reset, will only resolve the
ATS issues. But the software state is still out of sync with hardware
state.
>
>Jason

Sami
