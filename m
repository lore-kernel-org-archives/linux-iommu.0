Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E507B5187EB
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750441; cv=none; b=fPlUztndvo0IM6rU5uSK0g5TPO6n3GxtMY8SYk5vIRcP75mJP2Tl+JdmURZ00LXlBx1uzSRKDSMeHytIMBfVQgXnLtblnyuXuROhtNWVdAIAyiuHGSsVEdbmBeeogLje+w6GtiVcx7HEuGE434Gr18/MZP2/WdvUpb05TB9+xxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750441; c=relaxed/simple;
	bh=2EvlZasgpZ/lIxySBiQPHv2EmQ3k7uR84drJbmi41ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvzl0Z/0esneHpdj1WQvELPFFmroim0KePgRdvtKP7dUAVVZJW4yqIKGtIqeZqmRjqgeyxlY4NKPTCXp0RHpBM4gIHIooF7N3arUwkAa3munLbP/LEKkzG8TXm1NgNHGQPfpBqN/tzZgxKA5zB+Y8hZd8WG9sACWjyfy43OzJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uQsmyq1p; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uQsmyq1p"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469a34908so990842b3a.0
        for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 09:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789750438; x=1790355238; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vVUde7IRkQCiapOxCzvLvGC5LfRJvKccbFMpxGxukJw=;
        b=uQsmyq1pq4IhhVufDyd46Pa0k/KgFIak7RlU3jFZBwf0qn6bdFXAH9xLMVcjrXP14a
         14LqegNjxl9FH/Us8oJCzQ9RTSfzIZAmSmTTKW0WxQTmXryyZt/7xwP1jV7F1/ugx1Vc
         cm9s2WjYjVfb9rezVwlqWZ6F0nMmT3ZPmNo7AjORRaydV0sROGurQcVGvq7zYXFeaDO4
         Uw3YgwhH0m0JTsugFSYcn7ovUisMn4nFoqJr87Arc/N8NHO+NOgrDy3SwOteUrY6pEqv
         eO5pXwOxgn9np5VPh6OpFBUMqy3F6N37r2OV9ga6MBMVzU7aTGIo52dZYryqjYs6TvWn
         ulzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789750438; x=1790355238;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vVUde7IRkQCiapOxCzvLvGC5LfRJvKccbFMpxGxukJw=;
        b=CPuOyBp5RVvgR3M0VcLp29u6qD2X3jL9O1TvfMObbmfpDafp8JAWBxNd5gUxNebu4z
         FrumEsap3Oe23lqkXArHZieYwnGL+9vuMiGfvZDHI79t19cPGrpR2I+oVyMXUnljp5A6
         +FDjwl1T8yrvpPkNPgxkSOrrOXLOmBrEO0Kp6gnvCI3WXqnQUy/id6pjAvOtFYqlafRO
         UfHCBft3pccB4mrLwNIDPHR6IUmMk+Yo41Ys/S0SNW2tEVJhSHEwxQVxZLCwusm1zD0D
         vLBw25qZbqixFpubUKjwEhSlwt4wZP7lEbLfzA2ydTeXwDwdjK7thfB5RBuJUMUvOJ+M
         HxnQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwclqNu7KdWIpNctGcztHyH7G2kEPtwzqfgvf5pI+eaQJjB2pxANaZHncxEq6cmWZ+l6+4sA==@lists.linux.dev
X-Gm-Message-State: AFuF++l4HawfveH3Nb8McB72suOCXIrlfsQTke0knBeAZ28wwIVWG9W2
	H4tE16OIfrzSKTxjNh3qyVEaU5ClDTfesZZlYQAo6tjTLHvhFIZ4RaxP62tw6juQdvk=
X-Gm-Gg: AYBFou0bhZ9t0uHKQ1arAabovQ3KOcmzSmA1bQnH9ha/eA4ltX5nJy60izrbij4HjnQ
	khv3ew93PKMghHUu0YjxHWc/rN6aIpNx2heHaLPohKVkKuW9lIbyzrNQE3sEwMmVkfC95+YAVlw
	viRU/7enxIO2/WcDznzMHY0Kk/OJXr//HHcTX0yvuVnhiC0lpbtEg5SGyPh4ppl0ksWvHmHWLQ4
	JEB2Embh2WmUPq/v/ZcyX0zHYDEzV5RZhGTjl83u4tLUR3wyQHrutYPoHODVMiVgrgmZlqsyFKI
	tsXSal+8fI4+F18tVtorDfwvv+0iKm9H/bWE2svANx+qiL0osUc5AV3UEv5R5vNgNlg9SUmM+mK
	uo3vIX4jzYRhx3xWg/17qxL6RswXK6F7U8z4I2yH49mj78vU3kdwVK/mIQNpPbAc18UGKztDU5w
	ifMHJ+cyWO4zBsaT9QFbxAMu6E0y7UXux9gW5JsPzoaJ6caNnEA3bmupl82gI0sTnx4pOMHdLPr
	58=
