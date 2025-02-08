Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4CE246339;
	Sat,  8 Feb 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739030173; cv=none; b=hxRoIK3tgX2AqByAkxA1J/dSgWneSeVYph9b2DmgraMBAielhadRpuE0ZUshOmv0yFVYdnoD5SbAdrmQ4BFIMWf7WGFBusKfIpRfurcO3ik/BjC0Kw5BTnVi5Zj761Bb339rCw/d7ue1dcY5/ReujhFsXvqMwRo9KxCDEWy9z/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739030173; c=relaxed/simple;
	bh=BRk7BBm7oSdWplPPvfzhGPnNM6vM2mjwIOaR+mXLbRw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UEQdgqBm52oufTXuuG9ld3fPkABR8rWtgitts8mH1OUgQ9FWvjRGCsuckVlzyhnHR/Vu3zMkkHrs3Ki23RnP6TUZZFPAUa6kiTAevWKLE1lWU4wBAshF6WXhRZDdkBwgxca+Mz+kITrZoY9d7Hen+D/gpW9rmKi5totQOb670ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmEd8Q1y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmEd8Q1y"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4362f61757fso29341915e9.2;
        Sat, 08 Feb 2025 07:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739030170; x=1739634970; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gghYPUNRCdyG2yLo4ZGDDboCtEVr9fYIBuiGTMEQtB8=;
        b=OmEd8Q1y1Bnvq1BzfjaB+H3/V8cw7LNQ2Q8onDgqLbhtnWJHafSRYhHwJM9Y6nqZPe
         4Faw4l8DmH89By3ryfXGMml8PafSfad5Y/T8qvsU0lj5TxbJFfxULf6E8j72QjAfLbi0
         aiE8G0u3oG3CeEXKtsryRf02yHmHGapHKZiNxJHwOWOayGP4FP8S/Yc9Tsc/qmbT4i9P
         sI26DHpyDiN14qYQda7GNBKb+CJ2ac3Kn/zEckpdfKpf0a1bf/uGxwt5T5Zs0kPuO2T4
         Tt947jV12YSASh1Ny52uGBDSZyLMtKsnRsYFLT42MYtRx0JRyu3aQY0Ah9sQC/4LISo0
         t3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739030170; x=1739634970;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gghYPUNRCdyG2yLo4ZGDDboCtEVr9fYIBuiGTMEQtB8=;
        b=cCFGnTY5Pvy+yVMtBkFQvsjVlel5UlFHu0vcdo9qcIe7qkmLdBP6NQ5HmVQKU80OY9
         m/h2xQp9JfMA1a6j7tSyboefBPVL+kn6dn2xBjs9rRCzQ3QAku49LUEbMUTjzXCovfFG
         URry+q6Nwd2N+aZ6xfY8JhXxh05IStfvQxr+Inyr2PFYg5Vd0lAWLGBfhSgllrxFkpsY
         o3ZCDkRJ6X5oRVHzAuWK5w0Zo7Jj3dh7gdSUNpmV9dNfq58FIGjTvicZLs8eKbzCA968
         PTrMDRNDx6Kp8BZbm8GQ21jluduvfMJFsd6MOI9sr/PbRvrXvgYvAMArGlTeb16lRiCY
         KDgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR1rgrmmAIn20WuEfxVoABStpjTCFuogvFz3mFZQhf67mWPoVHOiRb0NnVfgxlaofjI5qQbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9AE+2ZdFvFiKMHpObe1mhI9+MiPu0YRG1JTtonJX9HAS156d4
	RMvXp3fHxjXIaYwREfwyXuZZ4FiNV66OoyUXBYsllsaT69C6tJKk
X-Gm-Gg: ASbGncumFEXShUNIbdaeoZXOa6/ws9oLdCE6A5XlJq3BwfG1PikzRBiFUC4v/gLeJLC
	SSwWz1TIyKe4n5hFsyjSGPVPHYtXJQycjXACVAfKHzxwFUo2rBMEUAzgbhhMjKz/w5lLUMmSN83
	7Fuufco/PIUy7r6jy2aZHHQfRz5d5+uPWTMi2iGDYHx7+cefC0qTjsg1ygJJiCPSNltC88AVVat
	P9sWbNEdCR69Izfnbg+v38rLqjRClCmGi51+SzJrFHrzKhsFhemSTCHpxocu9Jf/vDO090l3ckH
	HfE2s7nP9FiczEeXqcgEGd+4ZuMWGjWhSZ3D5aHI8Imkz6+W
X-Google-Smtp-Source: AGHT+IEXT4VHtoN7BWCb9b46QkhkIIkudo6GwKbhv3dYWDQ39vj5aKhwilizZwe5JyZGlUhGnb2oMA==
X-Received: by 2002:a7b:c001:0:b0:434:f5c0:3288 with SMTP id 5b1f17b1804b1-439250df455mr58897315e9.29.1739030169469;
        Sat, 08 Feb 2025 07:56:09 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dcae129sm88297535e9.17.2025.02.08.07.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 07:56:08 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 18929BE2EE7; Sat, 08 Feb 2025 16:56:07 +0100 (CET)
