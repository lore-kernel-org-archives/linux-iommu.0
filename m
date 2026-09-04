Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1141F5F3
	for <iommu@lists.linux.dev>; Fri,  4 Sep 2026 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548796; cv=none; b=FMw83JbgPeNa7EG8XJdi97QFeUDhe7yd0RjcJF5s202tLgKQN4yUNaxiCS5sXSLnOKtQf8vbadx3uV5C0KDUK1DVpGC8l6nQ49t5QpXgIQTBAwmaxbPgqs4dl+9HjAorRoXjyl2XO29qvuHTLbYIJWARMHndm3c5arpiZ1VAuWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548796; c=relaxed/simple;
	bh=21Bh4RJxpeiCW82oSWerk5Qo5AfL15/5sh5ePR1ifY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcfQFC0uPNQPTcXmrovKfUlvXY9Nno9QBST3WsfBE/jAaSeJI2XYUvHClMz4tu9AQSRbgDpHmKm5A56zOGNNZ2d/cIJoEX0YWm/n+K4lnVPrEhZtGQBWiRiISw68uuYcA3A76VwT/Qe8CXUSA44hNYbn/vgoXrtyqcutn8saZ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XlO4Owia; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XlO4Owia"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-86b03b75fecso23902407b3.0
        for <iommu@lists.linux.dev>; Fri, 04 Sep 2026 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1788548787; x=1789153587; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P3rzU4rRnN7pu/GZMmTRQuFVrRv0l5idd5+55lRqVAM=;
        b=XlO4Owia3UaDqO6YmrPTEvz8hk2SLPFksr2HNQHnzX4vuB+yCOLdu4NrKP5JWDJX12
         Af3pluPSXd7xSldPOzdikTJ5Vdsz2a7wVeYkLogEE5KhRKvlrGZU7BkeVIfKj0XH0Gag
         O0KJDYNE1flrqYbqowOM6fnh4UJsPbnzm+suQ9yZKA/4RUlPxTpbe1qC0COt8BhLbM6p
         BpvIZ1vnyieOz/txNy2lx+EDdMScLc4w5sBZk1eMUU3PHzP63MS/aX8vl8OQ2zM0neuv
         QKpXo2mk2EvZ51bQ/Lk++LwlA8X7wlPo0qwBI4/V32CGfi5N4mWQ/XlUCLA0kuLD222Q
         zbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788548787; x=1789153587;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P3rzU4rRnN7pu/GZMmTRQuFVrRv0l5idd5+55lRqVAM=;
        b=XEk+0ZAurXItA6vszFiZ9BCrByQJSETQqqaCYOGmM7ofbGjcsZdkfLBMu2bQxj7ZKS
         FOjU8EBm5mpWWSrMolvsAcNAtFC1ziAar0a9GGcYQVZxYVYEOxBqvBXD8ZMp72NT8ZT+
         0ohi0eFDkTNa5/t45v3tWba44r/HbQLt6m5WtjWdvhFUHFvOzeZjE9G0bhIpXSMunqyd
         S5tEDzC4AEk3EwODhBLrZYVowliSy8QjdAzWAjJ7Ud6DOVU1b4xKi3tgpfEzqREhqD1U
         TNipr+mbBY6jo87g5eZmKpPMO5f54/Kzbf8xC46oNtH5Ssg++V4bDS++qBLDiToQqdct
         cG9g==
X-Forwarded-Encrypted: i=1; AKwUvByYat7UVB6KIAufsX/7I+BHDjq59VRahxyeF3VF2HzORh1r+zEyKdy1niX7iwOZ3PcPgDfGVg==@lists.linux.dev
X-Gm-Message-State: AFuF++nlC17rqx/s599kEZIYfzglno3668RPAAf6JNXG8PmtnfcSVaRD
	6yxMSa5ks+6PBzrqkB4BocxOrFRu8/a3COHuAMYI51a+vRxOhldLBlEHH7EJTnuzByE=
