Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD6C3909B8
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428032; cv=none; b=ML5nhpLvZJUBzkPlnmiXCIvzFMwmDRcY3eFdFuDU8NCjBVWZRIIrOizm3ma/1fRSZkLk3qAiFaH2kCwv3p3Ihv9ajmMVvlHWjeEaZIfmHZLW8czVo1QM52JPirJnfkJAo1koOiwNtXjgyzLOfAxelyu6h0C4z9FrakPMeIZviMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428032; c=relaxed/simple;
	bh=Fwe9A2F4ce1V8se4ofrmXlCPqaQ1ErESwoHSJzzJAI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCdTPnLJe4Thh7pWcTy76DN5grJ71m3aGpCrwE7B7aKRh5L2s485RJfxQuw4RMNkRFlWIPlC7tcjM0MYqHXFN+SHhj3IRNQivnPwyQOT4hg2DM3WgPxZywy3SRjm8yJ9tAFPMfJbEUpo1LyMrS5HJQPswRDU1tkGhl/XQ/ADSOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Zf4Tdsui; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Zf4Tdsui"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8644F20B7167;
	Tue,  2 Jun 2026 12:20:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8644F20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780428014;
	bh=GtEdPMddYvUUSkxNI69UEpAyRWJR7CHrB3WyTxhx0+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zf4Tdsui7EBsCc49cp7VQRY0VZW3oaRl79YvdEORVRgMs9CyLAFKElC2gEufRHfTa
	 AQQgrVrfNLydpCPtuYuTMZMOtw3waPhtJsDhjELtAi2xbFvddh/gBEmxTF2q3aZ6bg
	 xEQC2tzKHuZOecS/NkYrMaB+i5fIaOn3WJjMQFHw=
Message-ID: <1ca3f050-bcda-00e3-23be-0172a48c3257@linux.microsoft.com>
Date: Tue, 2 Jun 2026 12:20:27 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V1] iommu/hyperv: Create hyperv subdirectory under
 drivers/iommu
Content-Language: en-US
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 mhklinux@outlook.com, wei.liu@kernel.org, zhangyu1@linux.microsoft.com,
 schakrabarti@linux.microsoft.com
References: <20260529014148.297154-1-mrathor@linux.microsoft.com>
 <20260601090735.00005f55@linux.microsoft.com>
 <99bc22c3-0fa9-044d-071c-53cc8c2b7548@linux.microsoft.com>
 <20260601214514.00003833@linux.microsoft.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260601214514.00003833@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/1/26 21:45, Jacob Pan wrote:
> Hi Mukesh,
> 
> On Mon, 1 Jun 2026 14:23:18 -0700
> Mukesh R <mrathor@linux.microsoft.com> wrote:
> 
>>>> diff --git a/drivers/iommu/hyperv/Makefile
>>>> b/drivers/iommu/hyperv/Makefile new file mode 100644
>>>> index 000000000000..0053e00e08e6
>>>> --- /dev/null
>>>> +++ b/drivers/iommu/hyperv/Makefile
>>>> @@ -0,0 +1,2 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +obj-$(CONFIG_IRQ_REMAP) += hv-irq-remap.o
>>> Should the name be x86 specific? This file will never be built for
>>> ARM because:
>>>    CONFIG_IRQ_REMAP depends on:
>>>    depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
>>>
>>> perhaps, hv-x86-irq-remap.c? hv-irq-remap.c sounds like a
>>> generic Hyper-V IRQ-remapping backend and may be misleading once
>>> arm64 Hyper-V IOMMU/interrupt support grows under this directory.
>>
>> we could, but looking at early version of hyperv-iommu-arm.c, it looks
>> very similar, and so if there are very few ifdefs, we could just
>> keep one file rather than replicating bunch of code.
> 
> With this patch as is, how could you keep one file for both ARM and X86
> where hv-irq-remap.c does not build on ARM?

We can remove the x86 restriction, make sure it builds on arm. Then
during arm patch, I can help decide whether to fork or just add ifdefs
in the file. I'll submit V2 with x86 restriction removed.

Thanks,
-Mukesh

