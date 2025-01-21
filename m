Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309B21DF961
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453345; cv=none; b=oXMeQqjT/0+Y3pzPmzpipLVOUqPwJ5yX4PrIYYhQXxGpGwEEDPZONyZ1LaWlRVpsFriwaIu4zHG4qPbF78VVpmTU7JGRfGXi/3m+YBJP7ICE8co7W4Mo+hHLlDC+k+SvqInIaRgw3FnvP5tVLZwbqRlkpEXt5TtONlpiC0c8n60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453345; c=relaxed/simple;
	bh=8PXPzOwbrsC9kILUva2YUAXRsm8M3PW5xczYUTLbG/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNCabDCgEMSPAn8jJYHi6mew7NhG5lSKwPZBfnuIJUgAjaXhP9+Ef+S0DZ4R1xklfB/080QJWIgzY+IOTEdH22rxWPU97N1mrjum0jjhPW/vJW8l0XnyJzrY4QXnqxFT8+5JDeyKGOZSSyBHzhSWXAxxBXSB3lCnvvrp/KbAvyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RgpfrEWF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RgpfrEWF"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e06af753so2673699f8f.2
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 01:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737453341; x=1738058141; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PXPzOwbrsC9kILUva2YUAXRsm8M3PW5xczYUTLbG/A=;
        b=RgpfrEWFi20bWKTOcfUhhvewRn2cnHOVDlVPw5Vx8fMzEXUoAs5GhcneslckZhRXPV
         quEnF8FdqZ2vzkaAYLMTFZgypSDxV6aCtNcJe9B8xRrb8UhLlw9ePDJA6mREimxYSNIu
         J3vPM5YskI18+H7WLBmzTHV/ZqUxi/Z2GXQaut1ktIFazdflbapILyNWuvPaPY5EK87E
         ovhtUioasVyTn3sLBLfaA/INjVZx3PLZ59DgDDceGOWsBiwqLKrfS6Ht4BNfgMOS08UV
         p8a79XOBj6YBVvETjDfe2F0VeROfPFRuLSGkcNTX9Jo2SRvnICRvegQyvWmEVRdGziVE
         Q3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737453341; x=1738058141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PXPzOwbrsC9kILUva2YUAXRsm8M3PW5xczYUTLbG/A=;
        b=OKGd/5PA8gmrpmm17JD0zU0cWY+VlpChc9gDs45gd7zJJFKww91CvQkIShFMkr++kf
         Kr6A0xvZ+myaw4/cbzhJ3AJKHj0Pf5OJFspM9x2L4JOT7ZlErM7dRwNquejZG4yyNqGD
         JbL8DVrjKYV3ST1MXjPrpaD4vAecTIZOCv25R5olNVo/A5Nqd9yLqO1wZz8VQ/9GwrdR
         cH7OKEedyi3olqWydB9PhS+vLgjBJgdeCb/scUx6KkvKEu3FnRksjHOSUc03th/lDdli
         auahoZ1OcJk1iE9pNkSBqYe34xpe6oy4Fx6BgAK+gV1OxLhOvNOC6RS64VexZLOkCIdp
         AH2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8Qj/0HeDjDekzxJeUCrARdvx622qwGNEsHoBD1hOrYtNorcQ3zR02ppqStXQZUepKB+HkMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZUlYy6WYhd1bKvox1Tgm+XDF0oaHQG8yGobNw/Uuq85drJvKg
	+ySNQHemqmgDh2OKO5zu0KO5P2HdqvcZzgiubtP6kZ8fZYGkJc4MQyGQU9xVGUqMo2DE5B0KIg5
	cWr0/zBgljAqBslc+wYag2COYrSMz18wRBDKd
X-Gm-Gg: ASbGncuqDphHiFM7TH/SzKPB6TXAnyumtVL8ydoaO/+JUTNg9P9xv9tlRKWuGXjXX3H
	EKtjea3WBEqMQlvklN77z6hS5vlGUdd+6wRiueFLw4ewOldoJfC0bLUE0tQVYRVmsPEUFT0+D61
	bFfLIEEw==
X-Google-Smtp-Source: AGHT+IE7KopMuvJB/37YGrU0+CEjSwlbu2NZ86YXc4fNcHk67SaKLR8AsHv99obklcQ0QFTCU4fwx+AhGp1sNJwYwbs=
X-Received: by 2002:a5d:584d:0:b0:385:f7a3:fed1 with SMTP id
 ffacd0b85a97d-38bf57b6717mr16579665f8f.44.1737453341430; Tue, 21 Jan 2025
 01:55:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250121084756.1051758-1-abdiel.janulgue@gmail.com> <20250121084756.1051758-2-abdiel.janulgue@gmail.com>
In-Reply-To: <20250121084756.1051758-2-abdiel.janulgue@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 21 Jan 2025 10:55:29 +0100
X-Gm-Features: AbW1kvYQlWV5FFQMfdmH_H_nGi0poXEpd85_Sr1sW-ET_ThW1oF8DVJ5JvmSYzY
Message-ID: <CAH5fLgj6TAHhSQWJaK9pj1PAU7+dbJFHURd_qa8wgFE4syBxTg@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] rust: error: Add EOVERFLOW
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com, 
	dakr@kernel.org, robin.murphy@arm.com, daniel@sedlak.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 9:48=E2=80=AFAM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> Trivial addition for missing EOVERFLOW error. This is used by a
> subsequent patch that might require returning EOVERFLOW as a result
> of `checked_mul`.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
