Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BA34424
	for <iommu@lists.linux.dev>; Mon,  8 May 2023 16:42:39 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-94a34a14a54so951891066b.1
        for <iommu@lists.linux.dev>; Mon, 08 May 2023 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683564157; x=1686156157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QR27B1v/nsW7Z6zgeZwIrFb522oCHrgCRwmb//arvhc=;
        b=Sr6pXfgM7T3CynCy78ggzUdQWyxVKX4tIi6nfPfYt1RHbXcu5S8wMvB9tRXKIkU5Aw
         nErFSccJxXYNyBiQEjpiMOC2f5jsZlh/dPJVwc+i1JX1dO8QQFR7PKFWNVC3hhS0Kwk2
         lzMeanGP5oT5MTR0aIKUoozGegGyGGhzoMgIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683564157; x=1686156157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QR27B1v/nsW7Z6zgeZwIrFb522oCHrgCRwmb//arvhc=;
        b=bCZ1SPtZ21wZzuplENiczbkwCBnLyJhmW+TGTr5UoIOa2683lXptV9WIMnW9C669a9
         kwnI96iQ2UnY1Pviw4k5f+HG+dK2+1qz5l185jAkJopWnAbxjVsFJQcPzTiq2ZNQd8AJ
         w83kfdLGeTaiJXb3e/sLWNvqjx3uTGXnkDajedqX93Hi+6g0psznKxuZnmM/Zbqdv3oi
         Gz6stVAQBpfUTYSTph6J0GWX7o6KJiileIzE8V9UCXWvLgUWUCQF0/Es8v7eJfCFgaxV
         UY7/XX8dSDw1fQivtE+2TIN24wMkouzgbS2NkosvbsRzCCqbktWIHM0tQaCjSMi5Dh3d
         Exyw==
X-Gm-Message-State: AC+VfDwc1Wz1P/BePFTfJXtfQp3kmuren4Tjy4153F5CZo4XQ/9vmNml
	en0dbux6YXvBPvk+LYJI6nweCthabmdBgh24qsLx6Q==
X-Google-Smtp-Source: ACHHUZ65WT95dYtl0ZOvCJVmIIOxWe0c8qEZcWu3DqrI/K0qb3G0vOCZqz7WA52PM7Fa+jKS33r75w==
X-Received: by 2002:a17:907:9308:b0:965:b2c3:9575 with SMTP id bu8-20020a170907930800b00965b2c39575mr8615700ejc.57.1683564157387;
        Mon, 08 May 2023 09:42:37 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id d11-20020a50ea8b000000b0050bc6c04a66sm6286796edo.40.2023.05.08.09.42.35
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 09:42:36 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-50b37f3e664so8684318a12.1
        for <iommu@lists.linux.dev>; Mon, 08 May 2023 09:42:35 -0700 (PDT)
X-Received: by 2002:a17:907:842:b0:94e:c8c:42ec with SMTP id
 ww2-20020a170907084200b0094e0c8c42ecmr9098645ejb.20.1683564154924; Mon, 08
 May 2023 09:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
 <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com>
 <20230506150741.2e3d2dcc@jacob-builder> <CAHk-=wjmOAQnqJF-pW=fzMXb_Rk_J_Oi4ESBLmVPhxwBK4xfGg@mail.gmail.com>
 <20230508094014.53913cf3@jacob-builder>
In-Reply-To: <20230508094014.53913cf3@jacob-builder>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 May 2023 09:42:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgobPe0U=Sc-PH08vF-ZbG00KrzftEpQMQ=n0LLNn7y6A@mail.gmail.com>
Message-ID: <CAHk-=wgobPe0U=Sc-PH08vF-ZbG00KrzftEpQMQ=n0LLNn7y6A@mail.gmail.com>
Subject: Re: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker <jean-philippe@linaro.com>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Raj Ashok <ashok.raj@intel.com>, 
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, 
	"Yu, Fenghua" <fenghua.yu@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 8, 2023 at 9:35=E2=80=AFAM Jacob Pan <jacob.jun.pan@linux.intel=
.com> wrote:
>
> Conversely, we could also have some part of PASID that is not about SVA.

If that's the case, then we should *definitely* have that IOMMU_PASID
kind of config option.

Then IOMMU_SVA - that needs PASID - can "select" it, but any other use
- that doesn't bother about SVA but might want PASID for its own
nefarious purposes - can also select it.

This is why we have config options. Not just for legibility, but also
for "there are different scenarios".

                Linus
