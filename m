Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3274ADDAE
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005706; cv=pass; b=SmN2I7zFElOP8GPr2dOiNd6cLpXRFrT24tZsUL9IHqrS/K0AsGsbsVtpzoz+Fmvvi40ynDWbGlDBAwW5h/5vxnuJTXrqhl5QU5une4JhyiSIsccnmxJGwpdApFefXEAJbeRW6d8nMOYzX0OW41+1FcDbjvBCp2VHbs+RzB0qWHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005706; c=relaxed/simple;
	bh=u0J/DG3q3l3oTdmjlcJn4ywY61k9yybeZt0U6uv+BvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2Dq3O97C5UMR58KrX++JGmsyCaUMH84iWmC1B8BsDNhhznrLYmha5SHthBv3f2HooPNK8gw6xMvXNhVGZc6iQtjsXQFHbYLtuvESZJwOfqbRIWY82u2mrGB5ctW0FoWNGiH7Z6mWGgvZrcc19ml8eE3UHqPe1hUMUxBYSWMUtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASfG9/C3; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASfG9/C3"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b8095668ebso320729eec.2
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 11:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778005704; cv=none;
        d=google.com; s=arc-20240605;
        b=BPRnujdvkXIYwsEv+YJ3GcWTiqlNQ9yCNyJ05LoRD0CPoaypGLi9VUW500batI7gSX
         s7LUgJ0kjECi2jH3mkIn1pFm5/lWg2FJW8AbFzoXu+SvPipBqg4ZCVlmPJEQvIsujzQ9
         7p57yonHQZzD6ZGqYkK6Hl+GxS4BAjqHL0FoHXupJ0Yx968t95ETw8Yo21FYiywcDP+3
         Im+qJnix6wj9ADolsXG4UPQ9ceSd9N5PCV9syA0c4IsrgKBlKbsndqLsU896Q88WSjax
         0tfhQKuje6yoA3ovmQ+BlB6cGC35fFJvPvPiOQYJhIjGpY/iBV/I9SNY3PA8bnuEN49v
         9XDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u0J/DG3q3l3oTdmjlcJn4ywY61k9yybeZt0U6uv+BvI=;
        fh=JLjWAJei9C8p8x0YaksfXMqEqz+6vt1Bv4UauYh0yFg=;
        b=JgH67bROkRkLbOMRY4sJ7p++hL3AH9OfW2AlzmxsCZXcHukQ5lT2tkToqmkMVhb56N
         j/s4hFb/qC17xeENSpg+dI4u6ZfcBIM3wI8YfLnYjdDaVWpnIADL7wNlhWThXO/rZ/oJ
         RRKLheNH7hy+MpqvinmqtLazh220SJywrUOjY5EH55v1tg4hZNq/xjIXy2+jHYhogwtZ
         EROevNthP9w5ePKSnaLfwMDb9xtnqNnj7UJHBRxZgaQ4oQLkIe+W8QwJNx0Yzs3vXhuv
         0PIyne9eyn9QcFdJ+7scQLdC2JSEAuruZrpCe1/RxNPG0IxLwaN3Kmrx56pik8V+Q7ZX
         2Skw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778005704; x=1778610504; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0J/DG3q3l3oTdmjlcJn4ywY61k9yybeZt0U6uv+BvI=;
        b=ASfG9/C3RCykcQkX0mMTnawbQ6O7HQPaUrJaStSyJafiENLAmcv89IMzi2o6x6d5wd
         FAZXqhGWnd4duwOBYwA7gFG24FYhX75O+i9Os6GdzaLygUGRZXmr3ZKo/zQl1cnHUZVa
         TRwKx8eVO7y237tvQjfq9P7Y9FMqsySWwTmAT/ZSATUodbofnuadLPjP9uwZT710AdM0
         Y72WY9anXtjVkUr5t7Op1eH0EYlxqwtWCl65i/gTMDG3Sr83WXKzKC6VYOy2EtWBf8KT
         RgA2ntynOy2xDTAU1+m81YWvDcdg2PkfnAWQuwud3fuPPfgsDBaNzG5ytDokzGY8nfs6
         mmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778005704; x=1778610504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0J/DG3q3l3oTdmjlcJn4ywY61k9yybeZt0U6uv+BvI=;
        b=qL1OmmJlKrGiBcodTAyqU84H0rMfhEqiIrxOYn9CBl04HtwsRO9+tZ0mxzCJ475pO7
         1Q1xdDTM5uzFl2nMiY6+ZNXin3LFSkb+oyw1Dn3WBEzZt7AcQhMVdDj/MKZHnrscsYoD
         ePpfcYdDVFN+Kvbrnz5llxCdsKERpeP10BDSfmYd0gaJc7ja3qRD03vAIknVHXROUMkN
         3c30o3s+PIHZIZgxaAo5vTTRquZwPOcA7qRd1mc9CCxYrO3Jj4O6xnGLIXA9MTnaFdgj
         4A9CyWwecPK8zpy0WTRgHgEJeVxwn6rS+cWyIXICC6u+dW3oyel6Q4VjiryP7afx6rbn
         BfRw==
