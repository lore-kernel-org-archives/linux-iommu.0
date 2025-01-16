Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C42126AF6
	for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737017490; cv=none; b=BPTUiqcn4cbKUed3I0jpe8Tz7YRYdSUxnqMa5eT2LoVgIEppzBL0EO8xbs1ZZFAia9CVmmDWhnDJwVitKL+mzZu5xoIzJxJMO6CxaaoAzwgfqWkLk1/7/vrltA2XNoPgMnCsADxWNEqqPn3pOB1KpoMDsNJF6FWFV6QJBe/geRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737017490; c=relaxed/simple;
	bh=FFnWxVgBfmkxOw1y7WfzcmhWlvlCPve9v5pbf9oHDrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eysvAErpEbv7uvDuyjyctaIUhr9eDMDUa0Hf7mj1f/QG2CJ60Bv8+1Ug2iKjrdWnCBEFPbITHqL43ZIPFFMsXkmVj9yWobp5jNi5xraIurCMklEkuedRZyC1grOqH6GyDFxu0fyeQOCLsA+r3ePi1eNwWmdt6sGnVXsNQPPvtQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FDOLHRdF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FDOLHRdF"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385dece873cso348461f8f.0
        for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 00:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1737017486; x=1737622286; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vdYGACSqmD06pBhAeXOqTAZ8uvEoU3CDJANNyc9PH5I=;
        b=FDOLHRdFTH2qnqRbphzGc6+vJze7ec4O+GWwOAc1iuctqnBWTcIVHnmWZIWINxPAbL
         pD93Ll4eS1K9qU2+MqNCSGJj2ZpakesR1eLZLz272fMyU9C0vdYkhlbwWf/mEQ75089W
         dlRwP/5J3Lffajwnag141PjkEbVNmfcbEmYzFmriQoOKmpblNXdgZSUzMInGHJaUeLCq
         X8s2+zYPLK/OIyGFaLd5YSVyyjW2LmLIj41rH1yaK6oG6XwCo5A1mOqahWNtVC4jBidt
         wQL6eXlLpt0oAFCIyQoVzbeEtE9KpG1P99udw79pxya5DXc8EFLkjU67l8VFfOrGj4SB
         URaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737017486; x=1737622286;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdYGACSqmD06pBhAeXOqTAZ8uvEoU3CDJANNyc9PH5I=;
        b=qCEr+mFGCR3ssN8BKbVFZbo9I2kJFKrSTo0lyVJBKqVhQv2cqApijSa405Mm3TfIvY
         /0fIFiA4h+ezN9SEbZgUvqpBKlHCDkCEnv9z4AIxwL2Ztrex7RYV+Ay0VaszrLj3XBMc
         0pGslQNZb0QmBiHmeG+Da1gNolWh/AR6SQWe9C/Tauu763yFWbI+fvhmeqkUXYqA/jj2
         3RsmA6Pxt2lJI6L19W6ozVmLgkEL6SRkNejmyeWEX+8Uv08kjg2IfCSiiqReKW/zNn+n
         U3Zp6ZKXdXzRjih3jotWCaGe0Hfe2hHfr/1UGOow6FTg7xjM2gj2gp2I1Xvdmr1JATQH
         y2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWqSPqSWWmwofK+zBUVy4/HpuEB1kVsvlttQ31KdiTrqWI8BaN4l2KUyjUWHMA5Eg14MZJ5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUhUvOwywmL6eeX0nHcjXULF/5vn6yNb9PkbCAnarTTwcM/n0v
	N36x44IsKhSWSMns4bRhtyq0voI+E5gMuiMKoLXNvgJmsdnCo/7AFpdo+JsKKpI=
X-Gm-Gg: ASbGnct+jWRdg3c8dM3IupIfhmRIFdSybbHGUZWTw8Pqti0kcszCv0Tq+mH3TJ6jig0
	IkrR+fqrQbWZ3Ri1GbkYXPbcUQae9FOtN9zekSbEHLrqhqD5BF0uzf4wPlZVfU/UtT1Bt4z7ySH
	+eN+U5OokMqaFATSbKca/FN2hV+bqBCzAzh+fzOpcNeH+vYSuXD9lLdBGXFr2NvgsNj0bP45j7V
	VG1MQvyIWL0b5AMmHmvM5JAMkae9fangFQ2mOvWCErZfxmpTVoijihtfKjPqcFUQQmG6nb2GZXQ
	OIgBiWYssma98FpQ2dOQNvEDZyAUN4324NBaiAC0bA==