X-Received: by 2002:a05:6a00:ad89:b0:847:77e9:acbb with SMTP id d2e1a72fcca58-874dc3f65a8mr6351046b3a.13.1789750438072;
        Fri, 18 Sep 2026 09:53:58 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:ff7b:49b4:123e:4989])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a6bec901sm69019b3a.4.2026.09.18.09.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:53:57 -0700 (PDT)
Date: Fri, 18 Sep 2026 10:53:54 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Francesco Valla <francesco@valla.it>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	imx@lists.linux.dev, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 00/12] remoteproc: add support for any virtio device
Message-ID: <aq1sooGCYUiWbhMH@p14s>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>

Hi Francesco,

I have started reviewing this set but given the size and implications, it will
take me a few days to get through.

Thanks,
Mathieu


On Wed, Sep 16, 2026 at 11:10:45PM +0200, Francesco Valla wrote:
> Hello,
> 
> this patch series introduces the possibility to support generic virtio
> devices over the remotepoc transport, whereas today only rpmsg and
> virtio-console are supported.
> 
> == Introduction ==
> 
> Support for devices other than rpmsg was originally planned [1] and is
> declared inside the documentation [2], but is in practice not there for
> the majority of (if not all) the platforms that provide remoteproc
> capabilities due to memory allocation.
> 
> While vrings are pre-allocated in an area that is reachable by both the
> local (i.e.; Linux) and remote processors, buffers produced by virtio
> drivers aren't, since they typically get allocated through kmalloc.
> The aforementioned rpmsg and virtio-console drivers instead use a trick
> to overcome this limitation and allocate these buffers directly from
> the remoteproc device's coherent memory area, somewhat breaking the
> separation between the driver and the underlying transport.
> 
> == Well, nice, but why? ==
> 
> Main usecase is sharing/virtualization of devices in hypervisor-less
> mixed-criticality contexts, where a subset of peripherals are controlled
> by a "safety" real-time processor but still need to be used by the Linux
> world. Several solutions have been / are being proposed [3] [4], but
> none of them re-uses the existing, standardized virtio specifications. 
> 
> == The proposal ==
> 
> The proposed approach is to introduce a bounce buffering mechanism that
> is transparent to the drivers and can expose to remoteproc devices only
> memory areas they can access. This is obtained by defining the .map
> memeber of each registered vdev and use the map() and unmap() callback
> to bounce data to and from the remote processor, just like the swiotlb
> framework is doing in other contexts, using the device's coherent memory
> area and the associated functions to allocate the bounce buffers.
> 
> During the map() callback the address of the incoming buffer is compared
> against the coherent memory address base and size, to pass through
> buffers already suitable for remoteproc usage (e.g.: the ones allocated
> by the rpmsg framework).
> 
> == Status and open points ==
> 
> The series was tested against a custom Zephyr application [5] running on
> the Cortex-M33 processor of an i.MX93 and exposing six different virtio
> devices:
> 
>   - rpmsg
>   - entropy (rng)
>   - gpio
>   - i2c
>   - spi
>   - can
> 
> On top of three of them (unsurprisingly: i2c, spi, and gpio) several
> devices where declared inside Linux devicetree and successfully used
> (well, technically I'm still experiencing difficulties with gpio
> interrupts not firing on the M33, but that's not really related to the
> series). 
> 
> Several open points are still present, and needs to be either
> investigated or discussed:
> 
>   - for each bounce buffer an entire page is allocated from the coherent
>     memory pool; this is a waste for most of the allocations, which take
>     on average 32 to 64 bytes. An option can be to initialize a DMA pool
>     on one page and allocate small buffers from it?
> 
>   - the support in its current form allocates more memory than before
>     (for bounce buffer tracking) also for existing usecases (i.e.,
>     mainly rpmsg).
> 
>   - an additional issue still exist - and is not solved by this series -
>     for a subset of virtio devices: communication through the device's
>     config space. The remoteproc transport expects this config space to
>     be somewhat constant, and there is no provision to sync changes made
>     by the driver with the remote device. This prevents e.g.
>     virtio-input to work.  
> 
>   - device de-registration on remoteproc stop is causing oopses (under
>     investigation - might no be strictly tied to the series)
> 
> == Patches breakdown ==
> 
> Patches 1 and 2 are cleanups to the remoteproc-virtio driver and could
> be applied independently of this series.
> 
> Patch 3 was submitted a couple of months ago [6] and paves the road for
> the actual support of generic virtio devices, removing the fixed number
> of 2 for the vrings associated to a vdev.
> 
> Patch 4 introduces two new APIs for coherent memory areas associated to
> devices that are used later.
> 
> Patch 5 might somewhat be controversial, as it unconditionally defines
> the VIRTIO_F_VERSION_1 feature for all vdevs. This is required to
> support some virtio device types, and there is no other mean of
> defining it, since the field reserved for features inside the resource
> table is limited to 32 bits. Given that the 1.x virtio specifications
> are ~10 years old this still seems reasonable.
> 
> Patch 6 is were the bounce buffering mechanism is introduced; another
> feature (VIRTIO_F_ACCESS_PLATFORM) is there unconditionally defined to
> force the virtio framework to use the new map APIs.
> 
> Patches 7 and 8 are new devicetree bindings, the first for spi-virtio
> (modelled against the existing ones for gpio-virtio and i2c-virtio) and
> the second for declaring virtio device inside a devicetree. This is not
> required for some devices (e.g.: can, net, gpu), but for others is
> necessary to declare child devices and link them.
> 
> Patch 9 is used to convince the remoteproc-virtio transport to parse the
> bindings just defined; it is worth noting that the virtio framework
> already has the support for devicetree declarations and this adds only
> the glue between the existing support and remoteproc.
> 
> Patches 10 and 11 are i.MX-specific and enable the usage of the newly
> introduced support on this family of platforms. The first one might
> probably be sumbitted as-is independently of the series, as it aligns
> the behavior of imx-rproc to the other platforms in relation to mailbox
> usage.
> 
> Finally, patch 12 is the PoC that has been used to develop and test the
> series and shall not be merged.
> 
> ======
> 
> Thank you in advance for any comment you may want to leave.
> 
> Regards,
> Francesco
> 
> [1] https://lore.kernel.org/all/1330589497-4139-1-git-send-email-ohad@wizery.com/
> [2] https://elixir.bootlin.com/linux/v7.2.5/source/Documentation/staging/remoteproc.rst#L26
> [3] https://lore.kernel.org/linux-remoteproc/20260721204704.400781-1-shenwei.wang@oss.nxp.com/
> [4] https://cfp.embedded-recipes.org/er2026/talk/PCYPJP/
> [5] https://github.com/WallaceIT/zephyr/tree/multi_vdev
> [6] https://lore.kernel.org/all/20260621-vring_flex-v1-1-c6c582fbe94b@valla.it/
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
> Francesco Valla (12):
>       remoteproc: virtio: cleanup rproc_add_virtio_dev error path
>       remoteproc: virtio: replace commas with semicolons
>       remoteproc: virtio: support dynamic number of vrings
>       dma-coherent: add base and size APIs
>       remoteproc: always report VIRTIO_F_VERSION_1 feature
>       remoteproc: virtio: add bounce buffering for data buffers
>       dt-bindings: spi: add bindings for spi-virtio
>       dt-bindings: remoteproc: add remoteproc-virtio
>       remoteproc: search for a fwnode during vdev registration
>       remoteproc: imx_rproc: always use non-blocking mailboxes
>       dt-bindings: remoteproc: imx-rproc: support virtio
>       PoC: arm64: dts: imx93-11x11-frdm: add multiple vdevs
> 
>  .../bindings/remoteproc/fsl,imx-rproc.yaml         |   3 +-
>  .../bindings/remoteproc/remoteproc-virtio.yaml     |  89 +++++++++
>  .../devicetree/bindings/spi/spi-virtio.yaml        |  52 +++++
>  arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts | 128 +++++++++++-
>  drivers/remoteproc/imx_rproc.c                     |  49 +----
>  drivers/remoteproc/imx_rproc.h                     |   1 -
>  drivers/remoteproc/remoteproc_core.c               |  43 +++-
>  drivers/remoteproc/remoteproc_virtio.c             | 222 ++++++++++++++++++---
>  include/linux/dma-map-ops.h                        |  10 +
>  include/linux/remoteproc.h                         |  24 ++-
>  kernel/dma/coherent.c                              |  34 ++++
>  11 files changed, 562 insertions(+), 93 deletions(-)
> ---
> base-commit: 9b87fdc9af2fbfcdb5c24a64139685ef80f6573f
> change-id: 20260915-remoteproc_virtio_map-bcf32a5fab54
> 
> Best regards,
> --  
> Francesco Valla <francesco@valla.it>
> 
