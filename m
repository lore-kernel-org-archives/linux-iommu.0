Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19A42E62B4;
	Fri,  3 Jul 2026 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097605; cv=none; b=dBvajaCRDJYrbr6hke4XwrUP2MVWbix5CnYfatIfCLcR/UrHpQuO0XI5+aIdpJL0gacaUVlPgjzkv/imE90ZGc+cOpIS2TinNSjYoo0A6dkTFMuzoISG8+EqjWbcHSXp8jXUQq7cUXdgRJkas1FndTCVd7t39rRCKq+quZAy35c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097605; c=relaxed/simple;
	bh=+wm7iBGV6NG9r5LEc21MHyCO5EAWcpaPW8H0ZcGzVDk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ULKd42SElmNL8ZhicaAaVWzv/LWzGv9BSpdDEiSxwdvC5hzD5dFcu+n9wnWkNdwdlOcBJJfaiK+hKSbHGb9tBnOCq0LXxnr78PHRHV2NdfHpdgvUySTXyFD8geReNKUS6edvrd7Wi1Vk+7MeI+Z5DRDrf3+azlTLlqc1PIpkZpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+g5ZKeE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+g5ZKeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36041F000E9;
	Fri,  3 Jul 2026 16:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783097604;
	bh=+wm7iBGV6NG9r5LEc21MHyCO5EAWcpaPW8H0ZcGzVDk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=J+g5ZKeEgpx9BLtfXznjokAYfMUTXTTvcKTTEuoPuD3uLTDHClnsSmvZ/g7E/gOxh
	 AVTRL2Tn14up6KFfzO3It/ay0VpJlAuoI3rUJDtiVbIJrdkt5Dp7HlIy6zmF0Uy7VU
	 ywF2uVjKMGSK+NXFD9HDhHOzQN1bZwocouVxXuS0WxspT+TaVlD++dOk5v7xnWU0bj
	 CRO/vJMUF2ieTRwYBe/7yYiBEwlXBplv+AHe8FlumbBRdEXfYYagtysKDgGHIrBUtH
	 CEo6X/Dq7pcRHMKBUnX/PnE+A9HbKVneDQbx2CogK1uVo6iPXQBzYT1Y4YdBLbIEcG
	 3h9ygMVYPMfQA==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 18:53:19 +0200
Message-Id: <DJP3CGLE438Q.1EM46SY9PWLHB@kernel.org>
Subject: Re: [PATCH] rust: iommu: add device lifetime to IoPageTable
Cc: "Deborah Brouwer" <deborah.brouwer@collabora.com>, "Joerg Roedel (AMD)"
 <joro@8bytes.org>, "Will Deacon" <will@kernel.org>, "Robin Murphy"
 <robin.murphy@arm.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <iommu@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <samitolvanen@google.com>, <boris.brezillon@collabora.com>,
 <laura.nao@collabora.com>, <daniel.almeida@collabora.com>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260702-pgtable_lt_v1-v1-1-18d9c9812a1a@collabora.com>
 <akdaMa7hQbAjWbox@google.com>
In-Reply-To: <akdaMa7hQbAjWbox@google.com>

On Fri Jul 3, 2026 at 8:44 AM CEST, Alice Ryhl wrote:
> I would suggest renaming this method to just `new()`.

Agreed.

> As for creating a device resoure version with DevresLt, I think that can
> be the secondary constructor and be called `new_devres()` or similar.

Other device resources use an into_devres() method consuming self. However,=
 I
wouldn't add it until we have a valid use-case anyway.
