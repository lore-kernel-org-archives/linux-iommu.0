Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D921E86A
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723583008; cv=none; b=c4pkgHKSnqoLbbAHF/gTBftc/T/W8lhkbPopHygzkaRdjHO5+ZDFkFTVoyYHaUImrrE/3h2IKldBIwulXGVzkZ6iEwsv1UJw1zRU0Hbsol+oKLMHGBS1u2Eodu2Eniy0GWaHebWXhykRxC7FbtDbp8X1MX4nOxYZACwLg/a0Dhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723583008; c=relaxed/simple;
	bh=S1wGFKTAEjSQsbf68k5RXdglIXflEszFnfO6eF1HbfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWCX/mO9r1Om5aQY9vZjIibWP81WdchULTNpvQn4j8GOM5YAw8kFNR+orT6axqMRrQsoIFUf996rU40HN5MnrB4LOMOeOAN5cBmp0Xfux8HN5nKIaRqUm9hHsWLbqvjD1e87B+6AGQmNTV+gOqyUedD2FZT1MIh0vjmadwZGbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzZPKLdm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzZPKLdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723583005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1UOf/e3HcQ+l94OWXrCwdSK3TbHtvFPHwqfrVahjAnI=;
	b=HzZPKLdmzl9SfUMMYWJITFd9JXtrdorv7WolYXcogxGZTwKSAKv1H2cpdHiss7rLBprePA
	1JTkHWGsRIi5aHPMmcZjtdmIqmRHxcf2q85Eq7cXSu8UktEGheGfJtU92WgydJzbp6OTWc
	vtTpEUgoVarlN/HBi/pu73aIU06I6yU=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-2mKpQcheNqGXm-8N9vIf7g-1; Tue, 13 Aug 2024 17:03:24 -0400
X-MC-Unique: 2mKpQcheNqGXm-8N9vIf7g-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f968e53b0so763208939f.1
        for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 14:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723583004; x=1724187804;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1UOf/e3HcQ+l94OWXrCwdSK3TbHtvFPHwqfrVahjAnI=;
        b=VqUgNTgc1WB2o2K0UhrWVq/eQR8/aI4HQqYqF85WI9fMD2QkjCgNMpGXbDdGPe6n4D
         xoSGHeltx3bBMJqvQCBjIC/TD18SywrP6aa4eGpi9+7W9FxTAfb/uP8DqXYbnLs/Vz/t
         96oWcTZ1qCyEoLgL3u/Bn2srcQNk1yXYIq2fohib8b4qnIngtx2GAUD/2wiyM4CqdzeV
         qIiP7lOa38v4H44FAF6cHgeRUMB+JIRYMHEI9cU+VvDQfAufddwUDm0p+DGkPQB6heVC
         rYzvOzPMHagxV2D94C8ABW8V99H/R3AbSfIGsAhtaIkqWyyr4hTxB9JpwS8TDrbNdhxY
         wfOg==
X-Forwarded-Encrypted: i=1; AJvYcCX2Ht2wAQofgVeq+fMj2vXix1K6S1zItrDxO7thCOqyaZxav0aSr8nUWGlWHEJOwQnmxNTUdDPZe3mFfuM8qwNarO4wIaQ=
X-Gm-Message-State: AOJu0Yy5VG+WdGq6B4H5b2qBWZIeYB/KJQbIymAFCrMjZVOPtr/3KLvD
	YBhZ7KCpqrpm3DVQZcbQn5gfGpfq/5R7O7BNFHOshmW4HOT6LxcIv+YK4hyxkQsdk0QTHTKpbST
	m/ZdMu67JIFE18GjsKWNPW7J7n+kxORsyGkHJpaJzDNr/fyfcnlUQ
X-Received: by 2002:a05:6602:14d2:b0:804:9972:2f8c with SMTP id ca18e2360f4ac-824dad04265mr122543239f.8.1723583003650;
        Tue, 13 Aug 2024 14:03:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUG+Ra/4MLDKrpbcdWTsiFMgCKM25UlSCbFVfALG5nTggblaB3Mjb05rv1rYcf1nGj/+3LVA==
