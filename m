Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF426ACC
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 04:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776746871; cv=pass; b=R/cpaghWSeZW0YTyUiG1F/nGLocsB6Um+hhgpgP4TAWvnqhKdr628JPMdfuBVDHtlnTkrIDNa8T7DOoTGWZy5vx386NzML6TjwzClYfBtsLjAjeV7anXg8A0/1CdEuYnV2KlKGIgZ1/eoMQafmFCZve31G1C9Nm6Undk/rJ1TG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776746871; c=relaxed/simple;
	bh=eaw65u4ezG4hcw+G7LICFJ/BO74DVdUXx6dp/fG0kUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyGuZ0zHOK4/x1RUyQtOiqtcfQSx+2wQs6H1iIbLV6Hzxpyk5uWySJVx0LLrPe1A4XEr/0nB0GnI9Bq8o5BYf8fG9iJ8o/G/UeOP82IbkeUZV6ffguF5YN1NfXTqY1RAN+ZQQQ8HvIItZzQYTonjPXwqFEVTEfh1YbS2islR2sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+kPW0VC; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+kPW0VC"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50d836552daso1857731cf.0
        for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 21:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776746869; cv=none;
        d=google.com; s=arc-20240605;
        b=Mu6st0Tp1orD2dvRiSHQKOSx2ZIM2tGGb8KLMqRgleYb9OH92wypTVjrTbJNOCLMj4
         yn5VbzbrK0ns1TM7owQr4F7xTHrRh7e9CWuZseWOq0PdOBWY3UrBGSKaZqDoqs63TnEB
         DBfYme6l0xT1x7Q6vynOc60v2P6NY/lcq4tqDoTnzn01fjSN6el9ENbtQ/VyRD7k4CoW
         RBfZZs3SOzs3YeSNeCBORU9WWLeYs4K4d/KwA2j9aeJfEhK8ChPGHtARP+nZbM1tOcvs
         e1i7WrExM9UEMSUSAOpzAsYVq5nWjkRj2MDX+wmpiQVnKe6ByvQAIe04/zu6Db9a33ZX
         BsCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dL89E25TA7Mh5McQBvyoLRuzNvTTjmYNqbSdOvN5cb8=;
        fh=l6d/N6u1hLHPo4TGqiX7B6XhUFrf2YjgyiVnG6QkPqQ=;
        b=DaQJ8+gz0D3I1b2T0ySEtsvwH0sRkCthJhhkMI0/+6qpNA1sIL3ydBS1f06Xry2flq
         8o7JUNzKj1Huv19neK99xpOxg1Sf1+zXVCkxFBkya4bImQ8loR75FUzUNjtX3zXYmo/+
         w2zCk5Lwet9bJv6x+1kpToe2I/fQqiIFXZEvv8uemilPHIznSqvbiLsf7iOrNi6ah26d
         TwXTm62vOpxZi+M3gk4GxQLIYUO9oSe3IdovRRM4AHt58YEsI7ZOUqWjKy2bz9qTh8sX
         D1IBxNWdh2qc1UxI+2o0loqfEk1isM/VPfuRNWtdZcOtk62Cpu66MXbzHUFt7Th5ISAH
         mpUg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776746869; x=1777351669; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dL89E25TA7Mh5McQBvyoLRuzNvTTjmYNqbSdOvN5cb8=;
        b=u+kPW0VCoXfZZta6I7BF5TNnZ25/NKI/Zp/G1hA68VmLpFUnRTWEyU+pxXqHtPargn
         dEej1neaUTOwgEiiWLzy5pXaBzdnf+WVEN1d2I2SxGLkvF7pv4VK0rwiII5sHU52MNlo
         X7q0yHLevhri3voXvDkztfTbRNP+hFE4N23NFRoSuD8k/fuwgTcJPus8IRf5QL8VMcjV
         HeesGPRxJ/eShWP8ZDqK+DOkO3XegMgOtnzzQFD7D4Wh6EXX57QW3xf4INwGMUS3TblV
         7ukE1N3sU45mL4EWumYiCoKGMUTmzxOE3B17+wkIFkQoG1Zkc9Zqm5IUSMQDz39uwqPw
         coTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776746869; x=1777351669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dL89E25TA7Mh5McQBvyoLRuzNvTTjmYNqbSdOvN5cb8=;
        b=SGRp+pLXungSqOSH3dp0ctb6vj4cuVKnMRf4HfA9zNLA0cSKmRsB0QVtn7FPccUu1g
         OltjDgKeVqcNdf2mdQGY0XG5aB0tgCHD6wbQoemepgmmTqzJJOpqe7gC/rgeo93FW6Ft
         1E5CLmyjOXJduV/jlxHjcYkMhWyErFvSaoqI2Af8HxoPsx4hMDQevAN2TCpEKKtL7bPx
         /IZ3k9b5/47oo9W9ifDr6rHL7PWMcpsUE1rycUmHht07g5nZGlCablLokEC1tSQ5Y2aX
         4uvAb9cDjZNaQ6VNJZIrPiJXUP1X8gCUjRQqdHCdYGzNSM3J2RZCnML/XfgIC0VTJSr/
         Iunw==
