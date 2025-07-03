Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CE8230269
	for <iommu@lists.linux.dev>; Thu,  3 Jul 2025 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751581057; cv=none; b=P1/Py5L3F/cq5jToNTh3qIMm0X3YfaXz9DY3FOYvXik0xoK+5UzVanJHpiCuj3ixYBTdExoHUev4tZ68Bf0SdDcLJonQwehNKwE9ivLWF41srAfN6keDNjfg9Doeu2flVLz8GywhY+oUZkrzKGtlomUijmtao+FohS2RGJjJk58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751581057; c=relaxed/simple;
	bh=4ypezCMzqx2m8rAZovbE9cWrKwtdXpCPRYKVPomZyMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFHIpD49D8wTnew8yhGL5DhCaQ1Hd4s+Ldvw0RmvnmHcX56B2bdriJyAoI/n4F/0qZvO8xyUcYQVg0YATIn0VKs05nqwyxKm+oDQ2X25NXGzwtFRyeUS+F2zm8AoXtCa0o5V7jNAWIEFSjDTkJ62Sccf2BFWVfUZNRy0pJZ4YMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMm777n2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMm777n2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751581055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dsjcnePffsNnJ3iYlPAnCmr2JiGAFkwGmeExoquH+U=;
	b=JMm777n2C4DRY6n4IcybNH0M902Y3PPE39VX7XpSCYgWYI2Bfx4mJoL0EqATC6Yl+fE+p1
	Cmzln35bao8gfZyHLSxoWU7JPFChm9EtYbOSGiEZhoKeGjmT6hxZIG9n6jYPuMh8kc1mdP
	GACvx7YlZB9sjtfkOKMzRZe30efToG4=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-YRn_sJstNEi-gJO0AdsX4A-1; Thu, 03 Jul 2025 18:17:32 -0400
X-MC-Unique: YRn_sJstNEi-gJO0AdsX4A-1
X-Mimecast-MFC-AGG-ID: YRn_sJstNEi-gJO0AdsX4A_1751581051
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-875cdf03c23so4941739f.2
        for <iommu@lists.linux.dev>; Thu, 03 Jul 2025 15:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751581051; x=1752185851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dsjcnePffsNnJ3iYlPAnCmr2JiGAFkwGmeExoquH+U=;
        b=Ulril4RDsxo4fkFc0Hs92iAkCp1blWb5ZqsEGa15jAsNNjetlujbPb6aBtNl1OwlaY
         DKuMaPJXtSi3CwI00PQEk3J/rYGavAXJ/VionMByoPnJCPdaW2xxAfBYTBCeChRVNR4E
         P96yMyIthba/I8T4LjXxjzKIj2WarYE7+pDtMEl7O31ptn9n3ukHZUaCoi+qkNKj6BiZ
         wug0KhbgLj3NqnY8vdqNaJHZQPlgPKrqERroubv+wiukcJ0f1CMNoCvSpQ1SZESoZco2
         U9BoQP7ChVvMMsV0x/Ag+H3nkPsYnLr4BijlalbqdIEWYBc2JRNGn7l+vPt2hcMeMns2
         NENQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCZD9KQ6lLSla3Wo+n5KKlpokiUZjiqXMmNECpgIwPQuEstRL6g4aNzBx5z+JQ4EcwTLvsxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzO9lt9+dHPMbVd106FQyUsCBQrXOZQ55KQyiyl32Ri4wG4dWWE
	XfEjz7jaDY5TXdnje6B4y4CQdsAlMeej7ek9+wvK2eYCLPkAVyRd00gw06adBX+DfgdnIufnl9I
	JVWI6oznM/wXMfWlKggPIT4Sf8n4z70IB4bOG6XoLaUoLGLJNqqtycMv1
X-Gm-Gg: ASbGnctYOklcGgbsv6WmYWcDC6Xl+CvIO/BEGz8GSg7rawVJ1nl43gyU6uLrwVeGaYe
	T34ddaOKmHHHy/R6Jy/AxaJOAPeWV5n/m9aj0woyaLJiLZA9B7i9LDho3TBTW1IEnqkBnLf91CD
	jHZDB9fD+cN4FyMuCDhw6LhxG4QNgKKQB5oyFe5OTQ/2OS0KemWYTJO4vgv/vNjnMxCKQLnowM4
	RECaXj/odz79N3lrVL3xLclVIiyw78sJC7SS3OXez8LhhYemjBpniSuQOwNUgZ3lmIeYlX3PHCC
	6e4PuTTb7wK6W8i6mLYxW7gqyQ==
