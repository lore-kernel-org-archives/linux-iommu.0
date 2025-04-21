Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3E62165F3
	for <iommu@lists.linux.dev>; Mon, 21 Apr 2025 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745270383; cv=none; b=IPpRiOyWMynathL5FBOBeHxBzFXHoH0xXPWlyimIsiNnA4kzqLHeca2hYvIXqhbXsFm9/MCekaJj7rCjQuMMNOLiNJvQ4pLSKHZub2kHBLRrG3+SmU/1jUONZdUyq4WPPjkqfgyBR5jWoRC+bu8mR3+2up8bKSbtEorQBj7j0PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745270383; c=relaxed/simple;
	bh=y9paRPe3EBkrJsPVpxL3MgtnKFa8kkeGioBWGvUF2m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6w+Kk59wDe39Zq1tROvp2wcIYtdNVZZUY8xrhPg0acIqcGGADRUVmmpHo1zCJI7Hb+A+K/kdlQfEC832q6+GXI8XYr6afv50LScfG7X7WdVJHcacc9MpYR1WySbrcseJVNvRY7u4yxymaClwYKohBRIxNycFvq9QgBElhp2Y60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D1Jt+LcA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1Jt+LcA"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73972a54919so3957445b3a.3
        for <iommu@lists.linux.dev>; Mon, 21 Apr 2025 14:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745270381; x=1745875181; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOxnJAhc6wvN/76rnzdND4XiH0RAh5L8BLwUG18oaZY=;
        b=D1Jt+LcAZC0Xx7yD3AutAnj9waxG0PayVbVEdiDNP4X4JGN2Krz6QocLO7gdCi/z99
         P/aMnTtz7LcpY+bXEoRUhAwQtOLFGS88zW2omZqXq6GHdkczqddfkhB5AVD0mHe1srKo
         h2dOgSznJ4ENXmQUVjWd8pxKxDk/tHBBUKN6XEtBt6cYJRGS2Dx+g9ZmEa+hR/CprJdS
         OWn87r3kMR67LkQrUbraMewWUCW6DdnJXdGQp9JU4aeP3aQHqnkI/dBpcaIlG28kcOU7
         S0h7c1/oocz2iC869KQwk9OTE2bUqHLajJA4JKtHvEI5wTUmvjPu2R9GWGSxgcoQR1DT
         wdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745270381; x=1745875181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOxnJAhc6wvN/76rnzdND4XiH0RAh5L8BLwUG18oaZY=;
        b=l5gQjKc9xz7KEVjVvdEbrRdyXB4fZ5/ZRziryobafxcI85R4MqOdVQfW5intTJKAlY
         OwgEheyT0R5InF9mQTEgWVjoHyCWuSD6e14RYi/q8iPUuVa7DgSFBM1h67aQYn6PTubb
         P4UgC7I5LxTqbLN7xRbtNYBlPF6puZD60oXNn2XYJ7+OgZzelRxA8ci3VldILfvNMn+R
         8WKa+zVYDuIjMrR5HxPEQo7TXrCQ+FQoZV+MJVHLMbndH4zkPnnVK7pMypfweSxAtuWV
         58b/0LgWcNLCEfygrEhaaIZ6XvyZkLkOszVGEb09yc+P4eRJRDq6R8MNiEs38ddKIgn2
         l2RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqDcjWLSkz2dDkJj4YwvYPi26tBfBFtmxvg9qD0w7II+iQLOHATovi5P9fustr9QRhE0opwA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8Jt6DaeF3RC6YLUHaqSOHB3vpFaYjRmpIuUzYLtZ0cPvVbnRQ
	flMsEyTddejuYt86dH+WP6tPXnqeuswzf6PKNPZAB0aqyvB6F1o+Xbng7nE9HA==
X-Gm-Gg: ASbGncsMv+MC6lmFTm8iZYWLzXd5HOst2LG3vkjB8GlnHpyCvEZMlVvJQ8V3PLazskb
	T1M2ls8JMg3np/f9KvsMC/MayEMVXdgV4gxX8FutqLLUgNupIndvGGeR4FCp9DTbWecj14c6Ajb
	IwV6t1HHUDWXaQXPNsTsmF6SGVfW84PQmZ1aoxQ5l3rdvHeE+K1cTK5rO5A7w0/kfCEsgABUwsD
	dLN1Sksv7dJPXRmxz0CMf3PPkOa+dCEYDV7XTPbxoRKcd0aHUeCl9bE4T1ZKCLsug4mubJJbhDV
	4qQOfz3Hm/Uxydgl0Z+WwciiECMLXbJkiRDua9o3Zf6adi75Z6GNnK/BnQGcBRjdALAPNRCsRsU
	my2lkfg==
X-Google-Smtp-Source: AGHT+IFQHuZZplaf8sY7Y2IO0G/qjhqIBZAX4ciEU72ZJiY0NIk0kGrIvFbpMAl14ucHM0THPLNUAw==
X-Received: by 2002:aa7:88d2:0:b0:736:339b:8296 with SMTP id d2e1a72fcca58-73dc1566852mr17070386b3a.18.1745270380314;
        Mon, 21 Apr 2025 14:19:40 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfacdb9bsm7051875b3a.155.2025.04.21.14.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 14:19:39 -0700 (PDT)
Date: Mon, 21 Apr 2025 14:19:35 -0700
From: William McVicker <willmcvicker@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
Message-ID: <aAa2Zx86yUfayPSG@google.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>

Hi Robin,

