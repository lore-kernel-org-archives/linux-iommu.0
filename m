Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8171CBEB9
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567812; cv=none; b=SIPmntxy8mbqOqOPzNEsRgWKxktQzSY38cRXfuqOcQrYF9TdEY8iTqoFB0ipf5/Y5s7IZ9LVfB8BDldcgTGRmiqV3NKe42HKQqVNekEzdosXpLSTOICacsY6QBOLXaJBWnRDkWfiAt2T540trcx4ZD8xKRU4jzxRaCiNKBCrhus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567812; c=relaxed/simple;
	bh=LuQ6nfbsZxrXAj6qI9VJl71Yj4w+NO2Brs57FpbEY6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsbnnqBnILq1hwZmP3zl3XAPwIj46fBZPCDzIAvR/DfU8HUw7Dx/wT3ojlVTwcH9lT1O+CfWhQh4CL6XnsP4klOtcympRs809/GwsV677poG//Xs0IWdhUrrjcLfJAvY+VCcNuiSLg0fgnW1sg2jgMz144sd4UCuayp+gx0ujJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vco6KkEA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vco6KkEA"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2242ac37caeso145985ad.1
        for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742567810; x=1743172610; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hxrgyaJKrS+dceEI41sRmgEHLaWRk4KoMQ5okYG8+h4=;
        b=Vco6KkEAdswjkGd3vs5DNIb2oFzOQFLDwZiNuHW+StiRZod9K+Jagd88VEGJCtNYbQ
         PCXOkGGUXeKD1uXbIicyvGJxuORC72J8EIK4rKla33nV9mzu9Mn95OHRwZiq7gBwFzmA
         WMcdgvtenZofRaMBhu586BAXFXcCw2AXwS0aDDbTATHxS880ou7eUgzMuJF0TTMQMSru
         VIKSSWnUALXIosn8BHbpPcauIMTzaoqgQ4gfBH3DXG1YOAU9wELz7NKLwb/ZoRq/v+UE
         xfi1+T6Q1OEGbiZB1AT9qej3kHdL1uJKnXhkm5/kaHPN/zE5Iv1eKnNvuRReB5oTP6q2
         y8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567810; x=1743172610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxrgyaJKrS+dceEI41sRmgEHLaWRk4KoMQ5okYG8+h4=;
        b=NwhtkZZx1hHXHGccn2mpS2nLs+lg+t4C0UYzkqxk3Sa5EMgCOg4q9JYUkxdzCSD//d
         NtgntvGJXnkbn8WDyKw6uTZqPv8p9eaQfLZPeQS/yV9teZhJlRpLHWhFjLZW6XF+Cbmr
         DvYVEGA4/IIR7TxVhJ6j6ysOrqOgEFXq1PH1WlFJ0Df8wRdArVrdE8V6b+VZ4bAF+Y3N
         JO9Q18/FxYqMh9J6gHkDTR1ryxFPA5dDSXptW6MafMYpWqJAnu2+DwloM0OCluJOJ2mQ
         QS6TRSYvLQcthWQ4SaldKGlAM/eUwjLgGAuh66OeH2eVFXfWEiNBe1TnKIbM1SI8MK5W
         SpHw==
X-Forwarded-Encrypted: i=1; AJvYcCVG7kwos0i4HD5yPgifs/agERulLxvJHjTFqz+ZmPMqsvxVQgMsm4uJULqnmYrY0F0A9JqTOw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2tSPhNDJHWCq0apfV7yZ+I1Ikg1GMnlCZAipReZoNBr4X4wE/
	lmVrImdWan3zQJIqzz0ZrpQp+aDzO2chWLkEdOS1g/tJGcGfgaxHQJ6r7C02Sg==
