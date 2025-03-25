Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A201F3D58
	for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928668; cv=none; b=CheXy/B8oaB07aISBOybBfkOM5COlyL2cTy7kQ2ruSEZTckhGnkCETwkEEHlZmKisVOYetcSSGn5rquUaKvo3oBUW5vW+CqAi2OIkgll/mDXj2L1YrXuSunW4ySrR9aCa1jbeD/qP4W45Y7G8NxnuqMbf9iNhMUIDyEx5t1htbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928668; c=relaxed/simple;
	bh=9LXbgpoOCiVQGaVF3eaFZ78LjOK6T4XMFnOl9Fypu/8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pY++SOvlwBdy5BOJREWDti96taYwS2BaFXnzRiGJ9ZG/uAj61oYMht/6UBR4oa4UAEl3BnwMBreO4hB4i1DgBnz7PvwvmTykUKTpeUv/vbGBQgnkEBoR+Mx/Yl6BOdp0ieMNin/LRM8mgXRkY97uR3G+qZqMLWLJESkyXSblNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=gusdwpje; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="gusdwpje"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso975205e9.0
        for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 11:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1742928665; x=1743533465; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKFyRYKxF1WM7/Qzxwsb5esyJjWasxcKEvmo6HpGkec=;
        b=gusdwpjeV64+GvisbWYjQHrm3aZsfZZee7ANW/BfImuvRVSvrFqSWT2NL8/+FXxDJz
         4D6CyKS5hdDg/Sl0mlTSkot88r1RXO1bUbiBqIl29P2ve6//Veg4dOrOK4WjppUkm6ZE
         ABAIEMvgOrG/OmKmW40CRaCK0Y6EkFGHi+Ul2ZgYaZx8lXDdUc04w8HsAIdm4L3HNLq4
         5yIyk9L6aaAV9rqpBWV260IEZ2//LtCRffOUlASjt8YvI71BzuIPgKU4FHws5ejVJd+Q
         sD7CF1nyTKwNRKVu+WIABKoc1B8UlbmGvK+LDU45YdOYgKGUOcZ/qC9My7UKoz0naj48
         Uh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742928665; x=1743533465;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKFyRYKxF1WM7/Qzxwsb5esyJjWasxcKEvmo6HpGkec=;
        b=NaQK7T4QqFQVvJb3g5IuVZGkp7OA/drl3HjIcwPe/qlFWgnlQK8Rq/2clvxBlx7LYG
         K4qEPBSBo80n9j41G0wIbVsOUBJUBdh3x/TyOuoH3woettVE0FubYbLRHR1c7lladXC+
         LXzCGvj1BU8XZ7dvda8T2cHYn0ktogRd7LRoeSUMhOqlIhcB6eAw05+T0vac7OBCMHwz
         GIpMxq2auq6UqMdO85DkDp7qbt+ygtdfRyWD5+mvuCbOkAW8AQ9mlx/aS4wUHULZEHb6
         Ntot/A52FUmgGPW+u30lpJOljqnVNqnfIYuwjB1piRtzjmUtwUEAjW7gc+1/Z29hYwqW
         vg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXf+wa06Il/+qCPZLrxwVu6ZWHA9vlbcZ0vekcbepv2zOlP83qBMYik59wkc7A5iB0i615mog==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTvbP6xA3lY2MEoGujzNptaweFKksOInwFe+WP7gn68Nasc2i6
	0XOZaxhpiDTiElH4o5Mc4fydJ+CzeM6BY/kWzwsOzTD/nP2U5OeFHvbapgVljmw=
X-Gm-Gg: ASbGncuX9aQgNR8lZATC8yq3xYv8w16q59Nj00QiwOfh8flJHWSgYDsgwd5iQ8x01md
	SPNl8UppkXYRmv5Mi7U6gwcoor1WaBpGOMiumugT4rnWfjcm+oDUptpJkwbx6634uEm+9DKIAZm
	328RyfcxbL7vM/6NYWO4wL9UziGnTxg7ovQdriW4zduco2R9Y8xaUjnl2p5mSNNxX3BqbTuCBw8
	wzeCKmorItkoNIJwVbPIgb49EnlOK7Z0KAz5lu60k/u93aVhGS+qbkRfbrb87rwqCXVy8NEtk1h
	pZXNqzxGpX9TzDm4904TUbwl21y5GjfKxaY0zdlbynkGAx39E3bKk+jfLg==
