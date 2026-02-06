Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC0238D27
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 00:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770338607; cv=none; b=KWzl+jLJjyFNweADtFx5Uko2pAQG2QFQ+Nnt+oJB8487SWlatVi7wAErq+Sl9MM0Eg86Kb66Uul5kThittcGEeKb1RovEtUA2h5nAJAbKGaG0X2atTrZMu8g1EQQSKFLGYQ7J1PlbPBPQgqupFI7IRpkEcD1Keq01ECXPT4q2Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770338607; c=relaxed/simple;
	bh=wP2wJ4Peje13tQ+dX5JV8k8WR+XuFtICLvRq3t64aCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJG09pg/9Vh1pTZRE6D1PZ3FJjWAYqy7RaFfw8IASVlYs84UVXDQDpyRyisl0/8XLjlKHblzxr9+8R/3FC5cEvpD4ZpKa8eXDjAg0cPTjQLSiev26oxeN+cQkUSxh+s+Yx9f0ohuNttA1LQyrf3g2fZQEfk5fcKglCn5UkoloKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ohFRWi0F; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ohFRWi0F"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506362ac5f7so1504761cf.1
        for <iommu@lists.linux.dev>; Thu, 05 Feb 2026 16:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770338606; x=1770943406; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uha6Xzj/9DIc/gHRHtkT3Z8tZYXd7dAwhOd20ha2Sqk=;
        b=ohFRWi0F61xW8lVQzkwALZzdvV21kanBAjZMPzq1IEHV3loyU7MK0jBQPn2tSlvW6K
         maJYqhMOGXlyPSrImO+TjtckF8Z0LkS99uMphN8ClWOuLHWztcLtoeEl2eV2hK2KhEB7
         WkVYfeBqYKod7AGjpIUahbf2silT3ZIrKa9GkRNxuLQBkA2DqY/UvrSeVmet5E51LRkh
         wNHAFZWXQCSeKBaZftAF/sIReWTAY/BX1oFHT/N4kci35x2yrVxOR3M6Wg5vfr8uYyL7
         TXJHFWgG8mqEvoHy5oaVIpnZ2Rw78vSHFM1XG3MM3Ui9pitqV/OpBqusib0wn96LASPt
         PVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770338606; x=1770943406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uha6Xzj/9DIc/gHRHtkT3Z8tZYXd7dAwhOd20ha2Sqk=;
        b=i0Mwy3qJTUpzYD14QmPhI3qhcxEOg+wmgHHp9Wsp+JsXy1AIic+igOcnpYAPWS6S41
         LcktM6Cp4Xw1zit0XedG1+c2AXWv8UnB6l3xIcyyhrnYn69iMlIKy0/IMVakEu/QJ33D
         cAeOcDKEz7x4kDttFXTY9+WBusnpBTKf6IBKJPfmTHsZEbGdmdA8ZbFPsHxkSTOS+45v
         zGk56m8XaImiMhFchMVuV2NNv0SkK5H0LglxVEd1l9WmddDtK/HGHkFczg/QDRMM6Pyj
         0sdYiprsir4vJ7usX0yv4GfNZnC5tqZEDAnULurCe63Rx5eAps5CocFfxBAxYWFuEe1P
         +G4w==
X-Forwarded-Encrypted: i=1; AJvYcCVCA38a8zcBiRH9i7UP7Ea4VUVH8wmN1uv8NCe8BtdDAJIgISJAV2nlCTS8AbqGPSwXUd7Rbw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxleVqHChPAPq/ip1ylvptm3gS+hSuHT1yspq9aktP8asYZWA3t
	onTaR0oiDhol3w1OpfmpAWqLDg++pzlorcl+XTaVsyGhXPLgT5vFOl/2GY0dTtbmCYYoDII/foB
	sr/xe
X-Gm-Gg: AZuq6aLs1CoYW4Wzt5oBwr6UL8PjqN7+t9dB+aOWdV3UMijEBtexAffFeWTivuEhHuZ
	nViK/cdsCyNfSUP0SY+Pm/oY7XDeNBuQXD/zhLPz/fk7RFGpnoyRsa78mdcpYJ0lUpBnjMHNbAV
	7kz6mJ9bTAT8FaenmDqtjaT177CwLIJC9/9HwkvsxLh7oUDaM0ZGb1UEbUoQ4BzhFAKv3X2BcVS
	1/LnHAYLTBtGtN16cfWotWgl4GfUGv0PLhEjM62DTXlCzRFHNeQW+pd+ruy8pxWml+wUWIe6Qlp
	+d4n5u6qUuq/caIrtfTnPoeytbscF27Y3rqNiksaLDwFaRwReZJ3kI7BV/i1Y2FILvAlqo3ysJm
	w+cJTHVk0JtnbdxfYtvwC7O0rDbZrZS/l1ydDqzoLkpLT+zeKGu9YO4w3+eLk8v1th6IaFEK2RA
	AWqagRwk6+c5S/wlIi2UMYEUvcD7etWMEuNo8kMAH7EHxLr10d4e+bt477uZ6ZyEfCfyc=
X-Received: by 2002:a05:622a:1890:b0:502:9b1f:ca3d with SMTP id d75a77b69052e-50639a2cd04mr14827901cf.78.1770338606358;
        Thu, 05 Feb 2026 16:43:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c057751sm6602716d6.43.2026.02.05.16.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 16:43:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vo9wT-000000041DZ-0JDt;
	Thu, 05 Feb 2026 20:43:25 -0400
Date: Thu, 5 Feb 2026 20:43:25 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com
Subject: Re: [PATCH 0/3] iommupt/vtd: Support dirty tracking on PASID
Message-ID: <20260206004325.GB943673@ziepe.ca>
References: <20260205023405.41583-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205023405.41583-1-zhenzhong.duan@intel.com>

On Wed, Feb 04, 2026 at 09:34:01PM -0500, Zhenzhong Duan wrote:
> Hi,
> 
> When we add pasid support in QEMU for passthrough device, we found
> PASID attachment to a nested parent domain with dirty tracking failed.
> 
> It's because PASID-level dirty tracking is not there yet, by adding it,
> we can enable PASID attachment to such domain.
> 
> Thanks
> Zhenzhong
> 
> 
> Zhenzhong Duan (3):
>   iommupt/vtd: Pass dmar_domain pointer to device_set_dirty_tracking()
>   iommupt/vtd: Support dirty tracking on PASID
>   iommufd/selftest: Test dirty tracking on PASID

I'm not sure why you marked this s iommupt? It isn't right?

Also only the second stage table supports dirty tracking so I'm
confused what is the issue? Is it trying to say that if a second stage
is written to a pasid entry on a !=0 pasid path it doesn't work right?
But it does work on a 0 pasid?

Huh?

That sounds like a systemic problem, the two flows shouldn't actually
be any different.

Jason
