Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C251E89C
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775515398; cv=none; b=EswT2a305nzu8neAuU5o5+JU4SKcodqJie+zUwbyL2VYx5Ci16GgnAMl0ZgQS8BdbZO/gArK0ljmJy4Tc8259sdETlUJA26H+XCXa8MbmAJW/MOqsXEkqwN8CQnRy5h/70th74NRFyYDKX7e5G0HIzEvA6iYanpVx31FRA4z1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775515398; c=relaxed/simple;
	bh=xcrfocpIH1wXzSNEdp3+HtIvCO4srr4E+al54l1e6LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeetGsmf+kA6pOFcAjBLpefgPiGvT1T2J2jFxCr1yKcU4sUsIvWlY8//g5ZZgr158K812gcmtipUFP6z/N1yQYhKJC8krNrJDgu8HkqjPjaBU0nyhw8MmNohIitiotl1p0M7TrpxOhSB1kfQ5m5giTj6YgCAWhHziNX+CjhDIJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ff2Lwaeq; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ff2Lwaeq"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89fc4147f2eso58376066d6.3
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 15:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775515396; x=1776120196; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A0ofprARzeA7jjb56JE2UkiU6d0K09eNO/n0Kbv591c=;
        b=ff2LwaeqRVpluN6WvDf3yDM2VzUCI0Id97FvO8YHdxv0Sin/ceBQn62DT9yGo2w7sr
         Y2spYP5mKJtKtRAmkt9FIP6EiWeMMk2brw+bRHBrYhwTlFpciZ09x7RjdH737bUPJs+X
         qGEJWz1ZsYWmVzmgMcujiu/McLISxoc0r48PESkwGSMsRbwi2WjR30hi/eHc6/lLj0z1
         zZhYhjzrjw6dzGt/IpgJgnOnfm0ssSZDjvUrfZTTvQc8RKfT8A4Gyp5xRnvZQm26dt/d
         Lm25t498TVHq9/W8/DLqEC6lPDoMD89B0aXePUzo47LMHuUu5x/5r3wgGUrjXYCVWVMq
         8yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775515396; x=1776120196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0ofprARzeA7jjb56JE2UkiU6d0K09eNO/n0Kbv591c=;
        b=SZNAHwJvb3vG1tWEPhAyIH6wM1kEeIlzXIb4ZJeFbAzLhRuOn0a8IOCCF/vIm3Qc32
         yC+9nEY88E2XDWer4lUWgtNM/qEG15QdeAYoMb3+ZmOXcZyNjQ4i1ueK4RUIyo0d7286
         q9YrC344DbpgifHq1VWpXfS1SkKGEI4Nw5L26RJEhMuWLMgyWosJ6EkWtyFANxhiioZG
         t3vPKyD0s5I0qkZ+XAq4Xc1fa1PyPKYsLwWIf535Hx20rXWj+PiDahjsDWEJL2k0unm9
         Ot18T3yWhWKv0cLz9j/sMYc0G53L85Nim6QTCea1hNO15fLRQIWY3pN0bQ+s5V8ww9XM
         db/A==
X-Forwarded-Encrypted: i=1; AJvYcCUxfRUp+mWOQhIRuZOH9Q3UbILceU9JXAXcbsGLbpiTscT1eUCCOXSX7EUR1eYyAA9sBb/9Rg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXuQ+hQzdkbaFzrbraY5YkWXFZKwIJAMW6la9HuwWOq+DMKIH7
	0gJHtP87OtKd+Z02cFoEnMkcYENHMPx0W1zofht+fwfOWuPGPXsFKJY80t+F+GWYN8em4Q9y8lR
	7nu98
X-Gm-Gg: AeBDiesr7ytiNTq3aqHDgNwHOyIkzE8z46kdwFGkabfqTKUrVqgtrZQrEndrQUf4F3j
	arRUGqNPRCa3TlcUpa1+9Gfk11ZWQUUXCeBEP34TJ+uhCL/nBHLr012fqV7OE48gRFV7kBwIN5b
	B4KZlxjD/4kjwRIe/A7Yhaw1lpV/OHqGve5i2NuoR1EtY5WKEfjkEA33Kk73OrKP0dy3k6K7LVr
	e6JiyPEnjp6biJ3F04vNdOLSAK/hwX6AYw9FCZaunD2O0LAO05iW+uDsg+ly8PibPYEptVcNLBN
	rVf84s9YWL83q1bcEIbnhx/9V6eS32KIVLCKvatjXcmlNr1/A5MnTfuMGtVAwib490wnqGZp+u/
	/kdQwlpJ4ICrVmjz728PnVc3UZAzJAEvptOaZR0fMFnxeRvCKzDN/aRsYASIOchCOmmtKglMTKo
	NTe52MsbcP9ox21oherK+1JLcBbNclaXRHCqokhpQxcBIu/xkKz17+0hrcEd9At/Phps2fcw==
X-Received: by 2002:ad4:5c65:0:b0:89c:6a86:e632 with SMTP id 6a1803df08f44-8a725befb13mr237314056d6.18.1775515395972;
        Mon, 06 Apr 2026 15:43:15 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593bf6741sm151891956d6.18.2026.04.06.15.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:43:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w9sf4-0000000E5IQ-2nq6;
	Mon, 06 Apr 2026 19:43:14 -0300
Date: Mon, 6 Apr 2026 19:43:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nafees Ahmed Abdul <nafeabd@amazon.com>, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iommu: Default to lazy DMA mode on ARM64
Message-ID: <20260406224314.GL2551565@ziepe.ca>
References: <20260402195913.32084-1-nafeabd@amazon.com>
 <ac8lwTT0oQNT-JaL@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac8lwTT0oQNT-JaL@google.com>

On Fri, Apr 03, 2026 at 02:28:17AM +0000, Pranjal Shrivastava wrote:

> Thanks for the patch and the benchmarks.
> 
> However, I'm not sure why should we change the compile-time default for
> all ARM64 systems? Currently, users can already achieve this behavior by
> using the `iommu.strict=0` boot parameter.

Personally I really dislike these rando arch specific things.

What justification is there for any arch to be unique here?

I'd expect a single kconfig 'try to be strict by default' and that's
it. No arch override.

Jason