X-Google-Smtp-Source: AGHT+IE3tPDzR9UC+jvepT8+s1j1/v6Ba1MUiSkiWeQVK07RICCfaGQOUUCB6kQZK6oyqwZkxgnC/w==
X-Received: by 2002:a05:600c:5247:b0:439:4c1e:d810 with SMTP id 5b1f17b1804b1-43d775fbf63mr8654245e9.9.1742928664501;
        Tue, 25 Mar 2025 11:51:04 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b3c2csm14167481f8f.46.2025.03.25.11.51.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Mar 2025 11:51:04 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH] iommu: riscv: Split 8-byte accesses on 32 bit I/O bus
 platform
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20250325144252.27403-1-luxu.kernel@bytedance.com>
Date: Tue, 25 Mar 2025 18:50:53 +0000
Cc: tjeznach@rivosinc.com,
 joro@8bytes.org,
 will@kernel.org,
 robin.murphy@arm.com,
 alex@ghiti.fr,
 lihangjing@bytedance.com,
 xieyongji@bytedance.com,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F043708-3BB6-46CF-BEC3-2636E9A388B7@jrtc27.com>
References: <20250325144252.27403-1-luxu.kernel@bytedance.com>
To: Xu Lu <luxu.kernel@bytedance.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)

On 25 Mar 2025, at 14:42, Xu Lu <luxu.kernel@bytedance.com> wrote:
>=20
> Introduce a new configuration CONFIG_RISCV_IOMMU_32BIT to enable
> splitting 8-byte access into 4-byte transactions for hardware platform
> whose I/O bus limits access to 4-byte transfers.
>=20
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>

Is such a platform conformant to the specification? Either way, why is
this a static build-time configuration choice rather than a dynamic
run-time choice based on the FDT / ACPI tables / some other platform
probing method?

Jess

> ---
> drivers/iommu/riscv/Kconfig |  9 +++++++++
> drivers/iommu/riscv/iommu.h | 28 +++++++++++++++++++++++-----
> 2 files changed, 32 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
> index c071816f59a6..b7c9ea22d969 100644
> --- a/drivers/iommu/riscv/Kconfig
> +++ b/drivers/iommu/riscv/Kconfig
> @@ -18,3 +18,12 @@ config RISCV_IOMMU_PCI
> def_bool y if RISCV_IOMMU && PCI_MSI
> help
>  Support for the PCIe implementation of RISC-V IOMMU architecture.
> +
> +config RISCV_IOMMU_32BIT
> + bool "Support 4-Byte Accesses on RISC-V IOMMU Registers"
> + depends on RISCV_IOMMU
> + default n
> + help
> +  Support hardware platform whose I/O bus limits access to 4-byte
> +  transfers. When enabled, all accesses to IOMMU registers will be
> +  split into 4-byte accesses.
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 46df79dd5495..0e3552a8142d 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -14,6 +14,10 @@
> #include <linux/iommu.h>
> #include <linux/types.h>
> #include <linux/iopoll.h>
> +#ifdef CONFIG_RISCV_IOMMU_32BIT
> +#include <linux/io-64-nonatomic-hi-lo.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#endif
>=20
> #include "iommu-bits.h"
>=20
> @@ -69,21 +73,35 @@ void riscv_iommu_disable(struct riscv_iommu_device =
*iommu);
> #define riscv_iommu_readl(iommu, addr) \
> readl_relaxed((iommu)->reg + (addr))
>=20
> -#define riscv_iommu_readq(iommu, addr) \
> - readq_relaxed((iommu)->reg + (addr))
> -
> #define riscv_iommu_writel(iommu, addr, val) \
> writel_relaxed((val), (iommu)->reg + (addr))
>=20
> +#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, =
timeout_us) \
> + readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, =
\
> +   delay_us, timeout_us)
> +
> +#ifndef CONFIG_RISCV_IOMMU_32BIT
> +#define riscv_iommu_readq(iommu, addr) \
> + readq_relaxed((iommu)->reg + (addr))
> +
> #define riscv_iommu_writeq(iommu, addr, val) \
> writeq_relaxed((val), (iommu)->reg + (addr))
>=20
> #define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, =
timeout_us) \
> readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, cond, \
>   delay_us, timeout_us)
> +#else /* CONFIG_RISCV_IOMMU_32BIT */
> +#define riscv_iommu_readq(iommu, addr) \
> + hi_lo_readq_relaxed((iommu)->reg + (addr))
>=20
> -#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, =
timeout_us) \
> - readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, =
\
> +#define riscv_iommu_writeq(iommu, addr, val) \
> + ((addr =3D=3D RISCV_IOMMU_REG_IOHPMCYCLES) ? \
> + lo_hi_writeq_relaxed((val), (iommu)->reg + (addr)) : \
> + hi_lo_writeq_relaxed((val), (iommu)->reg + (addr)))
> +
> +#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, =
timeout_us) \
> + readx_poll_timeout(hi_lo_readq_relaxed, (iommu)->reg + (addr), val, =
cond, \
>   delay_us, timeout_us)
> +#endif /* CONFIG_RISCV_IOMMU_32BIT */
>=20
> #endif
> --=20
> 2.20.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

