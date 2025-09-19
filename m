Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858D2FABFF
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283723; cv=none; b=RG9qDnXN0HMiJVk+UwhPLyqeNDwId/f2gO9Owvb9Xfc7dST/ZmpIP3QT1uCjNIQDjHHz3+fuuPvmBgriKIs2ciOxk0x9JRl4R+5o+qGNqn5L9ttXnVnilELFEkl9fKZeEFghRDn8uNP/st2L0l8Fjt/q2m1w6/BiBrStF1xHrTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283723; c=relaxed/simple;
	bh=PU4BzVSUM6uCKa5w2l6OSfoECkEW3DTQ8YYJ6WsGxgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4vktvUnjVc/e1bAl9W4dn0okXlhSNd1DjvE3QDXVVkEHAi1If0BxqnUI90ZbtIOt8/+elUWZT2QtZPWcYSnYYWYFkz9wV03Sw4xBAFBzgB7rv31+PrVoNXqKzgDHxcLqvuYfWIhj0byHVk0fixUpW301BovAlFpMRGl0BBk+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NM5faOPK; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NM5faOPK"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6234b7bdf3dso784798eaf.0
        for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 05:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758283721; x=1758888521; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddOV/4AeMTKAaTlLO+S2d6s4wCcUbRWR+oBWKnZEc/A=;
        b=NM5faOPKVeGO7OjDsQsb/kScnAlkMlNFQLKuRGZu3eliqIUtYMGOKu4MSztvFXSA8u
         3p8+BUvdva99GmiPvIAdaKTsj5WhJKPXSlV7ug9b90uifo8AK2mUxla8i4KGDNaX1HsJ
         1BlDsXe6Jia88E+SNGgnbl2Og2YZ/OF2Y57U0cupj469mUJfuGePXac3V6mRmCqKcDzY
         oLUhYj/vHpEZHB5JrOkJRB+mpgK/4s+yCNuh9+EugGaFrVFQmCRZ3o1xhFmd/DnuEdyq
         Pq3NwkqZE7KjPgulME4PPdA7+RGudPp+b3MpDDH7csicxRztjsDwoxODGnBzOMqgQ11/
         QbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758283721; x=1758888521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddOV/4AeMTKAaTlLO+S2d6s4wCcUbRWR+oBWKnZEc/A=;
        b=U9DR+pPm+OhCzmWrp/BVm6G+hVh8YEEMjyuWidhcGGyJYVmnikMjDqL1zGSzvX0ax1
         1dLN27URVKmf7kt3ve7jGGiI0jiZYQYysTKXc7jeAIoe2PPESmxRUKTls9xH+KLOahDI
         qNi/CwzbuHg2Y5//qYuxN5pjsuryUf5NuFJIHDWOEYfqMH92EoLjlg/p20wrK/OLQd3O
         Z5Z9USxfMWmamJrztOh1UmOfiedcHnu/Ze9oGzN91gw00AEOb+EnxUPWopJpc9Y2Sybq
         9rR0Ym6Afo7xIev38bKk+QRoY7NMQ3kDxSDh3sal3uuFPyeGGMiUrbTuGlPtCp61Tck6
         55bw==
X-Forwarded-Encrypted: i=1; AJvYcCX2NC12gtdDUC+9fajlF0b/FjYgAfNs/wgV/QbMQFHk+t5bVz6SaMN7fi3u1XQ8KTmPzvx0zw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6ZIXy4vU7pdzv0cOOsG6BHHXA2wYWpiIaUPks2T1d1nUPRFQQ
	7yNziS+w31MjLxW3crPIVNPrG3ZgXqVNq9z2rPSi0dsgbI9oWOmXUPeaVPFAzKWHiCw=
X-Gm-Gg: ASbGncviesDcmO6NGjSONCBthVYlBQmTAmjJPFqu0+HbiKjNee3X8Dx1iAS6DRBWW7L
	/k6TZrXGcFDAXAe3GCBWBr7x8j8DsxAM/3DIFJuFdFXWqoQDSa21Dt/HAeOOYhM6t+VeeEMCJAq
	bVx9d6AmuxARo3N8y96s0hhNjukPGgDApzAHDk/IPqERPIsU7C6eTkGkx9dDJnIX7riiF1YjlW7
	vIx22u1ef6FsrsmiZykVhnrQErb9yU76WbYOzCX2pduh6YDWTY0YbPxUlnJ2NWl8vcV63lxtqib
	SwjdwDuWiS6oc7b6QOiBl2WjmD2cGGONz18Iwf08X/eoKIcUX3rzhaZFQYo6LBlV3KUuX5/39UA
	Q5YqmWT8=
X-Google-Smtp-Source: AGHT+IFaCWGfMylYUS564NQsUR0mWVuwnX1ZTO8LwVtBeK6iF/UthAXLSHYAnBZ/pCpVTkoFVFyzFQ==
X-Received: by 2002:a05:6820:2285:b0:621:7820:a28 with SMTP id 006d021491bc7-6272abee5f2mr1140086eaf.8.1758283721447;
        Fri, 19 Sep 2025 05:08:41 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7692a973dc1sm2326849a34.30.2025.09.19.05.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 05:08:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uzZup-000000097kO-1FuO;
	Fri, 19 Sep 2025 09:08:39 -0300
Date: Fri, 19 Sep 2025 09:08:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>, thierry.reding@gmail.com,
	robin.murphy@arm.com, robh@kernel.org, joro@8bytes.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	jacob.pan@linux.microsoft.com, eric.auger@redhat.com,
	code@tyhicks.com, eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com, bboscaccy@linux.microsoft.com,
	saravanak@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	lizhi.hou@amd.com, clement.leger@bootlin.com
Subject: Re: [PATCH v4 3/4] arm-smmu: select suitable MSI IOVA
Message-ID: <20250919120839.GV1326709@ziepe.ca>
References: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
 <20250909154600.910110-4-shyamsaini@linux.microsoft.com>
 <aMw4I0AjKNPY6SOw@willie-the-truck>
 <20250918224322.GR1326709@ziepe.ca>
 <aM0HQ51DelZW_Rt8@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aM0HQ51DelZW_Rt8@willie-the-truck>

On Fri, Sep 19, 2025 at 08:33:23AM +0100, Will Deacon wrote:
> pieces and will need to work on the userspace side. It's not like
> MSI_IOVA2 is magically going to work (and I bet it won't be tested).

It could, if someone checks the default memory map a second constant
could be selected that works.

> > Nicolin has some patches on the iommufd side to let userspace select
> > the MSI address instead, but they are not done yet.
> 
> Maybe we should just wait for that? Carrying a temporary hack with ABI
> implications to support broken hardware isn't particularly compelling
> to me.

This patch would still be needed for kernel users.

Arguably the kernel users should just be using the iova allocator from
dma-iommu.c. This whole hard coded constant/sneaky uapi is just a hack
to make vfio work..

So maybe if the single constant doesn't work we could set some
indication that the caller must allocate the MSI iova, the kernel can
use the dma-iommu allocator and VFIO can just refuse to use the device
for now.

Jason
