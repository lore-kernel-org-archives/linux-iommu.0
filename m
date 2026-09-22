Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7EE376A0A
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041656; cv=none; b=EF2hbJY3Jn0COHamIAIXmFGIsBfUhTkGFy9ha5+799s9NQq6qqjf2QjCSrm/t7TeeI6sEUHNlco0tKma25MeC9p2IlvS5AUGW9z19PpIx9KVH7aquJFDmqTlIMcbKUin769R02tn1UoR2OPDb6N2yMR2ooCzIjYkDDGDypMi9Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041656; c=relaxed/simple;
	bh=JRet0lN6fAyPGKcEZAkelJe6hquf64NfYxR4H5/x8y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG1Wj6wepPADTvuvYgESZMQDDagYpI/hzEGyeG2TSgJj9JJVdH4aBc3zEv/CftXTLD9DM7SWCTB4nZGl5ECLECMb2bSazF2XN3fwjZOyAOxumeYYioRKr/ZL+osuehBc3Y6X6Va3NthO+0wumyL3wwhcrN8fcEYrOS3NdPtF2NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ou1R6FtR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ou1R6FtR"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2db33db4de9so43685ad.0
        for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 18:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790041654; x=1790646454; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i6+2inLQAeVlBcJ3LlCplkJMtCvXJB/NM/8WbN3/bwA=;
        b=Ou1R6FtRB4hDSc6xK/hp0ton+7qrU1RMPsvG4XQ9Hm/ldbCXwV2TrtZBsTJ6xQHeeY
         5w3jm1b1a4f2WE7PP/T96Ox5abyDYDPw6s3M70951+oDNtL0hZxtWhfoF3P6ABjnFOdp
         qqhc83YjommeJvGq4eTYU6wDRTwQQBFAyDtn4Wyn5FRX1jizi+AcjfufNjIA+f1MISxr
         ls7ep7btTdzLLYWHrxYJEnjlA5JLDtNKqSnE7F/8M6occqqCVsK4zib/MYXQc1uPw56A
         U/QYoHuawo/eMx0P+G3uVBpSPgdIXiWuUHE1Xmn0VPhk0dLqMzMyEszVzWal8yEG7LKJ
         s5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790041654; x=1790646454;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i6+2inLQAeVlBcJ3LlCplkJMtCvXJB/NM/8WbN3/bwA=;
        b=aDhFzkBIWq9ARxIr7nBrMWRkjwsrT8wBTsQszOWJio+zsDBmGL4LAvG+eRc9aSKSbw
         zAVJhBfhJna/0rsLukOwJB4KTYYdsuosIPP3ujn/9FFrMRyC0z83ST2z2BLFmqYO39eX
         ze9FhO61xpNmNdeMJn3co6lEl0GPvZplEATRKDGNr0140KXQipHcKtGBNn2E3GVK9GLN
         T2gF3jAB5sFSc7KV7QIe02w1qEr3oXN8u2OtQGJET2uAXD7arsOmaChYxFvqmI+d/GIi
         5yyfH14C3IbC/Hoxs6WviIKzVRrk9Ux4a5zNWfrA1QmYdHfEa7UlEu5n6pelJ9xCggP/
         28Lw==
X-Forwarded-Encrypted: i=1; AKwUvBwmLMpt/NOIPeTskZgFAKJPlwqNgn+VIFHp8+d+IHZOJNgMEEaM3W16u4MPV8oyTPwQGxSxCw==@lists.linux.dev
X-Gm-Message-State: AFuF++kP47gIE8l1ssJKWafs3K6hi8jLkDi3dnNb5LQFyO/ijyxQIvnL
	C7Z5zQ1x7o0Gjkyd0KusPAV+iEYsDjJJLeHcna4G+B5qJI0LDYUxwCdgeT6UVaAawQ==
X-Gm-Gg: AYBFou03aI44GPqnDpSEVu3WQlMAEsl1UPnsb9f7tMC/e5xaSfrsOYYs2QWkilhYEGn
	B9tkOCFbAgfxzd5nsxI0wD8f9wmufbhRCqZqU0MmyaRyQRl1BZGyvJdDz8Hkwp5fRBzMf3+5+bo
	TyS5ZXtyqhFErNcIJxIanxVo56phTQ/fK+8c6ShS8XQ+uAq8SYpnFr0qzFE3qgvidH89IfQ2Vr8
	m6KVBSPk4k17pkTdhdmICcfP2hZGY/PrptlsoFHPc0giTE+UxMoTtm9zA3RXW5h7Eatib43vPH+
	2D4DdmSEK9I4YRPU7W5iT5TlUYLT4/eL1z6IaNJQvOBi62S+Z9eaT1pIejrgPIU1XyWo5w9hUry
	IaBmtOylfZuvxUB8t1JQqcAe2utTRJEfqHR92DO8vIVBBaQ5rE9Y/FpKKErysNszQqbVmqdL0Z6
	+Ylvye1drcYd2hWi3YnmKHnSl8P1B7t8/cbXn9XMKccg+9RUe/p/2PURQsAfIbCjUbMX2ojsJFI
	et32ofs8GMJCqpI5hx05EZosa0dSOkit/383UUVA0uvNHTZKLpsr2HBynCcAAnbFQuGYhUjLlKi
	TjEx
X-Received: by 2002:a17:903:2f4d:b0:2c7:f688:f22f with SMTP id d9443c01a7336-2df5b835b4amr3114135ad.13.1790041653508;
        Mon, 21 Sep 2026 18:47:33 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e5751f2sm342687a91.9.2026.09.21.18.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:47:32 -0700 (PDT)
