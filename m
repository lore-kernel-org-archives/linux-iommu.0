Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C22A37B018
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501234; cv=none; b=qoDoE2p2CdvXcPL9n4vmDfKkOLJ3x5ALKWPBKaorPmEFchRDFBmsF8si8iyB3wnpWNxeG5cWWMqtrLzdoXe9sU3eUliwZo4Ete4mDihmuBbroYPRfJeRy24ePOfjHFwswgcItOyEbEkvb9M59HXLMDqg2hY0OPe2I7DL3J9/TMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501234; c=relaxed/simple;
	bh=7Qjhm3YdhhO4t+vF7XagYTnn9XOfWd4xq/CKCcvdJog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzNYLJD2Z5t+eXocXShUArM7tDRPav+wXsTI50GQo+9LK/GynVXtisyVwIK0jHxj+OGsPuz3Wu09F1zxZ34pkMMSJj9ZNiAmG8NZF6QrC/+ZGxalWtIvyshLK8lIHsIJIKn9l+KAbqh1fYgi3T/dfNUH70lah+fRqxhIeoX8CSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CY3wGME6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CY3wGME6"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b46da8c48eso95ad.1
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 05:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778501231; x=1779106031; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LT2dOn0HXXyGKpMQ+Gw6Q15wO7E08EwiUoUgDekxIyA=;
        b=CY3wGME6MKkfZGPYDAVOK6c4Gn4jKRj/W3ELRkBFSAjJn4XU0EAYy+N6sAGxuDrAU6
         LChyLL3OEoHUN/Lx3gFQejEGX10et2d4hfDGLCciDxJLQNqRmeKW9IOdrdk0FCJW0jxY
         n9FLBmnlif2vs07/rypy8W8V5vG4x7xNUNb05GnU0ZeLD7x9z4OnfKQ6iMKCAce1CW4C
         S3fL3fSKz2G3GEX1WSvjNVh4AB+GBoSS/SUljDCiOXOdBhmS47i1TcMFQpOv27c/+GLm
         dN+nOVP302Ow8s8HSdt19kxR/PlSynrMiHPJlGziHcxhYUGfaXAK3paVoS4tknN0aPlq
         AAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778501231; x=1779106031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LT2dOn0HXXyGKpMQ+Gw6Q15wO7E08EwiUoUgDekxIyA=;
        b=Ou7Pkm5qye6tAYJpdV5KOlA2sXa+87HiQfHw69Hlvo0YdZ0wCxV60/1t04gQWW129R
         hxDwn2T3kunCDe/S+mr/a4CL7mIVxlEepwx8HIFzpStMsluDPv9UMFd9NLFyt1LGcmYR
         uzhB5aoJ7JiSurTpvOLztrEbtTW96R0imZCurwJWWqsCvXqNhCAJu8Xm8nL+y0kgiPb/
         f+TjICD/0UTbQAsSfx+5CaNgAjejTgsgycsDq5XMw7u25KQYJWTRASK0+MvHASp0WRlE
         2qUWOgYTGDJ2mZ0F9sdkqP5vJobvgcf/zGF2N5wXVOHjGwUu56dYxpGjJaSvy20bV9fe
         zVPw==
X-Forwarded-Encrypted: i=1; AFNElJ+fUmJESJujlNWKeu06MHo1AqZiWt+40PDrJgfqr8P1mCK3QFTFFKPoBVJ3oL+kz9SiZVOLow==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4WEXlq5h9VDw1BBp+T5E2CDIkXAzNGxaZMuxL+/eUEkSF0m5p
	pw6zTkRW3zPBMr0YfFifRNs/5dHnZqxUTRPTixMGXuWK8zQ4hpOS0SCcqOyyiCFI1A==
