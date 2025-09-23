Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D22F1F4622
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641854; cv=none; b=toS+RykO4xus1j5nZtDKLkt0OId8VbyDDNx73p84KzDjGI5PbDkOU1lARLSdzGRbVqrKvTFGqir+Eb9Rce4u/2k2TZ30koKadiiFMK+S6TjLNlPc14SqVbheA7wqkyRhLjlnxr/Wlxlrp+Gz8ChFsX9HIfMCq8qHUB7O455DpWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641854; c=relaxed/simple;
	bh=VPsPP97J7NiYsQImvFBzCd/NUWkzwiH5aWFfTBKY7ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7wt8z/qZqJ2XOiGLho3DMr2D1DfrmyV4hDInTmaJSoZxfSHqL0EdcIt7mngae+9ikpatqtUedhXFLEYTLRqTs5xHOZAUYH77OBr+VzjrG4gm9Ta6wR21Jd+irpGz33rZYCk45X0A0nb+qnWl4DNDBozJN343g910fj9I7DAShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Dx7THe6J; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Dx7THe6J"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-ea473582bcaso6906578276.1
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758641852; x=1759246652; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wa5b2Ox9cKpFtfieebnhk7CueJ3gddY86USQDYphg/s=;
        b=Dx7THe6J7GVK2lTWoEFIGfS5QPvU0OQPVwEJSQLNhfwStwjox0H0oxFKNL1hslzCfI
         TAaDizBiwG/QStinW2NMUVf1lHCaAp2ZyyJbF3h0pRqw6l7Ub4Gpye3TBQuIcg48CkCN
         GsMdHGlNDAZB5wm870F8JfMLF2UpygJp0SpRh31QElCs4NXJbSc6NmRp1Eb9TofYB6It
         Jw+zKZttxCf6hA9ksuAjbXJoIiUNZnxHVn4gEhbNCPb829KQqpxJe07mKGZ0cm1/tT3k
         T9nzXSCYNDSqp/dyOB0DDVMDrEloWEUiFPqGZJ0GbUbeOjwyiNkGpA4Zth9YGNQ9mHa2
         xLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641852; x=1759246652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wa5b2Ox9cKpFtfieebnhk7CueJ3gddY86USQDYphg/s=;
        b=CyewomeLDhRd1QCUf485435y21fmwjUWlWcsivfYSwQtx9U9/3PUKzTTJ0b8Igv7b2
         IT55+06p6uEHxC86YZW0NIK7D8tOrKF4DXCqKDukJV76lAVarJr96mX9aJXh0ulPM5lL
         MgCZCdxiY2A24QlxLLryBIIO2/QcOs/GjjNxxMAIt26Iik7wyTonnW+QXFeyYK58Kl8E
         AAxmJS6nBUrYYdKD2Xky0oI9BxqK+kXAihB430eS4l8qeMZbLeJZ5yVdmDqxvI85hcId
         uwKSC9QYhcukPeRB5euUFkpceOAW7/EBuRXTRznK7OY5GQFHwbj0MApWU7RCH0iNLQL3
         zQoA==
X-Forwarded-Encrypted: i=1; AJvYcCU1qhDA7egn5xcXD6VSN63HN21h5eRd25MedrCIXeMxOsAIvveBw+ryqyJQoHuccdk40B3vIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVFXjZhtGLLJ+GjJ6zCV8AtvqphcFDODry+CNh7oMKZlN6WnMw
	q/d1ynK4t4pWWvXjBlFGNR/SWCWYa2tqdFzdEEnZ9qqwIm/NdxhSv499dqzDyYhAQVg=
