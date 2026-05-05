Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA04F3DEAC3
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997837; cv=none; b=Op5TjQW6uIjI+0mIN22kP7SErQFkZigKJkqRFaA1k9zxU9g0y15udbK55TSvxVlraY4fB6ne7mp4gYPRJMfCx3Wf4uXW2V8IjS+5ndMCmCTtR1sqxNP645/lobcJi2XIcgSOpCv1po6I8w+IqHLLyPYH3hhPaDwvMIIZT8YzoDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997837; c=relaxed/simple;
	bh=RNrRjG8F7y7vIp8q5Xm5bg/bZGzosl29uygoNMwlHPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5GV8jeEzIwKLg7MyfcHL1CtsMdt5CJT4L/xqpkSRIFY9kUo+Zr21zrGT7wL/qd6Zze6hgQ3J/o+T27uJToWkIvVcWF6853Q/ojEor05F4k7mWZTjLNmpRX2+ZUXgpO4LtXIKVeISb1Pfr+5XnqyI/sC9+c/zUTaG1mVtUoOiCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bdBujji7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bdBujji7"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891b0786beso36814775e9.1
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 09:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777997832; x=1778602632; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RNrRjG8F7y7vIp8q5Xm5bg/bZGzosl29uygoNMwlHPY=;
        b=bdBujji7MgLiTwOlBRKnU49SpFjMW41TKaQBTe86cZY+0uinViGp2rEaBhLs7VYx7i
         jKCITy7yfreFbfgs3UhKRt2pMnPbZMpTrYtXzMIg3RuNaVYjCnYauYYB7oaHewfpuIm2
         8aej4Rjg0zrV9vneDANTBs8RNlWQWVzulgr9JzGP/C1wz0tHx3Y+Z0e04SE7OMh6CeTD
         DZWfqZaqJp9oR+HBA31LuoBYyWI9ogWRK0todMiJ7+agJ5Bs321+KhDneszuG1OSg0xc
         RkyRhp9VyD4LKQuWk1ReAhUNPMQcei8RD0P1xRSz2s7TU1Lk8ptuxvKysGVJLzshIJKU
         mjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997832; x=1778602632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNrRjG8F7y7vIp8q5Xm5bg/bZGzosl29uygoNMwlHPY=;
        b=IPfU1cIHkx4k0af/xdx5+F2Z2dxeBFoBPEWL9LoUX08UErG/8MWw7L21XARazyaeH/
         gVRCGeWKOOKav5QhtgODUxSkxYpC4LClxXXh5D8sO3YLqSsoESfI0YMKODFF9lrUE5dp
         6kdKzzQPlT+Ne3z71awl++FsVdULn5Lg0mYDz7+L6fJunnxrHcimaK1rtjJsYBYGoprI
         2AGoURhKELAv5B8A3rMsFwYa7eG3yDQkTKVq73tBV12RD/u6rSrV+opUPGRA8UKFPPPM
         OnlOQxWP5P0uZje3yKXaeLGNbLtDosOmVitnzTvLwFHuv6wnztKbT0h8+bkfFiLYcTiN
         0RJA==
X-Forwarded-Encrypted: i=1; AFNElJ/RSNGiU91Zn0zyAz0h7szVteJdVYYReH4NuSo3A1CBOAaJjJzo/ioYQdQwdr3QMlLP7oU17A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yys0CMdqlNnTiqqb1blu/jECU0DFe7FSeq9dkgEfJA2H89zWDuh
	OZRXAW23Ykjd2iX6ybmPMIKHMCklYBxyuPZImfZ9f+EQJlb4LXlR2bQYWHa3WXi2w6/tZT76QeP
	kYX0FupMhfw==
X-Gm-Gg: AeBDievtBKtALtmx4OuLJCQoWGmg+JEdR1Q3s7z5S+/VfT8/jKSUjQJLV5afy96Zazb
	qq0ujxKyupFObFO+MquF1sTGhtZWe5gkEKdL6hdY+7sylow//8wt+yRs+0OmKpEHpXIlIOG7rkU
	9lm5dPxG6HhWdGgzrqxy+NqZA/9wzojsUUgC6qwAhZVNOZ8wdBepNlWs53hJTDMkpk/QjpUb1tF
	DaSw/c8C8oVU5gJkegb+9VAZCM8YWIGijkO9kCDFcSTy3zi9eqdIzZxBPDh+1dt5TCTv7SIrySZ
	LyLOewzq2Tpzrjz6tNU9Z+4lvQnKsJyYDpVQhDoxl2e4xxLUN1OtjAa86MMpuAGBiN5xABQ7x1y
	ox7I6SckSHPndyrYv3nvFvXlOOhl6McFd77wSm2F9it6WGKpmGKWY0xzen/9enPB5JPIIPEul/o
	w/voKeHRI=
X-Received: by 2002:a05:600c:64c5:b0:48a:5574:3a48 with SMTP id 5b1f17b1804b1-48e51c6ade9mr1520075e9.16.1777997831520;
        Tue, 05 May 2026 09:17:11 -0700 (PDT)
Received: from ziepe.ca ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82307f28sm692460135e9.13.2026.05.05.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:17:10 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1wKISL-000AN3-Vc;
	Tue, 05 May 2026 13:17:09 -0300
Date: Tue, 5 May 2026 13:17:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 04/25] iommu/arm-smmu-v3: Move TLB range invalidation
 into common code
Message-ID: <afoYBYIJOTClsdLS@ziepe.ca>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-5-smostafa@google.com>
 <20260501124143.GB6912@ziepe.ca>
 <afiN1UwS9q6F6A_v@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afiN1UwS9q6F6A_v@google.com>

On Mon, May 04, 2026 at 12:15:17PM +0000, Mostafa Saleh wrote:

> I am not sure if it’s worth it, the hypervisor is much simpler, there
> is a single page table, it’s locked (also identity mapped), it’s
> updated on VM boot/teardown only, we don’t even use iotlb_gather at
> the moment, although possible but I wanted to keep this series as
> simple as I can then we can add more features later.
> So this patch is the least intrusive change, as whatever the main SMMUv3
> driver does, the range tlb invalidation logic is the same.
> But I am happy to experiment with that when posted.

Okay, then maybe just always push a full invalidation?

I didn't like seeing the range invalidation lifted out, especially how
ugly that will turn into after my next series. So, don't use range or
use the proper full gather flow seem like the right two options.

I'm not so interested in minimal change, but maximum forward
maintainability. It is much easier to manage if you double compile
more of the driver exactly the same, and call functions in a fairly
normal way vs make special cases and special functions..

Jason
