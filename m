Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92620F063
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 22:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744325906; cv=none; b=MFBOC41pvCu19Z4VuALTZMo+K1jcORiNGEFRC10382u2dDNQVVI1s4KLDL6sJqSLvXDiewqXcSy0tEvQ2WIvYBR78AMVssLCtSzPjjYX2/kQGPbUa2+KzhyFW1EhiC+yk7BN6+x56qL7W4EP/sgXnaDKEvrH+pPY4fxdQWtrVAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744325906; c=relaxed/simple;
	bh=eJDePrXnvgmVbjmFO96M87uFRNhkD3osTi43nmcKyvU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=C97kGK5osyR5151z/S+qwykawiJPxiVj0RJqdGKQjidOgfezwGIi+DLT54kvw6SEfTVXFUsYmqso5y3DOkGIix5q7DopEWOw3gJSWoJ8EOFrhvj054DYeK2cx2B343ODNpaN6BwY0/UmAvfDqTiCc6FT262qsTBALOWjSnIppp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SIpFpe33; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SIpFpe33"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=72zapty4afh5laqrlf5uzfjjwq.protonmail; t=1744325895; x=1744585095;
	bh=814kMpO+RWBsIlWCQsGZxLfyE/xbPT2Ntf7DX7UNcqw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=SIpFpe33BKWL+P8+bP69S6dbYlPiUCadu0lQ1V+jHLt+a7Dpuls7GuBxQcu80iPnV
	 dUhqnQwciyzo9R6Y+OelczaZFcVWWuhTFmnCwo76qO1uTSOLno0jpaxTcMPzL7ZOPk
	 /JCZFFo3Wh00syQ4T9wsaUHHMWSz+z5idR0k5Xap0Gfe6zD0uCbGlodtN8WZKSRsH0
	 tMasxTMety6X6fIj/iSnLeP92VP6iNhU3kE8PYE9thK1CAK5KKxiynGx365tOeel2R
	 KZy8zJ0AZTR6nkfkx6018ecakKdbGUQ6dRnUAiNUdZ/CgtqVV9qW6o65boWv+5qFky
	 OmwDN4lOqE7xQ==
Date: Thu, 10 Apr 2025 22:58:10 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, a.hindborg@kernel.org, rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com, "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 2/3] rust: dma: convert the read/write macros to return Result
Message-ID: <D93BX5NEOSC8.3NOVI9GMDJEXD@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: aab41a993ca3e1cb50eda5ca6500bb0663194c61
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Apr 10, 2025 at 5:34 PM CEST, Danilo Krummrich wrote:
> On Thu, Apr 10, 2025 at 03:11:01PM +0000, Benno Lossin wrote:
>> On Thu Apr 10, 2025 at 1:54 PM CEST, Danilo Krummrich wrote:
>> > On Thu, Apr 10, 2025 at 11:58:17AM +0300, Abdiel Janulgue wrote:
>> >> @@ -78,13 +74,14 @@ impl Drop for DmaSampleDriver {
>> >>      fn drop(&mut self) {
>> >>          dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
>> >> =20
>> >> -        let _ =3D || -> Result {
>> >> -            for (i, value) in TEST_VALUES.into_iter().enumerate() {
>> >> -                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0)=
;
>> >> -                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1)=
;
>> >> -            }
>> >> -            Ok(())
>> >> -        }();
>> >> +        for (i, value) in TEST_VALUES.into_iter().enumerate() {
>> >> +            let val0 =3D kernel::dma_read!(self.ca[i].h);
>> >> +            let val1 =3D kernel::dma_read!(self.ca[i].b);
>> >> +            assert!(val0.is_ok());
>> >> +            assert!(val1.is_ok());
>> >> +            assert_eq!(val0.unwrap(), value.0);
>> >> +            assert_eq!(val1.unwrap(), value.1);
>> >
>> > Maybe use if-let to avoid the unwrap?
>> >
>> > =09if let Ok(val0) =3D val0 {
>> > =09   assert_eq!(val0, value.0);
>> > =09}
>> >
>> > I know it's a bit pointless, since we know it must be ok, but the educ=
ational
>> > message of the example should be to check and not to unwrap, so maybe =
that's
>> > better.
>>=20
>> The if-let will silently ignore any errors, so I don't think that it's
>> fit for example code either.
>
> Yes, but we still have the assert!() before, so the full sequence would b=
e:
>
> =09assert!(val0.is_ok());
>
> =09if let Ok(val0) =3D val0 {
> =09   assert_eq!(val0, value.0);
> =09}

Ah right, missed that.

> The intention would be to avoid patterns that shouldn't be used in "real"=
 code;
> assert!() should be obvious not to use for real code.

Yeah, I'm not sure if this is that valuable. I think having "real code"
is better, but I don't have any idea what to do in this case.

Why does this sample do the validation in the `drop` method in the first
place? I guess the same code on the C side would do this in `remove` or
whatever the equivalent thing is there, but would there be the option to
report an error? Or is `remove` an infallible operation? In that case
`assert!` probably is still the best option.

---
Cheers,
Benno

