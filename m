Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793001808;
	b=grDS80uJcn7BUulqt/uxcwNV9gBOZsZe2/6EgM2LfLb4mmv1ZLvx+0gH5CO9/g0nd0er
	 it/HI13lqiYanEQhmrCwMU3I99mui9jVwrpaeQkN78gjPXtugnfHUT+CP20drlQiOTdQH
	 JMdRe8z3wb4H26VJtlEYVOcy+rK5hkSrlSMixNXt8XzlQjDAXefrwr5BcQh8CaO1/piQy
	 +BtORTrf/gtElamu+qY6Vp1iQZlkdk8z47hXjuR8UJ+AXGnb2IMnsBhbjoYSoMTRBC7vc
	 WHSENan/c6DOzzz3XQ7IzqvLRX+yVYY5CdzEVw6HKRjo5uzflHGsBxDWClxAMJvI9gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793001808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=oue2gY3N148Z5QjebnGzECChsQECIfu8P/sF36ovlgA=;
	b=ZIKTzLtLOC6btLkkyR8qbJi/j0oleYPn5nrsyOQYGHTIsIwczUyCyhxYFGitN8tFqmIB
	 4M9zqFd956bvThFYQJaM24+wwl6ZqoDDDsHlrmAJsH9cphH0KePSZO8mCs/Xl5A81lzt0
	 Qkyj/FJkLn8Z3EAi4xD7ank53NVQS2n2VLFgND24b6ytMQ0lx7m+rpvwgdPe1NrBgSaYE
	 HSCfHr0jD80my1Hq71J2VeutVnR8lra1aVsMMrV1sCvR1frAYrEWnyXym62vMeZI9QuJe
	 RPVYU+pE1gIxAlq45iRuX02IntXFwfQvBA93RPsMuVDRSQt5o7aDJE5oOAzokW6BMIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iIzFb14l;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6216606A31D
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 08:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6216606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iIzFb14l
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c4649b35bso2746372f8f.3
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 01:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793001806; x=1793606606; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oue2gY3N148Z5QjebnGzECChsQECIfu8P/sF36ovlgA=;
        b=iIzFb14lylCYlZhVf+aB5Tr+Hxp77FupTPwRG1klLow4zLbhfE/CDxcCwrgxGsRu7m
         SoJl5ltf0mT3Bl0emSdzPgTpQHoKk7ORCmD4ixJtpA8woLB2JprdjV/UQo1Uw1ixpfNC
         Bf7h4+sbvPIvn+JFNvvysS6n3qjCwxNvUSzip+sXJMI+54TeyCK6ayf5+5Gpx4bTI/Yf
         +7GpcdSgF1nPBEWs+61f6gjkldmH8MGOeDu/s2P/gzaX6E9GHP1PxB7LDLEZsvzBGehH
         +Ao0FJMzg6FA9WW481SRjVqHnAyySuKx7lHPDSDv1tN28y4znjUYhhWjbOXMYDm28qEZ
         X/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793001806; x=1793606606;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oue2gY3N148Z5QjebnGzECChsQECIfu8P/sF36ovlgA=;
        b=yhliFnGglLFm2qJvFSyPwM1l94CrKq8CNuiTu5v/6Xl2r21Vz/j3T59c552xQGxb+o
         DQ+g7JnE9OlhHhTnVioHpEBP5lAL2q4HD0WW40O6R0rwrr395M66XmSqPSFqTIQIdTzX
         ogH9UYFPGPbr3mkjKwN8vnsjuGwMKdiaYGeulnF9GDttfcm+fJD17Al/aCPt7kSOP0uD
         lm3CPALReZt6WJSAf+xsb+aOCmwXtTJCl+pP9AiXl3OXidF2rEqC8ys+43I0thX8INX3
         df7HmvX7LWKu6tGFcTHeSqzQ39ULndoN/gkkMrrbD/bMREWQyCW0nO61OvNztIKUWWlF
         YoVg==
X-Forwarded-Encrypted: i=1; AKwUvByywWf/3ms++9evupl3T6M5Jtt8KLUpk/cHe+AkTcoj45pVW20dRGuwj9gxHsSrk5FjORMPaA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLtBeorZnnJT+k1doy+1RM0OM8IYJjzZqfvTah6lbgahzHTdsd6
	7B3taUhrN7kOC8fuCWgK8TJpdBh1+Nv08uK3F60V7moXvH/Pa/bxtraS
