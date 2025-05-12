Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992601F0E26
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747080160; cv=pass; b=eIWhVgfiWz4QiK0Ha8FQ9k4uLaT54l4RySzXz8szOMLQP5iq+/eACNFMPRt2NTpaAw7fngQoc6ZlzgarPxrPMXd39C1rebOxuIPMQHc/sMnwxjDQe+HwmL85PyIEgR7MQHmBQwnt97K7yufY8jdRKVRWX7xGepofLCvkoDVMxVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747080160; c=relaxed/simple;
	bh=puzRHBcMO8rvHuz8H81UYhM6x70hrg+q4UMp/8aK5o8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Kwqbl2QC1s4i6cHtdmm7gKH9eTFbMq02NiXVfYrQfa3CTT52ommoj7Q8kgUv7Czic/iqjuoKUoHpM+cv0nc8IO66YnERbzaAX1dPgBlFPKSJ0xARN+2VRs0Vii3scif5WOJiARqGEU2AuB1zTL0OSilf0ldvt8B0GMAamCVZkR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=K27k90PB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="K27k90PB"
ARC-Seal: i=1; a=rsa-sha256; t=1747080127; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Jotc9F0RGGpOV6IqypJ1faIXrg/K7Q4lYxpVOeSWJBaYI6PIQ17nU7hqgUFVlHX8c3ofIrDgpzFAwryzizvDjXstuTSCpUSJoM8oR2+J+a9HvzZCpOeajne5gdSK94hfiQKubp2sgYYkWXgWOFsZuHjp8eJEwYm7Cbgdo8fL/eg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747080127; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=n45Gcyqae2E8eLGQsbBmy9RbSgznDF/XzToG8E9egpM=; 
	b=GHZu5K73POYkxCAiatUmzNv9QD2SBYUogTAhqLSdmFMjwOSJJFsq+4Xm4IOcJN1BpkjQ5zuLN7znwx4f8Si0HM8VAK21W9YV3POS2WnI+vpez45hD3Gz1NFTniGvJ9Ta0XMkIJj17AcFjqgMUFpMI7pzQco6WpnKgwiKmR5nhD4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747080127;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=n45Gcyqae2E8eLGQsbBmy9RbSgznDF/XzToG8E9egpM=;
	b=K27k90PBkwJEqxcXWeecYvPmqyoSgUt89o1u1bvcZixbxbKRbq7xqKPSwnkxL+17
	0/2VRsre0Fta4Dy7pxlcR2M7vD6VyRIVD1boXIO3ZdPZP+m5F5o5dKxAqBeEWgy5yKY
	vJfvPTAbpc2F5Clyse8K/IbF6vlZ4GoYYyMUebPg=
Received: by mx.zohomail.com with SMTPS id 1747080124518928.7435041447463;
	Mon, 12 May 2025 13:02:04 -0700 (PDT)
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
In-Reply-To: <20250512164247.GF138689@ziepe.ca>
Date: Mon, 12 May 2025 17:01:45 -0300
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 dakr@kernel.org,
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
Message-Id: <AC0FC018-4440-4027-9943-12FFB481AA6E@collabora.com>
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
 <20250512095544.3334680-2-abdiel.janulgue@gmail.com>
 <20250512164247.GF138689@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-ZohoMailClient: External

Hi Jason,

>> +
>> +    /// Map this scatter-gather table describing a buffer for DMA.
>> +    pub fn dma_map(&mut self, dir: DmaDataDirection) -> Result {
>> +        // SAFETY: Invariants on `Device` and `SGTable` ensures that =
the `self.dev` and `self.sg`
>> +        // pointers are valid.
>> +        let ret =3D unsafe {
>> +            bindings::dma_map_sgtable(
>> +                self.dev.as_raw(),
>> +                self.sg.as_raw(),
>=20
> Can't call this function on an unbound driver, didn't someone add
> special types for this recently?

JFYI: I think that the =E2=80=9CBound=E2=80=9D state is still WIP and =
not upstream yet.

>=20
>> +impl Drop for DeviceSGTable {
>> +    fn drop(&mut self) {
>> +        if self.dir !=3D DmaDataDirection::DmaNone {
>> +            // SAFETY: Invariants on `Device` and `SGTable` ensures =
that the `self.dev` and `self.sg`
>> +            // pointers are valid.
>=20
> Wrong safety statement, Device must be on a bound driver to call this
> function, a valid pointer (eg device refcount) is not enough.
>=20
> Jason


=E2=80=94 Daniel

