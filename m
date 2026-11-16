Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859754;
	b=pMQCCVA3EZW8ZGLzK21FMHk41hEpzxesFI6KjU/i5AzQ86qGfgICRJXQyIgSsuYafQzP
	 lbU5q6yd76pdaRG3pU5lRBn+fviXcUEcAIzKwfA4SXH9azVbKoxx1q14H0vV7wQ/ALsVg
	 mYpnSGk5i3lLKqKy4OTHxnsyiSpAn2Z31ykRE2grgipoMxOL6PDFklie4Renr9XsJjJj6
	 MBxSWy8I+1CwtmqxdEh0AwUCE8+MIzUpPmdtH+dJjNOXpqKM0/mqA3dT4EaVC1OYz94yi
	 5V73+KcfNfjGU0PVPX0ffwtxIEMLfundHViBG/jMvIkgtazR9TjqNUoE4oT90RDlbaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rIDjnnpHadC4roO6Pjzwfgg43uG+Y6jCh2hpR36q9WA=;
	b=3sX5ZP5JBhhdQ9VixZ68eFunOM9aBBvo3zNZLUWOfebI7B/mRdHRnoL76UgaFGJExqHC
	 iNTNMQX46sA01fWaq6cU7/aNTuPjK9YlDsypnenEH0bS/h+IEKI9WPHb6oVc3r5z19qEo
	 YcJkYyVoewZ6lqlgg+okLwVFRpzi7pBjjqmuODC0nWhYBdo5MGXMkFKG42fxhB2GyI5nd
	 CZdqZ5oW4hw40KZqpaJOj1nInopxtyS5jnjV8gEp/vEdYuc+Hc+QaU9h20QnWkoaFGBWI
	 U4NcZr36ZsFKAZvQEHxe+8D/1chauHksbNXsY5qaRE0rlC9jo3qIijO+ZaK8FupdbRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=kgB6aQig;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DD4606A336
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 20:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54DD4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=kgB6aQig
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-536717a4d83so40754551cf.2
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 12:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794859753; x=1795464553; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rIDjnnpHadC4roO6Pjzwfgg43uG+Y6jCh2hpR36q9WA=;
        b=kgB6aQigMTtdRvvKH8bjYfrDN1EUjGPSV6bPlrkOct4wIco8x+8GEmVoolqNR6guFH
         L4k3oy/ndEBZj6CDJO4hKt3dy01ethJAIXq0Z/WifA/2fqfoehVfsf2Eklo06aioSMvb
         vYF0bEW+dj/jIYayrJ0wFl/oMVyihDP2ndc8ucqkIoGH8MAy5NxY52ayRYgXjaZ1YZ22
         HIJX+vcFqlUNL1/NXja/xLNLazveprCJKFGQ0qOFJcINB1lTjjzJIBynP6mzzgV5uBvz
         IhuTMM5Ep7tzEuym0acjMdkECJno0+CC19moxKJysDpVHheBU8UmlkbCcbiT29r0uBQB
         yS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859753; x=1795464553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rIDjnnpHadC4roO6Pjzwfgg43uG+Y6jCh2hpR36q9WA=;
        b=b0oWE+vZ3OmypilcxcKUYAcLrgAPlimvjax33lWpQQAiYghyj2h21DWijUdYNEzium
         LcGK+HhZkgj71XXXkmQkFPSidK+L9fNTzH9PQ2IM36xl5DmHvhpHO1C0tga1yw8WJhUl
         /yvBpgkBLNkJFXtajzkEbZ9o11FkgAT6EOV6INw3T8bNN4a+b9uvFAqQqZb0z9qb4yyL
         HSGXszTlS8UbHeiMkxg27bjOTQ4zEn8FJ56GHJfTGOa8p2fWqTe73LSBGkbbhWS1UBA+
         VEjbG3h5LI+pHlIFMv5eALUP5CRO37EDV0FgUxhwgGscJSLF2yiae8igI+VMoRMST3K3
         xKog==
