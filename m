Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469DE1292DB
	for <iommu@lists.linux.dev>; Tue, 16 Apr 2024 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268198; cv=none; b=MRN21DGONpZsAZiOED6w8beP2VNSQdqW5+MfeUKNimLJqKRKQk9iqJqTjZsgYZpclZ5y2vi55z1K4lkS0M8dx+O0G1YvHIIrIrE0/qT6I0rz8ibHtNzhUW0C+XOT6rVomrUzT3UmxYga56GtYutMi/7NaioFDPnojwGzgT+i9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268198; c=relaxed/simple;
	bh=rmvpFPUTIYgHV2p8/6H+ARfWisXS/Az8htu2TVN/PtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSvDThqckoeX7mN78C+G1eiRwhHWE2bdUWVO0FhhddO3V6a4k0/cJbGxPNxVOsRd4YxhJESNE4w9Q+ZwBP1UBxngtyNdnUvdtYaVxy2BDIKPAo1IsEAkg/Q0MH2TmT5q5hk2aDkpUcjGhi4XtP7gyXokaCh0KciFFYGPCK4bJWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CVfZhMhc; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CVfZhMhc"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6962e6fbf60so37696726d6.1
        for <iommu@lists.linux.dev>; Tue, 16 Apr 2024 04:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713268196; x=1713872996; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QCTi/88RzK0ECiO7fDP6JKGXgjJySXc+KTjtiX7cVN8=;
        b=CVfZhMhcC+cDOYevUvh9a/A1Ubio7eWJuTSS7utniF3xardppIC8ZP5b1JYhkVm0iF
         Kuzyh4KM1vp2chdwn4klcBAHzbHIFKlRfMabJC9YDzWVujpw5ro9Ow7Ypx4YPlr4LV1K
         LzN7D8k2TtXMDZ5RpVEWk2ZFYpFPKQBm0wAxek/3y9xjvmQ7yXIqts/UJ3/4F1NF1TeA
         kcDJ57Hx0i87utEKru3EP37A1me+AtRI/UBKZPt0D3yP9vtSztM4l2YrKsZmbuNhv+J5
         Fv/XjCleQrPhyKOFBd81s3A+Q7akcNJJef43w1JdInf66KFiKQBfKKFl3ozyDyzxtiYT
         1kqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713268196; x=1713872996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCTi/88RzK0ECiO7fDP6JKGXgjJySXc+KTjtiX7cVN8=;
        b=TBf83MldVRHnNNfRDy1A9UPtYXbCralmiadZk+zTlVFVM9fjAVsddypwwmRFWM53AW
         ILLuIy+R3fKFCfEetUgd9kt8tKuv6EAZ9wlWY9vuQXVYMLJecQOKPNgSBDNWv6SwPGST
         wr12Ao3h476k41MroL8bd10aMBeTyTE3ZZLOJ5bU4AnpaREuhlNG02W8hZ2O5IsTsIL7
         gHZ5dbu+AtXnnUnnSk8LGHZcCbJFrwB3IAH81Hacuqfxu0/3V/kWz9DeVaXOo8hHH8z8
         IreBE/FYg0jBPgmpYxG7UBaWITf9JdnkHRBHstGFL+UzsmlOdGV49bfrNzAVL+1Ew81E
         ul0w==
X-Forwarded-Encrypted: i=1; AJvYcCXx4CfgSOc7E6OiBPRtc/mvfRdr6mbddn8bG36n11DgILi31XFynt5u8VuDfiI5sfFS7T/t9EyaHKn47BAbtw/ZcRkCAFs=
X-Gm-Message-State: AOJu0YySjzWd6zXqYHfHBFmAByfENbuuMbJvFCuJYLB/+tTTGiGRdRbW
	700hUWqZNoubG1CWo7GKv1sBRXJ/nM1t1iB0mXULWi2Kq63Qe6lvwqHOfbh2HNg=
