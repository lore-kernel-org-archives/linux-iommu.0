Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26724322B72
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778852000; cv=none; b=Hhvt0Hnl47dX+EExnTIRcw5fffsrnkj6gs9+Z8J6K5ZxS/xLN7sana57j2eDmXB3rRGSgi1Y6aIMvzcJWZEVYei2wZCNRCbZ4JxTm5+ybFV1Y9R5RNeSZheCTz9uA4DvmXCYubwVPsxc6aFBwEjHkmo2Fc7jRTUiU2ko1ObOi80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778852000; c=relaxed/simple;
	bh=3TBAhU6hGBxpskdX1Eg3IPTIlGQxreDR2zG0IrhXS+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2U6bIfJOUJCEhqQHzwxbpOcTMHeQ2IGu+5EYaux74cCJ/B88+Mp/L7zJlI2xjufCp3d7SrP/HLH8D35EL+fqAc7MC8zHTi8hj3/QAS6oH8UjldMho4MFG2gNbYL2ASfX/vSG9zy7ALycf6JFzbhMiY+24m/wL1a8Nj24ZkAs64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=faKqKLc7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="faKqKLc7"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51306c36c3eso86368611cf.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 06:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778851995; x=1779456795; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kMBTbyF/T6Vu//EwZXm52sbAHBRdnqX86jxiszQbrCA=;
        b=faKqKLc7xRD6ku+eM029HSUeAyrNchE5ArIBzUSQyIIO+hzeJ0Y9S++caHgbXs2MGM
         gluwGkMlisqdp1akQmsK9ZmvWH6yxLJ6793twkKOWYRbCUc/gBCqe+mx1aAGWsORTxxM
         bhdDtaB3SglsGOldm1J/TknomMAlStzx1AUrySegUBK9BCIfMelJv2bbFMq3uPiyZI2X
         8riIJR5Ht2p2xt54ulJJ9PLeA8Zmb5c7oKGph0RHFJ0+1TUnhbYforNnrcyB55NPCHqN
         SQyfZFV+LeFZkEvDS54wIP5r5IZzHeHNpsDSTrEL4fHk/DcNkh708/x7ERIXUEgV08Hp
         hvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778851995; x=1779456795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMBTbyF/T6Vu//EwZXm52sbAHBRdnqX86jxiszQbrCA=;
        b=b476RD50M6+nizMu0GzaabCs1dF4XqIcpEuPVZfJCp3Fjni5VdUFpgUPseQJV+1fUQ
         trM3zXLudoE/hDmxSzN0ZlV9IPty0bbbV0S61uuTtABopi6XvYps9iz+/3YQLrEy2DuT
         GzsPKRjBbM5gDzBqXJ6mJR0prXC675eqJw9rV7spxDDqGYgOsvvdxtpAbVptBKV8s23w
         2rlmTHMlhPDfgGp1qsTLyU//SmicZ3PegD0/X4556c4YMfUgWfhWi9+WCcbqACCG3fKU
         swoIvKJRN1UZYUDsu9opyj9b5dK4OTWKGzNq1ehBu1VQQ+NiGPL5EDq5pPGILAkiLxV0
         2xSw==
X-Gm-Message-State: AOJu0YyD9ZZ6RRt8dxzbNRiIqfmk4WEW/e6aczbnMm/c6haaO0ecVz8b
	L5NFB7D2o99JDdlFsU6ovCYUVJtRNWsR1mnK3AFs82dvOCNY4WRYy9FVKHOgFll5LcE=
X-Gm-Gg: Acq92OEU6DdWRERpcy4jpb8SfP8EyTBHmcsuil1dmJAQCNTNzzPCRW6S0NjfV3lKnnM
	wUHQEJxnEZWD8RNhQi0U2AaKvHhIufmYjQHSQQIxnXexaS9cT2GVaIU3WmHCvggvxrG2sYzIzT1
	QwV7Zb7I5fnb4WxeguTL6iOZ5JI3sFvw3JuJWy9ATN8CRRuakBH4DcB6IM7BAdw0+rLnNeBLbzU
	L+Lq2ycJURq1bhz/+0IQkjB9MPdZBNFRXjNrjyDIFkJW3eMR/ljnLFYlazJ8zum0SzOE/TS3Cy5
	Nkhx2a06lol1Zu6hMB3gu04Tvbo+nPP7UNpdJqVGUpjNGG41zHq1CSCJPxOnACeuTnBexpL2pRj
	WFm56EBH0EeIHCfZl3i0hUtaBP+OWz5PlLrdCwadu7pAFCWNVKXHnGwIAfUez/YQxdncl1WYlGu
	tZDXw2xOUq4ej2OdVoVsNMKQOjOhsV/yGkZ2QLX5XT4zO4p+/S4sAI+I+O+bE9rCmObcHHgR5nH
	x/PVuYJtHLwcGQn
X-Received: by 2002:a05:622a:5408:b0:50e:6183:beea with SMTP id d75a77b69052e-5165a0df42fmr56075141cf.23.1778851995075;
        Fri, 15 May 2026 06:33:15 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164568a275sm44172361cf.5.2026.05.15.06.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:33:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNsfB-00000007Q3c-3bJa;
	Fri, 15 May 2026 10:33:13 -0300
Date: Fri, 15 May 2026 10:33:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org
Subject: Re: [PATCH 3/3] iommu/io-pgtable-arm: Use address conversion
 consistently
Message-ID: <20260515133313.GE7702@ziepe.ca>
References: <20260513215203.3852661-1-smostafa@google.com>
 <20260513215203.3852661-4-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513215203.3852661-4-smostafa@google.com>

On Wed, May 13, 2026 at 09:52:03PM +0000, Mostafa Saleh wrote:
> Use consistent address conversions in the driver:
> - virt_to_phys(): For all virtual to physical address conversion,
>   convert __pa users as we don’t need to rely on it type casting.
> - phys_to_virt(): For all physical to virtual address conversion,
>   similarly, convert __va users.
> 
> That changes nothing at all. However, it will be useful when
> compiling this file for the KVM hypervisor as it can cleanly
> replace virt_to_phys/phys_to_virt
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
