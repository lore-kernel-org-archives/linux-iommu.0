Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A75838B;
	Tue,  3 Jun 2025 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953127; cv=none; b=gmpcH+DT27z0X4Ci+POnNUk7RnX+YsfHy7N4ky+H3RNnIvT1HBWSfyQz37SUnwFpSa615QxqBdFT9cAK7GT4XNIaIEHWdFTeorh3NHBAs1V+jsfOYpxx5umVQSH5EA8Dlpna1jOrNLokhZcuyVE6i4aPqZm+DRHacilvch/tztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953127; c=relaxed/simple;
	bh=lIbv/HFizZ/7M6MW5NkVI5vENx0VdMaYNBVAP8G9wfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Spg2YIwc11DrWqvzOovzdyDM8YQYs40nv4a3LiwIqKQNJqcZLwOZ7uWe/wZr35uSgDqkaGmWK8iQSEyx8k9EK2faz+GuXsWXLbL7p0eYMz1/+sn5r88khmRtsrPnY3LuWH4CWUF2MifBff3IuQ+lVEzpB+ylDqMkYBd7AIquV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gc00Lol0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc00Lol0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2968FC4CEF3;
	Tue,  3 Jun 2025 12:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748953127;
	bh=lIbv/HFizZ/7M6MW5NkVI5vENx0VdMaYNBVAP8G9wfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Gc00Lol03c0COxKmvkykuO0jByZSKmHnfcwjWFSpd6RA8+SiQxINw7k/2NFtPK602
	 gLr/C/j70VUFHjw/e3SP5v0Bdar1wEDKFUn0lA8NM07vkCr8ivib4fNeqDGMmFwQst
	 mThEI/dcm0pDgQPuzqx4a+ovt62auea6kGLYGjG1y5Dmr0P7TPdW1Q9psO+/KlpRzG
	 hzQ4fd34laFoSdZNIvb61+ZWmXoTkpwW2ziS37pQhTapFUIFqQ7lsbopv6qIlCzCH0
	 jB4jIG6x2gcrvNjAzq9CDbnCDlhQS2F0qvijFYreO1T6iAi3e9UMnUb8OYPamEelcP
	 WdjE8VE3Pg6fg==
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
Subject: Re: [PATCH v15 09/11] rust: dma: use `dma::Device` in
 `CoherentAllocation`
In-Reply-To: <20250317185345.2608976-10-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Mon, 17 Mar 2025 20:52:16 +0200")
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
	<lGibBfz2PdlndvIn_JP9wiJAquaYfdfMYQxvpobEu3OqT9GZdduSYbeUl5VbO6j_EffHPosz4G8lpzZo4OhLGQ==@protonmail.internalid>
	<20250317185345.2608976-10-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 03 Jun 2025 14:18:24 +0200
Message-ID: <87bjr5588f.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hi Abdiel,

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> From: Danilo Krummrich <dakr@kernel.org>
>
> Require a `&dyn dma::Device` in `CoherentAllocation`, such that DMA
> memory can only be allocated with devices on potentially DMA capable
> busses.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>

Did you see my comment on v14 [1]?

Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/lkml/87y0x2igjz.fsf@kernel.org/

