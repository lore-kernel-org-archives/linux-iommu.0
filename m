Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77860482EB
	for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766426644; cv=none; b=IkAJsECRc5iMS3BsLNVEgdFVMMYfv8Q/TcSxmE/HyqvAwuOyJ2f/4q0iT6F2DEaUpG6BASA8s3epIZ/L3dFziJSwQHS6N86mjcwwuwwKda6AVVlohXE0YHaHHd0gPSqykgrbyJjjWIWhEQwmtKtk5KhuP1EaffX3ea7NwjgU8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766426644; c=relaxed/simple;
	bh=qW1PBGCN9dgQd9kUUxLQm6/2UTFLawAFRozXf6u5Bp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzhZhVUX3Xlrkd2OFNHHbNslVgaPN0GYYUH28xM1LSMT6rROXSMwS4I22syBJDZ/IdvW7Wf1uPuwrshkjvupaXAmCA19ZDS8U+MBY0KwumrFgiYFC702+2FtbPFkO5vQcF2zDTVwB8eGiAMBRgRLf/xbwEKhG5CMKcz63rmRAL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fH6Gx+qu; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fH6Gx+qu"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b81ec3701so6148884a12.1
        for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 10:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1766426641; x=1767031441; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZCjQyh2/n37I6DOYRVdJimhupluxrLcKg6nqkNe62k=;
        b=fH6Gx+quDfeIl1XzYhARLH+P/5g6oS6gaTsEa26f/h3xIwB88tQP3TtEVZbbJ6/Aw6
         tb3v/Yuvm/sUkfNz3wzrvn44tdriFwlmsWRhm0GdmhZR7D5eln1fy9S63PNN4KlTJTMe
         qPY0F0iiRMllQb9uYB0Tg9zZKeo+tdrARlINk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766426641; x=1767031441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KZCjQyh2/n37I6DOYRVdJimhupluxrLcKg6nqkNe62k=;
        b=dAVGLb3LQsMx03h/lnP2TtXAhC9pK3edCchPk1BXwrlEf86bsRA5pvZSFlkARlpjc3
         I+XmFfty9o7RXnoDcuYfpgc64AoJf0xzuiFx+QTvhE1La1M4YzJSCoy4sFjm+03MNreq
         0TDlKVer3JOdPiOeXEfAZ2gvGss9AgUg4DpdO3wgW9sItjQSe2g5AkGVx/I+HNbHJpRH
         J7RNnUxKMsSIig5LFuyCYtWpaEOx9WskwyUodPstnK/9sBaDNf8Knw1d5jymhrou6Rgg
         51Yp622/wSaNNRIOWQnNdlIY1uZURuP5lS3MS6VJsf4Syz0qbAFfz4mZnZxV1rA9THgW
         PLjw==
X-Forwarded-Encrypted: i=1; AJvYcCUasXJwcYibDlyVgXuFiStcAzbR+UCzToGDaYMlG8vfECW07ig3EPp1rLU4xZ9pb3RID73VRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCEGVI4uWElXH9U/xGSdccU9vGtMSCDZsIscaxOcSGG9JtjUZr
	SVz7QzoobL04SOK2CfSWNwah3k4hRC+2wfe4N+IhkxHqcflZVZTl5yP5wRStxkYsyAV7w/B87G2
	cq9UNQ1g=
