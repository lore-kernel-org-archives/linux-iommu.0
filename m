Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC0C20DD79
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742323371; cv=none; b=oleTW2nS1ARYNZulEUXaRkDySICZPVoLvzQAMJttfvTknK0+gy6yYf+9LwLNrGiYVVyr7VCaDiK9yLaG+QEzNpACv2tv8Z81CKW7vCwUf0BQ9aejUQ96oHgzmvB3EM2sbiLQ0xTzRqv7nsPUpITMPfmGdlxIreAUYydptzcuKSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742323371; c=relaxed/simple;
	bh=KT6mPg+Y1JtXH5YBFh2c2ejWXnZICH3D6X2YnV2mw2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WN6KEasiPmY0oWEXMJZl+kQr5uefUn8Y7C5lWJPPZaRj1nV2EVDydwRJ37Hgcoacfu+qgEAsEgOEegYUn3XExUSATm4dOUvEzv13DhRQ7pobajTeE7U7Askxa6cqoZH0sUFqA+iohE6pM3fgJKk4i2a1td7mbzYb2LF+st47lg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBnkSxqp; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBnkSxqp"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54996d30bfbso5408892e87.2
        for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 11:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742323363; x=1742928163; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOZgoX2iJQX4V6wby9ytPUcVpVhdLhvcjz550it+cic=;
        b=fBnkSxqpHTND3/+2Yv40o/HFJrL00qIeDybJavioIAeI/UVbyhetX6naZhLA3ucufi
         z79y8ckVfzqcqJ8PVKGdpt9CKwBCGKuut4s8quQnyzQSwGLa80ogOIdF9EvTrTWfqf+A
         PxQQqEIBDZUIyFH50e53UopHU8Ia6G8jiLgU/ei/kSuCDUUjsnVXqENre335qYN0vz9a
         gEDqapli5TIsFlMZUwBwFgByanwK25JONHctELtA9+qevSSYSfhd24/V+jrtPjQ39Rh6
         nI3XbOJPRkrcvcAjhyxGEiYo3O0bnWF9Em1BG1rlzW5WqtrpflAQxS4zBk5aKiyM6/lu
         hwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742323363; x=1742928163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOZgoX2iJQX4V6wby9ytPUcVpVhdLhvcjz550it+cic=;
        b=rIjjLpND1TFmja6cCcelx7wel2PibGykNKr9EalooS58znCXwrFZrgL2HYPcDHJ36r
         gGxSA/fS7HyK697Uv7sIErvrJpyZesDyho9rTn6NVW82Myr6OCyZGzNL/XBKloZ4n3t2
         AtTqP6+0s1ckCUa+ChIk26TV3H2lIMx1OS2YS1wdSXx0x6iCEczNIwOfYUNbf6KbK+80
         jYVPbsNN/okMSnrtTpLuOg8tJYAOWBFSseaZQcqpjv8AK//SamNkwFZJiGlEcYJlupcb
         9GMOqsXkmqt7LOwwO1TkNaUKfr2ECSwWRBWmAlxHLA8yT15fKyLkfHwb27aiC9FZk3rS
         Jp7g==
X-Forwarded-Encrypted: i=1; AJvYcCXq5upLo4T+mJBzRXa+JCQauj2r06ZFQ3e5JEPLMt8bGTaZrM0ndyiCK2XXIQrnRLEWCRNiYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwDwoshjyKhlGqwN/jIrf/Nk7XH+9700jRo/YBdT5GUOeOsdKl
	cwRTk1Q4NduJ3g3YuWsb0s7cA4j3e1kQBdqkuZ32X85wpey7Deu6
X-Gm-Gg: ASbGncsEjgwmvNt9KOdXXlvtUDPDyVDU4DSfyldrhqeric+gkooHwKjIpTVExm987xQ
	fLiRhtlJCeeaEQQoO2TkyqnPsFONwe/BbiAnfkt6kH4fZ9fBBv9aHS4Vadi92Edg20kikWudT5/
	OuIp2zEJ4S+1w543NtMiGEwfgKWfeFWaD1/n9ELB1oeWmABw1pvhRK+/F4ufzIylTFeZauzTJir
	ykhdYEXReK5+WuOHTp0VhyS3CPzyJVto9hdaV0JHSzXpLt29+L3wYx3QcDf5kd2BC9LiYUodWPs
	QKFCX66vzYB+sx6VbJySaverNdcytcNbzuTZpJOo5FQ6kpVkc/x7gdBBHeCgBxWkLa8unhqVlpB
	umQAp7hLYwXHES5rdjj+AQw==
X-Google-Smtp-Source: AGHT+IFfEyMAaLVB0aN9PjwmSGEU1r94RjANWvSfnn5QdYYbJjD+AEhkRe5qJQAshjNjQqNlY2c+gg==
X-Received: by 2002:a05:6512:3d09:b0:549:7145:5d24 with SMTP id 2adb3069b0e04-54ac9cc6d21mr45966e87.46.1742323363064;
        Tue, 18 Mar 2025 11:42:43 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8893efsm1743184e87.210.2025.03.18.11.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 11:42:41 -0700 (PDT)
