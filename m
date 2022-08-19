Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7292418E
	for <iommu@lists.linux.dev>; Fri, 19 Aug 2022 10:39:01 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id j7so4709268wrh.3
        for <iommu@lists.linux.dev>; Fri, 19 Aug 2022 03:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=txDRCxRE+VL20xCVVKpaRBEi6WdjaaEzP1riuovODtA=;
        b=s64w0EXyy5tHx2ognjpZotVbikonYpeogP/jvIz7yjldDSC52+4PNsKcIgWGCeuTHH
         JOZY54/CLWzUbgrOdBaSBU9DongZve4uDkWX+kdqAwZS+Vhj2qeJtJsrd5etV7c91Luw
         S0DCYz5fTXwjDnLi56C3X9iccyD5TKejyzj1quK4L5jzrhqzNm3PTixYH4TwIvQfeaFv
         IfuZW1JXBz//5wqYmC7n4iHUmUv9TBUHR5z/xabmtAjgpURQ0MLRO4NLV1q7I1YG9cwq
         +C/1X8FS9b1iKOZ+aPVCQta2JN4Cmdyny4NByeB6bYo7TBIDj2ZzS+1x23Kam0otkQnz
         U+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=txDRCxRE+VL20xCVVKpaRBEi6WdjaaEzP1riuovODtA=;
        b=TSwl6oO9SxZ2Cj6MpgD4YGbFCwg4rc5IsEItBLidT8FAedOpR8zxPOoAH6lJu22gue
         WbqelZK5cfFABhRXphBe0VWhwRNyuPeD3pFxRbMJqNZ1AU2XWJOErRmfnd0PKjgnWDg/
         n29XBjmaZQzlS3jBpgLYYj9/wClaOF43HQP+TmGqy4+7oOFKOJ9f3kQEynWWF+rX6p27
         xR4DKQKZBEZsQ6nIbh0gols5twnlrChuW1d/vVY1O3O/MBtwotTrbh5tFADUVR5KHJmb
         qYH+MMqLdmf03hgVMNNG0iZPw92Am1NNkEWXjNU7eLuwUQsERM4lrOU7Xg9IOXM/uW/k
         XzjA==
X-Gm-Message-State: ACgBeo2/Y33EdPRTY/Z2y6DhG0adp8BYBLJbrB4jUFy0+wpXnY+VQNti
	N5qV5WGvpQeF+loFreWuHyvZPQ==
X-Google-Smtp-Source: AA6agR71/L10zVJIfNJxviy2jwMfAe538/VFKZU9zAWlu5Jrgb16C/Z8Pths9R17WlqRfNJmzLd74A==
X-Received: by 2002:adf:f2c1:0:b0:223:a7d2:4283 with SMTP id d1-20020adff2c1000000b00223a7d24283mr3680639wrp.485.1660905539632;
        Fri, 19 Aug 2022 03:38:59 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id c188-20020a1c35c5000000b003a5f4fccd4asm8262334wma.35.2022.08.19.03.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 03:38:59 -0700 (PDT)
Date: Fri, 19 Aug 2022 11:38:56 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2] iommu/virtio: Fix interaction with VFIO
Message-ID: <Yv9oQPtlX+7xw3q5@myrica>
References: <20220818163801.1011548-1-jean-philippe@linaro.org>
 <51efe220-9eb2-b52f-81e3-45949e51fb27@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51efe220-9eb2-b52f-81e3-45949e51fb27@arm.com>

