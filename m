Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FB22EAB89
	for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256050; cv=none; b=tVYg2fsLQZMSJ1V6bzr7lVmZuaKjlByjlJAbPkcE+TsbvXJRfAU8zLwACpD2/lHDjhtu8huhfWws5YS/5ja2qe1w7Yd8EtVou0NCLr2LVaF/zSDISIJXf2Q8boEUS+kmL2uPml31+qBJKv4atV5A/0WJxw77d8IboN/FUCH/JWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256050; c=relaxed/simple;
	bh=YgtPxwKPTeZEZYoIXt8HkosylZM3S9CVqdbZuAkboEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxVkL2Wxmb3+41cq9VTmlOTVM32m/zd+qjfBQkCo/bqJX9tbnBTAkAuuqXJ42d0i9zl9BbIkOdKgGU+x3kmZmPXET2syPas9uDZj9vks6gw8Y0pNoeknnrfrat+XuaxPXZfojlHPI7VNdZniKOR1dIjLgccHWWnmwGNl8QqtHUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=MF5ej+JY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MF5ej+JY"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-606b6dbe316so14519592a12.3
        for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1750256047; x=1750860847; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWbyA4a1n1aVjvP6ctgBaCKRdhrm2Tmki3ui2GQz4OQ=;
        b=MF5ej+JY6qAMSIQyaetAUKVFlYq7UQIgUTT+kDMuvLSknQk3dQreHPsDIrm0ycn5OI
         qFVjX4k5jbYxe63L7wcsmefEymeT/oEWtrWSifHhF/p1qXYNmQg4JABIN+HnmTs30QQX
         W+2m5jz19ZQm5SJ8nMVRvo+/aStwygbbY2bAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750256047; x=1750860847;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWbyA4a1n1aVjvP6ctgBaCKRdhrm2Tmki3ui2GQz4OQ=;
        b=Bq0b2gATd25uRen+83brNGpFIcNbYqZvpsHo0gyxRcVoOyIxsnvVJKz3zYXT6kfN+h
         uijCXppEyLIbsJF6BGwlOYnZTDEvRJRcNvFgbD1xf0Jb6xVhOIDudKXpv7sWPgzPHgaK
         Tp0xdHQNqXdu9MIp8T+cGi2uB1erZAoqfZBTG9AJsCYvtzCabExCxgj6eYO32xUHDK3E
         XWZOJFiwrsxrXxQG8jLO/JAWHjNyDfQ7mXIwC1VcoFgWp0gUmhjgSnsk0H8dbr3HorBi
         HEKt+2HFF4C2qqncLDn2CmmcQ0BMqLHJPe7pHQqDFYF3DtRJUjkyCBXvDing9XriZwEc
         w8jw==
X-Forwarded-Encrypted: i=1; AJvYcCXZC3dYsRwH/kreSwhTGMjrjPp/n/73enzJ8REq40jfxpB5jhc22N1uCrgfNDrDQhrv3P66Yw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+Nmak+pUo0Smoc93mgNt1O5Xt2F8i2ir9v73pe97NW7jBTBv9
	rRNJ3/KNonotlfEUZchH5DSlO/X/SM6+VYoBa1Xr7OYRH7Sr2/DN1vKLIIGR27Miheo=
X-Gm-Gg: ASbGnctnWShh5Kjr7Q4KEa4PJssh4/heqxCeIad8ELHoVK5BQSz83lKcFZeOoH28J/W
	pssjHorQ3oFzezFRSWT9zdAQHBXsmuObZ0AeqvxkIMICUL7EQAh2am45MUcMFvBp/fMmd24uYMb
	+UouQUi6h5F3LOFqNkc1EdjjIGiLTT3bXJ7u+JQGoVm4X+fvi6ms9nl5v/CwvDTrBOtX/NRod+f
	XkuUai0xgh58MMVaKWExm3VuID333xKzmAHAkG87yauySuyRIyuSEGnn/eJhvWAE0S6d/WWRGIw
	PsFIsh/kSr2+JtEF+66XvpsADJ7lnVkOXwZyQRpfIoMHqqiyiyjch4eWdr7rTwwtxYaMWetQXA=
	=
