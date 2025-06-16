Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6B0286880
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090074; cv=none; b=Ar/HSVpugFc71+zgHzri68W3T2z8QHl1Fah/AVILLVzehiq3QvXFFNPX1NkSHa56KitXELhiFlxKV0qld6/4b5SxdGDbMxoPap4wjqaRioLuH1I/s+35+ZowJCwjaGzzYghKGlNJTsKZvbK4NJ506FZPTz3KuX7KC789nSCKqic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090074; c=relaxed/simple;
	bh=ZA6S9shc1QEX3PEyqUllB6Vi85lndLEG0kzkNo7/Ypk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIZ2f202gf6lsiy7zi67+fhOg2x7BHYZdegv01v1tx9glE6shVLHGdFGopjKn06l0c3Po++SicNBugab1eIllf2N+P3gYlZ5AaxkJdwKmW3/GJSEouGBgO6xhWC+VpRcq7X/4WM7iF1pTt9yDPt0WBDHgz6mzectv4KgejN0Bp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QGeKWQby; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QGeKWQby"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4532ff4331cso12489745e9.1
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750090071; x=1750694871; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=66enaQYzVszRsP2d3FubStZt1y7rSXnP5cI/cUMaHAc=;
        b=QGeKWQbyU/SAfHAoO6GtXFXbt3ijSPkUCkuIpKwP475P1jv9cg04C4+4CY478Ua/Su
         sw59k7B/vygjwPNoIltycCd+zYK/LQQVNq/3Wjw72nb71PpAiEDEg9bWDt6vOXOfx30y
         wjafkVSXbXIO0425pCy+Jy7zPDXKOEw7K+JJw68mp0jdbVR8Sh/V80mQx1RBSgylhA0H
         ThVphK6MGTcoM+Gw6nMcI8sSxxn8KHY7rWhs7FBXIQ2yvk+AAcKCgoYSbycR8nPr1TsK
         dfutK5JSBnAAhefmT8munEEBGhJElOCzCxeAhccfj0JV+nk2VaZTt0+TXvVe6yVfDH4H
         qfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090071; x=1750694871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66enaQYzVszRsP2d3FubStZt1y7rSXnP5cI/cUMaHAc=;
        b=C+JhkjHs+vgLCKC76RB8eSJfbWsJonRPebVf7NRrPs6jaI9t1230ZmblgKmor4a0wK
         4Ugmme9nxoHi4RUj/uoRzO3ymFjg5t8USBiWNJUcwqqRM2aIuER+zgaLyFMwGA+YqZuz
         Y+5RV5akyKwxuwMmdrBNauXyM65cW8PHEiKUjqmTTAp52iC4NzvXWI/Ao60hqzMna1+1
         S0RF3WmzCfvgMr8JPqvxFKwVER+ZsaDBrONjluJS9tit9HQpRz5wOCbvacvjW8D22NPg
         keYko32DCbxEAy7ct5JXjtCnrBKVT3/HuO8jupnmgalswOBHLPANHL93JXM8F7x7sJ2n
         0opg==
X-Forwarded-Encrypted: i=1; AJvYcCWs+XVdOZbKTeCe9n3jyT0v2d0ir21RjtTiaH35e1iGoRvYnkgI6aOS/R8oqmWVSenWh0Bxsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNSVlCxOqUcbtKeSlyI1XYVaH1Vf2pnnUIV3SPE5hu0hYmKRVl
	oQzHj1+9XCwS6rLEuVxczWYYlvVp+MwOcW6VmN8KNnPAxziNspkQZVayOvvdYyMHSeQ=
X-Gm-Gg: ASbGncsKR9d6fKUM2XYI4nfwmZYkpfeidllhA2V5+TIh1552tah8f3RM8hASsSIzRFK
	/IwWGnn/vwpcf+k0nObCcZtpGJthQfhcglEcMjQaiDmBnkVaD53ZCl+m6TGXSe9XhHnfuGlqLB8
	/ZXW38vQNbSzVd4kreG8nZMl6tfR+zXK7wbIrEom8WPPh/g9iGZP0i4OrdFtamG0x15/L6/l69V
	eZrM2pkAGGuVAs6Gr+5pRfylKaQOfRkbfAal7wJ4QA2rgeQzoTioqM5fpuFaFhi8JdDujhARDQR
	wdy5YEFmLq0LE5VUOBH6Fc9cuKpvLuLLtvW3CrJGm1o9/bZD+jELA1UL+nhpQaPt9x61a+kpNFl
	YvSCsaj66jCyaHg==
