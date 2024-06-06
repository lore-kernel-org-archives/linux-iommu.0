Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB99719D898
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717656878; cv=none; b=gKCu5slmYkELvYuugsE0Zz3MaYiyCLocTT+U+facts/cuFAjvpdf/6SlyeRx4Ncazxr+aQ98axVw02kBsKvLjXoRy4jkTfgpcEm6jC/b0cNO+HW0Et2QPZ27+QJqrfBB01czAvnosUvwsx5dpp5EI/cvb5uV+b2gLZZYE/mwjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717656878; c=relaxed/simple;
	bh=KSdDPxC5VUh1WnamIAbzz671Erp4LUNSssBAt5dfhn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txR7GNss6IS07bRlEqhyCWHmu76A4RdzSC1C6XGQ6i27IhqJ8XxOdENLdNkmTkUe/GgsFTpgglAI0Y4qrR30qU4j+GTGFlyFAVUelD0uisNxmqA6dDjhbS6BOKBh9cWQo/8QWPoDb0+2+uCHkSVD3DY3rgUYPrELXhf8elIGhjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=I5ocMm7Z; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="I5ocMm7Z"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4215f694749so1341425e9.2
        for <iommu@lists.linux.dev>; Wed, 05 Jun 2024 23:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717656875; x=1718261675; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a7TCmXGWr94ZoD3g1UVXKN5ISjES07LkwWyEhWG4/I0=;
        b=I5ocMm7ZeBAwyOBnUNdY7BuwbkHCU7k5cdkDb2bT8Pj5Wl5Ox7Zsx4NxYZpSRWN+TY
         QOBkkPiRUhdXWpVcRb4kKVp0yK4VTteJOU8pi27x778ziheDATGlNO3uJ3uxT6/K9Z9U
         IoU2FYoVYZ7L/FUMme0qmlFOqftjlDrNmb7jYo4AEP9M3rrbnRiZFL7Lx6u1LoSvnedF
         Ac/mgJiXZ0Rc1EoPIT42b2bgyo/sn4maVhv+rB1aRc4vVRdtPEfdhYSL0IFwzLVK/GVc
         aduHr7ZNx1iJnemYQWhrxHTMHYtlEd2jVTid6EVgy/r4CFC5VIuJ8+btyYna5nRixRmq
         Lr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717656875; x=1718261675;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7TCmXGWr94ZoD3g1UVXKN5ISjES07LkwWyEhWG4/I0=;
        b=T6IzbhRHuRoPHDexrsq9TsMRop+UDrfSSNwXJ76b0YOGQBNK/wvcq9phItw3Js4CwN
         E6yVFWqYSdUfG4w3U21KVaaWfeksxqV8Vl+Kc2BAKwqnom2s1nUwhBVcdicC3jiNM/82
         7ho+PIw3kt2C+sBXFTiAtkF4pfe4ggO6Tlrt1av/AW6ay/ZAOUsTYDd59mO59JaZTwRQ
         oP4DepT+wE5yPtfIVTqi3s6m1jOXPSVLPS2OWRdwM1goF1Vk9Ejco4XA4UXxwsYPEYe+
         fUMPqPUFpz9/Ff3QsGk8CE1W0g2I2DaXUFe94h3vUn8HYYuAb3MN4nzbDPfnIZ4GXaen
         xkwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+moVP7xRMyF0Hvl6sMqEVA/y6nhyB8uYWr5h24gFBmUiLzBJLGlaHaKVHyk5VAUImGP2FSvfCK94o7J11dewLUgJ8tRw=
X-Gm-Message-State: AOJu0Yx1WNGdRE1IezaQlrJmavh2FDCnaquaAta5Nmr/M4ZWrUZWdC44
	bl4b2/odO0X8SPN9GfY8HTgdJnhHE0wZcR2RJg4QNs4EnrC4psFycMwmJjWuXCY=
X-Google-Smtp-Source: AGHT+IHNKnXIBb3qZJygU2iYDImkZ9rzUJkNBWDBUa1dYfWFLGg6a9Ze5BMW5kuAh9PHrPhk9uqCHQ==
X-Received: by 2002:a5d:4711:0:b0:35e:83f3:ea0a with SMTP id ffacd0b85a97d-35e8ef65b69mr3594626f8f.48.1717656874844;
        Wed, 05 Jun 2024 23:54:34 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fc1ca8sm714821f8f.97.2024.06.05.23.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 23:54:34 -0700 (PDT)
Date: Thu, 6 Jun 2024 08:54:33 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
Message-ID: <20240606-988b5519747e28c276f9a952@orel>
References: <cover.1716578450.git.tjeznach@rivosinc.com>
 <7dcd9a154625704cbf9adc4b4ac07ca0b9753b31.1716578450.git.tjeznach@rivosinc.com>
 <20240529-08fd52a8e703418142bdfa84@orel>
 <CAH2o1u7N03b3dzxxG8jp7qW2jmCDADwq_OL2Ayv1AL1XsA7s5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2o1u7N03b3dzxxG8jp7qW2jmCDADwq_OL2Ayv1AL1XsA7s5w@mail.gmail.com>

On Wed, Jun 05, 2024 at 11:58:28AM GMT, Tomasz Jeznach wrote:
> On Wed, May 29, 2024 at 8:15 AM Andrew Jones <ajones@ventanamicro.com> wrote:
...
> > > +/* 3.1.3 I/O MMU Directory cache invalidation */
> > > +/* Fields on dword0 */
> > > +#define RISCV_IOMMU_CMD_IODIR_OPCODE         3
> > > +#define RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT 0
> > > +#define RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_PDT 1
> > > +#define RISCV_IOMMU_CMD_IODIR_PID            GENMASK_ULL(31, 12)
> > > +#define RISCV_IOMMU_CMD_IODIR_DV             BIT_ULL(33)
> > > +#define RISCV_IOMMU_CMD_IODIR_DID            GENMASK_ULL(63, 40)
> >
> > RISCV_IOMMU_CMD_IOTDIR_* for all above
> >
> 
> I've checked latest RISC-V IOMMU Arch Specification and it looks there
> it is a bit inconsistent in IODIR naming.  The acronym IOTDIR is used
> only once, while all other references to directory cache invalidation
> command use IODIR.  I'll keep _CMD_IODIR_ here.
>

Indeed. I've made a comment on the spec clarifications PR to suggest the
s/IOTDIR/IODIR/ change.

Thanks,
drew
