Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36E5212FB7
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324784; cv=none; b=h6D4cjTI1arN2fdPLK97Crl7EA/7gZP/Q00MOqz++lbsv2hbhdbwrCANvyc+vXLkwrlvrDzJFvf/sLShEvb5BT/7UP2ivIvcyznTd0O3SLCgmQjg5ajBcAdj+rEw6PZRLgM5zkA0UjcE0vhX+5XkvHb/xlb3Cz5TKIv+hPZgQzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324784; c=relaxed/simple;
	bh=bI/yDH187i1TEFtT63Lyj88JVRKqWkgcx4WuVkji76s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6XJUedLX4447AfaaQ9aWHt6AH0llDZqI8gYDTzWq5+iAjQi/foAZYmxuO6nSNLqDeZSDhOSNHvUNmwXU3iZSkTkx6QIbONQkJa+szs864xgaKPPnBQwjpQFC8byLcO9lOKXkCSmJ8HdN0M+0DeNjXc1lliEWD7qekG+JyUbqxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+BW9yDK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+BW9yDK"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-225887c7265so11061195ad.0
        for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 12:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742324782; x=1742929582; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI/yDH187i1TEFtT63Lyj88JVRKqWkgcx4WuVkji76s=;
        b=H+BW9yDK6rZwqTyc5k/7ur1c8hJ48GpXbIRyB6PTLDTZTVuDbaXKLpTgUHBiDy5rb/
         fXN5AZEmKe/j2ZVy2+q9t52kGjAhKnwVkCAKD4Z+cnPR2rAAhQXXCVDc7yop8gO9t+w1
         UBtQjoTGQrYRbaZV88Jv0rS5xhlkfRedf31/9h25fjyjmqtckuCcwFPInGwI9IU63lMS
         LJjufMGGppB96irZBNCEEmOAxTTUoKTotgCcaMnDEGeUQrvtStlujFMgmvkv2aNNforH
         J84WRwQOjKeISiZbPjfTo60ChLrgLVdNC3vSqyt63/lQiDTeWAnFCiriRO2/QRQElfSH
         q+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742324782; x=1742929582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI/yDH187i1TEFtT63Lyj88JVRKqWkgcx4WuVkji76s=;
        b=ggKjkKVLULLmURATEt9zzLYCK00vZ0exwyND3H1lqPf0Dy496BybzOjVspDGAAZXy0
         kZJXzTeqljkl1e4tjVNvNq3x0Xil42Btm06ZMyBqjLqBAF4sIQS5x8tyij0e6U6DvJ94
         N892mhwZ7CgK/+KNeiKAOF/5WNaDH+ls/eGlypw+9ixDsQ1ttoydzTbpviD5ZdVDGkSo
         W7ldAR8AYy0TOfX9UlnRJv8xoOzvbJme3j+aWCRs4gGSLpnO69CL6HfM50A+t/ZLDEgh
         JjDneaE6nAxDIHpUntojyLPN/Al0EmBbNQleV5SOp+iwY8acw3WVLrN1biQJBpktD6AL
         K9wA==
X-Forwarded-Encrypted: i=1; AJvYcCVsI/wRGrV9A5iE8fFCQYSafz1PuNYwTPxgqo7m60GyWeCmLWlQGDtMjnVVOyAMFPXb/MXaUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNWIumjg8MTWd5uCedtB63enEcxmQ1eNlb5nH7oQAOX7u/Sd6o
	aCqTrUVuen102Tk3KcF/pTrlgSkSQR8Ls6US8HN5gXw/+mTSbbgforFvWhr3Kq4zEJhEcsuEmw2
	L14on52W0KEd77Ph3l/ODcNV94a4=
X-Gm-Gg: ASbGnct6yJ7J0No6WoNgk3ny6M9R2/kJPFnPHuhBFmYFVXYec2OVnesXCuJ5+p083Kv
	iG3s+rW6i27nB6LFR5b7ZiuISXld2Zvd42/TMSOzy7KXhIyHEiFx6j6gk/NLZXVNMRPzMAsz4gC
	zrKqSq3EcQKyJWjLTzV1cEktuOwdqQLMxiq4/3
X-Google-Smtp-Source: AGHT+IEyseFfbEvwp2GqBH7WmkpfutX2mV5HknTlvM0wky98GPTBxhLW+WH/hFNotYCPow7EvEBycv8/VSwxmHUWxkI=
X-Received: by 2002:a17:902:e5c3:b0:224:2717:7974 with SMTP id
 d9443c01a7336-225e0a54ed3mr86815535ad.4.1742324782099; Tue, 18 Mar 2025
 12:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
 <20250311174930.2348813-4-abdiel.janulgue@gmail.com> <87frjajwq2.fsf@kernel.org>
 <03902487-5cd3-45ed-b3cb-cabfd0ac5cb7@gmail.com>
In-Reply-To: <03902487-5cd3-45ed-b3cb-cabfd0ac5cb7@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 18 Mar 2025 20:06:09 +0100
X-Gm-Features: AQ5f1JpKqT0k7rk4CgIyNE57qiW3K9pAOdJs5FPuC9sjlSncOTjWB4gkzDRk9Kc
Message-ID: <CANiq72kjTTAsQTG4S4WuQi0Udnb+2v=gK8mOTWBhprMsGev3jQ@mail.gmail.com>
Subject: Re: [PATCH v14 03/11] samples: rust: add Rust dma test sample driver
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, rust-for-linux@vger.kernel.org, 
	daniel.almeida@collabora.com, dakr@kernel.org, robin.murphy@arm.com, 
	aliceryhl@google.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	Valentin Obst <kernel@valentinobst.de>, open list <linux-kernel@vger.kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:42=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> Changing `dma_read!`/`dma_write!` to return `Result` is probably not a
> trivial change, would it be okay to have this fixed in a subsequent patch=
?

Yeah, if you feel the need for a v16, I would suggest focusing on
changing whatever is essential only, since I will be applying the
first part of the series soon.

Thanks!

Cheers,
Miguel