X-Received: by 2002:a05:6602:1607:b0:864:9c2b:f842 with SMTP id ca18e2360f4ac-876e13a009dmr22654439f.0.1751581051200;
        Thu, 03 Jul 2025 15:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK1hmIX7xtD4BcGg0tZpgeCzpZcsDTIoTx2ZGihjZIL7CUA+/RzY0cwRoZX1T3Wpx/+Vp+hg==
X-Received: by 2002:a05:6602:1607:b0:864:9c2b:f842 with SMTP id ca18e2360f4ac-876e13a009dmr22652739f.0.1751581050636;
        Thu, 03 Jul 2025 15:17:30 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b599c53csm153978173.24.2025.07.03.15.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 15:17:29 -0700 (PDT)
Date: Thu, 3 Jul 2025 16:17:27 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev, Joerg Roedel
 <joro@8bytes.org>, linux-pci@vger.kernel.org, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, galshalom@nvidia.com, Joerg Roedel
 <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 maorg@nvidia.com, patches@lists.linux.dev, tdave@nvidia.com, Tony Zhu
 <tony.zhu@intel.com>
Subject: Re: [PATCH 02/11] PCI: Add pci_bus_isolation()
Message-ID: <20250703161727.09316904.alex.williamson@redhat.com>
In-Reply-To: <20250703153030.GA1322329@nvidia.com>
References: <0-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
	<2-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
	<20250701132859.2a6661a7.alex.williamson@redhat.com>
	<20250703153030.GA1322329@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _fS9a6ezkiYCjHuFvMqaqYVKmPcY9YWsbgtM4RoZcF8_1751581051
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 12:30:30 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Jul 01, 2025 at 01:28:59PM -0600, Alex Williamson wrote:
> > > +enum pci_bus_isolation pci_bus_isolated(struct pci_bus *bus)
> > > +{
> > > +	struct pci_dev *bridge = bus->self;
> > > +	int type;
> > > +
> > > +	/* Consider virtual busses isolated */
> > > +	if (!bridge)
> > > +		return PCIE_ISOLATED;
> > > +	if (pci_is_root_bus(bus))
> > > +		return PCIE_ISOLATED;  
> > 
> > How do we know the root bus isn't conventional?  
> 
> If I read this right this is dead code..
> 
> /*
>  * Returns true if the PCI bus is root (behind host-PCI bridge),
>  * false otherwise
>  *
>  * Some code assumes that "bus->self == NULL" means that bus is a root bus.
>  * This is incorrect because "virtual" buses added for SR-IOV (via
>  * virtfn_add_bus()) have "bus->self == NULL" but are not root buses.
>  */
> static inline bool pci_is_root_bus(struct pci_bus *pbus)
> {
> 	return !(pbus->parent);
> 
> Looking at the call chain of pci_alloc_bus():
>  pci_alloc_child_bus() - Parent bus may not be NULL
>  pci_add_new_bus() - All callers pass !NULL bus
>  pci_register_host_bridge() - Sets self and parent to NULL
> 
> Thus if pci_is_root() == true implies bus->self == NULL so we can't
> get here.

Yep, seems correct.

> So I will change it to be like:
> 
> 	/*
> 	 * This bus was created by pci_register_host_bridge(). There is nothing
> 	 * upstream of this, assume it contains the TA and that the root complex
> 	 * does not allow P2P without going through the IOMMU.
> 	 */
> 	if (pci_is_root_bus(bus))
> 		return PCIE_ISOLATED;

Ok, but did we sidestep the question of whether the root bus can be
conventional?

> 
> 	/*
> 	 * Sometimes SRIOV VFs can have a "virtual" bus if the SRIOV RID's
> 	 * extend past the bus numbers of the parent. The spec says that SRIOV
> 	 * VFs and PFs should act the same as functions in a MFD. MFD isolation
> 	 * is handled outside this function.
> 	 */
> 	if (!bridge)
> 		return PCIE_ISOLATED;
> 
> And now it seems we never took care with SRIOV, along with the PF
> every SRIOV VF needs to have its ACS checked as though it was a MFD..

There's actually evidence that we did take care to make sure VFs never
flag themselves as multifunction in order to avoid the multifunction
ACS tests.  I think we'd see lots of devices suddenly unusable for one
of their intended use cases if we grouped VFs that don't expose an ACS
capability.  Also VFs from multiple PFs exist on the same virtual bus,
so I imagine if the PF supports ACS but the VF doesn't, you'd end up
with multiple isolation domains on the same bus.  Thus, we've so far
take the approach that "surely the hw vendor intended these to be used
independently", and only considered the isolation upstream from the VFs.
Thanks,

Alex

