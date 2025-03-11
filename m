Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99B51CAA87;
	Tue, 11 Mar 2025 20:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741724222; cv=none; b=dwkzVym+G/icputAlySaZOrDmhIjSkuehGpXTNSmLEJupWrXl6qf2fEE0NIufFT0D87z2ma5ecH1Jdj6+0Z/anObDhBMycA0BcVKA8JKiIaD27juSQ1dy+PHJPRjoa4LS1/zB+vFoyWbsKKg5BlLc8aLL0pt16hEfClfoNiUSTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741724222; c=relaxed/simple;
	bh=ehF+drNnVLkBktFXnJxEAKFECGmy24S4q/x4ANwyDZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IMKkBxNILvxzVQ1FmQIfZrNxhSQrimiW8J/FGUhgt3vCbjlhDfwjTkge6qx4xNU3sfSOpXYTrzYxdDqvCFVLt6hxSWNq6giqTpS38jmRlNNvKasAxgQIA8UnNVzYao5dkOrGZNWDC9a9mqJyHn+L3sfODrqsvKOEm+0IWxBAiYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma5E20SQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma5E20SQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D70C4CEE9;
	Tue, 11 Mar 2025 20:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741724222;
	bh=ehF+drNnVLkBktFXnJxEAKFECGmy24S4q/x4ANwyDZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ma5E20SQJJ3tOZ8xo8nJ8EXnyqYhzLiFFD+tVN4HTRPXHGXddhD5RFVU+woCA+8xx
	 NoovgsN1R8BaV1M/hjTPqhOHQu4KLRwn1kZTlUUb/d/5Vxz4QIjrWFgK+5uLgtaPtY
	 oRXwEWfHG9MP3O9vki46vr5QrI0+ZfqPwaP9/8SuJPW4d3SXIKn7zrqpKTmJqW7jxN
	 h6lEgIalg86b1Fp1QvbyuHmELtBwnrPsMloYQR6lnIF7WXBzEXFTEG357kHCfmsUr4
	 qMyN8zcRgVngcY4cjICA2E2QBz9pCjBprAvWPxIyWbvMPDtGTCX66m1Eokn3wbwrLN
	 2h7KouvYi6fVQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
  rust-for-linux@vger.kernel.org,  daniel.almeida@collabora.com,
  dakr@kernel.org,  robin.murphy@arm.com,  aliceryhl@google.com,  Miguel
 Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,  Boqun
 Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>,  Benno Lossin <benno.lossin@proton.me>,
  Trevor Gross <tmgross@umich.edu>,  Valentin Obst
 <kernel@valentinobst.de>,  linux-kernel@vger.kernel.org,  Christoph
 Hellwig <hch@lst.de>,  Marek Szyprowski <m.szyprowski@samsung.com>,
  airlied@redhat.com,  iommu@lists.linux.dev
Subject: Re: [PATCH v13 4/7] rust: device: add dma addressing capabilities
In-Reply-To: <CANiq72njoQbMrBioohDQaUHixLa4u+1PKpQCoDPWTw0X5EhmAw@mail.gmail.com>
 (Miguel
	Ojeda's message of "Tue, 11 Mar 2025 19:35:48 +0100")
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
	<nxaaNW1XIbhf7dSf8aRLVF5Se-0maF6BhX8GaUXlsOL-QOste8OMQxtmhYe_BYI6FYFEMeHEzy1s4OEy7PdGKw==@protonmail.internalid>
	<20250307110821.1703422-5-abdiel.janulgue@gmail.com>
	<877c5038i1.fsf@kernel.org>
 <902d6f21-a6c9-4776-9e55-26f089acd0da@gmail.com>
	<CANiq72njoQbMrBioohDQaUHixLa4u+1PKpQCoDPWTw0X5EhmAw@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 11 Mar 2025 21:16:33 +0100
Message-ID: <871pv3l3vi.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Tue, Mar 11, 2025 at 6:45=E2=80=AFPM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
>>
>> This already uses `Error::from_errno`?
>
> Maybe Andreas meant `to_result`?

Yes, sorry. It includes the if/else, but it tests for ret < 0. But I
think that is fine here.


Best regards,
Andreas Hindborg