X-Google-Smtp-Source: AGHT+IFm2XOGvEu+c2Vt4oKDTOhDYuX0Zc67/qbAzwRfpRIo4JlzBUdpBKcXvIOmlDkGO4s2VlIKAQ==
X-Received: by 2002:a05:600c:3ba2:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-4533ca79d19mr100567515e9.3.1750090071100;
        Mon, 16 Jun 2025 09:07:51 -0700 (PDT)
Received: from myrica (92.40.185.180.threembb.co.uk. [92.40.185.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b19b32sm11602270f8f.67.2025.06.16.09.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:07:50 -0700 (PDT)
Date: Mon, 16 Jun 2025 17:07:52 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Alyssa Ross <hi@alyssa.is>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, virtualization@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devel@spectrum-os.org, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	eric.auger@redhat.com
Subject: Re: Virtio interrupt remapping
Message-ID: <20250616160735.GA5171@myrica>
References: <c40da5dc-44c0-454e-8b1d-d3f42c299592@gmail.com>
 <20250613181345.GA1350149@myrica>
 <6b661c62-c322-4f2b-8e4a-da1d5c5e48a1@gmail.com>
 <877c1ed9o7.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877c1ed9o7.fsf@alyssa.is>

[+Eric]

On Sat, Jun 14, 2025 at 10:11:52AM +0200, Alyssa Ross wrote:
> Demi Marie Obenour <demiobenour@gmail.com> writes:
> 
> > On 6/13/25 14:13, Jean-Philippe Brucker wrote:
> >> Hi,
> >> 
> >> On Fri, Jun 13, 2025 at 01:08:07PM -0400, Demi Marie Obenour wrote:
> >>> I’m working on virtio-IOMMU interrupt remapping for Spectrum OS [1],
> >>> and am running into a problem.  All of the current interrupt remapping
> >>> drivers use __init code during initialization, and I’m not sure how to
> >>> plumb the struct virtio_device * into the IOMMU initialization code.
> >>>
> >>> What is the proper way to do this, where “proper” means that it doesn’t
> >>> do something disgusting like “stuff the virtio device in a global
> >>> variable”?
> >> 
> >> I'm not familiar at all with interrupt remapping, but I suspect a major
> >> hurdle will be device probing order: the PCI subsystem probes the
> >> virtio-pci transport device relatively late during boot, and the virtio
> >> driver probes the virtio-iommu device afterwards, at which point we can
> >> call viommu_probe() and inspect the device features and config.  This can
> >> be quite late in userspace if virtio and virtio-iommu get loaded as
> >> modules (which distros tend to do).> 
> >> The way we know to hold off initializing dependent devices before the
> >> IOMMU is ready is by reading the firmware tables. In devicetree the
> >> "msi-parent" and "msi-map" properties point to the interrupt remapping
> >> device, so by reading those Linux knows to wait for the probe of the
> >> remapping device before setting up those endpoints. The ACPI VIOT
> >> describes this topology as well, although at the moment it does not have
> >> separate graphs for MMU and interrupts, like devicetree does (could
> >> probably be added to the spec if needed, but I'm guessing the topologies
> >> may be the same for a VM).  If the interrupt infrastructure supports
> >> probe deferral, then that's probably the way to go.
> >
> > I don't see any examples of probe deferral in the codebase.

I think the flow with VIOT is roughly:

 // Scan an endpoint
 pci_bus_add_device()
  device_attach()
   driver_probe_device()
    really_probe()
     dev->bus->dma_configure()
      pci_dma_configure()
       acpi_dma_configure()
        acpi_iommu_configure_id()
         viot_iommu_configure()
	  viot_dev_iommu_init()
	   acpi_iommu_fwspec_init()
	    iommu_fwspec_init()
	     driver_deferred_probe_check_state()
	     iommu ready ? 0 : -EPROBE_DEFER

So if the IOMMU isn't available at this point, base/dd.c adds the device
to the deferred probe list, to be retried later. Later:

 // Scan the IOMMU
 ...
  virtio_dev_probe()
   viommu_probe()
    iommu_device_register()
     add to iommu_device_list
     iommu->ready = true

I believe after this probe completes, base/dd.c checks if dependent
devices can now be probed:

 driver_bound()
  driver_deferred_probe_trigger()

That should all be working and you don't need to add anything. The
question is whether the interrupt core supports starting the setup of
interrupt remapping in viommu_probe(), or if it needs to know of the
IOMMU's config and features earlier during boot. Even if the viommu driver
is builtin, those info may not be available early enough since they
require PCI and virtio probe.

> > Would it instead be possible to require virtio-iommu (and thus virtio)
> > to be built-in rather than modules?
> 
> It's certainly possible to have an optional feature in the kernel that
> depends on a module being built in where it otherwise wouldn't have to be.

Agree, no problem requiring this as a first step, but the IOMMU probe
might still not be early enough. 

Thanks,
Jean
