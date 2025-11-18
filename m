Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247EF248F4E
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 03:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763437706; cv=none; b=Y66CBhNTHP/YFHoktKvbLt3RRCgV93VLTJZhFcp1T9eWXC0+gv4vdoZwG+8EXI6Ez7ixBVrHKh/BEwgQhYp+CexATjLdYEGbNnTuqXfoHObgTjNMAAQloRs22uWizbwcETw6ELKSbFpAIkl6UPtfCMO96Dk2a8ovFzqvNSRJcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763437706; c=relaxed/simple;
	bh=+UkEr6bMm7YA1A1Y4M54d+g/Hdct0Lp7v3eTFkvgv7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlUBa8N/5xZOWFcrcQg+3z054HiLw9h+z4f+Sqw+u+MDr3lNbdaYjV4OXijQW12E1DrAuqh22DnTkCt3ImIjCvzS8aHQ31b0sg/16DMkhx3/gsrIiJamqaksXOfBf9qSfVSEusTWCu6ff7f4/NGugVd/iVI3pSsRH3YXrKJx7VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z7L829S6; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z7L829S6"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ee243b98caso108601cf.1
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 19:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763437704; x=1764042504; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AouM3oYRIcmTDzCogQR4kCGCOSum3W4GrD11L9en19g=;
        b=Z7L829S6uieJDs9f7Jr49dEvcFejXwgEMfmKMZrXV706zJo+p8Tmw3ZfOLVea9j0aq
         qaKkEUnsqcU77Zpnu0Vu87Jelm7lmVWD5pJedmmsH/kAKRX9wsAE0Yf+aCFu71ojqJST
         +8BpP2IaIQHaR8eboq0nZAV5F3Is5cxebnphCA50AE9riB5iJKwzWaWI/xAmI/pjiGwa
         GV/GhBPKAH8rBfBAR7cERzYM+a6OFfy6PkXgc6Z8ikkntKEYGxzSN4GC2GaSUQNQL0wD
         ygKfKMks/BVa2NK23ODBhPV0T04haZYD/555j3DodzFL1mIKQC1vhzyca6xT14JwlGLH
         Zf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763437704; x=1764042504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AouM3oYRIcmTDzCogQR4kCGCOSum3W4GrD11L9en19g=;
        b=JIV03wpfRRUNTbD4uaMN551kvOqFFAN4CF5WC3+ML6BYrP+owVpXa6JJxbXUeT3Enw
         uzs05bk98MaAFoSTliLr0Fprn1CzVpIEd4jlEl9BtVLy8umszDuvTUtbyDbgUsoNXAO3
         NAF/VhHJoFYGQpYajo9trE6rCI/jHdOIhqnqLoSnRx2sLjABM+etPZ4AzR5WiCqYabb0
         +neQs7OtWUkZYYfGp4VPuZNg22AiT48l7qWwENw9aS3VXAKroNyuhVPYyNMoqgY2UCaO
         Z8+OaTz2/dmWUpbaf3z+yMw7ZpaQpF26cIa/48kRQJcSoTqtv3sllOfjzOHxFzSq9VMQ
         DfhA==
X-Gm-Message-State: AOJu0YylChT0U63PRr2zvy2iUy6c9xUH3S/OsE9uRB/VnqKhK3rOWpBV
	f3FyEzqszWMWztRS0WEXZvIEgf2qO9q6bwBdb5JlOPKSUm7ey7IFXDtFMtAuVtglhGl4R0vgfZJ
	CCt4bNw9m4vsFVLZVM5iInE8H7+qFEDCDQUzmtdhF
X-Gm-Gg: ASbGncutD1l6D8/aRuR/Ss09cojkFkLlupigtsZhgJcRN00OMQ73odwP7mVzLxXgnEz
	TFrJuLjMDypYmn3Dllv0JTI0Tv+TlvQQieSQWU0kGe1HWEuQs8BMEeiWO7EMKyGkYLp45iwc2ma
	fvYRBQfrkK79LwH9YKtvXB9jpZOQKGgoPdF8q7RAomC4iuU8xo5063NWGefBaMdJwSzj64OVkOC
	mXl1Nlpv/MU/uvN0v9kG9cCwBvsEuGvQgmu4tBvTYjSeKDh5oUChqUWAtmavSNQdrb0t/NkHDwp
	4wSoF8RdXzxUjQ==
X-Google-Smtp-Source: AGHT+IE5qNByH6s68UVlWQ7Pt7oaGYFDwooke3DG9ytnWqTTS2QMNGTW5E8BtmDDQYU61iZf5QEvtVyxklsfiy3CZWU=
X-Received: by 2002:a05:622a:1a07:b0:4b7:9b06:ca9f with SMTP id
 d75a77b69052e-4ee31392974mr3078341cf.2.1763437703645; Mon, 17 Nov 2025
 19:48:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251117191433.3360130-1-praan@google.com> <20251117191433.3360130-3-praan@google.com>
In-Reply-To: <20251117191433.3360130-3-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 17 Nov 2025 19:48:12 -0800
X-Gm-Features: AWmQ_bnOjndMJ8ANj031Pw272RkQbgp--YmAWlqg62qjz4uyzu4mCyJeavYnmXc
Message-ID: <CAE2F3rD_HnZZz9XZTtpoWFfAsP-Rkiq2sAtmUR7xaH5_igYP0Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] iommu/arm-smmu-v3: Add a helper to drain cmd queues
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 11:15=E2=80=AFAM Pranjal Shrivastava <praan@google.=
com> wrote:
> +int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
> +                                   struct arm_smmu_queue *q)

Since this function is only ever used with the Command Queue (cmdq),
could you simplify the signature by obtaining the queue pointer
directly from &smmu->cmdq.q within the function?

> +{
> +       struct arm_smmu_queue_poll qp;
> +       struct arm_smmu_ll_queue *llq =3D &q->llq;
> +       int ret =3D 0;

I believe you don't need to initialize this to 0. It won't be used
uninitialized.

> +
> +       queue_poll_init(smmu, &qp);
> +       do {
> +               if (queue_empty(llq))
> +                       break;
> +
> +               ret =3D queue_poll(&qp);
> +               WRITE_ONCE(llq->cons, readl_relaxed(q->cons_reg));
> +
> +       } while (!ret);
> +
> +       return ret;
> +}
> +
> +static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
> +{
> +       struct arm_smmu_cmdq *cmdq =3D &smmu->cmdq;
> +       unsigned long flags;
> +       int ret;
> +
> +       /*
> +        * Since this is only called from the suspend callback, we
> +        * should be able to acquire the exclusive lock without failing.
> +        */
> +       arm_smmu_cmdq_exclusive_trylock_irqsave(cmdq, flags);

If you assume that we're the exclusive user and then ignore the return
value of arm_smmu_cmdq_exclusive_trylock_irqsave, I'm wondering if you
can just skip the locking entirely.

> +       ret =3D arm_smmu_queue_poll_until_empty(smmu, &smmu->cmdq.q);
> +       arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags);
> +
> +       if (ret)
> +               return ret;
> +
> +       return 0;

Can you just always "return ret;". Wouldn't that be the same?

> +}
> +