X-Gm-Gg: AYBFou0//MtR/mhDKJNOM4Tl+H+/roUkrh1qgXPYt5jgBdyUECaMYIJa9JkDTMd0oSB
	h/yxU/tNd1rDKIMc4klBNO0ndtrB6bYNcP+UFrKimdfgxbalPKdpch9kgnyHPpNHEtRqVvcOL4q
	iIcOn4KNB9xMvRru+tR1E/qVf1AlJf6AO2RM9C4Q5it4BigvvQoRjXUIBiVHXi1yXECNm9Wm18C
	YSOBXMMXoJNoDqkOw4Ml0t75478EikYbX3HDUHaqmGb4KSzHGhq6mvO1wUqWrobGDQMflZuMCvP
	I1Ka6mBFzKJFWCSvO6FTD0xLPX6/gxhg9BkH/eSTkAZ+XSnqOZz9uvBCCxMNYRw3PGa0mI2IcrY
	u/94jB0W5SLfTt3ib2Alc+JWjmoNi4D6hKRC/M3PJeDU7550yadOjRFWZmtczxFIK0Fbr9kiReP
	opjTISMXwt08FW0sRTWs/EcOKmnHHEfOClvpLumPuALb8tvZR334P6KpJO8q60cA3OC9iPLSesF
	B/1GpQEPf2vG/AfSGr8vZqWoDCqKYw/JiO6URwuorZ7rIMzPbJI6QrAG+cvHR7BHVV58+hqMvdO
	xe2kOlR8OXfRDXSf9ucqJ9sbh6gU7AjPjj1c9eHb0qC+yqubwQ/KHiX6u6UWjfuRkzUwYs4R7FU
	GKqtEsKQq4T4YIiqYFqjZwJ1f90O6oyhfvoChiEV85er+68d+Yg70vM1UJXjQvw==
X-Received: by 2002:a05:600c:3f12:b0:4a4:7a8d:c436 with SMTP id 5b1f17b1804b1-4a47a8dc6e6mr85645335e9.11.1793001805868;
        Mon, 26 Oct 2026 01:03:25 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b1a4-1201-5c78-89f4-99d8-70d7.310.pool.telefonica.de. [2a02:3100:b1a4:1201:5c78:89f4:99d8:70d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ad39sm473163315e9.1.2026.10.26.01.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:03:25 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:03:22 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, christian.koenig@amd.com, 
	sumit.semwal@linaro.org, jgg@nvidia.com, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Matthew Brost <matthew.brost@intel.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Dongwon Kim <dongwon.kim@intel.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Kevin Tian <kevin.tian@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, Felix Kuehling <felix.kuehling@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org, 
	iommu@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com, 
	treding@nvidia.com, jhubbard@nvidia.com
Subject: Re: [PATCH 05/26] dma-buf: Let the exporter select mapping type at
 pin/map
Message-ID: <at8IQZ34wkHQ_5PL@gmail.com>
References: <20261026053623.202642-1-apopple@nvidia.com>
 <20261026053623.202642-6-apopple@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026053623.202642-6-apopple@nvidia.com>

On Mon, Oct 26, 2026 at 04:35:56PM +0100, Alistair Popple wrote:
> +struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
> +					enum dma_data_direction direction)
> +{
> +	struct sg_table *sg_table;
> +	int ret;
> +
> +	might_sleep();
> +
> +	if (WARN_ON(!attach || !attach->dmabuf))
> +		return ERR_PTR(-EINVAL);
> +
> +	dma_resv_assert_held(attach->dmabuf->resv);
> +
> +	ret = dma_buf_mapping_select(attach);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	sg_table = __dma_buf_sgt_map_attachment(attach, direction);
> +	if (IS_ERR(sg_table))
> +		/* Nothing was established, so the choice may be made afresh */
> +		attach->selected = false;
> +
> +	return sg_table;
> +}

The map-failure report from Sashiko [1] reproduces with a KUnit test
against the full series:

  pin selects B -> map returns -EIO -> selected is cleared
                -> retry selects A, with the original pin still held

The exporter pin count stays at 1. Preserving selected when it was true
on entry makes the test pass. Patch 7 needs the same fix.

Could dma_buf_mapping_select() report whether it made a new selection?
Then the error path could undo only that choice, without dropping one
established by an earlier pin or map.

On the Sashiko failed-pin report:
("Because the attachment is not pinned, the exporter may migrate the
buffer elsewhere without invalidating it")

I don't think this follows from the documented contract.
select_mapping() requires the exporter to keep the recorded type
servable and invalidate before an incompatible move. That obligation
still applies if ops->pin() fails.

Is retaining the selection after a failed pin intentional? If so, this
can be added as a test documenting that alongside the map-failure
regression test.

Thanks,
Karl
