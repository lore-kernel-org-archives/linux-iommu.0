Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855860;
	b=RY4eppx/Xbqo8qltHAdsxK/2MOaMR+Z8DlCzOEb77mM9DDM2z5SymdHQ9uFiYuE1f8f1
	 amns8PWplFiAxmnRr+3gL5fuqbTK5CSqAja+VBRxQhrhW48ebi0VibrJRY7ph4KwpIKi8
	 hWLbsC6t9oAXZ/cLgskPjy3xzM0ocuI64T4BCXaUIUAb4+A6UshKGAVT7Kp+wHoTrdooQ
	 B/fYRv9hQ/AF9aFKRgVQU9VjXge02u6F3U+M3wGuxfK5oogdPRHcbXTMlZ60jvhqWuSb+
	 10hOpjhK9FSE5/ykdb6uhS0WucDnhJD/GDLgIPcdvkcMW4nsngrn8Wa3i37wl6j12zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=WvOfbKHC1YhEa2QpW290x7cG/RSkj9nU3s9Pf1uScWc=;
	b=uO6+By0H9GYzFQ/QQ5JYMwk4pzqwK4A9G7Qbs68ROwGrGRpI2auuoNDHWKih85ppHFSf
	 LtmLIjP4hSY3UDOTRtVloVnyyMmAq9GwtmKaRfxhDZPP9W0tixy/shgmsAs0mcJLP2zmk
	 oDCSSYVO0Q6+/rdAwVbOkHZnp4f9H0ZPE0F8lvehLRu+Shc3E/L8XWZNbGj7sJT37vv7m
	 NZuuIsDwb9lE3tznZCA8ZOSaDFHEAWMEnJx/Jzl7yXo4nfyiVQr44l/2+ILedFsotF1nb
	 aJcZrEWeFvvM8rJVj90Qc9MRnMVc3weXgbWYoaQys2ifSlrsAhpOZHpD0WZG7UHdkGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="c0FDCiO/";
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14EF606A32C
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 19:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E14EF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=c0FDCiO/
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53634b8328eso39592791cf.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 11:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794855859; x=1795460659; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WvOfbKHC1YhEa2QpW290x7cG/RSkj9nU3s9Pf1uScWc=;
        b=c0FDCiO/SvHUN1oSXSerEuk/f9oAOPDd4xb5+sWGRVeAusTyr6TCni/+V7wq4DkYo2
         wyHGD38JVt/kNbDRUmHgzuoEbVlugnG3HWsyfBqVvGtWcEvySSCgGG51WBBo7mrsh5lG
         S/YviV77x6EshDEdufdQHwfEjp/9tiJBWUatgQIFpabgPHZdj05TFS/aasqgqA48igGu
         DTWgG2Jxr/ZhLzSOsNrVcF1e/MidQ1iwDLI9tR1tKz134Gx+uByw+yiLZua4UNMqScJZ
         A0GhGzyDtkaf2Fi9n864eeB3x736O68GPa8lyvDB92WwSC4mQuowod6APA69SYb5RWK4
         idIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794855859; x=1795460659;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WvOfbKHC1YhEa2QpW290x7cG/RSkj9nU3s9Pf1uScWc=;
        b=xNEZMKD1BsVVcYgEAEUYPGcV4CPd4MD3M8gMW5Xfj0OwF3zezy5sAYtWxoeR4ah20u
         x5KKdPlNMleLHsIbQFbQotytzAVbnlGioQtKYw+OYFLts43YdIAv+k6el8K5kJOewxdI
         QtImyOw47/2jk3jTT4oh03kbJhsV27mckZGlVOMIvuerZdSUNo/2kbjyQeCxUIVM/kqG
         JqtrSv62u9HwRyzCy22y0T9r2toGHR6oDAjnHgTU4O628RHze0057fXVqpxlP8hz1Xd1
         krjrDwE0HBh29QttGUrZb9117UOraYtIHneHBpStkf2lRCJT4SG6lmKIu62HtJdmU5+5
         QbBg==
X-Forwarded-Encrypted: i=1; AL+hErFFqZq9FYDaAp1VN4kLT/nRbcyhKUF0c8u7y+N8ROrBWUqVvqG1iCu6945f69NCKslnhI4wuQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9fNbJgb+D6Yqnlzt+4Uw22cHt5VTRjSAA1Sl/5L+AqF81I9yMa
	bAwDFghbQfE2a3uIgmQHsNNrAF50uN3P6fhz1XmAdHPOTYLvjVm67TMeRuDhYtrFIDI=
