Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02616EB54
	for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742002173; cv=none; b=FU1GhyIQ40/Ojxwd3R3yV0koqDKcYkG9P3bujEGPxnsNyZiLZYv+nsV47p4/THVAV5EAnzYy+J9ZM4f2sgAq04JWIDvlIUeBxOZieW17u59WLkRFi7iOxlG6Ei9plX+biGCK8gEwTKcHFDRPGVJcizfR1HemRYN2GQY1NA/c8EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742002173; c=relaxed/simple;
	bh=bL3E6ZKdsE327UUQdlOSCxHKLR6a7H2JRLqB/6goHos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iK+m1F/7RUycfhO93GTEZJbZRe/0+002GkZlSLjUFTjc3R7SRHSa+OIcUiX80RyP5DKZHPEgOG/Ccgz1J1yMaimMelcavY+CL3/37H1V8o+zSFQ+ZEv5cVKwCpToQyzRqR2qIBmZnhJpVEEa3zFoQriBzHJuXDZ9idg1EjQlO60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PPE1MBmE; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PPE1MBmE"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-549b116321aso3046303e87.3
        for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 18:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742002170; x=1742606970; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6w0disyuUDvtQQ+N3XWfjRUpHu9jC93VlrnWH3RRULk=;
        b=PPE1MBmE44x1dmof1iASx+etIMkxcnpj1YXyXjoXVASH8IQM+Astj9Y31Y+GnYjB7K
         wOMJlQbtPBzmElNIjOM0rLnGcfmt8t73tcdCBjiYT0vEbsbEUMyqxmRbvyKMbib4j4av
         LSrXPkyvfcqXohtOtVNyP2Qe/xc4FlN9EeywfEbwLzJfd1da+JUcjMPsODuESs4fEcv+
         68RRTiKguqC0gUokRWC3TfIu4qsYWw2SzA4BQQ+lyqrjjUhWsXw8skIWFUulfDGfi7M8
         18NwkdQYLXTnbahwMUprVP6GBzihGBCyQ7XKI0ZlwMKvrKhcpyXrK4W2DLtLK/gzAGqp
         PBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742002170; x=1742606970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6w0disyuUDvtQQ+N3XWfjRUpHu9jC93VlrnWH3RRULk=;
        b=QFCXqQkvhVOcxOcbkmzdBEWoGkSFQMQXn6yy2ivZoFZ0l7+H4DgpNAbu2ppPfDYrpR
         0XCOc2XjZRneMdHmfumv/Ftlu+PciSnjBe1RHtUiep6Vh1sm1dcawLMGdnuPhJYnE/1O
         LuI4jqhakb0FlJihILf1pl9KtH3sBZiyodZmt9BbwVRL9C+vQYH6XqQBzZPkwNLwiqKG
         TxJ3bEDM7nfWozqV2jP9Kx5BIqTvGrE+sm5YEEWgMx+ETXly1Ah0Lr4QZnZ8HCOL9qvo
         XP7A7pKNhl7k28l9uYV1IvI+1VhKfSvKxtPsAaEVyaLFj9wkr8H+oWzhJ6RaQozO9IGQ
         dNmA==
X-Forwarded-Encrypted: i=1; AJvYcCUZdh+tLgXXzgn0TrnTwhui5LHAV8VnKB5CrsrYYV/jdYiZDuQZYN5TpQeNa2PmRZ9mtZtg3g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7vm7fSD7rit1IzbCdGcDRQudeAjBjwKplcBNzf0krDCnRJTIZ
	ZIYXlTAF36oAp69OcFoo06tq2abdUw+i+EdCH680axqkXiB2gtpEdpa2/C/dD6j9CK9T6l8E6oB
	yh1P3BqmtxmS20xnVBJA+jwv3Qf44bnRtfahXkg==
X-Gm-Gg: ASbGncv4/MiGuwuaYsMdcanQNWqjN8lXvB5EKAAkWqwzW0Z6lVKM/iLCmtAevnwIMtM
	Xp3FyN05qIzAYet8D3/hdOiiMH3awPIR24gZFMbskTMqvVbLcA8pfIOGdQWt8nynHg5SfPsIrUA
	dQB187ZmlRTht0TxcbvOiCSaDq
X-Google-Smtp-Source: AGHT+IEcrCNfkXntuX0aeO1m76LAx6oQqfZga4okctB2AQ1NJbZPVtoeE1K8MorP61BHMqFs6rP9wk4g9/bvh9zwZ0k=
X-Received: by 2002:a05:6512:31c3:b0:549:8f06:8225 with SMTP id
 2adb3069b0e04-549c39507ebmr1467555e87.53.1742002169612; Fri, 14 Mar 2025
 18:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250314071058.6713-1-zhangfei.gao@linaro.org> <20250314162838.GA781747@bhelgaas>