X-Gm-Message-State: AOJu0YwknGv00JvLpjQtuME5fBhQ4YvvQe/pJUOJZHYPXD4XNqmbqO56
	tbBOJ4UHXP7uUeHsjp9pSi+gjnPXk0egRuU/68G1uAw0Dg+koHJAGLvSHp51cFVVR0/GP0rLBKn
	HocTG/vo6clF4e0ZE1C6+6MHLwlTM3+ewzYFY2/CL
X-Gm-Gg: AeBDietdSe1Ngm/21FAKlkdvnkddi5Vj/G4iprIu88XNGRgvoFozAc+3jaB9H34y9ga
	VNZvb7GOEMTTTbH5PC+Ugspmkc8/eUBKGVZ72b1uuw+JmT/NNrcICCshXyqHbJeq7BmOwIwFtZL
	9GRzdlCQ5OZLr/tQBooVxkgRuiatQkYBAvrlP4Tcu/vORt8auaU0zA2kuyiX12XdOE7lbgj2DPw
	9V+rJUfTxCIeJWU/LFrIF75YLWWmRQGFxpzswEE9kv7PjxZvzPLJYJTTljpQyoIdEC1D+EBR2Ci
	GbP1XJZN/JY64Pg5zyn6g/37hQ==
X-Received: by 2002:a05:622a:8d0c:b0:50b:8d3c:5bd7 with SMTP id
 d75a77b69052e-50e441a9a16mr34354151cf.9.1776746868730; Mon, 20 Apr 2026
 21:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260414194702.1229094-1-praan@google.com> <20260414194702.1229094-8-praan@google.com>
In-Reply-To: <20260414194702.1229094-8-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 20 Apr 2026 21:47:36 -0700
X-Gm-Features: AQROBzBGFqiJnD6PSdMGMKnivc6X99jY_iDx9o-et98N7RXkyLFH5gb4P9qP858
Message-ID: <CAE2F3rAAaxP7a3v_K2n3WWQHeA8jfMkhB9DWz3j1Ggu74EXftg@mail.gmail.com>
Subject: Re: [PATCH v6 07/10] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 12:47=E2=80=AFPM Pranjal Shrivastava <praan@google.=
com> wrote:
> +       /* Mark the CMDQ to stop */
> +       llq.val =3D READ_ONCE(cmdq->q.llq.val);
> +       do {
> +               head =3D llq;
> +               head.prod |=3D CMDQ_PROD_STOP_FLAG;
> +
> +               old =3D cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.v=
al);
> +               if (old =3D=3D llq.val)
> +                       break;
> +
> +               llq.val =3D old;
> +       } while (1);

Can the equivalent be achieved with the following?

atomic_or(CMDQ_PROD_STOP_FLAG, &cmdq->q.llq.atomic.prod);
