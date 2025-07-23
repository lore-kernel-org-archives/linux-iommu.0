Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F1423AD
	for <iommu@lists.linux.dev>; Wed, 23 Jul 2025 00:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753232122; cv=pass; b=PoaRudMR8g/bYpZoBd0Ek36aygBtkrV6qScX/t6UlOnNzuvy+u4cEHsBtoJ4VheJNM5Z6GDeI8bvfE19aU9Xv+TUdlnYRkhAhEEj9zZPKY1LlHnRytoJrE2ZgEmDEmrXqXOeCf7RFSb73vmDTK+oovMnqGB5lHzJLZw7Xj2jEKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753232122; c=relaxed/simple;
	bh=ycN+a20a39+uHkwjSn4cEM7f6YHzcXmsuaFLVrv2MDk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KXfTwgMjiO+ff6eEM0wv2D0txBdgRP/AHpYfXgltvUVgp7aHu/NB+lXD5V/NA9UO8OYHt+XPntFH1WXAhiEFLKPkTZZ/YNi6ebWqbOFe16U84FVepfWC5EriWuJPJq3SAsdD9NIYZ5ea85FSa8SF1C+RdDlZJoa9Lhdcn7VrYQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ZvYXaG8T; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ZvYXaG8T"
ARC-Seal: i=1; a=rsa-sha256; t=1753232083; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BNVgI65NKwrtemFylave53P707ygH90jssUdgPyCXHBjCVKl7Udowg3RrF5jW7lF+5L42aejLvx/6hooj37lkUWKT4Dexs1swMBwvouETQ8S4k/u0Ys2wqbDqX/QqCZ/2uvKx2loUqZJ0H9dQiab1L3k3n/E7e2nCVbAErzEDSU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753232083; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rFbss56s1hh59hJnWNWrBx8A3FfQ2zEsLLLpTD2DR70=; 
	b=TGSZ1id1WJCBtc6bHuQLco/N+TCYCFviuh18cPF5Ek3sPu2D4qJWiYMri7c2Hb6K4TSJo1sgI+loqbsf+bHo0vuIeo/q1PCJWgOAx987mFoVGKr6//t5m0SXPHgRxTimb9YJHzXMX6mCGdtaFfMMVynLWzb3h9zNW1On/X63zGk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753232083;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=rFbss56s1hh59hJnWNWrBx8A3FfQ2zEsLLLpTD2DR70=;
	b=ZvYXaG8T4lAnVI7iEL9ckJnVjctoR4mbpuljQW5qa0nNFVYtj2UA182Mcp7VcjIq
	rU2H+R1c/ojDQ0LgbZpn4xh+1AOzAXJ8AVqlNn0ZrzBOrk5X3WK5mhFEJ8rftjA7KNA
	yuEqHQt4db104nTrC+dqErmZkdlh3xjnXx0CK9b4=
Received: by mx.zohomail.com with SMTPS id 1753232080305334.71411635942;
	Tue, 22 Jul 2025 17:54:40 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 2/2] samples: rust: add sample code for scatterlist
 abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250718103359.1026240-3-abdiel.janulgue@gmail.com>
Date: Tue, 22 Jul 2025 21:54:23 -0300
Cc: acourbot@nvidia.com,
 dakr@kernel.org,
 jgg@ziepe.ca,
 lyude@redhat.com,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@gmail.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Petr Tesarik <petr@tesarici.cz>,
 Sui Jingfeng <sui.jingfeng@linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F13AD3DF-6045-45FB-B3A8-9F4BA99BC485@collabora.com>
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
 <20250718103359.1026240-3-abdiel.janulgue@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Abdiel, Alex,