Message-ID: <03902487-5cd3-45ed-b3cb-cabfd0ac5cb7@gmail.com>
Date: Tue, 18 Mar 2025 20:42:39 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/11] samples: rust: add Rust dma test sample driver
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
 dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
 <20250311174930.2348813-4-abdiel.janulgue@gmail.com>
 <87frjajwq2.fsf@kernel.org>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <87frjajwq2.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 18/03/2025 15:26, Andreas Hindborg wrote:
> Abdiel Janulgue <abdiel.janulgue@gmail.com> writes:
> 
>> Add a simple driver to excercise the basics of the Rust DMA
>> coherent allocator bindings.
>>
>> Suggested-by: Danilo Krummrich <dakr@kernel.org>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>> ---
>>   samples/rust/Kconfig     | 11 +++++
>>   samples/rust/Makefile    |  1 +
>>   samples/rust/rust_dma.rs | 97 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 109 insertions(+)
>>   create mode 100644 samples/rust/rust_dma.rs
>>
>> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
>> index 3b6eae84b297..e2d14aa6beec 100644
>> --- a/samples/rust/Kconfig
>> +++ b/samples/rust/Kconfig
>> @@ -78,4 +78,15 @@ config SAMPLE_RUST_HOSTPROGS
>>   
>>   	  If unsure, say N.
>>   
>> +config SAMPLE_RUST_DRIVER_DMA
>> +	tristate "DMA Test Driver"
>> +	depends on PCI
>> +	help
>> +	  This option builds the Rust dma test driver sample.
>> +
>> +	  To compile this as a module, choose M here:
>> +	  the module will be called dma.
>> +
>> +	  If unsure, say N.
>> +
>>   endif # SAMPLES_RUST
>> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
>> index 0dbc6d90f1ef..1a9aff6e8d6a 100644
>> --- a/samples/rust/Makefile
>> +++ b/samples/rust/Makefile
>> @@ -7,6 +7,7 @@ obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
>>   obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
>>   obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
>>   obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
>> +obj-$(CONFIG_SAMPLE_RUST_DRIVER_DMA)		+= rust_dma.o
>>   
>>   rust_print-y := rust_print_main.o rust_print_events.o
>>   
>> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
>> new file mode 100644
>> index 000000000000..1740140faba6
>> --- /dev/null
>> +++ b/samples/rust/rust_dma.rs
>> @@ -0,0 +1,97 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Rust DMA api test (based on QEMU's `pci-testdev`).
>> +//!
>> +//! To make this driver probe, QEMU must be run with `-device pci-testdev`.
>> +
>> +use kernel::{bindings, dma::CoherentAllocation, pci, prelude::*};
>> +
>> +struct DmaSampleDriver {
>> +    pdev: pci::Device,
>> +    ca: CoherentAllocation<MyStruct>,
>> +}
>> +
>> +const TEST_VALUES: [(u32, u32); 5] = [
>> +    (0xa, 0xb),
>> +    (0xc, 0xd),
>> +    (0xe, 0xf),
>> +    (0xab, 0xba),
>> +    (0xcd, 0xef),
>> +];
>> +
>> +struct MyStruct {
>> +    h: u32,
>> +    b: u32,
>> +}
>> +
>> +impl MyStruct {
>> +    fn new(h: u32, b: u32) -> Self {
>> +        Self { h, b }
>> +    }
>> +}
>> +// SAFETY: All bit patterns are acceptable values for `MyStruct`.
>> +unsafe impl kernel::transmute::AsBytes for MyStruct {}
>> +// SAFETY: Instances of `MyStruct` have no uninitialized portions.
>> +unsafe impl kernel::transmute::FromBytes for MyStruct {}
>> +
>> +kernel::pci_device_table!(
>> +    PCI_TABLE,
>> +    MODULE_PCI_TABLE,
>> +    <DmaSampleDriver as pci::Driver>::IdInfo,
>> +    [(
>> +        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
>> +        ()
>> +    )]
>> +);
>> +
>> +impl pci::Driver for DmaSampleDriver {
>> +    type IdInfo = ();
>> +    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
>> +
>> +    fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
>> +        dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");
>> +
>> +        let ca: CoherentAllocation<MyStruct> =
>> +            CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
>> +
>> +        || -> Result {
>> +            for (i, value) in TEST_VALUES.into_iter().enumerate() {
>> +                kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1));
>> +            }
>> +
>> +            Ok(())
>> +        }()?;
> 
> Why is this placed in a closure? Left over from deferred error for pin-init?
> 

The macro expands into a block which needs to validate the function 
item_from_index()?

>> +
>> +        let drvdata = KBox::new(
>> +            Self {
>> +                pdev: pdev.clone(),
>> +                ca,
>> +            },
>> +            GFP_KERNEL,
>> +        )?;
>> +
>> +        Ok(drvdata.into())
>> +    }
>> +}
>> +
>> +impl Drop for DmaSampleDriver {
>> +    fn drop(&mut self) {
>> +        dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
>> +
>> +        let _ = || -> Result {
>> +            for (i, value) in TEST_VALUES.into_iter().enumerate() {
>> +                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0);
>> +                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1);
> 
> We should probably change `dma_read!`/`dma_write!` to return `Result`,
> so that we don't have to wrap these calls in a closure for obscure reasons.
> 

Changing `dma_read!`/`dma_write!` to return `Result` is probably not a 
trivial change, would it be okay to have this fixed in a subsequent patch?

Thanks!

/Abdiel

