Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0801FBE9C
	for <iommu@lists.linux.dev>; Mon,  3 Feb 2025 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570649; cv=none; b=ei1V69CrfDs5Q++p/fb3NHthY5vDHUNAROpYSQ9Q9g4pLXy8FSnBPkGfgy3OyAVh0RMYFrRCP45bAfJnuQo3REaufpG1SQzDV5G6/GEv0nlW/Utn5n6GvQWa+fPSN4/neZhmkttoliND8U+ootekyzzKB8tOaqO1vcTeX7piy1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570649; c=relaxed/simple;
	bh=AxxM+Oghro50qL7SrbRKfKWGi2Z4tqUKdB9L5D5SM3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBKHg1nn3itDfObirO/coaaKDuEj0WYsHxwlcwyLZ9UtPEptQxNgPqB818Of5Rn8K1YtiHSYLEgUKxs0T57HHC8yCSjlO/dbl2mcyO57hqEB/dJ3S70v9E2WM++vGCdXQ/gnT44VbNh/EWH9ZqzbRI21CX6+1b3rBIZFGaEJi70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCIEK5+A; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCIEK5+A"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-543cc81ddebso4836675e87.1
        for <iommu@lists.linux.dev>; Mon, 03 Feb 2025 00:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738570646; x=1739175446; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwY9dmn9tpB/fEfgIGlxZgLK8oRB5S74OHPETM9i7n8=;
        b=iCIEK5+AD4Dgm5GJB68nswU9dlZyCwxrYXvDKTRAlQgNQWYACWkohE3L0e/v7SPSfe
         4TZ66b9kbsyMkqHujuhWefvDuOm9y9Bw330tM58aD6W9A9xuBRQE7clRkQ58tnboGhLN
         AN5DcdOplC7rkSrXfWfnpHYkLxEapndKDnlEqFtD8zAmbeaVexH5u1g385Z7tRevzrcx
         STUWk65+Enmkp1afK9GtEjkmMEQdn+TpSMBz62lkV142DzY2ZRfPD1PJCqZHooKJkNXn
         0/ZG5UGqOKHs4/zYA/rUs7J1EgTGRgixMZhhSCOwP0lSfcuMErxxBNYcchVVEghFR0KD
         CzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738570646; x=1739175446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwY9dmn9tpB/fEfgIGlxZgLK8oRB5S74OHPETM9i7n8=;
        b=awYTruhcK6l4s2/8OaiMhrn+ocGOP1xS3s3UbgEo1fhxazDeMgp5ibH26V4DOpxo3e
         b3zmD/ytacVtJiJkGy4SVx4Opr52w6pwY7tjm0i4z5b/48dv1Dl3pNnzce/iiVOq7gzz
         Ig7zgdpzKYo05fmSuqHi/+hfnY0JP0IuXdpy2ms0Lmupg5ciPJ9oRFy1azud7+mrGxOn
         DsNMZknQrsZO+au4O1okGAJr4RwFK/XKHduUQYDX6a/1aT3l12ATti3KakEyQzRBtBmw
         z14CbgUG2wEsjAT9IkOA31xryiDUBtuzfK3S6bI37LmW/Qx2CrLkeQqn5sByu3Sl7bLA
         FYCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWabGaeYdZJJTwvDeW1uJXsZOUwFmIcX4QySmWNk31koPxDMwlwbUFUwIggCDuZ4sEQTsk3JA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7OceVFLbm6LqpXH06+byeywAg4JQp7QWSTJ/IKY3MaOGQpbMV
	ECGKCbRts3kQwT0O1+5V/jP2ZpIknHNqzoqoS/htpZ7Ueizyd5Zq
X-Gm-Gg: ASbGncvedNt2rkHwv3sxWeOy8jOp27l6MjzALQcHYUpY6jIlW6OyKDNQiNftfoenlu3
	HzozcoaMIfVenlSxsWnDlG7i27oM6Ws5Ng5HP4KWo56at1V8FYWpd9HyKQkzOjes3Ljr3xyPcmG
	R55A6c8p/A/UVKeWwkfdi7Aw0tdbZJUVIxR6eELdoTb7zexHIoXngjO9CmaJ6zQPq25aKmoC8xS
	0z2Ct6CUROWfXMn2GRGK7Z0MMSrSUM9bXdb3MO5ILcplS0P/yhntAI51ktoxIhg+TXgEa+vp33A
	pa5YRZLSI26QXOlVK3Jbr2Uq+JZViV5UtWsJ0WRDPnj7KHu18zvwJUol+ibCIg==
X-Google-Smtp-Source: AGHT+IGKBQ+wd7FfWEWtUosmj3C2VaV+XSwzA8bbZUlfkgoRAt1WJR3dEXACCIH8JBI2gdBWC6ZcMg==
X-Received: by 2002:a05:6512:3d21:b0:542:234b:9a6a with SMTP id 2adb3069b0e04-543e4c32c2bmr6941786e87.33.1738570645823;
        Mon, 03 Feb 2025 00:17:25 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebe0fbcdsm1242277e87.60.2025.02.03.00.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 00:17:24 -0800 (PST)
Message-ID: <c3a56770-d483-409a-8586-610ce6a718e7@gmail.com>
Date: Mon, 3 Feb 2025 10:17:22 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
To: Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 daniel.almeida@collabora.com, aliceryhl@google.com, robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
 <20250108151858.GB24499@lst.de> <Z36X_ZnCmBQBMoZ6@pollux>
 <20250109080812.GA20431@lst.de> <Z3-NqwAG_96yq8VD@pollux>
 <20250110083955.GA5395@lst.de> <Z4D5a5NYrAbNxUL6@pollux>
 <Z4kG5AcVeQKegLnb@pollux> <20250128092334.GA28548@lst.de>
 <Z5qeoqRZKjiR1YAD@pollux> <20250131075751.GA16720@lst.de>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <20250131075751.GA16720@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 31/01/2025 09:57, Christoph Hellwig wrote:
> 
> Which doesn't help me a bit.  Every additional bit that the another
> language creeps in drastically reduces the maintainability of the kernel
> as an integrated project.  The only reason Linux managed to survive so
> long is by not having internal boundaries, and adding another language
> complely breaks this.  You might not like my answer, but I will do
> everything I can do to stop this.  This is NOT because I hate Rust.
> While not my favourite language it's definitively one of the best new
> ones and I encourage people to use it for new projects where it fits.
> I do not want it anywhere near a huge C code base that I need to
> maintain.
> 

I do acknowledge your reservations about the possible maintenance burden 
due to the introduction of a rust (or another language) consumer of the 
dma-api. But I was hoping that we could arrive at some sort of common 
ground?

If this rust middle-layer abstraction is unacceptable to you, could you 
perhaps suggest a solution so that all rust device driver don’t end up 
with redundant dma coherent allocator rust code? Could the rust team do 
something about it?

Thanks,

Abdiel

