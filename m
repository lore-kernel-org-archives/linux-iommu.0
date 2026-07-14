Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B5136F42A
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994543; cv=none; b=Vc77ak5QqJ5hhWdydsjHnfuhiT8TKd4E6HMI+ncb5aR0Rk/14CKTctI+CUdZBgqrpeSbDF3ovLsPaYZ4B2MRAd+w8eav2akIAwpWEmrWtHJ2/aXK9YkwxCQPxeL55Wj9mVjXcWCvtPe8g3LeEli2INHFZ6zP53x3sjaSHTaBkf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994543; c=relaxed/simple;
	bh=AshqqY2sSjRgs6kJ4C0zvRMw7Vsqtm19l81b+jHhBCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvHtBw1kFrFcoL9LyA9wXkhhnVib+/0dTWYKFqc9Dg8AEjAKcmIbieaH7e1wrz4I9mRZ2sByVsgBv28nQBGBC8Ar3IkGAfAn6Y64hCPh8efBzhUGSkbp6Rsgxf+Yu3b6FMvh7Rqq0jQtHINu50yS2ubodqkIu2LZ6I/hrc9SmxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYtxoeVG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYtxoeVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376FF1F00AC4
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 02:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783994538;
	bh=JPG8KJkkby84Nl2p+va7Q/OZia1JnxQSsep3QJTzGik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CYtxoeVGMI2VeLL+qKdcAcEbbzTCJwn3jA7RwyUyFDLzXrOrGxkYQVTJOWDMUn3ff
	 Wu4HEThhVkvxU4Y799ThqjM0hycUl3dOCHsnvEiKDRy518R/gVGAuy2i1siJEbaNk7
	 aBJuXAmJzYvGt3oOpnFHHh/sUwzHp95JEleAUfWXpJllw388wmp9yUrBCA6AareiaD
	 S8tQrDg0pANOUPpftTr20fHEzWzABqnGn/dL9R7G2mDBJgA90YlsN2id9M837v0OnM
	 d7sSiP0qSMp7AiGTqmxk08Brp6ICl3FrCVmtTztNmV0g3pLh3Bl2khBbign1yVuheg
	 mwGNFeyQVFVAA==
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f3e6cc44aso1502913f8f.3
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:02:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RonOws6V/sMh3Aae9n0JVOm/j1Dq0dmVRoVuUb44n+Lv6DB9YesysoXZR8VMvW8UeYRa8k3sw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7DiDp0TL5NUbnQNQ3ZcP8ihL7Q2G5e4rkaNRS/2Hwa/NiMIqv
	OxSU9h377PloeWjmDgocGgo0jpqPYeIgWMcyvWh7nie0sZg/V9TbaXCasIO6OOMH4BUbUf8nfGt
	XquGpz5ucvjJhXex2nB7aPYTgVBHKqEw=
X-Received: by 2002:a05:6000:25fc:b0:47d:eb17:3bee with SMTP id
 ffacd0b85a97d-47f4884871emr464793f8f.6.1783994536738; Mon, 13 Jul 2026
 19:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com> <20260713122903.9458-1-zhangzhanpeng.jasper@bytedance.com>
In-Reply-To: <20260713122903.9458-1-zhangzhanpeng.jasper@bytedance.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 14 Jul 2026 10:02:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRsE=sHeK+qHdSp5_mAZF_=3JYOg3O7uZqUtXLUte+y8g@mail.gmail.com>
X-Gm-Features: AUfX_mxv-rDVQ-sRl5v_ZvLetOTEQcTb4z6swSsoJc6I4J4f-kN-VaGIj5bIac4
Message-ID: <CAJF2gTRsE=sHeK+qHdSp5_mAZF_=3JYOg3O7uZqUtXLUte+y8g@mail.gmail.com>
Subject: Re: [PATCH v3] iommu/riscv: Use 32-bit MMIO accesses for 64-bit registers
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: Tomasz Jeznach <tomasz.jeznach@linux.dev>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, David Laight <david.laight.linux@gmail.com>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Zong Li <zong.li@sifive.com>, cuiyunhui@bytedance.com, 
	yuanzhu@bytedance.com, iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LGTM!

Reviewed-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
Co-developed-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>

