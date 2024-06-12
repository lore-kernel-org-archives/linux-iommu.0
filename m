Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F2EBB
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 00:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718152661; cv=none; b=qccAGTcHuWYtrE90jV75dVXYdKV2xq0uFy/FEFboHrWfN2+5DFKLqHLZr44IQs7lbJEKOnQTawMfWfNqCGGIyCTZ+p8WfCuLsZ+vGGulFc+WPx4rhB1ynpyX2RhNZBtDBvCZimmggOAxe19UjQ8q2c9FMPigyzBmfYt6CyPvg0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718152661; c=relaxed/simple;
	bh=CbxB4gsF19wnuHRkxYjRBOGmzgRMjYMbezsZVPYzI/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJaNbdS2y4wSEKB6H4jNViWnN7VPqTbgMHNlZYbp6CXhWSYneOEkesK8V2XeuxRxB5jqAxLmYoc3V48eICEwsu78CugZGcYx0nEnsFkGPLhoUpXBnQMiMmZKekevYZicIzgV8beQw+g/CcvGCKguU9V5VFJ1J3SuTJpZ6qK1eN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IzDSRtA+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IzDSRtA+"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c8bd6b655so7822a12.0
        for <iommu@lists.linux.dev>; Tue, 11 Jun 2024 17:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718152658; x=1718757458; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbxB4gsF19wnuHRkxYjRBOGmzgRMjYMbezsZVPYzI/0=;
        b=IzDSRtA+QR1AmYrbaFJ7rGwacFQmR7wj6OkmVh9ICEvHAxEgXFZu5zcZp9RHdin4+G
         pMEBCR9CNkMGLUVTqdMZ48+mQhBKE0dtO6vRTAaL9Lk+gRjn1xiaHKVcexRP/pUamGbf
         Moo8JeGWjqmVnqLYLg+w9+S3OeC9INgvwIDTgTHaW2lIGCTzM1CS5F1q2ioxaOrEaCux
         seo53250gukx9tDG2eLldcSCa57oATHQD1/aO7wGqk+kXzGEiic2XloWAvZn4tsyU7aR
         76YZ5BaAAN8g/9eaQjakyTlcAbKoj3BrxUPBY+CLSoDfLcc8XVZCuIxhshpKZ0ax4AnA
         jRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718152658; x=1718757458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbxB4gsF19wnuHRkxYjRBOGmzgRMjYMbezsZVPYzI/0=;
        b=f9N8i7l2XehRwQPg2CfhUhGKVNiBtovt6n2p/1KNIaK5scVDUzQiSsK0yPDGy6v+Y3
         Ap/hpiWf/xpEVmcNr3fZrXG2mvFblGVmFzEiroTaf/+RLT6smsHll4YmbmoWuVCiVr2y
         7J9OSje4HdQQgJ0Saqxg4j2/2TJKQNfm7rdLeSLN8GH2ByxpKKsVMx/UaJeZnkiLjkwy
         0iIoMMszNLd4ztsr2RHzSU6h+LQhVtsE91bl2ZtBG8qaKiVy8fYI38+zZ//xbuVV8LVY
         une8OQbIKF6kAbuTazKLeXgu0eUvHNBEgxX+44b10UhT8SYCPB7oSbDDR2we1c96+KHn
         umuA==
X-Gm-Message-State: AOJu0YzSPXvckHKEMw0Uj7VAA7zCjpHQG2UfQ98F3vSv27AJu3SZKvnk
	DqiX//zPg7rZ9uiACq5P3PQA8AZaR1Ft7bj+Tp1g9nkWKD9zooPM836YNCAfFLMRU37Uc0Hq7Xf
	df46QKiIcQMDakZJs/xF2Fg8nZE3eX8kLW14T
X-Google-Smtp-Source: AGHT+IGPogOtYqDEs+7RxuVSqbTRCrwDGOHdpFBNLv9I3kbjcl6SRTnxLsX2Kfx19alhBDTwgj55N42gOEfTZvGQj0A=
X-Received: by 2002:aa7:cd17:0:b0:572:988f:2f38 with SMTP id
 4fb4d7f45d1cf-57ca7fd71e8mr98062a12.6.1718152657843; Tue, 11 Jun 2024
 17:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-318ed5f6983b+198f-smmuv3_tidy_jgg@nvidia.com> <3-v2-318ed5f6983b+198f-smmuv3_tidy_jgg@nvidia.com>
In-Reply-To: <3-v2-318ed5f6983b+198f-smmuv3_tidy_jgg@nvidia.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 11 Jun 2024 17:37:26 -0700
Message-ID: <CAE2F3rBA-QHBROY9T0eo6HzYkMOs51+xMXHZLSjnz4=D6XEszQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	patches@lists.linux.dev, Ryan Roberts <ryan.roberts@arm.com>, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 5:31=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
> +static inline unsigned int arm_smmu_strtab_l1_idx(unsigned int sid)

Existing code appears to be exclusively using the data type u32 to
store StreamIDs.
