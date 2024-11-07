Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB410624
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 00:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938594; cv=none; b=iia8OfAgiNDZ03X3bhTxjucJduMRgXqseIsTEcmEJnivxeyB7un/fkw5C9m/bbPhseNsqygk86gDCWoYADw3UMH7Ynw8ymHedS5WfsvnjGSlC+xQwvnzM0DfrztXT11JORsfuFHPMGONkCllSBb7d3IOZEYw1ysojDSnt7I9uuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938594; c=relaxed/simple;
	bh=LBgH/f0GCpmR3RWNjxNdDJ39gH9kDpYN3cqGdAWC2IA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMSbOUejEe6JgkRTUmTDi3pKDeEAXl5QArYCIi6TzCD5YW6npDgQH2Wu5cge+7VtacAWExffvTWOpYhSgI+E21GO1d5pcTdNlRZGnukxBJkzWd9recVh1c93oAcfUNjVj9OqJtHBlYBmZyqNKLgzaUSyjXS0F9cGUTghORNZi3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G7V9QDIQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G7V9QDIQ"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c947c00f26so4230a12.1
        for <iommu@lists.linux.dev>; Wed, 06 Nov 2024 16:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730938591; x=1731543391; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GTG+Ign50UZHXnut+zxQ2gmqnSMDzLGeRF5nsPA2cA=;
        b=G7V9QDIQbn+cVtZFA+8yoE61NVivUlp8BJNjNRbbZcaxcEckuK14HmiP6VcYPMKVd5
         6E5Km/2EYpr6dVsjtZ4j7do/cYxf0Wh4HBQDQb+tY14+Ulxrxm+tF183hF/tImRuJj0U
         bxLxJSv5Qe0eFwwtyGIe/D+Mcfx/t50jnppciCmd0IIdeaWAT1Q5TI43FxriiW6pABln
         7I1oPPvAv63NyrhUIX1wgNakBl59lvFxPqeAerzwQSwaVLhkUr3hQeBKA511kcIbbCbu
         E1kjn4YZfDNbBvQ0QEPfw+nmGSmp6wsdzil91a0zNPoqL5qX10iWwLAkIGetZiqjdsWv
         iGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730938591; x=1731543391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GTG+Ign50UZHXnut+zxQ2gmqnSMDzLGeRF5nsPA2cA=;
        b=KnL40OI+9gtTU7hcKvaUDqN941I5FsiU53SqX8TZpqHQAvcTuPot7n2+8VFQkKZ/u4
         XinbcCXR6s/fiCFk7PyZK8qwwvt8gH9TUBblSV5ubC4jqrzLJWta9LfslVUdB2BV238y
         Vc2dtckPyg+ejPYHP+D1v5BwNMVvic6hfPtmvCZ0SFdzHZsG2mdj9H3Ks33h/AjdHYsg
         jCRbrgZ2f3TlK/wccJ0MBuSuKNMOXa6uAY3V1cT0qVmWjm4IMAkd9PN0FOXmRYLCnGeG
         6jAWlMKoHV67TuDsjZ06kDpwl0OGUclawE13O+05YtZlsoxBGcQGQlkB8iYAUpoWQbU4
         HeEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTbY09whqTaF27jSb+34Ji/ubpyEFADvyi8cK51n44iEGoJv5FA1AKEKOp9dGTWc025oho2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrolvWvuXbRmrAjwnlMZwSa/93QTKwZ/x8555d9VqpJgWnf5C3
	wlqMxtsbXZ/wkH+ccisDEWTIAFQ2I1MqDUIAtC6NtspZGtt8ZnPmH+KMMU7aZgfuy4XZZaaJP6W
	BEGh4ERj6JbwOfKLy8m7KbW1k6dBrjLhsRgNZ
X-Gm-Gg: ASbGnctV0aiMoLirfWGFD/TrmRpGPEYb1fMFJnElXBBVVPKrbJJlmB4P8+NsQZtqc3n
	AKtuDwGxpVoJlCjBvLGtlPYgpxvVH93n/M7tR5vXTe+CCvvANODXI0hf9dI46mA==
X-Google-Smtp-Source: AGHT+IGUu2m/2cY4hgbWj4Msq+kdzpbDU7WfNrPnQt6/oLHQmr5ONZzvhOsjwWnhRUTDbkJiuRmk6rxt3uvN3fps/Kk=
X-Received: by 2002:a05:6402:6c1:b0:5c9:85dc:5ae2 with SMTP id
 4fb4d7f45d1cf-5cefbcd6d8bmr299473a12.7.1730938590849; Wed, 06 Nov 2024
 16:16:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241018180022.807928-1-praan@google.com> <20241018180022.807928-2-praan@google.com>
In-Reply-To: <20241018180022.807928-2-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Wed, 6 Nov 2024 16:16:19 -0800
Message-ID: <CAE2F3rCZALbQQUNeaAqShgXz6UNnSQAagqE7RA9kAewBFJNenw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 11:00=E2=80=AFAM Pranjal Shrivastava <praan@google.=
com> wrote:
>
> Introduce `struct arm_smmu_event` to represent event records.
> Parse out relevant fields from raw event records for ease and
> use the new `struct arm_smmu_event` instead.
>
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---

> +struct arm_smmu_event {
> +       struct arm_smmu_device          *smmu;
> +       u8                              id;
> +       u8                              class;
> +       u16                             stag;
> +       u32                             sid;
> +       u32                             ssid;
> +       u64                             iova;
> +       u64                             ipa;
> +       u64                             raw[EVTQ_ENT_DWORDS];

Consider removing the member named raw from struct arm_smmu_event.
Compare this with struct arm_smmu_cmdq_ent and
arm_smmu_cmdq_build_cmd() which keep the encoded and decoded versions
separate.

> +       bool                            stall;
> +       bool                            ssid_valid;
> +       bool                            privileged;
> +       bool                            instruction;
> +       bool                            s2;
> +       bool                            read;
> +};
