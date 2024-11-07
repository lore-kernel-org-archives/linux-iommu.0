Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814BA215F71
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997325; cv=none; b=LCAbanfVf/t2AVtVQY6g6BQHvwHCbrnGMkf2jxJTCYp2e7NT2CZCeee1NGMcdjJzHPzCRYiTRp7Wyvta7FuhMLu+pWFBKLsSnO6F2Y8FDQb6X/J8Dpp5t9ykNM/IjV8LvJtruFAz0h4G2ZC1k2mZtcsULpPh/MOukhamkEERjfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997325; c=relaxed/simple;
	bh=eUCeCaJ9PfD3zyQFxA6TaQ67CanzLnw3Tdtqk26WJFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoTl0HA5VEFSb+q77Ho+Zjn4YRR213Nt4uOHhHK/QK7IfZj/ngdSxtxYB01cNGhsNp3PSnHuXoEcom1aKx9oPOebc4bzKKaikM850H1sqOLyYUUg2AB/Qj2XJvw1YB2Hejg0qvp9WHmZGKwi4wYKXZO1hM9YQ9TBtlJfE7Q1zEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YzF7fkcS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YzF7fkcS"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso1412185a12.2
        for <iommu@lists.linux.dev>; Thu, 07 Nov 2024 08:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1730997321; x=1731602121; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JmDtn4eHHwzfqsO66Tv5ritJL4qD/TpJe1GQgggVHNw=;
        b=YzF7fkcS4xcH/d577G3hsMPjfM1GtmYQv0r8p24AOya3+1uHcbiqI8falLa2CVuCsA
         wDC9ePHM7xAq+vDep75KmTdwSvYjsOGYt4GwmSGS5jF2WPXfh0BdYIKs6NFusMSSzMoV
         o054HkcPErB+Wd/E3O4QPMEppqDu65arq/WC1s3yCeQGMmPbasli+R/lnIjPbqKRl8E3
         KZB4c7rANvj6D6ZHizK1JtoGN4nDZWhNauAK8bqQ9v6Js13vosh35lQI3MeJcVwscovn
         tQ87uHPatOnvHNiViE0PIUM1Gc7nuj81ACIGNNlGIUENd+jKXdtnkJewgLVTVDXoeeQU
         PaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730997321; x=1731602121;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JmDtn4eHHwzfqsO66Tv5ritJL4qD/TpJe1GQgggVHNw=;
        b=hbjlf5voMXgGb391zioZm+Lv3pJ9DsM+SSiGbzu/nny+T6wJODpTkhU0z0S/veoX8U
         AWnlZMxEQyjApN5LbULX58dkDXd+1EBNukHJXzPZ71MV/rP6HUYHSfI5ajilkAoNbiQA
         JXDmEzWgdta+4u3LCxlLLEYOQ9fa1zoj2vzJJwwZ17kGqcyAVhTTZBvjVmdYtAu+ufcG
         m4bzyAp+TT9XwcIDwARkcqjG0LQQFIaurtPcbnqktmlntWj77PixmhVHbGqVcAoLEOyw
         KB5v/cIbvmg0TrZWDapL3d+nrrRcT+CfMVb1zCB1mm5TNDh2L9l33gtlnYayCH3MgVEf
         4RdA==
X-Gm-Message-State: AOJu0YysJ+JIAKitnzP0LbFiOnkhBbY803kfrhBZ9FjKVR3AlGDs5a/w
	pwD0Hx1KiXbNFsLgFIVv5ezqnZPwYEU2D+Vq3Gxf51jNfJGJ2chbfruuOBdkl3wIbJ/ZsLFuJP/
	0
X-Google-Smtp-Source: AGHT+IFtmxkLlGT8OxA9KTMenPWNAzzstmI7WJwkpa92ObcSE8IEPgx11H+XPafWA5cenT2npaB1EA==
X-Received: by 2002:a05:6402:27c8:b0:5cb:7877:a633 with SMTP id 4fb4d7f45d1cf-5cf098cdc8amr23197a12.33.1730997320658;
        Thu, 07 Nov 2024 08:35:20 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ed68sm951155a12.63.2024.11.07.08.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 08:35:20 -0800 (PST)
Date: Thu, 7 Nov 2024 17:35:19 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Subject: Re: [PATCH 1/2] iommu/riscv: Free irq vectors on pci remove
Message-ID: <20241107-4570ae5b32599c6ff96b5241@orel>
References: <20241106175102.219923-4-ajones@ventanamicro.com>
 <20241106175102.219923-5-ajones@ventanamicro.com>
 <CAH2o1u5ttY+0d4v8U=H-PwLUHZo5uMxxCQ5NAXudOQvUUMcpfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2o1u5ttY+0d4v8U=H-PwLUHZo5uMxxCQ5NAXudOQvUUMcpfA@mail.gmail.com>

On Wed, Nov 06, 2024 at 11:00:55AM -0800, Tomasz Jeznach wrote:
> On Wed, Nov 6, 2024 at 9:51 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > riscv_iommu_pci_probe() calls pci_alloc_irq_vectors() which
> > states pci_free_irq_vectors() must be called on cleanup.
> >
> > Fixes: 68682e9578fb ("iommu/riscv: Add RISC-V IOMMU PCIe device driver")
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  drivers/iommu/riscv/iommu-pci.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
> > index c7a89143014c..25a27e627a0e 100644
> > --- a/drivers/iommu/riscv/iommu-pci.c
> > +++ b/drivers/iommu/riscv/iommu-pci.c
> > @@ -99,6 +99,7 @@ static void riscv_iommu_pci_remove(struct pci_dev *pdev)
> >         struct riscv_iommu_device *iommu = dev_get_drvdata(&pdev->dev);
> >
> >         riscv_iommu_remove(iommu);
> > +       pci_free_irq_vectors(pdev);
> >  }
> >
> >  static const struct pci_device_id riscv_iommu_pci_tbl[] = {
> > --
> > 2.47.0
> >
> 
> Andrew, interrupt release call pci_free_irq_vectors() should already
> be called by device
> managed resources framework, with unwind action callback pcim_msi_release().
> 
> Callback is registered during vectors allocation:
>  pci_alloc_irq_vectors_affinity()
>   __pci_enable_msix_range()
>    pci_setup_msi_context()
>     pcim_setup_msi_release()
> 
> This driver enables device resources management with initial call to
> pcim_enable_device().

Ah, thank you for the education and inspiration to look closer at how this
works. It was easy to confirm with a WARN in pci_free_irq_vectors() and an
echo 1 to the IOMMU device's remove sysfs node.

> 
> Are there any conditions / testing sequence the release function is not called?

No, not that I know of, this was just my knee jerk decision to mimic the
call pairing I was doing on the platform side to the pci side. Sorry for
the noise, this patch can be dropped.

Thanks,
drew
