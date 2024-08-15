Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8F2A8D0
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741153; cv=none; b=gbQMIfVPHa9TUk3fXREaA2NeKpVlXx9TbZCT6sk0fMUZAlk6uDQZHnMbPToMzSUjmVO4DNJs6LyUD+65NYKfMPLq3VDLYK5MbQlNnUP1BjMNxaPapPvb5BvRcVhkePCvcYfyY8vj2O6e6HDGQ2kbcQlKFeHK1PXlQF1MKdP9GMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741153; c=relaxed/simple;
	bh=3hIwpWIXEHc6rIHNNwobnugw6L7v+QjdIrBr1viVgI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSKO2gac7D48DPJ4qM8Nie1wKAsL+BjYD+GGMR9kH5rvFso2rK+61qF6P7QUfehhadKtOSgrTLVntWnChAPZ9UbDRp3Wn8DZbcJ1jMP6royj3r2BNE91kK5av7OHTSWSl4c8YyYFRH4RDNq7rPCUXEbJ6+ZT1oToFVIxfDcj4lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvHNT8Ks; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvHNT8Ks"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723741150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlcSz4KYwAPgWcAKkWXUG1nSmDKdddlqy88W5LmzqbQ=;
	b=DvHNT8Ks9er0yzKFAFBZwcINolhnMs610dS63wH8jMV51W3CTZa8LY8GBbjOPWJRSSFvab
	5jwcrulIeU4z1Klc31juwIUPKJA7hrJMlkvogHLm3lOv7iBZA7z5ckg4z54Yt+10fBRlB9
	7hMPlIBXoIG+YS86XDmPNviCQnTEDdY=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-LEMu9OqyOuue4-UE7xz2gQ-1; Thu, 15 Aug 2024 12:59:09 -0400
X-MC-Unique: LEMu9OqyOuue4-UE7xz2gQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39b38200743so11875595ab.2
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 09:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723741148; x=1724345948;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlcSz4KYwAPgWcAKkWXUG1nSmDKdddlqy88W5LmzqbQ=;
        b=aRCwN2vtAFbSuxjP/YFmD9DZW0EKawk1aizJF2MQwMC8lgcfWSzpBI8Y0n9u2wofS0
         wvyMNZob9SJUDNtNTFbdBgO+CG9/TC1SqwuCbQtDiDpt5ORIJMYJKmlfPQ8J7oRCgUNO
         IWnU0K07gzlkngpXacqUYxlJ1/EbBZF6c2YKjZkio9rQdUTKPyyfwpC5S34UXP0RWjFi
         fcAR3vizYtD72yWkCSglJaWxb4j3McFh8uE1iU4+B8SWUVxpub0RCpSaCWjzC+uw+z0+
         Lvd75U5PK4d+bsiRZdmzXpqJQ6EIui1VCeS0sHlB+syc2oW2jZLNAy+qOyuKq09tXt+Y
         MqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMN/0WtkVo5JmtrTl706dbTzcMglHqYG34U0UDcbGFi4WLuM+mdqRq42vPou8Bqi7ybuGSJ6++1GBpmc3P3Pz+NoYO4tU=
X-Gm-Message-State: AOJu0Yyj6WUl8z5L6NlQBTPVwRYxeNKSSL2NXwDqtTsVSJFoTAuCmkl7
	0KP9NFF9WhxV7MpBoyB1d26iiU3rA9+ScTi795aDj9kYOhj0mdBhrhfbgb86vjkRSw/hv5jP+ML
	4sH8lDOcQOZE6LUJly2s7LUFBvLGFfeMaFJJSbNHCb1EInTjEBqSz
X-Received: by 2002:a05:6e02:1aaa:b0:39a:ea4c:8c26 with SMTP id e9e14a558f8ab-39d26cdf8fbmr6083275ab.1.1723741148130;
        Thu, 15 Aug 2024 09:59:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnffchl9WybcknzKF++o1mrFSsyjdEylnwuSiMZ5up4JHfQDmnQXUAj1Uo1c5erjQFGND9Ig==
X-Received: by 2002:a05:6e02:1aaa:b0:39a:ea4c:8c26 with SMTP id e9e14a558f8ab-39d26cdf8fbmr6082925ab.1.1723741147721;
        Thu, 15 Aug 2024 09:59:07 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d1ec19de3sm6807035ab.45.2024.08.15.09.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 09:59:07 -0700 (PDT)
Date: Thu, 15 Aug 2024 10:59:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, quic_bqiang@quicinc.com,
 kvalo@kernel.org, prestwoj@gmail.com, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, dwmw2@infradead.org, iommu@lists.linux.dev,
 kernel@quicinc.com, johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci-quirks: Quirk for ath wireless
