Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5A03F20F0
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509356; cv=none; b=M4Xy2XhjZxVQZh7NtfSK8grKWZleFWD0Ch1iviYdpoWmPoEUEe9be2C2O0ebRlIBhGTB/YGMP4sFIyO/n61WpGYA9K5kkwTJFiU5JUzwfJcq4lSEfAQTWGGjVmvjHnb0YV3hZr2XI+bd2cqFyf8lFCUyMO11SARqvwQHdh2T2Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509356; c=relaxed/simple;
	bh=qJaZDUv8tWzR82l/Nglli0CCITCzVGn6lJPSfUdXdOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKUFCFQ/7Aj3uRkYIMEtF2UrhGCFFhflot5MfYIjPgoFq30YYHzzl4PYOjLUbrOVZ4AbKEAPKbiHVkCE5v6W5AA9FPgGmM/fB5cinIxslXwj24xbGovCRwL806rloIK+RAiEHwsu8syI4cQUVOK7ZD+2o5m/NYryyiJWfUyTgvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=altI4kOA; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="altI4kOA"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so69835916d6.2
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778509354; x=1779114154; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lRu8PBFexJkXAK4pr5czUbNe2ffmqFkTspqpEqHZ1YI=;
        b=altI4kOACRIeYYXcLF5hYE5CoALt+DXkHp1s2gX8AEw4Ks1UZ//U7U8QPk1uCLR4nw
         i5AdlKcQZ9ZytAJBKEa4CzSfr2IPqtjsdWL8AKZnadHbhNbdZajwvXhpTaiH2AuScG0a
         6KKscMTVILZ3avptJw8tKiATfvB05J6VM7rXvBrpJthm3IO96eP5gHy9PMHejt9sA764
         jYv2VxoW5WCIKehTbTHLHPQLawq1msNLEVU1cgh2DYHQlSwqyEEaqYy6/IoUFCcFDED+
         glerDlaLxRtHl5BgCxcfVQ4Rq12ZqD6bvV1F5Cnuh0cZTpwSk1OGYu/N0wFevjBVT/1N
         7xiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778509354; x=1779114154;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRu8PBFexJkXAK4pr5czUbNe2ffmqFkTspqpEqHZ1YI=;
        b=gz3SQ5GF+WW1KdHZ/KzNJqm3bfxuUyPAZPG7vbNnzPuxmiri1gE3fs/ctF8yxmmIxq
         hM7SJGUhFsdtYNxpkCejRzop6uWsSvq+PJHMT0pvCb+qorS+lvqrfFej5fEDPxJ5pcRr
         s5CPP5WGHAp8bBZ3Ia8lyxXw+SRcnw+XkFJOcb+GkgzZ2b4vd0C6poy46BSTACqhQf4g
         hgYBsmvCi8dB6usnrFGd7MQBOfADysWxzCFn81hE9MfG+ORlddjfqskkQ14IH9IemXjU
         3q+7vnWPcov1LHa1aPHEIkzrOjaHtFS+SuLpRKNxY20VAG5Gog3E0PejX6PRPOgw7E16
         sFLw==
X-Forwarded-Encrypted: i=1; AFNElJ+gix+p+fiOHnI/89IpbtTnoer22XfPDDzGm47+SY8ZU4y20154FNamUBwhuLSWLsNysRvRxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxElwIDGNUljmwaLdnvIbs7gZuB44P6CHSyzRMY3byDh/MK8jkz
	qi4gaI3J6DyPWowUKu8Bri9MlO3750de2/CK246ZglKwO6+0kFFnuaxp6u+K5kZOaa4=
