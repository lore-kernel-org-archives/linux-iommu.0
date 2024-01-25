Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD2A74E36
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198024; cv=none; b=a8C60nWpCkVfgonHRRGvqWS1y5jmy2Cd1zYhFavrYIP0NfE9+v3ULs0OXgc9ZpqxmvtJsN/AgD3X13cvpl7shwm2BC1/o4QRVaA6DSZCwK0rK2SdZCOR+rRlgidVbBiQXFFbe0i16pzzIxEUF3QAwADtzG8KlBjKHe9KYKHLly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198024; c=relaxed/simple;
	bh=TabZwQ0sIJD3zmBvYOv3jm9/5vRfTCsazrZ1Sp6vgXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ode/kj/Pf80VhERMIMsgehZD+xpFsl02ik0RtVKvO9/sXKEPgxcxP9yYDxVRdnaOQ68yp9eq7Q6C5KWJ5v7IcOgam1yvlgHbExA8YOPReU/kKPMAQKNssTvY+qbbRE6hyaiwP47jVyuipC2X6iGOne+3fBIfTiZ81ZSax6ElDIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mizE6h1L; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mizE6h1L"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so4544114b6e.2
        for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 07:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706198022; x=1706802822; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Gm8YcRmtBnHpG5joLEjpJ5CY8ySvBOTiRVNyzJNjsQ=;
        b=mizE6h1LcKrwiJ4EcP6+rNJ6cJDCcf10t7aUj+CUBuy0MgDBN/jGJ+YFJjX0AvZek5
         tdD1YvukFez1JQyG+orCyIZRXXaaMgWUhtl9u3V9Y5pPcXq8+A+aONCVWm9CQ8A0L+Qn
         DVJ1zTRWZbHhB9e8Zm6ylZR/5twr8d+H2pPyMFrekPS68Pksv/Ez37th23/7sehG8th+
         1kq7VdbKDAVDk+1lWfurriD5xvf0OM0YE88XmZQGc7wJRp1OjUs4p6UmNqHhX2qcBixL
         XQat0koYgofrhB37waORE6+gyIKkKA+TNyyUK9wgXg3J9VZzIz7L5jitcJAX+r+kel/i
         HSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706198022; x=1706802822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Gm8YcRmtBnHpG5joLEjpJ5CY8ySvBOTiRVNyzJNjsQ=;
        b=Yzlks1PDwqfGm71WVUefjzVNQt8N6FNa2NJczxCVSoXH4GcF9yYBSkEGz7ZR4AT67H
         0th7W2B4M3vXbZkyqY+ECVuIMDY+stBH0keWKJmA1q2kF0mSvfIM9OyquzRORGsxd10f
         FqjnGfxTzZD81ASe8bQRjn8TWOrHo9QVJLpJirMWrWbncxVj2HL7w9oN2J5rlpwzau9L
         /rKfwxRtofh6Xm+chFcyt9fMgOb4VppTT5PkF1GvYMqlv14cm6CZCiMhTy+G5ywq0lcq
         5djiL92A5WuRBPD3UmVoZHXsedc+LQoHrzfkUNgAmsa4ZdPyw/sG6D1LzqxOReV7N4aa
         8+0Q==
X-Gm-Message-State: AOJu0YxSSGpACzcA3NOu3vz8f+DMFlF6/wNz9EX4dyGGhGWmGlt8mRF1
	mUE57pOkVW2u0CksLPwJWpFzFDzPlbrAVHvQkrg0AHcCuA8BpglnwhzzbtPnG1w=
X-Google-Smtp-Source: AGHT+IG1S9mF7KNH0OEVjd0X02+LAFTBulsVL1p3DmxwCsHxZH6wfNZ+CnfLhyQ9dnRobzDH1HboEg==
X-Received: by 2002:a05:6808:158f:b0:3bd:df11:62d7 with SMTP id t15-20020a056808158f00b003bddf1162d7mr627364oiw.13.1706198021783;
        Thu, 25 Jan 2024 07:53:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id z11-20020a05622a124b00b0042a64e81e5dsm1184016qtx.57.2024.01.25.07.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:53:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rT22u-0091s7-Ik;
	Thu, 25 Jan 2024 11:53:40 -0400
Date: Thu, 25 Jan 2024 11:53:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 14/17] iommu/amd: Refactor GCR3 table helper functions
Message-ID: <20240125155340.GY50608@ziepe.ca>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
 <20240116165335.6043-15-vasant.hegde@amd.com>
 <20240119195907.GN50608@ziepe.ca>
 <e8f2c380-acb9-bafa-c2b5-5445c0f06a4e@amd.com>
 <20240122182607.GP50608@ziepe.ca>
 <c60ed34e-063a-b9fb-9255-365d3662f076@amd.com>
 <20240125014605.GV50608@ziepe.ca>
 <ada10028-ed0e-fc6d-be9b-e649de16abcf@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada10028-ed0e-fc6d-be9b-e649de16abcf@amd.com>

On Thu, Jan 25, 2024 at 05:41:29PM +0530, Vasant Hegde wrote:

> > I'm not saying you should do that, I'm actively saying you should not
> > do that! All paths should be symmetric.
> 
> I still think its not a good thing to do domain allocation inside
> setup_gcr3_table(). Anyway I have changed it in v6.

Well, we can find out later if you have to change it and then we can
understand why it is not a good thing :)

Jason
