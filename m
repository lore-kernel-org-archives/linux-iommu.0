Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71211BEF77
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737451680; cv=none; b=XfqzImR108y51g+2tXucRgERoFhEN2vTOPA2u8MR7DHCE4k3FcsBZMod1OJ8e9kuYUlH5oRWXs55wyEA2KWSvAVzjAqVxikEbufAgeXgAKjPd8NhlyCwFvUJjBqcGzEo25TLTcA0o/RhBmECVWoCWCTUNh7JiUFH6D/qOp6JGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737451680; c=relaxed/simple;
	bh=IF4TaY7d4duRohpHNCzfQE6bKthFQI9a4bf/i4NmVg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjPBFW4uPgNMWKVRaD1ah6fF+Lu6wA5ugF2D0nOhxFo3PfozXZgQ5dbfE1Zep+LRK34/MOX/YkwDeCYMOwCu0Wgb2COB3FGbc4Te1u7YaPy/zGOUpT/8zGdCbeh9ykSz+u5SrnxrhmKMadnDZyfjfFQLPiqx1BGoGKvp266kNLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cj6RVY0w; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cj6RVY0w"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so3417407f8f.0
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 01:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737451677; x=1738056477; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IF4TaY7d4duRohpHNCzfQE6bKthFQI9a4bf/i4NmVg4=;
        b=Cj6RVY0wQKt7UCteaXxkQVjifNPuHr/MfEsn6bI8IjZPWQ13VjiFETYEw86vzAcv4j
         yThbWIjAmsPy2m7v16KbifOciw+qv1bzDHIV/uGgIVOvcHU9vFVHlBhw6LYUmksxNEQ6
         gU4+HrbLH4+4zhErQDvhl8jS2spYF+rWIzUKmoSnwiwcuGxBlcyDmGGWS0+aqMVa4yco
         vxkKg9+Wt8DxKUrGPJpckp54iwulJ558yzRiHBVYeK98zhQqSeD9hX4vpp/nJcnXsdMX
         mhXSAOGZmfkDtf2TLeOj69slx4BUm60og2oI3FTEnEPGCyK1KIoFFAiELN8ilfNs8QWP
         ZLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737451677; x=1738056477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IF4TaY7d4duRohpHNCzfQE6bKthFQI9a4bf/i4NmVg4=;
        b=Hp/KFRmyfRoC67MulGlReEUnDP0qmdUBCEsag7cSJnnJ9Th71bO3lTuqbFs1BCex0w
         sA1etKFgPoF1FbKAqpVL7CmJZeQ3EXjCuc8g8umtus0rL/OID7CUYofXNk+poRKL1849
         Z1fxvo2iu75felGylJf3GXBsAQZdyUPkP742QuFChZuG60rJEQIEf0bqOAHDLSBDQ6zq
         rVwCT27AXF4v9M1at/3E4dO66OUkzhPlpFkVJiLxQtO+lQir+lLFUuQ5EuTTKiCaAIDQ
         9nWDH0EOEHv6xP1yRicDk/5EjUbuQ9F6wlR5kPtFs4UPhlij3c7HyReGV/6rit2XX7sP
         BJ0A==
X-Forwarded-Encrypted: i=1; AJvYcCXu3dpZB4OgNCWkprCweMYUZa57NqX9oOELhYD1zNQZEGq5f8mXYm+xB2RCCPZh8GXewKBy1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrBEblMBjV/a9mI4TfNyHtOpSkNTfTMCUcF5sZxMD8+ukDUe8/
	8deOXK+y03ptB0+1yAwFN7acO9coBQkMHoq3HmNvEe2+ck4yUO71NqBCgZWoktTySPYb2WpYDwb
	R5GEGljGGWkmAEFWOF6M5EW8kCFQ=
X-Gm-Gg: ASbGncsDil30WcCfEKe65NKGhrE0hxCeI47H0APWdJf8wWAnPw1eltpC7Hy7y5roRGi
	DHRkn61i1MTbhxQ4iGyihnVBj2hWQ+SB75hsZ6CdbxkwQhX2Jidu5
X-Google-Smtp-Source: AGHT+IGsHiq2BXKFB5OMXmd0lgl9uWHfEUBKI+MYwp+JL4oD+JVooOEe842v0Fn2NK+Yo6kt6laXtC4RaZ/9ayRXYk0=
X-Received: by 2002:adf:ea0d:0:b0:38b:da31:3e3e with SMTP id
 ffacd0b85a97d-38bf566c690mr13509240f8f.28.1737451676752; Tue, 21 Jan 2025
 01:27:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250117071423.469880-1-east.moutain.yang@gmail.com> <20250120135933.GJ674319@ziepe.ca>
In-Reply-To: <20250120135933.GJ674319@ziepe.ca>
From: Wencheng Yang <east.moutain.yang@gmail.com>
Date: Tue, 21 Jan 2025 17:27:45 +0800
X-Gm-Features: AbW1kvYWGED4KZNuExXgO4AJnk3tgAnEtHwpSg2ObjCB4wpxxs4VW1Y66VsUkc4
Message-ID: <CALrP2iXyfU91-bg3u0mAL8zQrriuQMbdtJ1Hta9XeBRQ_vDEHQ@mail.gmail.com>
Subject: Re: [PATCH v2] drviers/iommu/amd: support P2P access through IOMMU
 when SME is enabled
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 9:59=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Jan 17, 2025 at 03:14:18PM +0800, Wencheng Yang wrote:
> > When SME is enabled, memory encryption bit is set in IOMMU page table
> > pte entry, it works fine if the pfn of the pte entry is memory.
> > However, if the pfn is MMIO address, for example, map other device's mm=
io
> > space to its io page table, in such situation, setting memory encryptio=
n
> > bit in pte would cause P2P failure.
>
> This doesn't seem entirely right to me, the encrypted bit should flow
> in from the entity doing the map and be based on more detailed
> knowledge about what is happening.
>
> Not be guessed at inside the iommu.
>
> We have non-encrpyted CPU memory, and (someday) encrypted MMIO.

hi Jason

IOMMU shouldn't and can't guess the type of the mapping, e.g. memory
or device MMIO,
VFIO passes the info in a flag to IOMMU to setup IO page table entry.
There is another Qemu patch which will set the flag.
Qemu path: https://lists.nongnu.org/archive/html/qemu-devel/2025-01/msg0283=
7.html

Thanks,
Wencheng

>
> Jason
