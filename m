Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896023;
	b=LvCoio0L0PsTO4W4f2zzvaoYjrs/oQzqWvh/BNcpuKTwfqXa+E5ga1QpnhHT2mR/esvV
	 fglhsF1nfSnWcOEC1/9eCY+J5oLQu9LxTCakpcE600yM+S6rfPaHobm46wYGo1bLdIqFs
	 r3MgsF/Rmm1MCl29tTOfM+Us1SR1KXTiiC6cxSgiTnSk5kIbdAK4O67aU+2I4JAzxparB
	 QMinkT9j5UaA5Wh+2sgv+W63tKft5fEwMn5KsEzeLqOFbR9fNvySEEUetUwVXO4pUxK3X
	 /Gm/V4ULhA6G2zOZhRmI28e4f75ckm0CzmDp4PcEj7iUXgQtJjU/kE8tzJrCMlHrdIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
	b=0QIdNwg27s0efpVKKgKhFdP7AxJKC/5BrB0F79ViuW2bc7JHtCMz/bPW/hyoYn0X75lR
	 B2oZCRE/V4R85C5/J6arbnx3QH46tJEHSK2dix3b6O2Rm97QNxooS4K37pdxVDs6/p949
	 TlPvHshXimKZ/XqLf2584GbA7xTOr94+MOyMybToS01SyeWRh6+lXO7t9b3dRem1+Fb8d
	 R+evShm0/Ez62uDFywxcUg2iiY/xr9CFMBwI5tQjipf76vlH6xiYbdCFqvoZo1AQvbOny
	 6vpAFXL4bO58cGmcbKzgGqVf8kGyYER0s+OnbKb/U94/aRlT6FxWlmE1tyy4F4w9Ebg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=H1OQVHcQ;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888B6606A33F
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 16:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 888B6606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=H1OQVHcQ
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ead5ff47caso754296e0c.0
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793896021; x=1794500821; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
        b=H1OQVHcQ1uAjCjVR8BRgJ48YlfatlDz4giWern+6CduNzr5+DwC1ER44CbAFxGx0Gv
         ToxPmzQ7/J+YZpDH1rNcL+CbPzjbvrtlVGghwQtrdptiawPkP2U9QsW6i15STQcANPjp
         w4viNeXRjgOodbGSjAvkJLEZiyL/bsSJuSDDQNeCa3jDQYbnHCV/uzQMDQ0MQSfKrXUJ
         qu4lYckMSRhMHHXv1v2ChvIJGU/JFtGDF0AejhYQ6ajAmFp11x5kUEysunILL2dD0TLA
         bnkR1dvFpyEOAsYZNxFf78CeltEyOQjkAUnGlkkiWJtqIsVAKQhZlQdnYobqU0Rk2zdP
         uSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793896021; x=1794500821;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
        b=Mb6BCLnFFanPUjQQMc/hu7A7H9AIgSQ7Ot3Z3bKFps0IS6WoEHT3FvxZw/MdJ7a9WR
         IUxWgThw9RXIcwIr8cwl0fz2GGKGme2DjvN5Mv8mLafNugzR3YlFcRgmiVsaq3v9tS/m
         xG6LnmOZW8A9Gz+9m0mtT7Ni/JehJLcDSVb4uo100b3lYxqSzxmfmwFJg4LVQIqZVoTu
         gREJ/iJuFp+LRguCRRmiJKSG6cV9/Ei6U9+U3FRv2qbMju+MlYWmk3v23k3N9YVoCrns
         A2OOx3XbZTuHniQf9+6jH78RF4pNGHmHO/OlUEdzyvY/szc4kFt+8W8OSL1Bsrm8NxUb
         aegg==
