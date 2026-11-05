Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890796;
	b=x2hUBIpDWLM7r5UQEhQVvhIcrBxezFdcySwuBfsDMqvfUZXTkyjSyws3ImqdDjFqXN8f
	 Jz6+vk212vTHl10VCkr+FscEVjFeYXT83NyAJAc4GEjHKH1ZuNF+rfDyX7lCWd96OEyCS
	 EPK6Gq8zw85yX0Lj/H7DJv0D/jAShKntBUlQjX/JJeriL1cNRWf9dDJ3t3ErEY2LjMs28
	 4jA/Z8wirabuu3EuMi2iyGTTBvSWs97Fq1hpokTBoQgeFGAHvzDYJYDcq5BIm5zy/kf81
	 SWt/DbKq0odNxNixeGTt5UAbxZB6y6iMjY+2NLpPlSW+KcwHGzJWbSQdfrgNGMG6tTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sv1GqJtGOVxD2bg62FKkDXwLV7ybcH0/LrV/szN48RM=;
	b=wPeMgRWn49qKJoYTOU5iepzlr3tH5/OlDA2cIBBQWuKHuSB5mT4IXkeIKxgkCWKP5YSz
	 YJTCr64ph2hF0SfZ/WChw95Tfo+oiM9APpVBwvclX/99ZqWxdfmzc5Q3vVfJo5B66muMc
	 TocUTJ/JUw4zjj8M3I8byScOc2GjprwRPyoz6Oh7WC+I2NFPyB7WyXR8IW3MZtiDkAr9q
	 HgkJIwsvnzvPM1CXnZN+S7x03ue0z5xd3WK92RDFYt7ki/rBfKYI0HyWfqM4+UT5Q2uIG
	 JlQHVroRaGNS/7vzHqiGgxBFVzulALDRSO1HkxkwqnzKS2g41cgwi5MCc7bLs/HIA+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=CNC3Wu8P;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3F8606D801
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 14:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC3F8606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=CNC3Wu8P
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so711485e0c.0
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 06:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793890795; x=1794495595; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sv1GqJtGOVxD2bg62FKkDXwLV7ybcH0/LrV/szN48RM=;
        b=CNC3Wu8PHpHFOGw8+zRbAhXStxCs0FaZ37Wrjj34KR5LM6IIffVv3muoBALrogufI8
         OnrrdQEs5hOdCRwrrGVj4kGRPPnsGUCptRUh8SLIQZseOS6QQZVfpahMN7hq4l29r7Ur
         ZyqxeOXSRIv8lZxq06tVccYr/bfoPNFcUhJA7SSIKN/Exrx7QEoC//LULTh+EEW4EKqD
         agOe1zUar/ben3ti5iWJduSKTqN3k1w/Ol9/rH/BCZVOYFBoK35vpb0NtHtbH1EXthzy
         YrsCPLr5aSe0tQaAacqEnlwrbebLwsJMMjgp4Ymv6U+D0yq3o/3NaJyt9hq+orEaeDn1
         Dl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890795; x=1794495595;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sv1GqJtGOVxD2bg62FKkDXwLV7ybcH0/LrV/szN48RM=;
        b=po3f7NVhGJspp3QF0fyljsj5lxPLPz744dbhn76lIK6kbQfKd3HMeRWdYLvss+6o3r
         z96JdUUTRmPGhDO3cjVPJ5qkT8mHHidJfT6a0bXEU7cXHAr0sHzlXywt3aHpd7hGbhaB
         3pt0T6xhUBjy7FkAusAbhLB5myVGTEQQnrHpPn4G+i99UdOC7+Rj3VcW304cQpd+2JfS
         ScbGOdr5E+30MWtPjWMPuJ4hKaFQAV/JY5DeO3L2pXwVQ2Hkpph+BnNpSix54tE2Iekf
         +drgKP5WcxPK6+j3QGpK1SOrXZJqiLn0SJ/7dZzcYM8xl/eY81V5qwQBTmOXrB/5fZMp
         FGdA==
X-Forwarded-Encrypted: i=1; AKwUvBzwKtJ1L3/igXsmSYdlovF207OJRXThKwwiO5VjTy7AxEpg6KfNHgJ0sdFXZbXNmfdCmAOZgg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9UJKe6CiSwpkTar0Q8/ujDbqBcoCqXVN5PJBWlk1srS14QmBEh
	liUShQ2eS8qYnHAAt8co2cdnicaHY6EqkkNHoA/fADHjwOw+MV19EF0ZHVwRGldkTrQ=
