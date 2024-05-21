Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CEF757FD
	for <iommu@lists.linux.dev>; Tue, 21 May 2024 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716308492; cv=none; b=YHChF/Uf2ndMO4SBGwNTVK5HYlJM0sej7GMkIfmhLG9sLd4KbdU5Pe2nmo9fBOv8iGGRbDd1kpFBd4XK+fgLKUaPm9x/lFA8JK8aa/O0uc+oTe1HREqqkJP+yPEJ4Mi3y7Ofr0Ms+87NlaZ0pYPx14miy0wktySMFphCK/81ieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716308492; c=relaxed/simple;
	bh=XS/PoMZ0vohM4lSNeJOQ/OrYk9eYCa2hb4zd9/QLyUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PoPQReMrYs+lfRP4iHFFNj5PdXuxbuEzZWKLfxNHBi8Tq/w01KXajg/y3FlZmkJEwJSp0ccBSbyT/OBu5iyo8jPQb0MiXTNk2CrjFDicq1umQVPKuGnCPhaHpZJT8bZX59y/CZs1iUfCTPhEobObx38YSE5jFZ9kkbbRnaUK6v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=REDvZUZw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REDvZUZw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716308489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBkDmR7/UY5pu+K19ObSTfPnyl9pBj1jvfc+LLqjkwU=;
	b=REDvZUZwUvKeXMqYZ00ETJfJu4dFUuHKmOrwlfGibNMxDQgQzOcR3dOLbpqmDfEFsrWlbs
	veFWu3ZdCkrectKcd8Rw0Hv9ofFTGz5orsaNCHO+zvIiysBq3uxcw+RUzR9V9PXLg8N9Bb
	lqrF7kmSKmDFkFu9l3py2JHLJ96qEWY=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486--kVyYccdN1-P1Svp5Qrj9Q-1; Tue, 21 May 2024 12:21:26 -0400
X-MC-Unique: -kVyYccdN1-P1Svp5Qrj9Q-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1bcad7693so1338352539f.1
        for <iommu@lists.linux.dev>; Tue, 21 May 2024 09:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716308485; x=1716913285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBkDmR7/UY5pu+K19ObSTfPnyl9pBj1jvfc+LLqjkwU=;
        b=tPBJQooBqXHPCncspZM0E2446orUSI7RQ7e+zbPZnj3RArxjBSd0E9PTg/m60TCNvU
         /ptJyOuh6YXI7sRp4F6zYnngR3EogitRxO8FoXIU30N3CWvzKHtsHIEtOboGB9yeZ5Z7
         XDxVSlJ5F+k+OK+pQl1oEdIPAu1YRxWAxMXsCMFxj9XrnIntx2ve/kMIRzePILvHk8J3
         u6SE7wN2D7aODG5SPaDGQJQDl465OZsgD+S/p0nALmhoWcazRB7AgSApX2aVbqa708io
         ZbsJUuWH23MndEYN3lLw/2U0y3eGz/etKBQ7sU//sELt47yd1hhNtS4lsNvD8oNkKLhF
         QOjA==
X-Forwarded-Encrypted: i=1; AJvYcCUQU1QfhKz/+hmDdE8DSnm6a7pTb2t1Hv31n0VkJs/chL7MiTJkF6EHcgkn2HJ99v+7lL4ETIV+nahPWByhrW/4RX91rU4=
X-Gm-Message-State: AOJu0YyPQW++NYaCQ3ZTuu6N94d48mYyud9sIbCoL18mPJ6EMzvcnKL6
	PfwNgyeVXgbrCwxx969ja3GaEQNDKFUBEirsCcffsHEZLXU6qCe2YQUKzbZvB1b4+PhoREP3Q2n
	CAkPxD4eusBc+lrDHEUl/vXSzs5zBBD2am/ZL1HgUucY2yubkAQkm
X-Received: by 2002:a5e:9515:0:b0:7e1:83ee:7263 with SMTP id ca18e2360f4ac-7e1b5217d31mr3432548839f.19.1716308485171;
        Tue, 21 May 2024 09:21:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPMptMWyo0jbfKOTtQpGxuYSbiSfgve0+756eiZhQ4Fl8lA8G4jDvEgV+jrxZwDY6cLELV/Q==