X-Gm-Gg: Acq92OE9GBuQfxia5mseECHwhIPOeXVgywD7c+rhbHQT47LF3yXthkbRrGTVw7AJpzW
	0vnBLqKad38V9KREz5MRfiktXpGZ5YW/J/fiA4qynxVI5SUyg+wxXmlm3UUzNNEc+roWoYoj0RA
	ZexmB0bTR+H/mXYQ5n5QuKmspxiR/iAJVKmd6wyJ0xs9uT0yWnFxtjllq8jIlSC5VEStbN+txZC
	2MZwRcULOrEfV1xxZLP/D2MzKAxKePrEVb1jj4KrQ8Be6gjgWOatTftst967iuplZFoR/WS+Zkm
	1Sa8KvN3KRPq7TG32FmqelkegJvp+++GL8TIUw0hFDpkpva+EYxERZHQDIuwY7KXFEQ9OrNll54
	JGNWyfUrzUH+kdJ2kMaaGeLpXkp0N6hOygTeoi18M9i8RvkYeDXE9nwmIWk9VQGaVkIy7G1WBQO
	v1lAzYkV2WFlv16ScJ9U8S+dPJzWWg2yNL/piNvo7DqP2+z7Q6/RB/SeSYzMjUx15rnfz/A3C31
	7s13GJInrH90HTK
X-Received: by 2002:a05:6214:130b:b0:89c:8a0f:55a0 with SMTP id 6a1803df08f44-8bc42f55059mr354930086d6.16.1778509353844;
        Mon, 11 May 2026 07:22:33 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d83114fsm308645866d6.48.2026.05.11.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:22:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMRWi-00000004oEW-37xE;
	Mon, 11 May 2026 11:22:32 -0300
Date: Mon, 11 May 2026 11:22:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 08/25] KVM: arm64: iommu: Shadow host stage-2 page
 table
Message-ID: <20260511142232.GP9285@ziepe.ca>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-9-smostafa@google.com>
 <20260501130006.GF6912@ziepe.ca>
 <afiRB3e3o0G1oZvY@google.com>
 <20260509232714.GI9285@ziepe.ca>
 <agG8XtrHUfWGy-kd@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agG8XtrHUfWGy-kd@google.com>

On Mon, May 11, 2026 at 11:24:14AM +0000, Mostafa Saleh wrote:
> On Sat, May 09, 2026 at 08:27:14PM -0300, Jason Gunthorpe wrote:
> > On Mon, May 04, 2026 at 12:28:55PM +0000, Mostafa Saleh wrote:
> > > So far this is the list of requirements/changes needed share the
> > > stage-2 page table (besides the obvious: same page table format,
> > > granularity, endianness...)
> > > 
> > > 1) HW BBM is not supported in the hypervisor page table, that’s
> > >    because it can generate TLB conflict aborts, which the hypervisor
> > >    can not handle because of the limited syndrome information.
> > >    We can rely on FEAT_BBML3 which was newly introduced to work
> > >    around that, it’s quite niche and not supported in KVM yet or
> > >    have an allow list similar to the kernel
> > >    (as in cpu_supports_bbml2_noabort()) which also limits the number
> > >    of CPUs that can run this.
> > 
> > Do you think pkvm will need BBM? Hitless replace of a PTE is already a
> > pretty advanced feature and the SMMU has its own support matrix there
> > too. Is it for shared/private conversion?
> 
> Yes, we can break block on memory donation which is transfer of
> ownership to the hypervisor or a guest.

So you need BBM support on the SMMU too? That is probably a big
problem because the SMMU is often mismatched to the CPU :\

Also io-pgtable arm cannot trigger BBM behaviors, so how do you
implement it?

> > No.. once you turn on IO like this you don't have page faults
> > anymore. Everything must be permantently mapped into the SMMU view, it
> > can never be made non-present and you must run without page
> > faults. That's what you have in the io-pgtable constructed table,
> > right?
> 
> Exactly, but the CPU page table doesn’t guarantee that, so we either
> have to handle page faults in the IOMMU, or completely change how KVM
> deals with stage-2 if we want to share the page table with the CPU.

So that's the real explanation, KVM cannot manage the S2 in the right
way so you can't share it. RMM/etc are managing the S2 without
pointless page faults so they can share it.

> > >    Alternatively, we can pin the stage-2 pages, that would require some
> > >    hypercalls, hacks to the driver/IOMMU API and possibly new semantics
> > >    in the DMA-API for IDENTITY devices as they will still need to pin
> > >    the pages as they are actually in stage-2 translation and not bypass.
> > 
> > ?? Then how does this series work?
> 
> This series works fine as it shadows the page table and doesn't share it
> with the CPU, so it fully populates the address space.

Which is why it is so weird that KVM is using a partially populated S2
when there is, and must, be a fully populated one for the SMMU. But I
understand there are reasons fo rthis.

Jason
