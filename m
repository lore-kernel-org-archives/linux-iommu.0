Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129E613D638
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776754155; cv=none; b=YU1dyGL43Ju4Dey27svPQnwev+vJ4EYz97nwvHH5WkOCHTV501K+qHChDX2LGoojxCcmifu8Jxia5N81aAZCRD+fvkYeCjD/BQ4QRHo8Oq9XUomIs7CVy0qcEbAOvI6p929/1CO7Muqg5HrlvqxrXBjQ6+Soa+/wX6I/PyIpIR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776754155; c=relaxed/simple;
	bh=am3smhs96M1Iz0Y0JDciE1ZjrAK1dDbEC7UccjVq/eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAYYHJcGKw/5Y5AbxKEfKWEqROoyz6rpXIlR7DPTAaRGGudrc8VLYMEMPGvcJ75kNCNqcYq0zUXG2cDwTSjE9CqbA2MF5YF5aitOhXt+n7XR5x9Ae1+/N7zmcF77qTRsMCXMO6tmm+0o0A+gvO7tNp7lbXAEIlh2hw7IQTlftJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTf9S6+9; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTf9S6+9"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-356337f058aso2502936a91.2
        for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 23:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776754153; x=1777358953; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VdNywBu7apdyTFV9cnt3GZxXLndr1pBULjY0WptzCm8=;
        b=iTf9S6+9hFXzg1jlHt0V8wcJG7W9VDJeNaOBZ0KiOn5/FP1rCmcUnvBkZvlmvkx3VT
         E1+LAklYbjdVFoq04a3RQdgHWyH1VfNPHc6iKWpuYe8Fqzoszd7niO+g1pOrJKfax3ny
         rput8vmmbtzYu86QzWbQexix107YrXxKhzdVE5mHXREHAMehZb/jJ2iu+3o9A81+QshZ
         jJv2pIbk07KyQYFs7akLMWPM33BqHliI4kyhsByAqsSA+jB9oqGTAlwfjjNt2glo+apl
         uDmaEZWVbkIZFGbJ1ZZ6QC+JvJLZcdxjbFrP0CSFaiCJlpTO8kSrNLvP8oqQuFOa8/nA
         7Ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776754153; x=1777358953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdNywBu7apdyTFV9cnt3GZxXLndr1pBULjY0WptzCm8=;
        b=r0DbvFaZAqks0dvoYl+K/mH6Mw7Y9FBBV1JN3DnK5aIai2JG0Uyy8HEIn/EvANSb1M
         4cTgy5HWhksUXRIaxcQO2H/wpZ4evHjl+yriY1SBp5IPAEVFK/EJMQEn3MKDDEHWOdGr
         0ZjpgPsuv13ApyZJZGxiQL37oLunzL/fnBlLU0S0Ot333i5RumnYnkjtvbHIt387MoXF
         z74JQf4HMT7OY+kfhxEHZGyx0HeILNY+U/HP6i/0T16/D73McXzy1QkSRHHsMPvwlUR2
         eXnOQ5yUeSsi42k8ot4bqE+KwxvYjxwZB0hJh2IR6uaDXP1v/Qmb1FX7Nxsd9FEsMBVc
         YfVw==
X-Forwarded-Encrypted: i=1; AFNElJ/mbDzZz63Mb8tbiaNto6zmYcI1P4CZj476XZXtwoVCWm6F7vhUJisAI7PP3c0SqMkDqHlc9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOZnYI6PIhIXzi3U3hmpA/qE7CEYgrOLW0BjEHGQnlZI0N2chm
	ct9w7S4KEbZuPP/CUmPg5yd3LUw3SARfN2LuA8vNmjbAgzqTaE0fivN1
X-Gm-Gg: AeBDietLFFjn2qpYhv7zu58uEX0oTjd2OyqaCd1IRZPgK6u25HE2xFUgl4d+VSNTohm
	r6kZ/czmFRRzJMe6zNkbgw3XNkVtpwnZcB/NshY9/NT8e16wUu9+HHBUr7rw4+vd5Eq9GQM6ZZG
	Xb/Sqs2BtIoavmsD0N3gdRyYKqH/PVg18XgJZwSApuncHl/L27JrMFYauOH7h85YM/M+hUzPtrI
	0hJGdzNZuQc5bmCBmkPRXX2nsflyS/dzfrgfQERn8Q0cnoqTLV+/5jWh2ts7ft2dyDB6UiIxZKv
	1onqFho12OJ0ZntPx8NCA2cFXXT437qgtgJEQEvU6+w9+HJ0S+ng+xYRF8w4fyePmyhS0xUjZE7
	AWl/0ohFixIajbGqDTU1r6oghyZ2l6Yh1xQ7YXyNChed0xJ8Ek37r2595RTplwUiWagAnRegcg/
	syMADaMxF26bdP+tMKnZesSLckgaOBpIeDSnABq1Y7DEP9C3HODlYrlV0paVhqPZ1UumrrRcNY3
	R/mZJJUmvjjHGFR
X-Received: by 2002:a17:90a:dfd0:b0:35e:30bc:96ed with SMTP id 98e67ed59e1d1-36140402361mr16891174a91.10.1776754153374;
        Mon, 20 Apr 2026 23:49:13 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a8f0sm12278674a91.12.2026.04.20.23.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 23:49:13 -0700 (PDT)
Date: Tue, 21 Apr 2026 12:18:55 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, 
	x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, 
	Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>, 
	Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, Theodore Tso <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [patch 32/38] powerpc/spufs: Use mftb() directly
Message-ID: <aecdpyvTLJOjCdFp@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260410120044.031381086@kernel.org>
 <20260410120319.723429844@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410120319.723429844@kernel.org>

On Fri, Apr 10, 2026 at 02:21:04PM +0200, Thomas Gleixner wrote:
> There is no reason to indirect via get_cycles(), which is about to be
> removed.
> 
> Use mftb() directly.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/platforms/cell/spufs/switch.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/arch/powerpc/platforms/cell/spufs/switch.c
> +++ b/arch/powerpc/platforms/cell/spufs/switch.c
> @@ -34,6 +34,7 @@
>  #include <asm/spu_priv1.h>
>  #include <asm/spu_csa.h>
>  #include <asm/mmu_context.h>
> +#include <asm/time.h>
>  
>  #include "spufs.h"
>  
> @@ -279,7 +280,7 @@ static inline void save_timebase(struct
>  	 *    Read PPE Timebase High and Timebase low registers
>  	 *    and save in CSA.  TBD.
>  	 */
> -	csa->suspend_time = get_cycles();
> +	csa->suspend_time = mftb();
>  }
>  
>  static inline void remove_other_spu_access(struct spu_state *csa,
> @@ -1261,7 +1262,7 @@ static inline void setup_decr(struct spu
>  	 *     in LSCSA.
>  	 */
>  	if (csa->priv2.mfc_control_RW & MFC_CNTL_DECREMENTER_RUNNING) {
> -		cycles_t resume_time = get_cycles();
> +		cycles_t resume_time = mftb();
>  		cycles_t delta_time = resume_time - csa->suspend_time;
>  
>  		csa->lscsa->decr_status.slot[0] = SPU_DECR_STATUS_RUNNING;
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
