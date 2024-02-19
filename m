Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E5B23769
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342034; cv=none; b=WkGuijFFzjs3gJbztyWJmXk4R7wOeAcyRjeX7OYrI7r0xwwMiRgD3f6Ut+n0d55t0zRq/b5Mw5jRzkJkyC9fNtSgqlqOY2MTaSuKHclAOncz9riIWCzqN74U0sEsjnvpjqCG2fhETW56C1Tr58N/5qqeCsY201EfWdnL2ggfyaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342034; c=relaxed/simple;
	bh=psRznd+qwD4id3H3mkwUZ3NR28Q098n95rwBPacKDxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpmiffwOb+1GivF492IhLlBNdF37T0nTns6IFtHd7h/9lxQGqiSNCvjfCZ8fBbGVrTiRSjt5KPDiilwjJnMnhLMc5qV8+nfBIoDM7fVlB5UdnVui4kFa8bQS22xgGkjG78LqbcPsCdHsHYCDIn3f23hg+8Riuz+8V04i5bq7Qpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1wkmCZZP; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1wkmCZZP"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-607dec82853so35910397b3.3
        for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 03:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708342032; x=1708946832; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psRznd+qwD4id3H3mkwUZ3NR28Q098n95rwBPacKDxA=;
        b=1wkmCZZPXGw7Qt8gNezGoDXYlxOXNGa/Xs+EkSUOK89ORJmeFbvUiGIUM29d5pTMBv
         yOYdfZ4NB3wKOQ7yr3iwa5g73ThUu7rME+S/OGwr6nhQoTuCP6VieHKDc3geJ0ZBY//J
         Flkyzx+2E0/3NWnQk4RrX5wBa8j9CNWpoFBi1YkOPWNqZONKHlSRQm2iWhwTdfkbzmVt
         aaabwVCeoF2UO7va+1x8whuxjy8OQLZRUhnzJ+jo2sQfjxZ3Eo+2/SvUrJw8JekPGNZZ
         gMSuLtjKrm0DGNnZLkNDNR5fuM45aktd4s/XcMhJN1mzglPrpTQXnRi9t9JSbjJ8UxYW
         tGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708342032; x=1708946832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psRznd+qwD4id3H3mkwUZ3NR28Q098n95rwBPacKDxA=;
        b=hLhkkWqUh4lgO6nLVSf8iqTaoCgPWx9sBrGX+w9V13wj5C5owiY7TfrUZpYR5ak/2T
         PAU9cuPtQVZw8e2x3f93EOvQqsyVxNWww2h9pEUJGfeNXAkdo56s9sRZEuw79IrByOm6
         66SLqUWjQO9XJg/LXQkmIFfrs2/TewDSSXVGCH/vz+GfghOXQ90qJaSuXNgFxT7xFtD2
         iey96+W5mNspDqH1udKqc+AvyEpZeSLigrVotfsVEEUmBPuA4fWfEE+3oSadYJd6DKMu
         cRXKC0hDGHVcHggPiknS7ys4klAqpB9rlnTUod/drKrcq/zPTCcb7aofZ0iZ6NXpM5NB
         JWtA==
X-Forwarded-Encrypted: i=1; AJvYcCWmvCSDtVADNE8X+1960Qs9dIvo4A3xemDfZGwX6l9LWvYQhNTkXN6BkPrOLrXiaRq5j8fNNJ6ausyc+2n7vsx0CNQZqyE=
X-Gm-Message-State: AOJu0YwMAgVvszMe+zDiHbEE7t/lXvZNAvI/CVVRz2tcnqImuJ8y9CLv
	5kXGJwQcrUQBJ0gS9jjVDwDl6SUdDExwGFA+PMk/SA2SQ5YLKGMo+pRn3vYUOepOmF+vEbLxtqA
	xovk1bkarfgSi2k4Sz4W1edvLLqb7wdkg992S
X-Google-Smtp-Source: AGHT+IGYQ7Ft8/k+yh/fauCEDuGdjwHYmI6RFXGJtA15ZTj7Vn8HJ0Oql8n7gZRk8bvuYJStcRQFfFcSWNN8TG2iA8c=
X-Received: by 2002:a0d:cb89:0:b0:607:c93f:2c2a with SMTP id
 n131-20020a0dcb89000000b00607c93f2c2amr11818399ywd.46.1708342032049; Mon, 19
 Feb 2024 03:27:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240208152808.3712149-1-howardyen@google.com> <20240213055426.GA22451@lst.de>
In-Reply-To: <20240213055426.GA22451@lst.de>
From: Howard Yen <howardyen@google.com>
Date: Mon, 19 Feb 2024 19:27:01 +0800
Message-ID: <CAJDAHvYbMVCitf59OvKGQk+cWrHc9Sk7_20LSyssUOEeJGvbFg@mail.gmail.com>
Subject: Re: [PATCH v3] dma-coherent: add support for multi coherent rmems per dev
To: Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, gregkh@linuxfoundation.org, 
	andriy.shevchenko@linux.intel.com, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 1:54=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Feb 08, 2024 at 03:28:05PM +0000, Howard Yen wrote:
> > Add support for multiple coherent rmems per device.
>
> Why?

Resend the message because the previous one contained some HTML.

I tried to upload the patch to support multiple coherent rmems per device
because in some system, the primary memory space for the device might
be limited, so that add multiple coherent rmems support per device to satis=
fy
the scenario.


--=20
Regards,

Howard
