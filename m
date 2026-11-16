Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844785;
	b=h+luyP/bn6JYVf4uKyrg8CEi9qheRLWFRd/wkWiw+uC0M83o23abxVmSAAXBaxZysVuh
	 L57SPIn5RxPRxqYTW5yGCMeZUfDJu4tP3jK/7gHcsm3jOGRu6rdzbuCqYPyuS+MwGMVc5
	 xxl+nhMe+AscbbbhxGIKWUjNWjSJG1IJWIlgKKQZO/81B4c8mvwc7KixluilOwRaVOAe+
	 dcXZzkEBzHzKfX+AfJlLev7i330ODOjvueexrYqKn3dn0AE7hRlXSNsGUs2DbUiE8H21v
	 nsne5HZnOrzM7NXlC4DdtyKcO2g4RZNdzMZxdmoPBxJNpCHB+9qoymz+dda5XSA5JgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8zt6BKnr5OMQnoN+jLF5J5ZxUIjEZ6DGHzLguvsf5vs=;
	b=IInpW9UoIzff+vXQVjCIFs6IKhUMbI+T23Rw9ChX8sU7hmZpxWa1/q8fJUL0N3RvVBNj
	 4uFnN1llUyvEMfVrSkruvbKBTyv0YACdszlfi9DS8YJ/AtsTBZE6zCO4/goL5JU9Hk1jp
	 LnfQj5/xYRiPedu83y7WZsDn59EmwnMp7JstVkbxxLuvkrtwn1r6sTK2RDq+Zrprc57uV
	 qXcHcRWaE0/bvcZHA4j70j5yHXdog0ckIpXisraD7VeP9IxwiFl+vKdhUr/YSgCjQxzmi
	 MXyjJyhUBjCvDDDdVIyS+j/6psRgAwsKHhimAAOFoq8gD9jf4t7oEl+KDWHG44cAjwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Kj3HZZm6;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC886606A323
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 15:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC886606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Kj3HZZm6
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91eb3fea2a9so42080326d6.3
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 07:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794844784; x=1795449584; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8zt6BKnr5OMQnoN+jLF5J5ZxUIjEZ6DGHzLguvsf5vs=;
        b=Kj3HZZm6VsiSY2VSh5xuqQ5FztNq0RICtlckv9INxNJSdQDs2r1hvpg0FORIpLcTKY
         Y9Lv0SWDdO8tW+84wu7+VFeOUThglEPk2adIUO/kV+T6cbXdSlVtnme+Y5DtWxq6nOnt
         rEahO7bRz4syTLL+2fDv8rPUfy6E3cZmaOIkI7NJNUhED5rcAf6WiU3JngRpezjBNISK
         yb7S9WcYQLMGnDieKnbNGCmWNIQgDXcQYb37kRll3p0+5dBluY3ZwdMqWdnGwQEPoFuk
         3JWfpf9cRBpOpi7cwYuKGNuu/b87V5MZ1PlxqDzAS21evghQTjRq0c8NdXcYlepTyNVY
         7PZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794844784; x=1795449584;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zt6BKnr5OMQnoN+jLF5J5ZxUIjEZ6DGHzLguvsf5vs=;
        b=H0w+JiEW1rIx3v8IhbdxApIyNKSA0+jSrFCjqUf+i4as9A9d+Qzgy0SedMDP78TVMT
         /SOwlAnlmd/QjyXwJKLBK3tQ9nasfRYJR2jcPZaHcwxmqyLViHbX+W2dIKMHYpHJ6F80
         jrbUoewXbwNuAuoOxrIUM8hFbD5wRaSzJ5lb70YA1+CPfP9ctifVWPCJsmQnJvi329oZ
         dMoxHWvZZQvf5ME5USj8Fpj+oM5TNQAgpxcF+z1fHLsLBkViCbaKzzyWtoLhp9ywD9sZ
         iHHVnZU5dhvWg5xayO2AtrFlG5g6V5CdLb9QtAqjP3w46N5tQfqLKGG++HQxgN46TS89
         ZCpQ==
X-Forwarded-Encrypted: i=1; AL+hErGttq6OSEvkAMLLePxTLn7JiB192sWW6/hy6e74tf/dFiSpgB4F0YCawTcpDFGa7f7rHesVOw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8td81iXyrda0QtSHzQ48muLr+ILEAvnv50aHbbOHXRg1g76QtX
	Rwj5Zek3lFWxOSl4eLojoU5i/GVX6s6yFOG23J190BqYf09pnOV6EuVN6Vbf1RS8gME=
X-Gm-Gg: AZFdTZc5DYOIcnJ0MBd/Od5len5PYlEGwVxfn2oFF1Ish4AgfB1UPHB00/GXRzsJ8Md
	pbrvZobiCFacB+sERgTdK/ufMaueYiU9MKrPv9MJK10B3vfKR6gOV0/64JTpnow9bs+QHYyyRrv
	QZk2BZKNyIt/a6BbrTJm/nfe4cDr02x5tkl4hIVDb+VxDLyhAxI5MHHNUPt1bOle17Z3/ad3dN8
	YUBNw85FKH6O7PgqluKhSNB3j8Q3pHAJq0iD4aY4yHajlPm/EPVdbu8oqFOeENu8DqQJ6eOgncP
	cbeNn7ZaTHFBmDnFZwd/RGwjq5JEpEvz58bbIkjUgBHaCyfAmXC36FZDhW9yUS2Tip9cmJKp7si
	xIJZL8APN0q0+jkq+EPkdq5Sg/Do2qYi3XKGmWo0VaW6ddDJOb9NcJkWc7ZfkRCyM9mNIUJ7v/I
	SMHBVFG1qbcgUP4Rw59vdzKhH918cH/iJ5sZKxM6A+smoAgtQOBvgItrcFrvoJqP5jx28NR2xCe
	kX4elI1RxMfWfll6Cj1SB1yvl1WmnvIovF8Ok57BlKTZzXgau6j/p+XfJJ2z8k0OoXnlT9JSo84
	qmHXBQ==
X-Received: by 2002:a05:6214:2467:b0:91c:7f1f:2c9e with SMTP id 6a1803df08f44-91f24209db6mr171122396d6.55.1794844783992;
        Mon, 16 Nov 2026 07:59:43 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d93f10sm87735096d6.30.2026.11.16.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:59:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xSz7O-00000009eOI-3Mx3;
	Mon, 16 Nov 2026 11:59:42 -0400
Date: Mon, 16 Nov 2026 11:59:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
Message-ID: <20261116155942.GA2299285@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <yq5amrr8yldi.fsf@kernel.org>
 <20261116132046.GI2532299@ziepe.ca>
 <yq5aa4n8ydsk.fsf@kernel.org>
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
In-Reply-To: <yq5aa4n8ydsk.fsf@kernel.org>

On Mon, Nov 16, 2026 at 09:22:11PM +0530, Aneesh Kumar K.V wrote:
> > Once you turn on TDISP you effectively activate DMA, just like turning
> > on the IOMMU.
> 
> We considered two options for doing this:
> 
> 1. Via the ->accept() callback in pci_tsm_ops.
> 2. Via pci_dma_configure(), based on a combination of device trust and device acceptance.
> 
> If I understand correctly, you are suggesting that we stick with the
> former?

It should still be done in #2, just with nothing to do with device
trust.

You can't run a TDISP run device at all if DMA_ENABLE is not done,
there is no half step here so it has nothing to do with device trust.

Jason