X-Received: by 2002:a05:6602:14d2:b0:804:9972:2f8c with SMTP id ca18e2360f4ac-824dad04265mr122539339f.8.1723583003274;
        Tue, 13 Aug 2024 14:03:23 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca76910393sm2733107173.7.2024.08.13.14.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 14:03:22 -0700 (PDT)
Date: Tue, 13 Aug 2024 15:03:20 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, quic_bqiang@quicinc.com,
 kvalo@kernel.org, prestwoj@gmail.com, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, dwmw2@infradead.org, iommu@lists.linux.dev,
 kernel@quicinc.com, johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci-quirks: Quirk for ath wireless
Message-ID: <20240813150320.73df43d7.alex.williamson@redhat.com>
In-Reply-To: <20240813164341.GL1985367@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
	<20240812170045.1584000-1-alex.williamson@redhat.com>
	<20240813164341.GL1985367@ziepe.ca>
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

On Tue, 13 Aug 2024 13:43:41 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Mon, Aug 12, 2024 at 11:00:40AM -0600, Alex Williamson wrote:
> > These devices have an embedded interrupt controller which is programmed
> > with guest physical MSI address/data, which doesn't work.  We need
> > vfio-pci kernel support to provide a device feature which disables
> > virtualization of the MSI capability registers.  Then we can do brute
> > force testing for writes matching the MSI address, from which we can
> > infer writes of the MSI data, replacing each with host physical values.
> > 
> > This has only been tested on ath11k (0x1103), ath12k support is
> > speculative and requires testing.  Note that Windows guest drivers make
> > use of multi-vector MSI which requires interrupt remapping support in
> > the host.  
> 
> The way it is really supposed to work, is that the guest itself
> controls/knows the MSI addr/data pairs and the interrupt remapping HW
> makes that delegation safe since all the interrupt processing will be
> qualified by the RID.
> 
> Then the guest can make up the unique interrupts for MSI and any
> internal "IMS" sources and we just let the guest directly write the
> MSI/MSI-X and any IMS values however it wants.
> 
> This hackery to capture and substitute the IMS programming is neat and
> will solve this one device, but there are more IMS style devices in
> the pipeline than will really need a full solution.

How does the guest know to write a remappable vector format?  How does
the guest know the host interrupt architecture?  For example why would
an aarch64 guest program an MSI vector of 0xfee... if the host is x86?

The idea of guest owning the physical MSI address space sounds great,
but is it practical?  Is it something that would be accomplished while
this device is still relevant?

> > + * The Windows driver makes use of multi-vector MSI, where our sanity test
> > + * of the MSI data value must then mask off the vector offset for comparison
> > + * and add it back to the host base data value on write.  
> 
> But is that really enough? If the vector offset is newly created then
> that means the VM built a new interrupt that needs setup to be routed
> into the VM?? Is that why you say it "requires interrupt remapping
> support" because that setup is happening implicitly on x86?
> 
> It looks like Windows is acting as I said Linux should, with a
> "irq_chip" and so on to get the unique interrupt source a proper
> unique addr/data pair...

The Windows driver is just programming the MSI capability to use 16
vectors.  We configure those vectors on the host at the time the
capability is written.  Whereas the Linux driver is only using a single
vector and therefore writing the same MSI address and data at the
locations noted in the trace, the Windows driver is writing different
data values at different locations to make use of those vectors.  This
note is simply describing that we can't directly write the physical
data value into the device, we need to determine which vector offset
the guest is using and provide the same offset from the host data
register value.

I don't know that interrupt remapping is specifically required, but the
MSI domain needs to support MSI_FLAG_MULTI_PCI_MSI and AFAIK that's
only available with interrupt remapping on x86, ie.
pci_alloc_irq_vectors() with max_vecs >1 and PCI_IRQ_MSI flags needs to
work on the host to mirror the guest MSI configuration.  Thanks,

Alex

