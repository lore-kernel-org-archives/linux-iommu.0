Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF782F35
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 07:53:32 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-40550136e54so220951cf.0
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690530812; x=1691135612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCkZl/qhv7Jne5YDBQ8ejzDwVZoTpLAS727QSMzp5Q0=;
        b=6fRRzIgSr85C86YxYuL3k72o/nG8Mz4C+lKlI3SrmzNHHvxxXkuNFPFBKeQ7TX6VT9
         qMWsGVOWBFZVuLPp4/jM6QV7f8kQsZIFy96EvVrmlJaNQOOi1ZHYPWmDicqh56k6QJbh
         qkxivVEgMFSRvkk4j2T/8djCvq2aX5q/T3qW17eojfahjzOLwUuR3i/2WYu5a/ZTpe5o
         Puw9HSdiZpO8SMxTZh7Q+Ha+D5d2n65k22wFvXf/3vHDhlUYQxQapBcUUk0J6c9v1EGi
         Oa9LgN65HyW8juGw72UI70gy6wpeQu5j4alDiL7mRo1OYRevd7VLzs0Xj2Vqi0vFNgVp
         Ex8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690530812; x=1691135612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCkZl/qhv7Jne5YDBQ8ejzDwVZoTpLAS727QSMzp5Q0=;
        b=IU+tS06Jui/J5gzB4HWFLMgZBAi85VpZ5Dx2fRfkGofSTybBUTuTwfpn6vJqUOp8R5
         dNpRdmSCCi6cP1Wn4TalkKeAapkVFo4lL/Q4FaeWmtbABCVDmLe3y8owzBmdxlcDd4C7
         bTfx82g4g4j/jlRZXt6r9qQQZWo4Hp/OHHmkzPnwIOtY64zxvDuNh9Ji9KU5S4DYtqO1
         rYZV7h1WHa+ZTSxVBde3C0V3IlARsIE6dVxBvjBKz9Bgp6TGrZjFYEi/yRj6GMkhvYfa
         9MheznY5o1DsKzze0Q4Scs/MZdcYxKL14YtTC/AmTQMdOg2/C1B1UMRrk3Xz+lasTC9Z
         UrGA==
X-Gm-Message-State: ABy/qLYbkYidUjRTSOZFW+Bb7+P0HikHYt1Foh/KeW4V/zLK20kIV+co
	Z3tPcUMn7b32TyDPmel4bVfLGbg6gUSax0LtaL5Qog==
X-Google-Smtp-Source: APBJJlGD+SwyVD2EOuZnO4UoKoOOcE6/ENbNmOzXdUfuF/X+GQBYzXEFu/reLSXEl57dPRqhCmrPVZzVmXxy62vjJUk=
X-Received: by 2002:a05:622a:1a18:b0:403:b6ff:c0b with SMTP id
 f24-20020a05622a1a1800b00403b6ff0c0bmr216044qtb.6.1690530811464; Fri, 28 Jul
 2023 00:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com> <20230727182647.4106140-8-mshavit@google.com>
 <ZMK60wm3BBk038r7@nvidia.com>
In-Reply-To: <ZMK60wm3BBk038r7@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 28 Jul 2023 15:52:55 +0800
Message-ID: <CAKHBV24U3ekA9vFbh1_ZzO88qkozxVnwP=AMkNkbDnSTH3o_dw@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 2:43=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Jul 28, 2023 at 02:26:23AM +0800, Michael Shavit wrote:
> > Each master is now allocated a CD table at probe time,
>
> Currently it is allocated during arm_smmu_domain_finalise_s1(), so it
> isn't allocated at probe time.

Urh right, I meant that this patch moves the allocation to the probe,
but that was misleading wording for sure.

> I think the right place to put the allocation is during the attach op,
> the first time we need a CD table then go and allocate it. If we can't
> then domain attach fails with -ENOMEM.
>
> Then you can put the free in a detach op once the CD table becomes
> empty and it behaves much like it already does.

Hmmm fair. I can't think of a reason that the table *must* be
pre-allocated for the PASID feature, and that could always be a
different commit if it turns out to be necessary.
