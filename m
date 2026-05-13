Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6688335839C
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692263; cv=none; b=d1OgPNHTCVCN8wGdL0ba/MQ5dpZF7FTtGH54bVBoBoMYKrNryRLybiGUVsk2/jhGcaSws5H+aMkYS9G2LPCSJ7MRoALLbRC53pgVbdrniug5zJNio7v4UlGkCVQBmQw1cwpEZT6HEbUbP5g0Zbb4AjtnLXdCywUbRghWOPQhpgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692263; c=relaxed/simple;
	bh=QW93lb1fdkpsnUJto5D4XyEklvCRZfMWCbZsUem2uAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXQci5oGzgcgvGlVSp6BeR7qKzhwm8F9S8ILEVHosz6ctYXwBfwQlfhFt/a6gfXKj+Aeze6IsIbC4NhX16c3MDc1wC9gu29g9luTTxjzisqujeNynPQ0mwssngZzG/Ej0XxMRbYrknhREIvZMd4YjoNcMte8Pnc/wCj0A1yKbdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UTTOrSCq; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UTTOrSCq"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b81586dff3so81021046d6.1
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 10:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778692260; x=1779297060; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LFS+fpNwj5CoQBfOxdsT86bztMTzUd1XUisAgFNuBCE=;
        b=UTTOrSCqRGI20oWk7GLP16R/GfJvM7+28XaH7slpD8pJQvGReqeoDS8/PzxAjVQE6X
         1OJV43sX6ua5/FyPCjdPiz0irs3XdJTsIGXOBwdzNaTHypTwRCztBKRrsQ2vhjiJG08G
         apaEzWFEHgz/plbggUEfyN9VbLbOCITmtHHL13ocXOdbxl6XtYC9cI2/pzHTOppsEuqW
         OsR1Z/B8ZS9hZ3P2L+vTSXDaLCzSX2fF2c216ikF4lGmWP3/CDa8D+gvT6HyWFFXXYwM
         gG9i3FQgMuA9+dSduw0fZX5M6D9iDFB0axc3qCuWNHem+dOB0CINUDad++2z5/p327ug
         H8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778692260; x=1779297060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFS+fpNwj5CoQBfOxdsT86bztMTzUd1XUisAgFNuBCE=;
        b=mJZqWJKyB/FChthz8lp2hXrdDfskBC0hog53+MxfDOO/k4gdQXK7BAdRgilKPVvMB7
         fFo3MRy8HPQbMqJbRcZPZWYESGDEc1fohQCgVzolRuTAB+snYFhTcbUKCIvsfm3FPVdq
         J/ktWYmELvI45zoxq7xTepYwxDVTebDVdqEEUMFYRNk2VzRc2LG4cSED7mpmnH1St7CT
         7iM91I43RAjPyzh2ZQ0C9ax8J0JthEPESzvL8XORQckvDMw/v7qw8bEUKYFVFzcgB/z4
         mko0exiy802akEzFAu2Bv2yTLc9V5zihZytahvXv8SfYYhQeE8SbCrBZ2vR/v5jaHTOn
         Efkg==
X-Forwarded-Encrypted: i=1; AFNElJ/Nyv39NI+XQfCOnhnr7QXpBCcxBIORztoNqV7csuT5hhq5X2Ed3x4E7p8+svTOdSKbpZAHdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqTvy8OcN8pK7/MR32o20iMsTmzzfHvBdegEm9SHDAFA8nHFcr
	Yp1TvMxjrUZq/STFNcFzVeXHVK7LyyfZZgqFxOZpBFJgl1EhipSetp0SIheKC9afIsY=
