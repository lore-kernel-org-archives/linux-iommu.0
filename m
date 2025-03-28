Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895DF1494D9
	for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743168084; cv=none; b=bS+d5zwNwjYREaxXAoAI4IFFxKxo2pXPTp7l8MIeVTSrz6UHa1Khiyusn8eI/MLQl7v6P7z/ULk/opLTn4hpS1uptzFUTrhF1Wdb8+Yicwm7caaQMJEAdamO/SmPXvUa+naAWRtLxrIFgSMaXydw8PN5M1dJAUKj2T3nX5dxPyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743168084; c=relaxed/simple;
	bh=FotXQKGcDHMEApNOl/cH73tHhN4AGsce9ThhNwsirJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j274NvXwHN9VorrsjVn0g1ymzbta9ZyjTDuaACEGrej/FPrMOCbTLmsXnXv3XQUdLd3M403KJ3PwbS5TudV7zKe2y7Eu5WJeL3g4FRvWxs6XdYf9yTXixTgp8HWYdBEhYwPppzDcK3Wd7Y/mX+eLGj9IpALK9RiBsAcYWplfcNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lt6i1ReW; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lt6i1ReW"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c592764e54so277866985a.3
        for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 06:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743168081; x=1743772881; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J9/uYhFOtAZFRBwS5Hb8nFrDoYUuTwJ1mHwmGGqX1PQ=;
        b=lt6i1ReWepBbjl8xHmXP2TDc9UNa1sJhPDc+A4KQff2rNKO7iRoUaz3Nho8+0xhzWQ
         fwy1kf699HPZIt3wiUrT8TE8jwos6jlcmqVU0wN300S/Cg0s8sfGqq3poxAoPqyK1cY6
         hLmJcd+M7D6xPvJcwFTXl6At55HEeh/+V/r5s1gzvOQkwFVSDugtPyEYIdr9G8XlNHuU
         HSz9W6tZnmeVlAKsC+OkH4Ouj/b9G0wJNiZueLi5PdKCH1R8/kufECtuDxpMOIeSp4OX
         LuIpHeaCuQ13+qGlVErInsZP5quPHiXtFPkYUVubhc0MoNI21xt70jsjq1CmwwmKeBMq
         nI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743168081; x=1743772881;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9/uYhFOtAZFRBwS5Hb8nFrDoYUuTwJ1mHwmGGqX1PQ=;
        b=a/uEDF0NzmZqx1YkJx/4i6bKfAu0S+HProSLiJN322MNXo7rm2aTgygzrSQxYQz4J2
         GHZFvCuu24shQqPkRGMOWktfNt3LRQqtpXzyvnBDHwgI4rCit/bXzNb4JyFFqxrSMN4q
         NkwtIefsEFBKaOkjAMTT+eWpiChs0X29gp0Qx0xaeTFi+voZVknGS1SUYlL07xdi+lEa
         MJ/maWKo6aBUD8d69n400BLykQMDIDZnZXps5qVfrrBQtkl+4AdbQWQhYF1pbSx33e+G
         XyuQngdxYuBA/sXVbfFFVX85ldXivhyHkjM5Podgq4aay8HlK3yLOKfv+v98Pyi2/O0q
         sEzg==
X-Forwarded-Encrypted: i=1; AJvYcCVYdzrKgsRNFxB1Yf57yAyCYqB69ZhaRlgL5/V/jm4UPVc769LlnC1mIYeO+u0usAkdXthRSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGIO1A2kr9PBcjEnAUWSzBON/gk8zKaK6tR+0QEZidtavCwU62
	VEtcW6YbSUUPHLsZ2AJ1NwjGX0mLfCEHeRfA0C0yNknIbIMURvGrRoaUjIGlr2k=
X-Gm-Gg: ASbGncvUViFPYn5YCCDsO13gsFfcQaHMAYDjcWBTcb+QsrqG8EOirPiqIaq67+CZ+UU
	kyDCr5BWEdpgarwN7H7+XtI8Kg2Un0LQebMw1T7rMc0YgMjHlSzyl2b3D10fp5jQyu25FV6K/gO
	cviWlGLzXX7/FoKfjL+maslIG9Bu8KA5NBhWVidSH7CIEmU4M5mrXR4QVJVWb+HXMoA6O65wM29
	Ie/8moHymfmdP5RzZT4HfFP6LfvEX7TKm94HbUVOQlgBfWfX04PR0u4uQC+6dYDHy+TECkx44Lk
	CQrrhrhFhKNSl2cJJbqph1DfdtAsfo6ZBjZjBstNhXMVBeNE5xLa5NdPmuZKO0WgJzebZgNBJy9
	ApNzNSmhkaqrx/f3haSPqsgY=
X-Google-Smtp-Source: AGHT+IFdxXx59V9DMhhflYf+CrdwDgNqFs1kM6EdJu1ZIwDcGp0eBuA+4JAwXgy7LtKCBCRbRkslsw==
X-Received: by 2002:a05:620a:4442:b0:7c5:3ca5:58fb with SMTP id af79cd13be357-7c5ed9ddb7fmr1082869285a.4.1743168081307;
        Fri, 28 Mar 2025 06:21:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f7680b7asm118112185a.27.2025.03.28.06.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 06:21:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ty9eC-000000005Ug-1Pbq;
	Fri, 28 Mar 2025 10:21:20 -0300
Date: Fri, 28 Mar 2025 10:21:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Pranjal Shrivastava <praan@google.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <20250328132120.GD20836@ziepe.ca>
References: <20250319004254.2547950-1-praan@google.com>
 <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>
 <20250319194609.GA126678@ziepe.ca>
 <Z9yWnBmOfeG-7rno@google.com>
 <20250320230551.GL126678@ziepe.ca>
 <Z917OSsvHBIZfar8@google.com>
 <20250321153034.GN126678@ziepe.ca>
 <Z-GcHNeDSX4Ttdae@google.com>
 <Z+K1wEgN2jtAa3Ln@ziepe.ca>
 <Z-WNToFe-uRFqeAA@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-WNToFe-uRFqeAA@google.com>

On Thu, Mar 27, 2025 at 05:39:26PM +0000, Mostafa Saleh wrote:

> I agree, I don’t like the approach of adding a (yet another) flag for
> firmware to populate, I guess we can either:
> - Prevent SMMUv3 suspend, and that’s already the status quo as it
>   doesn’t support RPM, instead of doing that from the driver by
>   detecting non-secure attaches, we can just make VFIO takes a PM
>   reference on the IOMMU.

That would break runtime PM support through VFIO on other platforms..
 
> - Disable the PCI device, or unmap it from userspace from VFIO suspend
>   handler, and retrieve it’s state on the VFIO resume handler which would
>   be ordered after the SMMUv3.

I don't think that works, the PCI device could have already been
programmed to do a hostile DMA prior to any unmap.

I think the only thing that makes sense is for the SMMU to not do
power management if it can't obey the API requirement around domains.

iommus are expected to always translate according to their attached
domain, never something else. The only possible exception would be
abort-all.

Jason
