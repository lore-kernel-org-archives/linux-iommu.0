Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BC03191B5
	for <iommu@lists.linux.dev>; Tue,  9 Sep 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433532; cv=none; b=K15Grh0TbBrEWeZS4/Q1qZaGSp3riJQNKbrbC2J5w/HjabrPKl/nRx90xEuBhzJPtlH2aCs9hs50pC1c8QdmpTLUT2zKog4Tgk/wLZ22zCNvS0JWY3iZTCr1dHKD2w/e0e78n9hX73RbCLbcEUJzrzrX9Fm9VdyWyJcQ5HuuSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433532; c=relaxed/simple;
	bh=bKYz3c9y+gNOcYf7TFJwhjWkpIADlCUKYQIpmt+9Y2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vp+zUupE1D9G0GIddgnfFLMbvHaWPoSLjWjyvO9zNxKMTI4/l/iNp2LWT7t0yQnQrrrMWuaJHTI9QItvqEwdpVGYKEuJu9VzlytdwTPsItqdzSCcjmJZ8oLYmbIWlrfdXgSZNjmCJcekiIL1DBEzJbOhaKl4xHfsRK/f5ME0R1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IOA2cOYb; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IOA2cOYb"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8173e8effa1so156360685a.0
        for <iommu@lists.linux.dev>; Tue, 09 Sep 2025 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757433528; x=1758038328; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xhvGZRaKvGOKbFuieB7cy8gqgC/YDYs/ewa6xCzMoyM=;
        b=IOA2cOYbpg/DtYwNKgDUjwzJ72Emah3NrU0acLCobbQxS5KHN965w37JaFjHfwfg9h
         +CuAIpPqkAZFn9rM3N5SgZNBooOvYHMmxEKWdMcisLP3fWFa8bVrTsQWxj6bp3X7NcJp
         /bZ4fauGogiXA9w1VIgK4tEVJvjg/iHda8dCaEbxZK1q9J5wLYaqVvnqPuWEp7B1xKgU
         J8gyuCfcwBF+/Tn5EAmAn11cTUke3B4ivv0KhjlPnXmwwnov35jUyO+QN8ynGoxQ5NaI
         KMjjXzFNT83+zahUtuGw6aMI1E4kyG9RuWe+WVqo1yPyM8MC88Z1Q031EXhQoePFOU0n
         YFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757433528; x=1758038328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhvGZRaKvGOKbFuieB7cy8gqgC/YDYs/ewa6xCzMoyM=;
        b=bXsyucwPLSQE/eTlI2KMJ3MUpPU28j1O5FQyTSCRI//h3V7HF0riPHgINt3tfZguMT
         lFEFyRTJOfFBK2bwVSi2k7CzkBlOFo0pF5kJH9XixeYQWcHpYHLsJVo6PqUADE3OQNMj
         KPQiHTxOoeen34egv3GDGq51E5uA12ebKGbtJ0G3rJrRF48rcePesb7sO6ypxmvaPFLl
         R4nkv26pfAbNlY/OrOELDXY8BQJgP6SdKciXYNbVqv729u5hSntJCqntPYhQChcngMYm
         p4C/OgvYkO4Zu7W5HoetFLQUPQZ1lo/Rhe0KuHn4prUs6c4BTE+oGHMuW1KF0EWxxGUN
         oZdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTNxU9Ar8uWx13KmkAwJHtNpm9hHUzJGXc/i13V+Vp+Zmi6q0S13zDQaud1QOcoHAHEjEMwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGz8PNPzIs7cqXkuwElmXeHF4FGzWaSTt1UzXnUjhgSBJRmc/Q
	pYNgCxB5tXIBba+MDpO47EAD3pMKquTw6N9GlvzgyR7jL2h7k/8TQkyt1wNR3Xyjg1Y=
X-Gm-Gg: ASbGncviq/GcSwZ+OAD9y0ilkZuzak5KzCjOBAPbuH+2QckqaAxVurx56SW/zExZrdC
	UfVP+6NFgsY/WH3gycFHS6sreA3u8dwav2GJmuASvSRCmoUWoTHM+gg9nLsmfQ812gOk33Bj/KP
	nmrkGculPXC6Z4hvH720r5U58Q1Q2uzZ0smt0gKNy9d5jXAgyKmMcWUI5H3bKLgbMmJAbW9zH+r
	v/2lIg2OZMOqZSVglCBUsH4lfNg80TDC/av+wRyhJUaS3DszCfkYR0o12XJwgx4p20+gJrEwvba
	1Vca/ht6hLWJrSUU7ze3wRmZmw+GXAx00VbxsMBvMIFT1bLW+YcPIkK7Qr0tMzphUw04xJuCHBC
	X/u/yN4k4d61U9rm89KlGKyTdBzMLRX24m9wVPNVTEJy4DWnL0miz2gubRgMZj02mAlHrEUTUnE
	8hID0=
X-Google-Smtp-Source: AGHT+IHIkjBRe7yt4WbOZJ/YpK79iphLy2T8QoB+1HLpvRtSFAYohJmx9nvB2OQluCbq6HB69MOUdw==
X-Received: by 2002:a05:620a:4609:b0:816:638f:4ab0 with SMTP id af79cd13be357-816638f4eebmr916110485a.27.1757433528370;
        Tue, 09 Sep 2025 08:58:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b58d4957fsm141532185a.3.2025.09.09.08.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:58:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uw0k3-00000003iHY-0OSc;
	Tue, 09 Sep 2025 12:58:47 -0300
Date: Tue, 9 Sep 2025 12:58:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: thierry.reding@gmail.com, robin.murphy@arm.com, robh@kernel.org,
	joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	jacob.pan@linux.microsoft.com, eric.auger@redhat.com,
	code@tyhicks.com, eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com, bboscaccy@linux.microsoft.com,
	saravanak@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	lizhi.hou@amd.com, clement.leger@bootlin.com
Subject: Re: [PATCH v4 4/4] drivers: iommu: refactor arm_smmu_get_resv_regions
Message-ID: <20250909155847.GB882933@ziepe.ca>
References: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
 <20250909154600.910110-5-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909154600.910110-5-shyamsaini@linux.microsoft.com>

On Tue, Sep 09, 2025 at 08:46:00AM -0700, Shyam Saini wrote:
> Both ARM SMMU v2/v3 drivers have common set operations for
> arm_smmu_get_resv_regions(), except iommu_dma_get_resv_regions()
> call all other operations can be clubed into common code block.
> So to avoid code duplication put common operations in a new helper
> function iommu_set_sw_msi() and call this helper function from
> arm_smmu_get_resv_regions() instead.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 26 ++-------------
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 24 ++-----------
>  drivers/iommu/iommu.c                       | 37 +++++++++++++++++++++
>  include/linux/iommu.h                       |  6 ++++
>  4 files changed, 47 insertions(+), 46 deletions(-)

I would do this first, not after you made all the changes to both
drivers.

And then once you do it:

> -	static const u64 msi_bases[] = { MSI_IOVA_BASE, MSI_IOVA_BASE2 };

Can just be constants written here, nothing else in the kernel should
refer to them any more because they are dynamic. The only way to learn
the value is to read the IOMMU_RESV_SW_MSI. Thus don't write them out
in public headers to prevent mis-use.

I'm comfortable with this side from the iommu perspective once you get
agreement on the DT representation.

Jason