X-Forwarded-Encrypted: i=1; AKwUvBwK7gCmrVDB8ZqX/ZEYig++2EeUZLQcD2hIc9wbUNGOqzL3Rdhp5KBcb2sWvbLERvFHKHqrgg==@lists.linux.dev
X-Gm-Message-State: APuU4Z94dnzlod9iq1G6t7uqwws3dcWfIewv3VPVr3v5HWITF8lVPy5P
	EH4fa73hX9WvlCglycINR8O2VQmrWdOsMfahaXYj0PNf0XtkmkXrtMf0Q0ciO+CgfJM=
X-Gm-Gg: AYBFou0PyQFQFMcw5PdSplYtMGAukYNJkn4Yb4sCAYQmDjkwpC/qAuU4MQY1LeG6rM3
	L6ObNiaNEJBVmyjTRJjI60zuGg8jBv37h3g1nno081vOuKeDoXU6fxgdRX5QT1G9Yhz22XGEHgB
	r9KenOd2xdAKnSv7DrwJVcuZ7yKIH5EDfV8Si8IwXzy0U37sfosm8iXYPVql9yI3mq1uWN9zVwi
	OQx+NvMKwFG/9+JnUv0OCnchOzSqXLZH0UxSyKEAWKjhV+K90n6IuZwcfHV6b8cZgG/Hr3fHZaF
	J7QW6mIs/x17QZWkjDsYVELVv2iWzNjmpFCmbG5b7jU4FkMbclBocS/onhs7smX/XRDHDkrNI2n
	jvxnxfljGDtqG3m0VM/e7S0SQL4Qjsh7xp7wkOL7mN5YkIPIvTga+hDVe07fBrXjH/lXjkZuVH9
	8M5M2hC5Ig63zWndSN4KD5Wx3eNjKT++k0NgNlxMIMdcLUK76LJOcXqiP5yPeU4UJEfTxfXNBly
	dVIgMRjzmmxfzngoPxydNpM0l7jNdPdDa2TlDgK2sCdhrxezFY1gMrOe8jxo6uVBtMJ2eCaPKYq
	ciFMJDLpHoweUCMH9LggTPiqQ9mLGZRWLeXxmLdsqNlhX0usrrzs5x/VtY8mAD7pMS0m4pIkB/L
	kT/VDnFvIxweHY3oCzxrthKNwdIGddbs=
X-Received: by 2002:a05:6102:3f9f:b0:7cc:174b:f7bc with SMTP id ada2fe7eead31-7d2a15715c3mr29296137.15.1793896021174;
        Thu, 05 Nov 2026 08:27:01 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm4667110137.11.2026.11.05.08.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:27:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP0Il-000000032XP-37xT;
	Thu, 05 Nov 2026 12:26:59 -0400
Date: Thu, 5 Nov 2026 12:26:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-input@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
Message-ID: <20261105162659.GB663069@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <2026110526-aerobics-correct-4c06@gregkh>
 <20261105131856.GA8298@unreal>
 <20261105140352.GF3889730@ziepe.ca>
 <2026110558-tartar-juicy-036a@gregkh>
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
In-Reply-To: <2026110558-tartar-juicy-036a@gregkh>

On Thu, Nov 05, 2026 at 10:43:00AM -0500, Greg Kroah-Hartman wrote:

> > But I supposed Greg is asking about /sys/bus/usb/devices/DEVICE/authorized ..
> 
> Yes, that is exactly what I am asking about.

It looks like that does the same basic idea of delaying driver binding
that this series does. Hopefully Leon can harmonize it to use the
shared trust level flag instead of a usb specific flag and retain all
the uABI around it.

But, even with this v1 the user can choose to use the generic trust
level and ignore the USB specific authorized and get the same
functional outcome.

> And I know there are other types of devices that will want to use this
> type of thing (i.e. SPDM seems to be spreading to other new bus types),
> so it's good to have and get right.

Yes, we are investing alot of time right now in trying to get SPDM
uAPI right when we bring the general framework into the
kernel. Everyone needing SPDM should be able to re-use it.

Jason
