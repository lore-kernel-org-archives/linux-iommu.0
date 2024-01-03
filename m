Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC71B26E
	for <iommu@lists.linux.dev>; Wed,  3 Jan 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eGgv75sn"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-427b515c2bbso309611cf.0
        for <iommu@lists.linux.dev>; Wed, 03 Jan 2024 07:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704296608; x=1704901408; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BZqZfsoLFzOnYuUAQnq8Eco9vhs0Xn+54z54M3p2vw=;
        b=eGgv75sn1s9lzGA57/6egaBoH9ztK3vmJgJ6FrkRz8ac7pqkOgwVl73TdKkVErlcll
         i1BNAusLqY5tZGBxjcq1OPBqqWfFOnfpRhrNulbm5H/xFiCNdlyPX6G00E+APVWsCqQH
         NhdVJnHCu+B4qT4pOzcVcmWkGO8hRjzANqeAn2A+G9Lk4cpsvMPj65zFCo3sstBv31Ug
         W4QPoSZKm6h/cPjq8DAkiYuMSzXk7aELBdRUMMvgpjhXk7URvjpL4dHrKpSf8EDlH5B9
         +mvPhhAWyqNv/vSD552N0OqNHTNnswJx6Znt5zghUv5hbxdiwJLpDyqQx3gE60LkKm50
         RjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704296608; x=1704901408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BZqZfsoLFzOnYuUAQnq8Eco9vhs0Xn+54z54M3p2vw=;
        b=VRJuQQVbQQrTwnJnSNSe0q9bHBvsV6AFyCxwrCQB+HF24M5aQTADuKZPtInf3vDEL4
         ZQpUWQ6gAVWe3MddjlfA2znRHBbJIxX3RaE55rvXIFjOuvhHh2NWe53gP6DC/U04Nfhh
         ylo1mtY2rc02RxxFuU8jF82CAJTCTyTBsnGvABfymiN/VrY6NNhQnNYAQ5kzIxw9UQ/4
         pZNkGGkJgNVHQcV0Y9ZSP3IdFTDStwTWreFBwucGD1BLLaUiFXiQRDddvrnN0QbUE1NW
         hAVVc8Awg3XOBm99zD5arwIFVCcHk4Ir0VMt7ea8FKym5/VwaTMx8aGUiYodoUNFC8tP
         aCEg==
X-Gm-Message-State: AOJu0YwOXkowNogWhHBfs4/fw0MKyUuKRePhrVm2Ot5LH191Je9FRjaM
	V5TVlBLcP1mCYITpQB+sWkN+GNovZDTd/uoHZ6nCLVqPGA3x
X-Google-Smtp-Source: AGHT+IHwO6gllQd0x4W/+tJZ7y23+nggPE9uUun6R47KPXbdWuhXIlhRP3JQd+LNxNJpuB0+XaQ7xuJyqs0XbRVIKWI=
X-Received: by 2002:a05:622a:1013:b0:428:3472:eb9b with SMTP id
 d19-20020a05622a101300b004283472eb9bmr247710qte.18.1704296608462; Wed, 03 Jan
 2024 07:43:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231012121616.GF3952@nvidia.com> <CAKHBV27G1PLZ5gkYkOOCZdD9waZOZypkWqk4_HSR4XXGFT-+LA@mail.gmail.com>
 <20231018130455.GU3952@nvidia.com> <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
 <20231020113918.GD3952@nvidia.com> <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
 <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
 <ZX7xu8jN/rBZ4A/d@nvidia.com> <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
 <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com> <20231227154648.GB50406@nvidia.com>
In-Reply-To: <20231227154648.GB50406@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 3 Jan 2024 23:42:50 +0800
Message-ID: <CAKHBV26v9V7UqqLP+h3yxpPtAewNOOw6zD3DNfDpcejiL1Fr7w@mail.gmail.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming independent
 of the callers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 11:46=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
>        } else { // hweight8 =3D=3D 0
>              set(qword_start=3D0,qword_end=3DN);
>        }
About this branch: wouldn't it be more clear to explicitly do nothing
or warn if any of the bits differ? We shouldn't ever expect to see the
STE differ in unused-bits position.