X-Google-Smtp-Source: AGHT+IESqldpjft/eXho3+hgJTTcbX6pmRWAM7oqr10WigziCiL0y4fcBwniEWrqOwd0oNhEvyEagw==
X-Received: by 2002:a0c:efc6:0:b0:69e:b96d:26a0 with SMTP id a6-20020a0cefc6000000b0069eb96d26a0mr1003878qvt.27.1713268196162;
        Tue, 16 Apr 2024 04:49:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id r18-20020ad44052000000b00698e65cdfefsm7335858qvp.87.2024.04.16.04.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:49:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rwhJz-008b7B-5T;
	Tue, 16 Apr 2024 08:49:55 -0300
Date: Tue, 16 Apr 2024 08:49:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Eric Wagner <ewagner12@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
Message-ID: <20240416114955.GT223006@ziepe.ca>
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
 <20240415163056.GP223006@ziepe.ca>
 <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
 <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com>
 <20240416003903.GR223006@ziepe.ca>
 <47d4bfd6-1d76-4bb8-a33c-c9c99b86656b@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47d4bfd6-1d76-4bb8-a33c-c9c99b86656b@arm.com>

On Tue, Apr 16, 2024 at 12:25:52PM +0100, Robin Murphy wrote:
> On 2024-04-16 1:39 am, Jason Gunthorpe wrote:
> > On Mon, Apr 15, 2024 at 10:44:34PM +0100, Robin Murphy wrote:
> > > On 2024-04-15 7:57 pm, Eric Wagner wrote:
> > > > Apologies if I made a mistake in the first bisect, I'm new to kernel
> > > > debugging.
> > > > 
> > > > I tested cedc811c76778bdef91d405717acee0de54d8db5 (x86/amd) and
> > > > 3613047280ec42a4e1350fdc1a6dd161ff4008cc (core) directly and both were good.
> > > > Then I ran git bisect again with e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
> > > > as the bad and 6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3 as the good and the
> > > > bisect log is attached. It ended up at the same commit as before.
> > > > 
> > > > I've also attached a picture of the boot screen that occurs when it hangs.
> > > > 0000:05:00.0 is the PCIe bus address of the RX 580 eGPU that's causing the
> > > > problem.
> > > 
> > > Looks like 59ddce4418da483 probably broke things most - prior to that, the
> > > fact that it's behind a Thunderbolt port would have always taken precedence
> > > and forced IOMMU_DOMAIN_DMA regardless of what the driver may have wanted to
> > > saywhereas now we ask the driver first, then complain that it conflicts
> > > with the untrusted status and ultimately don't configure the IOMMU
> > > at all.
> > 
> > Yes, if the driver wants to force a domain type it should be
> > forced. Driver knows best. Eg AMD forces IDENTITY when the HW/driver
> > is incapable of supporting otherwise.
> 
> No, in the case of AMD it only forces identity if it thinks the device might
> want to use PASIDs (because of the architectural limitation that the RID
> always operates in GPA space so can't have its own independent translation).

AMD forces this because it doesn't yet have a way to automatically
choose it's v1/v2 page table format during alloc domain. It is just a
SW bug.

The CC/SNP limitation is also a SW bug but is more fatal as it can't
even attach a v1 page table in this mode.

> Either way, though, there's really little sense to that argument - if
> enforcing strict translation *might* compromise the device's functionality,
> we should instead go out of our way to ensure it's definitely as broken as
> possible? I fail to see how that can be justified as useful or desirable
> behaviour.

For SNP cases the attach of a DMA domain will fail, so yes, moving the
failure earlier and giving a clear message is desirable.

> "Failing" iommu_probe_device is merely how we tell ourselves that we're not
> interested in a device, and consequently tell the rest of the kernel it
> doesn't have an IOMMU (via device_iommu_mapped() returning false). 

Probing failing with ENODEV means the device has no iommu and the rest
of the code should assume DMA direct will work.

Probing failing with any other error code means the device has an
iommu and it couldn't be setup. DMA direct probably won't work today.

If you want all failure codes to mean the device is safe for DMA
direct then we need to try and attach the IDENTITY domain on various
probe failure paths too.

> I think I've now satisfied myself that a simple fix for the core code is
> appropriate and will write that up now; one other thing I couldn't
> quite

It really doesn't match the design here.

Jason
