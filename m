Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF627FB1F
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730932; cv=none; b=KYjdQYL+SO3X8R52+Y4FLbNzSKXbKHsUJcZVsuat9+1o+g/JcFVg4c/xt1W6rRURLSIPXz0OKzNcDuXubhBTZLGPQ5Z4c6rDAVfB6F19ymqZ8TFbQ/tgXp4RYTIbUGwyyttcm2XeyztPNO4OjOsQS27sKrHZR4aaxSlTXcpI6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730932; c=relaxed/simple;
	bh=hZMqDOiBhVT6Gqfcrnl8FzxYs8BKqFbsfne4yu/5XKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ui2Wm2MlI5eG3DM9hnJ6/KJW8KR74LpNrx9GDybWXRSYk1fP9FYNSy+ZCdg22WAvqza6IN8A1gvr9DQi87BTVODLutot5wbK14pP/XXyFbM0tqdl5Z7iJsuJRHKtiseBJ4PFPvbcyOKSDfyiEUm+w7TazTJa6aKwXvmc9ix0KLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=stU8xlUD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stU8xlUD"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so18176275e9.2
        for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 02:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768730930; x=1769335730; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhEepC620f7PSurENGJkYTsztzKlzLPGFJM6HD3c33o=;
        b=stU8xlUDuQhGuCi6hUvAAgZJwQqsNts/PZxwE7KE10CB/b4zTDZHVUB2OA3LAj/ZcJ
         nxPtiL4AWq4VI3qWjg97q88eFPhofUDHeiRp3KLlV1wv70ZCy64Vg7OCy3xlMXO5rLzx
         vJ9SzQq1I6UE66ONE4GApfQl3wMrwXsMzLgDxx1Fukjs0uUHpReSTWUqzOAmNoW1ynxs
         v2EmIaIeSw0hP5Ry18XiBONFuukhn3lvMEugybubB5XMlB12mNyi4xleBuyfD+dYNq1U
         9JXZNzlhg/Xc3XJ9DYGbKCP37X/uDl+qo/e5Kpx58bfMrQhyUrbAr14bIUIWtH1b8QAn
         ly6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768730930; x=1769335730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JhEepC620f7PSurENGJkYTsztzKlzLPGFJM6HD3c33o=;
        b=owh9qjV9dLbDNYhUxn8V+FUK/wwNLvOnb6x2n/XHuBXRRzObFPvg0L+uyvrLYQIQp9
         aHKPNOlvRsG5J5+WY3C+zGZx7ycJ0TAShnyrkPhVDZWXfSD+0czV9rqBcpqoddHKsmab
         Q8r/SY5MpBG4beHPQHpk87n+nzI3cQckBICWFQ1PVoHZJ/MUuqTYrlvy6bs94CpivH70
         NIX49chqXmM0koX0iUMspc7o/RN7kINSoiDHuNZsCji113F4gaeawszsrFDk0q9tZ21L
         DAa51uZx0G3hZER3ra2o/bguUXS6KXz5eIZSmDmgk9mLcNCPi/MRRk0LmyLEKMiU0i/V
         5aMA==
X-Forwarded-Encrypted: i=1; AJvYcCXN+/KjXyBlGHR5CDcihZrddvUfHxqK/DT5/mEQsCb3iMGNTnnMWP+Gc2YtCgSw+r8iulEFNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YySGK8IHGBkDW51VY4RNb5I3+CwZF8eqen7LKA2Ie/07KoQ2ti6
	p78I3BF6GG2nIFVwm3jwfSgcsyeX7xLeST5vCDPNTk+josbeSAJYFEONloyfCt0JbUNXPqkdrax
	eZCFPCg7aqPqq396zTrLe2jAG9eqO9vb8HbhuHoIy
X-Gm-Gg: AY/fxX6Cibh0gFj/w1oAbqvLoetkWwDaiOhl4YUOoXDE9ppGd2D8WjfyrEcMELixYTj
	MM+JuzL7kxvtlHloGXn1vcUrx20DcrwoLKyVYd8lIiO2D2USwm6lqTTPtgn2Zdc4hl+z3U4a8Se
	er0b3jqXq2l8KFrDesxH3voR5bU4wp4vCsKcV0MML72K7QibPtN+5L4a5qbD6I5gIDH2m3KpYLU
	bxBOfeVlgj42/TgS1uC7bcBXlzg7F22JKnlJXmY8PFLnpeKWO2nSLKX/yjYxK026fVFaF18eUXX
	TWRI72m7apz8MCTPgE1l9d2bWGo0ZAuGlr4D
X-Received: by 2002:a05:600c:5486:b0:477:afc5:fb02 with SMTP id
 5b1f17b1804b1-4801e33a82bmr102416435e9.21.1768730929647; Sun, 18 Jan 2026
 02:08:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260113-io-pgtable-v5-1-7ed771bc3d8d@google.com> <swz2lj4xhs6vjmjs56aj5u7pbk4uaqur3cqt4zoybqrx7yckg5@ifu7j7i2fmco>
In-Reply-To: <swz2lj4xhs6vjmjs56aj5u7pbk4uaqur3cqt4zoybqrx7yckg5@ifu7j7i2fmco>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 18 Jan 2026 11:08:37 +0100
X-Gm-Features: AZwV_QgEnja4-Py9gRSQ--EfuDMdE5KO9EC5s-5Nzmv9xxOLMF8VJHFVFbHfPAQ
Message-ID: <CAH5fLgi3sPq5BfkPWJ0ytqyGx7hKb=4GsTcX-ReVtEkKG-re7Q@mail.gmail.com>
Subject: Re: [PATCH v5] io: add io_pgtable abstraction
To: Joerg Roedel <joro@8bytes.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Asahi Lina <lina+kernel@asahilina.net>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 10:50=E2=80=AFAM Joerg Roedel <joro@8bytes.org> wro=
te:
>
> Hi Alice,
>
> On Tue, Jan 13, 2026 at 08:49:27AM +0000, Alice Ryhl wrote:
> >  MAINTAINERS                     |   1 +
> >  rust/bindings/bindings_helper.h |   3 +-
> >  rust/kernel/io.rs               |   1 +
> >  rust/kernel/io/pgtable.rs       | 276 ++++++++++++++++++++++++++++++++=
++++++++
> >  4 files changed, 280 insertions(+), 1 deletion(-)
>
> Thanks for your contribution! I'd like to queue that for 6.20 but agree w=
ith
> Danilo that there should be a dedicated iommu directory under rust/kernel=
/. Can
> you please move the file and send a v6?
>
> That directory might some day also contain everything needed to having fu=
ll
> IOMMU drivers written in Rust :)

Done!
