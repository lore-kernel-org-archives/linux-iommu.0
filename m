Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F9A28488F;
	Fri,  3 Jul 2026 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783107479; cv=none; b=qfUFz0wUc1RYCm83wEluUwLrUp5J6gxTXtC797fSw1jwv2EvAiBaC8XmP0LTmwBnLA1jkheN3A/vGH6nK9AQaO9nCCpAhEGpf8amjes8kLxcgVxMi0u/vH8PznNsEqT1RuGrYM9pZrDHS5F1/VNt60NLu5Iej8nelyfjCbBT60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783107479; c=relaxed/simple;
	bh=O4vgPwTfiZl/yD7BKOhny+nmGMjWV+4VJbug/maQAjQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=IBew9HTEtR2/266jUrA6gGyYfHEcfzT8Qs/czKVNJFxynjB4VoXZhhnvLQYw7a8b9wO5n09o+TdjloSD8CCbIc5AoTTZsSWTJCzNUsThzoUMRPgIezEweWWymc65VTW9hfsYmDCHw5tP+QqmHT74SR3BKeD+kjvfnt0fVETZhoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEDmIsLe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEDmIsLe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76A51F000E9;
	Fri,  3 Jul 2026 19:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783107478;
	bh=DiCN4+7Zej4DyTkI/2lB9TANFaLXp9oiyzAzN2TvC90=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=AEDmIsLeVCS51Hz+VLCL2GB7U68Unyu5Ta3VUQdJ6s3Xx7/EUyaHDgEZL9TwZoJV1
	 vu6T64Z8Q9Z3sII7QzTUvLNb6EyufN1x7PXXGGx1+ALfCaeJv3O/e2ZCmaBbMEXhOP
	 X0YbldKb3WhzJoOqj501HxKh+HstRuMvd59FwU3ePDhON7t46RIQhmN5QP+yW474PB
	 5tloausVgX1zfuhe5bw/R3+ISZDdDUdLUVPK3vGCm8xItYZrIVLy0o6frn43QNrddU
	 jQML70soVTkBE7sZDBnQqVKZ8qLvQJpdJTmyPvh5+2o1X/8veyO1kiNpqjgjPcCjm+
	 lWb2NfreXZIwg==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 21:37:53 +0200
Message-Id: <DJP6UGQMBAXD.1UHYDZXIF88ZD@kernel.org>
Subject: Re: [PATCH v2] rust: iommu: add device lifetime to IoPageTable
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
 "Robin Murphy" <robin.murphy@arm.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <iommu@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <laura.nao@collabora.com>,
 <boris.brezillon@collabora.com>, <daniel.almeida@collabora.com>,
 <samitolvanen@google.com>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260703-pgtable_lt_b4-v2-1-f14da6d4106d@collabora.com>
In-Reply-To: <20260703-pgtable_lt_b4-v2-1-f14da6d4106d@collabora.com>

On Fri Jul 3, 2026 at 8:52 PM CEST, Deborah Brouwer wrote:
> +impl<'bound, F: IoPageTableFmt> IoPageTable<'bound, F> {

We settled on the convention to only call a lifetime 'bound when it actuall=
y
described the entire bound scope. This might be shorter lived, so maybe jus=
t 'a.

> +    // TODO: Provide the option to return `IoPageTable` as a device reso=
urce
> +    // when DevresLt is available.

I'd drop this comment, we only really need it once there's a justified use-=
case,
or do you have something in mind already?