X-Gm-Gg: Acq92OFlxVbUXokvlP8mNNLBXTXN4OrIl0mSr3/6Fgsyu2UiAZu52gIHbXsM3gEdR8G
	gH0iy1VhElqZSjxmiQRJAdkrXaZKfuNUrRBSfYUDHgOoncFKSKu5p9xkd0hiHPh7MV/7SOuSHVl
	xaV+7mPeMPG67TB67UzckI3jDe6lv4Z4PWN/0A/dfSYoUyQLqzFfwy4tPs5uUa5Jhzkb/SMgS/4
	8R9IXPOTby9MUyPEJs8MXoS49T05v2zhAVRtDya4THKyhcrtpGo54vlyt7OvaVFR7ur4JXQcnaB
	jZCdqWpxHILzx7NAaC5dTVdM5nc/JTI65NB7cL24nJvo0ALsXusedLtlo9sHfYuLYyIpjqzoje+
	aHD/+ID6S5JTpUIzW4/VcKZ39EvW0u3V5HcBLn+ZuweA7B4f34CWUVGX6sEFB4MpLjwjYniE0X+
	sS2FPrPMtPxuSnAtmarMyBykNx1FLGLKEu0zqlgdD6Pze4cgEyTOAo8pHLfhwlQNu+lE42gHm12
	9p8SA==
X-Received: by 2002:a05:6214:4697:b0:8c6:1e19:80a4 with SMTP id 6a1803df08f44-8c7bc91b0d7mr58558936d6.26.1778692260161;
        Wed, 13 May 2026 10:11:00 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c358539sm710716d6.41.2026.05.13.10.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:10:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wND6p-00000003cRB-0Am8;
	Wed, 13 May 2026 14:10:59 -0300
Date: Wed, 13 May 2026 14:10:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joonwon Kang <joonwonkang@google.com>
Cc: Alexander.Grest@microsoft.com, amhetre@nvidia.com,
	baolu.lu@linux.intel.com, easwar.hariharan@linux.microsoft.com,
	iommu@lists.linux.dev, jacob.jun.pan@linux.intel.com,
	joro@8bytes.org, jpb@kernel.org, kees@kernel.org,
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, nicolinc@nvidia.com, praan@google.com,
	robin.murphy@arm.com, smostafa@google.com, will@kernel.org
Subject: Re: [PATCH RFC] iommu: Enable per-device SSID space for SVA
Message-ID: <20260513171059.GP7702@ziepe.ca>
References: <20260512151133.GD7702@ziepe.ca>
 <20260513170333.1235601-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513170333.1235601-1-joonwonkang@google.com>

On Wed, May 13, 2026 at 05:03:33PM +0000, Joonwon Kang wrote:
> > On Tue, May 12, 2026 at 02:51:38PM +0000, Joonwon Kang wrote:
> > 
> > > Appreciate all your clarifications here. So, my understanding is that if
> > > our system does not support ST64BV and ST64BV0 or if our device does not
> > > distinguish between the posted write and the non-posted write regarding
> > > PASID, then we can lift the use of the global PASID space. Can I say this?
> > 
> > You should do what Robin said - just have your driver use a per-device
> > PASID that it allocates and never use the global pasid allocator.
> > 
> > To do this lightly re-organize the SVA code so the driver can supply
> > its own PASID, and in this mode we wouldn't activate the ENQCMD
> > features in the mm.
> 
> Ah, we could actively disallow EL0 to execute ENQCMD-like instructions
> when the device driver explicitly shows the intention via a new API like
> `iommu_sva_bind_device_pasid()` that Tian mentioned earlier. 

You shouldn't need to do anything like this. 

All you need is to ensure that mm_get_enqcmd_pasid() returns
IOMMU_PASID_INVALID so long as a the normal iommu_sva_bind_device()
hasn't been called. Once it is called it is fine to allow the ENQCMD.

Your new iommu_sva_bind_device_pasid() needs to establish the SVA and
attach it without triggering mm_get_enqcmd_pasid().

The arch code is required to block the ENQCMD like instructions when
IOMMU_PASID_INVALID.

Devices that can mmap an ENQCMD sensitive BAR region must not do so
unless iommu_sva_bind_device() has been called.

> To allocate a per-device PASID, I think we should do it using
> `dev->iommu_group->pasid_array` instead of making the device driver

No, make the driver manage this, don't mess with the core code. PASID
isn't supported with multi-device groups already.

Jason
