Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B38B262D12
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715125; cv=none; b=lxORDydqUiAl2bGbkIP3RiBOKhFaOQCYKpfOgIASXzHP0DXebNM0ijMn1a/1cX3D2OAbcEXQCoRiM2dKqnr3IfQbfzd2JYx6MxsopeDIT40pg24rfOZ7XNJV1FRoZReRjU8RmLPPKOIh2voySLh3uNo6xcpxRpzuOHMy95uocl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715125; c=relaxed/simple;
	bh=l0VXxLyHqQ03BojE4ii06LhUjI+hhzdC8CIFLnCEcf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3YsAqbruoYMJy8yOrClZ7MtpUo2dAPKyTNwV8UeeB6Pn7VY3X+OLBaCfZCuWnax7SakDvlj85sr5N/Q1RK5SFRH/xVHqoGik9riO9aDPm5K0vFvMjlKxQtORbFFiAvSawNBf13Gff4bG702HD4vfdxpWHJoj3A6/Dho+IGtg4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ct/+PXwv; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct/+PXwv"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bf1d48843so48436761fa.2
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 10:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715121; x=1742319921; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asnNU19ygcsN2CKrHdfOexyM1HK98rMZqPH+Eazq5VA=;
        b=ct/+PXwvY0e0OTLvOHAZPcShom9Vw57t6b39pTteA8Kwr7n3D69DAT1SGOWdkH8tTh
         iYieyFE428a1WeUtPhWLkmhZubUUpMkNHBJ+8A24wH4ntX4ZgqyVvW3SGkfEcYe+qEMk
         4C3jf1ww7/JH0Q2t2cWQLIBhJb0AjVkr1LRmHW3mnrxkwX0i5WiQDQV8EkTQA8EgRqWo
         yIIUmkjtDDNCu2yxipOcK4pLwcN2Jjg1qy7ckcgNVXX0+3wT47MyUujTF8CMPs0bFM6J
         77W90CgbBeLGmURXXQu6ChCvB8DUe8boiiThgC/3YB93bzhFaDBqHL++7MUZ5gTfsEUZ
         Zgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715121; x=1742319921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asnNU19ygcsN2CKrHdfOexyM1HK98rMZqPH+Eazq5VA=;
        b=gddI1KGhpfnBdDKBG2b4BY7ZoU3f199WE0XRDQKGufSBjpbQ4X/thuRbE/ratf5N/A
         xd6jr+Vu3SjsJnbG+fFkssWbmme887ZVpaRJ6uJ7ml7faeNs2WnSazGnfFtDq7R82Grs
         GclmZIVZqr9fZjxUmMv9AufnMjbeZmrKt8gLWn0pWqkU05ESILDX/T5CghbKrs1Py4DI
         Usl5uNeB5S1W70t5IKveafIOX4d82MzBlj1n+boS2DVlLumLjM8dSEHQih8f98AdO5Vf
         D/SwYQXwbeP5q7Vi/tcywPzy4R+kTrmjLW0YPetcjN1rremtkbVAHw5uH2b56oTgayzb
         nvGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY4wCcve1jDlE7EEdK6NoRMJwpBHGyaGnIgQfbX/vRl8CASXdGOz7o7Lo8bJiAc0ii6Ge08Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSNbqHE2iseO0dXd4xdGbn4OVNMSbWY92YUnmGZmvqrudrcrZc
	y2eHUY7pioU4AzyVTusmfiUjQ8del9Mj2psy2VYz/SZOZySp5qYk
X-Gm-Gg: ASbGnct7a56cA4kx4SEYPF8KDNWamHF2xiwX0mqqhibTzqgAAG+sSdfIR+1X7U0islf
	7VukrmGlJHd3xMpyX7IMdLgmV3mBSbksfdum37f/4tET9fzfHgRKh3NubZqjhxXCRbLYGQQ3hFa
	JhyeEC5js/WlK8iLIrBIhbPZeFrvy5jXmBCLGRbuJYmL3rg+wyElPI8jQmCTwTkNGOqS2udrFtI
	kFcrOuIgQksu+e1KhzygbTfDfGCdC+qxv6UQxs023bzTKdKbi4rMO7RJWEIGVlY9NeukiVG03i3
	AemPbdmp+nj4Kor3bSyYp88MQ5u1mYYFeeHgClTQXrNPjEiHshrJu+3TRweKvmSPLq3fkxJy5p9
	4QgVeXJkNLI6X3qn0ff1lnA==
