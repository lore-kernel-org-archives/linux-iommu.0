Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3379D3AD524
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931081; cv=pass; b=tlJ2Fwt1FimyMaICPxKj+lcNbmKWOkhWivOicTsC7FoNpEOR2X5g1z8OMe2RqhZqY2zVHHz6imCdSAw8koRikGVuVWgFSbL4DaCXg1VSRTCpt9+Cs5QitIdGKPLGgcRZjhu4uzr2QhajwElt5MPQ+UhrcZ5E59my70fxpMHk6sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931081; c=relaxed/simple;
	bh=Pwf3ib3W1cn2rsmU9+xp117vdaE++X1Wu6jYG+3z83g=;
	h=From:In-Reply-To:Mime-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xtm+VOLw1l0EHNveUs4KbV305ros/hCzLhaklFZ6Jv/pzLdpNA3rMWkZptUeaNKu7/rGO1mI7igXd1ehd+eySk9GYr5qcFn2avoc6FThcqoOHmT/78K/p0H3SqSo4m5uVdcM93xOv+66DavSEbW2pk8fvQZzqL5CCQ+xwrhSdO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=l2DMNCly; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="l2DMNCly"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeae350e0aso3350286e87.1
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 01:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783931077; cv=none;
        d=google.com; s=arc-20260327;
        b=Al6hcigXI4wwHTjjbo8mxLbcw+3/Xzw+RB0nRIJoCTWBv/mnOxwPMVXMo+Hk+yOC7H
         z/s+OM7QUAVS7lryLdHtC88f0vgQ56d2YjqViy0zGsFQzDAarumEgXhL+jE/N/xYu5DD
         J5Y4dAHic6Osd0Slyyn30keNoSxNtD8Av1AbIqk573GJPjA+bMInNFKSdC5EgSUQnO4F
         Ep+XWCw2Z3xKxUP2ycD/LzU2VTr0sfdJHxJH4PgF0UtWo8jt7+Uc/BL8ggK66RcoGJuj
         vJ+gJPSd/NGNYuXtsgYtX3U6dnl3LFRmgenIpDFdhkEcF12XOp0EAixwErcpq3GIX6gj
         YDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :references:mime-version:in-reply-to:from:dkim-signature;
        bh=rw64d6fpmrwwgrKtd9NfBoVHViSe69VHc1+TSY5ZOZA=;
        fh=X7yy6GLBVdKOIvjF/ImVWtj4qVM6De31guOWbzkhgdE=;
        b=RCqvxHsBK1v946aUasc2FoaziqX/Po4u1YQgH44sPsqQ8ntWpzNFZ5f0yE5f11tefI
         IfuQN0JwlOXWyBKITJWVUsi6QM/jPknSx7uP0mD2z1Yg5TiAZ4wAyguwndYDD1Eb7s/B
         PCl9jRUJ5JfDl76AMM5ACes2nBHU8s1VPliM+Po2vH8zJ5Mh1nj4/XxXLg8hPQj8t3LJ
         FQ83/kVGY8VJWUZYK0VZH30vUK5RmZC4Vd3ZnkyfwbwgPhqdmQbjf/FtRQU1r84cEvHY
         nnO+5LoVPRr4rc/FYwkCbmAqykNBkfQARsxA7AUBgurVxKsjmljx1JnHLBFg6yW4JURZ
         BOnA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1783931077; x=1784535877; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:user-agent:references:mime-version:in-reply-to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rw64d6fpmrwwgrKtd9NfBoVHViSe69VHc1+TSY5ZOZA=;
        b=l2DMNClyWeiVDBF8zIHIT2A4dz9UCDwewCVy1F8e/xYoaSbMl5W5D24KY+AphOknIW
         0u6pDF2LfbLQ58welpd4o6oL5JN94WMUaec0BROvm3fl2dQHlT/W/hnUD3QxEpND/d1t
         uHuES9+MuDPLeX0XUa8QJrXDgR0cankJ8hQIyFI2axmGIvXESLikY0TxxkjLHX6aS1GE
         imVLhfSy+XZiLZBZL6vsuaFZGHbTvQV0SYqRjNf35WglwAMnvrahkrTwCEzQiy/yegoR
         8rKoc02ktewV6O8D3nY2tXg5/rUobYd5WbbzaZ3wLaDEHbJ05IXplaEClzonfdTAPRpM
         HSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783931077; x=1784535877;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:user-agent:references:mime-version:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rw64d6fpmrwwgrKtd9NfBoVHViSe69VHc1+TSY5ZOZA=;
        b=i4G7IFsPw5+tanRUneUMPdU5yjVChnebFbDPkAHNMZtxK9RmuLmy7REgcV8z8nyveV
         Iv8dcX5RatD63+9qE02c1AzgQYGiHkA2dlHQaCEyyhvS259LhHX8U9z0sgs9Tkh0rZPZ
         Sc8LdL1ftkLVaHVUkQLk6/whd50QV1ykhLr0xDpbeatxL0N7h47jb1xVHgY4BzbKNc81
         v+jQEkHHsc63w+DFxK50XWE/tefXND8bzP9JY12fbiheNmK3uD/bUHhVMWj/ZWzM4ti0
         cNkaaDEPbG7QAPMumj6JH9yCoEri2eepXM9l4DahXacC+uOderT8pB7Znx4Ys+vcreuI
         Jr6Q==
