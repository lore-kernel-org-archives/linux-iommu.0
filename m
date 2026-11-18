Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795017384;
	b=syg5TGHdA14t2uFr06f32mKfaosL7jUSBWRlGTz3w58eX/dncfGxyTHvaszGjY8tcs6k
	 NwkP/2liP0mE+ddwPOGumZlVHoU49X+ROuy3EjD229RH5sCa2IcFUV7/o6KhsoEJPlVfi
	 eWP6DUtnw5R/+yr54LbRA+TflyqMw4cvvRskYNzNo6s5GspPGuljmhzcWXKL4SrtpKMur
	 xy4FiyCg+qahqpZsYbxJmJtOOxVpOLgwOAC/2m0GH3W+3oUqOgp0SyDhyZm10+wasG58U
	 4pdLZ9u81ju1toWLJ5SiLPUWFdGXk5BgST0g+6DdnV4hBr6MZxJMQaNlaFyGdjFW/AA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017384;
	h=DMARC-Filter:DKIM-Signature:Received:Content-Type:Mime-Version:
	 Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-ZohoMailClient;
	bh=6sJDfIqoJRz6OacN4WC3akT40sE3dP03HyRnaz2zBvw=;
	b=d+Y7AybsFi/nxIBCnYob/MYcSY7xt6S99Cms47+ev26Ay+Qik53o2Nqdfnoadcg2XENi
	 W49O8Jes9LvQ+lWJcQnnXPQTDy8hhLsqfbgZ5SbGC2zAluBD+H5+MQzFzASvoHXbjvhvo
	 KnO3cYzhatNc8IvRYKtnBQwao0lDVQ49J8zDwOmGLfk9eKeT9k5fIDEJFbKcdAqgZB8oy
	 0sjUfv+dsH+kC8cZTxwp22mlIUqIDWHjTTvfsJkhc9uUZlmj7owRYBgarg0msE/iNhBHa
	 vMzgHSdL9S+Cf4u70x9b9k6teBu9Bt6GL5mHVOlXHVIOXPzAvrx7qiivgeknYXg2tFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b="khl/W3s1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4EB606A330;
	Wed, 18 Nov 2026 15:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A4EB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=khl/W3s1
ARC-Seal: i=1; a=rsa-sha256; t=1795017370; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UQD1UEoBXfruoRRSm990gZKrS5pwnqQ8A8t4yEY8TsKbkc84+96yZ4cUPomepB0VpoXwcWIu/UCUAWpa1EUKkT7jzz0cZUUaEAXRNROqEmsj1BQmoyc2Z/zEE4ofYQvkVBoaSt70uVZ/t34ZhGjyevNiat2uHgblAMFoe0F+TZ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795017370; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6sJDfIqoJRz6OacN4WC3akT40sE3dP03HyRnaz2zBvw=; 
	b=SKVj+FIbaJQ6XFiofW78YiTWFsnKKXChpB5PDRP0ovXgeF0cTUsCGs/x8XgXbDRT52tD3rNb3MUuEXHxXFzKS5j8S0AtyNZkMpnAmKrQMbeULa5Vk/KQ5gDUHUPtlNEvAxzxkiBrGrlKErKIIhXqpaMr8U/brFh7EnE3eG2NB9c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256; b=khl/W3s11re+hi2jq8M3Vc6y0leCIaABgeHODIXSqfFm5t4YwF4T3gjDnrkOGB/JxPTYEPaidXuZWWeaZVVphTaTOOsD4gDGFhZgqKO9zu3VqBqcprTsZnevPcRGZA9sjm2PgLIk998unDIc1J7VnE3b4euxmxaxJlq7l+Hv/bM=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=6sJDfIqoJRz6OacN4WC3akT40sE3dP03HyRnaz2zBvw=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795017368433890.2082940439967;
	Wed, 18 Nov 2026 07:56:08 -0800 (PST)
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
In-Reply-To: <b145b2ceb92c73a4fa0477d7b3895a6e3b4adf99.camel@collabora.com>
Date: Wed, 18 Nov 2026 12:55:49 -0300
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
Message-Id: <42134022-AFBD-49E0-9AE5-0C5885F6C71D@collabora.com>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
 <20261116193821.GC2452510@ziepe.ca>
 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
 <20261117202055.GA3115493@ziepe.ca>
 <b145b2ceb92c73a4fa0477d7b3895a6e3b4adf99.camel@collabora.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External


>=20
>>=20
>>> The fault handler is used in the same way it is used in GPU drivers: =
to kill
>>> sessions if they fault. This way the driver can simply refuse =
further work from
>>> a misbehaving client, for example. It is also the natural place to =
enqueue a
>>> reset if the codec hardware is frozen as a result of the fault.
>>=20
>> IIRC no GPU driver does that, they hook the obsolete fault handler =
not
>> supported in new iommu drivers not the new PRI based one... IDK we
>> have even wired this up to work this way.
>>=20
>> It is nicer if the HW can tell you it faulted rather than expect the
>> iommu to do it.
>=20
> We most likely don't need that, and should drop it from this series. =
We have
> never used the fault handler in any linux-media codec in the past, the =
HW would
> always endup producing an IRQ with a error or a timeout. Using the =
fault handler
> would probably be a bit racy too. Pausing work from a faulty source =
though isn't
> a bad idea, but more of a nice future addition, assuming it can work =
in a non-
> racy way.
>=20
> Nicolas

I am still collecting my thoughts to reply to Jason, but I don't see why =
we
wouldn't want a fault handler. For example this:

> IIRC no GPU driver does that, they hook the obsolete fault handler not
> supported in new iommu drivers not the new PRI based one... IDK we =
have even
> wired this up to work this way.

Perhaps does not account for the fact that the fault handler in Mali =
doesn't go
through the iommu subsystem, but there is a fault handler. Not only did =
I write
the handler, I also had to use it constantly as tyr initially faulted =
all the
time :/

Also, saying that a handler was never used in media is not a good =
argument,
IMHO. Yes, eventually the decoder reports some error, but this is =
orthogonal to
knowing whether someone is trying to access invalid memory. And if you =
know
that, you can prevent further invalid accesses before they bring the =
whole
thing down. Quite often I had to reboot the whole machine because the =
hardware
was perpetually stuck, and if the objective is having all the users of =
the
encoder play nice together, then this is not very ideal.

This is not unlike my time reverse engineering the NVIDIA codec =
hardware:
nouveau would complain on faults and kill the channel too.

What I am trying to say is: if the argument is "not all iommu drivers =
properly
support fault handlers", then perhaps I can vonlunteer to fix this in =
the C
code, if they want it and if a "fix" is technically feasible(?). But the =
overall
desire to kill a faulting user is something we could definitely use, and =
the
remaining question is whether this is possible via the iommu API.

=E2=80=94 Daniel=
