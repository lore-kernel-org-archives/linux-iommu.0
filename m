Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9032F12D4
	for <iommu@lists.linux.dev>; Wed,  8 Apr 2026 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665369; cv=none; b=ikU52IPrBPDEorZkVEtn9oAxQx7yZZb5o53MmTXB33zKFtnWmmqWREhQxmLEVDouzWuCZ04i6bQxCzE6dCZeV05wHeXrHYSP6r175gTzP8gSyj+qyPTJIll02YIIB94/yz25zZT0+LwJ8atPlu/jExISmfLKlyz4CB7KpvG2FYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665369; c=relaxed/simple;
	bh=MbK2EhOyylLAxU2Q/eHjdaz1ad4dnrnqpmOeagl6cGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXcKTKzicFt8Tj8Q0ha/1S47wvKktYmB+p9k0HbsxqeBW5a2xAjntSUtaPL/VmzNvXLyzR2LFbtwiBzFUYQnBFHg03i1Z02aU1uy8B57IA+oq5sMdLreD3ojJzuCn6ePynKOZUS3b7Vtxpi9bsizmcvu6FXRyFYteDeLHJBR84U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fqs6cJHc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fqs6cJHc"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b980b35534eso188878766b.1
        for <iommu@lists.linux.dev>; Wed, 08 Apr 2026 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775665365; x=1776270165; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FrJr1968WuvXLCx5E+q3h8WCNbUNL7Em2uQzgCx18+c=;
        b=fqs6cJHc5VCltZYsvtXZFABXTIUOGLt2/IQVHkxQpRp6QHX/vDUqXIgfmemnlGaSJD
         bsdnOL8CFR+lrfTHeQU0opZgbv59ClaFwebbz0o8maoADffvepk1ix3DtAwpVAgLXBv3
         09k0KT4p5XgToLVAHzZa4kzjdNRre2MCDoVF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775665365; x=1776270165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrJr1968WuvXLCx5E+q3h8WCNbUNL7Em2uQzgCx18+c=;
        b=LO+DtSKg+YYYVsp7yd6ZGeKq7ffZ3fUiztud53qUZ3FHA5zBY+qaEPBdwuuSYkWfZu
         2oAKNwIlz5CChqqm4wNB1zabQIy5DT6HNgyjbgCi+9qZBQx2lPTzTmUTT9sD0TONVMeh
         92BIoLpkdAcZAirCRFLC+/GXA9wyZB/+PhmZq0sgqAPTit84q5CwaLSuaSqUBGm6Ap1w
         ya9W/jvRjlc2mYPpFImdURKSo6JW4kAO4cMIPgQGv7Mr7rk0Awzmq7ROBTu4T1IFg093
         4aqD9brpJ/YN8xxSWn4hfKPgvsNX5iT4NyXiZqEcwWwS4w71QDVB/IfBwkAIRLZ/SYq2
         Q3vg==
X-Forwarded-Encrypted: i=1; AJvYcCUufjAkWzp8Oh2+8Jk1Bu+fdmhnTRFAi8+HMq5idYYpPEx1wEiuGFuobYrvmw+0x+aPNkyv/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwF44e4kwj3QvlFe9VgoKAdGZ6r6oTayJll1ZR19Fd17SUPg3il
	5BAF3iQkJ2QtaAlVAOOsArAv5EgPwsbE3ZvEiWxw/v51uyYUg3FefF0/bH+cHTHI5TO4DsXe6kT
	cMrLVArY=
X-Gm-Gg: AeBDies0x/h1pTro9FOJWSR3bKkImeyn7e+Mb03vvSI+ug/qWfswpbgmYrsYU4Yxhrw
	0eMBxqD70sWEVzEezCNhdnvvRtPYG6p7/oG1wpC1/3AlZbzNi89wyA8aOuo4F26VwXEN8r6m3OS
	OTVdewcvGklp4cCHCeAb1hj0qwPwJ4WjgId/QTldgJqkYX4mq9JGpWxcjsWC7epffsB2f9vSO/b
	atDmaNE9wu2ZjFXSaWH583N1R5spuzz0Hhjj8jT6d6Ts/3f3Z4Hgl0FR7ww9PGTWufhChEQbGea
	OwFYWIQJdJISBfNRFqEVhfRAFL1upodx8LXjct/sNnM67tMYpapUucmSH4+PBN2JnGJ7sr0r5PG
	30IXLeVUt6fbdJsWgNGc7anuZYTzxKPW+o4YZItUUxUgZN+gJdlm+l90zEHVsoJhxZ6yhJUObZv
	4Dp/sCg2HmOvewus7Q8Z7c9a9xj6xRgr6R+nwu+ipH3vymRwEvag1odrOXAkHskpxp3mJ5GbTr
