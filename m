Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9858415F15
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085839; cv=none; b=L6Y6xO2VH4Sje/e4ehPOALBpA6loAXEt1EmQmi/gCCxV7qt6/qTyVA1AmWZqjoyUFgR6NCLpHjCioMdmiTcI8xEvE63RhoNe7Prn1YoS5f+hKrdm3Eg3hqiouLUHzJ01lExsymd6PSjWXXVVxXeZBfxmZ+jmAB4J6a2a2qB5v6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085839; c=relaxed/simple;
	bh=OLr+uTnUVK7S9B5QUknUbFXuyG9qUE76WCenfq8svv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liCzFqYWyqMQXIhGk8/ux/3K5mdvtb1rSb0En4M7RUjAHIPSkCDQqSJo72KJ45/zKz7nbT21XdUxqKBtFOzOZamXGm0516ec9p7cQ5nHoT/rP9HAjCJ+YG4FpsH8Ko4KOef2tpCvvTxBsgCB/fn6OvtoLhtI66sE3IzfSJSJq2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EsgfNtYV; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EsgfNtYV"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93cb9e9405fso98505485a.2
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792085829; x=1792690629; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OLr+uTnUVK7S9B5QUknUbFXuyG9qUE76WCenfq8svv4=;
        b=EsgfNtYV+GSoPlnrFqOrBGmVhHix2R6QbQL1ylIYy5rnoCv6Fyr8C8e2LAJJRvq3Aq
         KP8j/x5GrjPs/2nlGBzQirxhpCFR2dsV1x8kb2ZFJlETTCiWvfLospiv7FjHIw1nc9Xn
         9sHNpDMGp0Y+0bSkT7ULOcQIzMrdqtOy7mi7SSDCUQTp3+MAplwHVbqxv/8d90uRGc7q
         X9nlPp7tG0cOevj4ROx6V3ilBtujiI6C5Wbp9d5fxZrIhnvnYbXBW7mN3xTbsvBPMM2s
         EP0qTDrxh/AfTQRmKIoBS1O0Xp/URxUNC5BcRYNVpqY73yO+tdUksecQnc2XB3617bkz
         j0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792085829; x=1792690629;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OLr+uTnUVK7S9B5QUknUbFXuyG9qUE76WCenfq8svv4=;
        b=klRdNAfzeEyZ0GkgGeIjBlsMFVz1oltilSgYSzEOil8AkJFEFt1yNb23+xh/ryVxTa
         DtQrsxmNCv+txoO3JN6gTiaq7IWsszNzB4EoeKhb+YhXF+LKNZ/jC5ZMjln4/fYg527k
         z1eROOuiHZWVUxCjuoAawkEAX+BC/JK6VC4kHqpLwHwb2CTckEprOinnZJ5Nhd4TVcGX
         0KLnl9D1USVO7Qukc6Hc7mebk9V0fJPICEO53na6FhLwvEd/BvR6ur32kHtqcy3V1PEY
         e2dTMaSlxNCGN0wRK2Z/HI9f4r+vjIlCWqD1UJrtnsb/D2lcMUFc1AtSUytBYKdBDeXz
         r64Q==
X-Forwarded-Encrypted: i=1; AKwUvBxuJMjgQ8ee1bbjUlP5efPzAV3qT+jaPX8Q6Luc+ZJ5kejblD0yfnMnFHGcbPbO7dnEB4EKLg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLAxZ9VSRFezUTn3vpylB0/rkFxF7d+TqJ8JhlKJsMu8N87Lhfm
	gEKlWu4zTBJDB4VTlvo3hKoYp49fUsn2XDOFshDzzbaLo86qWBbpvIsIygA+7nCvu1g2NkBlONw
	+HKLv
X-Gm-Gg: AYBFou082P3b+DMSW8Gryo2m/Qop1TO1ElgmYt/UneW7lLHEAjBdWKs9+kNBcfBjCYn
	cMbWWQF4TTqJU7OR45K95QbWtp9G4+LubzT8l9hmqD3y2uts6r7lb+oNnauvrA4lI+7e+ZeFSa3
	C2qKGRj5hiRCwv4uNBNqoZroBxObQtWp5ShEBLg8BdzsZ4VWSu4N+gchHeldVqPkHe0EpORw14g
	pxSSPgxaZOgcktob/REOYIuKN602wY0ch/pXtP55OIxX5et+4qz2b4PMsm84WOMrcybxxZ2GR37
	Ac+Kdm83RA3/caHMPHd97Owa8dkOL9MBhWf7suyAD3506pl3x0UCAYD/8TWor6cnqBI5h7u+63G
	cNQ8/DRQWU3i5p6K9kpNqwxhZNh8rRCUMRmuhZAQX/0x8BGaZfRC4CD1gueTZcFPq9Eztg6v+xR
	0aGwah18bux8ACuRsX1W5jDb88JOftDjeiNvyw5EWUo1PyS806gqzHZGtanhNxvCVQWVqwPEsmN
	fedYlos4tnGW1tRO3uTo4y2DRr/5DMuxdXTJZDZl2nT/V9tshjKoSl7
X-Received: by 2002:a05:620a:469e:b0:93e:c12c:fbce with SMTP id af79cd13be357-93ec12d06a0mr3209910285a.74.1792085829213;
        Thu, 15 Oct 2026 10:37:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5086fe3sm818646485a.37.2026.10.15.10.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:37:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHPO7-0000000H6B3-44RG;
	Thu, 15 Oct 2026 14:37:07 -0300
Date: Thu, 15 Oct 2026 14:37:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
Message-ID: <20261015173707.GV14213@ziepe.ca>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
 <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050>

On Thu, Oct 15, 2026 at 04:31:31PM +0800, Xu Yilun wrote:

> An alternative could be, bringing up one IOMMU when an associated
> device requests link encryption. Then a no-tdx-support iommu fails the
> encryption request naturally.

That is what ARM is planning to do. I think it is reasonable to
trigger creation of the secure iommu when the TSM is connected to TDX.

Fail connect if the iommu could not be created.

Jason
