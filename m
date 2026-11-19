Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795105426;
	b=Zdn/34n30JkiX0jdxg+F4aTcH8WCtivQHRSA4S3X0sVFz9kVhc9SeEaDyEwFWMR8fF2i
	 xM/xiYsvP2tdTzynj3e/RV+3mLmPvRddvc/6co+OcXSj4JoNCS2qUk7bqIZpmD9XxFD9K
	 jvW9Z+OWpa8w3HoaY+S/B8fkHwYDEo/pGTfK1hGzswGuf0M9AUQXoY79UN44MXgNC8yFI
	 oi2cfH8uulv4wnhMhi2IpR5W4hhgixlT6oB3whCMzJlN3STqoZFQY7Cov8GQlbA71fwKA
	 rPHofax0d9KIl6Ukq2cZMMBZ49uUXIJ8rw+/I+a+5rBCs7GjhbhvhLNq6SesMMcV7Zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+PcaAwQ0PR5vU4PI0WrkTjiNqMUtnDUUt58Dd2LFEBo=;
	b=0urswPx/LRUsn5r+A8hMvhGwW453P5OE+9v1oHgXiniCv+ScCgROC1NdYt+89B5+1WZI
	 8EOhCW3LTOZ1SBhEnooUaMXTcV7t4TX8yjasIcVqJQHc1lLHeJGbuiKIp9exzoIJjZucX
	 2au+5Zf6nj7ErMG991aYka6EOqXYVfYSox2POvb8Bs25OvOn4JbVAz6yAbk5AS70DoETt
	 jTOMBCY6rw7+y9AMXLUaaPgoCJ1iGJObQBAgq84KT/NTGTShPdbL/Km0IxZLmXXLOLNnU
	 KyjaiT7LcAYFeMxjip+LPAL7YdFEwbm909Fb1lib8R4l4n6/lTbUzLE/xWGBDUY9gpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iaR82iql;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB0606A326
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 16:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FBB0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iaR82iql
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-49d64a88222so739576f8f.1
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 08:23:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795105424; cv=none;
        d=google.com; s=arc-20260327;
        b=AGAgxKZGRh9XezBckEV7fJxEkERznmriaDpJaqkZ8N/yFyWyi4WL5ojv5XsqA+jeGZ
         bmv4w6L6Yuca1+YoK/9GllXfSjw1DO9krMncS7hH2+Ry1uroUoMaOcOzXqdoxRdhhf6R
         2dGKA5HjCUvBwcN3rVZk9Vb3k/al+ffpXQaWW2BnRo6GmzUw5cs6xjgCMiHyNU1acqkL
         hNQ2nHrsZjrRp/Xs/nmG22F9uNqlgDk94CjdJ/qo+lCXKsMPJEC6GKqxXeLdjHXtvyYi
         s2tTfGVnTYCrmg9Nwt8WPO3rN3POdi8qP4djrRRQ3tXcJ0AkiuIsmnDM7poKD13GkJFK
         EeaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+PcaAwQ0PR5vU4PI0WrkTjiNqMUtnDUUt58Dd2LFEBo=;
        fh=Rwk6zeQxbHeCfPJb9oQzRQ3hkZxGv+pyIHmBOFRLSlU=;
        b=jVvjmMbmwvvDElfEaMBmpcX4C6DLe5/UU91xA5mfl0Yrty5LbFr0r/IM3UOypu1Xfj
         CcqNGHw4WF9mnXDdPTyq7EsOPQWH1BggKj8sRwONCP4HBLmdDP42avgi0pcH8L71A/ST
         dZNRU+h1r5PA+xJp3IpvRS9K0DDKtTHmzJMKZPQT7liQbWuPgWl358qGzFJu/ZoLc2Bq
         rQHaa4/kCiZC06oNvoxMqXuYA+MoW7/kc5N1fDlRK1MyxS4Uc9w6reGtfiMFXELRuqEs
         H4Cpqs977mDiKq0tXKkn1cu742AjRgSubVAAa/jIwJYd51b9HTkSgM0DrsrSwtmuDWhw
         IqFw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795105424; x=1795710224; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+PcaAwQ0PR5vU4PI0WrkTjiNqMUtnDUUt58Dd2LFEBo=;
        b=iaR82iqlDghr+ZjgTD7rvOet+0bJeWkODqvL1ERqTnhmPwwtoAIHgp4y9mipfXebib
         pFPZ1NUrNbog4ja5Eas6+MErBA5sPc4TYUsYh9ftnjKsRNKrBOKAl9CuMDEa3BGcnLC0
         lPvrGowLQGP4pPrFzIk1xpXBKLTUtfUlm2gEuv8f3Wz+4elJnnGbiH7aRmiCadNzVf57
         qz9jIg07a58asczj4DBPEUYO0uK11fPxM7QUKHe9jLjO9H9ilGgG9b4W8DiT/wRKkKmS
         cXKRCTULPJzccoAbEfvE0R/FVcu9+hZ42sVO9KZUQwaoSRaLjKBfFBB4g4KA8Qq5KdNi
         NB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795105424; x=1795710224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+PcaAwQ0PR5vU4PI0WrkTjiNqMUtnDUUt58Dd2LFEBo=;
        b=An8YgHFz7OW9Y6f6kZwaJborb7KtJTy1aTodWVIt9pYWSUa5Bl8/C9GmuS+JjjnFYd
         vn3R8EukwWcSTiPjFiiTUxVdgt3n2B9gV2CShAKCB6J3/kTwwy+SktkZjLe1ZfvZc+F3
         AVk/3u3mq7rzqYFWrEEQEwbiw+zczae36yTam0EGP5zKwLSwlXy8TAKj2/u/zxtti/bQ
         Cdyoo0Fp7zbOKP6anv+By58xw5Yt2ILA2DUzQJ8blmLQSBserSRdlRPk8pI9ybbA6vKY
         ZxmY9SFPhaWSFFDDQsBVvjLx6AuraRXSeF9RTKqmtvNPagq0DPb1S9eioujr4l5RaciL
         64iA==