In-Reply-To: <20250314162838.GA781747@bhelgaas>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 15 Mar 2025 09:29:18 +0800
X-Gm-Features: AQ5f1Jq548u8pPFXs_fox2r7erQleFFr1iIjN49eNipnJu4ChBbFpiLc4BGDKXE
Message-ID: <CABQgh9H_vGTPfB_dY+fT9gsWw5K53o0MBXf25LamaxBfVc2-Qw@mail.gmail.com>
Subject: Re: [PATCH] PCI: declare quirk_huawei_pcie_sva as FIXUP_HEADER
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Mar 2025 at 00:28, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Mar 14, 2025 at 07:10:58AM +0000, Zhangfei Gao wrote:
> > "bcb81ac6ae3c iommu: Get DT/ACPI parsing into the proper probe path"
> > changes arm_smmu_probe_device sequence.
>
> Normal commit reference style is:
>
>   bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
>
> bcb81ac6ae3c is not a valid upstream commit.  It does appear in
> next-20250314, incorporated via f5a5f66e2791 ("Merge branches
> 'apple/dart', 'arm/smmu/updates', 'arm/smmu/bindings', 's390', 'core',
> 'intel/vt-d' and 'amd/amd-vi' into next") from
> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git.
>
> I think there's some value in keeping fixes close to whatever needs to
> be fixed, so since bcb81ac6ae3c came via the iommu tree, I would tend
> to merge the fix the same way.

OK, understand.
Then would you mind give an ack.

>
> Unless there's a rebase to merge this change before bcb81ac6ae3c, this
> probably needs a "Fixes:" tag so people who backport bcb81ac6ae3c have
> a hint that this quirk change should be backported along with it.
>
> > From
> > pci_bus_add_device(virtfn)
> > -> pci_fixup_device(pci_fixup_final, dev)
> > -> arm_smmu_probe_device
> >
> > To
> > pci_device_add(virtfn, virtfn->bus)
> > -> pci_fixup_device(pci_fixup_header, dev)
> > -> arm_smmu_probe_device
>
> This doesn't include enough detail to show the change.  I don't know
> the path to arm_smmu_probe_device() and how it relates to
> pci_bus_add_device() and pci_device_add().
>

Thanks Bjorn

How about changing to this.

Subject: [PATCH] PCI: declare quirk_huawei_pcie_sva as FIXUP_HEADER

The arm_smmu_probe_device is now called earlier via pci_device_add,
which calls pci_fixup_device(pci_fixup_header, dev),
while originally it is called from pci_bus_add_device,
which calls pci_fixup_device(pci_fixup_final, dev).

So declare the fixup as pci_fixup_header to take effect
before arm_smmu_probe_device.

Calling stack
Before:
[ 1121.314405]  arm_smmu_probe_device+0x48/0x450
[ 1121.314410]  __iommu_probe_device+0xc4/0x3c8
[ 1121.314412]  iommu_probe_device+0x40/0x90
[ 1121.314414]  acpi_dma_configure_id+0xb4/0x100
[ 1121.314417]  pci_dma_configure+0xf8/0x108
[ 1121.314421]  really_probe+0x78/0x278
[ 1121.314425]  __driver_probe_device+0x80/0x140
[ 1121.314427]  driver_probe_device+0x48/0x130
[ 1121.314430]  __device_attach_driver+0xc0/0x108
[ 1121.314432]  bus_for_each_drv+0x8c/0xf8
[ 1121.314435]  __device_attach+0x104/0x1a0
[ 1121.314437]  device_attach+0x1c/0x30
[ 1121.314440]  pci_bus_add_device+0xb8/0x1f0
[ 1121.314442]  pci_iov_add_virtfn+0x2ac/0x300

Now:
[  215.072859]  arm_smmu_probe_device+0x48/0x450
[  215.072871]  __iommu_probe_device+0xc0/0x468
[  215.072875]  iommu_probe_device+0x40/0x90
[  215.072877]  iommu_bus_notifier+0x38/0x68
[  215.072879]  notifier_call_chain+0x80/0x148
[  215.072886]  blocking_notifier_call_chain+0x50/0x80
[  215.072889]  bus_notify+0x44/0x68
[  215.072896]  device_add+0x580/0x768
[  215.072898]  pci_device_add+0x1e8/0x568
[  215.072906]  pci_iov_add_virtfn+0x198/0x300

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Thanks
