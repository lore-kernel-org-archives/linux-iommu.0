Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F01196;
	Tue,  9 May 2023 13:12:20 +0000 (UTC)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so30422878276.0;
        Tue, 09 May 2023 06:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683637939; x=1686229939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2TVkTcRR+HHLfwU8yYzkifpJylSopd6W+iGl+jzFcc=;
        b=IqgFetJku+D8SG7U+6Y+fxClTw09OYQB7Y9UUENlnULKngDeHvyObpmIfXEmo/6OY4
         IqZ7jgbWgwjSUfkbVFRss8Y6dyRGtL805jEDf8ZeeIgir/aogu2u94CINhNnXe34yEqQ
         rjxoO356CwHqYPWrRSXhs0jTglTN6i3HXrdgE+7eLwsbsbOvxrIMi/x1yuKIZwV2sBpO
         kxPLBp1K9egrsJEvorxcZLSWf7T6gCV8c56RtaVIbU/QQwzXptlcXZLM26D2NLvOY+qq
         9AItZhBwwnvuobPQOv7wuzfPN4l0br83JhCTzVKIwII2RueiDs6N3wbAOMkrNglYNYsg
         sTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683637939; x=1686229939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2TVkTcRR+HHLfwU8yYzkifpJylSopd6W+iGl+jzFcc=;
        b=i0FALIHdUSSeZ+a7+9F4Rh3FxQYALSBY/kUimq5DWpudNMJH2OXRQnFk+X0EMnETNA
         mXSdr2i/gwO0VWKEEixJh5hRnN0WS/yt5zjdB5CplDCknE470O7sF2G4xsvtqwfRRpec
         zkmDKel9HmBqzJW+nyGKU8xiuaGHpszH97tYoLPqUcU0uXi55Ve1YdjaMQ+QSBSTKcn8
         KhB9OCZr08Mn4+kcRT2yskzce5bwsicwRVKOsnvmsPw3yLpGzV0dCV6BcdB3t+ZGzTCM
         r8FSsKi+K/TX8D0riIvJyRBys4wHhhoqume1yJvrKbaEtbkXrVrlcAYMGUE35fq2yvJA
         i9Zg==
X-Gm-Message-State: AC+VfDwi4/FNOgxxu/d1C3lNTVfU6W4nXQ6OcZ/wedaPCD7j8Gz3K73t
	JvTgaPbDTl0vxktCQuwp61yR1qmB+NSVAqP9ViM=
X-Google-Smtp-Source: ACHHUZ4H70Ob3tXh7aZL/4+UzNdRfq3+NVyxO+HhjHaijcard9AvJqMssYLZC6/XQwlbr1GdM/OwTLNWrNmDeAouSGs=
X-Received: by 2002:a25:e7d1:0:b0:b8f:3915:fbae with SMTP id
 e200-20020a25e7d1000000b00b8f3915fbaemr15459162ybh.2.1683637939712; Tue, 09
 May 2023 06:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <2-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com> <CANiq72m4sGq10s==TPTjN4L28xgHk1dYsq+o1ves7_c6pho_pw@mail.gmail.com>
 <ZCWcd5FkGhpYhCUi@nvidia.com>
In-Reply-To: <ZCWcd5FkGhpYhCUi@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 May 2023 15:12:08 +0200
Message-ID: <CANiq72mymifSufr-uBJyVi-7rY2OCtKgLvbxbEQM8MF2bHG3Lw@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] iommu: Add for_each_group_device()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>, 
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2023 at 4:28=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> That would be nice..

Done! https://lore.kernel.org/lkml/20230509125812.310307-2-ojeda@kernel.org=
/

> Yes!
>
> clang-format and clangd have really transformed how I'm working!

Thanks, I am glad that is the case, and it was also useful to justify
the change above.

Cheers,
Miguel
