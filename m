Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1023F1B3754
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648829; cv=none; b=TPZ3PRFWM5LUlzhZ3NFDb/jaelR+Sgb/XV0ufccxcArd4uUofWl93NWfisD6NGXI1675owjqOI68//TX6pXJWOL5ZcX7+S+vcUgBgVwxU2/NgxLPNOMvvbTBp6Z2u5nP93l1YV8t1Xx6QmE5hKtOH0AJEXPGMLmvzBupx1+cgHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648829; c=relaxed/simple;
	bh=hcduPUJ63plKYFg5sMgJaJoxpYnUDTuhe5B+9+bWdAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWOKSOX/AJPWn0fV+3gqadmwqBo8PQvdA4zDVszY7+Me4PxP2hcDj/fcIfWdWmx0rtt84p26wAZb+l6ovWsdkNV23fIhykW+LDE2TOOmUEP+0rCnkh25BeIgYvF8BfPNhpmnlfHxSv0XbXhM0Xt6kqALIuBiZ1SvoM37+CNUBYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jV97spcu; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jV97spcu"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bf6755323cso2251296d6.1
        for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723648827; x=1724253627; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mg23CNEDMD4zHjO1hlkwyk+loYx0YTVZ8r/y6/PQnrA=;
        b=jV97spcuaBs6jCC6mIrvSqRLMKROVk4AEdZFWOMZLv/yYc0Ika7NYRpCeReRBMJ0pV
         sVvB4yTlclHo30eFtt2lM+TcHkXspmmYr8p4ubw0Z5rA4Ysm1mK8xK+buHLIzuJjpPFu
         dkXbTWvF8iM41v8qPY3AQaf2ClCrEv5NC5RRVjR3sYVUiqZCSpDewtuKg+tdRFvY/5Ug
         w3bl8wPZGAi5K+MwApZy0Jarj86k+TJXixfUEk9vOfs1tJzdeC+CsDBzpEUeY1PnzqMl
         vR0thhubHHajycimvVpiM75mu7RSj7l2zMicbcxSUmDCbJE5k9TuLsQE/FMln/1Fwdvj
         RZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723648827; x=1724253627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mg23CNEDMD4zHjO1hlkwyk+loYx0YTVZ8r/y6/PQnrA=;
        b=QyIH0vmZHrongmWyOsm0Q2+6eVM5/coz6gJFTf84Y6DGgRSLps4jdecDf0eYgG6tM3
         P/7Yabcq7D9JD1YVY0YDdOhwlpghIfKp8J7flS7fE18hRezuQzK3TFX5yH8PZedQHt5y
         CzjC8vvayJCJGMNCmok40lWNBtca/aAMYUPIWAh/x8Nb+q/Xm86tJ6kslWC5zFJ2I+A9
         dTq5/8EP0aRslBJpM9blTqEMAHQIbBTUGo2eBpujBV242dWQH2x1cRhbMaqKvaL/uS47
         FCRyGGHeU+GhvEbJpxm4IAXbgXk+04Ibto0Kg/njgMb9EFiRTfJQ8Lv70zzelp38RWCb
         lueg==
X-Forwarded-Encrypted: i=1; AJvYcCUfOx0ezVIWFcGL6t52+jo2dN1FjgJinshv9N1tDtiYWMSdZoIseZmRBp3aXxmFgbXKA9vGkid/TSRSQoGXf1Ryza18znI=
X-Gm-Message-State: AOJu0Yy9nhzEQFo6wYW/i3mklP59Sko4B9qUl5ILm8WUjMJQU58QJ0kj
	Mj1UtIrO6RG34KicUW3vzYZHhtIfU0y9YRhjXKN3MJNWC1l5Uk4lZgv7YX+iOxY=
X-Google-Smtp-Source: AGHT+IFs/BQEZjr8h6unAsrJ2o06RGnXrm/il5j+/wDCwXIvEtQlOlvpOhTjJBqTcjF825DsnYbpEw==
X-Received: by 2002:a05:6214:3c9f:b0:6bd:6ff2:bb3c with SMTP id 6a1803df08f44-6bf5d056a6dmr44429756d6.0.1723648826791;
        Wed, 14 Aug 2024 08:20:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e4e5d3sm44550136d6.110.2024.08.14.08.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:20:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1seFnV-00EfQF-Mk;
	Wed, 14 Aug 2024 12:20:25 -0300
Date: Wed, 14 Aug 2024 12:20:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	quic_bqiang@quicinc.com, kvalo@kernel.org, prestwoj@gmail.com,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	dwmw2@infradead.org, iommu@lists.linux.dev, kernel@quicinc.com,
	johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci: Create feature to disable MSI
 virtualization
Message-ID: <20240814152025.GA3468552@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170014.1583783-1-alex.williamson@redhat.com>
 <20240813163053.GK1985367@ziepe.ca>
 <20240813151401.789c578f.alex.williamson@redhat.com>
 <20240813231642.GR1985367@ziepe.ca>
 <20240814085505.60819623.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814085505.60819623.alex.williamson@redhat.com>

On Wed, Aug 14, 2024 at 08:55:05AM -0600, Alex Williamson wrote:
> Let's imagine the guest driver does change to implement an irq_domain.
> How does that fundamentally change the problem for the VMM that guest
> MSI values are being written to other portions of the device?

If changed to irq_domain the VM will write addr/data pairs into those
special register that are unique to that interrupt source and will not
re-use values already set in the MSI table.

This means the VMM doesn't get any value from inspecting the MSI table
because the value it needs won't be there, and alos that no interrupt
routing will have been setup. The VMM must call VFIO_DEVICE_SET_IRQS
to setup the unique routing.

These two patches are avoiding VFIO_DEVICE_SET_IRQS based on the
assumption that the VM will re-use a addr/data pair already setup in
the MSI table. Invalidating that assumption is the fundamental change
irq_domain in the VM will make.

> The guest driver can have whatever architecture it wants (we don't
> know the architecture of the Windows driver) but we still need to
> trap writes of the guest MSI address/data and replace it with host
> values.

Yes you do. But the wrinkle is you can't just assume one of the
existing MSI entries is a valid replacement and copy from the MSI
table. That works right now only because the Linux/Windows driver is
re-using a MSI vector in the IMS registers.

I suggest the general path is something like:

 1) A vfio variant driver sets up an irq_domain for the additional
    interrupt source registers
 2) Somehow wire up VFIO_DEVICE_SET_IRQS so it can target vectors in
    the additional interrupt domain
 3) Have the VMM trap writes to the extra interrupt source registers
    and execute VFIO_DEVICE_SET_IRQS
 4) IRQ layer will setup an appropriate unique IRQ and route it to the
    guest/whatever just like MSI. Callbacks into the variant driver's
    irq_domain will program the HW registers.

Basically exactly the same flow as MSI, except instead of targetting a
vector in the PCI core's MSI irq_domain it targets a vector in the
variant driver's IMS IRQ domain.

Then we don't make any assumptions about how the VM is using these
interrupt vectors, and crucially, SET_IRQs is called for every
interrupt source and we rely on the kernel to produce the correct
addr/data pair. No need for copying addr/data pairs from MSI tables.

> As noted above, this does not provide any visible change to a QEMU
> guest, it only enables QEMU to implement the quirk in the other
> patch.

I see, I definitely didn't understand that it only reaches qemu from
the commit message..

Jason