X-Forwarded-Encrypted: i=1; AL+hErGAorvHvcJhinGOX1KEF73fHKjR1MBF+V+wo0Ep1rQnsyRSXBRkQ6aYT4sgae6jEZAaxVV0tQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8lXvexJD7vdW1PFIiOMbGkQR7Pmtqbxbd6zDRJbTHHMxm0WNRX
	ha8ME4YXr5sUBwPHrhE+CnooER7EbpOuAaQtZ8Lit17VCPafA+T4Qelr5LXLfuO5Ogq0HU+6bPX
	dERKETDopicHuh4/hxz9FgfOt4r7aXLMnX8ULaaWP
X-Gm-Gg: AZFdTZce9vajg1IA+/A6/t4WJlaSSp9dsNHtqQEah5iQgiuvjmOy3DVjSl7KJfo0GEl
	omoibAjK2JaZeyuX5AU8DpRu4hW4xTGyR5ZGe0O31x2spjhuUiIAOlLcIrh1CpoTWSiVcmHPYZw
	19LYlfPeINavfi7nNnGyC35WWcrffBDGsF0KsDfaxGkjT/Jxrgqg+dd8jMNaDlSdb9pqlI5rQli
	x8IysvgvvbzBj0SZZ70NwWAdPWeTe7EKZ/L6HfeCz9rnl4gDrdhdCxoaRG2N6nar1jaK0onbEJa
	wX6Z7I3r/CtlMCcNfbU36R/lOYKqRElLtXipAmXYVptVDQUAeGGVAO3mnQUqJQrmrjp3irY0lyQ
	xMCm+o4CRBYjVzPWl/lv5ycz9ratI4QYHZtbsPTgANmSlYoItFVzw5s6aGeT8YyrwZej5htzV55
	8rAen8ZMjQnATG9JC5AKyXG7OPIPJ1a6Cua9U7DMdOOgNa
X-Received: by 2002:a05:6000:401f:b0:48e:7475:fe7b with SMTP id
 ffacd0b85a97d-4aa545e305fmr3959097f8f.6.1795105414756; Thu, 19 Nov 2026
 08:23:34 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com> <20261117-tyr-remap-2mb-v1-2-2a8efd4c8180@google.com>
In-Reply-To: <20261117-tyr-remap-2mb-v1-2-2a8efd4c8180@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 19 Nov 2026 17:23:22 +0100
X-Gm-Features: Aa3M54q16wzTGtbS81z0CLg8Zo7Ll8Oq1HQJT0nxCo6CHGOwHrlaM2Dzo0-8z18
Message-ID: <CAH5fLgjwOypVwBGaac100KiyCCwb+SqQU6Fz=CO98tJCd3zG4w@mail.gmail.com>
Subject: Re: [PATCH 2/4] rust: iommu: pgtable: add iova_to_phys
To: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Robin Murphy <robin.murphy@arm.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Deborah Brouwer <deborah.brouwer@collabora.com>, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 8:32=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> From: Sami Tolvanen <samitolvanen@google.com>
>
> Tyr's VM_BIND remap path rebuilds the page-table mappings that a partial
> unmap sweeps away, recovering their backing from the still-present
> entries. Add IoPageTable::iova_to_phys(), which returns the physical
> address that an iova maps to.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> [aliceryhl: split into separate gpuvm and iommu commits]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Joerg, Will, any objections to merging this through drm-rust-next?
