Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9351D9A5F
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 01:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524334; cv=none; b=CdDldONQH4n4WlW/zQG29oj4kSmrMxkQV9kNt9ni6IPga1SlVC5P3DXcOBMpnlzA0qPvxnZNwlMnsHO1FloJaRqbdqBPArQQTjbJG2yqzQuueEbayAL8VCqZ3NDmZf8dpjxJha50Ds2b9ZaJ861HA50jhVe1Qqsf3WlvTn2cm7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524334; c=relaxed/simple;
	bh=T63k1uJxSq+Df7WJDfeXbmrwdzhkKi+FAbSdKxJ5VGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErOXofUdfj+p3SpBOlKYwV5lEPWX4rgkgr0gLT3G3nwDAt4I4zcyMDUC+pDRFDP+AxklRu1C3K2B893GKXjW6tkKFZLC2juqmph00qWBAvexBPYLgPCPGAb92pHCIvfiLZeqGNdEy3JI7wR1Y9bDH/VYYPH0yplcSfwI2L2qCnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OEAM14Zo; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OEAM14Zo"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89cc797547fso55416696d6.2
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 18:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775524331; x=1776129131; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xaTS/cjbwD199MSee68/inAfCQq7y2tm4S22SDQ6gKc=;
        b=OEAM14ZoA1uITzlBsm3A+UaPqGPhguuLW09cbhK51C0RVqOjdLk/m9lMpIWZqHS+QF
         yxZeDZFTGLo82joHH47jydKjjrfL/lhZEzRlEmIEraHeXmmeSasMf+GEcIt5LD5F5mlz
         tArsMN6b4bOElEwRhen4G774A4ejfbTlpFA8RkytPnRTA9f/VgZqWAwEHBmXhD3LDC4G
         R1IzW1cXGT5U52SnfNXzR4DLo5y3kzbJo5uTYMZVzf4P6md56UVkmzk0j4dl+VaSTxZH
         MZmC2zI3zM2+4SclGBfY82m76Ta01ggByxSJAmZFC++cWvVHr5UBau0Yb0qa7/6dp41e
         TSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775524331; x=1776129131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaTS/cjbwD199MSee68/inAfCQq7y2tm4S22SDQ6gKc=;
        b=Aip1jK1zumQ3QVu1NGs1L+2aodImpI6dmeI2Itk1jyincYsZPqqXzOqOLnhFFtkUR6
         UJT1Lenk5Jc0WI5UEkZnou4fi+8yiJifkYoyUf7y5huNjsNFxYQrYxsJ1rN7f8z5KhM0
         PVUVGgPKqMcyy4S+l6Zd4S+utLr5jPVJYX/wz5o95RvG0v1UupcaU5GQaiRO7Wdzkvpd
         kwwKWr7ILoJfnn865wsaOaLohzTG7Vpz+5NyajwI3+AaeBzPE8g8wcGi436aATMzTlh9
         Nd1u2q5J/8rOK6v4TQUZrviEFJPtrw3XqwbnKjCZKum/gf3ebhjM5LsifJw+erYQH3FS
         kdyg==
X-Forwarded-Encrypted: i=1; AJvYcCUes7rnakieVTQvoFFlCae56MF/X07TjaTeTDulWTAlbjEbf+1101Ot82PJskJ4fkjeYcv76Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1T6ZIXAyc3cGzjZNu4jd8mS84dFovIDlxp0rcugJkoovQHRxz
	MC2f1eDPUFXquMCz8xEjpLh6XfH9WCjMtpB3eqdh9lovQXwWNub613pwyd1S4e11z7g=
X-Gm-Gg: AeBDieuJ32tNWrWsPuBfVy9pXVItGRSu5dJ3+WlFAJKNJc75yM+ikTM0MJ99dHfSedy
	gYcPyoVmq2LhU9i38Escfe7U/F/4lBe7ukSBludgmIjHQh6lDkoKrXZkkpxtS+Ljc4ZUGWrEv73
	o4OgvmlO0R9E32GECPQItQTxIoC/BWo6qF5xLZcQelIuLVzMQm9gwYOCbfaBjjZuN6A1s+0fAMs
	Xvllak7U3CKC3QMLWTE5dl3kxT2V29b3qJoKnO7yErwZRVoP8gdGAjJpnbNAvIPURv7w39SK89C
	+irPYd6hQqIT/V4YgsMHBDLmhxRo+nkGhxst5JbK74Pae9G6jgkKHWxgIlX/8fv6Z27wfvKbZZy
	bKn6Y4UDgDeUIve7155AS3R5MsfIb33ORonhOGASqeZ2L0iUBZiz8k92q43k7XNAzYDY889yOc7
	l5+T1wXX0K7XbJpPuEMAjwnyLN1602Cqtrhx+uqPTwKQRN4p1OfcHLH43f7cE5niBFvp1QEfaW2
	0/phFh0
X-Received: by 2002:a05:6214:518e:b0:8aa:6dee:4b93 with SMTP id 6a1803df08f44-8aa6dee68e7mr101997526d6.16.1775524331555;
        Mon, 06 Apr 2026 18:12:11 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593908b47sm160088906d6.11.2026.04.06.18.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 18:12:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w9uzC-0000000EA12-1dZT;
	Mon, 06 Apr 2026 22:12:10 -0300
Date: Mon, 6 Apr 2026 22:12:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sina Hassani <sina@openai.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Aaron Wisner <awiz@openai.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Fixes a race in iopt_unmap_iova_range
Message-ID: <20260407011210.GM2551565@ziepe.ca>
References: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>

On Mon, Apr 06, 2026 at 04:07:01PM -0700, Sina Hassani wrote:

> io_pagetable *iopt, unsigned long start,
>                 unmapped_bytes += area_last - area_first + 1;
> 
>                 down_write(&iopt->iova_rwsem);
> +
> +               /* Do not reconsider things already unmapped in case of
> +                * concurrent allocation */
> +               start = area_last + 1;

area_last can be ULONG_MAX so this literally overflows to 0. It is why
I formed the suggestion I gave as I did

Jason
