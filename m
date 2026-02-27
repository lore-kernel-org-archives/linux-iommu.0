Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FE543CEE9
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201013; cv=none; b=Bsx7DHdH523HydmsoaJWVMz469LnK7ZIl83jtB9wttlqt3E7EWL13p6enQWYhFOTWr4b7RkvWSoOFTFqbWvLV+Dk8o/tWdyyJg0+Pc4V5pq5Ty0EMphangrcejEYuaHo1X/CiUi5Nv71i5ZB+Iq7f5fpHWtGKnVRTjqdLRhTXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201013; c=relaxed/simple;
	bh=/W505Jzbj5uWoZ/qJ3gNXx9zDJjMXlpnlkd2GeMGH5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWdZA5SzuAUC3JpS1RK4DVSFNxhLmwfjIBCQXCxMCjAyy2g9GpSt3i4g3vsNOqVH0unroMKAFfgPctiYPjJCrEP7RV+d9Io/m9JJ3cHhiOr7bmVEIUtwHV7lVQx8ZRXJd0rsL0OUt82ixmeBJ6u9JBhq321kdpVlHaG8O0Cu578=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=V82jx9l/; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V82jx9l/"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d18d02af68so1681686a34.2
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 06:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772201011; x=1772805811; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5kyvGGKr8t/91lDXefhAhTqmzrSuKLLo1P9UK6MZn78=;
        b=V82jx9l/Bk3RAbBHCto8NnKFfuV+SiakbzB1LV0LsqbjVfi/qms9j1p9m6bboKRdik
         uH9yYfokNH4uqcxwXSskaadCrsxiE+BeR3mUUvm5/43JGBb1KAAjwi/BX0/Ril/esDPW
         Uvwnuhwpn+f7dchQTwu7cmzs3cmTA+PxR+zi0ZaT9OLn57FI5ZRpNDPnjlAHmO1u8Xfy
         2N0qZmfEhdKqewvjTftW6XaQ/oxO85iS5NX+a2GMPO0mnRczqwP/dTTnQ3fAzN5FAp98
         yMUb2gylbit4UAvkYf7I+ZzAzaXGv3AgjtqJckK3nynrUKWbxms4W/OwHUwxY+h5mJFy
         v0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772201011; x=1772805811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kyvGGKr8t/91lDXefhAhTqmzrSuKLLo1P9UK6MZn78=;
        b=f2yoawOJGcIt+DE7BYxHSMsZ2YVgZKrSYn+NGd2VAvGvgHu5xMBsstx8rvpmv2JhHD
         2le7+m6wQW7ZFdHX2ShwlXe966gWH6FhZiWniYcDSQmPMyawbCcwYOFPVduvknkCJP5S
         k5PLsW9rtIHmqBW1H+V+BWxRrYLeCDISYCCWOkGTx/6z3fbeCgEf0rSrcSwJDOgRLN4t
         WIWAretsQM2xMys6URf2QScKgfK2LBS0P+VRp7+ePaYWDPz3P5Wh/tXRKwSu6Q8A3pWr
         dZ7st8BswadU/9OOkhV7mbUPVTTy/39Lg2zPaJq18wMOhBpJ5pYEV2kkWuZTGdRsPMkR
         jdrw==
X-Gm-Message-State: AOJu0YwD7S4kntcu4NGibo1+Q3uXK/26/dtyzOUE0eNOknPfth7d7Fbh
	O7jUA9I4i/M8SOuasNVeszHruvksra0UYa0MJCBv6yVen4T2X5RWftqYXYEJW/DHAPQ=
X-Gm-Gg: ATEYQzwkMEABPRKNkHClZ5f1Mff8bFxWMS6RhxlwUK1h14O/UKy2CT2vpYLyTl1h6Rc
	DYfX/bEK36RYVA6ud3fZxjPHyfrboqxwOs6EcFPsOuh9zJ697d2TigfmH/ap6IGdxTbVC4STIRf
	w0DO91YEacdmQX2LpngsMPA/Wo7lkJABVspl7QD7O1CHI0lj3Z8J39Z7T9Gf4/2k7bg+/eE+JZX
	6T7OE7swQ98mJgIx1iPCU3HtLhpgv54jnQqhYiwUQnIvQeiIe+O8Otd91koyA9Sx/VE3ABpAB4M
	cCUm+f5zOaIC+nUrqIUoNaqlaikEg8cyIXUAqxToo2Vg+H3O2h68/mQ2EPnxiTK2YLpC8b2vvCW
	wvgDKjpsa/BBqH9S+oEEJshNovsb8aRdzsy51AJC6ugNHfp7Nok1MBceonRJHOIHgxd9MOsM+ra
	WEfMjvDaUc2ZSjyXyPgrwPXvmC3FGdHh1ITt1qdj59/p9dEzFpePDzSNRYxEyJvyFORCjXPBZdc
	sx1Pv+Z
X-Received: by 2002:a05:6870:9192:b0:3eb:318f:36fb with SMTP id 586e51a60fabf-41626de7bb6mr1591090fac.12.1772201011051;
        Fri, 27 Feb 2026 06:03:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f926csm481207985a.32.2026.02.27.06.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:03:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vvyRF-00000000vQL-1Fdb;
	Fri, 27 Feb 2026 10:03:29 -0400
Date: Fri, 27 Feb 2026 10:03:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	dnaim@cachyos.org, Mario.Limonciello@amd.com
Subject: Re: [PATCH v3] iommu: Fix mapping check for 0x0 to avoid re-mapping
 it
Message-ID: <20260227140329.GI44359@ziepe.ca>
References: <20260227080638.208693-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227080638.208693-1-lkml@antheas.dev>

On Fri, Feb 27, 2026 at 09:06:37AM +0100, Antheas Kapenekakis wrote:
> Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> introduces the shared iommu page table for AMD IOMMU. Some bioses
> contain an identity mapping for address 0x0, which is not parsed
> properly (e.g., certain Strix Halo devices). This causes the DMA
> components of the device to fail to initialize (e.g., the NVMe SSD
> controller), leading to a failed post.
> 
> Specifically, on the GPD Win 5, the NVME and SSD GPU fail to mount,
> making collecting errors difficult. While debugging, it was found that
> a -EADDRINUSE error was emitted and its source was traced to
> iommu_iova_to_phys(). After adding some debug prints, it was found that
> phys_addr becomes 0, which causes the code to try to re-map the 0
> address and fail, causing a cascade leading to a failed post. This is
> because the GPD Win 5 contains a 0x0-0x1 identity mapping for DMA
> devices, causing it to be repeated for each device.
> 
> The cause of this failure is the following check in
> iommu_create_device_direct_mappings(), where address aliasing is handled
> via the following check:
> 
> ```
> phys_addr = iommu_iova_to_phys(domain, addr);
> if (!phys_addr) {
>         map_size += pg_size;
>         continue;
> }
> ````
> 
> Obviously, the iommu_iova_to_phys() signature is faulty and aliases
> unmapped and 0 together, causing the allocation code to try to
> re-allocate the 0 address per device. However, it has too many
> instantiations to fix. Therefore, use a ternary so that when addr
> is 0, the check is done for address 1 instead.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Fixes: 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> 
> ---

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
