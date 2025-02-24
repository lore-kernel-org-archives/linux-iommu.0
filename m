Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6944823BCF1;
	Mon, 24 Feb 2025 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402682; cv=none; b=jWNa6PW60d8+LvWqS2oh1KhcZ8F+2Mr3VuDqjA69c2RtlGJglgOiggt9tPZFqb9FcL2n6rdVCvnpUbRdgUska2nWqY4QKK65K0+crCX8/NcAGS9rAnqTI51sv5TP3WG/lSeC7T/ci7ryihpvRlAuOrkxwVmlczuMBODpvMneXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402682; c=relaxed/simple;
	bh=LYdAXzO8SbVG83HH+nxA4TnZc//nwyYpcvy5mTdmdKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q7Vu7ipZrJ9e7F3Fjf0thRFnQvDNfRw9qUPJkJbYZovhqs6zbm58UpAwKN/TMI4hhkQtTSeaGp7VFsSRcqDGqy4n8RC3M7rYKoK8dz/wxmxuaIRdSJSGlNJDRsVTWzFaWqsvwBht0nYU0MttiYk2q21gCYhq+YsX72DYbIgnaJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctvpDCg5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctvpDCg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2F1C4CED6;
	Mon, 24 Feb 2025 13:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740402682;
	bh=LYdAXzO8SbVG83HH+nxA4TnZc//nwyYpcvy5mTdmdKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ctvpDCg5YqsORrsRWCcvWjHj1c9z3quO4ellroNdFN8RHnhvnjXwKZu5pu+HyFRo0
	 6xnq9lXzwNJgW8LUmQWA94VKHw/tZ2Y8zPEo1T6p/xgtTb2ZOEjKdbjKrbmSe1Zgvl
	 YCEImmXaYHj3MB/pVu5JUgecqIniz4c40Y/W1CXrR3guezSPMOqdJj40h3FH1/CBBm
	 LFRdRqu85znYx/Ag+Zuh0jANmqRuE3TPKiki+kRSwMBmboBR6VwJ4JOK/QqMo147Vr
	 VeFHhD2f6xE4PIcyQOzPPnNJDcJnQRI1JJXowGnWAqEtEka9BkHe0CSKYKYjOdXD6C
	 G9/XbNR7oUBcA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
Cc: <aliceryhl@google.com>,  <dakr@kernel.org>,  <robin.murphy@arm.com>,
  <daniel.almeida@collabora.com>,  <rust-for-linux@vger.kernel.org>,
  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,
  "Valentin Obst" <kernel@valentinobst.de>,
  <linux-kernel@vger.kernel.org>,  "Christoph Hellwig" <hch@lst.de>,
  "Marek Szyprowski" <m.szyprowski@samsung.com>,  <airlied@redhat.com>,
  <iommu@lists.linux.dev>
Subject: Re: [PATCH v12 1/3] rust: error: Add EOVERFLOW
In-Reply-To: <20250224115007.2072043-2-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Mon, 24 Feb 2025 13:49:05 +0200")
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
	<L-IMnzWNMQGcB6Qt5mnpFrsDdcoiVceLvT66VTWw_ZEbn1eD-t7bRJz5qFocbRfIDXJIiVKEeCVM-EbOZgAM7A==@protonmail.internalid>
	<20250224115007.2072043-2-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 24 Feb 2025 14:11:10 +0100
Message-ID: <87a5ab1o9d.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> Trivial addition for missing EOVERFLOW error. This is used by a
> subsequent patch that might require returning EOVERFLOW as a result
> of `checked_mul`.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



