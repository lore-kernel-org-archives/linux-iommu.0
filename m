Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285B3B8922
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 07:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013056; cv=none; b=RnJZxHtB+y+4vnUx68UZzgUhYoB7W7oHRLbXu5w1gkMaEav0lL6qx2kjL1I1XqJl9m2orOdj1aqwm0tGnmND0MMxyUyY1n661rK94x5+kOcd4+rriy/xB/WbfqIgmNLD/xpUMcwejk0Uk4k/pSuMP9wiWQ+D0+4HzbyIs/eoPXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013056; c=relaxed/simple;
	bh=uuTUDEDbrIKMlFUB+o1Cn+3voXEtlwTET15d4qQect0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4Dn6SJNYVdJvNJiy+iz0WuPWWdE7Eg58Sini90XJWEAIYGS41fNCEUhfYyhxkVhEZDh6dwOgPvyFz+uCslgP7wGPf/P57DiSHWCel420aia8ulBEEBYln7Cv0e0J5d2JcL+uylgSUou2KXOEbUHQVYdMO3yq1ZQmtdtKz9umQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PupI7Qp0; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PupI7Qp0"
Message-ID: <2226176d-73fd-4def-b80e-89f03bade03e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784013051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GT3rIxG28NqGYqoctwKe35C7wW+IlZnhyXvJ39odNJY=;
	b=PupI7Qp0/erKaMYoqQzSiSrA843/pulTK0kaFAOKUS+a12uVrEhK1PHaNfL43H+b557ENd
	zAFzpBcvFbrWlokT1FABUJkn9qNNx2VMSsrNdM3mHB165AbKOPFft1SKpCTuoHbJjvKhgr
	eINoMgzjbQbGJ02gSPeRjhB+5R6dHho=
Date: Tue, 14 Jul 2026 09:10:28 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v3] iommu/riscv: Use 32-bit MMIO accesses for 64-bit
 registers
To: Guo Ren <guoren@kernel.org>,
 Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, David Laight
 <david.laight.linux@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>,
 Zong Li <zong.li@sifive.com>, cuiyunhui@bytedance.com,
 yuanzhu@bytedance.com, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260713122903.9458-1-zhangzhanpeng.jasper@bytedance.com>
 <CAJF2gTRsE=sHeK+qHdSp5_mAZF_=3JYOg3O7uZqUtXLUte+y8g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tomasz Jeznach <tomasz.jeznach@linux.dev>
In-Reply-To: <CAJF2gTRsE=sHeK+qHdSp5_mAZF_=3JYOg3O7uZqUtXLUte+y8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/13/26 7:02 PM, Guo Ren wrote:
> LGTM!
>
> Reviewed-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> Co-developed-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
>
> On Mon, Jul 13, 2026 at 8:29 PM Zhanpeng Zhang
> <zhangzhanpeng.jasper@bytedance.com> wrote:
>> The RISC-V IOMMU specification [1] permits 64-bit registers to be accessed
>> using two 32-bit transactions, high half first, and leaves the single-copy
>> atomicity of 8-byte IOMMU register accesses unspecified.
>>
>> Use the generic hi_lo_readq_relaxed() and hi_lo_writeq_relaxed() helpers
>> for ordinary 64-bit IOMMU registers. For DDTP, poll BUSY in the low half,
>> then read the high half and compose the register value from the polled low
>> half. HPM counter reads require a rollover-aware sequence and remain
>> outside these accessors.
>>
>> This follows the 32-bit access direction proposed by Guo Ren [2] and uses
>> the generic non-atomic MMIO helpers suggested by David Laight.
>>
>> [1] https://docs.riscv.org/reference/iommu/
>> [2] https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel.org
>>
>> Suggested-by: Guo Ren <guoren@kernel.org>
>> Suggested-by: David Laight <david.laight.linux@gmail.com>
>> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
>> ---
>> Changes in v3:
>> - Use the DDTP access sequence from [1]: retain the low half returned by
>>    BUSY polling, read only the high half, and compose the DDTP value from
>>    those two 32-bit reads.
>>
>> Changes in v2:
>> - Rework the patch based on Guo Ren's earlier proposal [1].
>> - Drop the build-time option and use 32-bit accesses unconditionally.
>> - Drop the global lock and use the generic high-low MMIO helpers, as
>>    suggested by David Laight.
>> - Poll DDTP.BUSY through its low half.
>>
>> Link to v1: [2]
>> Specification discussion: [3]
>>
>> [1]: https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel.org
>> [2]: https://lore.kernel.org/r/20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com
>> [3]: https://github.com/riscv-non-isa/riscv-iommu/issues/765
>>
>>   drivers/iommu/riscv/iommu.c | 9 ++++++---
>>   drivers/iommu/riscv/iommu.h | 9 +++------
>>   2 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>> index cec3ddd7ab1..d647b71ebec 100644
>> --- a/drivers/iommu/riscv/iommu.c
>> +++ b/drivers/iommu/riscv/iommu.c
>> @@ -670,9 +670,12 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu)
>>
>>   #define riscv_iommu_read_ddtp(iommu) ({ \
>>          u64 ddtp; \
>> -       riscv_iommu_readq_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp, \
>> -                                 !(ddtp & RISCV_IOMMU_DDTP_BUSY), 10, \
>> +       u32 ddtp_lo, ddtp_hi; \
>> +       riscv_iommu_readl_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp_lo, \
>> +                                 !(ddtp_lo & RISCV_IOMMU_DDTP_BUSY), 10, \
>>                                    RISCV_IOMMU_DDTP_TIMEOUT); \
>> +       ddtp_hi = riscv_iommu_readl((iommu), RISCV_IOMMU_REG_DDTP + 4); \
>> +       ddtp = ((u64)ddtp_hi << 32) | ddtp_lo; \
>>          ddtp; })
>>
>>   static int riscv_iommu_iodir_alloc(struct riscv_iommu_device *iommu)
>> @@ -1501,7 +1504,7 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
>>           * regular boot flow and disable translation when we boot into a kexec
>>           * kernel and the previous kernel left them enabled.
>>           */
>> -       ddtp = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
>> +       ddtp = riscv_iommu_read_ddtp(iommu);
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
>> @@ -70,17 +71,13 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu);
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
>> -#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
>> -       readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, cond, \
>> -                          delay_us, timeout_us)
>> +       hi_lo_writeq_relaxed((val), (iommu)->reg + (addr))
>>
>>   #define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
>>          readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
>> --
>> 2.50.1 (Apple Git-155)

Thank you for this change. Sorry for being late on the discussion. LGTM

Reviewed-by: Tomasz Jeznach <tomasz.jeznach@linux.dev>

Best,
- Tomasz


