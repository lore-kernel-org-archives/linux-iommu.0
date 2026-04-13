Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DD526A0A7;
	Mon, 13 Apr 2026 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776093936; cv=none; b=Kiiq/TZU0r88s4pleYRRnRkeXatRIasnmDkGgW2E+qIJPqvC/GMwx6JTBv8Xu992rJVrob7q4CWANDNqhgxZoKZ6+EqBAdz70iIIQVk/Qheh+IUCiieu+TFhBHC9ICpSSKmVkO1GtzHu+nJ1dS9BeNdljdmD0dlybxmMp1oHq5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776093936; c=relaxed/simple;
	bh=cU9lrhEmZpvQLEgoKVEj0GRhcNMapbzoQ668g/ZSdDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BeHT/+p8KW6wSFf6c1iyu8rnRgNQ/0P6JUwqRNNlIveEkaf+i2jSyDe/ACkzOLnFAMhnhsLA2Kb9nolztL8FFDa0DKkv65IspBoCNUNgrLQ0ZzArWqxEidkEeQJ3OEy0sDuAGBu+WoDJnOjd0+iZ5T9PzFx04ocg2fZhW/6iA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUm7qJ9y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUm7qJ9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEDCC2BCB4;
	Mon, 13 Apr 2026 15:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776093936;
	bh=cU9lrhEmZpvQLEgoKVEj0GRhcNMapbzoQ668g/ZSdDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gUm7qJ9yF0OgIhNg+F92vYs9RmpAI3ImKBtfqic40EOJqj5yt5jRmNv0ejprfID+l
	 jjcCEfOW0mEasF+VZaIH3vFWd1t8L7rh8rfeVQhc2eL3dsVoKzDli1lgTAxjwr2oSe
	 cDd10Fmf12aUEONAemC706ufTDWNpfuVc3wTVoPWP4CNdurUENl1m7LZgA30Bvl8fM
	 wZe54h9dWcTlWGA69fLQafkLljy1VUZ+m3syyOh+wFFo50Ll6GYiwwEq0KSn5D8lz7
	 +0DO+pKdYnxTfw0fHZq2xZUH9trnNqvchCtOzKln4PGK3D/+2sFoF3bFtC4SjC/bpO
	 FR/QCkqKIycFg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	m.szyprowski@samsung.com, will@kernel.org, maz@kernel.org,
	suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us
Subject: Re: [RFC PATCH v2 1/5] dma-mapping: Avoid double decrypting with
 DMA_RESTRICTED_POOL
In-Reply-To: <20260413123559.GI3694781@ziepe.ca>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-2-smostafa@google.com>
 <20260330150654.GA809900@ziepe.ca> <acrgYotBExJhEJkK@google.com>
 <yq5aeckjbdrt.fsf@kernel.org> <20260413123559.GI3694781@ziepe.ca>
Date: Mon, 13 Apr 2026 20:55:28 +0530
Message-ID: <yq5azf36anmf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Mon, Apr 13, 2026 at 11:30:38AM +0530, Aneesh Kumar K.V wrote:
>
>> I know there is a v3, but I=E2=80=99m commenting here to check whether w=
e really
>> need to do this now. In my opinion, we can keep this much simpler by
>> treating all swiotlb allocations as decrypted allocations.=20
>
> That's not going to work when we get to supporting T=3D1 devices that
> may still want SWIOTLB for encrypted memory.
>

Earlier discussions indicated that a T=3D1 device would not require a
bounce buffer. On ARM, we require such devices to support 64-bit DMA so
they can operate with an unprotected IPA.

-aneesh
