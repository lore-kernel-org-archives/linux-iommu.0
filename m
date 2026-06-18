Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8873FBEC1
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795870; cv=none; b=bx0iEb3t/1nFROlEHgAafovjXI+Tvt55aXl45Ell4xe/38Xf79PUM8goD1wBp1cJvsrhvSUfxWK2SxrRnK3nNSv7us/OhmY/y7lC8PK5GIZ9GB7CS6K120oNCG1P+OIEj/kCczB92N/VR+fJBLH9lN2tvijbYtiX4P6hLBSrEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795870; c=relaxed/simple;
	bh=fb4jtdv5mW6uUnsvCDcww1wfNGkPXw/cVhax9OAz1ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W96hXhkvT7FzKqUj5+0vX4IHQGQm/WiORB+GfTfY9gS2BPs9mh1CqOyLK4XrqeX7gZA4EMKMs82t3WwpFjXqt8DszJVkSeXSq2ADyx9IYk1TRzmUSTJOz3u8imKx9i6cs9AmUAl7fIy0SEkvdWJaNLuRfjGc0fFYhnXL+99VDoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JxIQSVjD; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JxIQSVjD"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-48611addcfbso450066b6e.1
        for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 08:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781795867; x=1782400667; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fb4jtdv5mW6uUnsvCDcww1wfNGkPXw/cVhax9OAz1ag=;
        b=JxIQSVjDplSVqxf6rNl3M79qVjdXJIVjv8USUbnbXHe8F34UqyOgVF6YcrL4vptjU2
         r8WaZsPcGpt2zI6lrOZwobEWYplcP4bq6ln10T6RiMOq1XdScVjOZogzy7P4HNcdQOgc
         kLroeCPEZJPuQSRTyt6ZTcARTLD4g67yyofFqxPMx/pyQ7oVXuFsNfzRr2ktAhCPDbvL
         18JXOQvhdbGULdZFxbfUB/ETbo4jYJUwu4h1uM/lsztPktB9SHBIO+P/xckdqxzMfUEV
         4x2oqRlEQdoph3FkTyg41RzDo4u7xPEi9RAHKpgMKIIn5RQHywawP8ACFgapCbtJS6u+
         nyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781795867; x=1782400667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fb4jtdv5mW6uUnsvCDcww1wfNGkPXw/cVhax9OAz1ag=;
        b=btOh2ONZXiHryS2OwQSMurYz3+dJ2Pe3U+kPsW/Njys8+nYLPz5dUbfVNiETj7TLyd
         emIDt97l5Tz79jCkwK7vqHmpCXAPZxg06z24OP8GlqOuq1g2GiM19UGRAgOVdp0TR9QP
         uondTGjAwXEfEr5pwQrcRX88GhIsyLf4Bxzi3Qv6JTtrhYQcdKFGolHKMUjSdJjyzCpa
         vlagvnTeBr2aXQsOjLaIRQsfPaUrjGJN4Fx7FPZ1tRhpMpAZIZHBdlmP/Io/GwagHzgD
         z4TOB/KxRVmxbRJfe2Qt2X4rFf815Y4o4TtW5rUifkG69PW2W6Oef1LrLhSWTjtC7GzN
         uv1g==
X-Forwarded-Encrypted: i=1; AFNElJ9y4j5cAPxT3Q3yGdDLdCLF2tBwQSPVTsrJVupTxOqOq8/xPSG2R7k4E0mTZszbfAJNufKE6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxC6SkmZbixeN6p+F3jFv2Y2rxhI8r/4PR28NwkSLg7Cd+DWJ68
	iJS0NH6n9EsqLZ+8wkXcclaYckVfafLRN4aqmP96VVIt7kqwhg/ccsGMZH3Y/fdw8cQ=
X-Gm-Gg: Acq92OHQrw7OI7L2AIDxrbOSM5UXG8qmYou8R9qzKWGBrTy3jnZgGoTYYoSbnjmvvBh
	2Ju1YYXgq1SQbXLxo7ChR1dp2Cm1ZT0Dvz1mmGWFtN1wUrAga6iQp2b4uFy9qe1Lns7tX7ivhus
	2bAh6pkdZ5xaMGdxk3uU96Y0N4hZJ8Cfj0qfz+JcaZKgpkE/vPlbU/vXaE0VhkAmaC5fnJDltWr
	pwU5TxVu8jvAggV66oVkXZzTgz0AslTTmDwEYUbX3C/LZbeqrKl74jDBkiObwXrl4MM+bkiQs5f
	WRVFySiKkv0VDr9Pukd0GXk1tXE/KgKJSqhx4SN4c21J8h4zg+UN1m+vzoG2zYxUkZGXrBopjWH
	lQEQCZxGKd9dEUF5y5At/MLxZl/ICfghewx8fKDRdlYMORvPRFrHW3Sn9FTMLBEM+MzdG/Ei3GY
	yTRV35tPMh1101HZTEL8c2vx4uh2kdvB1UB8YM6EJnpxYf+lfqUHmS06NMpKyniFzh0GmaRxNtj
	Nq4nw==