X-Gm-Gg: ASbGncu2cZs+wm4dQQFL3ubK22jEQF7dqJ7pQyz2KljIxP0baaYlJqsPkysnwrTwBLo
	BAdXYOb26lGcDV4feFUbzOY5VHu+DtZt1mv2bqxkGFTW4WD89LxUtwFnViyccwrBGdIpgsij4Ci
	4visEmRfb212WoZsj/P4p/K634mhQSmw8ffbKYZUFInjTeRd5wbYlij0jVROidTOcu1gUGVBDyh
	7HSaeZ+PIW8jxfhNgs4mui4Yw+xci5ddD01WGfb+SXROs1YEjGnK2BZNZPLi2C7D/rZICvUWGrO
	8p5lkAhsfLife3xBJBFfopquA/ClUEOuN05gog69LLPLEYJm3jpEaM3IGqDXb87LcvbkcpHAGq+
	8Ic59Sy+ZgvQ77VimOWjbfRSt
X-Google-Smtp-Source: AGHT+IEg1iVUs6leKP9cHj2cx58SzsL13TI+csDZL0P1k6w1OJijHfrbcJXnEnD/4J+xBKVTIxDONg==
X-Received: by 2002:a05:6902:1381:b0:eb3:6e74:dd0c with SMTP id 3f1490d57ef6-eb36e74defcmr792195276.24.1758641851831;
        Tue, 23 Sep 2025 08:37:31 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce854f57sm5087789276.22.2025.09.23.08.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:37:31 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:37:30 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, iommu@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, zong.li@sifive.com, tjeznach@rivosinc.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, anup@brainfault.org, atish.patra@linux.dev, 
	alex.williamson@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, alex@ghiti.fr
Subject: Re: [RFC PATCH v2 08/18] iommu/riscv: Use MSI table to enable IMSIC
 access
Message-ID: <20250923-54e8e0f39d672845e2979286@orel>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
 <20250920203851.2205115-28-ajones@ventanamicro.com>
 <20250922184336.GD1391379@nvidia.com>
 <20250922-50372a07397db3155fec49c9@orel>
 <20250922235651.GG1391379@nvidia.com>
 <87ecrx4guz.ffs@tglx>
 <20250923-de370be816db3ec12b3ae5d4@orel>
 <20250923145251.GP1391379@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923145251.GP1391379@nvidia.com>

On Tue, Sep 23, 2025 at 11:52:51AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 23, 2025 at 09:37:31AM -0500, Andrew Jones wrote:
> > undergoes a specified translation into an index of the MSI table. For the
> > non-virt use case we skip the "composes a new address/data pair, which
> > points at the remap table entry" step since we just forward the original
> > with an identity mapping. For the virt case we do write a new addr,data
> > pair (Patch15) since we need to map guest addresses to host addresses (but
> > data is still just forwarded since the RISC-V IOMMU doesn't support data
> > remapping). 
> 
> You should banish thinking of non-virt/virt from your lexicon. Linux
> doesn't work that way, and trying to force it too is a loosing battle.

Well, we need to consider virt when the hardware has virt-specific
features that we want to control. We also need to consider virt when
additional address translations to go from guest space to host space
are needed, as in this case.

> 
> If you have a remap domain then it should always be remapping. There
> is no such idea in Linux as a conditional IRQ domain dependent on
> external factors (like how the IOMMU is configured, if the device is
> "virt" or not, etc).

The remap domain is created when the platform supports MSIs and always
does remapping when the IOMMU supports the MSI table. It could even do
remapping when the IOMMU doesn't support the MSI table since it could
use the DMA table instead, but that's left for a later patch series if
hardware actually shows up like that.

The difference between virt and non-virt is what addresses get remapped
for the remapping. For virt, guest addresses get remapped, for non-virt,
we don't remap guest addresses. And, since we don't remap guest addresses
for non-virt, then, rather than invent some new, arbitrary address, we
just use the host address. Remapping is still in use, but, as I said
above, it's an identity mapping.

(Note, for the current riscv iommu, "remapping" for the non-virt case just
means keeping the set of IMSICs that a device may reach limited to just
what it should be allowed to reach.)

> 
> Be specific what you mean.

I'm always happy to clarify when asked. I'm not sure what I said that
would lead to thinking remapping was disabled for the non-virt case,
but hopefully what I wrote now clarifies that it is not.

Thanks,
drew
