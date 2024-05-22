Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73007199B0
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389006; cv=none; b=PCqzlfM1VQeOuwvi79cWi6Uo9u/4qSIt0e8K3WtIEJ9h2vkA0okbKZSdpYS0tysEidpC+aRcluY560LNMp00UMHuDn0bul6KImKkSqwsPrYJvyyXtC6K/zwHDBeaKPYFLbUSw8SfCauVAj1m5caaO49OX+jyZjyfFRsZUpn1x8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389006; c=relaxed/simple;
	bh=ojl3Kz+45ZBjnPCHAViG+5m7ZbPO937xkun+CmzGL0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1SVXLVzZ66DBTgOh54rOId1cy9ib3CXC3TjuksW0apYTz1EefQNmVyhbuk02wRKeY/h9XdFs60f5ODHct9kNSMJSrQD2Yo4LGgaqAs7/mCZSedsXDeagTfgG2vjmOSfl5hiAe8jHkkiP13YNtgEuCZgyCUDbcF0caiDk3c9a2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RtRh6HMx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtRh6HMx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716389003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCCD5AL8sXkrhzAHpHnYOFwpAjoAA+9SMdIBjKqepNw=;
	b=RtRh6HMxJeAW0SxMGSUCOfk3ogXpiS2flVfLQqG+2eDlHB8sUPVb+BFRpjeGOc5YKCFvfP
	MIxL87120ruR9lC5Dhi1QY09eunlEACnK6a18ggDMgd71bLW6ccwt6RKwRypKVI8lRwOFQ
	xkcwkVo91QBIop+3GAaWchx5PGLiPa8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-NSc-FIFnOD2852R1ShR14A-1; Wed, 22 May 2024 10:43:21 -0400
X-MC-Unique: NSc-FIFnOD2852R1ShR14A-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36c74ef7261so8523475ab.3
        for <iommu@lists.linux.dev>; Wed, 22 May 2024 07:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716389001; x=1716993801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCCD5AL8sXkrhzAHpHnYOFwpAjoAA+9SMdIBjKqepNw=;
        b=Jut+h8lrnxRXASbUdsw5fUI3OU7ABo+IUBlmpdjOeIYKmzm9ZzRhcTVMu+S2k2KQUs
         upsQVg8SqbX+ayayHVUqIbNatmg1DSkYVqCN5j3cuM1C5pPBZ3kdlNyqCXLnBDwWm+IV
         B5c2QIzmsm2Y80GUymrbxEnpj8n97yJR/FBM6AsS6O3PmeBWhGdTrIYyc8fS2Scj0+uo
         8yg/5yFnGg6Kv62x7uCjMN6QHHrGI+uD0Ml8NDK3/nMY0MpDX3rkd7Bfp5PUEYnOcM/B
         8AYomO5ttjnYigMDnmxyqLX9TcnuZ2bZZ5udJUnismvlrcXTq8qVXmfVfX+aF1TVFvjt
         CFUA==
X-Forwarded-Encrypted: i=1; AJvYcCVs1N6wvC9CckbuyLKYG2VldbzFmHPJqed4sUvhIvxWd4JMHm1hXrypgIbZqb2E1hsRHyj3J0eVK4+ZKV7YS15Gu+Q61j4=
X-Gm-Message-State: AOJu0Yzo1VXMV/WF85LQuvUU4rviZ+GZe4M31FjgH/Oxw6c79Hd3yZyB
	vrJYLUoGo484cjsYjEftfgQrpgVWc/v3VNDl09xiZz5aEipxxYXyrIohN/wp/gMXoGGKw0ADuwf
	pWnIPluMCI9cZwJ1Ro41KhQOfBm+tCdc8kt/DRxXgTw6CviHAQ71Z
X-Received: by 2002:a05:6e02:12e8:b0:36c:45bf:a8f0 with SMTP id e9e14a558f8ab-371fb91fe79mr24461425ab.25.1716389000975;
        Wed, 22 May 2024 07:43:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqJHjQHAf8ioYQJxg3KTDvGvqncn/7PxrQwSaE3bVUPwOeK3bCtm4GVPxds6m+Fab6ef5A4w==
