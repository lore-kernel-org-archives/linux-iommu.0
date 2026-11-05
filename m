Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899480;
	b=b8v7VvOS/kN80lndHbfqa9ZG9T2o/UlJCN8p7fM51QAug/kqadZrKLpb6VwzrHHsPuku
	 0j48RSRFni7G1pdVsKIuAc3pGSno45qDw3J375P0NKNXMd+xuGsrV3OtepYvQTWF9jwJk
	 7u3nK8r8cD3qksVPSNwJ0ZlBI6M9wzyFRAcWmxwGQHO/x4tyubkD1+w3VpsWhGrrYxSG4
	 r3OOuehh/vyaKMwl44dM/tAbGo0IzuVs6c/nXp27w/9IAoXMBcBu8kter7D8zpajly2+f
	 HGSkpLNl40Vp1N+uQPutxSsfGkS34NzUc4ykT7Qy5T1wD+g5o3umymXuOGaYE7Qqcrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+Sc9yPGaNTmoDAc39XzEsbXpXvtl7Fk3dFBI/g/ZPmw=;
	b=Zsnhy+8AxLM/VOXE9OCbglHk+4K7ldMm+ebC4I1iaImI8IIFrc2ku7EdXnybvudOvy4T
	 mVRS9h1YVso1BzDzJzjdw6Cuno+THFPf88dRR5NEkPCJfkLYrB9NYL9W5uwOxw7mF/sI2
	 70SHu23NMQPh4cu8vS31V4Osy6xqTljuaoidwpVnMbwHU8qNXtTSvQV6wEJ1w5Q5BYbEy
	 /NIy2pIbz38NQYd7qyP1CCElMn3JMHmDsBxSkwZuXJvbRYIBSCQ10L29zq1+Xq01MbGEW
	 P+GsQqUv4qh4UrC5GTnSWY6mF2p1Njl1dM6e4dEUQpYJCGYSziewt9s0T3jJa5/mA9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=wB0U56+d;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D28F606D83D
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 17:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D28F606D83D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=wB0U56+d
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53c4b82919fso26190051cf.0
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 09:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1793899478; x=1794504278; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Sc9yPGaNTmoDAc39XzEsbXpXvtl7Fk3dFBI/g/ZPmw=;
        b=wB0U56+dnYBxAhJZFcxp3M39nx4FSrFxtybQsmVG9510aidN1tTt2xu21n0Z8XZUl9
         +tAANCx1VKfE25ZiSElnEP3niYVUgWlPhnfIeYrHpueGCSwuhRwqofAAV0Zg2XqWgcgV
         MRTkgzQ0sVKh/we+x3qoAaqL8e7zQ1yFg8iugG1Cta+wXy5QIPvBpf+ddNexlD3Ikh8Y
         rkPSCCgKXv16KXdM3lvKvhh215QThS7LW/nhLJA1jmhpyLFsPYmYL2GyMC3q0hNQNB2o
         9vGU96QdPvzaMQlEfcPEBqvJXZKr/QW4cFzjtb+jUdPoRsVI/RBBBQZYmWCfetdbCI5l
         BuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793899478; x=1794504278;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Sc9yPGaNTmoDAc39XzEsbXpXvtl7Fk3dFBI/g/ZPmw=;
        b=fvYH2ZWvcUIPJ1VMtozQWiSf4DTm/lTpwA6intMiVKVLbM+8xrjeUL8puMKmS8bADV
         Q7bgzG0CQvTR+HrLapT4hFhvXi7zpBXBvCrcAmP1jC873VSt1huFfjOW/VbSWXoCJQnP
         fMbeAc0pXSgcj6sIDgn1pgS+lj8/7YYsRFRgsyA1JdoJfv7xl6FxXQMu+t0Usdka1uA+
         Dq4QYDmydwMO+vOiW7qcz8PPdYmuiMpMs+PNEtlXkM5L1xGIeDZFit126Y8gkLGQ9+Cf
         QpXaOcEMRzs+84GpwZveX4GWXtmb06iGlDwBqUtbG/RUxJ5vCiTFZ6exIsMctKy+hpeZ
         l8qg==
X-Forwarded-Encrypted: i=1; AKwUvByHc+jbHqYA3hOjs4sp0xE+pQI/fe3s9mLzKxXe4pIbxJxEoZQugDNr6N78fa+6fwBtWvMq7w==@lists.linux.dev
X-Gm-Message-State: APuU4Z+BWiSPWkq6xdU3tecamEA626P5EPeS0kEZlcSwXX7f8dC7fkc3
	dqkRulR2vOIgcxvnRhnL2QoRVepstXVGXPm2OU4OH5L+U6BQ5m1nyXXVa5flkJyKEw==