X-Forwarded-Encrypted: i=1; AFNElJ9SmOcqACYDJajTKEi4ge9jtny1ihrZZm5ct1wqLqQymRa+mHRH/6gG8aSHW5FEQgwlWG7kwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNdlqQcY3/TKoQrSHPqPDUPKvjBeZSvGS7bpc+2iMqX2tZMRUM
	QrAiZiucVNUP5o8U+s/FZlWVxmrvm+ynXLA4ruiFAlS72dnL4CL6r8bqncQINyctiWEUxoxRgmz
	0ZIDqRWDxKgjeuIZvY6DscNhto+59r1U=
X-Gm-Gg: AeBDietcD5fD//k7ctb/9u/NPaxbdhvndvtHmxgKSwUjGT2znX3oH2mzll8TZkOFmRv
	c5CM4l8Cw613mR/Ic2GtUljof7usCCS49XEY7ClekCebKxZGesF7nkr4y5sMtnrrEyUHxl5Xqdu
	MZV5sBymSLmJYu4w8Dwxjd1QIolN1tvqBUd4nbA+7GZlMSIBYFH+jCKGvffVPeZhDz2vsUpZQDa
	wFrJXYjrTQw7ODT+n7MWJK7WCoi9zpnp6QuV4vqfsfd9zaQvGSJJh9wxqSKfpk/a0nw/elWEy4+
	3rpo9DrhwhwusPqUPMics67A7e8rNs6nsiE9CiLShz9Q9VPaWIi7/sHYWhRI0yneQ8j/XCd34oV
	c26UEovGrzAMvnsW6hN37KspELv62GhX6VA==
X-Received: by 2002:a05:7301:6784:b0:2f5:2154:c7b with SMTP id
 5a478bee46e88-2f548a8c16fmr96868eec.1.1778005704160; Tue, 05 May 2026
 11:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260504111421.72130-1-x@2005.tr> <20260505082323.37335-1-x@2005.tr>
In-Reply-To: <20260505082323.37335-1-x@2005.tr>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 5 May 2026 20:28:10 +0200
X-Gm-Features: AVHnY4I1gAHbg4OBDbK2BRfiEoG_N6cd2k5zc2o6_6hC4CBMbryprYyf6O6Wea0
Message-ID: <CANiq72kGEB4769kC=-S8e6eY_xqwHTtmbuTvVqjsgL18SGPUYw@mail.gmail.com>
Subject: Re: [PATCH v3] rust: io: use newtype for PhysAddr
To: x@2005.tr
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Robin Murphy <robin.murphy@arm.com>, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 10:24=E2=80=AFAM <x@2005.tr> wrote:
>
> From: Favilances Noir <favilances@proton.me>

It is great to see more strong types, thanks for this!

From the other parallel patch:

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1204

By the way, please try to fix the email From header -- it can be quite
confusing to see "x" in the mailing list and other tooling... :)

We also probably want a few more `#[inline]`s as Sashiko mentions.

Cheers,
Miguel
