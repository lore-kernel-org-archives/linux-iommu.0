Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197DCEEBB
	for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 04:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742964727; cv=none; b=rpjfUrc7K1XdwR/gJs4aNuwbb7rv5w2AGpAqVkXuI00532FUMEJE+iG0UC/03oz0Hc7kYcXw2lvbMftx24A0nb1KLgwoEilzebLlvhGQdcZlEa7CDy4XZnPJfAj3+tBCXGlyc9gt1KLDNj+/uVAb3wtlhUnOb3sdpJenbB3n5v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742964727; c=relaxed/simple;
	bh=z0aOehE5oYMaKLcN/VyMJEsQDYX6UkKkic5L8I8KcYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTr2GD6hlR0/9QpD1sKgHlJS8GJPObiOYxStUCARrLxMdMNcBWUzE7l2fvhPdLNQsoVITDVSDP1YlYY+G3iVCLoLluylKcCKoevXM5diHj5M4UjwHrb3tWA4EBfgvUmlt0T6doGzRqqxyvaeDdTOvLTQoB6GRgrj9uZSc2hTJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xgPscXhx; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xgPscXhx"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso6914a12.0
        for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 21:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742964724; x=1743569524; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/HTkSCFJ6WUMXs3V/B+tHgvoBQWbu+mraItNsSIvzM=;
        b=xgPscXhxN0d/xcdIjBG+1/glRfEqgCfWA0HhPBxAnVJpzgKYdORXA2fPW4Vzkky6X9
         la0spurlMImNpfnZ1C4rJl0D3sl5BgDPbv4vRKQpLKSlE7MF5UgycWSjSf5bX03WAWzD
         Y/Kl8shYFUdQNxGx3KRw7Gg+nkp1F++eDmBTkRVKN6meiwRQFz8EgKjEU92/y5d0v73P
         yCMaCHv4Bcy0rYOjkSc6yaxPp0glGNsqGRldy/y2ufKX1QgEQyviNxR1ZzlWYwL0YXEU
         TGAnOtMR+E93ALbRH/C2Ve+sJxjwqmzVhOBSJNQ5cHJlNri891V3vNWaR0vCB8T8524g
         9fZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742964724; x=1743569524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/HTkSCFJ6WUMXs3V/B+tHgvoBQWbu+mraItNsSIvzM=;
        b=U4Hzkbw+O5xpSsdQGXaIZIqLcrBhS2/aYxcimDABOYZk4i4lgNaT5no7IxEWkAmrSc
         YNGspPChbVG6MEkbbcDP4QuyhQ+re8c8OeYAF8CM0ebIPPE2Qj4kGDtWXlcR+13kQ2b7
         AQAslNXc1KJNVfxExkIwziMAremKzxIaguavp2L5MmRn604pJTdrd139FV3tjhbMUmyx
         82NoH+QdYbxJjxPIwmFk2pUydhhjxZ3kB/sGtXVL6WhI+SYCg2U0VOa8gap+VKTnqwzo
         KGAGaIAsbPkbSOVr8nl51vF68oB61Dq0EK0C44ygig2QSpOi+FU0OyUxbfizaiSKPyzM
         PNmg==
X-Forwarded-Encrypted: i=1; AJvYcCXEyIwcTWVZ+GEa4s3TAIcGIl9PS5CARPK1jz6Rb4cU5plc1rw3Fku1V/9MNOzrG8C1mF+G0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVK5TtzYWfFXE7ytoBU6ND+Il8hORoXb1iK283lIU6pNnejJ25
	s5BCYcsXKluXUIp8vhyMJ9Wm53zHVER0HK2tATCaslgfUwUorUMDSi8+HZKjje2D8+OuXkfmdzB
	JrYgeqhPhyCUuS8NWTSMC3qS2RX74u+dS3AAu
X-Gm-Gg: ASbGncvZqaTDB/+VSs4plBhBwL9r7JpuRidrb68Y4eiHmMngcP0FQSjtXTQje0bNqLG
	qFUAXnF/Tn+oRqZh6jLjlo6Dtz785PsZfR26oigzZ/Ww3tqHQDqpE9Ki1IEa+iskoV32PtqePyy
	vPAgG2u6PwPyJcAMERyYkAUx6O8ZkphGrXqp5Fi5o1Y7FEhxuKtUaB+QJ/JNPX
X-Google-Smtp-Source: AGHT+IGTCF0foiCvlOpYOuuk3ZfinMeErbyAA8SXwbqRril0pHYwmX326QLf4bTjN4I0nPUkcw9dK/dgGdPugBkEtG4=
X-Received: by 2002:a05:6402:291a:b0:5e5:c024:ec29 with SMTP id
 4fb4d7f45d1cf-5ed55bb606fmr42319a12.0.1742964724018; Tue, 25 Mar 2025
 21:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250319004254.2547950-1-praan@google.com> <20250319004254.2547950-3-praan@google.com>
In-Reply-To: <20250319004254.2547950-3-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 25 Mar 2025 21:51:52 -0700
X-Gm-Features: AQ5f1Jq6-D-W_WjV-MchJapIpgl0UKgEp148ec7VdngAUlFc3e4R_UhuntSPLTA
Message-ID: <CAE2F3rAnRa0zCBrPv6THUQ6mMbjoPf5xZWejPnXNBhq_oKADdw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] iommu/arm-smmu-v3: Add a helper to wait till cmdq drains
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:43=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
> +/*
> + * Wait until the SMMU cmdq is empty
> + * Must be called with the cmdq lock held in some capacity.
> + */
> +static int arm_smmu_cmdq_poll_until_empty(struct arm_smmu_device *smmu,
> +                                         struct arm_smmu_cmdq *cmdq,
> +                                         struct arm_smmu_ll_queue *llq)
> +{
> +       struct arm_smmu_queue_poll qp;
> +       int ret =3D 0;
> +
> +       queue_poll_init(smmu, &qp);
> +       llq->val =3D READ_ONCE(cmdq->q.llq.val);

In a later patch, I believe you're calling this function with llq
pointing to cmdq->q.llq in which case this assignment would be
redundant.

As an alternative approach, I'm wondering if you can reuse the
function __arm_smmu_cmdq_poll_until_consumed. Just take the current
producer index and wait for it to get consumed.



> +       do {
> +               if (queue_empty(llq))
> +                       break;
> +
> +               ret =3D queue_poll(&qp);
> +               llq->cons =3D readl(cmdq->q.cons_reg);
> +       } while (!ret);
> +
> +       return ret;
> +}
> +
>  static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 =
*cmds,
>                                         u32 prod, int n)
>  {
> --
> 2.49.0.rc1.451.g8f38331e32-goog
>
