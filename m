Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB05417583
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730741028; cv=none; b=eu7gOQk7M1QX0F+niS+L9YqAgfKrwSWWCyaj1uVEEebqvXi04+6QkMPdDeq5mdFcS/DWKeCQm8+fJuu/5S4h9X+Cn302fxkX/w2GFGXOJ6bMm+ccLaAjcSuXT1+6P58WLLMTjEa26Gz3ljpBqptBaUNmJxFr+52/E+wY6Rt+Aqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730741028; c=relaxed/simple;
	bh=lLCR3ey6Aywm8pzzEXibOabM7Tk97XUmt+OK6dOIhy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftUTdprKnSvA6SJAdp4JCOF18UvaDSQoP2QK+ZRstCHt+AlDtWfTBmmbyvAB6C6YUHZ/tFiBdahB4SEikce/zLs3M35jO8u5gxCSoKjersM319lEt7UD0wJz0DlGwhQPkGP9Vb6561nQ9/xIXB2uHKFgPNCMACpP24hdhZCVOQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zX+qMkEG; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zX+qMkEG"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e681ba70so31161e87.1
        for <iommu@lists.linux.dev>; Mon, 04 Nov 2024 09:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730741025; x=1731345825; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YMMfEELvIAZyJYr4Q5Y3UH7/qXTwPo/vFBPbalpGDE=;
        b=zX+qMkEGOeuDcP8bw1EFqpTCDV2Bq4bh2FmDz7eoZSDJ9bX/XHtS8guNZ87JfB3lMK
         WNtLV91NRQxDP9/cFB8hHFAEZyrnLKpcSWjZQEs/OYbs6p+rNylUjKpIPy7xWsFmaWM5
         jGOT/fGoBgynsgpGpycnzr7uw1TyOKwPNyP6acbQYmsa2QhD8TpduuFyj/QQetF7qvvj
         HBIrxkmvVUUISPJmVa/gxS6CQcwVLGWuJU3CIXtTUNd8nn62U17eqLJw9lOl11OGcfmk
         EA2xVMgeUiflbBspfLkVcdkwdMEfqR/TCRJEa3mnkOhiRIxB3IJzJjaZIvGPv6NBB9/z
         B8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730741025; x=1731345825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YMMfEELvIAZyJYr4Q5Y3UH7/qXTwPo/vFBPbalpGDE=;
        b=d+kbcACD4wKT2le1xhiAet+O89XNiho8LrIBYU7MANSs5BlloK4YnkOoR/u28nyReo
         jUVnFsNuR8c5/v2274zlhDQyayxpX/t+gp9Yi9e6UBj1Pco+3pMmRlf5M2Ng92NZw8Oh
         nwrV83AUmiIJ9wRrnjlIYAZjO8hAdr4Tp89NcF93OW48qBFIbmD5mQ4V9k+BTMGfn7cs
         KlSkU9WMpmqdd9ggHrn6vHpctWXkAJDr8ZDhVrD88BVT3r4W/5x9MFj0N082qiUPrg91
         s1P7IpO3R+VqhXK9r/eic8HnqGXEKVGkBRR335X4yhwg0hAgfLBuZl+3QpNeiTrHhUl+
         PgFw==
X-Forwarded-Encrypted: i=1; AJvYcCXwyD+Q9gsCmSwsgonD0rntn6FCTuqRdPavqEgC5N2Dw0w0g3hLR8nZjgKuQGSnSqgzQ3W06A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxO5nHua3BXVIE+Tf78jMHQBWh6JbjvmRsZZdyW2MIwTcpfSIOr
	bZy0VDKBKU4AKmVD6DPg8qY7jt2AfHzb1lHoCswc7hK7aDzqrbHvMo13ECNN8Qxmkms9aJd7M+r
	KxGSkMgo2raSHXYjIk49KjxS42+n2mRl8/xA+
X-Gm-Gg: ASbGnctivwY0TV56WtA5S1XYU9GMajqkUk9wahxfZ/4oXczCllS0xC5sVQyu40zCpo3
	MO/mudkIzoqej7zRfL61JuLxIfVO7b5X0ta9e4HMlyQOQki863l81zLvNxr97iCQ=
