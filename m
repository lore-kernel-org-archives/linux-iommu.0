Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BD91D9A66
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524657; cv=pass; b=bO/d51rgOPojVf3yGvWKdIJU/T0Kj9liYiZEWUKS88/NpkQG1emhYcAAp0jsqzdJpqzNfKRBpRauVoucA2mM/4Es5ZbgkRuYQobs7OL+EelNCfi7RaQ1G+QTWdhalZiZ4rA33MJIMfKnGkSGCbzBF6sF7L9ImmE/2LN18V6xLZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524657; c=relaxed/simple;
	bh=czqVJ9cz7Ktw9imH5A5AFq07K7or30oW1/Cb5IOvfOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSvoHU0mrr6ylbVdSARnbnzQ3QHXTnIgpZ15VlgAitlJqK//fC4Q0Rv9aVxswHU6WT/HAXA6hE70ut0cJbxcttxdzUFE90NnRZCdxafu1TMwoWzQL57LIu1HeJyZK0FxI9HpQ3/lagJzncpYe2owtFH78KSANV9aU20ZZttfxwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=UDUGYgGE; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="UDUGYgGE"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7982c3b7dfcso39568217b3.0
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 18:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775524655; cv=none;
        d=google.com; s=arc-20240605;
        b=O8fKpZGhFqNv/W+/J3kaLffqWbQfrN9bOFiXmvuE9PuXWRlgaHZOP4GPAXbmg29YcD
         th/Jlneore/AHPDwYkxu3vgRUi9x+foHK/X/mlkliaX5UJZ/JHFrBdyezgRbx0Kq/9ou
         E1Q2CtmCdI1XPnE8UF2RtVJtYIGF4RZbYfMJx5uJaiFIdTxPtuuplIRdvB8zFE7CgunM
         AfcVjbAddKTXWS/yHOwkhRP0b7G2oouI8PcY97BWiG2v6HtpcClU0Ct3heCLepFXsEeC
         iUG68DIDiyx88LQcy3sgHHG4FCwxeQZRB4gDwS/QPSMlwFNndXw83Lk+C2dnTBf6pm5N
         F9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VJT/iwQLEn+40200OWlfNgjmYGPm0JSSw/wJxedFMI0=;
        fh=3aL1pkU7ha9X2tjSWjsRxgKjAU33zhaC1CZ7R03nNps=;
        b=NLe/FIMXbDW/fjUj1W3/ZA14NLvsUmDwp9L+A8V2tcdnCNbBTUSTqoWb0bQbIDGLjs
         Z0D+iECIw6WoDZzCxQ07H4SX7CXwRQHmKm6J34/HVq4IO+9K11tPDf1w5fRBcS2oHjE2
         ziAeyrPH2oj0SKAOeJPOndk6/G9+1XhGkdw2gyFHlTGWDnKK3hTm9aQtawlUFXAbdnUo
         xXZbFw8hdKezydqYJPxsgzENdEWqdKyRx1xk2Us7T86XFyRrglt/oUaAl8Oqgz9987yL
         umiKrdvUecDOopTO2E6rYn406fq2HcHQkWozGHP2HxkJcMRlfBsV5HPzXneOdn7btQbq
         nsBA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775524655; x=1776129455; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJT/iwQLEn+40200OWlfNgjmYGPm0JSSw/wJxedFMI0=;
        b=UDUGYgGEEAwl8nGqbzrb9CQgsN7xb/BbIZJQAaXwZxoYVmwIgROAZAHtv7OC4ZAM6o
         6NhT75JQYT/X+und2rvqBIk7yOG58Tbnj3W3hPblQ2cuLJAgZizrHaGX+0XUDjfRltDe
         6StJc0KnXlCanX82NwfbzhAWBIb7en4snsruQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775524655; x=1776129455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VJT/iwQLEn+40200OWlfNgjmYGPm0JSSw/wJxedFMI0=;
        b=mugMecJsqB2QgB5etbTqujnLeMUEixYRjAJtgvg2t9ESYwOJTNJzFPKOTuEvKE07Q8
         8IMI6tvprHiOHDebrdgbsefDJ1Ket8MGxvakMLKPdgoWy69NdBw/q9DCWBwr8QIxh+1D
         brLWNcag1D8OF00gD5eg3MrlrlL3hHQVU7ltJPvNSt3Gnpok0ld6mZ+LzJFSKFIwN/TX
         DVyH3OJa9PD4i6xwjhWdAX2yGjbtOSqbCxBYKwse0XpyfE52EjUpeB7GCW9yQm3GioWa
         1woK7PywbxKggCKKJ22P8qsAJlYE5YqOAVfhQLY0VztUxhHrr7cn2Uhtu4UPy/BjeHZH
         9Fpw==
