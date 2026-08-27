Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A0A305674
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853803; cv=none; b=irCCNvBl8JDyq6Y/ZNNAh6SuyY7TnO4Rp5LTVjkbNSALvuZ7M2+HfFjcySHd7P/zg4u7BpJK1F9R92g/0QffiwieM/m5zuvCbmkvfZFb5gXJhKA40+IDQbiXDfXOinN4o1LKk2zXJFskA6hAE6B8Eppkq4OyP5qPGyGbVtVH4MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853803; c=relaxed/simple;
	bh=aVJvper34EDrUAZdd4lOfHj1wCc4uQDuLNlXgq1p1YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCftx8qJqz5ROBUzXLq9OmauA/jRYEYTSevvjxqS4PZDpgKGtgRG+HGa0I5RtA8rXsJ+YGYXd87R5T7GYX3aLlEEtZpXhaLaBVHYi5J0dQkiyIlgqQrT1TveFwkC69rppbK+sC+1PVZ2Qx2Q50kOAkDpjd4Bttt/HxsxIMi0+Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MpfKfD3y; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpfKfD3y"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d3b445a84fso14505ad.1
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 11:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787853801; x=1788458601; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KoGSjfHeCXk5ZMZawIjFrD2nA/EHJWwuQY/vd3YWCZ4=;
        b=MpfKfD3yUqQLshgUUu1NpxIjlDgjAglrakaCAAoWhaGQLiHb46SbQp3vD5oH5AbAwI
         dJ1nNbQEsvf9//gtCY8vDjnnVi8Kuc7/weIIDAAy9+WTR24pfjjkTc6F6hWgAeAb6Spb
         615Lo0K0l6bFLYzOS9C1kZOe0fj3ZXv1+0Tgo+2TisADY6qeiSo6IyqvvO9TJwOKgHbU
         NX0aiOfFaW9cx6y0NC5wyB73LbKuHUerg2WKU13lokgBfb0TKrGVtG0D4h7PViYNn+hW
         TDf9yr8EqHzbqCDIXnpISJ3X31y+YO+adZwzpG9VPCmTYPd//bhAoLTSfcJjiT5JAcJp
         93sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853801; x=1788458601;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KoGSjfHeCXk5ZMZawIjFrD2nA/EHJWwuQY/vd3YWCZ4=;
        b=XQLiQ4o36kieQdtuutEzXmabpvPRxvuSpT/kuINKNikYkokaG5gLOoC5XzsbYiYwf0
         FCHoGxHKOSF9NRSjrel23QkARyYSIpmFabSk6oU7NEuItDKYRkiaukJ26QVy5jGcx8vL
         trWglIMJHIdXKOWAbCxkhICbpNz15tqX+CdbFaq4PZdArWxCmKBDJvZqLSvzr4BGYX1f
         o/vNQ8y1NL/IoPc5S5poZ4CagJi+bh+76koNGL4VYjwlWOtNlnlcf22ezIlGj9Le+jx8
         hnw6eeF9nBGlAD0vywycb6QYESjpN+i6Vm+QPZirnvbHijqKP5y5A11V6vqQY8vFDiNh
         8SEg==
X-Forwarded-Encrypted: i=1; AHgh+RqEoM0T4Hary/SHrD+qHJH/UJEb/86LKBCE9XQrSyXpaUxrIOqOx7CGlKcaEXQCzyuxIVU2xQ==@lists.linux.dev
X-Gm-Message-State: AFuF++n1i4Pn6YJhRwxIoEgIp9R/rBDUsLlFn12SWyKz1uUD7cTfdWmx
	B254GMuu/jBlw1YRlcJlderMmQhPzdh9JknAl1TUoBxfOj+kKI6bsBM8l5T35zZ7SA==
X-Gm-Gg: AR+sD12Z8OHjI3cQ+sbquXUciUzgbNprpgGbhOC22d9vSo8FvohAuCbVItdCcTOLDlM
	Tex2y6sZuHahR7s/wMnkOL3kR9lS4wjisgSbiFcl5KVdadkFfW2+9CFsh5CqQfHm6G9k22+A25o
	ITRh/Mm9lvXdBwrQkalWQkkinfsQlume4LOVGhIJPtMgz0yRBKiT1fcAJD3yUQs6xnG4/VFc9cP
	9R/c2iYUui6R16Cd0LoP4ML5gGn3Y6NeG9cBUurgpGhdPSLxlI86nYSOXmJ09uW5y8m0a2WfQ1b
	RTWRzHyscYlG7h7S9qVYe1wpzGl+LQh0AOZsETwruGwSiUJ8Q0saIh2Iksg4b+FsLPsQIqA4umK
	uqQWfI+8X5y/tvDd8MkLIkyj9/zDUEHgYdL0va9NJSHDuAc8mie6/QcuutVoiF+CotObe0SowdT
	nGnN9sScu1qaz3szUn9WkQxENU8c5yXVraDYE6UbUWQaZIdpNH6z+D3HNrYxF/OXwjSmXbThmg4
	aQVlmi3ceVdH0Kp+CSC8itIRXDLTTu4xvc2xHoexIngzg/5Jun4v45iX/8=