X-Google-Smtp-Source: AGHT+IEsbulHh7PZVHSAEnmDh38IVvfobmbwOpTAusRtk5MN3iwIfCnGsZ4ArTaC23pmkWtqt4FHJQ==
X-Received: by 2002:a5d:47c4:0:b0:385:ed16:c8b with SMTP id ffacd0b85a97d-38a87309d21mr11955948f8f.23.1737017486382;
        Thu, 16 Jan 2025 00:51:26 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c3428sm19402764f8f.87.2025.01.16.00.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 00:51:25 -0800 (PST)
Date: Thu, 16 Jan 2025 09:51:25 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Milan =?utf-8?B?xJBva2nEhw==?= <milandjokic1995@gmail.com>
Cc: linux-riscv@lists.infradead.org, jgross@suse.com, 
	aou@eecs.berkeley.edu, Milan.Djokic@rt-rk.com, rafael.j.wysocki@intel.com, 
	linux-kernel@vger.kernel.org, oleksandr_tyshchenko@epam.com, iommu@lists.linux.dev, 
	sstabellini@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	xen-devel@lists.xenproject.org, Slavisa.Petrovic@rt-rk.com, takakura@valinux.co.jp
Subject: Re: [PATCH] riscv: Add initial Xen guest support for RISC-V
Message-ID: <20250116-aa9eadde9279e66dbc01c705@orel>
References: <e4a649a7fdfc8fcf5f48a0bc4e76e5d546078083.1736868605.git.Slavisa.Petrovic@rt-rk.com>
 <20250114-316084c962eb867c0b681043@orel>
 <CAKp59VFkW8F2xHsgAxiw138ZrpQJL8R5cTkF8f9vY40iEoRbWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKp59VFkW8F2xHsgAxiw138ZrpQJL8R5cTkF8f9vY40iEoRbWg@mail.gmail.com>

On Wed, Jan 15, 2025 at 08:04:05PM +0100, Milan Đokić wrote:
> Hello Andrew,
> 
> On Tue, Jan 14, 2025 at 7:18 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Tue, Jan 14, 2025 at 05:09:36PM +0100, Milan Djokic wrote:
...
> > > +++ b/arch/riscv/xen/hypercall.S
> > > @@ -0,0 +1,71 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#include <linux/linkage.h>
> > > +#include <asm/assembler.h>
> > > +#include <xen/interface/xen.h>
> > > +EXPORT_SYMBOL_GPL(HYPERVISOR_event_channel_op);
> > > +EXPORT_SYMBOL_GPL(HYPERVISOR_grant_table_op);
> > > +EXPORT_SYMBOL_GPL(HYPERVISOR_xen_version);
> > > +EXPORT_SYMBOL_GPL(HYPERVISOR_console_io);
> > > +EXPORT_SYMBOL_GPL(HYPERVISOR_sched_op);
> > > +EXPORT_SYMBOL_GPL(HYPERVISOR_hvm_op);
> > > +EXPORT_SYMBOL_GPL(HYPERVISOR_memory_op);
> > > +EXPORT_SYMBOL_GPL(HYPERVISOR_physdev_op);
> > > +EXPORT_SYMBOL_GPL(HYPERVISOR_vcpu_op);
> > > +EXPORT_SYMBOL_GPL(HYPERVISOR_platform_op_raw);
> > > +EXPORT_SYMBOL_GPL(HYPERVISOR_multicall);
> > > +EXPORT_SYMBOL_GPL(HYPERVISOR_vm_assist);
> > > +EXPORT_SYMBOL_GPL(HYPERVISOR_dm_op);
> > > +EXPORT_SYMBOL_GPL(privcmd_call);
> > > +#define SBI_ECALL 0xE
> >
> > Shouldn't this be 0xA000007, i.e. the SBI firmware specific extension
> > for Xen. Otherwise why refer to SBI? Note, '0xE' is an invalid, legacy
> > extension ID in SBI.
> >
> Hypercall is triggered through SBI and we defined 0xE just as an
> SBI_ECALL ID on Xen side for hypercall handling (among other operation
> IDs), so we're not referring to some standard /legacy ID here, just
> utilizing SBI for hypercall handling.

If the SBI specified EIDs and binary encoding aren't used, then the
hypercalls aren't "triggered through SBI", Xen is just doing its own
thing on an ecall. Xen doesn't have to implement SBI at all, but if
it wants to provide SBI services, as well as its own hypercalls, then
the hypercalls should be encoded in the same way as SBI functions and
an EID allowed by the SBI specification for hypervisor-specific
functions should be used. For Xen, that EID is already specified and
it's 0xA000007.

> Is this specific ID (0xE) not allowed to be used on the kernel side
> for some reason? If that is the case, we can use any other ID,
> including the one which you suggested.
>

Linux can use any ID, and Xen can decide what that ID is, but, if Xen
wants to implement SBI, then Xen can't use 0xE, because that EID is
not allowed by the spec for the purpose of hypercalls.

Thanks,
drew