X-Received: by 2002:a05:6808:690c:b0:485:48da:132c with SMTP id 5614622812f47-489444e5528mr6402027b6e.18.1781795866966;
        Thu, 18 Jun 2026 08:17:46 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ddc8d99d7bsm8073486d6.12.2026.06.18.08.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:17:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waEUz-00000002rrM-2pkZ;
	Thu, 18 Jun 2026 12:17:45 -0300
Date: Thu, 18 Jun 2026 12:17:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	will@kernel.org, m.szyprowski@samsung.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, dikshita.agarwal@oss.qualcomm.com
Subject: Re: [PATCH] dma-iommu: Introduce API to reserve IOVA regions for
 dynamically created devices
Message-ID: <20260618151745.GD231643@ziepe.ca>
References: <20260119054936.3350128-1-busanna.reddy@oss.qualcomm.com>
 <cfd23f75-8952-4463-abd5-815b995031b0@arm.com>
 <bb59f07e-ca7e-f012-6a4b-0a148350b69c@oss.qualcomm.com>
 <20260612172649.GM1066031@ziepe.ca>
 <da77c21d-25b3-46c3-a48f-71f0549e9f5f@oss.qualcomm.com>
 <20260615125257.GS1066031@ziepe.ca>
 <dcc0d02e-91fb-ddbe-399a-0191bab94c4f@oss.qualcomm.com>
 <20260617194038.GC231643@ziepe.ca>
 <e9e76c9f-b3b1-4ffd-9547-183556f6bb60@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9e76c9f-b3b1-4ffd-9547-183556f6bb60@kernel.org>

On Thu, Jun 18, 2026 at 01:57:40PM +0200, Krzysztof Kozlowski wrote:

> Same with interrupt-map.

> There are PCIe controller nodes which have interrupt-map and no
> interrupts property ever uses them.

PCIe is quite a different situation because we expect Linux to
dynamically create the child nodes based on PCIe discovery, and the
various maps are all searched based on the PCI BDF based on HW
properties of real discovered child devices.

Here they created "vpu_bus" and create a bunch of devices for some
reason, but they are all hard coded in the driver. It is not a dynamic
discovery, and it is not creating "real" child devices.

> Because DT person - me - told that creating child device nodes just to
> configure iommus is abuse of DT. There are no child devices in terms of
> hardware or firmware. The iommu ranges here are no real hardware.

That doesn't seem to be what Vishnu is saying. Review the earlier two
emails explaining what the HW issue is here:

https://lore.kernel.org/all/bb59f07e-ca7e-f012-6a4b-0a148350b69c@oss.qualcomm.com/
https://lore.kernel.org/all/cb37e7cc-4fb0-4c24-8f89-f6f9eb08a107@oss.qualcomm.com/

The VPU HW diagram with different IOVA requirements for different
stream IDs seems to be an entirely HW based thing: "each context bank
enforces a different IOVA range"

The original patches just created a 0 based IOVA space per stream and
justified that by increasing the IOVA address space (make sense). The
email above now says some of the streams only function with a limited
range of IOVA because the HW uses the IOVA itself to select the
streams (insane!)

IOW this entire device is completely mis-designed if it is going to
easially support the Linux DMA API :( That's all HW mess, which is
motivating hacks to try to make the Linux DMA API do something usable
by this device.

Anyhow..

In Linux if you use DT iommus the SW sets things up so every stream
shares the same translation. If your driver/device doesn't like that
there is no SW way to opt out of sharing. I think that is the first
core issue that VPU was struggling with.

If you have one "device" then I would argue the DT should describe all
its streams using iommus in the normal way. The introduction of
iommu-map for VPU is only being done because that is a convenient hack
to allow Linux to unbundle the streams. It would be much harder to
unbunble the streams directly from the DT iommus property, but that
would probably be the cleanest, software agnostic, DT modeling.

So, if we are going to do a hack in DT to accomodate Linux, I argue to
choose explicit child devices so VPU does not need to create a special
bus, call of_dma_configue, or hack in new DMA API things that only it
will ever use. Then the explicit children can properly describe how
the HW decodes IOVA into each streams in the DT (which sounds very
much like a HW property to me) so that Linux produces IOVA that the HW
mangling properly routes to the expected stream.

Then the VPU driver just has to assemble itself from many struct
devices, which I admit is also a troublesome task.

> However, said all this, since I pushed folks to come with the iommu-map
> approach, I will revoke my disagreement to child device nodes in DT, if
> you really believe that is the approach. IOW, I will agree to device
> nodes in DT representing fake hardware-children, just for the sake of
> Linux driver model limitations.

I would wait for Robin, he knows this better, but I belive this was
broadly his point in the original email..

Jason