X-Google-Smtp-Source: AGHT+IFxj2Dayu+wbOQKzrV5wxiY2G9Z04wHC3RtTdBJTzM8av5dhGJypQXyOqhWF4kFSnReXrQF/w==
X-Received: by 2002:a2e:bc27:0:b0:30b:b184:a904 with SMTP id 38308e7fff4ca-30bf44edde3mr71880861fa.4.1741715120287;
        Tue, 11 Mar 2025 10:45:20 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c011d2830sm14276651fa.80.2025.03.11.10.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 10:45:19 -0700 (PDT)
Message-ID: <902d6f21-a6c9-4776-9e55-26f089acd0da@gmail.com>
Date: Tue, 11 Mar 2025 19:45:18 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 4/7] rust: device: add dma addressing capabilities
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
 dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com, iommu@lists.linux.dev
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
 <nxaaNW1XIbhf7dSf8aRLVF5Se-0maF6BhX8GaUXlsOL-QOste8OMQxtmhYe_BYI6FYFEMeHEzy1s4OEy7PdGKw==@protonmail.internalid>
 <20250307110821.1703422-5-abdiel.janulgue@gmail.com>
 <877c5038i1.fsf@kernel.org>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <877c5038i1.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 07/03/2025 22:12, Andreas Hindborg wrote:
> "Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:
> 
>> Add functions to set the DMA mask to inform the kernel about the
>> device's DMA addressing capabilities.
>>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>> ---
>>   rust/helpers/dma.c     |  8 ++++++++
>>   rust/helpers/helpers.c |  1 +
>>   rust/kernel/device.rs  | 29 +++++++++++++++++++++++++++++
>>   3 files changed, 38 insertions(+)
>>   create mode 100644 rust/helpers/dma.c
>>
>> diff --git a/rust/helpers/dma.c b/rust/helpers/dma.c
>> new file mode 100644
>> index 000000000000..8eb482386f93
>> --- /dev/null
>> +++ b/rust/helpers/dma.c
>> @@ -0,0 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/dma-mapping.h>
>> +
>> +int rust_helper_dma_set_mask_and_coherent(struct device *dev, u64 mask)
>> +{
>> +	return dma_set_mask_and_coherent(dev, mask);
>> +}
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
>> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
>> index db2d9658ba47..f9d3d4f60ddb 100644
>> --- a/rust/kernel/device.rs
>> +++ b/rust/kernel/device.rs
>> @@ -6,10 +6,12 @@
>>
>>   use crate::{
>>       bindings,
>> +    error::Result,
>>       str::CStr,
>>       types::{ARef, Opaque},
>>   };
>>   use core::{fmt, ptr};
>> +use kernel::prelude::*;
>>
>>   #[cfg(CONFIG_PRINTK)]
>>   use crate::c_str;
>> @@ -187,6 +189,33 @@ pub fn property_present(&self, name: &CStr) -> bool {
>>           // SAFETY: By the invariant of `CStr`, `name` is null-terminated.
>>           unsafe { bindings::device_property_present(self.as_raw().cast_const(), name.as_char_ptr()) }
>>       }
>> +
>> +    /// Inform the kernel about the device's DMA addressing capabilities.
>> +    ///
>> +    /// Set both the DMA mask and the coherent DMA mask to the same thing.
>> +    /// Note that we don't check the return value from the C `dma_set_coherent_mask`
>> +    /// as the DMA API guarantees that the coherent DMA mask can be set to
>> +    /// the same or smaller than the streaming DMA mask.
>> +    pub fn dma_set_mask_and_coherent(&mut self, mask: u64) -> Result {
>> +        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
>> +        let ret = unsafe { bindings::dma_set_mask_and_coherent(self.as_raw(), mask) };
>> +        if ret != 0 {
>> +            Err(Error::from_errno(ret))
>> +        } else {
>> +            Ok(())
>> +        }
>> +    }
> 
> I think we can use `Error::from_errno` here (and below). As far as I can
> tell, these C functions return negative on error.

This already uses `Error::from_errno`?

Thanks!

> 
>> +
>> +    /// Same as [`dma_set_mask_and_coherent`], but set the mask only for streaming mappings.
>> +    pub fn dma_set_mask(&mut self, mask: u64) -> Result {
>> +        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
>> +        let ret = unsafe { bindings::dma_set_mask(self.as_raw(), mask) };
>> +        if ret != 0 {
>> +            Err(Error::from_errno(ret))
>> +        } else {
>> +            Ok(())
>> +        }
>> +    }
>>   }
>>
>>   // SAFETY: Instances of `Device` are always reference-counted.
> 
> 
> Best regards,
> Andreas Hindborg
> 
> 

