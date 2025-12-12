Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057B7283FF1
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 06:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765521611; cv=none; b=s5k6BNVQ+Q8ZsU0uCSbHd9b6rMGyeJMV/E6Pn1XFOAsrmpHITwDwdBNk0JjacF+VWn3uUSBm7B5emu4N02vL+DSfJ8swhxthGqTDiT7nvLnvi0W2e+r77uF6qqBAaLuR+LENKhKMiG8yq+vY/4+hlv5oHlfkLDAwa3CUAya+Ujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765521611; c=relaxed/simple;
	bh=/lzw2EkpraHtItx0uRIBlL+3LUqcArpC25Y7u4No+Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c85HYhqsFzGhJe68OKxX4irmHEpVLBnmg66nH26TVCxT9Thv3RowPntLr07iy+hGh3o3BVl5Fi6p0MFRfAL2syQKpDthKBMhw7a1XWeqqAFNCud6tkXMBvrB3C9p91oqPGWeiengt5G5hsSyGoIGU9rVe5hAQs9S4na/A8EU6zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=J+aZXgdE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="J+aZXgdE"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2956d816c10so10901365ad.1
        for <iommu@lists.linux.dev>; Thu, 11 Dec 2025 22:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1765521609; x=1766126409; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tFYcbK7L/fuI/GrrBDZKfrYBdADfjZp9qLIva811S+E=;
        b=J+aZXgdElCMCBItGc6UAK0XkF0Rfw+bXFhIlOmCKCjCnOJ6II1RuZwJLX5Sw0Pxnpd
         gs1C0LADJ6DuPeOisGMJN4wFn3KdKwpkzJchRu23Ohgiwy7r6z1FHLkPMwva/ZzTW5Ek
         cy9Dy4mR01yR+LJ5MPvM/TdonkigsXk0nl5Afk/3A67LKNt8eyeubNp/AdqINWqoZJDO
         X79Ur94k1oJGCj/EiITPIIl1+Cz15ZfvMWttrhzgwCLKN1t9hlU4M9WRcvOHnsoLjz1d
         f2RJQm2Q1KxOCucHkSOPs6GSn+O8qj3dDxG3fKEXn9/gII8BYtHy5s1fWKYVr7yQNNuk
         Y4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765521609; x=1766126409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFYcbK7L/fuI/GrrBDZKfrYBdADfjZp9qLIva811S+E=;
        b=eFr0UnW3kpcWlBV51LCOpCgy6kB/5S2B8/C9HAfLzqjE78qYfN2V/z16judCr14j8N
         lzKW0p1BBQgs8M6VfAORchuVauyzsq4giB0BnxN3lH0+1HaNcCCOBW9vyqMZijMVuO3U
         ZhLsRMpQaylmTcylF/1jbkthoJl6uDMUnTu5xT3vES85M4JMJCltEhX8vmmhYUA438UP
         FAEzT0g9tp5aFILPjx8+ZFp3z/lfXnRb1zZsEKX5siyK/6ebidXCSQNJbybcbx3R19t0
         AeRTyArwWinH7FduK24l4forwXaT2SmE8rhXizTzUGZqmSM5n9VFBROHarPtg23yySFc
         gYbw==
X-Forwarded-Encrypted: i=1; AJvYcCW7diG24A1fNV0hjLiJqLs7rbW+/vwAORDWbNF/nTDW/DzGKklkJR3HYajhskKmgLvKad245Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhOIoHHucFRMjz2iv82A1dgFm2ygwWsnMyFpLQDo+n0S78wbRB
	t+Vn0R48vW41xzdi+ojRzbvmPiHIh3MZSrfP3Fl6vyjw1yJMt6FMyG3hQaMVSXunTpw=
X-Gm-Gg: AY/fxX4IfbzvMMadkjFWwt2rpMyGScRg/Qrk76VKiWhw3o/V88Hli0VsFQWjei3PDcN
	Tv2feyPcZ2F0CBXukOLL3MUaDLGeRjiqxEYsVcbelFvePnykxPeUdQrON31UaoVJZty39RdpkQU
	yq120tjav58skX94imebQooJ6dc6XRMPhDWvOB/6eVP0w2IVFGERagkI/gtB+FG94Rpz4UXrl+G
	Vy8cWF/Gl2CloU2cvoLJZyCBwmnf1r9JE+thTDYNACYjRVZZ1lQBu1qs7JO0WrEaFu+IkT2J31i
	sLNB1H1sSRFAeO10E1ecEOg5sZTG73EHygWljudp0EaLvxUaVtxc8QTI/w5HNdzlLFxTwNMnYEw
	u0Se4J4V64Jf110T3C8OPrHwPZTZnSGZrn5MB3nXneWYsx2sjmcN9W4LW5lHsgRWgMx5PdUJ6PB
	MDtsRtWTSy
X-Google-Smtp-Source: AGHT+IEPSya2f7Y38TleFBqEbmC5+occ+9/MQpEFnHQbgbfijsnQIDud3+WhbafaLoWO/lNjTfvRdg==
X-Received: by 2002:a17:902:d508:b0:295:4d62:61a9 with SMTP id d9443c01a7336-29f23c677d7mr12001705ad.38.1765521609158;
        Thu, 11 Dec 2025 22:40:09 -0800 (PST)
Received: from ziepe.ca (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d38adcsm43786595ad.30.2025.12.11.22.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 22:40:08 -0800 (PST)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1vTwow-0001v7-37;
	Fri, 12 Dec 2025 02:40:06 -0400
Date: Fri, 12 Dec 2025 02:40:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Allow stream ID sharing for
 devices behind PCIe-to-PCI bridges
Message-ID: <aTu4xsAApNupRGYC@ziepe.ca>
References: <20251211133933.4128100-1-nirmoyd@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211133933.4128100-1-nirmoyd@nvidia.com>

On Thu, Dec 11, 2025 at 05:39:33AM -0800, Nirmoy Das wrote:
> ASPEED BMC controllers have VGA and USB functions behind a PCIe-to-PCI
> bridge that causes them to share the same stream ID:
> 
>   \-[0005:e0]---00.0-[e1-e2]----00.0-[e2]--+-00.0  ASPEED Graphics Family
>                                            \-02.0  ASPEED USB Controller
> 
> Both devices get stream ID(0x5e200) due to bridge aliasing. Currently this
> USB controller gets rejected with "Aliasing StreamID unsupported", causing
> USB timeout errors. Allow stream ID sharing when both devices are on
> the same bus behind a PCIe-to-PCI bridge to fix this issue.

I don't think this is right, if you actually need stream ID sharing
then I seem to recall the driver needs more changes. We don't want
this in general.

IMHO ASPEED has wrong PCI config space and there isn't any actual PCI
bus here that would force RID aliasing to worry about. I suggest going
to ASPEED to find out and confirm that they don't actually share the
RIDs and then let's quirk the PCI devices to disable alias generation
in the first place.

Also, complain to them to fix their config space to report a PCIe bridge
type in future devices. :)

Jason