X-Gm-Gg: AYBFou1GPaeYQRptOb6BuFBqFZ3tyR/SiuL3cn8Dny3Z09y++jejUp6ghbg8PFVbuk/
	B7ojd330FNuZOrDqY/V3IxrLvXYYWNmEJxSj2ceEoQSSQogTaosIlSf8WuAXe853uBSSLmoPuD4
	mySe5wKZA8zJKfbmMykMrC1+FDUiNvNWfBBFt4zzhAOq0E16HiOi/az08MB1L8xKsHaPely2f9p
	1rRSPGKyV22mr1vabt1s6+q2KeLwFNGat+S4bHEkUeBvNeKfzObyxjjvNcwvMjt+MM9PtdMqByC
	Z9PfA8uAq+sX4HJ2uPvhnSMXG3TCXrG8kdoXcAITEse3LiOiIj+zWtsGxc6EKNeKB1i+bq9V+RU
	X3WcXlmq1q6vOOFJMB5QhcgP5+BOzrcCYll2cITuZxioitbkbzFS7ZOcvHq1qTy9nSGxpPKdvIz
	/mbtizv/VKTsFhVTZbXGvJ0JPZUHyKBcu1/nJjAelvUI1Kd5DBKUyvC22X9JvhfT01lI+qSbBWr
	QVqb6tQlmQoSZSlKMP3kP62I7bPJGpAPF9vUoRDrZ998lfCP+XGv0NyOF+8caHsvT/nadyE8jtM
	BlGlncf/Q5LG5iDfe3hIwjr6eqJdOqWSJ7bUf1lu7ShT+5QK75gaGe/VOHjGLPycvuX4v2NQ95c
	jPShbVvDb+RM=
X-Received: by 2002:a05:6122:6c0a:b0:5d9:302a:8243 with SMTP id 71dfb90a1353d-5ecb429571cmr1423011e0c.12.1793890794801;
        Thu, 05 Nov 2026 06:59:54 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8df2a38sm4234612e0c.16.2026.11.05.06.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:59:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOywS-00000002o7b-2oaN;
	Thu, 05 Nov 2026 10:59:52 -0400
Date: Thu, 5 Nov 2026 10:59:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
Subject: Re: [PATCH 10/17] driver core: Expose device trust authorization
 through sysfs
Message-ID: <20261105145952.GA663069@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
 <2026110514-bunkhouse-handset-6a3a@gregkh>
 <20261105132729.GB8298@unreal>
 <2026110535-engulf-precut-cf10@gregkh>
 <9d896ebb-6892-4cac-a7c5-41def47f0be0@arm.com>
 <54c9476c-9f76-4ea1-a73a-c9937d6b463c@lunn.ch>
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
In-Reply-To: <54c9476c-9f76-4ea1-a73a-c9937d6b463c@lunn.ch>

On Thu, Nov 05, 2026 at 03:43:53PM +0100, Andrew Lunn wrote:
> > Yup, and that's true even in the PCI TDISP case - there's a major amount of
> > "communication" and "configuration" involved in that. The principle which
> > should (hopefully) generalise is that a bus/host controller driver can
> > always interrogate its child device to perform whatever attestation and
> > general configuration is appropriate, but we won't hand off any _control_ of
> > that device to a specific device driver (nor enable potentially-impactful
> > bus-level features like DMA, interrupts, etc. if relevant) without the
> > requisite agreement between the bus code and the user.
> 
> Maybe it would be good to list subsystems which the bus driver can
> use, and cannot use.
> 
> You list interrupts as potentially being dangerous. What about reset
> controllers, GPIOs, regulators? At least in the embedded world, the
> bus driver might need to enable power, set a clock ticking, and take
> the device out of reset via a GPIO, before the device pops into
> existence and will enumerate on the bus.
>
> I don't see why interrupts are dangerous, which makes it hard for me
> to determine if GPIOs and clocks, and regulators are also dangerous?

IMHO we shouldn't try to over think this.

The overall point is to give the userspace a place to inject policy.

Bus drivers should try as hard as they can to contain their child
devices. Like PCIE should activate the iommu, disable ATS. USB should
limit the messages it exchanges, and so on.

When userspace accepts the bus driver it also accepts its containment
capability. So if it accepts one that uses gpio, etc then that's fine.

We are not the point of trying to describe what threat models various
kernel drivers can support. Userspace has to figure that out on their
own.

Jason
