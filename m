Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08997201106
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919668; cv=none; b=o42HvwYaHepov/bORCTDrYvLdZh389xuLH3LGEJ8U+sxia0Is+Xy6VxXFR0tuopAGJWe8k7TTl9R6GElPo9j2UQhaZJmGrSOugFTLzFrX4ozkWI9Em0Tq+VTbJg0Ii41ZqgxDRU4cEb90QL2SbfR5YMFhTHni6gZfLWToKAOSoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919668; c=relaxed/simple;
	bh=5hdQupgsH4RLCWd2NxZg727/NPUBjS2vG2y9B6bJEKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iB4griklqP/kLi93yBjvNiqJDS04FTQDGn63lF0mfPgsp5jIyxiFCUmdtjP/ZoiyhCIZvq8W7VFAzJ++XdFt+34Kgu+v+KBM3ZguaARqwmtFFe76i/6OUztcC7fwoKnzCnQgMH4lkRgsS7VpPPU+gtBMAdq+POmOwsBfgbYELDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=um9GYzWV; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="um9GYzWV"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3a5cd2a3bso705045ab.3
        for <iommu@lists.linux.dev>; Wed, 06 Nov 2024 11:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730919666; x=1731524466; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nokwy9FNt4uthy8MIjfBTH5T/UpMOLuozVjuYdrWGao=;
        b=um9GYzWVDZ23j/NCV1IhWPloRqWfX0YfossKyKytGo20GnWWdOggfynFeG17i9TGCa
         FrpTKD+/aDD4hank6q5HU64PzLo5LvYQnAFrhyMoJY4hmhBoWKplglgNIWwb5kvkG1e/
         Ofr3szpFxuNrE+jv0wmym/UQyHyiE93+q0TqDo+OexNy0Yo4G9NIIUMMIrbzmQBoOWpz
         VOev5NrfcTmgoEfgnez5ZUeKf2bkuw6kWVZnIUSrbW2rh4RL9OZZFY1LrAtpDfSkrsVs
         fMO8zyALA7batrK3ILdMQCZUHjxIPcKpseB9iZHk1drTSXosHYS8U6rsN3vGl2Gx8bXg
         woOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730919666; x=1731524466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nokwy9FNt4uthy8MIjfBTH5T/UpMOLuozVjuYdrWGao=;
        b=R6RNpBGm7QnVQreF9du5hEiOC4sWOxHW06uQfu1gSs+gv0DLnTsfGuMcVncUgSTh+1
         2zrKjeRNAy2sRBk4JgbOswik+qdz34nJmbLooiHpQeeUsEO8gfG3fwjI/axfz5z2ocKg
         HFKGrm4ky5Z6tjXivbFUEYeIOTtEkRctsMN6gpVCezbf7yvUaRvjyFS5xOK5G+ZMvQPU
         15qsX10PvaxwF9r3pFG4rYXSMmWI0O5RDZKQOtuydoniowlDauPQfDxqgZ7Mpudeuef/
         z+RKCG8koOtVAUzrMooyxemtIIqydrl0aAlvcgbpWWzKu21VCQ9+SkU8/ZaeopK39Rqj
         +lXw==
X-Gm-Message-State: AOJu0Yy9ewmHoPuEjeZnUKxReM5bn47L1xvj172+6ttT4WclKfWKV761
	BhamjI97C70OvTzZZc3LPd4WHw2IN5S0R9SE6G6kApRfT3joBJiulh43oIHkXRrLWXxsp6MXlvx
	wUwcmuUVqpWso36RxGp2mMvuC4ztftw7Qt8GkGQ==
X-Google-Smtp-Source: AGHT+IGKLw+vtB22wIL6ge+rYJfG2yKicRc2L7oxp3S9z+BUnDn7CDGeMTTQTITBq0NYmM5cY0+xV814s8EnnG1ZsZw=
X-Received: by 2002:a05:6e02:1568:b0:3a6:b258:fcf with SMTP id
 e9e14a558f8ab-3a6b25813e9mr226176725ab.2.1730919666151; Wed, 06 Nov 2024
 11:01:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241106175102.219923-4-ajones@ventanamicro.com> <20241106175102.219923-5-ajones@ventanamicro.com>
In-Reply-To: <20241106175102.219923-5-ajones@ventanamicro.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 6 Nov 2024 11:00:55 -0800
Message-ID: <CAH2o1u5ttY+0d4v8U=H-PwLUHZo5uMxxCQ5NAXudOQvUUMcpfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/riscv: Free irq vectors on pci remove
To: Andrew Jones <ajones@ventanamicro.com>
Cc: iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 9:51=E2=80=AFAM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> riscv_iommu_pci_probe() calls pci_alloc_irq_vectors() which
> states pci_free_irq_vectors() must be called on cleanup.
>
> Fixes: 68682e9578fb ("iommu/riscv: Add RISC-V IOMMU PCIe device driver")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  drivers/iommu/riscv/iommu-pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-=
pci.c
> index c7a89143014c..25a27e627a0e 100644
> --- a/drivers/iommu/riscv/iommu-pci.c
> +++ b/drivers/iommu/riscv/iommu-pci.c
> @@ -99,6 +99,7 @@ static void riscv_iommu_pci_remove(struct pci_dev *pdev=
)
>         struct riscv_iommu_device *iommu =3D dev_get_drvdata(&pdev->dev);
>
>         riscv_iommu_remove(iommu);
> +       pci_free_irq_vectors(pdev);
>  }
>
>  static const struct pci_device_id riscv_iommu_pci_tbl[] =3D {
> --
> 2.47.0
>

Andrew, interrupt release call pci_free_irq_vectors() should already
be called by device
managed resources framework, with unwind action callback pcim_msi_release()=
.

Callback is registered during vectors allocation:
 pci_alloc_irq_vectors_affinity()
  __pci_enable_msix_range()
   pci_setup_msi_context()
    pcim_setup_msi_release()

This driver enables device resources management with initial call to
pcim_enable_device().

Are there any conditions / testing sequence the release function is not cal=
led?

Thanks,
- Tomasz