X-Gm-Gg: ASbGnct+BqIi4VyO10N+cAfhULfyWahvBn8Ud8Z/GM48qPrW0ytT8XInbBdoaTT36q1
	7Uc84apUMFaDJiJR84e/E0+AvOtHu8QQ0FUqf83nqRdkDXdp6+ffAYRv6NnMtb+eGb1CUSdg8PA
	cLXS0pxH8MhowO39dZTiPF7qCWbnSpBNvstyqb0pSZcLC6m2c0b1s3b8ya0/+/qbk+SfoL8GfR8
	J8hDOrOB+GQ+3NBHx+FpKmUeyWPq94KBt3DqOZBE2coVXJmkx88hjFeKJaEv5melomv0bcwjpG7
	6x2j2vUWMItMU2R70kp08epATqhCgKE5zvpjGNe0wxj+2hbS/vzYiJXT/+RAL3PcEV9BwJ8zbG2
	Sakk=
X-Google-Smtp-Source: AGHT+IFfQf26xs2g85PUc36P/NsI/S09Q0AmISb32x+PsmvkWk7p1vX8NtDW+rL1YDc+JNbU5i9Q3Q==
X-Received: by 2002:a17:902:e80b:b0:216:21cb:2e14 with SMTP id d9443c01a7336-227844dde68mr2197765ad.21.1742567809646;
        Fri, 21 Mar 2025 07:36:49 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3969dsm17333205ad.45.2025.03.21.07.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:36:49 -0700 (PDT)
Date: Fri, 21 Mar 2025 14:36:41 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <Z915ebfGstqI0NIQ@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>
 <20250319194609.GA126678@ziepe.ca>
 <Z9yCCe1mRTr-4dTx@google.com>
 <20250320230813.GM126678@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320230813.GM126678@ziepe.ca>

On Thu, Mar 20, 2025 at 08:08:13PM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 20, 2025 at 09:00:57PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Mar 19, 2025 at 04:46:09PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Mar 19, 2025 at 06:22:30PM +0000, Robin Murphy wrote:
> > > > I don't see SVA and VFIO needing any special considerations, so it might
> > > > just be the new vIOMMU stuff which may need to hold PM enabled for the
> > > > lifetime of things exposed to userspace.
> > > 
> > > Are you expecting that the VFIO driver, and whatever driver is
> > > managing the SVA will keep the power turned on as necessary then?
> > > 
> > > VFIO is not going to work if the SMMU power goes off unexpectedly
> > > while the VFIO FD is open.
> > > 
> > 
> > In that case, why not hold a ref till the FD is closed? When all the
> > refs are dropped, we can safely power it down?
> 
> I assume VFIO is already doing that?? It must be keeping the PCI
> device powered up, doesn't that automatically keep the SMMU powered
> too?
> 

Yes it should if the devlinks are setup correctly.

> 
> > > I suppose VFIO also can power off on-demand via userspace asking
> > > it. In that case the VM would be co-operating.
> > > 
> > 
> > I'm wondering if user-space / VMM would be willing to control runtime
> > power at this point? Maybe we could have n VMMs vote when they need
> > power and drop the votes later and we can simply rpm_get if votes > 0
> 
> Yeah, I imagine that is how it would have to work. 
> 
> > > viommu I think will only uses STE fields so it should be OK?
> > > 
> > 
> > What about IOMMUFD stuff like the Get HW info IOCTL?
> 
> Isn't that all from SW caches?
>  

Not really? I see arm_smmu_hw_info reads all the IDR registers..
The call flow I could trace is like:

iommufd_get_hw_info()
 -> iommu_ops->hw_info()
   -> arm_smmu_hw_info()

Am I missing something here?

> > > SVA.. Is similar to VFIO, if the power goes off while the SVA is
> > > working that is bad. The SVA requesting driver would have to manage
> > > this. HW with userspace command submission probably can't allow the
> > > power to go off while command submission is possible.
> > 
> > Hmm.. maybe then rpm_get() 
> 
> Again mostly assuming the SVA using driver is already doing this
> somehow?
> 

Hmm.. yea it should happen through devlinks too.. Let me re-check if
there's a surprise somewhere.

> Jason

Thanks
Praan
