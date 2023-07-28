Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171A12F35
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 07:48:22 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-40631c5b9e9so167131cf.1
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 00:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690530502; x=1691135302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUIcMhVF/1TXo1rqJGfnJ10sMHDmAV5y2UmUPZxHyso=;
        b=zm2w/xaSYP9fraWbl9XbK57vPboGwFbaKmAn53G34La8VFbct9frpGoZBErfB8qcY0
         PsyLraOMAE6EssS6TGMr6sTBNSTalvEFjJHW5pDKCfWyeY9cQUdJSlT7Q3ciDuWx933m
         SIrJEdSjUCoOCLHgLMfkUD/mZMsuh9qwOVZ63YlKtJl0fVtTei+MWl2pYvL9kP7eJxSC
         T/Edi/zqpNKBM67b65buVS3yEYEHj1/AX/KU5sCI1XeC0+KTHfzEni6E7S9hvCm3kJ48
         ZDtjwcmmYqPVfHxpU455E2j24bzWpPO+th7YT10EKaeCkEMBDRG0tOC4eSNj0pkYpjKA
         TUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690530502; x=1691135302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUIcMhVF/1TXo1rqJGfnJ10sMHDmAV5y2UmUPZxHyso=;
        b=XsCyWRTZMH8xRbh02CcWQ2iatBYynmY7bz9oh+mggshFB3D1oKfLmFdccE750+kl6K
         ByEbLRMzKEAWoKB0kzKXccqY1r1fHJD8n+TwwMuBIHrTrsI2f0yASeWmOXNoGxVPQJTY
         HSG8KkPzwklhpYtowQpbLZiZeKKnMQsqBXQfCUgSR3De2KeqPf/Vwo8M9nsB9cPCUwVB
         1hAqImVrg5L22gemuNyCnxJNkhSAKtIMNwmLpTzzMpRUmII9wAzP0gcAsEk69ceDuEGm
         O8ObBdXDeBDzdYB0+smvjgT5/MVVwHVXVH8/dHOOxC1legf4n25BJqA0b8Pxx/sMwQxa
         IpkQ==
X-Gm-Message-State: ABy/qLb8tS83Ac1YUvPbfVRTeyNTSKtX4W16mUKTLqXwArUgNx73Fn0/
	8ffTicTFO/wWq+SDwr7cZSvYOHOZ95cJp1fX/SwF0Q==
X-Google-Smtp-Source: APBJJlHNHh7OBFkfrB6xevuRXLFBa3hgMyt/+TAPrzU2QxrKh7IGRGo24VsyFyVjyhWh6yXWTm/ElpomUyCgUFPl7b0=
X-Received: by 2002:a05:622a:58f:b0:403:d35d:4660 with SMTP id
 c15-20020a05622a058f00b00403d35d4660mr129612qtb.11.1690530501658; Fri, 28 Jul
 2023 00:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com> <20230727182647.4106140-3-mshavit@google.com>
 <ZMLaM9QjHDu11iKf@Asurada-Nvidia>
In-Reply-To: <ZMLaM9QjHDu11iKf@Asurada-Nvidia>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 28 Jul 2023 15:47:45 +0800
Message-ID: <CAKHBV252e5Cx1nssFTPVBmr_iGqLhvp1jjBfR5euRynAzHC12w@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] iommu/arm-smmu-v3: Replace s1_cfg with ctx_desc_cfg
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, jgg@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 4:57=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:

> It'd be nicer to align all the variables to "cd_table" like the
> 2nd piece here. And if we rename the struct name too:
>
>         struct arm_smmu_cdtab_cfg *cd_table =3D xxxx;

I agree that renaming these would be nice. There's 36 usages of cdcfg
in arm-smmu-v3.c, and 6 usages of  arm_smmu_ctx_desc_cfg.
I can rename the struct since we'll be touching many of those in this
patch anyways, but I'm a bit concerned of the churn from updating all
the cdcfg usages.

> Though "s1fmt" is redundant, "max_cds_bits" doesn't seem to be.
>
> It'd be nicer to separate them in the commit message to why we
> remove s1fmt and why we rename s1cdmax.

Will fix!
