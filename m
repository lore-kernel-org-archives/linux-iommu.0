Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116878F2E;
	Fri, 13 Mar 2026 07:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773387398; cv=none; b=OEOcaCx5f2dNeS4i/GclCqFIogg6uEeJTfZixazA9lImFdFqpFOWnT3adZNKBJtN8MD37uhCbXisIlGDkbG9DocAB3x6C/3A0ZpGByoy9Hy1Z2DwjSL9b9V67qeWuGEt4nFsESQaxNnFf9Gh1V01qYjJJ9UP4YiQwn9qZAymBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773387398; c=relaxed/simple;
	bh=CqpWMjJx6qSoFIegVWUVqJAnvK4En078LAZ1pHYrfus=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lb9QyXCCDKIBN02BWcxJ7Ram3t5UyY9+he3h6/hqJucyGO49369UzgweviaIg+I+38lIrSlkut+g5585FNMIaeYbINDGDJOZu6t3mH/opbE2kOQbBIpeQzcyINFDrGBZLA7IZxHXXPE+d5DrD2fYPwjhgwDhH3bSPxlqHRJZ5k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCRImi3h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCRImi3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BAAC19421;
	Fri, 13 Mar 2026 07:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773387398;
	bh=CqpWMjJx6qSoFIegVWUVqJAnvK4En078LAZ1pHYrfus=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bCRImi3hWnlK6tNJMLKKR7X6SsHBVJVJqKxUxVZDYhIthAJ0FXE89rPxLCQV+xvda
	 9WlsHwbBJeSet4TN6XUU89YQqmMRISOKgHm9Mm8pMgup6hZU2R/Rr2c4cn+FRJDxL/
	 zszaCiLjnvM0JzuEIx6hqLNcnuTV/t98SGVr9C149l+PGaCqtVKHeQWvKS4H5J5UYn
	 DO2QI8EQAyC8JbjpaVgaUqmy0ce+2CLiLL8rABjNGYT8iAxmZt2tjjNAibjcIU/LKI
	 hMYMXfbFWzDkMIg2YKLSa8SIXASMtlV5qxdj61oXLkR/1Nc3IWguP8T+puEBGQ+g4L
	 Sz6TkhVwCRUdg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com
Subject: Re: [RFC PATCH 1/2] dma-mapping: Avoid double decrypting with
 DMA_RESTRICTED_POOL
In-Reply-To: <abFfV__EkxSqvyMc@google.com>
References: <20260305170335.963568-1-smostafa@google.com>
 <20260305170335.963568-2-smostafa@google.com> <abAeSML-7ziLeIvv@arm.com>
 <abAi6NeKb4m_RbwV@arm.com> <abFfV__EkxSqvyMc@google.com>
Date: Fri, 13 Mar 2026 13:06:31 +0530
Message-ID: <yq5a4imkb2ps.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mostafa Saleh <smostafa@google.com> writes:

> On Tue, Mar 10, 2026 at 01:55:52PM +0000, Catalin Marinas wrote:
>> On Tue, Mar 10, 2026 at 01:36:08PM +0000, Catalin Marinas wrote:
>> > However, it's unclear to me whether we can get encrypted pages when
>> > is_swiotlb_for_alloc() =3D=3D false, remap =3D=3D true and
>> > force_dma_unencrypted() =3D=3D true in dma_direct_alloc().
>> > dma_set_decrypted() is only called on the !remap path.
>>=20
>> Ah, I can see Anneesh trying to address this here:
>>=20
>> https://lore.kernel.org/r/yq5abjjl4o0j.fsf@kernel.org
>
> I see, thanks for pointing that out, the case Aneesh is fixing is the
> missing decryption in the remap case. However, it=E2=80=99s not clear to =
me
> how we can get there for CCA, I left a comment on his patch.
>
> I can inline the is_swiotlb_for_alloc() checks outside, but I believe
> adding this in the lowest level is better as indeed the memory is
> decrypted and we don=E2=80=99t have to open code the check in other place=
s are
> dma_direct_alloc_pages()
>

There are a few related changes that I have posted. However, I am
wondering whether it would be simpler to treat the swiotlb pool as
always decrypted. In that case, even when allocating from swiotlb we
would not need to toggle between decrypt/encrypt.

Another reason to treat swiotlb as special is the alignment requirement
when toggling between decrypted and encrypted states.

The patch implementing this approach is here=20
https://lore.kernel.org/all/20260309102625.2315725-2-aneesh.kumar@kernel.org

With respect to remapping, there are two conditions that can currently
trigger a remap: when the device is non-coherent, or when we receive a
HighMem allocation. Neither of these conditions applies to CCA. We could
potentially enforce the HighMem case by using the following hunk in the
patch:


+
+	if (force_dma_unencrypted(dev))
+		/*
+		 * Unencrypted/shared DMA requires a linear-mapped buffer
+		 * address to look up the PFN and set architecture-required PFN
+		 * attributes. This is not possible with HighMem. Avoid HighMem
+		 * allocation.
+		 */
+		allow_highmem =3D false;
+
	/* we always manually zero the memory once we are done */
-	page =3D __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
+	page =3D __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, allow_hig=
hmem);
	if (!page)
		return NULL;

https://lore.kernel.org/all/20260102155037.2551524-1-aneesh.kumar@kernel.org

I haven't got much feedback on that patch yet.

-aneesh