X-Received: by 2002:a17:907:d06:b0:b9d:14e9:d06d with SMTP id a640c23a62f3a-b9d46062179mr9110166b.8.1775665365525;
        Wed, 08 Apr 2026 09:22:45 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3ca9abb2sm665341966b.24.2026.04.08.09.22.44
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 09:22:44 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66d65646c65so60975a12.1
        for <iommu@lists.linux.dev>; Wed, 08 Apr 2026 09:22:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBALa9i5p4vmc/aB6rB1Dt2fKdxJ7SfPRQx7tQPonij4ibP9Nxiys2+7Ud7/5tztzdKm2aiQ==@lists.linux.dev
X-Received: by 2002:aa7:da5a:0:b0:669:cbc5:db7e with SMTP id
 4fb4d7f45d1cf-6700a57ee26mr52955a12.6.1775665364063; Wed, 08 Apr 2026
 09:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <adZTGOjjJrVJOcT8@shell.armlinux.org.uk> <adZfTi3R6jtsjXx-@shell.armlinux.org.uk>
 <adZ9grUg71f518Fg@shell.armlinux.org.uk>
In-Reply-To: <adZ9grUg71f518Fg@shell.armlinux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Apr 2026 09:22:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgvBPt8b204E49qUfK5F3otKzV==4t8Z=6_wXO6vgWqHw@mail.gmail.com>
X-Gm-Features: AQROBzAZ_qhfjZYeQTD5IRVziYmZuTFOofH8RWcCNS0y3LUoXT4zBJ_T9EYFJb0
Message-ID: <CAHk-=wgvBPt8b204E49qUfK5F3otKzV==4t8Z=6_wXO6vgWqHw@mail.gmail.com>
Subject: Re: BUG: net-next (7.0-rc6 based and later) fails to boot on Jetson
 Xavier NX
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-ext4@vger.kernel.org, dmaengine@vger.kernel.org, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Apr 2026 at 09:08, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> The rebase is still progressing, but it's landed on:
>
> c7d812e33f3e dmaengine: xilinx: xilinx_dma: Fix unmasked residue subtraction

Well, that commit looks completely bogus.

The explanation is just garbage: when subtracting two values that may
have random crud in the top bits, it's actually likely *better* to do
the masking *after* the subtraction.

The subtract of bogus upper bits will only affect upper bits. The
carry-chain only works upwards, not downwards.

So the old code that did

                       residue += (cdma_hw->control - cdma_hw->status) &
                                  chan->xdev->max_buffer_len;

would correctly mask out the upper bits, and the result of the
subtraction would be done "modulo mac_buffer_len". Which is rather
reasonable.

The code was changed to

                       residue += (cdma_hw->control &
chan->xdev->max_buffer_len) -
                                  (cdma_hw->status &
chan->xdev->max_buffer_len);

and now it does obviously still mask out the upper bits on each of the
values), but then the subtraction is done "modulo the arithmetic C
type" (which is 'u32')

In particular, if the status bits are bigger than the control bits,
that residue addition will now add a *huge* 32-bit number. It used to
add a number that was limited by the  max_buffer_len mask.

So the "interference from those top bits" stated in the commit message
is simply NOT TRUE. It's just complete rambling garbage.

Instead, the commit purely changes the final modulus of the
subtraction - which has nothing to do with any upper bits, and
everything to do with what kind of answer you want.

I think that commit is just very very wrong. At least the commit
message is wrong. And see above why I think the changed arithmetic is
likely wrong too.

It's very possible that the 'residue' is now a random 32-bit number
with the high bits set, and you get DMA corruption.

That would explain why this happens on Jetson but I haven't seen other reports.

                    Linus