X-Forwarded-Encrypted: i=1; AJvYcCUXQnbTwbE7Y6V0Me59BXHNvPyBW2BfR9egaISNHddRjE7IAP+Bpg0Iv/kwb+Npe1dq9UQ5CQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsTz1nGX6T6mdIWSOFU1Jc8WODSDLb9ftmHog2YcwoQgkhRfsz
	4BEk1wTU6AfpA0gqKmFw841jfWuGCZe9SIaMUX+gz2MkJR9hvuohoV/179L5fDjekJE5rjFTQHX
	8e4eLstve0b9oGkfuZRxn27NSZuYFKu3KWQRie6fOIg==
X-Gm-Gg: AeBDieuqU68HoyTqegOb1HH3/i2iDhseoUZesYJh8nhEUZPKMJu3IYn7YEKkNovaulw
	/pfZTDrLStJ24p727erD8yL6wTbSzHe8xDP6CmzxEH5MXzzZVbR9og6C9AaM9w85W4nPadvj6GP
	gpJAvqvAgsSX2OD7pUDh6fTa0o9jFQ3daAuHMeHAOCqrrS1MA+fwvsrXxfjlSs9zrdcVLefPU4F
	qa7dzQPPV8/MCwL9H8AtjB+gx4/25JuXvI85qImvAbnEFt1TkO9TlBhTfINyLvb1BqrbP4UZVnY
	a5wFwk9mMhx+2mbHpHHLd+EO0pRCg7JgBygtr4nc8fiQnQ1RYh6yEumla6BOZt58cIc/kwexUPh
	kzBEJM9XE+HkfISWDO3Q7hceJy/cfa1UhCqy3nNLJeJqNK3RXyrdkS/k2JmzxjYg=
X-Received: by 2002:a05:690c:6d84:b0:7a1:dbab:93e5 with SMTP id
 00721157ae682-7a4d2ff20eamr147191477b3.2.1775524655240; Mon, 06 Apr 2026
 18:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>
 <20260407011210.GM2551565@ziepe.ca>
In-Reply-To: <20260407011210.GM2551565@ziepe.ca>
From: Sina Hassani <sina@openai.com>
Date: Mon, 6 Apr 2026 18:17:24 -0700
X-Gm-Features: AQROBzA83tto2liL_v4antfrma0fo1MHacGEkseVIBd3rayyTAcOUj5whgCNcpo
Message-ID: <CAAJpGJQXnMjhC4C7Z6bAQJN5y48fsbiwPd3YF5vft+1MBNFLVQ@mail.gmail.com>
Subject: Re: [PATCH v2] Fixes a race in iopt_unmap_iova_range
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Aaron Wisner <awiz@openai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 6:12=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Mon, Apr 06, 2026 at 04:07:01PM -0700, Sina Hassani wrote:
>
> > io_pagetable *iopt, unsigned long start,
> >                 unmapped_bytes +=3D area_last - area_first + 1;
> >
> >                 down_write(&iopt->iova_rwsem);
> > +
> > +               /* Do not reconsider things already unmapped in case of
> > +                * concurrent allocation */
> > +               start =3D area_last + 1;
>
> area_last can be ULONG_MAX so this literally overflows to 0. It is why
> I formed the suggestion I gave as I did
>
Yes, in which case the  if (start < area_last) that follows will catch
it. Are you suggesting I compare against ULONG_MAX instead?
> Jason
