Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA41FDE3A
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078742; cv=none; b=KNBqX11kkN9MFBAz8nwIJ1NkvgqCn/EL0gfVd9/KEpnplLkxoT+Or6VYoj5Iar2vBg/shfkxXLCRUzCgREzM9jvpBa+xa+7wF6XKZZJLDMkLujI3CJU8v0+wexH0YgobATpUpI+Eo7T9zcmMP9KjzWeRN4vik/RGw+RVQrGF2lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078742; c=relaxed/simple;
	bh=GRs8DmVV8Q0Rqg68kkllhDnXL0SPxEdTvmczIygoWyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zj0vcuCBbTFDU6r5ncXgy00Whcd1wOodwuCnaGtT1APLiKjqxgA8V+TYH+tK25UxMYrIwGfzsjBpJ5II8LBQl7waN20c9Iwaq74hKoNJtlRRlff016J4DerjJUy15pOdUtx3DgAPPgrgt9fLvpvaDjI9qUCVcskSJaSQzT50H2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnlnSC47; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnlnSC47"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bb184ab24so21645131fa.0
        for <iommu@lists.linux.dev>; Tue, 04 Mar 2025 00:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741078739; x=1741683539; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IpLvosOPTODge75ZhJwO92ZOn1A2PUQkW7JVgLvP6v8=;
        b=lnlnSC47iScGrHp4IzGDncUznn8rizEmDhqP3AP+PRtQVnEzAlLqxWguwn56UkpF73
         uISIs8vm9dfD7LhpNKfWoc7OMAinRJe6WudyiytRFp862V9vxWGnTJ1uUcyMaEjoFdxL
         dYZx74MZuUGFACoWmzTOack7hE5KTSwAf93InO0/+n8Rv7kCzCfIje9UUXmEg4SShPOI
         fz/ot/no28gGcAzgWAj24/XsE3+a7SXtRPux1Ycr9FkoxBqUaNJSQN+cwMpfV37Nq+MZ
         xGhdOEMHVyaR6DvIIvbTrH8GqGfS0U+NKCr2MCg+GKr86MmMRp24+1wtLLl8akWp+wAT
         A+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741078739; x=1741683539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpLvosOPTODge75ZhJwO92ZOn1A2PUQkW7JVgLvP6v8=;
        b=gRhXEqlCIjzrJBhD2F/vEZ2xCHupVLA6XPS98kyhoQDvoJCmd7XQsZZXDb3meW+lal
         0wVJwXhnkAjvGN28IIowel2/FAX/dE25Qqs0fZPMkRk7hq8e7oXtODLYId1z7kXf2/2g
         WByHS9eb/dD9J8zLF/VSUS6SaDN7dPFV+Ox2DP7o1xFsTuOnyjip+CeKySwWCxHI9MIq
         n4C/e4NgVP7Ekmm4pPiSmGE/43kLGq/G+6LIBBUhLW7MXoSYOQkiwXOr4yeP2yZGD8wI
         6r+qFhHj4mrYjlYcSlc9PzdAs6YOmjxR0yIGEjVvfkvbFzbmqEslR8XUsWnjHm0r8AqL
         0rFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbAzgDvasGKcawCvq9oDCtZveZeJk9vHXba07OTM69tO9ZMJBssE6Jluqr4E6hSptEXiRxuw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7v7Q7BgaxmUUcRBBmU01KC9d6w+jKAYqZpm/jj58e/NnWLCoM
	ptL2aN4qpxgoezjF9/9rLgtglRf9VzR2ZgNoxuEhOePF3kh2m/cm
X-Gm-Gg: ASbGncsigBMso7StDFgAI8jHsTEfDckp3XJMS+c+E6PCR5YijeWBZaPT2KsR+n34v6V
	AehFD25O+wz2cP/q1IggJJbJDQiL4ylsthYG9tPnjl/zbmc2ljo4Az4G902JNHCflvbOmOWJklm
	pXreIlEqupyotFm+hn2xh5eHWMgdk7DJfRyjtML2EnrK7uX2dweBVPjTi1BaSireTCtUIeNem07
	pndornr8fCek/4wpwDLafEmWwxs9vK9EoO5C8Ib6RAdhOzd3VMBPwvTyG9cy0Y3p6N80NesXHRy
	3Fqih0uVx3oScDTAwkGx5n7pgmti7A+/AXeDWU/qLjBqnc80MAdBr5Uwbp3ixdA7rzPP7YlkT+q
	H3FfWYMlqCy+3micmkwM+5g==
