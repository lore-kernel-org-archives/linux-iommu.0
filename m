Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F8915EBA
	for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 09:02:35 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-414ba610766so235431cf.0
        for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 02:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694682154; x=1695286954; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1uEkZ8AewlH4VkHXLgnDcZZ4NDv2GyDPMI8S1n2Giw=;
        b=uSitbITNzDp9XsFMdKgGBrfG6ZqVzw0LgN9UGWG4HlDsTjdEHkcmge0QPxthvcTQ9A
         FIH5perRPVOOvnadcAkxeMYxe1V3CgV0833isfKGxTPEFSXYdYhz23/7rN+ElABFuuwv
         YrNabBRRLwauba1GtcRgGAL21QnYG0H7DCZ+vtCpT2l1F2zwx0F5kRPVHsyeIaq5qFlc
         GaZAbuk6WX1YnVY32Wy7pHP07xti5sX/wB9zBv6HQsTcTluampqWTapQOjNkF+WgXTjD
         sM2zQO810x/+I8Twwi9iWU3OcHrvGkfd+0k5ge8x0bXdrR3tWNKnjWsq8keB/QUKEK3s
         hstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694682154; x=1695286954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1uEkZ8AewlH4VkHXLgnDcZZ4NDv2GyDPMI8S1n2Giw=;
        b=ku4AjzS2zG1b3DoAtMyr9PKwqwWiBj/ol+FUBojmv49Ne4tEgZ32/k2HoUqh1Clcpa
         SpsWqGF3HUx2hpQ55c9FeDc09JQ5S6lfh7mYPFGMFMeELIuNIwkTWdLma8gm0UqxQfs4
         Ybw5ExyPPR4xI3Xx6mABHhlzPwLJU1j3U93Xu/VOsQsA48Z+J0XyJIQKJ31z1VSJKbx5
         RR/h7Z0dmLawTqc+OZRpkFacbdtF1cPtGoj7ehP8eZa200EzOzXTcOzbMUwZ6lZR5zw3
         X+up2uBNm1ZryUEmt+jyr2bnX4LRoLUP02Y7OWqxJhUWzTCM7gX0IWVOX3yQwF9tKnYb
         sQDA==
X-Gm-Message-State: AOJu0Yy0Ok5gmNyeCrY+ndFxNXCavot5g6g5BDMAPzdZw96UYtvjV+32
	rqFXNK9KUD0XJz3Be1OSgUGsfrV8wIxLh2PIbsb3HA==
X-Google-Smtp-Source: AGHT+IGLYvslnZ50So6mjixflAeizPqblOjFot0SC0qSJrxPgXATQW71P15tPNcPhMGfUdBdiLJYjPvjl/0Re3DbDZ8=
X-Received: by 2002:ac8:5951:0:b0:410:385c:d1e0 with SMTP id
 17-20020ac85951000000b00410385cd1e0mr467589qtz.25.1694682154431; Thu, 14 Sep
 2023 02:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230627033326.5236-1-nicolinc@nvidia.com> <CAGfWUPziSWNMc_px4E-i+_V_Jxdb_WSwOLXHZ+PANz2Tv5pFPA@mail.gmail.com>
 <ZQJbunPj6Q8XRcpV@Asurada-Nvidia>
In-Reply-To: <ZQJbunPj6Q8XRcpV@Asurada-Nvidia>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 14 Sep 2023 17:01:58 +0800
Message-ID: <CAKHBV25dfy2q73DmU7X6j_2XNTfgk8kbstanMczy8oZo_WFxrA@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/arm-smmu-v3: Allow default substream bypass with
 a pasid support
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Aahil Awatramani <aahila@google.com>, robin.murphy@arm.com, will@kernel.org, 
	jgg@nvidia.com, joro@8bytes.org, shameerali.kolothum.thodi@huawei.com, 
	yangyicong@hisilicon.com, jean-philippe@linaro.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 9:03=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
>
> This has another version [1] rebased on top of Michael's refactor
> series [2]. We'd need Michael to respin the refactor sereis and I
> will resend mine.

Just to clarify, you'd like me to rebase off master and re-send? Or do
you mean something else by respin?