X-Received: by 2002:a5e:9515:0:b0:7e1:83ee:7263 with SMTP id ca18e2360f4ac-7e1b5217d31mr3432546639f.19.1716308484853;
        Tue, 21 May 2024 09:21:24 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e1be57e690sm615576439f.39.2024.05.21.09.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 09:21:24 -0700 (PDT)
Date: Tue, 21 May 2024 10:21:23 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Vetter, Daniel"
 <daniel.vetter@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "hpa@zytor.com" <hpa@zytor.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 4/5] vfio/type1: Flush CPU caches on DMA pages in
 non-coherent domains
Message-ID: <20240521102123.7baaf85a.alex.williamson@redhat.com>
In-Reply-To: <20240521160714.GJ20229@nvidia.com>
References: <20240507061802.20184-1-yan.y.zhao@intel.com>
	<20240507062138.20465-1-yan.y.zhao@intel.com>
	<20240509121049.58238a6f.alex.williamson@redhat.com>
	<Zj33cUe7HYOIfj5N@yzhao56-desk.sh.intel.com>
	<20240510105728.76d97bbb.alex.williamson@redhat.com>
	<ZkG9IEQwi7HG3YBk@yzhao56-desk.sh.intel.com>
	<BN9PR11MB52766D78684F6206121590B98CED2@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240516143159.0416d6c7.alex.williamson@redhat.com>
	<20240517171117.GB20229@nvidia.com>
	<BN9PR11MB5276250B2CF376D15D16FF928CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240521160714.GJ20229@nvidia.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 May 2024 13:07:14 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, May 20, 2024 at 02:52:43AM +0000, Tian, Kevin wrote:
> > +Daniel
> >   
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Saturday, May 18, 2024 1:11 AM
> > > 
> > > On Thu, May 16, 2024 at 02:31:59PM -0600, Alex Williamson wrote:
> > >   
> > > > Yes, exactly.  Zero'ing the page would obviously reestablish the
> > > > coherency, but the page could be reallocated without being zero'd and as
> > > > you describe the owner of that page could then get inconsistent
> > > > results.  
> > > 
> > > I think if we care about the performance of this stuff enough to try
> > > and remove flushes we'd be better off figuring out how to disable no
> > > snoop in PCI config space and trust the device not to use it and avoid
> > > these flushes.
> > > 
> > > iommu enforcement is nice, but at least ARM has been assuming that the
> > > PCI config space bit is sufficient.
> > > 
> > > Intel/AMD are probably fine here as they will only flush for weird GPU
> > > cases, but I expect ARM is going to be unhappy.
> > >   
> > 
> > My impression was that Intel GPU is not usable w/o non-coherent DMA,
> > but I don't remember whether it's unusable being a functional breakage
> > or a user experience breakage. e.g. I vaguely recalled that the display
> > engine cannot afford high resolution/high refresh rate using the snoop
> > way so the IOMMU dedicated for the GPU doesn't implement the force
> > snoop capability.
> > 
> > Daniel, can you help explain the behavior of Intel GPU in case nosnoop
> > is disabled in the PCI config space?
> > 
> > Overall it sounds that we are talking about different requirements. For
> > Intel GPU nosnoop is a must but it is not currently done securely so we
> > need add proper flush to fix it, while for ARM looks you don't have a
> > case which relies on nosnoop so finding a way to disable it is more
> > straightforward?  
> 
> Intel GPU weirdness should not leak into making other devices
> insecure/slow. If necessary Intel GPU only should get some variant
> override to keep no snoop working.
> 
> It would make alot of good sense if VFIO made the default to disable
> no-snoop via the config space.

We can certainly virtualize the config space no-snoop enable bit, but
I'm not sure what it actually accomplishes.  We'd then be relying on
the device to honor the bit and not have any backdoors to twiddle the
bit otherwise (where we know that GPUs often have multiple paths to get
to config space).  We also then have the question of does the device
function correctly if we disable no-snoop.  The more secure approach
might be that we need to do these cache flushes for any IOMMU that
doesn't maintain coherency, even for no-snoop transactions.  Thanks,

Alex

