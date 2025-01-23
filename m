Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2CB1D5160
	for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737672913; cv=pass; b=TxjAC866k7I3XIsDF/DtKfDREmkphHUi/0A7F8v/FeVWsRJpHQEq5yuX4Q4KNAwhWs4YsuUKv7dYFlcDKpsEKALZDqM1sF4W+u8fdVfTUEwdZJZrqj+mzFNwLCOJ4nA2b5YTsbZoeLCukU3gvmOcPS0s/Y2jiVSSmVwQYYuTp9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737672913; c=relaxed/simple;
	bh=aE/BUQNzdDfxtwqZTwv6pOJJ7zZvHvzHqo/HVtLIPGU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jcVXUakHNUNlk/WgSQkpK8rNoUWJqEgFUsiIOGMIZa6j741xnCztNnlZD+l2M0/jbhbyG3sfxt4NbqtQv3/AecUzcnermkRY75Ruh2rWUJErRRm4SRTfRixhZiS7h1VZQSqHJf0cjCpZq5WOuhfh3irMRr4tTtySMAOnmk6dINs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=PkkyLRfv; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="PkkyLRfv"
ARC-Seal: i=1; a=rsa-sha256; t=1737672889; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l/5YRDNf1sKMe/MORDvWXF57OrZBxmzKgGEV2PyG+Iyv2+DF8gCNBWbD//iK4kGpLWLsSFwHVikkqCPQZ3E2L+e4rknRVAXgmiUCL6GuX/NeOvDXP8YMjwPzrRyF4xd1RToj5d0NFEcXwT54YFQ9mpZ996HVK9otfs6rx4UmKVE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1737672889; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aE/BUQNzdDfxtwqZTwv6pOJJ7zZvHvzHqo/HVtLIPGU=; 
	b=gR9RZ26C5Gmro6pcjKIchaobRT7mmPES4pmxCHoR5DI41NZsSxB9TbNny6H0VX9gIzD/zTeHk0LpKcH4fZzcuvWGxUlCyGQM/bOY2xqNYLo7w/S3FEir0nMjUkCxudGgF6+U+qvvz+vKZWwHWUsZ/Zw6c5i35pPvmWZL8bRfe8U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737672889;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=aE/BUQNzdDfxtwqZTwv6pOJJ7zZvHvzHqo/HVtLIPGU=;
	b=PkkyLRfv41kR16MT3+1b1+ZNWCFkxv3XkG4DvQEeEDCG92isW71HTlg3+Utu9s7/
	vXiDfXbOuZr0yV03atdJn7zZ6Rboi0pRbcVVbESlPYRWTMWqKLS1L1lC10qZ3D24V6x
	6VE/zpS21JQ/NldWRerM/6DEhuwCCPGGOswcTivc=
Received: by mx.zohomail.com with SMTPS id 173767288270373.7871320517429;
	Thu, 23 Jan 2025 14:54:42 -0800 (PST)
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
In-Reply-To: <CANiq72khT0LgvOd+JfYVx4iZpTVMzCDUiUteukHLjGOA_gLWjA@mail.gmail.com>
Date: Thu, 23 Jan 2025 19:54:24 -0300
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 =?utf-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
 Miguel Ojeda <ojeda@kernel.org>,
 rust-for-linux@vger.kernel.org,
 dakr@kernel.org,
 robin.murphy@arm.com,
 aliceryhl@google.com,
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
Message-Id: <28A709CD-6BD5-4B77-BE26-F785640BD257@collabora.com>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
 <20250123132940.1f3c2666@mordecai.tesarici.cz>
 <cd25d3a6-c203-4460-ab7c-81fa4b56c566@gmail.com>
 <CANiq72khT0LgvOd+JfYVx4iZpTVMzCDUiUteukHLjGOA_gLWjA@mail.gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External



> On 23 Jan 2025, at 11:44, Miguel Ojeda =
<miguel.ojeda.sandonis@gmail.com> wrote:
>=20
> On Thu, Jan 23, 2025 at 2:38=E2=80=AFPM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
>>=20
>> Miguel, what do you think? Would it be possible just include this =
change
>> and the one below locally if you think this series is ready for =
merging?
>=20
> Sure -- there is more than a week until the merge window closes and so
> on, so we will see if there is more feedback and Acks by then.
>=20
> Cheers,
> Miguel
>=20

Note: since an unsafe `as_slice()` function was added (on Boqun=E2=80=99s =
request IIUC) then
an unsafe `as_slice_mut()` should be added too.

I discussed this with Abdiel earlier.

=E2=80=94 Daniel=
