Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B332C4E50DE
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108811; cv=none; b=TRxW1vSq/dpLJg5QvvBUcTVsQ+oClwNKyDwQnvYWgfszMMJVZRiW4plhtdiWUuZGwdmV3pFCSHN5Nvc+jAxfwRyiRVcHE2sZyFzv8Hxv6qqT5EJ/4Ys5DuDWoIA2PxMDPv1du1B2jk4WEfCS65vvWjZI9YiqNYuRd8gCj1ql47I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108811; c=relaxed/simple;
	bh=QqEHOCux09a0Q8vXL7DmpuXdHbLuTIeeYNtJksyQERU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJEXO09cm4m8+wQsxrjreg0mb+kn/6MM5PVRJkB1E2R+9Vtst3Xxae0cu5jaJsKowSaL9PuEOWQxyb3tsftTPPaNZBBaYcMN5jiiNLj3DeZ/E29J0DzMW9DJO3KdhJuuSGMwS1PBVbcZV0UMiMMF69+28trqtz2o6TIX/KNOW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VWT2NaHG; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VWT2NaHG"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91b83459526so54527096d6.2
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 17:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792108809; x=1792713609; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QqEHOCux09a0Q8vXL7DmpuXdHbLuTIeeYNtJksyQERU=;
        b=VWT2NaHGs2Yc4Q6Xdkgr+pciiw34ukVmmz/ZwxHbLsDUMXfiuvMDphi32uef7ru84x
         Jw24UejRhNua91C50y8UhD3esZgqCgDIjw8qq04LYhqOt+bSP2pFU3zt6fzz99un2m5U
         0gqLh5PdAqIS2G+3LiHE8iZ36/wntO6HGjeE1jW0f9rChjrB2+oKEd4TJ9tcGYcQgafO
         A1j1Bp+3/OOi0hFHmITHDSVKIAwa5urXfhSZytTxwdo4DHmgi4/h2tJvDwLJR1mW1lkI
         Hmd0R6rpNKUrG6JwlLbMk8BmDngy9gKWi+4GNdibimU8FDLp5KXCGsu9Crko7fxuEsx0
         jizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792108809; x=1792713609;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QqEHOCux09a0Q8vXL7DmpuXdHbLuTIeeYNtJksyQERU=;
        b=x/hNn14KrmFlFiG9NS5PtNGWP8InceKRSr3anQe9lwLrhi7OMOniBArbuUUtTz4sUs
         WPl3ywKmpwqYiZcQFcInEYKhCyL9UaORI/73VSpAAlEI06/m4ZRYqKkDU6bGLOZy5LXS
         qJ5LYk4+CR+T5gZbeYBMkZBaS/zGgV4t9z6uOWTKahAQL5V/cUJytbpJZquL5Kvk/IeB
         DEWFE2hwj3Ukor+OK89W/O62YzTHHfLah9zxmLVijAkv7cjchc/DLo8dZS/aezvurD4b
         4aYbZSzQkPMt58Wu6Y191SVc469yzL3PvKmpRNYECargOy6uMkZGHEEvCyjWqCzaBOeU
         GcYg==
X-Forwarded-Encrypted: i=1; AKwUvByXELfO5XWZ4s5iVIazVfpAgacs2T33uj1/2ifZv5kwZOohoK8L6ONlNGPy4QShD8D/WLlGog==@lists.linux.dev
X-Gm-Message-State: AFq9FYLFgir5QZCETKkcNLr32Jy7r2E1apIeXQn9KBOg269UB+ZF85XG
	UvRsBhumLBpdKS0IX1/xBPQGyxfCtdngPYLq/olOw1Rqbg5RGMrnwgmUYF6ft/hJrwhMf+Z6q8T
	70wr6
X-Gm-Gg: AYBFou1M/4IiqRzx4jUVXG+PIgXxmXXk3VtGesYClrqZZhRAZuvtN5T1zUiV+VqVPRd
	W9XwYfX7wI+U+bcXdBLf9BYK/RsecIyYwC3dPWva1tnkEnrAcGPGsHPfKN6C9FdEjN82cQfmYaQ
	g+JvnU8F3Ntod8kp42cVlmG8LjUyybnZ1BuIDmpDyjFXt2oMAW0C7A7yX0vT3ZaRgjOGwLq1qlk
	hKvEs5ffmBh5yAeQZslaQ+rfQhswaYq1SCZn8V2AcK53gMqoXjVzEMsX76zryRs3dcT+LidmgSE
	2cpIOo1PRckSxvqphPteSfEu0nYqu5IwXGbizFHW/mCt8YgjdbVQRDuddR2v+DzfpmBJuiFsHtX
	+FlYikcVBOLYRk4FsaJyMyOxC/7fgPn2qqR+rAjgv+7N8GqLnCkiChqDLXNYGhEIn/6suL/F77y
	W7ghOCFx/XSr85c+iDrJfGiABM6V+dQ/6/S2KZsrl0FZJ1D7kWbLmbcD3yQ7f8hcNXi4DE0yFBu
	wU8vgLXobsa0VL5Tx/Szh3sqBd+FJHc1LzFt1LT+Q==
X-Received: by 2002:ad4:5deb:0:b0:917:bbf1:5323 with SMTP id 6a1803df08f44-91b55793527mr367860846d6.38.1792108808237;
        Thu, 15 Oct 2026 17:00:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bce8918bdsm4228956d6.48.2026.10.15.17.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 17:00:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHVMi-00000000H7g-17qS;
	Thu, 15 Oct 2026 21:00:04 -0300
Date: Thu, 15 Oct 2026 21:00:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Tomasz Jeznach <tomasz.jeznach@linux.dev>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Zhao Qingye <zhao.qingye@sanechips.com.cn>,
	Gong Shuai <gsh517025@gmail.com>
Subject: Re: [RFC PATCH 0/12] iommu/riscv: Add nested translation (vIOMMU)
 support
Message-ID: <20261016000004.GB14213@ziepe.ca>
References: <20261015065232.604503-1-gong.shuai@sanechips.com.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015065232.604503-1-gong.shuai@sanechips.com.cn>

On Thu, Oct 15, 2026 at 02:52:20PM +0800, Gong Shuai wrote:
> Add nested translation support to the RISC-V IOMMU driver, so a KVM guest
> with its own vIOMMU can own the first stage of a device context while the
> host keeps the second stage, and add the interrupt support. This is an RFC
> and comments on the design are welcome.

The iommufd parts looked reasonable to me

I feel some mild skepticism about all the MSI parts, it would be good
to get more of the interrupt stuff actually landed before posting this
again.

Please try harder on the commit messages, do not use AI to write them
like this. They need to explain why this patch exists and what problem
it is solving not some inscrutible description of what it contains.

You'll need other riscv people to help you with reviewing it.

Jason
