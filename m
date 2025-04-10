Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B6A1624D0
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297875; cv=none; b=fX+Ca+txL+mc0I6gVO/NjeVGgiZRAXPUMJbItgvCrfJ5tc1oG94PGkeNGvXIyGBvYyY+uMOYyo6RQX+T2TsmlUNI5Z7oQm7Lk9hWUI0sNe4WLKZK5SiSyG5giZg4e9PfwU4Ln6KqH1OBW7TN+G1heE271VCrE69hwmSQKsC8Gss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297875; c=relaxed/simple;
	bh=rViml0MO0HXvkmWfFcE+jHaQpoerFBjycLu5vc7XwYs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrltXsJ0jkzOatPhmIgcIJqtBQcauRS0O1iXN5WgdtSq7isnRwi5qZG37eGYt7ZBxXwOhF4vyhi1zxHG55P69/WyOv9aNvCPapg7nsrsCGHX25vTF1P1Vtt+gPPitG/40KTCYVYizDMr8sK183YLnfUYIflBInHIKorr9wkDrr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TAdClRal; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TAdClRal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744297866; x=1744557066;
	bh=8ZROoD5JcNESwIbha+YQjpRq4TIlO/1MtVld/+GK+DY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=TAdClRalV5KSb2YEn4SpuTWPWvUMvV6hoPDAdYO2YTz0zNJBHQaZbugC2YiMxthXD
	 /rr7iToQka6Pakzg7S6RL+LfEs2Iu38EJdF4tskUcB3QStu0+dPZ03+u49z5XHEYAz
	 5QgdaMRFvJRL2ROqa4frDEe0Eo6+t1m2/Cu6R7SqqXGOxI1nyM1mEHPc8iKGlPRoll
	 8LJNTOSyeRI+tWC6GAQu18Amf+UtjrJK2ZhJbSRexB1eWma6UsNdf2ODtoPfRLKnmR
	 haHGIEEvajcI3S5FpLqAE0fJ9MEdxH6H89oZzqHFoKBmuLD5lamQISOkIIl8r8sxK5
	 K6xQfNm/oO8tg==
Date: Thu, 10 Apr 2025 15:11:01 +0000
To: Danilo Krummrich <dakr@kernel.org>, Abdiel Janulgue <abdiel.janulgue@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: a.hindborg@kernel.org, rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com, "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 2/3] rust: dma: convert the read/write macros to return Result
Message-ID: <D931ZGPNHUA8.U3L2C72CVH46@proton.me>
In-Reply-To: <Z_exjZ9xEntlL9FC@pollux>
References: <20250410085916.546511-1-abdiel.janulgue@gmail.com> <20250410085916.546511-3-abdiel.janulgue@gmail.com> <Z_exjZ9xEntlL9FC@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ec7346d749b35949f7f5a50559c44a645fedb015
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Apr 10, 2025 at 1:54 PM CEST, Danilo Krummrich wrote:
> On Thu, Apr 10, 2025 at 11:58:17AM +0300, Abdiel Janulgue wrote:
>> @@ -78,13 +74,14 @@ impl Drop for DmaSampleDriver {
>>      fn drop(&mut self) {
>>          dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
>> =20
>> -        let _ =3D || -> Result {
>> -            for (i, value) in TEST_VALUES.into_iter().enumerate() {
>> -                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0);
>> -                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1);
>> -            }
>> -            Ok(())
>> -        }();
>> +        for (i, value) in TEST_VALUES.into_iter().enumerate() {
>> +            let val0 =3D kernel::dma_read!(self.ca[i].h);
>> +            let val1 =3D kernel::dma_read!(self.ca[i].b);
>> +            assert!(val0.is_ok());
>> +            assert!(val1.is_ok());
>> +            assert_eq!(val0.unwrap(), value.0);
>> +            assert_eq!(val1.unwrap(), value.1);
>
> Maybe use if-let to avoid the unwrap?
>
> =09if let Ok(val0) =3D val0 {
> =09   assert_eq!(val0, value.0);
> =09}
>
> I know it's a bit pointless, since we know it must be ok, but the educati=
onal
> message of the example should be to check and not to unwrap, so maybe tha=
t's
> better.

The if-let will silently ignore any errors, so I don't think that it's
fit for example code either.

---
Cheers,
Benno

