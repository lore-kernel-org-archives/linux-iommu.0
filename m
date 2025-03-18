Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD251F4C99;
	Tue, 18 Mar 2025 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742329075; cv=none; b=aSZWSFKgi0zoBw882dbNY5jnQLQVI7GKb94tdjBKLVETCsu+YGFAJCwLthp6tgHcjAJ+2qlvLdlTgPwDIafjrEGY+AKNFIpT6lup6UP9uPAYgIXvTnguA+IjFKWtWlJkIauga1xudTi/z90pXRPqM/Dv1hvY0Yf1Y/8UwciBwDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742329075; c=relaxed/simple;
	bh=qjoI51DvAkOY4VBqJdc/V5YA+NOO+//yNH4o3cRoKfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I2/nieCeKGx35gqsdFr2rl5CibyImtzSK7coEzU+IDfE6yiWR9zK2UsrtR5mrEP/ITfwO9PLHzVJ7HpO75TUaZ7jQd+aQnI/gxUjUaYbJnU/+hHtKtColKMQWJsmiArFcvasUrPtZolgpZCVUrzrREsY2FTNLJ1miK/JjBht5kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx64QfkP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx64QfkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97090C4CEEE;
	Tue, 18 Mar 2025 20:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742329073;
	bh=qjoI51DvAkOY4VBqJdc/V5YA+NOO+//yNH4o3cRoKfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Cx64QfkP3BvtV2i0Kqdrf3DzFFqNj7jsSp4qxnaGHj7oAyt+ragXbM2cvI1WBARR4
	 BcymFmMGqaw0+IhNEo/tOdqWwIcnGYLTnluFZD1Vm1spmQyveS3SmK5FP/JNnsctKP
	 WKVsM5SUk2CmJlIeoiEu2IX5u0x4PHTzQlS0MuYw4+yxliP7086U36yQqidQfBlG+v
	 G0IK6zSc7OL5dWWjXkMS7hl2A+rZQf7kS963ly1pG6pB9Ctk1xMnV3+TwQ5NkxAy9e
	 oK8Y17XCv1R8Bk/Myp/8PBBbE4F5jgR5hpjYgQhN7tRvFJL+blQNLnka+2TpJ/Yk6J
	 Mr+EFO5dyPobA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>,  <daniel.almeida@collabora.com>,
  <dakr@kernel.org>,  <robin.murphy@arm.com>,  <aliceryhl@google.com>,
  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,
  "Valentin Obst" <kernel@valentinobst.de>,  "open list"
 <linux-kernel@vger.kernel.org>,  "Christoph Hellwig" <hch@lst.de>,  "Marek
 Szyprowski" <m.szyprowski@samsung.com>,  <airlied@redhat.com>,  "open
 list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v14 03/11] samples: rust: add Rust dma test sample driver