X-Forwarded-Encrypted: i=1; AHgh+RqOAOjD2lkiPOwA5wlBZD6CbkuN24oOq2BS02EQ5YtPsZ749vIN1K2e5J6o3fIUuQ7p5czXOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqvtO2JmwW0eK9qopU9eJLnOCghg44Eym6UCt/CGIrlO6Cmabw
	cR0kDO6N32nd8I7PrHSWTX7mvBi2keFEz7ix+zcK8zZGSKJkJbMMd9LUKAkze1I73l//gH1n6AE
	dKDMC/bLG8GiVKMeEtZYuUNO50nhsMwcQsLdjSgd2ZA==
X-Gm-Gg: AfdE7cnB+I+gxVx1PXpUkDgxs9Fsii98aBBEJh0MKGUEF81O8lqlNXveOB/7lllMT1Q
	QYW/At5s2Mm5thtPUUpGSWG56RIU5zYXyMKSF/ZCgJ+UW3ANFleUN7DpI4ceSSWR5Zjm//RlvOv
	gEXz7REWZupkCSYqlatBAK90teSXqeoTO5DGtDBgK9VMeiX9eEnKhWADgN7YiStgMBvbSH6Wews
	HPMoa0XrDO1WSLi7+y5jC4bgTOQp1ecwsFBPFXiXqeLg4kyTkKmZoSv5Ed4ukwX3qD15+P9ftEZ
	9ng9ig==
X-Received: by 2002:ac2:5933:0:b0:5b0:cce:da00 with SMTP id
 2adb3069b0e04-5b023568b5dmr1139987e87.1.1783931077230; Mon, 13 Jul 2026
 01:24:37 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 13 Jul 2026 01:24:36 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 13 Jul 2026 01:24:36 -0700
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
In-Reply-To: <CAJF2gTSFX87LTXbAB=Qzy33xTVuaFQdR3jxh96ZdOhehfy-=AQ@mail.gmail.com>
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260713060902.15161-1-zhangzhanpeng.jasper@bytedance.com> <CAJF2gTSFX87LTXbAB=Qzy33xTVuaFQdR3jxh96ZdOhehfy-=AQ@mail.gmail.com>
User-Agent: Mozilla Thunderbird
Date: Mon, 13 Jul 2026 01:24:36 -0700
X-Gm-Features: AUfX_mzZvU7oa1oZHbOWG75hXLtmVhHOW5g3WnTef66HzvZC6b2_d2Iu5DRMHDw
Message-ID: <CACnXVncuXtGNqv7NABFRcFQWwK7eyMSz=GQd6joVmskQ-fDLrg@mail.gmail.com>
Subject: Re: Re: [PATCH v2] iommu/riscv: Use 32-bit MMIO accesses for 64-bit registers
To: Guo Ren <guoren@kernel.org>
Cc: Tomasz Jeznach <tomasz.jeznach@linux.dev>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, David Laight <david.laight.linux@gmail.com>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Zong Li <zong.li@sifive.com>, cuiyunhui@bytedance.com, 
	yuanzhu@bytedance.com, iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guo,

On 7/13/26 3:00 PM, Guo Ren wrote:
> On Mon, Jul 13, 2026 at 2:09=E2=80=AFPM Zhanpeng Zhang
> <zhangzhanpeng.jasper@bytedance.com> wrote:
>>
>> The RISC-V IOMMU specification [1] permits 64-bit registers to be access=
ed
>> using two 32-bit transactions, high half first, and leaves the single-co=
py
>> atomicity of 8-byte IOMMU register accesses unspecified.
>>
>> Use the generic hi_lo_readq_relaxed() and hi_lo_writeq_relaxed() helpers
>> for ordinary 64-bit IOMMU registers. Poll DDTP.BUSY in the low half befo=
re
>> reading the full register from high to low. HPM counter reads require a
>> rollover-aware sequence and remain outside these accessors.
>>
>> This follows the 32-bit access direction proposed by Guo Ren [2] and use=
s
>> the generic non-atomic MMIO helpers suggested by David Laight.
>>
>> [1] https://docs.riscv.org/reference/iommu/
>> [2] https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel.org
>>
>> Suggested-by: Guo Ren <guoren@kernel.org>
>> Suggested-by: David Laight <david.laight.linux@gmail.com>
>> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
>> ---
>> Changes in v2:
>> - Rework the patch based on Guo Ren's earlier proposal [1].
>> - Drop the build-time option and use 32-bit accesses unconditionally.
>> - Drop the global lock and use the generic high-low MMIO helpers, as
>>    suggested by David Laight.
>> - Poll DDTP.BUSY through its low half before reading the full register.
>>
>> Link to v1: [2]
>> Specification discussion: [3]
>>
>> [1]: https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel.org
>> [2]: https://lore.kernel.org/r/20260615064855.90316-1-zhangzhanpeng.jasp=
er@bytedance.com
>> [3]: https://github.com/riscv-non-isa/riscv-iommu/issues/765
>>
>>   drivers/iommu/riscv/iommu.c | 18 +++++++++++-------
>>   drivers/iommu/riscv/iommu.h |  9 +++------
>>   2 files changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>> index cec3ddd7ab1..14b572058ed 100644
>> --- a/drivers/iommu/riscv/iommu.c
>> +++ b/drivers/iommu/riscv/iommu.c
>> @@ -668,12 +668,16 @@ void riscv_iommu_disable(struct riscv_iommu_device=
 *iommu)