X-Forwarded-Encrypted: i=1; AL+hErGD4Nyl1N5O2pwEjfLFkx6uSj66Zn3Rp4HLVTFf1rJiCf6DoQoNZHtCs6cEPxLuj80U+GeUKA==@lists.linux.dev
X-Gm-Message-State: APuU4Z//Lm7+NffpaoWvNWBBiXwXzdHcp+uhQTDa0F/+SouA0ybWAB3a
	j+MK+EcX/OsT4cUsPKLAOk99StISA6aip8V/OdS6stRwopqg5HaP+wWNB0SNsZbD+A0=
X-Gm-Gg: AYBFou11YAJXDpBnsW4kl7euV75OCwNRn46d5F7DFeK7dSM8M7FsWqMSvazZf7ArDdT
	lYIq3m7ItUYf9n2JIZN23bQrtbpEoMO3JnIb3xs6lytlYR+jV8yN39cHT0aT9KMpB0M2TojokrF
	1Wyb4Fowu/Ew4MIJerKQekpDJr3PD49Us07DuPCmq2OYTbGstyX9weEYTR5/m43SXG1Oq0mUOK2
	7h/Pb0PUAyAfpGoSDQzkbbQTINK5TEQXWIwwa/BqJv52+ReXtjKO8qqlQ4mQRjEIO3wa2hL4neU
	btz72ew6n8tlUp624pmUaDbUFMbmiKgT71PRs75nbS/tGZ8/UTXfuB/FsTMq2MXEbAAenLN5NXA
	ZU3IbWrgIcdLXYvqvf/9giTnB/vsPcatvEEzVFNrR/X4o1P8G6PPOeCh+JvS/xrZviobht6dHJZ
	GTcFIRCjDnTHPqUYRIJJ6WeZC5srw/PONVPxdfZwjGPIWiiugG8ClZxFgMXBq++N1qvJOj9YroB
	SLvuDgWxmfQxTRayEnGO/+yEcxnpBaTXM4GuYw0W2ERemx73UKu95JafF+o2xwcDNHAv0Lb2UMo
	nqyzvQ==
X-Received: by 2002:a05:622a:5144:b0:536:98da:f790 with SMTP id d75a77b69052e-55ac43909femr187873791cf.6.1794859753196;
        Mon, 16 Nov 2026 12:09:13 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d445d1sm92856046d6.8.2026.11.16.12.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:09:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT30p-0000000ANtb-30lh;
	Mon, 16 Nov 2026 16:09:11 -0400
Date: Mon, 16 Nov 2026 16:09:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kameron Carr <kameroncarr@linux.microsoft.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v2 18/19] PCI: Replace untrusted state with device trust
Message-ID: <20261116200911.GA2473219@ziepe.ca>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <193e4130-9c2f-4a0f-b218-f5fcf0b3d508@linux.microsoft.com>
 <20261116190417.GD2299285@ziepe.ca>
 <2965c691-82fc-49f3-abdb-383860f6e82f@linux.microsoft.com>
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
In-Reply-To: <2965c691-82fc-49f3-abdb-383860f6e82f@linux.microsoft.com>

On Mon, Nov 16, 2026 at 11:24:17AM -0800, Kameron Carr wrote:
> >> My scenario is pci-hyperv in a confidential VM with a paravisor. The
> >> paravisor is inside the guest's trust boundary and owns TDISP. It locks,
> >> attests and accepts the device, then answers a VMBus query describing
> >> which BAR ranges are private and whether the device's DMA may target
> >> private memory. Before a driver can bind pci-hyperv has to:
> > 
> > Sounds like a user in such an environment just wouldn't use the trust
> > level mechanism at all.
> > 
> > What use do you see for enabling trust level but having all the
> > devices unattestable and accepted already?
> 
> Previous iterations of device trust used the trust level to make
> decisions around DMA bounce buffering, etc. Is that no longer the
> case?

It is not, this is now just about userspace attestation really.

> I am looking for good hook candidates. I was hoping that trust levels
> would end up directing DMA behavior, etc. but maybe I am
> misunderstanding the design direction for these trust levels.

I don't know, I broadly expect some flag in the struct device to
indicate that it can access private memory, but how and when hyper-v
could get involved to set that flag I don't know.

Jason