> On 18 Jul 2025, at 07:33, Abdiel Janulgue <abdiel.janulgue@gmail.com> =
wrote:
>=20
> Add simple excercises to test the scatterlist abstraction.
>=20
> Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
> samples/rust/rust_dma.rs | 49 +++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 48 insertions(+), 1 deletion(-)
>=20
> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
> index 9e05d5c0cdae..1fa278e8e29a 100644
> --- a/samples/rust/rust_dma.rs
> +++ b/samples/rust/rust_dma.rs
> @@ -4,11 +4,33 @@
> //!
> //! To make this driver probe, QEMU must be run with `-device =
pci-testdev`.
>=20
> -use kernel::{bindings, device::Core, dma::CoherentAllocation, pci, =
prelude::*, types::ARef};
> +use kernel::{
> +    bindings, device::Core, dma::CoherentAllocation, page::*, pci, =
prelude::*, scatterlist::*,
> +    sync::Arc, types::ARef,
> +};
>=20
> struct DmaSampleDriver {
>     pdev: ARef<pci::Device>,
>     ca: CoherentAllocation<MyStruct>,
> +    _sgt: SGTable<OwnedSgt<PagesArray>, ManagedMapping>,
> +}
> +
> +struct PagesArray(KVec<Page>);
> +impl SGTablePages for PagesArray {
> +    fn iter<'a>(&'a self) -> impl Iterator<Item =3D (&'a Page, usize, =
usize)> {
> +        self.0.iter().map(|page| (page, kernel::page::PAGE_SIZE, 0))

The order seems to also be inverted here (see comment on the previous =
patch)

> +    }
> +
> +    fn entries(&self) -> usize {
> +        self.0.len()
> +    }
> +}
> +
> +struct WrappedArc(Arc<kernel::bindings::sg_table>);
> +impl core::borrow::Borrow<kernel::bindings::sg_table> for WrappedArc =
{
> +    fn borrow(&self) -> &kernel::bindings::sg_table {
> +        &self.0
> +    }
> }

I assume there is no way to get around this without compromising =
somewhere
else, right?

>=20
> const TEST_VALUES: [(u32, u32); 5] =3D [
> @@ -58,10 +80,35 @@ fn probe(pdev: &pci::Device<Core>, _info: =
&Self::IdInfo) -> Result<Pin<KBox<Self
>             kernel::dma_write!(ca[i] =3D MyStruct::new(value.0, =
value.1))?;
>         }
>=20
> +        let mut pages =3D KVec::new();
> +        for _ in TEST_VALUES.into_iter() {
> +            let _ =3D pages.push(Page::alloc_page(GFP_KERNEL)?, =
GFP_KERNEL);
> +        }
> +
> +        // Let's pretend this is valid...

I=E2=80=99d reword this.

> +        // SAFETY: `sg_table` is not a reference.
> +        let sg_table: bindings::sg_table =3D unsafe { =
core::mem::zeroed() };
> +
> +        // `borrowed_sgt` cannot outlive `sg_table`.
> +        // SAFETY: =46rom above, we assume that `sg_table` is =
initialized and valid.
> +        let _borrowed_sgt =3D unsafe { =
SGTable::new_unmapped(&sg_table) };

Wait, zero-initialization is considered =E2=80=9Cinitialized and =
valid=E2=80=9D here? i.e.:

struct sg_table {
	struct scatterlist *sgl;	/* the list */
	unsigned int nents;		/* number of mapped entries */
	unsigned int orig_nents;	/* original size of list */
};

> +
> +        let sg_table =3D WrappedArc(Arc::new(sg_table, GFP_KERNEL)?);
> +        // `refcounted_sgt` keeps a refcounted reference to the =
`sg_table` and is thus not
> +        // tied by a compile-time lifetime.
> +        // SAFETY: =46rom above, we assume that `sg_table` is =
initialized and valid.
> +        let _refcounted_sgt =3D unsafe { =
SGTable::new_unmapped(sg_table) };

Ah, this is cool, though the Borrow implementation is a bit of a =
downside :/

> +
> +        // `owned_sgt` carries and owns the data it represents.
> +        let owned_sgt =3D SGTable::new_owned(PagesArray(pages), =
GFP_KERNEL)?;
> +        let sgt =3D owned_sgt.dma_map(pdev.as_ref(), =
kernel::dma::DmaDataDirection::DmaToDevice)?;
> +
>         let drvdata =3D KBox::new(
>             Self {
>                 pdev: pdev.into(),
>                 ca,
> +                // excercise the destructor
> +                _sgt: sgt,
>             },
>             GFP_KERNEL,
>         )?;
> --=20
> 2.43.0
>=20

=E2=80=94 Daniel