>>          riscv_iommu_writel(iommu, RISCV_IOMMU_REG_PQCSR, 0);
>>   }
>>
>> -#define riscv_iommu_read_ddtp(iommu) ({ \
>> -       u64 ddtp; \
>> -       riscv_iommu_readq_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp, \
>> -                                 !(ddtp & RISCV_IOMMU_DDTP_BUSY), 10, \
>> -                                 RISCV_IOMMU_DDTP_TIMEOUT); \
>> -       ddtp; })
>> +static u64 riscv_iommu_read_ddtp(struct riscv_iommu_device *iommu)
>> +{
>> +       u32 ddtp_lo;
>> +
>> +       riscv_iommu_readl_timeout(iommu, RISCV_IOMMU_REG_DDTP, ddtp_lo,
>> +                                 !(ddtp_lo & RISCV_IOMMU_DDTP_BUSY), 10=
,
>> +                                 RISCV_IOMMU_DDTP_TIMEOUT);
>> +
>> +       return riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
> readq? Please ref [1]:
>
> #define riscv_iommu_read_ddtp(iommu) ({ \
>    u64 ddtp; \
> - riscv_iommu_readq_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp, \
> -  !(ddtp & RISCV_IOMMU_DDTP_BUSY), 10, \
> + u32 ddtp_lo, ddtp_hi; \
> + riscv_iommu_readl_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp_lo, \
> +  !(ddtp_lo & RISCV_IOMMU_DDTP_BUSY), 10, \
>     RISCV_IOMMU_DDTP_TIMEOUT); \
> + ddtp_hi =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_DDTP + 4); \
> + ddtp =3D ((u64)ddtp_hi << 32) | ddtp_lo; \
>    ddtp; })
>
Oops, thanks for catching that, it will re-read the low 32 bits. DDTP
must retain that polled low-half value, read only the high half, and
then compose the result.

The macro one [1] is correct, I've fixed it in v3.

>
>> +}
>>
>>   static int riscv_iommu_iodir_alloc(struct riscv_iommu_device *iommu)
>>   {
>> @@ -1501,7 +1505,7 @@ static int riscv_iommu_init_check(struct riscv_iom=
mu_device *iommu)
>>           * regular boot flow and disable translation when we boot into =
a kexec
>>           * kernel and the previous kernel left them enabled.
>>           */
>> -       ddtp =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
>> +       ddtp =3D riscv_iommu_read_ddtp(iommu);
>>          if (ddtp & RISCV_IOMMU_DDTP_BUSY)
>>                  return -EBUSY;
>>
>> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
>> index 46df79dd549..1b03790fbe1 100644
>> --- a/drivers/iommu/riscv/iommu.h
>> +++ b/drivers/iommu/riscv/iommu.h
>> @@ -11,6 +11,7 @@
>>   #ifndef _RISCV_IOMMU_H_
>>   #define _RISCV_IOMMU_H_
>>
>> +#include <linux/io-64-nonatomic-hi-lo.h>
>>   #include <linux/iommu.h>
>>   #include <linux/types.h>
>>   #include <linux/iopoll.h>
>> @@ -70,17 +71,13 @@ void riscv_iommu_disable(struct riscv_iommu_device *=
iommu);
>>          readl_relaxed((iommu)->reg + (addr))
>>
>>   #define riscv_iommu_readq(iommu, addr) \
>> -       readq_relaxed((iommu)->reg + (addr))
>> +       hi_lo_readq_relaxed((iommu)->reg + (addr))
>>
>>   #define riscv_iommu_writel(iommu, addr, val) \
>>          writel_relaxed((val), (iommu)->reg + (addr))
>>
>>   #define riscv_iommu_writeq(iommu, addr, val) \
>> -       writeq_relaxed((val), (iommu)->reg + (addr))
>> -
>> -#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, tim=
eout_us) \
>> -       readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, co=
nd, \
>> -                          delay_us, timeout_us)
>> +       hi_lo_writeq_relaxed((val), (iommu)->reg + (addr))
>>
>>   #define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
>>          readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, c=
ond, \
>> --
>> 2.50.1 (Apple Git-155)
>
>
>
Thanks,
Zhanpeng