X-Google-Smtp-Source: AGHT+IFeAv1am0CoOekDXZjVJDgT+xlqBdQkq92qoLGUMGY12Y4fdOoupbN3ouXZSPk55idh4W2aj+8Wntu7N02ZhoQ=
X-Received: by 2002:ac2:53a4:0:b0:52c:dd94:73f3 with SMTP id
 2adb3069b0e04-53d6b1ac6d4mr403996e87.3.1730741024746; Mon, 04 Nov 2024
 09:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241018180022.807928-1-praan@google.com> <20241018180022.807928-2-praan@google.com>
 <20241024131147.GG30704@willie-the-truck> <Zxp9kHerb-ln4ioO@google.com>
In-Reply-To: <Zxp9kHerb-ln4ioO@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 4 Nov 2024 09:23:31 -0800
Message-ID: <CAE2F3rAtg_dE2NpFM-xB8fs3W+_7tANnBdA00SVfKgk-y6X5Gg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
To: Pranjal Shrivastava <praan@google.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 10:02=E2=80=AFAM Pranjal Shrivastava <praan@google.=
com> wrote:
>
> On Thu, Oct 24, 2024 at 02:11:48PM +0100, Will Deacon wrote:
> > On Fri, Oct 18, 2024 at 06:00:20PM +0000, Pranjal Shrivastava wrote:
> > > +struct arm_smmu_event {
> > > +   struct arm_smmu_device          *smmu;
> > > +   u8                              id;
> > > +   u8                              class;
> > > +   u16                             stag;
> > > +   u32                             sid;
> > > +   u32                             ssid;
> > > +   u64                             iova;
> > > +   u64                             ipa;
> > > +   u64                             raw[EVTQ_ENT_DWORDS];
> > > +   bool                            stall;
> > > +   bool                            ssid_valid;
> > > +   bool                            privileged;
> > > +   bool                            instruction;
> > > +   bool                            s2;
> > > +   bool                            read;
> > > +};
> >
> > minor nit, but it might be worth seeing what pahole says about the
> > layout of this structure in case you've got a bunch of wasted padding
> > thanks to the mixed-size fields.
>
> I ran pahole with this, looks like there's only one 4-byte hole but the
> cacheline aligment is bad (for a 64-byte cacheline):
>
> struct arm_smmu_event {
>         const char  *              master_name;          /*     0     8 *=
/
>         struct arm_smmu_device *   smmu;                 /*     8     8 *=
/
>         struct device *            dev;                  /*    16     8 *=
/
>         u8                         id;                   /*    24     1 *=
/
>         u8                         class;                /*    25     1 *=
/
>         u16                        stag;                 /*    26     2 *=
/
>         u32                        sid;                  /*    28     4 *=
/
>         u32                        ssid;                 /*    32     4 *=
/
>
>         /* XXX 4 bytes hole, try to pack */
>
>         u64                        iova;                 /*    40     8 *=
/
>         u64                        ipa;                  /*    48     8 *=
/
>         u64                        raw[4];               /*    56    32 *=
/
>         /* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
>         bool                       stall;                /*    88     1 *=
/
>         bool                       ssid_valid;           /*    89     1 *=
/
>         bool                       privileged;           /*    90     1 *=
/
>         bool                       instruction;          /*    91     1 *=
/
>         bool                       s2;                   /*    92     1 *=
/
>         bool                       read;                 /*    93     1 *=
/
>         bool                       ttrnw;                /*    94     1 *=
/
>         bool                       ttrnw_valid;          /*    95     1 *=
/
>
>         /* size: 96, cachelines: 2, members: 19 */
>         /* sum members: 92, holes: 1, sum holes: 4 */
>         /* last cacheline: 32 bytes */
> };
>
> I don't think we can do much about the 4-byte hole as the members occupy
> 92 bytes only. I assume a single 4-byte hole shall be fine?
>
> However, for cacheline aligment we can move the 3 top pointer-members,
> `master_name`,`smmu` & `dev` which improves the cacheline aligment:

Can you be more explicit about what is a good cacheline alignment? I'm
wondering if you're trying to ensure that raw[4] is contained within a
single cacheline as opposed to spanning two adjacent cachelines. I
doubt that this is worth optimizing for. Also, I'm wondering if this
analysis assumes that the base address of a struct arm_smmu_event
instance is cacheline aligned, which I am not sure is the case. I
would solely optimize for size.
