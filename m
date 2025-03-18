Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EAA20E317;
	Tue, 18 Mar 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307548; cv=none; b=ZRGZWOyRaoVBfSTmLhOa403mMO3Dco7+mSxEWpvHcfvmDmBJMqpOpHXAb9geMlCKDhHsGZnWJl8ZCH/tzWeZeZVePpym7Z9qL656wxttq+NM0cOCMelzv3YlaQk8LkjuheBTUsnBhjlyvJu1TuTj1tIT/7TMkNBkc2GIEHdFduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307548; c=relaxed/simple;
	bh=DLBSdfjhrcTO18lXkihNamSUSA2kNdGMQBdw1Ge2tAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rHsMNKSLj4jC5t6el25tL3SJjn1roiOKEWgNiSZlV3nXnDExJ41jkD4jMbGRejcEPAdBv5pUHCCXjhzRGw/67xc3MBw2//V+Glm9WBiLBKLgZtkfwvj9S4VzDe9IJU03KbUMsCU7yyorb0eOuQwPINmRVzllbVrzU5ys57ZgMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKZyiF8w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKZyiF8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD35C4CEDD;
	Tue, 18 Mar 2025 14:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742307547;
	bh=DLBSdfjhrcTO18lXkihNamSUSA2kNdGMQBdw1Ge2tAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fKZyiF8wbU2gEBgW6+z+JLzRHPBN8EAUXikYDFjAXN0BWYLGXyKszi4p1ncD67WXw
	 0gsO9bb7p0/IdHYKWQhE7Ea4FMRsUvQqM3F7Af1OGbBuGOFZyJdiGmkwYcHr5LFXhb
	 6mF9KjgKBR0+DkNlb+Yu5qlZZ8GFzEdRS34oIJLj4eYze0bBbbiQJP3xOoBFtqZj+w
	 WgJrLcgNpYeB+v1pFuigIo0IV9UkjTgeF9aXTyVoVFAL0/8s2hHVlenUsAx77vex7V
	 YMY9VMl7Ijxc55DJduVdSYLy8DQI9+VfL7CdQmscTTbVqb7PdhOchIutpjqvJmS3SH
	 04TQmmtraZmFA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>,  <daniel.almeida@collabora.com>,
  <dakr@kernel.org>,  <robin.murphy@arm.com>,  <aliceryhl@google.com>,
  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,
  "Valentin Obst" <kernel@valentinobst.de>,
  <linux-kernel@vger.kernel.org>,  "Christoph Hellwig" <hch@lst.de>,
  "Marek Szyprowski" <m.szyprowski@samsung.com>,  <airlied@redhat.com>,
  <iommu@lists.linux.dev>
Subject: Re: [PATCH v15 11/11] rust: dma: add as_slice/write functions for
 CoherentAllocation
In-Reply-To: <20250317185345.2608976-12-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Mon, 17 Mar 2025 20:52:18 +0200")
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
	<1vuR_eOzfIz1yigvLbgiW9YYnm45qzIRwfjp-7reCYpDDiRI3zrmkDbA6XtHpMipLTm10-tUwMZixJsjvf6T9A==@protonmail.internalid>
	<20250317185345.2608976-12-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 15:09:27 +0100
Message-ID: <87senaig6g.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> Add unsafe accessors for the region for reading or writing large
> blocks of data.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg


