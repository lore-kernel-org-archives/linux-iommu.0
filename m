Received: from va-2-37.ptr.blmpb.com (va-2-37.ptr.blmpb.com [209.127.231.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FC486341
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 02:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610706; cv=none; b=qvPJGlaPuYl5FBgkYy1m2CrX091w4J52QM1/dznEt58w5C1lunw5Zxmc4u7hMTW7YwHNvDE4/pTsiWF/8dNBLl+F/GVFLpwkYad/GtzOMVDWz4g2U50Ow3WIZoOtmwAX2/ot7D9itMDd5hO6PxxE6X87EojMShUQKNRNJNNqDmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610706; c=relaxed/simple;
	bh=Sxo18wVPwpf/v7g9jFtkgFrSGUWSgHhvfTGebiRsIiw=;
	h=Subject:To:From:Message-Id:References:Cc:Date:Mime-Version:
	 Content-Type:In-Reply-To; b=cwC1fISuh6VjfC8plTlzfehz5U9UO0q7aofBuol6OF0qRCVX32pxOYkxBAqqmYT5PzhUg9f4taN59+CW2OE5Z5KSglwW44x4IgfGKwG4byLEiRo/sRsFC6/aPf4D4gFayjEmvbjyNMjQwtYstNvpFrJVjaPdqWcR0ZtLTE8NFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=mTqXAqnW; arc=none smtp.client-ip=209.127.231.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="mTqXAqnW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1789610690;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=MDsxntRODNgCNG5JeXxth+hLjZlO+v0hDLmbatGO5VY=;
 b=mTqXAqnWaPFcsNiK+cyRsvkef7ovWgv/a91kjHhwtxxi0rz3WkmSgPKAb9tPxHu4cvsg7l
 WPqFKWE/8rrtTXoJZ5FGUQ362TxDT/psZkJIsZAKOPWWFGkRbrWYHDAQdmQ+m3jhw7Tac5
 V/UNueXEyE6eo7zK849y6ndNjtaInWuCCW7TqHQj4/ttpXgOdl33IsGTJtehb2FhwIPSUK
 gETRKnwLg048G5crunUBk+XxN/Lnl7dBwwPNDK1oHRgQ+gnEW+et2Ww+ZjQIziI9UKsYCj
 eFIeEizEg48VTZFN0XvxwJ2KlPenZi2TBoPJF8d88unoRFxVZ8eySU+wuSuTtA==
Subject: Re: [PATCH] riscv: iommu: ask for ACS to be enabled
Content-Transfer-Encoding: quoted-printable
To: <sunilvl@oss.qualcomm.com>
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Message-Id: <9d469f95-73b4-4a0a-9c35-80a655a53225@lanxincomputing.com>
User-Agent: Mozilla Thunderbird
References: <20260916112545.887461-1-xiangwencheng@lanxincomputing.com> <CAB19ukHfFXmuPEaWdNPvFRkvMGpDQfVEpCHfqsHL20tpBytQRA@mail.gmail.com>
Cc: <sunilvl@ventanamicro.com>, <rafael@kernel.org>, <lenb@kernel.org>, 
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, 
	<alex@ghiti.fr>, <linux-acpi@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<iommu@lists.linux.dev>, <tjeznach@rivosinc.com>, 
	<luxu.kernel@bytedance.com>, <guoren@linux.alibaba.com>, 
	<jgg@nvidia.com>
Received: from [127.0.0.1] ([123.120.5.129]) by smtp.feishu.cn with ESMTPS; Thu, 17 Sep 2026 10:04:37 +0800
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
Content-Language: en-US
Date: Thu, 17 Sep 2026 10:04:34 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAB19ukHfFXmuPEaWdNPvFRkvMGpDQfVEpCHfqsHL20tpBytQRA@mail.gmail.com>
X-Lms-Return-Path: <lba+26aab4ab7+d8b7ea+lists.linux.dev+xiangwencheng@lanxincomputing.com>

On 9/16/2026 8:18 PM, Sunil V L wrote:
> On Wed, Sep 16, 2026 at 5:15=E2=80=AFPM BillXiang
> <xiangwencheng@lanxincomputing.com> wrote:
>>
>> Make sure ACS will be enabled during PCI probe
>>
>> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
>> ---
>>   drivers/acpi/riscv/rimt.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
>> index e4538fa6c2c8..30d2d0211d5e 100644
>> --- a/drivers/acpi/riscv/rimt.c
>> +++ b/drivers/acpi/riscv/rimt.c
>> @@ -525,4 +525,5 @@ void __init riscv_acpi_rimt_init(void)
>>
>>                  return;
>>          }
>> +       pci_request_acs();
>>   }
>>
> There is already a patch in the mailing list for this.
>=20
> https://lkml.org/lkml/2026/9/3/1930
>=20
> Thanks,
> Sunil

Thank you for pointing that out. Please just ignore my commit.

--
BillXiang
