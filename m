Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF591261B9B
	for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348420; cv=none; b=Ugys/LTnVZ3KFd7Xgr7sISs9I7ocYAuVEjZ8+ZSrXtfjVlUgtaVsh9PxApD0kD+4pv/nBbkFxoWNvoS6r1fK3oVo/2VTaadOoFrZetx/nCYGIZdq64HZr/zqe4o6cJYomFjbyhWmGGOBipgOFFoTagR8Tc6p28kWiERRyRV8CRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348420; c=relaxed/simple;
	bh=WX4pc9BQeZW3s5krELSMAl7NSmtfwDPPbwwaGWHKB0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlJAiyROwTACyEenAjTi29UsMVt/+eiJApBp5QIDSIcXxPkUIZo9k7/x2jv/5XOwQr9IacCJaue8x+Y0Zdd6OdCeYSwO1X19ohgVt6PFxwOsVRl3japw9d7Pzu9y9VitKcNz363ETmjIlKCTPn+8UKeoUqGrTD5sNT46cSvrRSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=a5ii2/uT; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="a5ii2/uT"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b29ff9d18cso185366585a.3
        for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 08:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1764348417; x=1764953217; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WyDxOQ8Lw5prQGezJfzgyKDZ5+VnUcEleF9/ih+sij8=;
        b=a5ii2/uTFeh/03May8Y/XQYhHflaXJfDqQIs4b9SL/abSXtcUKrFKAyXElj9pF3mBY
         RXiYrOXuSCcldKY19VCRW2Fi/uv/M/vI6kw3lg/NyzGfjyCD6cotaMDyd27nQSpJF7sT
         Wrm+01PvdsnRaZkRt83+9DblpIiAz4L4nJk+Wq34/P3ElGZYPZvOJKiKXxLkemhrXKHx
         dfwdikuAnfJBXGW3/viKx+9D8bXu8iwdENkWqpqmFAqjlaX4pCu/Vj7hr5ccDj4f+951
         IdKHru8TAdJpr3NR8kZ4WWXe9bW8l9qS/78Lk6Xfo1DyOjhrl1h5occt99bmP8U2BDI/
         OgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764348417; x=1764953217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyDxOQ8Lw5prQGezJfzgyKDZ5+VnUcEleF9/ih+sij8=;
        b=N7xrGLYViDoh1+NvE9Z+SdVEVinhrMXJERLwck33nGz2DOkpilTuVsRn4WBv8LOamI
         dNleg6T1Y6FHo8fY0HHslt4WU6K2Qzdg6A/5M3yDvziExiySUzC1MGkM5qZR+63NQfsQ
         qqlfpjuNyrh+AyYTQlBLoVG2pWgZH5mktdpbzKHubB3fkwignI2DN+BFJ61eWeR84x1E
         aAKDB3HllHrkR3vt70G0RE2nwbpzYqHSuA1NQEkSaH9CH6oOljjDOJuHPoHEonzjhUtf
         42ZGZldNXNRdPkpYBTRbhdmn6P4vahV/HDRkZeTf05vDndVkYIbkQ0n5hxtkGtqtT3WF
         SdFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb1Wg5RIHOSJ5dSdMIFXJOMiDV04CdU7Fqc1WRJuuTAXBfXu+eTz22QZ35N+Q+sL3G3Z16Rg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzT+Aq2bPy/JmLwBwKsIC0O9kToH8OJeoQPk96wJGXLzuAmSeQs
	k2oZoBSwu8uUY9QZTvgO945mH3/B5mkOQ2BgesF1HQ8xCXeO2QuhPq+CEKec62XsmHM=
X-Gm-Gg: ASbGncuw4uHsTvL/wcp7fhl+2g0HnM5hGLmaF5PcicAyXCP8Aq4djyyQ4nxRWpIRxUC
	/1//8GUjYeDpkyqC7blH58N29Ot4O/op3tZyr4geA6Gbzhnh/gldq4Yzfwss4PCya5pgNA71K+4
	t0HgZ42jAL9uVsccuag5/ALkkZwLM19Wv3H8kdvGXuClxvnWKkYd+Ea+q5ZJ7id/SZpLCZiizvJ
	VVzbudr4MaX+34sjU4Ip8Qec4KQkLYiY3lLQ9Z0EIzgNhjHHm2NmY37FnVG0JUyzE02AGE7Lstc
	utcQJ4xUMesoQrsf1Drvcvj6Jt35+XXB940L1XhUfcLQoiIsb9mzSeFKabVgVDvP2ifU2OM9OWF
	9CyzKBkqfi1uVB7opNWEhuKeYs6+TCtpdPaCojAwf3cTIIZ+/xFTCcch3MJjXU6wqr4jJ1BC91m
	Lq/qzLV9QiteldWP5LDrUyjtNZnr82Fcs0Q04r7cdksvVRaeWZNnf/NcmVV5TqoQYVhWA=
X-Google-Smtp-Source: AGHT+IEp5YYm0eW3jhapM8OVullA+b9CRrzLXKAGXQfH68FS3XEeNccrfEDUvP/XIE+WOdxNSzgv+g==
X-Received: by 2002:a05:620a:4694:b0:8b2:e986:26ff with SMTP id af79cd13be357-8b33d469db8mr3847315685a.66.1764348416499;
        Fri, 28 Nov 2025 08:46:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1b6591sm338772785a.30.2025.11.28.08.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:46:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vP1cV-00000003Pw0-0IzM;
	Fri, 28 Nov 2025 12:46:55 -0400
Date: Fri, 28 Nov 2025 12:46:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	praan@google.com, danielmentz@google.com, mark.rutland@arm.com,
	qperret@google.com, tabba@google.com
Subject: Re: [PATCH v5 05/27] iommu/arm-smmu-v3: Split code with hyp
Message-ID: <20251128164655.GB812105@ziepe.ca>
References: <20251117184815.1027271-1-smostafa@google.com>
 <20251117184815.1027271-6-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117184815.1027271-6-smostafa@google.com>

On Mon, Nov 17, 2025 at 06:47:52PM +0000, Mostafa Saleh wrote:
> The KVM SMMUv3 driver would re-use some of the cmdq code inside
> the hypervisor, move these functions to a new common c file that
> is shared between the host kernel and the hypervisor.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/Makefile        |   2 +-
>  .../arm/arm-smmu-v3/arm-smmu-v3-common-lib.c  | 114 +++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 161 ------------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  61 +++++++

I would think these inlines should go in some -common.h instead of
arm-smmu-v3.h for better clarity, and ideally pkvm stuff does not
include arm-smmu-v3.h at all?

Jason
