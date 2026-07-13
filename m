Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6023546F3
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971741; cv=none; b=uFDcyjWcGLqI9V6P1e3ge3EOhjMfXFiNR+f8TNfwjj1Ihgp7aeIlbhcYXpv6QkqwW6CweKLPijW519A1e95LIwYYS2xtWtZs+9sBSv6fSKe+jaxDCgEXhckVAYg8QiA+MLlkhjS0ofwB8YXM7oJfu0IQLR0BdgXI1l6Z1TAIPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971741; c=relaxed/simple;
	bh=5d6Bc8gkCbSlPfvzi0E/608dMWlnVz1C1iUyYSF7w/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBIAiJ5ngsTA4DNmRpI9fcTdTp2VUOaU0b/zSCuIGDjzt0Q4BfZzs1L3FmLqbE5UJ4iWRQT7Gu8CQGQOXm5vb/AzwRetmCxLa3y6TEw5qYHl3IlvMZf4kCLqVIWZy3cOxtFcqzLl00JpRqPzAxILM+tOCY7QNpDcwCrr/Qdpwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GS2yLQ7q; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GS2yLQ7q"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e6391b114so18520285a.3
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 12:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971738; x=1784576538; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q5KluJxuBWim2YOI+gCMldEdZU/bLOQ3tr992AX6OwE=;
        b=GS2yLQ7qoZ4wWhbpetkiDl7h1gvrH3vaJ2vE6Myr2R3a/7qmTKylJBKbxq1EdOu7OO
         Hoa7f+XsQrGHFdcr+tTC+uI6wRzRSnYTIxDXfv4QbXiwwAlTZxTzdhVHaw6Tekv8Wtmg
         WCyna1Pm/ECAKGBtrT1Q8tTIZNSXQmgopLhJ7QiZO8IeYt49vetmMOI/F6yw2lbOj51D
         lLhkPMGPPa5MQGBtQQIWRKQMAo597jKDG0x6gi4q3kbkOd0XBy8jxpBJYSKG07v8DBlf
         XjkmtWHnJwHTn6xzHCCTrKoQ4uxR0f6TZvQkQLXcVxATvDFTsVHn14qCYNZnH0ELVwJX
         OnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971738; x=1784576538;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5KluJxuBWim2YOI+gCMldEdZU/bLOQ3tr992AX6OwE=;
        b=Ig+fz2g3MnARXpZmiXeKroEWb3gmY7990wzK1HIKMOGDWrrPHtRBm7a+ilGv/ev+Ec
         kYT5Aeu4U2d3+boL1XVsV/8TbMcik0cEnpi2u5qYOKM/ygTYwiWEr5uLXISmZWeG/kop
         X7UWUPGXJqDNYFeiF8juT7w81EAMVxKMyGV22FrIvZthjzSLqvz8QZ00qwUsg/iEdKlm
         5OgnUjc6u0rxCEm0mezE6YUzOsWpufUXFbANINIR59+m6gMKYUkVltYNQRh6t+dGx4GL
         RJaJ18rQpu5kPGhDF58zc0XmunEnBBa64GBFxvKsVcPV+eAmH/twRu3U44fjIxbZ88n8
         dUmA==
X-Gm-Message-State: AOJu0YxaxinlgxF17x1jieYhc41D2nUYcvCmOr7O6QAWief4dCzlzbfD
	n1mgLpIHcqupKHoq5weGEIawm73G1zbFRtB18pfAE/m9ZmzVeOQohAlxZYsr0L4VSSQ=
X-Gm-Gg: AfdE7cmpAUf1Yf619dAqOijmT+YL2fi2zaNAfhxC3MOt5CgD67Z9m4iMvF3T5IEKVH9
	bcLJrVffi6t9aZQ1sruOvb05BbsVFdONuS6cwiYzVvWPd5vYBF6GNgKhNtc35uoma8brQ17Fvqv
	GdcxtdjTlk2/of550RCSd3ro07bCFN145VXW3wMPIdDlb3gngm7W7bzBwUTMJ+6JVGl2OvW5ycT
	DNzmfiTiK3/VnjxXgI2s9VSqr5QHiUsR4rukJAMzjD+ak//1t2EeATTgg1D1kYpUA7ebrqFJ8Ww
	+yElOGyQYu/BekQz0GmLDYRtD9GTVkB6BwV2niAw54o9ppLk7i8NWnEK8W/ssTIBbZxZPj1AHYR
	JQ1+C4xcytGJO/4ZqT34DvSrqQNKXmc2ezGL0D1YA3DKuTazXLeuodoHJkJlK
X-Received: by 2002:a05:620a:262a:b0:92b:d4e3:1f08 with SMTP id af79cd13be357-92ef2bcc2e9mr1042196885a.55.1783971738155;
        Mon, 13 Jul 2026 12:42:18 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d37540sm1154048285a.38.2026.07.13.12.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:42:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMXh-0000000E6o6-0etu;
	Mon, 13 Jul 2026 16:42:17 -0300
Date: Mon, 13 Jul 2026 16:42:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 21/22] dma: swiotlb: handle set_memory_decrypted()
 failures
Message-ID: <20260713194217.GA3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-22-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-22-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:25AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Check the return value when converting swiotlb pools between encrypted and
> decrypted mappings. If the default pool cannot be decrypted after early
> initialization, mark the pool fully used so it cannot satisfy future bounce
> allocations.
> 
> For late initialization, return the `set_memory_decrypted()` failure. For
> restricted DMA pools, fail device initialization if the reserved pool
> cannot be decrypted.
> 
> This prevents swiotlb from using pools whose encryption attributes do not
> match their metadata, and avoids returning pages with uncertain encryption
> state back to the allocator.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 80 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 65 insertions(+), 15 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