X-Google-Smtp-Source: AGHT+IGsqCmrJXzMwPM+oH1kv5sMlk4UVUkN2dXKJGBUjRXie2yVHLpK2+aze7LyMOOgssnqt0k33w==
X-Received: by 2002:a05:6402:274c:b0:607:f63b:aa31 with SMTP id 4fb4d7f45d1cf-608d0853447mr14785409a12.6.1750256046873;
        Wed, 18 Jun 2025 07:14:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b4ae68a2sm9640327a12.79.2025.06.18.07.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 07:14:06 -0700 (PDT)
Date: Wed, 18 Jun 2025 16:14:04 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Lukas Wunner <lukas@wunner.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux.dev>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:VFIO DRIVER" <kvm@vger.kernel.org>,
	"open list:SOUND" <linux-sound@vger.kernel.org>,
	Daniel Dadap <ddadap@nvidia.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 5/6] ALSA: hda: Use pci_is_display()
Message-ID: <aFLJrHdfrTmoyhin@phenom.ffwll.local>
Mail-Followup-To: Mario Limonciello <superm1@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Lukas Wunner <lukas@wunner.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux.dev>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:VFIO DRIVER" <kvm@vger.kernel.org>,
	"open list:SOUND" <linux-sound@vger.kernel.org>,
	Daniel Dadap <ddadap@nvidia.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>
References: <20250617175910.1640546-1-superm1@kernel.org>
 <20250617175910.1640546-6-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617175910.1640546-6-superm1@kernel.org>
X-Operating-System: Linux phenom 6.12.30-amd64 

On Tue, Jun 17, 2025 at 12:59:09PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The inline pci_is_display() helper does the same thing.  Use it.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I think the helper here is still neat, so for patches 1-5:

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

And a-b for the vgaswitcheroo patch for merging through the pci tree or a
dedicated pr to Linus, since I guess that's the simplest way to get that
done.

Cheers, Sima
> ---
>  sound/hda/hdac_i915.c     | 2 +-
>  sound/pci/hda/hda_intel.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
> index e9425213320ea..44438c799f957 100644
> --- a/sound/hda/hdac_i915.c
> +++ b/sound/hda/hdac_i915.c
> @@ -155,7 +155,7 @@ static int i915_gfx_present(struct pci_dev *hdac_pci)
>  
>  	for_each_pci_dev(display_dev) {
>  		if (display_dev->vendor != PCI_VENDOR_ID_INTEL ||
> -		    (display_dev->class >> 16) != PCI_BASE_CLASS_DISPLAY)
> +		    !pci_is_display(display_dev))
>  			continue;
>  
>  		if (pci_match_id(denylist, display_dev))
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index e5210ed48ddf1..a165c44b43940 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1465,7 +1465,7 @@ static struct pci_dev *get_bound_vga(struct pci_dev *pci)
>  				 * the dGPU is the one who is involved in
>  				 * vgaswitcheroo.
>  				 */
> -				if (((p->class >> 16) == PCI_BASE_CLASS_DISPLAY) &&
> +				if (pci_is_display(p) &&
>  				    (atpx_present() || apple_gmux_detect(NULL, NULL)))
>  					return p;
>  				pci_dev_put(p);
> @@ -1477,7 +1477,7 @@ static struct pci_dev *get_bound_vga(struct pci_dev *pci)
>  			p = pci_get_domain_bus_and_slot(pci_domain_nr(pci->bus),
>  							pci->bus->number, 0);
>  			if (p) {
> -				if ((p->class >> 16) == PCI_BASE_CLASS_DISPLAY)
> +				if (pci_is_display(p))
>  					return p;
>  				pci_dev_put(p);
>  			}
> -- 
> 2.43.0
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
