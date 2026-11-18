Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795017634;
	b=yutNkLbc++tOEW9o6ZP89am/u2i4k3iDnw0p8USSoZJE0o4+DU92g0EM6uxNFlmp/jQ9
	 dEP3mqxgf1bCaXZYgPmkqV6f1jC1RTaL0rBytFw21W0dDU8z2ABG/m2qDo1ZhCckJTD4i
	 XgLziCjVNi7d3KI39HHB1uBBfGO7FqK/Msicx3OxGpYw5PnWojq/RHaD0Y9FY/IKkaUOn
	 4xeEA9y4g+aRoa6PDe91gRWKPq9E3DCCiTAtSH1tbtip6oP82KCRdSHAds89dkPW5VSpC
	 xJb71UqNr/O3fPC4VITrLcwHcctx9+lFNL94saKZ+ZwxQ7LZUxt+utLk69pRWVA82pg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017634;
	h=DMARC-Filter:DKIM-Signature:Received:Content-Type:Mime-Version:
	 Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-ZohoMailClient;
	bh=dGEORZaZz716wYpcThRPi5e2IbZeLqMzlydXlrCmTJ0=;
	b=27HjiNCuXaNyH82H/+xdk0dOj2cVY0fRa3p+UXjtu98Ynu0PebzcnzCsgWBG5bfxVINV
	 oihDvfkEHWzRqLHt4Qo/rDT3HFtXfAqBymk3HPGo0SWk/cFNP56wRfD5rhzOi+tQA2f7V
	 OvhXUwwkZA9qFtYBIOIjdf+8f1vXMVbmgtCzgL2ahSKCl7ZoulrwlWLPPgSbY01Wv536R
	 C+JcEoKME8CPgW/eIPUBUhh1dolplf9zgyR0cyFVdcCzayopO8F65I1rB8iv2sMO7InaK
	 TcJ1hxuVmNZHjMr5Je7jnjYkKMPSZtaThQcniP034OWlxHKJDBnJKlqtbJL5wgRr4pw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=jIhn4CYS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F007D606A338;
	Wed, 18 Nov 2026 16:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F007D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=jIhn4CYS
ARC-Seal: i=1; a=rsa-sha256; t=1795017617; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=H4epku+O/85bMOP3tyXQjrKRm9TqkppbUVATAvIa/R3uj5Z1hmHZfudmjfRDT4tEkEsIaE9Ni0O/ZEWIeBZmkYAzGzZpOyVYDj9iAB0kSHtG1JwPzFcrBBzs89u2q83ZJrTItgh5RpMOi17GKtGd86YT44MB/8QolZqDkok96Ds=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795017617; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dGEORZaZz716wYpcThRPi5e2IbZeLqMzlydXlrCmTJ0=; 
	b=Ut2s465OoydkIEXPPGDEzie/p4sl68t1R81WJ/7mGbIE4aGXPa2OL/QdwvRlWIyluSehPYEv7Hww/heOMCNsmCWQZCCi35aBDDYAM94BqwaYVsumSbt4IMV4mY8DDNWHmQ0uodRPuKoNvKs5NJhPXx7twJpOX40Wk+PNlL/E7R0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256; b=jIhn4CYS7T/X3otAn976iSpHeYy5amnyxRNxeXLcoMBFwz1ocw5bTo0WQcIosgVak2g0f4tCQw8QYVt/340bvjuctoeOe2RKMQMLIDTHs9dSPIbxDN6b1ijBHN1xe74VKcI+5r4Lg7i3qsji6l77PNU4Qq7R90Z+L/wwq46eZw8=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=dGEORZaZz716wYpcThRPi5e2IbZeLqMzlydXlrCmTJ0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179501761435743.54237341897863;
	Wed, 18 Nov 2026 08:00:14 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 0/6] rust: iommu: add a paging domain abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <42134022-AFBD-49E0-9AE5-0C5885F6C71D@collabora.com>
Date: Wed, 18 Nov 2026 12:59:55 -0300
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 iommu@lists.linux.dev,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev,
 Detlev Casanova <detlev.casanova@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD8C46FD-929D-4F44-8205-9DC0625EA758@collabora.com>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
 <20261116193821.GC2452510@ziepe.ca>
 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
 <20261117202055.GA3115493@ziepe.ca>
 <b145b2ceb92c73a4fa0477d7b3895a6e3b4adf99.camel@collabora.com>
 <42134022-AFBD-49E0-9AE5-0C5885F6C71D@collabora.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External



> On 18 Nov 2026, at 12:55, Daniel Almeida =
<daniel.almeida@collabora.com> wrote:
>=20
>>=20
>>=20
>>>=20
>>>> The fault handler is used in the same way it is used in GPU =
drivers: to kill
>>>> sessions if they fault. This way the driver can simply refuse =
further work from
>>>> a misbehaving client, for example. It is also the natural place to =
enqueue a
>>>> reset if the codec hardware is frozen as a result of the fault.
>>>=20
>>> IIRC no GPU driver does that, they hook the obsolete fault handler =
not
>>> supported in new iommu drivers not the new PRI based one... IDK we
>>> have even wired this up to work this way.
>>>=20
>>> It is nicer if the HW can tell you it faulted rather than expect the
>>> iommu to do it.
>>=20
>> We most likely don't need that, and should drop it from this series. =
We have
>> never used the fault handler in any linux-media codec in the past, =
the HW would
>> always endup producing an IRQ with a error or a timeout. Using the =
fault handler
>> would probably be a bit racy too. Pausing work from a faulty source =
though isn't
>> a bad idea, but more of a nice future addition, assuming it can work =
in a non-
>> racy way.
>>=20
>> Nicolas

Sorry, forgot to address the "racy" part: if GPU drivers can do it, we =
can do
it too. I wouldn't worry about race conditions if we copy their pattern.

=E2=80=94 Daniel=