X-Received: by 2002:a17:903:8c5:b0:2d5:db3d:1a44 with SMTP id d9443c01a7336-2d74f6efb5bmr432895ad.17.1787853800262;
        Thu, 27 Aug 2026 11:03:20 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39675867f73sm3108022a91.4.2026.08.27.11.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:03:19 -0700 (PDT)
Date: Thu, 27 Aug 2026 18:03:15 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Alex Williamson <alex@shazbot.org>, 
	Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>, jrhilke@google.com, 
	tatashin@google.com, Will Deacon <will@kernel.org>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] vfio: circular locking dependency in
 pci_dev_reset_iommu_prepare()
Message-ID: <apB6tsN6cHz9Iuv3@google.com>
References: <20260821193502.92431-1-vipinsh@google.com>
 <ao3nr1-t0DxANAyC@google.com>
 <CALzav=f5wUUt4mKZn0tvQez6_1iYPcb8eX5q-XjabTNy03JiNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=f5wUUt4mKZn0tvQez6_1iYPcb8eX5q-XjabTNy03JiNg@mail.gmail.com>

On Wed, Aug 26, 2026 at 01:27:20PM -0700, David Matlack wrote:
>On Tue, Aug 25, 2026 at 12:06 PM David Matlack <dmatlack@google.com> wrote:
>>
>> On 2026-08-21 12:35 PM, Vipin Sharma wrote:
>>
>> > ================================================================================
>> > Potential Solutions Suggested by AI
>> > ================================================================================
>> >
>> > 1. Decouple iommu_setup_dma_ops() from group->mutex in drivers/iommu/iommu.c:
>> >    iommu_setup_dma_ops() only requires struct device * and the domain pointer
>> >    (group->default_domain); it does not mutate any fields in struct iommu_group.
>> >    Moving the iommu_setup_dma_ops() calls after mutex_unlock(&group->mutex) in
>> >    iommu_probe_device(), bus_iommu_probe(), and iommu_group_store_type() breaks
>> >    the initial &group->mutex -> cpu_hotplug_lock dependency.

The group->mutex is needed here also since it sets up the dma_ops on the
default_domain that is currently attached to the device. And those
attachments are protected with group->mutex.
>>
>> Are there any other code paths that rely on group->mutex -->
>> mm->mmap_lock ordering? If so fixing this one case wouldn't help.
>>
>> > 2. Avoid holding down_write(&vdev->memory_lock) across pci_try_reset_function()
>> >    in VFIO:
>> >    vfio-pci could zap active BAR mappings under memory_lock and set a state
>> >    flag / disable memory decoding, drop memory_lock before calling
>> >    pci_try_reset_function(), and then re-acquire memory_lock to re-enable
>> >    memory. While resetting, any concurrent user fault will see the memory
>> >    disabled condition and return VM_FAULT_SIGBUS safely.
>>
>> This would change the userspace-visible behavior of faulting on a VFIO
>> device BAR from "block until reset is done and the succeed" to "fail
>> with SIGBUS". And it would allow VFIO to access VFIO device BARs during
>> the reset through vfio_pci_core_iowrite*().
>>
>> But I think we can extend this idea to solve those problems by
>> introducing a wait queue for tasks to sit on while a device is being
>> reset.
>>
>> e.g. Something like this (completely untested and partially written by AI):
>>
>> From: David Matlack <dmatlack@google.com>
>> Date: Tue, 25 Aug 2026 18:37:52 +0000
>> Subject: [PATCH] vfio/pci: Avoid circular locking dependency during device reset
>>
>> Avoid a circular locking dependency during VFIO device reset by dropping
>> vdev->memory_lock prior to calling PCI reset functions
>> (pci_try_reset_function() and pci_reset_bus()). Introduce an explicit reset
>> state flag (vdev->resetting) and wait queue (vdev->reset_done_wq) to stall
>> concurrent BAR page faults and MMIO accesses during reset without holding
>> vdev->memory_lock across PCI reset operations.
>...
>
>This approach does not look ideal. The implementation has a bug where
>concurrent resets can lead to vdev->resetting being cleared too early.
>And from a maintainability perspective, there are more call sites that
>currently take memory_lock that would probably also have to be updated
>to wait for vdev->resetting to become false.
>
>> >
>> > 3. Refine synchronization in pci_dev_reset_iommu_prepare():
>> >    Evaluate if attaching to the blocking domain and pausing ATS during device
>> >    reset can be protected using more fine-grained locking or atomic state
>> >    flags without holding the coarse &group->mutex.

This might not work as reset_iommu_prepare() changes the domain of the
device being reset and those things protected by the group->mutex.
>>
>> I don't know enough about this part of the kernel to say, but this would
>> directly address the new lock ordering dependency vdev->memory_lock -->
>> group->mutex introduced by commit f5b16b802174 ("PCI: Suspend iommu function
>> prior to resetting a device"), which is what led to this lockdep error.

Thanks,
Sami