On Mon, Jul 13, 2026 at 8:29=E2=80=AFPM Zhanpeng Zhang
<zhangzhanpeng.jasper@bytedance.com> wrote:
>
> The RISC-V IOMMU specification [1] permits 64-bit registers to be accesse=
d
> using two 32-bit transactions, high half first, and leaves the single-cop=
y
> atomicity of 8-byte IOMMU register accesses unspecified.
>
> Use the generic hi_lo_readq_relaxed() and hi_lo_writeq_relaxed() helpers
> for ordinary 64-bit IOMMU registers. For DDTP, poll BUSY in the low half,
> then read the high half and compose the register value from the polled lo=
w
> half. HPM counter reads require a rollover-aware sequence and remain
> outside these accessors.
>
> This follows the 32-bit access direction proposed by Guo Ren [2] and uses
> the generic non-atomic MMIO helpers suggested by David Laight.
>
> [1] https://docs.riscv.org/reference/iommu/
> [2] https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel.org
>
> Suggested-by: Guo Ren <guoren@kernel.org>
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> ---
> Changes in v3:
> - Use the DDTP access sequence from [1]: retain the low half returned by
>   BUSY polling, read only the high half, and compose the DDTP value from
>   those two 32-bit reads.
>
> Changes in v2:
> - Rework the patch based on Guo Ren's earlier proposal [1].
> - Drop the build-time option and use 32-bit accesses unconditionally.
> - Drop the global lock and use the generic high-low MMIO helpers, as
>   suggested by David Laight.
> - Poll DDTP.BUSY through its low half.
>
> Link to v1: [2]
> Specification discussion: [3]
>
> [1]: https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel.org
> [2]: https://lore.kernel.org/r/20260615064855.90316-1-zhangzhanpeng.jaspe=
r@bytedance.com
> [3]: https://github.com/riscv-non-isa/riscv-iommu/issues/765
>
>  drivers/iommu/riscv/iommu.c | 9 ++++++---
>  drivers/iommu/riscv/iommu.h | 9 +++------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index cec3ddd7ab1..d647b71ebec 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -670,9 +670,12 @@ void riscv_iommu_disable(struct riscv_iommu_device *=
iommu)
>
>  #define riscv_iommu_read_ddtp(iommu) ({ \
>         u64 ddtp; \
> -       riscv_iommu_readq_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp, \
> -                                 !(ddtp & RISCV_IOMMU_DDTP_BUSY), 10, \
> +       u32 ddtp_lo, ddtp_hi; \
> +       riscv_iommu_readl_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp_lo,=
 \
> +                                 !(ddtp_lo & RISCV_IOMMU_DDTP_BUSY), 10,=
 \
>                                   RISCV_IOMMU_DDTP_TIMEOUT); \
> +       ddtp_hi =3D riscv_iommu_readl((iommu), RISCV_IOMMU_REG_DDTP + 4);=
 \
> +       ddtp =3D ((u64)ddtp_hi << 32) | ddtp_lo; \
>         ddtp; })
>
>  static int riscv_iommu_iodir_alloc(struct riscv_iommu_device *iommu)
> @@ -1501,7 +1504,7 @@ static int riscv_iommu_init_check(struct riscv_iomm=
u_device *iommu)
>          * regular boot flow and disable translation when we boot into a =
kexec
>          * kernel and the previous kernel left them enabled.
>          */
> -       ddtp =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
> +       ddtp =3D riscv_iommu_read_ddtp(iommu);
>         if (ddtp & RISCV_IOMMU_DDTP_BUSY)
>                 return -EBUSY;
>
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 46df79dd549..1b03790fbe1 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -11,6 +11,7 @@
>  #ifndef _RISCV_IOMMU_H_
>  #define _RISCV_IOMMU_H_
>
> +#include <linux/io-64-nonatomic-hi-lo.h>
>  #include <linux/iommu.h>
>  #include <linux/types.h>
>  #include <linux/iopoll.h>
> @@ -70,17 +71,13 @@ void riscv_iommu_disable(struct riscv_iommu_device *i=
ommu);
>         readl_relaxed((iommu)->reg + (addr))
>
>  #define riscv_iommu_readq(iommu, addr) \
> -       readq_relaxed((iommu)->reg + (addr))
> +       hi_lo_readq_relaxed((iommu)->reg + (addr))
>
>  #define riscv_iommu_writel(iommu, addr, val) \
>         writel_relaxed((val), (iommu)->reg + (addr))
>
>  #define riscv_iommu_writeq(iommu, addr, val) \
> -       writeq_relaxed((val), (iommu)->reg + (addr))
> -
> -#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, time=
out_us) \
> -       readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, con=
d, \
> -                          delay_us, timeout_us)
> +       hi_lo_writeq_relaxed((val), (iommu)->reg + (addr))
>
>  #define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, time=
out_us) \
>         readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, con=
d, \
> --
> 2.50.1 (Apple Git-155)

--=20
Best Regards
 Guo Ren