Message-ID: <20240815105905.19d69576.alex.williamson@redhat.com>
In-Reply-To: <20240813233724.GS1985367@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
	<20240812170045.1584000-1-alex.williamson@redhat.com>
	<20240813164341.GL1985367@ziepe.ca>
	<20240813150320.73df43d7.alex.williamson@redhat.com>
	<20240813233724.GS1985367@ziepe.ca>
Organization: Red Hat
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

On Tue, 13 Aug 2024 20:37:24 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Tue, Aug 13, 2024 at 03:03:20PM -0600, Alex Williamson wrote:
> 
> > How does the guest know to write a remappable vector format?  How does
> > the guest know the host interrupt architecture?  For example why would
> > an aarch64 guest program an MSI vector of 0xfee... if the host is x86?  
> 
> All excellent questions.
> 
> Emulating real interrupt controllers in the VM is probably impossible
> in every scenario. But certainly x86 emulating x86 and ARM emulating
> ARM would be usefully achievable.
> 
> hyperv did a neat thing where their remapping driver seems to make VMM
> traps and looks kind of like the VMM gives it the platform specific
> addr/data pair.
> 
> It is a big ugly problem for sure, and we definately have painted
> ourselves into a corner where the OS has no idea if IMS techniques
> work properly or it is broken. :( :(
> 
> But I think there may not be a terribly impossible path where at least
> the guest could be offered a, say, virtio-irq in addition to the
> existing platform controllers that would process IMS for it.
> 
> > The idea of guest owning the physical MSI address space sounds great,
> > but is it practical?    
> 
> In many cases yes, it is, but more importantly it is the only sane way
> to support these IMS like techniques broadly since IMS is by
> definition not generally trappable.
> 
> > Is it something that would be accomplished while
> > this device is still relevant?  
> 
> I don't know, I fear not. But it keeps coming up. Too many things
> don't work right with the trapping approach, including this.
> 
> > The Windows driver is just programming the MSI capability to use 16
> > vectors.  We configure those vectors on the host at the time the
> > capability is written.  Whereas the Linux driver is only using a single
> > vector and therefore writing the same MSI address and data at the
> > locations noted in the trace, the Windows driver is writing different
> > data values at different locations to make use of those vectors.  This
> > note is simply describing that we can't directly write the physical
> > data value into the device, we need to determine which vector offset
> > the guest is using and provide the same offset from the host data
> > register value.  
> 
> I see, it seems to be assuming also that these extra interrupt sources
> are generating the same MSI message as the main MSI, not something
> else. That is more a SW quirk of Windows, I expect. I don't think
> Linux would do that..
> 
> This is probably the only way to approach this, trap and emulate the
> places in the device that program additional interrupt sources and do
> a full MSI-like flow to set them up in the kernel.

Your last sentence here seems to agree with this approach, but
everything else suggests disapproval, so I don't know where you're
going here.

I have no specs for this device, nor any involvement from the device
vendor, so the idea of creating a vfio-pci variant driver to setup an
irq_domain and augment a device specific SET_IRQs ioctls not only sounds
tremendously more complicated (host and VMM), it's simply not possible
with the knowledge we have at hand.  Making this device work in a VM is
dead in the water if that's the bar to achieve.

I observe that the device configures MSI vectors and then writes that
same vector address/data elsewhere into the device.  Whether the device
can trigger those vectors based only on the MSI capability programming
and a secondary source piggybacks on those vectors or if this is just a
hack by Qualcomm to use an MSI capability to acquire some vectors which
are exclusively used by the secondary hardware, I have no idea.  Who
can even say if this is just a cost saving measure that a PCI config
space is slapped into a platform device and there's simply no hw/fw
support to push the vector data into the hardware and the driver
bridges the gap.

The solution here is arguably fragile, we're relying on having a
sufficiently unique MSI address that we can recognize writes with that
value in order to both replace it with the host value and mark the
location of the data register.  If someone with some hardware insight
wants to come along and provide a reference for static locations of
these writes, I'd certainly welcome it.  My sample size is one, which
is why this is posted as an RFT.

I do not believe that introducing a vfio device feature that disables
virtualization of the MSI address/data _only_ at the vfio interface
(not to a QEMU VM) provides some implicit support of this device
behavior.  These values are already available to a privileged user in
the host and the same is available for an MSI-X use case by directly
reading the MSI-X vector table.  The only point of the vfio device
feature is that we need a vehicle to expose the MSI phsyical
address/data values through he vfio channel, without additional host
privileges.  The virtualized values are essentially unused by QEMU, so
why not give QEMU a way to turn off the virtualization to expose the
host values.  Thanks,

Alex

