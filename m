Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138211FECDF
	for <iommu@lists.linux.dev>; Fri, 16 May 2025 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414735; cv=pass; b=R/XGKbkNxxhs2Zp4Hf1xewfJoJ4q4LbGfwPr/gS+na18irW8xVWd1a9WtQJTBcaV2DxBY1w4cxi6pAihr85XXShukdCRm5Lc4zz4ImTfnKW+FVaW0+JLUhDtBtqihT7fOwgL24oeouWPJg6nW8g+XVQChYQ4sO+jF/BgnLx6aZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414735; c=relaxed/simple;
	bh=u9CnnsxgBHYiMqrlH88scXaMolkI1hCUr/OKugbhe5w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KrjXnzteBZuJ85G7VqJbdmh8vUo0g8S6tlS0lG63ZSqpHd9CjHx0dm7Of8vuR+XfJpEBigTEg9t9tzApQXrLsJBks1SNZ4aYikyaYipl3fOehgLiqjCqjvZZH9VhEKoVlDkae+Cag03oSnxclLXFUx3wQiYZDegrhnyBxJef49U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=FbziE6P3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="FbziE6P3"
ARC-Seal: i=1; a=rsa-sha256; t=1747414698; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ACyHRvfJmA7Y2Kox0fwKg6zSpbnFTWJWZE/4EHlZDMSQZFrU8DeFj2P9BRvL6oWv72ZAPcWkCiLVq8Fr5kYNhkY7KskQ2TGrFRhCLgRPhNunmksAQXsxUqbmX78LJl86QREzTQ9TLSr9gCZSFxiHE+KQX7Sr5qd+0wzEZyQYY9w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747414698; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=74P/MVvEdQBxgBZoK6QuPVyfTK+cWj6e2b7brUvTP/I=; 
	b=SYPfq2OYs9F78KHHzfZ01ofNRtneVGNZLZi+ha5tQkeg44WCU54zq0dMx7gOblNp9AE5QwKU1bW3hTXl6nxtw4etoPZepWqjeNKq3v4BhSHAhvCC2c8Thz5UWF8Utqq2ggVvEbuXGgrWYOyJp4sstQqp1fV8HU/bwxQzghwcPrw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747414698;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=74P/MVvEdQBxgBZoK6QuPVyfTK+cWj6e2b7brUvTP/I=;
	b=FbziE6P3W0Kl3k2r5njdXfq6gpVRmRRn2+f5FaytbMT7wdfA8gASt6BaYNVWUSbO
	MiwOjO9FRVDrstgCM+QkGV6HFjpYPs0+C7WrYjTsjjtHeIkKQyfJ9mYCiBnmEzTEGNo
	kcdieD+cO/XeoWkueu2dVKeTlFGmMor/OBe2ew9k=
Received: by mx.zohomail.com with SMTPS id 1747414696338270.7222041661928;
	Fri, 16 May 2025 09:58:16 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [RFC PATCH 1/2] rust: add initial scatterlist bindings
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aCZYcs6Aj-cz81qs@pollux>
Date: Fri, 16 May 2025 13:57:59 -0300
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 lyude@redhat.com,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 airlied@redhat.com,
 rust-for-linux@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Petr Tesarik <petr@tesarici.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Sui Jingfeng <sui.jingfeng@linux.dev>,
 Randy Dunlap <rdunlap@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E2F129BE-777A-4DBD-BC3E-44033BCD11E4@collabora.com>
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
 <20250512095544.3334680-2-abdiel.janulgue@gmail.com>
 <B3564D77-9E26-4019-9B75-B0C53B26B64F@collabora.com>
 <aCZYcs6Aj-cz81qs@pollux>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-ZohoMailClient: External

Hi Danilo,=20

Replying to you and Lyude here at the same time.

> On 15 May 2025, at 18:11, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Mon, May 12, 2025 at 08:39:36AM -0300, Daniel Almeida wrote:
>>> On 12 May 2025, at 06:53, Abdiel Janulgue =
<abdiel.janulgue@gmail.com> wrote:
>>> +impl SGEntry {
>>> +    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// Callers must ensure that the `struct scatterlist` pointed =
to by `ptr` is valid for the lifetime
>>> +    /// of the returned reference.
>>> +    pub unsafe fn as_ref<'a>(ptr: *mut bindings::scatterlist) -> =
&'a Self {
>>> +        // SAFETY: The pointer is valid and guaranteed by the =
safety requirements of the function.
>>> +        unsafe { &*ptr.cast() }
>>> +    }
>>=20
>> Hmm, this name is not good. When people see as_ref() they will think =
of the
>> standard library where it is used to convert from &T to &U. This is =
not what is
>> happening here. Same in other places where as_ref() is used in this =
patch.
>=20
> as_ref() is fine, we use this exact way commonly in the kernel, e.g. =
for Device,
> GlobalLockedBy, Cpumask and for various DRM types.
>=20
> Rust std does the same, e.g. in [1].
>=20
> I think I also asked for this in your Resource patch for consistency, =
where you
> call this from_ptr() instead.
>=20
> [1] =
https://doc.rust-lang.org/std/ptr/struct.NonNull.html#method.as_ref
>=20

That is not the same thing. What you've linked to still takes &self and =
returns
&T. In order words, it converts *from* &self to another type:

pub trait AsRef<T>
where
T: ?Sized,
{
    // Required method
    fn as_ref(&self) -> &T;
}

The signature in the kernel is different, i.e.:

fn as_ref<'a>(ptr: *mut bindings::scatterlist) -> &'a Self =20

This takes a pointer and converts *to* &self, which is a bit in the =
wrong
direction IMHO. You also have to provide `ptr`, which is a departure =
from the
syntax used elsewhere in Rust, i.e.:

// no explicit arguments:
let bar: &Bar =3D foo.as_ref();

vs

// slightly confusing:
//
// Bar::as_ref() creates &Bar instead of taking it as an argument to =
return something else
let bar =3D Bar::as_ref(foo_ptr);  =20


Which is more akin to how the "from" prefix works, starting from the =
=46rom trait
itself, i.e.:

let bar  =3D Bar::from(...); // Ok: creates Bar,

...to other similar nomenclatures:

let bar =3D Bar::from_ptr(foo_ptr); // Ok, creates &Bar

So, IMHO, the problem is not conflicting with the std AsRef, in the =
sense that the
code might not compile because of it. The problem is taking a very well
known name and then changing its semantics.

Anyways, this is just a small observation. I'll drop my case, specially
considering that the current as_ref() is already prevalent in a lot of =
code upstream :)

=E2=80=94 Daniel

