Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C6367B99
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926146; cv=none; b=QBVkSYB4S/UiFb1YNcsO9CtXp0WmmivO9p8dJub6Vz/ZYKYDJhDIJxxvf/kwFv9eFlnPjcXUWzFnKi3sB7hU59TsbYCBat11enOd1/d1izI8Xfh1zPcR7SWnhtOyaTDWFei2yAdZ0IbxCxKVI7xv05tcB7j1upVtYrJf3PjmqWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926146; c=relaxed/simple;
	bh=4OUtbohm6aw0MgX+/4lwbRnHgcp20dkSsUtNV6JOjQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rY/+iWiLKg3o7K3NaJkLwuybmr6z8TYq+BtGRie06tTcZ/t7sertt6fq4R0rRkjYRl2z4UwQVisfHbsWKJEGpd8bIenZX1U5CeKhkkiRzK4FQBHk5yxPnrHg5HewKp3LVpiz+eHSkdELygfsyBA1GE+b+q4rQjvUv/oWekmnNBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oL8Z5dmZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oL8Z5dmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0FB1F00ACF
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 07:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783926144;
	bh=rMofJfjBbwG6O408bABbGZP0477aJvPr1c1S1PiwKco=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oL8Z5dmZAucX4BoyaZVbIiF7KSsQdeEx+auTdvznSTLw40grvsQ4p4lTuWwXZ8QZ4
	 zUTNsNe5WqMniidlplZuRfhKQVcH/5XEB8jLNTZAoyVQVPhSceQK73IN0h9+P8401i
	 VhNtqjmx0oqqXbr4gVH1XgpEZ6N31vzK2XXRCDo5Sgumbz1rwLS+JPwpk2dgAphjwM
	 J9lyqx1tRy3tl9WS0uRHCN9cfa17lUe/W03JML2wNO1Zc+BLmzvxDccIPw8PUfcjXP
	 iG19+uIuweLRHOMTvkqvviRYJ+qotDc7uXxQY8FiDS/6QB+GUFgMK2MQzSq+/Erhs0
	 Hduh7W0CdQyNA==
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-470174001a0so1616995f8f.0
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 00:02:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rraem8N31Wb5WKEByj9TJHKljNxLWf+5C05JFr+HW9eSrYfarVD7JuH7mrjIXpcfRzse3F6DA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDHjwsKlzeL+8D/WKkUwqfsszNvb9rGTsfm8rRBXzSYAf5ZCPS
	+F0IQiDNnO0SVUwBimkFXIwldpNnl6uTn6lmVpOwIbRTIqhk9kz55wFDGBkZaXaAt0E6BvmSEbB
	YE0k3yoiod7bvF/djT4rbcW+/LBe5pkY=
X-Received: by 2002:a05:6000:310d:b0:476:6bd4:82b8 with SMTP id
 ffacd0b85a97d-47f2dc9b84amr8906420f8f.14.1783926051335; Mon, 13 Jul 2026
 00:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com> <20260713060902.15161-1-zhangzhanpeng.jasper@bytedance.com>
In-Reply-To: <20260713060902.15161-1-zhangzhanpeng.jasper@bytedance.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 13 Jul 2026 15:00:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSFX87LTXbAB=Qzy33xTVuaFQdR3jxh96ZdOhehfy-=AQ@mail.gmail.com>
X-Gm-Features: AUfX_myVkTZigj8Kv2PJTMqswtZonQ0byVSCfxIzOZtXPcdFPw_Y6nqVvbqpXBk
Message-ID: <CAJF2gTSFX87LTXbAB=Qzy33xTVuaFQdR3jxh96ZdOhehfy-=AQ@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/riscv: Use 32-bit MMIO accesses for 64-bit registers
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

On Mon, Jul 13, 2026 at 2:09=E2=80=AFPM Zhanpeng Zhang
<zhangzhanpeng.jasper@bytedance.com> wrote:
>
> The RISC-V IOMMU specification [1] permits 64-bit registers to be accesse=
d
> using two 32-bit transactions, high half first, and leaves the single-cop=
y
> atomicity of 8-byte IOMMU register accesses unspecified.
>
> Use the generic hi_lo_readq_relaxed() and hi_lo_writeq_relaxed() helpers
> for ordinary 64-bit IOMMU registers. Poll DDTP.BUSY in the low half befor=
e
> reading the full register from high to low. HPM counter reads require a
> rollover-aware sequence and remain outside these accessors.
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
> Changes in v2:
> - Rework the patch based on Guo Ren's earlier proposal [1].
> - Drop the build-time option and use 32-bit accesses unconditionally.
> - Drop the global lock and use the generic high-low MMIO helpers, as
>   suggested by David Laight.
> - Poll DDTP.BUSY through its low half before reading the full register.
>
> Link to v1: [2]
> Specification discussion: [3]
>
> [1]: https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel.org
> [2]: https://lore.kernel.org/r/20260615064855.90316-1-zhangzhanpeng.jaspe=
r@bytedance.com
> [3]: https://github.com/riscv-non-isa/riscv-iommu/issues/765
>
>  drivers/iommu/riscv/iommu.c | 18 +++++++++++-------
>  drivers/iommu/riscv/iommu.h |  9 +++------
>  2 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index cec3ddd7ab1..14b572058ed 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -668,12 +668,16 @@ void riscv_iommu_disable(struct riscv_iommu_device =
*iommu)
>         riscv_iommu_writel(iommu, RISCV_IOMMU_REG_PQCSR, 0);
>  }
>
> -#define riscv_iommu_read_ddtp(iommu) ({ \
> -       u64 ddtp; \
> -       riscv_iommu_readq_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp, \
> -                                 !(ddtp & RISCV_IOMMU_DDTP_BUSY), 10, \
> -                                 RISCV_IOMMU_DDTP_TIMEOUT); \
> -       ddtp; })
> +static u64 riscv_iommu_read_ddtp(struct riscv_iommu_device *iommu)
> +{
> +       u32 ddtp_lo;
> +
> +       riscv_iommu_readl_timeout(iommu, RISCV_IOMMU_REG_DDTP, ddtp_lo,
> +                                 !(ddtp_lo & RISCV_IOMMU_DDTP_BUSY), 10,
> +                                 RISCV_IOMMU_DDTP_TIMEOUT);
> +
> +       return riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
readq? Please ref [1]:

#define riscv_iommu_read_ddtp(iommu) ({ \
  u64 ddtp; \
- riscv_iommu_readq_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp, \
-  !(ddtp & RISCV_IOMMU_DDTP_BUSY), 10, \
+ u32 ddtp_lo, ddtp_hi; \
+ riscv_iommu_readl_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp_lo, \
+  !(ddtp_lo & RISCV_IOMMU_DDTP_BUSY), 10, \
   RISCV_IOMMU_DDTP_TIMEOUT); \
+ ddtp_hi =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_DDTP + 4); \
+ ddtp =3D ((u64)ddtp_hi << 32) | ddtp_lo; \
  ddtp; })


> +}
>
>  static int riscv_iommu_iodir_alloc(struct riscv_iommu_device *iommu)
>  {
> @@ -1501,7 +1505,7 @@ static int riscv_iommu_init_check(struct riscv_iomm=
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
