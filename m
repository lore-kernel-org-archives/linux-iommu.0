Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE2680023
	for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402859; cv=none; b=L3ygoyTCmwEVlGowr4sTWHI+UsFTrptws4kV/F4JOhZ6t0g5EWtm24xhMlIac4jzwOC8U/ztI+222UL9Mjqui+mIkNqG7HBd6r5y0PTLOOwdoVsH/RUm1XaTQi2x+JXjLWDxxv+Qu6SM3zLoNgGgE9VlNvVyLweWurrJK0fKeR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402859; c=relaxed/simple;
	bh=ptyag3zULY46EE3cfrjM8Ikvapm7FareWHtUvzj3mxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJ8Xv6nOsgLyuQAnUI4t5CAsk5PPxt5a70SzMF441e00Q4SYokHlU9ou8uApebt6gtJfPp1oqPlKNbuyPjkhVCwOJW/zLzvles5hc48cieTIbJLRfQJbGk3tYkTAg7tAAcfYBbmScT8EKo9jmoUPl9qDwFnQkkZ/2MPrszYkY3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SZvH4qx9; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SZvH4qx9"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ee2d64423cso797073a34.2
        for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714402857; x=1715007657; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zs9gDn4gEwMrdg5ATdgVAkw08vBW0VJzGDrdK3qnGyI=;
        b=SZvH4qx9nFoadTP6JBZhfOO7AgbfOnL1zaJ1F74mLsFFG+WSfsaptc3zIDtcHqtrEt
         zW9XjzfkS1CBDkwnf8lUbstfy4G1SWYnrl7U9aDYBHlhGngHTlwhWXZ1dWl2ndqw1lKi
         lijhl+6HNjVcST1/BZwikuqdr0clj+vVr5HWSNBw02UyQKpCkBFAEuQM9s0o3dp3QzYl
         TCUtBQ+lwBDebOnPETzS2LTwCZDqDZ6LR5IuFsib7nUGdifMExJopsKFnLJlfKoXg19J
         saQ5bTB3HMgKC2TEk4uUCEE65XPoJARFmLYyh9DCsBTzIcGmWc7+NvaBIsgOCF9Qv3UO
         i4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714402857; x=1715007657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zs9gDn4gEwMrdg5ATdgVAkw08vBW0VJzGDrdK3qnGyI=;
        b=ssKLqN8eQmqdPYUSkdM2aZD0fgIJg6g+rCF7YvKJpw2LZ/Swm8fqqUSkRzkBZuo7Zb
         dXvnFKEInTCHPYCctnuIDJtshZBw2laMEOVOfdCRYfBRBgHbhBKmSCytIc5D0yqikCd+
         AAIxZSNCcSbwCxKWAVsjCQPCEcwr2OEkatWFrtbetZ3nb/TRs5yWjaQQgr8VxAFrY9ja
         uWkn0S1ch6aVBkdBPh/ZudyfqSeJobVl6wP/WT0j4Lbx4d0EU+RFPWQH5n6uiTzTZCLx
         AFR2Hkx+sOyp08HPdo1abexKu/CPI/SqoIZLn5gmH+Uwp8qzcIScW+EGJtVOF7OZ6PVO
         7nkA==
X-Forwarded-Encrypted: i=1; AJvYcCXe1FqNTRW+nbRhc8V+pk/xsi6o5ZzSVP9vAbZFh4f3+xmNp7hoIPr2JsSMjiagVsmJBpRrH0LC7yBOMRfE4pVy5Oyp8Sg=
X-Gm-Message-State: AOJu0YzTuY6zDMHINT3e95toBiZ7jVgemc6XcxoL8a1sYmnNNsbc0YKW
	ef6b9usQW4hXXk3/Y9dLbh0wf/21dE5qU/5uXGR1e12phnr/0dAUNFj3gQWKTpQ=
X-Google-Smtp-Source: AGHT+IHmbKK9Qyx4FAjBmnBgz0h7jK0zmwVhyAhO2G/acRzTXIKNs7HZYL8cXLLvumgIQCohXl67Tw==
X-Received: by 2002:a9d:7a58:0:b0:6ee:4081:2e7 with SMTP id z24-20020a9d7a58000000b006ee408102e7mr2008732otm.0.1714402857407;
        Mon, 29 Apr 2024 08:00:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id o15-20020a05620a0d4f00b0078ee090baa3sm10508476qkl.10.2024.04.29.08.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:00:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s1SUy-001XRE-DN;
	Mon, 29 Apr 2024 12:00:56 -0300
Date: Mon, 29 Apr 2024 12:00:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: will@kernel.org, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	liviu.dudau@arm.com, sudeep.holla@arm.com, joro@8bytes.org,
	robin.murphy@arm.com, nicolinc@nvidia.com, ketanp@nvidia.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] iommu/of: Support ats-supported device-tree property
Message-ID: <20240429150056.GP231144@ziepe.ca>
References: <20240429113938.192706-2-jean-philippe@linaro.org>
 <20240429113938.192706-4-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429113938.192706-4-jean-philippe@linaro.org>

On Mon, Apr 29, 2024 at 12:39:38PM +0100, Jean-Philippe Brucker wrote:
> Device-tree declares whether a PCI root-complex supports ATS by setting
> the "ats-supported" property. Copy this flag into device fwspec to let
> IOMMU drivers quickly check if they can enable ATS for a device.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Ketan Patil <ketanp@nvidia.com>
> ---
>  drivers/iommu/of_iommu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