X-Gm-Gg: AY/fxX6R0nRJnDNjq/m7ycBZGzcxeU/4qJU+irlWNP/770soDUIYQ9+6ZGjDs4+Bwtg
	S/6DuwrypMdq8KZbaBY6eJe7xvdg9DcjvOU4DKd1hAAEy7dQlb2IkNMnIIDgZzRU6Ll8Kfxlq99
	P0xB+3JAKGMTtKAvcH7HnAC5lXDbi1T8F6z1IOhY0aaGr3qjIn8c10QUXaSINOF10Sl4mlYzIL9
	36mTAqj2/XFjgGTG7gC6pEuudpwjq0mKqeZerrVM7Bp21RBt1pMBWSPlOUTTZsKIIDT4IjeFdsv
	A9R5vdiYqYP6FltcjSx8T5Oi55JAvFuufHseV/8GQKzgdy8mzV717nZwRu80CvUp8VFVk5jVAKu
	4bcvzqDCqKSUZcEkHR9ryzT/Z6oYtEwUFawOGO46Eo0lcw8zgxqY5xT19/YtkZ+IBbgOMtLgmI0
	OrDbahGAaVxjfmbBXATLECt1gGhZT1UUGgxIYdazPsvuUXn7ShqxqWlLSAI+q7
X-Google-Smtp-Source: AGHT+IEeOHz8lUrpOvFqWmpF0XRuVekn+jW/p2VSalZ/CZBkk1DGDPo4MPZ8MzpHIwIzf8iwoOfPZQ==
X-Received: by 2002:a05:6402:1e92:b0:64d:589a:572b with SMTP id 4fb4d7f45d1cf-64d589a59f3mr4684169a12.17.1766426640587;
        Mon, 22 Dec 2025 10:04:00 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b916b372esm11146634a12.32.2025.12.22.10.03.59
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 10:03:59 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-649e28dccadso6839285a12.3
        for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 10:03:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgrGHa0OCtyjj7CiFKyDsqwGEUWsHxjWBY3X3TpBm/wIMWhWwEI60ZeUbFsFR/hJC8T+XmPw==@lists.linux.dev
X-Received: by 2002:a17:907:9810:b0:b70:be84:5186 with SMTP id
 a640c23a62f3a-b80371d66camr1271984166b.44.1766426639355; Mon, 22 Dec 2025
 10:03:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20251222160344eucas1p12182e7b47456263b0b67309f6c674ac4@eucas1p1.samsung.com>
 <20251222160328.2523773-1-m.szyprowski@samsung.com>
In-Reply-To: <20251222160328.2523773-1-m.szyprowski@samsung.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Dec 2025 10:03:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgpWEoW1VKZv-7YC_oftbqWXh3xERYBsjfv5dc-MO-Lmg@mail.gmail.com>
X-Gm-Features: AQt7F2rymZbl7OoJEn6SzyoIEusFWez7C5Yy9L06OHfhgnxCEnKgACQ9SWJ5GM8
Message-ID: <CAHk-=wgpWEoW1VKZv-7YC_oftbqWXh3xERYBsjfv5dc-MO-Lmg@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping fix for Linux 6.19
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Dec 2025 at 08:03, Marek Szyprowski <m.szyprowski@samsung.com> w=
rote:
>
> Leon Romanovsky (1):
>       parisc: Set valid bit in high byte of 64=E2=80=91bit physical addre=
ss

Heh. Pulled and pushed out, but in the process it triggered a
mis-feature in the kernel.org hooks.

That commit message uses the UTF8 character U+2011 for 'Non-Breaking
Hyphen' in that "64=E2=80=91bit" thing (and then the same character is also=
 in
the commit message when it talks about 32=E2=80=91bit systems).

Which is all good and correct, and I'm not complaining about your pull
request. A NB hyphen is certainly not incorrect here.

But it's apparently unusual enough that some of our infrastructure for
the activity feed on kernel.org goes all wonky, and that scripting
then complains about

   remote: UnicodeEncodeError: 'ascii' codec can't encode character
'\u2011' in position 90: ordinal not in range(128)

and I wonder if that's why I also haven't seen a pr-tracker-bot reply
to your email yet (but it might also be that I'm just too quick to
blame things, and it's just delayed a bit).

Konstantin - I think it's only the subject line that matters here,
because if it reacted to non-ASCII characters in commit messages, I'd
have seen this issue many times before. I'll send you the whole
traceback separately, although I suspect you can easily just re-create
this issue locally.

                 Linus