On 02/28/2025, Robin Murphy wrote:
> In hindsight, there were some crucial subtleties overlooked when moving
> {of,acpi}_dma_configure() to driver probe time to allow waiting for
> IOMMU drivers with -EPROBE_DEFER, and these have become an
> ever-increasing source of problems. The IOMMU API has some fundamental
> assumptions that iommu_probe_device() is called for every device added
> to the system, in the order in which they are added. Calling it in a
> random order or not at all dependent on driver binding leads to
> malformed groups, a potential lack of isolation for devices with no
> driver, and all manner of unexpected concurrency and race conditions.
> We've attempted to mitigate the latter with point-fix bodges like
> iommu_probe_device_lock, but it's a losing battle and the time has come
> to bite the bullet and address the true source of the problem instead.
> 
> The crux of the matter is that the firmware parsing actually serves two
> distinct purposes; one is identifying the IOMMU instance associated with
> a device so we can check its availability, the second is actually
> telling that instance about the relevant firmware-provided data for the
> device. However the latter also depends on the former, and at the time
> there was no good place to defer and retry that separately from the
> availability check we also wanted for client driver probe.
> 
> Nowadays, though, we have a proper notion of multiple IOMMU instances in
> the core API itself, and each one gets a chance to probe its own devices
> upon registration, so we can finally make that work as intended for
> DT/IORT/VIOT platforms too. All we need is for iommu_probe_device() to
> be able to run the iommu_fwspec machinery currently buried deep in the
> wrong end of {of,acpi}_dma_configure(). Luckily it turns out to be
> surprisingly straightforward to bootstrap this transformation by pretty
> much just calling the same path twice. At client driver probe time,
> dev->driver is obviously set; conversely at device_add(), or a
> subsequent bus_iommu_probe(), any device waiting for an IOMMU really
> should *not* have a driver already, so we can use that as a condition to
> disambiguate the two cases, and avoid recursing back into the IOMMU core
> at the wrong times.
> 
> Obviously this isn't the nicest thing, but for now it gives us a
> functional baseline to then unpick the layers in between without many
> more awkward cross-subsystem patches. There are some minor side-effects
> like dma_range_map potentially being created earlier, and some debug
> prints being repeated, but these aren't significantly detrimental. Let's
> make things work first, then deal with making them nice.
> 
> With the basic flow finally in the right order again, the next step is
> probably turning the bus->dma_configure paths inside-out, since all we
> really need from bus code is its notion of which device and input ID(s)
> to parse the common firmware properties with...
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci-driver.c
> Acked-by: Rob Herring (Arm) <robh@kernel.org> # of/device.c
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2:
>  - Comment bus driver changes for clarity
>  - Use dev->iommu as the now-robust replay condition
>  - Drop the device_iommu_mapped() checks in the firmware paths as they
>    weren't doing much - we can't replace probe_device_lock just yet...
>  
>  drivers/acpi/arm64/dma.c        |  5 +++++
>  drivers/acpi/scan.c             |  7 -------
>  drivers/amba/bus.c              |  3 ++-
>  drivers/base/platform.c         |  3 ++-
>  drivers/bus/fsl-mc/fsl-mc-bus.c |  3 ++-
>  drivers/cdx/cdx.c               |  3 ++-
>  drivers/iommu/iommu.c           | 24 +++++++++++++++++++++---
>  drivers/iommu/of_iommu.c        |  7 ++++++-
>  drivers/of/device.c             |  7 ++++++-
>  drivers/pci/pci-driver.c        |  3 ++-
>  10 files changed, 48 insertions(+), 17 deletions(-)
> 

[...]

> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 6f2a33722c52..1813cfd0c4bd 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1451,7 +1451,8 @@ static int platform_dma_configure(struct device *dev)
>  		attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
>  		ret = acpi_dma_configure(dev, attr);
>  	}
> -	if (ret || drv->driver_managed_dma)
> +	/* @drv may not be valid when we're called from the IOMMU layer */
> +	if (ret || !dev->driver || drv->driver_managed_dma)
>  		return ret;
>  
>  	ret = iommu_device_use_default_domain(dev);

I wanted to report a regression here that was exposed by the new probing
behavior. On Pixel 6, we load our kernel modules in parallel which means
probing is done in parallel. This results in a race condition between the IOMMU
thread and the device probing thread. What I'm seeing is at the top of the
function `platform_dma_configure()` when we assign
`drv = to_platform_driver(dev->driver);`, `dev->driver` is NULL which results
in `drv = 0xf...ffd8`. In parallel, if the driver gets bound to the device
before we reach the above if-statement, then `dev->driver != NULL` and we will
de-reference `drv` --  resulting in a kernel panic.

To address this race condition and KP, we need to defer assigning `drv` until
after we check if the driver is bound. Here is what works for me:

----->8-----

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1813cfd0c4bd..6d124447545c 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1440,8 +1440,8 @@ static void platform_shutdown(struct device *_dev)
 
 static int platform_dma_configure(struct device *dev)
 {
-       struct platform_driver *drv = to_platform_driver(dev->driver);
        struct fwnode_handle *fwnode = dev_fwnode(dev);
+       struct platform_driver *drv;
        enum dev_dma_attr attr;
        int ret = 0;
 
@@ -1451,8 +1451,12 @@ static int platform_dma_configure(struct device *dev)
                attr = acpi_get_dma_attr(to_acpi_device_node(fwnode));
                ret = acpi_dma_configure(dev, attr);
        }
-       /* @drv may not be valid when we're called from the IOMMU layer */
-       if (ret || !dev->driver || drv->driver_managed_dma)
+       /* @dev->driver may not be valid when we're called from the IOMMU layer */
+       if (ret || !dev->driver)
+               return ret;
+
+       drv = to_platform_driver(dev->driver);
+       if (drv->driver_managed_dma)
                return ret;
 
        ret = iommu_device_use_default_domain(dev);
--

Please let me know what you think.

Thanks,
Will

[...]