X-Received: by 2002:a05:6e02:12e8:b0:36c:45bf:a8f0 with SMTP id e9e14a558f8ab-371fb91fe79mr24461105ab.25.1716389000614;
        Wed, 22 May 2024 07:43:20 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37195389d91sm6333875ab.7.2024.05.22.07.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 07:43:20 -0700 (PDT)
Date: Wed, 22 May 2024 08:43:18 -0600
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
Message-ID: <20240522084318.43e0dbb1.alex.williamson@redhat.com>
In-Reply-To: <20240522122939.GT20229@nvidia.com>
References: <BN9PR11MB52766D78684F6206121590B98CED2@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240516143159.0416d6c7.alex.williamson@redhat.com>
	<20240517171117.GB20229@nvidia.com>
	<BN9PR11MB5276250B2CF376D15D16FF928CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240521160714.GJ20229@nvidia.com>
	<20240521102123.7baaf85a.alex.williamson@redhat.com>
	<20240521163400.GK20229@nvidia.com>
	<20240521121945.7f144230.alex.williamson@redhat.com>
	<20240521183745.GP20229@nvidia.com>
	<BN9PR11MB52769E209C5B978C7094A5C08CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20240522122939.GT20229@nvidia.com>
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

On Wed, 22 May 2024 09:29:39 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 22, 2024 at 06:24:14AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, May 22, 2024 2:38 AM
> > > 
> > > On Tue, May 21, 2024 at 12:19:45PM -0600, Alex Williamson wrote:  
> > > > > I'm OK with this. If devices are insecure then they need quirks in
> > > > > vfio to disclose their problems, we shouldn't punish everyone who
> > > > > followed the spec because of some bad actors.
> > > > >
> > > > > But more broadly in a security engineered environment we can trust the
> > > > > no-snoop bit to work properly.  
> > > >
> > > >  The spec has an interesting requirement on devices sending no-snoop
> > > >  transactions anyway (regarding PCI_EXP_DEVCTL_NOSNOOP_EN):
> > > >
> > > >  "Even when this bit is Set, a Function is only permitted to Set the No
> > > >   Snoop attribute on a transaction when it can guarantee that the
> > > >   address of the transaction is not stored in any cache in the system."
> > > >
> > > > I wouldn't think the function itself has such visibility and it would
> > > > leave the problem of reestablishing coherency to the driver, but am I
> > > > overlooking something that implicitly makes this safe?  
> > > 
> > > I think it is just bad spec language! People are clearly using
> > > no-snoop on cachable memory today. The authors must have had some
> > > other usage in mind than what the industry actually did.  
> > 
> > sure no-snoop can be used on cacheable memory but then the driver
> > needs to flush the cache before triggering the no-snoop DMA so it
> > still meets the spec "the address of the transaction is not stored
> > in any cache in the system".  
> 
> Flush does not mean evict.. The way I read the above it is trying to
> say the driver must map all the memory non-cachable to ensure it never
> gets pulled into a cache in the first place.

I think we should probably just fall back to your previous
interpretation, it's bad spec language.  It may not be possible to map
the memory uncachable, it's a driver issue to sync the DMA as needed
for coherency.

> > > Maybe not entire, but as an additional step to reduce the cost of
> > > this. ARM would like this for instance.  
> > 
> > I searched PCI_EXP_DEVCTL_NOSNOOP_EN but surprisingly it's not
> > touched by i915 driver. sort of suggesting that Intel GPU doesn't follow
> > the spec to honor that bit...  
> 
> Or the BIOS turns it on and the OS just leaves it..

This is kind of an unusual feature in that sense, the default value of
PCI_EXP_DEVCTL_NOSNOOP_EN is enabled.  It therefore might make sense
that the i915 driver assumes that it can do no-snoop.  The interesting
case would be if it still does no-snoop if that bit were cleared prior
to the driver binding or while the device is running.

But I think this also means that regardless of virtualizing
PCI_EXP_DEVCTL_NOSNOOP_EN, there will be momentary gaps around device
resets where a device could legitimately perform no-snoop transactions.
Thanks,

Alex