On Thu, Aug 18, 2022 at 09:10:25PM +0100, Robin Murphy wrote:
> On 2022-08-18 17:38, Jean-Philippe Brucker wrote:
> > Commit e8ae0e140c05 ("vfio: Require that devices support DMA cache
> > coherence") requires IOMMU drivers to advertise
> > IOMMU_CAP_CACHE_COHERENCY, in order to be used by VFIO. Since VFIO does
> > not provide to userspace the ability to maintain coherency through cache
> > invalidations, it requires hardware coherency. Advertise the capability
> > in order to restore VFIO support.
> > 
> > The meaning of IOMMU_CAP_CACHE_COHERENCY also changed from "IOMMU can
> > enforce cache coherent DMA transactions" to "IOMMU_CACHE is supported".
> > While virtio-iommu cannot enforce coherency (of PCIe no-snoop
> > transactions), it does support IOMMU_CACHE.
> > 
> > Non-coherent accesses are not currently a concern for virtio-iommu
> > because host OSes only assign coherent devices,
> 
> Is that guaranteed though? I see nothing in VFIO checking *device*
> coherency, only that the *IOMMU* can impose it via this capability, which
> would form a very circular argument.

Yes the wording is wrong here, more like "host OSes only assign devices
whose accesses are coherent". And it's not guaranteed, just I'm still
looking for a realistic counter-example. I guess a good indicator would be
a VMM that presents a device without 'dma-coherent'.

> We can no longer say that in practice
> nobody has a VFIO-capable IOMMU in front of non-coherent PCI, now that
> Rockchip RK3588 boards are about to start shipping (at best we can only say
> that they still won't have the SMMUs in the DT until I've finished ripping
> up the bus ops).

Ah, I was hoping that vfio-pci should only be concerned about no-snoop. Do
you know if your series [2] ensures that the SMMU driver doesn't report
IOMMU_CAP_CACHE_COHERENCY for that system?

> 
> > and the guest does not
> > enable PCIe no-snoop. Nevertheless, we can summarize here the possible
> > support for non-coherent DMA:
> > 
> > (1) When accesses from a hardware endpoint are not coherent. The host
> >      would describe such a device using firmware methods ('dma-coherent'
> >      in device-tree, '_CCA' in ACPI), since they are also needed without
> >      a vIOMMU. In this case mappings are created without IOMMU_CACHE.
> >      virtio-iommu doesn't need any additional support. It sends the same
> >      requests as for coherent devices.
> > 
> > (2) When the physical IOMMU supports non-cacheable mappings. Supporting
> >      those would require a new feature in virtio-iommu, new PROBE request
> >      property and MAP flags. Device drivers would use a new API to
> >      discover this since it depends on the architecture and the physical
> >      IOMMU.
> > 
> > (3) When the hardware supports PCIe no-snoop. Some architecture do not
> >      support this either (whether no-snoop is supported by an Arm system
> >      is not discoverable by software). If Linux did enable no-snoop in
> >      endpoints on x86, then virtio-iommu would need additional feature,
> >      PROBE property, ATTACH and/or MAP flags to support enforcing snoop.
> 
> That's not an "if" - various Linux drivers *do* use no-snoop, which IIUC is
> the main reason for VFIO wanting to enforce this in the first place. For
> example, see the big fat comment in drm_arch_can_wc_memory() if you've
> forgotten the fun we had with AMD GPUs in the TX2 boxes back in the day ;)

Ah duh, I missed that PCI_EXP_DEVCTL_NOSNOOP_EN defaults to 1, of course
it does. So I think VFIO should clear it on Arm and make it read-only,
since the SMMU can't force-snoop like on x86. I'd be tempted to do that if
CONFIG_ARM{,64} is enabled, but checking a new IOMMU capability may be
cleaner.

Thanks,
Jean

> 
> This is what I was getting at in reply to v1, it's really not a "this is
> fine as things stand" kind of patch, it's a "this is the best we can do to
> be less wrong for expected usage, but still definitely not right".
> Admittedly I downplayed that a little in [2] by deliberately avoiding all
> mention of no-snoop, but only because that's such a horrific unsolvable mess
> it's hardly worth the pain of bringing up...
> 
> Cheers,
> Robin.
> 
> > Fixes: e8ae0e140c05 ("vfio: Require that devices support DMA cache coherence")
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > 
> > Since v1 [1], I added some details to the commit message. This fix is
> > still needed for v5.19 and v6.0.
> > 
> > I can improve the check once Robin's change [2] is merged:
> > capable(IOMMU_CAP_CACHE_COHERENCY) could return dev->dma_coherent for
> > case (1) above.
> > 
> > [1] https://lore.kernel.org/linux-iommu/20220714111059.708735-1-jean-philippe@linaro.org/
> > [2] https://lore.kernel.org/linux-iommu/d8bd8777d06929ad8f49df7fc80e1b9af32a41b5.1660574547.git.robin.murphy@arm.com/
> > ---
> >   drivers/iommu/virtio-iommu.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index 08eeafc9529f..80151176ba12 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -1006,7 +1006,18 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
> >   	return iommu_fwspec_add_ids(dev, args->args, 1);
> >   }
> > +static bool viommu_capable(enum iommu_cap cap)
> > +{
> > +	switch (cap) {
> > +	case IOMMU_CAP_CACHE_COHERENCY:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> >   static struct iommu_ops viommu_ops = {
> > +	.capable		= viommu_capable,
> >   	.domain_alloc		= viommu_domain_alloc,
> >   	.probe_device		= viommu_probe_device,
> >   	.probe_finalize		= viommu_probe_finalize,