X-Gm-Gg: Acq92OE9AxPXlq8/STTR7Niyw6ORYBhXkZFIAP5lYtq0UfKYCMfQlCb4e2/76RtHdVO
	yI/zSWM6RJaJAal2j1kb6lj1snTG2atzIE5uG3hW9Pxw4KsdscsmOseeIuvrQtabPeqjcp6GLKt
	Yl2XhSLJeaAsv3+khjEi7RxW+J2wFc7a0RoT4AUq80pipmGiFEioXZ2uonQr9mTfldXDk84Qmgi
	OLH7XvvFqdprU+ysL88PsKxFGhTgtGn8FZHyCNVpTzcwKyDRIzIh8cPr2Bn7slGGL2Y9bP/4aR7
	nAf2wI/yjL2UJSX6B5avd8EjTF8dghHSYmyp/RYG8YCDI0pPDbzyS7pyO1G3sqpHl0vvI9kVVU4
	hbdJHg6tyjl5B7uczwG35kG/+ci+gQluJ++Wq3VtAxrpcfKZiyRhYEOpnJjgdurZ1yGh9mqCp9v
	t/uGkk6lEkzh4CSU3zDQAlc/mrL53AmnChJCtGlwc2I/PwXdpDwImR0KNpahWKj3agbe4n
X-Received: by 2002:a17:902:fa8e:b0:2bc:dc0b:ab29 with SMTP id d9443c01a7336-2bcdc0bada2mr962865ad.0.1778501230958;
        Mon, 11 May 2026 05:07:10 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826768acf3sm10719085a12.10.2026.05.11.05.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:07:10 -0700 (PDT)
Date: Mon, 11 May 2026 12:07:04 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <agHGaJfwPr7-F1z2@google.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afoWrn/RXxDmcHsS@ziepe.ca>
 <afpdm5lfIeWptxOh@google.com>
 <afpwCIjQXwfImPXm@google.com>
 <afsN9jrsfuigV+DM@ziepe.ca>
 <afu5Y55W5oj70b5v@google.com>
 <afu69hAtkRlI1GJd@google.com>
 <20260509171451.GG9285@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260509171451.GG9285@ziepe.ca>

On Sat, May 09, 2026 at 02:14:51PM -0300, Jason Gunthorpe wrote:
> On Wed, May 06, 2026 at 10:04:38PM +0000, Pranjal Shrivastava wrote:
> 
> > [1] https://elixir.bootlin.com/linux/v7.0.1/source/drivers/pci/quirks.c#L5703
> 
> The quirk is broken. It clearly says the device has mis-implemented
> the ATS invalidation message so ATS must *NEVER* be enabled.
> 

I agree that the ATS must never be enable on this device. 

> Thus the quirk should cover the VFs too and also disable ATS there.

I observe the quirk does apply VFs but after the VF's iommu attach
because of how the pci_iov_add_virtfn() is written:

int pci_iov_add_virtfn(...)
{

	...
	pci_device_add(virtfn, virtfn->bus); // <------ This is where the iommu attach happens within device_add()
	rc = pci_iov_sysfs_link(dev, virtfn, id);
	if (rc)
		goto failed1;

	pci_bus_add_device(virtfn); // <---- This is where the quirk gets applied

}

i.e. in pci_device_add it calls pci_fixup_device(pci_fixup_header, dev)
whereas this ATS quirk is of `pci_fixup_final` type & gets applied within
pci_bus_add_device(). 

While, we can move this quirk to be in fixup_early / fixup_header.
I still think we should add checking the PF->ats_cap within 
pci_ats_supported before bailing out happily (return 0) for VFs.

> So I still think my original suggestion is appropriate, fail to probe
> the iommu device if ats prepare fails (serious PCI layer bug, like
> broken quirks) and fail to attach the domain of ats enable fails
> (serious internal kernel malfunction since enable must succeed if
> prepare succeeded)

I’m concerned that refusing to attach a device because it isn't ATS 
capable is bit too aggressive.

Even if pci_enable_ats() fails, the device is still perfectly capable of
performing standard DMA. We should allow the IOMMU attach to succeed but
in a 'Degraded' mode—where ATS is disabled for all it's functions, i.e. 
configured to treat it as a standard non-ATS device.

Thanks,
Praan