Date: Tue, 22 Sep 2026 01:47:28 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Alex Williamson <alex.williamson@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, kvm <kvm@vger.kernel.org>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <arHP3Sj19YX-J-vx@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
 <an5JbIzz40svS3xe@google.com>
 <20260814083737.66bb83fb@nvidia.com>
 <20260817121810.GC933791@ziepe.ca>
 <CO1PR11MB48354AC2854C4D8E9984FD8E8CA62@CO1PR11MB4835.namprd11.prod.outlook.com>
 <20260818140304.GC5482@ziepe.ca>
 <20260818143906.1f58aecb@nvidia.com>
 <CO1PR11MB4835146C50242D76568724DE8CAD2@CO1PR11MB4835.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CO1PR11MB4835146C50242D76568724DE8CAD2@CO1PR11MB4835.namprd11.prod.outlook.com>

On Thu, Aug 27, 2026 at 05:35:17AM +0000, Tian, Kevin wrote:
>> From: Alex Williamson <alex.williamson@nvidia.com>
>> Sent: Wednesday, August 19, 2026 4:39 AM
>>
>> On Tue, 18 Aug 2026 11:03:04 -0300
>> Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> > On Tue, Aug 18, 2026 at 07:07:20AM +0000, Tian, Kevin wrote:
>> > > 3) resetting a PF due to ad-hoc FW error
>> > >
>> > > e.g. pdsc_check_pci_health() calls pci_reset_function() when FW
>> > > reports broken PCI. Sounds a similar condition to AER.
>> > >
>> > > but as it calls pci_reset_function() this series causes a regression
>> > > in case of active VFs. Is it desired?
>> >
>> > mlx5 does something similar. RAS flows require detecting the PF has
>> > blown up and resetting it to bring it back.
>> >
>> > This has to work while VFs exist and bound to kernel drivers or vfio.
>> >
>> > In the VFIO KVM case I would expect the VM to experiance a RAS error
>> > on its vPCI device and trigger a VF flr
>>
>> This would need to be a device level RAS flow as we're sorely lacking
>> on forwarding reset notification to VF drivers or providing any
>> mechanism for recovery from the vfio error eventfd.
>>
>> > But we have to sort all this out through the hypervisor to not crash
>> > the machine or otherwise :)
>>
>> In general guarding the high level pci_reset_function() family on
>> (pci_num_vfs() == 0) seems to have more pros than cons and the
>> restriction matches the scoped intent of the interface.
>>
>> The low level __pci_reset_function_locked() interface remains
>> untouched, and as the prefix implies, relies on the caller to do
>> necessary verification and preparation.  A "reset the PF regardless of
>> VFs" seems like an underscore prefix sort of operation.  We'll need to
>> export the pci_dev_save_and_disable() and pci_dev_restore() functions
>> to provide handlers the full suite of tools they need to replace the
>> existing function and port those we find (maybe also questioning the
>> author's intent on VF reset and recovery).
>>
>> Of course making the guard parameterized with wrappers to expand this
>> family of calls is also an option,
>> pci_reset_function_locked_with_vfs()...
>
>+1 for wrappers. Maybe call it pci_force_reset_function_locked() which
>is slightly forward-looking if in future other conditions may reject the
>reset request using the base function.
>
>>
>> The mlx5 driver doesn't actually seem to be affected by these changes,
>> doing its own link toggle or a PCI bus reset, not a
>> pci_reset_function() call.
>>
>> On the other improvements, triggering a pci_reset_function_locked() on
>> unbind after SR-IOV is disabled, when needs_reset is indicated, looks
>> pretty trivial.
>>
>> The blocking domain operation looks like it might be simplest to
>> implement in the IOMMU core.  We can set a flag for a default blocking
>> domain on the IOMMU group when we take_dma_ownership of the group.
>> Then
>> release_dma_ownership picks the blocking rather than default domain.
>
>IMHO we should change release_dma_ownership() to always picks the
>blocking. No new flag.
>
>this take/release interfaces are invented for drivers which manage dma
>on their own, so it sounds reasonable to not assume the operated device
>is in a good shape after the ownership is released.
>
>Then only a clean reset can unwind it.
>
>>
>> This is then unwound in use_default_domain, called via dma_configure,
>> attaching the device to the default domain in probe of the next driver.
>> Therefore until probe by another driver, a device used by vfio would
>> remain in a blocking domain even while unused and unbound.
>>
>
>so unwinding it blindly at dma_configure time is also problematic, as the
>device may still have a bad state to hurt the kernel.
>
>Instead use_default_domain should fail in such case (in blocked with
>owner_cnt being '0') then a reset is expected to unwind it (Nicolin's
>work will carry the resetting status to pci_dev_reset_iommu_done())

Thinking about this more, it might be tricky in multiple ways,

- This will only work if drivers do reset after dma ownership is
   released. Looking at the code, vfio currently resets the device first
   and then dma ownership is released.
- For some devices with no reset mechanism, vfio-pci uses bus or slot
   resets. This will need extra care to propagate the
   reset_iommu_prepare/reset_iommu_done to subordinate devices to bring
   the device out of blocking domain.
- AFAIU looking at vfio-pci code, some devices do not have proper reset
   mechanism, not even slot/bus, so those devices would be stuck in the
   blocking domain state. Probably need a mechanism to let IOMMU know
   that there is no reset mechanism?

Thanks,
Sami
