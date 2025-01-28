Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FD119D8A2
	for <iommu@lists.linux.dev>; Tue, 28 Jan 2025 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738060639; cv=pass; b=ebmoqAPkPoWKTJ1YXno16cAoqh7vNcfsK8zqKYXKFVXnAJVEaoEgyr2/GpNQhDgSWTSxZzspqLj648A9PdNnQ5H2I4tsWVttVfo7ZsIpmgqzHFiE/roTCB1XdOEqYsQ3OdVnjWBlGSx/L+GkgMPZxZ6h4/IHKodpnzYgNAOS1IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738060639; c=relaxed/simple;
	bh=Iy8jL+RO4kCeCWANeotzNXbiNiT5D6HxELcbUATE7KI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=P8pQOaj4xX7zbjBA+wq2AB2k11WC1rOW2xH2fIQBXbY3uhOJRwUV+2+Azv4oDJdV991H0FyvX5pDMxe4/ZRbAwh22J7pial+yNOr4+f0yz6ZPk6bW9PeYdtsJDQu8cbB105L4p4In6fHxupMVJMTZQwzJBwf8id99DjzkkLb1IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=SbSmuRoR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="SbSmuRoR"
ARC-Seal: i=1; a=rsa-sha256; t=1738060620; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nMWaP8QhBMSFwiQFHXhh9+w5h+K9wBRT0aJ6/Y/QZvGHk/6Wdxqwi/ie6FVty6lOoG5eA9vcKEFUvOSg9Kv+1j6l6gJeDlPluwn67iB7pWgf8duhP9bPpCSbovUd35yIK1OUI0eqYjVHNwtjQk7wTDfQyH1NwGoe5a0zIgbpnjw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738060620; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HCS7Y/La3qKBzsI149zadTuSnL283J0V9/JciMTktvQ=; 
	b=a9gzWZAZpv2DdOs6klXod8Cc1F0qXnuAnAOvLh5LZWN81KKLpoP0eCT/70/o/kTso4TiGmpRawv1/ANGO+JurxuqfHPP301QOqXFomOa9AtMSPc4niUkAID5fQ+OwtDU3jP2BsZJrH8zLjvPLBrBn6KvWjoQ7nTouaIJBCLq7GY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738060620;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=HCS7Y/La3qKBzsI149zadTuSnL283J0V9/JciMTktvQ=;
	b=SbSmuRoRJcDdhFGq5GhZlYXVdwcZB/BaYMHzFu0UjA8ZkiauDSzi9dDmJVzUv+GN
	3z1XxQxrB8QOEaOrw1byYHhVrdPRJVbUaCVOVcEdAwr9XW1Zt2KIJa6UhMGDxoSjhhF
	eNneaaYNBxJ85QBFDoX8YuSXGuwDf0WkJSdx2v/E=
Received: by mx.zohomail.com with SMTPS id 1738060592449555.1420105642246;
	Tue, 28 Jan 2025 02:36:32 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLgjZiux1_=dNuZN+7SEY6fUGMDNLoJNTwmHcB=WbKChwzw@mail.gmail.com>
Date: Tue, 28 Jan 2025 07:36:17 -0300
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 rust-for-linux@vger.kernel.org,
 dakr@kernel.org,
 robin.murphy@arm.com,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D3CC752A-8FE3-4B2A-93A2-7FEC2EC3940E@collabora.com>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
 <0E0FC88B-95C0-4DBE-B497-AF9101BACE70@collabora.com>
 <CAH5fLgiW6n82hMhbmJ-ynd6329mEDFX6TzxXQZaaoG47HAWWcA@mail.gmail.com>
 <95382414-7A44-45A4-8F3F-C6D755422AD5@collabora.com>
 <CAH5fLgjZiux1_=dNuZN+7SEY6fUGMDNLoJNTwmHcB=WbKChwzw@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

>=20
> I mean, I imagine that you could make the syntax
> `dma_read!(my_alloc[7])` read the entire struct. I'm not sure which
> safe methods you are referring to, because right now there is only the
> unsafe as_slice().
>=20
> Alice

I mean this:

+    /// Writes data to the region starting from `offset`. `offset` is =
in units of `T`, not the
+    /// number of bytes.
+    pub fn write(&self, src: &[T], offset: usize) -> Result {
+        if offset + src.len() >=3D self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // - The pointer is valid due to type invariant on =
`CoherentAllocation`
+        // and we've just checked that the range and index is within =
bounds.
+        // - `offset` can't overflow since it is smaller than =
`self.count` and we've checked
+        // that `self.count` won't overflow early in the constructor.
+        unsafe {
+            core::ptr::copy_nonoverlapping(src.as_ptr(), =
self.cpu_addr.add(offset), src.len())
+        };
+        Ok(())
+    }
+}

=E2=80=A6and the similar read() method that was apparently removed, =
i.e.:

+    /// Reads data from the region starting from `offset` as a slice.
+    /// `offset` and `count` are in units of `T`, not the number of =
bytes.
+    ///
+    /// Due to the safety requirements of slice, the data returned =
should be regarded by the
+    /// caller as a snapshot of the region when this function is =
called, as the region could
+    /// be modified by the device at anytime. For ringbuffer type of =
r/w access or use-cases
+    /// where the pointer to the live data is needed, `start_ptr()` or =
`start_ptr_mut()`
+    /// could be used instead.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that no hardware operations that involve =
the buffer are currently
+    /// taking place while the returned slice is live.
+    pub unsafe fn read(&self, offset: usize, count: usize) -> =
Result<&[T]> {
+        if offset + count >=3D self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY: The pointer is valid due to type invariant on =
`CoherentAllocation`,
+        // we've just checked that the range and index is within =
bounds. The immutability of the
+        // of data is also guaranteed by the safety requirements of the =
function.
+        Ok(unsafe { =
core::slice::from_raw_parts(self.cpu_addr.wrapping_add(offset), count) =
})
+    }

I don=E2=80=99t think there=E2=80=99s anything wrong with these, so =
maybe your solution can come in as a convenience
when one wants to save on the amount of copying? IMHO the two methods =
above co-exist with what
you propose.

The unsafe `as_slice()` and `as_slice_mut()` should also stay, in my =
opinion. They can be used, for example,
in codec drivers.

=E2=80=94 Daniel