Date: Sat, 8 Feb 2025 16:56:07 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
	Radoslav =?iso-8859-1?Q?Bod=F3?= <radoslav.bodo@igalileo.cz>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [6.1.y] Regression from b1e6e80a1b42 ("xen/swiotlb: add alignment
 check for dma buffers") when booting with Xen and mpt3sas_cm0 _scsih_probe
 failures
Message-ID: <Z6d-l2nCO1mB4_wx@eldamar.lan>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Juergen, hi all,

Radoslav Bodó reported in Debian an issue after updating our kernel
from 6.1.112 to 6.1.115. His report in full is at:

https://bugs.debian.org/1088159

He reports that after switching to 6.1.115 (and present in any of the
later 6.1.y series) booting under xen, the mptsas devices are not
anymore accessible, the boot shows:

mpt3sas version 43.100.00.00 loaded
mpt3sas_cm0: 63 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (8086116 kB)
mpt3sas_cm0: CurrentHostPageSize is 0: Setting default host page size to 4k
mpt3sas_cm0: MSI-X vectors supported: 96
mpt3sas_cm0:  0 40 40
mpt3sas_cm0: High IOPs queues : disabled
mpt3sas0-msix0: PCI-MSI-X enabled: IRQ 447
mpt3sas0-msix1: PCI-MSI-X enabled: IRQ 448
mpt3sas0-msix2: PCI-MSI-X enabled: IRQ 449
mpt3sas0-msix3: PCI-MSI-X enabled: IRQ 450
mpt3sas0-msix4: PCI-MSI-X enabled: IRQ 451
mpt3sas0-msix5: PCI-MSI-X enabled: IRQ 452
mpt3sas0-msix6: PCI-MSI-X enabled: IRQ 453
mpt3sas0-msix7: PCI-MSI-X enabled: IRQ 454
mpt3sas0-msix8: PCI-MSI-X enabled: IRQ 455
mpt3sas0-msix9: PCI-MSI-X enabled: IRQ 456
mpt3sas0-msix10: PCI-MSI-X enabled: IRQ 457
mpt3sas0-msix11: PCI-MSI-X enabled: IRQ 458
mpt3sas0-msix12: PCI-MSI-X enabled: IRQ 459
mpt3sas0-msix13: PCI-MSI-X enabled: IRQ 460
mpt3sas0-msix14: PCI-MSI-X enabled: IRQ 461
mpt3sas0-msix15: PCI-MSI-X enabled: IRQ 462
mpt3sas0-msix16: PCI-MSI-X enabled: IRQ 463
mpt3sas0-msix17: PCI-MSI-X enabled: IRQ 464
mpt3sas0-msix18: PCI-MSI-X enabled: IRQ 465
mpt3sas0-msix19: PCI-MSI-X enabled: IRQ 466
mpt3sas0-msix20: PCI-MSI-X enabled: IRQ 467
mpt3sas0-msix21: PCI-MSI-X enabled: IRQ 468
mpt3sas0-msix22: PCI-MSI-X enabled: IRQ 469
mpt3sas0-msix23: PCI-MSI-X enabled: IRQ 470
mpt3sas0-msix24: PCI-MSI-X enabled: IRQ 471
mpt3sas0-msix25: PCI-MSI-X enabled: IRQ 472
mpt3sas0-msix26: PCI-MSI-X enabled: IRQ 473
mpt3sas0-msix27: PCI-MSI-X enabled: IRQ 474
mpt3sas0-msix28: PCI-MSI-X enabled: IRQ 475
mpt3sas0-msix29: PCI-MSI-X enabled: IRQ 476
mpt3sas0-msix30: PCI-MSI-X enabled: IRQ 477
mpt3sas0-msix31: PCI-MSI-X enabled: IRQ 478
mpt3sas0-msix32: PCI-MSI-X enabled: IRQ 479
mpt3sas0-msix33: PCI-MSI-X enabled: IRQ 480
mpt3sas0-msix34: PCI-MSI-X enabled: IRQ 481
mpt3sas0-msix35: PCI-MSI-X enabled: IRQ 482
mpt3sas0-msix36: PCI-MSI-X enabled: IRQ 483
mpt3sas0-msix37: PCI-MSI-X enabled: IRQ 484
mpt3sas0-msix38: PCI-MSI-X enabled: IRQ 485
mpt3sas0-msix39: PCI-MSI-X enabled: IRQ 486
mpt3sas_cm0: iomem(0x00000000ac400000), mapped(0x00000000d9f45f61), size(65536)
mpt3sas_cm0: ioport(0x0000000000006000), size(256)
mpt3sas_cm0: CurrentHostPageSize is 0: Setting default host page size to 4k
mpt3sas_cm0: scatter gather: sge_in_main_msg(1), sge_per_chain(7), sge_per_io(128), chains_per_io(19)
mpt3sas_cm0: failure at drivers/scsi/mpt3sas/mpt3sas_scsih.c:12348/_scsih_probe()!

We were able to bissect the changes (see https://bugs.debian.org/1088159#64) down to

b1e6e80a1b42 ("xen/swiotlb: add alignment check for dma buffers")

#regzbot introduced: b1e6e80a1b42
#regzbot link: https://bugs.debian.org/1088159

reverting the commit resolves the issue.

Does that ring some bells?

In fact we have two more bugs reported with similar symptoms but not
yet confirmed they are the same, but I'm referencing them here as well
in case we are able to cross-match to root cause:

https://bugs.debian.org/1093371 (megaraid_sas didn't work anymore with
Xen)

and

https://bugs.debian.org/1087807 (Unable to boot: i40e swiotlb buffer
is full)

(but again the these are yet not confirmed to have the same root
cause).

Thanks in advance,

Regards,
Salvatore
