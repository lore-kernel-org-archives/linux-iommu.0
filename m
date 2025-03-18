Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597331BC2A;
	Tue, 18 Mar 2025 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303177; cv=none; b=r1wwjCFzkolwHixdePRlzAGXME101aItGV9D+f8+qbU6ljqieJ5HC+FoREavymNJyV90Syt0qsnqzC+VbNkHYOpzyrLcxrFgHJo6+XfCgje0Gs01OXYP6gtv2fcW/2aGUEXTuXr2Rynewcam3sefzFFUPD1sRzaFp4RWtfPeuAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303177; c=relaxed/simple;
	bh=iwxINfSB2zCJINdE+DyD9nYGixg/c5s4I+n8SaSDA+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvgSUJYURsHApMQDWGgLv0MIRPcwGK5tJgP3mcb0iT4oLnKc/xacy2SQq5ha/y2q3yIy70mSZDFuBgCg0X/NB28KsnvL+FP1srfQRPTtkDzHgGr1xs+gZFqiOJMZFAZ8uzvdMOuwXO+0R72NzABLXjcyfkm+xQjPUBGNNAog3EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxnuQD6e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxnuQD6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BB3C4CEDD;
	Tue, 18 Mar 2025 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742303176;
	bh=iwxINfSB2zCJINdE+DyD9nYGixg/c5s4I+n8SaSDA+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxnuQD6eFZX0fTG+wJCSWHjTQmSSFq5rUIaYte/Zs8snRa+wYgQ/iBVMDSbXmSTkt
	 MHaC7dHe+chdVuCwKM3xxwElKPipOZnP/9fQatzkTlYJnmBT4rcVxQY9wHUU8mhY+w
	 Jt6bOJ47fDm6SsEsgbxjqgiKFEaMsg+xWKZb3qRHYlX2tXaDCeEN3/WeZ0Dj8v4WW+
	 9Nx7Nu+Hq/CphegzI/UkC3sGFPjrIVNSMBgaOrPsDT/qvOx52wMc902E+IQAlRUR/+
	 z1K65rHz5q2Ug8lMqUKQOByi5OkH1QvJ1BSjUxWiPU0twDiMO/UF9xR1mgki6uLqys
	 qt1+Aqliz3bCQ==
Date: Tue, 18 Mar 2025 14:06:10 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	robin.murphy@arm.com, aliceryhl@google.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v15 03/11] samples: rust: add Rust dma test sample driver
Message-ID: <Z9lvwvanRrmTHb-C@cassiopeiae>
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
 <20250317185345.2608976-4-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317185345.2608976-4-abdiel.janulgue@gmail.com>

Hi Miguel,

On Mon, Mar 17, 2025 at 08:52:10PM +0200, Abdiel Janulgue wrote:
> Add a simple driver to excercise the basics of the Rust DMA
> coherent allocator bindings.
> 
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  samples/rust/Kconfig     | 11 +++++
>  samples/rust/Makefile    |  1 +
>  samples/rust/rust_dma.rs | 97 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 109 insertions(+)
>  create mode 100644 samples/rust/rust_dma.rs

This patch has a conflict with the driver-core tree, which you should also hit
in linux-next.

The below diff should fix it.

- Danilo

diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 1740140faba6..44e0e6aa5658 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -4,10 +4,10 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.

-use kernel::{bindings, dma::CoherentAllocation, pci, prelude::*};
+use kernel::{bindings, device::Core, dma::CoherentAllocation, pci, prelude::*, types::ARef};

 struct DmaSampleDriver {
-    pdev: pci::Device,
+    pdev: ARef<pci::Device>,
     ca: CoherentAllocation<MyStruct>,
 }

@@ -48,7 +48,7 @@ impl pci::Driver for DmaSampleDriver {
     type IdInfo = ();
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;

-    fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
+    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
         dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");

         let ca: CoherentAllocation<MyStruct> =
@@ -64,7 +64,7 @@ fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>

         let drvdata = KBox::new(
             Self {
-                pdev: pdev.clone(),
+                pdev: pdev.into(),
                 ca,
             },
             GFP_KERNEL,