X-Gm-Gg: AYBFou2k8i7DtiKHQGmfykJ7/ixVGle80zvs8lckIfevM4AlW5uN772Hj36FAtxzO/6
	zxhdYRiUjbeQMVnZUaFpFnrDqjmiAMm+xQ+3wqhjZ/pYwP2+YZkNcmutdMrmXBiefJh0hMkmJuG
	O0zsSZVz3xONzqzzV22i4GM3mUF0x2KOJ3x3GIV907U7iaAwXSzx6NBJh7nmh0OBZYo3bQX0H4N
	rVT9eQ1yyTtGjqgPDqTdbn4Z/SpLIQwYobZvPRVrxaXcPCnYGXAYMKnqYxywYqGLvyixNOl5HbD
	2K+rQDUqbjBH5LAFxGN49kfbRKidy41tl1SYkf0/Eq9ATASAuhOn4NeGsCNJ1LYm+P2k7AZgVxD
	ItVMLG1GaB6eKv9HW2ir8hvBLHNcMxRcOH6FxuivKP7IhIiThjbKjAPnhS+kkFdQhSRWQd5+eIv
	BBPmZZMrfN5AszOWsJnOCdqFTB09uOprxwc8wCInBw77E/zbJlLrKkt0TleN1nUC0UyUIhmuM1h
	Dh0nDSXcgm8h1g8qak4W1cxMXcJDdX4xaqGLb9M8+C+fhPRFCDcrnAVV/IkFg2cL1u07RqohLqm
	NfWTJA==
X-Received: by 2002:a05:622a:124b:b0:536:9140:e2be with SMTP id d75a77b69052e-55ac948cc41mr174359441cf.74.1794855858824;
        Mon, 16 Nov 2026 11:04:18 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad1b13917sm87667361cf.29.2026.11.16.11.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:04:17 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT201-0000000AFsj-03Yl;
	Mon, 16 Nov 2026 15:04:17 -0400
Date: Mon, 16 Nov 2026 15:04:17 -0400
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
Message-ID: <20261116190417.GD2299285@ziepe.ca>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <193e4130-9c2f-4a0f-b218-f5fcf0b3d508@linux.microsoft.com>
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
In-Reply-To: <193e4130-9c2f-4a0f-b218-f5fcf0b3d508@linux.microsoft.com>

On Mon, Nov 16, 2026 at 10:46:25AM -0800, Kameron Carr wrote:
> > @@ -1738,24 +1738,24 @@ static void set_pcie_cxl(struct pci_dev *dev)
> >  
> >  }
> >  
> > -static void set_pcie_untrusted(struct pci_dev *dev)
> > +static void pci_set_default_trust_policy(struct pci_dev *dev)
> >  {
> > -	struct pci_dev *parent = pci_upstream_bridge(dev);
> > +	struct pci_dev *parent = pci_physfn(dev);
> > +
> > +	if (parent == dev)
> > +		parent = pci_upstream_bridge(dev);
> >  
> >  	if (!parent)
> >  		return;
> 
> Hi Leon,
> 
> The default policy here works for physical hierarchies, but there's no
> opportunity for a paravirtual host bridge to participate in the trust
> resolution when the host bridge driver itself knows the appropriate
> trust level for a device.

HW doesn't really "know" the trust level, it can suggest a default but
the kernel command line and userspace should always be able to
override it.

> My scenario is pci-hyperv in a confidential VM with a paravisor. The
> paravisor is inside the guest's trust boundary and owns TDISP. It locks,
> attests and accepts the device, then answers a VMBus query describing
> which BAR ranges are private and whether the device's DMA may target
> private memory. Before a driver can bind pci-hyperv has to:

Sounds like a user in such an environment just wouldn't use the trust
level mechanism at all.

What use do you see for enabling trust level but having all the
devices unattestable and accepted already?

Your bigger issue is the below:

>   - query the paravisor,
>   - refuse to operate the device if the query failed or if the response
>     is invalid,
>   - decide whether the device may operate.
> 
> The modular host bridge driver in this scenario needs a hook to be able
> to participate in trust resolution.
> 
> I'm also looking for the right place to setup MMIO and configure DMA
> in my scenario. Let me know if you have guidance.

Well, you are very far outside what Linux expects for a CC flow, and
these special requests conflict with the arch code flows we need to
have.

So, I don't know. Maybe somewhere in the arch code hyperv can hook and
say the device is special? You'll have to see when we get more of the
CC stuff layed out.

Though, FWIW, I don't like it at all as a model. Denying the tenant
the ability to directly attest the HW is far away from what I'd
consider as necessary for CC.

Jason
