Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0521319D07E;
	Sun,  3 May 2026 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777833956; cv=none; b=hmjoWx05m3OufZxnSvMa2roDItSZApn7wVN0URlc478K8iygh0OAaR9fgBllgLbPDMP3p6J4e5FTcG7hwbAOBVQ/rSJgrmVB3K+CELNy6vVBSyjj4QapgXLyCkU/Ao+n1tbN5u62qdXNPg+67Ui0OQjqgwNcmTJCKsMF3vKJzM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777833956; c=relaxed/simple;
	bh=OFwZG492Y8lJsFqq3CsqALzxYsXcTMS/AWur0zGFUq8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=XadbA2IaSrZi7O5jPtNaI94GNmCaYeoVFQoanrxOxs2GIWENiytXHE2DhGoEdHtW8SxRy17dWyw6+DHGh0qF6PIzETQeL4Pnde47q1e9Yp9vr8bzj5GvPmCOIxYj7YrUKHPWFpCGesFyYiA3/5ah4dcqSgxaclh9iOt4OYJzIUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCWQW5Zf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCWQW5Zf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADB1C2BCB4;
	Sun,  3 May 2026 18:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777833955;
	bh=OFwZG492Y8lJsFqq3CsqALzxYsXcTMS/AWur0zGFUq8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=mCWQW5ZfGQ01PeXKR2Gmd+uZm4N1n68GsTGWALQJ5TVnUgTHYSuMoV3hNUnLBHacf
	 VZJztSNRqzEGZ0JlM7aSUqtxX5VxgfG2ZmvT9K5SyboiPkyjIGV3JHWeVVo4DYp8mP
	 lFHY0DjSoxZormz5RX0mC4GAnmxq5o3K0b7A+zTn66rjEttTl69ACC66Vrvwt6g425
	 qaTyA9aGfccFFny/4wl+k8Yg2iLhzehqt7dn8kQK7Wh2ZKLeq0ebVcZKerZ78al/YC
	 wRZAcWwfqrU2TWmFA6GGFLTZTxpO3euzxIkt1HP1IHafl3pviIQYfbPMR8FCX7euOg
	 rBiwwjc9FHWKQ==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 May 2026 20:45:50 +0200
Message-Id: <DI99JDNG0S39.20MM1O9MFDGQL@kernel.org>
Subject: Re: [PATCH] rust: io: use newtype for PhysAddr
Cc: <x@2005.tr>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J . Wysocki" <rafael@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Joerg Roedel"
 <joro@8bytes.org>, "Will Deacon" <will@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Robin
 Murphy" <robin.murphy@arm.com>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <iommu@lists.linux.dev>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260503103050.200526-1-x@2005.tr>
 <20260503182827.21492-1-work@onurozkan.dev>
In-Reply-To: <20260503182827.21492-1-work@onurozkan.dev>

On Sun May 3, 2026 at 8:28 PM CEST, Onur =C3=96zkan wrote:
> Copy and Clone seem never used, please drop them (also see [1]).

This is a transparent wrapper of a primitive, so passing by value is a very
natural and idiomatic thing to do, so we should keep them.

What you are referring to is more meant for larger types where a copy might
actually hurt performance.
