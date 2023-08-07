Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02063DDBA
	for <iommu@lists.linux.dev>; Mon,  7 Aug 2023 15:03:13 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-407db3e9669so469161cf.1
        for <iommu@lists.linux.dev>; Mon, 07 Aug 2023 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691420593; x=1692025393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sjbQgfVh4+chNJ8EXVHqEaf9Z0qufHdO6KYLZ0+AlE=;
        b=C13nAX71DuxP8u8617uVB420fVs33zJxNc32Nz4uo3tPmeOfxMu0iUIxYp09pE7q53
         rw50DsGmJoJmzuziN+xcSYGi6PZwBsAeB0g8sPpr9LUiDjo471gQdZaa+aSM42u96OBa
         B8pOdFy1d+PtTpqiZqI547fF8x6Ii+4UZEc+5c4opfh9eWbANSQfDzrKEW1WLVrp5ssT
         6XD0xyk7q3g1KZ6V893GRTJSKq4QWxfVZNY4XVUkl43HL5Z8O/pKAFctscSUcCmS0wWl
         0PoBGcf4wnSqB03+1nTMLEDafoTekrrUYmlHW/L/2VumHIbqGdDrzzn3TeK2U2sHIBPY
         giEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691420593; x=1692025393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sjbQgfVh4+chNJ8EXVHqEaf9Z0qufHdO6KYLZ0+AlE=;
        b=WnC2lZRL4uMXmkAm3zPGkQn1W9AMy2mq65gTR0PaqWYhAI3JpaJm7vUpFKTn639dOv
         74ml99l1GKO4uRPwLRoStFuUEZN6zlfwkLjW0T1PpZDKtIi2tFR+g/ZMFerIT3BRokfo
         c0gzpadprAxb+L9t3L7o5077StnA4ZydNcnlYnGG29l56RbQ5lQSwwHUsGalFZSemmSL
         rlYSvWoDideU4XS95iMmGthWXXLI5gjCHgWm8qNeJ5aq2iXStaG4U/zbrDLsURPixk6J
         gPcoZ52n4u8mBzLc2rGm7auXEVNCJnIuryceJcLPTRObMpKOiCqYJb5LuWcufM3HjA4O
         wywA==
X-Gm-Message-State: AOJu0YxXb8xcgN0dwj8BeitwacdH2szR/RVH2zeCnVeojJzuoVjB3Jgr
	iDNLIHRCiMVCqrDYyQty7MSEGetoPz1W4Vk+nCEZlg==
X-Google-Smtp-Source: AGHT+IEGoZQC7C1AQ/DFaQeVurM32Yd2O9ZQ+8VygMrQeWsl+H1IH61VxF2PRXaBNe4iiVPWyOtMfBWdCO4Px6caR34=
X-Received: by 2002:a05:622a:40f:b0:40d:eb06:d3cc with SMTP id
 n15-20020a05622a040f00b0040deb06d3ccmr429004qtx.7.1691420592462; Mon, 07 Aug
 2023 08:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230802163328.2623773-1-mshavit@google.com> <20230803003234.v4.7.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
 <ZM1Yh5vzfxwV5Rbc@Asurada-Nvidia>
In-Reply-To: <ZM1Yh5vzfxwV5Rbc@Asurada-Nvidia>
From: Michael Shavit <mshavit@google.com>
Date: Mon, 7 Aug 2023 23:02:36 +0800
Message-ID: <CAKHBV24356NsGu8QL3iVh2ANt8NMGx+ppMuwgYF=hwHTVE0-MQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, robin.murphy@arm.com, 
	jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 5, 2023 at 3:59=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> w=
rote:
>
> Before this chunk, there is another fork for "Bypass/fault", where
> we could set "installed" to false too, although it doesn't seem to
> cause a problem at this moment since arm_smmu_sync_cd() is called
> only in the context of an ARM_SMMU_DOMAIN_S1.

Oh, good catch; I didn't notice the return in that branch.
Fixing in v5.
