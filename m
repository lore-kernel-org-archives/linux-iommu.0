Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612FF253F38
	for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022123; cv=none; b=jKRUXlXpqkKhS6Bt7F8u7/8FIEp5kmVJB8fpsP7ypHNt34EQzxOxaSicOe0DmQAcM+5uw5NTBGyDiPNeGw84CGJmi7gNBkAyE7K7AQE+uXPeOS19ln0JzjKyZEREmXvtVxkAVvg1MnmdgP7OeNiyNpH2uflPW4fYn98iI8Fp5uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022123; c=relaxed/simple;
	bh=WA5K+7T4bGA2EQSuajb34nL2J84mbXlMPZ65nIWTCMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkUNpNqvRIBx9vV2K+4xwLSTrYnme3IRlAOnrw4qGn+kAekYL37o2Xsh9HY4WVhAyenj7rkwA53tXl3bbYVRfQK5gEJ1kGiYp2FhUzy3LbQyYfMYhxzTnOCrzh1+/JDPI0Urors4AmWUxvOqbil/C4Nn3o1+yhI7HNsZr3KGvTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NS9I3miR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS9I3miR"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2264aefc3b5so780785ad.0
        for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 13:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743022122; x=1743626922; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WA5K+7T4bGA2EQSuajb34nL2J84mbXlMPZ65nIWTCMg=;
        b=NS9I3miROBRpJ6T2wh/mXVtYCfoMjlO1gqrpaVpdPB4h8NLSzw2XZ61QrHT6jwpAy5
         x1nPM/gsNAQ6uj5Yza79tLMo7eY9x83vgMmPfJcJ95EyLhLfZ3HSNxTq/k8IhJgWnvkK
         PKP2pEfq/nwvVyA0+PPjt4nu/wJI8jRJk+iyj1H/PC6JuXjfGcKR02D+7tQ4QC2rGjrW
         f8G9bFauCmA/E6Uq5AE0ufsn/eenMIkDZEyuZDrb04AsLlw7a2awIC/z9SaqQN92IhON
         OuW5mTZ80ENeew+zT3X9aYv04fvvLQvFzs8OZmWZC1GhiKpIjgmMUaWpruJrRVocJeJB
         cf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743022122; x=1743626922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WA5K+7T4bGA2EQSuajb34nL2J84mbXlMPZ65nIWTCMg=;
        b=pwO2KodpRILMujetSI+ea8UeIUdqGfcGoSupvu4LG8wvmTsqjbecb4pxQu5nA6PpRN
         7wkxt8QFfdADhb+aReAU/L9ILh7XwK2hZcZZfN81vYnPqFy21pjEhon+ei7uD/nRUiEi
         lUU5VJSrGsDAaDQ4G3AZBxlERkAALtcNQ6sRqy3VLEC4hnGYHif/4L3eWLqPD4n5FFVd
         o1rOaxKYl8cVf8gE0IAx6CrrkLJRIaRnsKO6nrm+7PgkJgOF/EDFOXKSrM9jj1PJSPm4
         YkWD4GGY2014TscMCsx/pMeaWozU7jigC5DmvrTAe5AXoJhG5yk7Gb9DlJV6NWHhcHcg
         OFFA==
X-Forwarded-Encrypted: i=1; AJvYcCXaFNTCe3JuL2rGmwPEAtyeOleTUNf9ZduOkdTVKpSO0qwvSC+BMue2HtnKsEXJ9bUNxWhN9A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYU+8GlNprvbjDE2o0q0YE9dEfUJuq/zPtik21sVJ4XaGXUbs7
	trJOQdf5Ks9JCyyQOpr8lakym9mIh7sqfnqSwqtyt2M3VksbWkndml+urG1Jkd7NXkrLbWZamhA
	+ShEdwlm6Yd9qATKgRdlOU7uD4Jc=
X-Gm-Gg: ASbGnctziffP8bgPsrcPjYMLcRfU0Y0jf0+paAMmyEKhQjtBD3Rv8nxVfC7AH2ZcXCl
	SKuHiZlXq3tjr2edkodqEc6cwxhfMCQHsdKHvQ8WpuDn5+TDai8zq2lPd/94W4KtLmsQoXXmZdk
	KbA1f47o7QC+Cv7o0FlCJI8ij7
X-Google-Smtp-Source: AGHT+IEkgyd0Gw0RYVd7hriwBM8pB5+QBTlDc75EX5QoUKCuGmCDXcwwiHJreLAOJyb4Rs06wgOreHMsKtnM/6qI/Ig=
X-Received: by 2002:a17:903:2343:b0:224:252c:eae1 with SMTP id
 d9443c01a7336-22806880276mr1811855ad.6.1743022121703; Wed, 26 Mar 2025
 13:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com> <20250326201230.3193329-3-abdiel.janulgue@gmail.com>
In-Reply-To: <20250326201230.3193329-3-abdiel.janulgue@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Mar 2025 21:48:27 +0100
X-Gm-Features: AQ5f1Josk2qyDu9QczrMqqIYKYpwwuKnjwLwKqau9a4_X5mWRfRxRycStY1Iryo
Message-ID: <CANiq72mjGf1pBG7PM7fKJA_EZkphp5he2H9pvg1mxJYZb-WGxw@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: dma: convert the read/write macros to return Result
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: a.hindborg@kernel.org, ojeda@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, 
	"open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]" <rust-for-linux@vger.kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 9:13=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> As suggested by Andreas Hindborg, we could do better here by
> having the macros return `Result`, so that we don't have to wrap
> these calls in a closure for validation which is confusing.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>

I would suggest:

Suggested-by: Andreas Hindborg <a.hindborg@kernel.org>
Link: https://lore.kernel.org/rust-for-linux/87h63qhz4q.fsf@kernel.org/

Maybe also consider if Co-developed-by etc. makes sense since he
provided the diff.

Thanks!

Cheers,
Miguel