X-Gm-Gg: AYBFou1VlTeriyYDTKjTQYDxSjRLmGr4NiysPabU0yVYg9txduwf9e1hF5//654WwMQ
	/r+e1r5KX0mmwhHNHlcE+cW3/+lhCLaTBkIJO0Dl/orcDls+JkBuxgo6xwQ8DaC7mbyMfDfPuhi
	Z3kKywzSyjqSoZ/SdJD/3fA9rXUfVLgcuz+j6+QaKw//TqeJtS5gUYqS6vBfCx4ACVkOEZAgYCY
	28CQ9uXvVLPC/bu+uVxyLH6OQqoUlpCbjGUkBrzJchz4E9sOMJFxNCfU5USSSG08EzvHfq83OF4
	XJPPKfS9F/rAVNRk24AgjhCxcVZwocQ32nKbDFxUgkNUBXAtDt5qxha9aVVgZSQmWouH2nqlHXw
	HRo4k2C9UttoYgC9fTGMrHB+Xemit3u5g2m3qe0LMx+bXD6vpAumy0pOQYPUAB1fscqTj+QPIBb
	SgFnDrJwK/8YFw6ryknjt6mOHSpEXqRvfLHGmNfeGPZiyvcMSqtrSoliGcp6N/RziTe5nI8lv/D
	8RK5P2uqHHtiU62+bqAdT2RYiYS3tH/Hi9PxAMlVnrW1qdov5Q28wzLWg==
X-Received: by 2002:a05:690e:2026:b0:66f:c284:4834 with SMTP id 956f58d0204a3-66fc2844e8amr819081d50.60.1788548787246;
        Fri, 04 Sep 2026 12:06:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406481b4sm27434626d6.17.2026.09.04.12.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:06:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x2ZF3-00000002uJq-3KUc;
	Fri, 04 Sep 2026 16:06:25 -0300
Date: Fri, 4 Sep 2026 16:06:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Alex Williamson <alex.williamson@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <20260904190625.GA667892@ziepe.ca>
References: <20260812045325.2733631-2-alex.williamson@nvidia.com>
 <an5JbIzz40svS3xe@google.com>
 <20260814083737.66bb83fb@nvidia.com>
 <20260817121810.GC933791@ziepe.ca>
 <CO1PR11MB48354AC2854C4D8E9984FD8E8CA62@CO1PR11MB4835.namprd11.prod.outlook.com>
 <20260818140304.GC5482@ziepe.ca>
 <20260818143906.1f58aecb@nvidia.com>
 <aod22_H66eUth9av@google.com>
 <20260820233722.GA1110819@ziepe.ca>
 <aoeffe1v--CgRK0a@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoeffe1v--CgRK0a@google.com>

On Fri, Aug 21, 2026 at 02:20:55AM +0000, Samiullah Khawaja wrote:
> On Thu, Aug 20, 2026 at 08:37:22PM -0300, Jason Gunthorpe wrote:
> > On Thu, Aug 20, 2026 at 10:38:07PM +0000, Samiullah Khawaja wrote:
> > 
> > > > The blocking domain operation looks like it might be simplest to
> > > > implement in the IOMMU core.  We can set a flag for a default blocking
> > > > domain on the IOMMU group when we take_dma_ownership of the group.  Then
> > > > release_dma_ownership picks the blocking rather than default domain.
> > > >
> > > > This is then unwound in use_default_domain, called via dma_configure,
> > > > attaching the device to the default domain in probe of the next driver.
> > > > Therefore until probe by another driver, a device used by vfio would
> > > > remain in a blocking domain even while unused and unbound.
> > > 
> > > The devices are expected to be attached to the default_domain even when
> > > these are unbound and the use_default_domain assumes that, and it only
> > > checks the ownership and doesn't switch the domain to default_domain. I
> > > guess we should add a WARN in use_default_domain() if that is not true.
> > > I will probably send out a patch for that separately.
> > > 
> > > I think we can move the device back to default_domain after reset after
> > > unbind, maybe it can be done in pci_dma_cleanup() based on
> > > driver_managed_dma?
> > 
> > This blocking domain stuff sounds very similar to what Nicolin
> > implemented for the per-function ATS issue?
> 
> I see you are talking about this invalidation stuff:
> 
> https://lore.kernel.org/all/348c50ab6e95b5ec6d48ee3fa05d529a784a34c3.1765834788.git.nicolinc@nvidia.com/
> 
> But this was the case where the device is going to be reset and to
> prevent ATS issues, we attach it to blocking domain before doing the
> reset. But of course, with the PF reset here, it induces the same kind
> of ATS issues on the VFs.

Yes, we need to attach a blocking domain before we make the function
unable to respond to ATC invalidation. PF or VF reset both trigger
this condition.

> Hmm... doing that for SRIOV also, by allowing PF reset but attaching the
> VFs to blocking domains before the PF is reset, will only resolve the
> ATS issues. But the software state is still out of sync with hardware
> state.

Sure, it doesn't fix everything, but it is something you'd need to do
to avoid problems in the iommu driver side..

Jason