X-Gm-Gg: AYBFou3uU1elvrzOiF20dQVfWYqvbuj4JFMW5VziXE57+tGDys22G0QUv95Ba/GT7Mt
	RG/V9YYwAv4iwrqkXm0vs4IfSjThGUpWS/N+x5UaT3t7kSlhx4vsTlpGpQ1dkH3RE127iB/kEFQ
	2wFr6VLen7IaPtkzjV7BKQi308kYrEi3uzLpmgQOiZBMDULC0mt+TNpsqBoeSsNILxA17pJ+y9S
	6LbqPxuJHnTOMevMBAIdniSjKTdrWRL5LelTRUePB8SJV7PHA9O2WHpqKN9tkvZAgTbjacIcG10
	d/hbHrmjHJpNrVdtjnLst1vmeg1pbXXQYla5tf4YPVqb8DOGtDUMz25ptqogIhIyaB1B6i0mEsF
	VJXJkspWotSeYf+X2/fvSDuotmIZau7H2MMLIY87VQqMtDy+udSXyIyZ9t83V59HF7TVqnqW6f5
	IsrwOHAwlSePSOqY0QLfnNkxloH3HoSfv8fIIVF4huL9tw3CLtJ4kdJDvd17u/xSnEg2Mb0W8cO
	hpHDV84zOo9hzE0ifpM03ZPSFcQ/Mxm4mS3XGI1KZaR95IfzR/xi5z0rEBrnu/2/j44NImyPfZy
	WFnydPoirE6MLNqsO6d1lAN7UlO1
X-Received: by 2002:a05:622a:2515:b0:536:52ae:d92c with SMTP id d75a77b69052e-542b6e55bebmr328898701cf.35.1793899478212;
        Thu, 05 Nov 2026 09:24:38 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10a6ca24sm57130131cf.14.2026.11.05.09.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:24:37 -0800 (PST)
Date: Thu, 5 Nov 2026 12:24:33 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
	iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 05/17] USB: Lock registered interfaces during manual
 driver binding
Message-ID: <bb83fe3c-cebb-4bc8-bfc9-24df1cf72b0b@rowland.harvard.edu>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-5-1e536825b4eb@nvidia.com>
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
In-Reply-To: <20261105-device-trust-core-v1-5-1e536825b4eb@nvidia.com>

On Thu, Nov 05, 2026 at 01:42:18PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Interface claims hold the USB device lock, but device_bind_driver()
> requires the target interface lock. Without it, trust-policy writes can
> race admission.

This says nothing about usb_driver_release_refused_claim() and the code 
related to it.  It is an incomplete description of the patch.

Note that nothing prevents drivers from using an interface they claim 
before that interface is registered.  For your scheme to work properly, 
you should make sure the claim is authorized when 
usb_driver_claim_interface() is called, not when the interface is 
registered.

Alan Stern

> +/*
> + * The driver core refused to bind an interface that a sibling claimed before
> + * it was registered, and dropped the claim. Let the claimant release the
> + * interface instead of operating it with a bound interface but no driver.
> + */
> +void usb_driver_release_refused_claim(struct usb_interface *iface,
> +				      struct device_driver *claimant)
> +{
> +	struct device *dev = &iface->dev;
> +
> +	device_lock(dev);
> +	if (!dev->driver && iface->condition == USB_INTERFACE_BOUND) {
> +		dev->driver = claimant;
> +		usb_unbind_interface(dev);
> +		dev_set_drvdata(dev, NULL);
> +		dev->driver = NULL;
> +	}
> +	device_unlock(dev);
> +}
> +
>  /* returns 0 if no match, 1 if match */
>  int usb_match_device(struct usb_device *dev, const struct usb_device_id *id)
>  {
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index a738d03c23eac..d35a7710c8ef4 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -2264,6 +2264,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>  	 */
>  	for (i = 0; i < nintf; ++i) {
>  		struct usb_interface *intf = cp->interface[i];
> +		struct device_driver *claimant;
>  
>  		if (intf->dev.of_node &&
>  		    !of_device_is_available(intf->dev.of_node)) {
> @@ -2277,7 +2278,14 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>  			dev_name(&intf->dev), configuration,
>  			intf->cur_altsetting->desc.bInterfaceNumber);
>  		device_enable_async_suspend(&intf->dev);
> +		claimant = intf->dev.driver;
> +		if (claimant && !try_module_get(claimant->owner))
> +			claimant = NULL;
>  		ret = device_add(&intf->dev);
> +		if (!ret && claimant && !intf->dev.driver)
> +			usb_driver_release_refused_claim(intf, claimant);
> +		if (claimant)
> +			module_put(claimant->owner);
>  		if (ret != 0) {
>  			dev_err(&dev->dev, "device_add(%s) --> %d\n",
>  				dev_name(&intf->dev), ret);
> diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
> index a9b37aeb515be..293340a48b6c5 100644
> --- a/drivers/usb/core/usb.h
> +++ b/drivers/usb/core/usb.h
> @@ -49,6 +49,8 @@ extern int usb_set_isoch_delay(struct usb_device *dev);
>  extern int usb_get_bos_descriptor(struct usb_device *dev);
>  extern void usb_release_bos_descriptor(struct usb_device *dev);
>  extern int usb_set_configuration(struct usb_device *dev, int configuration);
> +void usb_driver_release_refused_claim(struct usb_interface *iface,
> +				      struct device_driver *claimant);
>  extern int usb_choose_configuration(struct usb_device *udev);
>  extern int usb_generic_driver_probe(struct usb_device *udev);
>  extern void usb_generic_driver_disconnect(struct usb_device *udev);
> 
> -- 
> 2.56.0
