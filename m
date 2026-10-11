Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F9B33260B
	for <iommu@lists.linux.dev>; Sun, 11 Oct 2026 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742977; cv=none; b=i5hxTh5i24St2RccZ2Y3P+Tmw0bSmaGUkdInFfVmZbmAL+RA6gBqXo1Xd63Nm1es6LCKcLHkTO9HG+ioJHiawYxuLMQgXgQshnuzexo52DEO7gWGTCGOHHNYRTNNLJaIxR82bzicwyGe8cjDheA0YG1l2l7KsSu+996dYUopJH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742977; c=relaxed/simple;
	bh=XPWwyt3/uXVYcgzd8Enwfe/DGoKEFenuEHyqp8gDCJM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GNgUYpbveEJiIBgRicj/2TX6jQARjyqsdZ+fyvPhFPwfReT8Thxdn7suQsXtS5X4L+f6v5rrmk0kx8q1xtFBCLIb9ZVdagygy7hiKhAA5blE+RGLFYi6mmKoqy3X8eOjffYEsjHlvgF6cm92Nrvhe8ptAjLYPmptt0XGEb/AiJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=I1OdSDY3; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="I1OdSDY3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791742964; x=1792002164;
	bh=XPWwyt3/uXVYcgzd8Enwfe/DGoKEFenuEHyqp8gDCJM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=I1OdSDY3q0LkROmMghCduFk5TXBGpYZSeWAZfaVi+UsuztOWLpCk6Alwrh9DBqvQ9
	 9PrC0OCe+4SGTHa/uSevW260Azc+Ragw4AbHti07P9vcIrK6B2ei28ifSphdeuUvIQ
	 e+EIasH/QSck5vuSOJgPlkgvNQfIMCwuPK4J/3PJ5Y3B8pG2AfMBrrGXf/pbP6djI+
	 p8w6HOsvNA/O4DCDt+QA//91rhZeL/wyM1UIajqQtDbm0lJwplbNtkOblgj5cZIF0c
	 +BDyeCFhXr2S/7UB2suVkACh5Bj+5YJ+dsLGm5rccy4rL2CP394aeKCfohSEPSA6ig
	 KqNUs6+QJ0JRQ==
Date: Sun, 11 Oct 2026 18:22:39 +0000
To: x@2005.tr
From: Lorenzo Delgado <lnsdev@proton.me>
Cc: Lorenzo Delgado <lnsdev@proton.me>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Robin Murphy <robin.murphy@arm.com>, driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v3] rust: io: use newtype for PhysAddr
Message-ID: <20261011182233.3234121-1-lnsdev@proton.me>
Feedback-ID: 53083996:user:proton
X-Pm-Message-ID: be7ab1927f2d72ecea22ce26cc259d326bf9dd73
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Are you still planning a v4? v3 no longer applies to driver-core-next
since ResourceSize became a newtype, and there's a new PhysAddr user in
drivers/gpu/drm/tyr/vm.rs.

If not, I'm happy to pick it up and credit your v3.

Thanks,
Lorenzo