X-Google-Smtp-Source: AGHT+IFMgqZCbWR5mRoy9EQCtE3Z96nLi59uYRRUqwLOmodMoMI3drMHKTbl7nN9ffI6EtqpyEJVAQ==
X-Received: by 2002:a05:651c:210c:b0:30b:c36c:ba9f with SMTP id 38308e7fff4ca-30bc36cbd5dmr20830681fa.14.1741078738757;
        Tue, 04 Mar 2025 00:58:58 -0800 (PST)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bc1b1c4fasm4745901fa.18.2025.03.04.00.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 00:58:57 -0800 (PST)
Message-ID: <80f31377-f897-4881-b294-87f13f75acd4@gmail.com>
Date: Tue, 4 Mar 2025 10:58:56 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: aliceryhl@google.com, dakr@kernel.org, robin.murphy@arm.com,
 daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com, iommu@lists.linux.dev
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <k3GMnfXzzvUVOgSnuMlEq3eVRyq1qjcf_tDtILRbOwj08EIQpwQ4bGtGhwWufr8lUn-VlHnNjP8FxIA48Jv-Ug==@protonmail.internalid>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <87h64al5c6.fsf@kernel.org>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <87h64al5c6.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/03/2025 13:30, Andreas Hindborg wrote:
> "Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:
> 
>> Add a simple dma coherent allocator rust abstraction. Based on
>> Andreas Hindborg's dma abstractions from the rnvme driver, which
>> was also based on earlier work by Wedson Almeida Filho.
>>
>> Nacked-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> [...]
> 
>> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
>> index 0640b7e115be..8f3808c8b7fe 100644
>> --- a/rust/helpers/helpers.c
>> +++ b/rust/helpers/helpers.c
>> @@ -13,6 +13,7 @@
>>   #include "build_bug.c"
>>   #include "cred.c"
>>   #include "device.c"
>> +#include "dma.c"
>>   #include "err.c"
>>   #include "fs.c"
>>   #include "io.c"
>> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
>> new file mode 100644
>> index 000000000000..b4dd5d411711
>> --- /dev/null
>> +++ b/rust/kernel/dma.rs
>> @@ -0,0 +1,421 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Direct memory access (DMA).
>> +//!
>> +//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
>> +
>> +use crate::{
>> +    bindings, build_assert,
>> +    device::Device,
>> +    error::code::*,
>> +    error::Result,
>> +    transmute::{AsBytes, FromBytes},
>> +    types::ARef,
>> +};
>> +
>> +/// Inform the kernel about the device's DMA addressing capabilities. This will set the mask for
>> +/// both streaming and coherent APIs together.
>> +pub fn dma_set_mask_and_coherent(dev: &Device, mask: u64) -> i32 {
>> +    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
>> +    unsafe { bindings::dma_set_mask_and_coherent(dev.as_raw(), mask) }
>> +}
>> +
>> +/// Same as `dma_set_mask_and_coherent`, but set the mask only for streaming mappings.
>> +pub fn dma_set_mask(dev: &Device, mask: u64) -> i32 {
>> +    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
>> +    unsafe { bindings::dma_set_mask(dev.as_raw(), mask) }
>> +}
> 
> I'm rebasing some of the dma pool code I'm using for NVMe on top of
> these patches, and I notice that these methods in the original code from
> way back (besides being on Device) has these methods return `Result`:
> 
>      pub fn dma_set_mask(&self, mask: u64) -> Result {
>          let dev = self.as_raw();
>          let ret = unsafe { bindings::dma_set_mask(dev as _, mask) };
>          if ret != 0 {
>              Err(Error::from_errno(ret))
>          } else {
>              Ok(())
>          }
>      }
> 
> Is there a reason for not returning a `Result` in this series?
> 

Hi Andreas, the original dma_set_mask function got lost to me for some 
reason. But yes, this is indeed a better approach!

Regards,
Abdiel