In-Reply-To: <03902487-5cd3-45ed-b3cb-cabfd0ac5cb7@gmail.com> (Abdiel
	Janulgue's message of "Tue, 18 Mar 2025 20:42:39 +0200")
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
	<20250311174930.2348813-4-abdiel.janulgue@gmail.com>
	<87frjajwq2.fsf@kernel.org>
	<wAjk3jNcvGi573b_S5kGahtGLyPKgJbhc2ZaLDfmh3IBKD-smledIpK_5r5-5R8t3l9okVmH7gZx7QcRHZVjmA==@protonmail.internalid>
	<03902487-5cd3-45ed-b3cb-cabfd0ac5cb7@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 21:17:41 +0100
Message-ID: <87h63qhz4q.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> Hi,
>
> On 18/03/2025 15:26, Andreas Hindborg wrote:
>> Abdiel Janulgue <abdiel.janulgue@gmail.com> writes:
>>
>>> Add a simple driver to excercise the basics of the Rust DMA
>>> coherent allocator bindings.
>>>
>>> Suggested-by: Danilo Krummrich <dakr@kernel.org>
>>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>>> ---
>>>   samples/rust/Kconfig     | 11 +++++
>>>   samples/rust/Makefile    |  1 +
>>>   samples/rust/rust_dma.rs | 97 ++++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 109 insertions(+)
>>>   create mode 100644 samples/rust/rust_dma.rs
>>>
>>> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
>>> index 3b6eae84b297..e2d14aa6beec 100644
>>> --- a/samples/rust/Kconfig
>>> +++ b/samples/rust/Kconfig
>>> @@ -78,4 +78,15 @@ config SAMPLE_RUST_HOSTPROGS
>>>
>>>   	  If unsure, say N.
>>>
>>> +config SAMPLE_RUST_DRIVER_DMA
>>> +	tristate "DMA Test Driver"
>>> +	depends on PCI
>>> +	help
>>> +	  This option builds the Rust dma test driver sample.
>>> +
>>> +	  To compile this as a module, choose M here:
>>> +	  the module will be called dma.
>>> +
>>> +	  If unsure, say N.
>>> +
>>>   endif # SAMPLES_RUST
>>> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
>>> index 0dbc6d90f1ef..1a9aff6e8d6a 100644
>>> --- a/samples/rust/Makefile
>>> +++ b/samples/rust/Makefile
>>> @@ -7,6 +7,7 @@ obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
>>>   obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
>>>   obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
>>>   obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
>>> +obj-$(CONFIG_SAMPLE_RUST_DRIVER_DMA)		+= rust_dma.o
>>>
>>>   rust_print-y := rust_print_main.o rust_print_events.o
>>>
>>> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
>>> new file mode 100644
>>> index 000000000000..1740140faba6
>>> --- /dev/null
>>> +++ b/samples/rust/rust_dma.rs
>>> @@ -0,0 +1,97 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! Rust DMA api test (based on QEMU's `pci-testdev`).
>>> +//!
>>> +//! To make this driver probe, QEMU must be run with `-device pci-testdev`.
>>> +
>>> +use kernel::{bindings, dma::CoherentAllocation, pci, prelude::*};
>>> +
>>> +struct DmaSampleDriver {
>>> +    pdev: pci::Device,
>>> +    ca: CoherentAllocation<MyStruct>,
>>> +}
>>> +
>>> +const TEST_VALUES: [(u32, u32); 5] = [
>>> +    (0xa, 0xb),
>>> +    (0xc, 0xd),
>>> +    (0xe, 0xf),
>>> +    (0xab, 0xba),
>>> +    (0xcd, 0xef),
>>> +];
>>> +
>>> +struct MyStruct {
>>> +    h: u32,
>>> +    b: u32,
>>> +}
>>> +
>>> +impl MyStruct {
>>> +    fn new(h: u32, b: u32) -> Self {
>>> +        Self { h, b }
>>> +    }
>>> +}
>>> +// SAFETY: All bit patterns are acceptable values for `MyStruct`.
>>> +unsafe impl kernel::transmute::AsBytes for MyStruct {}
>>> +// SAFETY: Instances of `MyStruct` have no uninitialized portions.
>>> +unsafe impl kernel::transmute::FromBytes for MyStruct {}
>>> +
>>> +kernel::pci_device_table!(
>>> +    PCI_TABLE,
>>> +    MODULE_PCI_TABLE,
>>> +    <DmaSampleDriver as pci::Driver>::IdInfo,
>>> +    [(
>>> +        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
>>> +        ()
>>> +    )]
>>> +);
>>> +
>>> +impl pci::Driver for DmaSampleDriver {
>>> +    type IdInfo = ();
>>> +    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
>>> +
>>> +    fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
>>> +        dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");
>>> +
>>> +        let ca: CoherentAllocation<MyStruct> =
>>> +            CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
>>> +
>>> +        || -> Result {
>>> +            for (i, value) in TEST_VALUES.into_iter().enumerate() {
>>> +                kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1));
>>> +            }
>>> +
>>> +            Ok(())
>>> +        }()?;
>>
>> Why is this placed in a closure? Left over from deferred error for pin-init?
>>
>
> The macro expands into a block which needs to validate the function
> item_from_index()?

It is not required here, since we are already in a function that returns
result.

>
>>> +
>>> +        let drvdata = KBox::new(
>>> +            Self {
>>> +                pdev: pdev.clone(),
>>> +                ca,
>>> +            },
>>> +            GFP_KERNEL,
>>> +        )?;
>>> +
>>> +        Ok(drvdata.into())
>>> +    }
>>> +}
>>> +
>>> +impl Drop for DmaSampleDriver {
>>> +    fn drop(&mut self) {
>>> +        dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
>>> +
>>> +        let _ = || -> Result {
>>> +            for (i, value) in TEST_VALUES.into_iter().enumerate() {
>>> +                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0);
>>> +                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1);
>>
>> We should probably change `dma_read!`/`dma_write!` to return `Result`,
>> so that we don't have to wrap these calls in a closure for obscure reasons.
>>
>
> Changing `dma_read!`/`dma_write!` to return `Result` is probably not a
> trivial change, would it be okay to have this fixed in a subsequent patch?

It is actually trivial:

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 027ef75a461a..52d235f61886 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -446,20 +446,22 @@ fn drop(&mut self) {
 #[macro_export]
 macro_rules! dma_read {
     ($dma:expr, $idx: expr, $($field:tt)*) => {{
-        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
-        // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
-        // dereferenced. The compiler also further validates the expression on whether `field`
-        // is a member of `item` when expanded by the macro.
-        unsafe {
-            let ptr_field = ::core::ptr::addr_of!((*item) $($field)*);
-            $crate::dma::CoherentAllocation::field_read(&$dma, ptr_field)
-        }
+        (|| -> Result<_> {
+            let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+            // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
+            // dereferenced. The compiler also further validates the expression on whether `field`
+            // is a member of `item` when expanded by the macro.
+            unsafe {
+                let ptr_field = ::core::ptr::addr_of!((*item) $($field)*);
+                ::core::result::Result::Ok($crate::dma::CoherentAllocation::field_read(&$dma, ptr_field))
+            }
+        })()
     }};
     ($dma:ident [ $idx:expr ] $($field:tt)* ) => {
-        $crate::dma_read!($dma, $idx, $($field)*);
+        $crate::dma_read!($dma, $idx, $($field)*)
     };
     ($($dma:ident).* [ $idx:expr ] $($field:tt)* ) => {
-        $crate::dma_read!($($dma).*, $idx, $($field)*);
+        $crate::dma_read!($($dma).*, $idx, $($field)*)
     };
 }
 
@@ -486,25 +488,31 @@ macro_rules! dma_read {
 #[macro_export]
 macro_rules! dma_write {
     ($dma:ident [ $idx:expr ] $($field:tt)*) => {{
-        $crate::dma_write!($dma, $idx, $($field)*);
+        $crate::dma_write!($dma, $idx, $($field)*)
     }};
     ($($dma:ident).* [ $idx:expr ] $($field:tt)* ) => {{
-        $crate::dma_write!($($dma).*, $idx, $($field)*);
+        $crate::dma_write!($($dma).*, $idx, $($field)*)
     }};
     ($dma:expr, $idx: expr, = $val:expr) => {
-        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
-        // SAFETY: `item_from_index` ensures that `item` is always a valid item.
-        unsafe { $crate::dma::CoherentAllocation::field_write(&$dma, item, $val) }
+        (|| -> Result {
+            let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+            // SAFETY: `item_from_index` ensures that `item` is always a valid item.
+            unsafe { $crate::dma::CoherentAllocation::field_write(&$dma, item, $val) }
+            ::core::result::Result::Ok(())
+        })()
     };
     ($dma:expr, $idx: expr, $(.$field:ident)* = $val:expr) => {
-        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
-        // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
-        // dereferenced. The compiler also further validates the expression on whether `field`
-        // is a member of `item` when expanded by the macro.
-        unsafe {
-            let ptr_field = ::core::ptr::addr_of_mut!((*item) $(.$field)*);
-            $crate::dma::CoherentAllocation::field_write(&$dma, ptr_field, $val)
-        }
+        (|| -> Result {
+            let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+            // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
+            // dereferenced. The compiler also further validates the expression on whether `field`
+            // is a member of `item` when expanded by the macro.
+            unsafe {
+                let ptr_field = ::core::ptr::addr_of_mut!((*item) $(.$field)*);
+                $crate::dma::CoherentAllocation::field_write(&$dma, ptr_field, $val)
+            }
+            ::core::result::Result::Ok(())
+        })()
     };
 }
 
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 39b6050aa3b6..962e65322893 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -61,13 +61,10 @@ fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>
         let ca: CoherentAllocation<MyStruct> =
             CoherentAllocation::alloc_coherent(pdev, TEST_VALUES.len(), GFP_KERNEL)?;
 
-        || -> Result {
-            for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1));
-            }
+        for (i, value) in TEST_VALUES.into_iter().enumerate() {
+            kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1))?;
+        }
 
-            Ok(())
-        }()?;
 
         let drvdata = KBox::new(
             Self {
@@ -85,13 +82,10 @@ impl Drop for DmaSampleDriver {
     fn drop(&mut self) {
         dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
 
-        let _ = || -> Result {
-            for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0);
-                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1);
-            }
-            Ok(())
-        }();
+        for (i, value) in TEST_VALUES.into_iter().enumerate() {
+            assert_eq!(kernel::dma_read!(self.ca[i].h).unwrap(), value.0);
+            assert_eq!(kernel::dma_read!(self.ca[i].b).unwrap(), value.1);
+        }
     }
 }
 



Best regards,
Andreas Hindborg


