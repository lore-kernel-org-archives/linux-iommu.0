Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40588473
	for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 08:18:08 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-40a47e8e38dso164061cf.1
        for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692692287; x=1693297087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Y+P92gaIOtxmJ4GQuI1gvrZz/VMhfETxorK5TKfzBk=;
        b=XTbK95xrJra6oEzO1gFH4l3LUyPCQjhZVzPiUtK12pfKx1SfKU/ZmRcBAyKT6CYABK
         HKyrx3uFVJcTcBmsvdmN7zERpPi1u+63GNjEr8uaoOAd5l254TvXdetBum+neGos1/xj
         znnlKqJv0gPnoKlPNvUK/E8aiGqMv6ihs76Z0ezD6UaJYbqqVZ7arIE4fDWPKUecZze2
         4rnMhiYUUjnZ4KcHp5jHFfBIeqSep+q9So0PEC69rRHb0JgqBGm+N5Jo0OFmfnRA3eUp
         pjB4/txnakmdH/53EJfRWnVrmwTGIOydAWTGEdbbzdG3xSj4itwzPnN1N/CAVz6NXIMx
         zWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692692287; x=1693297087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Y+P92gaIOtxmJ4GQuI1gvrZz/VMhfETxorK5TKfzBk=;
        b=EEAxtn4OT6TwIJ76FKe2nQvwfAup4V6WkQS500DqCX1jQLCRie6fYYYOZJ9d64GPpj
         xkZRGcHs4d6UqMikMKRARtAvEN4aCQ8JCoKRayhwK6U0k3+4F+ByZp4u0f1l0wkiJ0po
         bjgmmLfr48h7AWAZ2U1uYd7vbvcTWME1ScsLx18Sp3oDIJNj5CYYoNRGWBzMamIuKopz
         FzTgb3xFY3m5dBu3SkPGJwE3zNG0+J1h0J7Z7x80yerfBWmomucT3Ikg7baEnobc0H2p
         Pg3PodwSCR+I5zKbxqrsrALhe87mJAwcT6bWbtEt+2YHrPtZP81yrC3q2rFVaNbUgPNH
         NoVA==
X-Gm-Message-State: AOJu0YwD155VACdDMuyTZOzYYDc6sTFtWvUxBZyIAw7GVvQn+nYjm9P8
	/0lSHsZDCTMf/KJprDqhF7Y9m+U0RfSLgimCck9cXQ==
X-Google-Smtp-Source: AGHT+IG6Imz+hb2H6ThrnJJSyj9TF/FlinkAsxgSUw9yPUDKDS984QzNxxtXbKl1fI2UbBLRqax8GK76LtgImM4gJkA=
X-Received: by 2002:ac8:5cc4:0:b0:410:9855:acd with SMTP id
 s4-20020ac85cc4000000b0041098550acdmr209444qta.14.1692692287343; Tue, 22 Aug
 2023 01:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.2.I782000a264a60e00ecad1bee06fd1413685f9253@changeid>
 <ZN5y4N8ffSoiR/sm@nvidia.com> <05f69a1a-97c9-ebca-5e01-c0b00699c93e@arm.com>
 <CAKHBV27suc5nDoH7gMHebjYBONTNqsugWvxbo2E-fRjRGs288w@mail.gmail.com>
 <ZN93TO9mRIrX1grw@nvidia.com> <CAKHBV24L7pTajkStWCRiW7976+B8VtDHRDpo+Emta0RshkvRhQ@mail.gmail.com>
 <ZONRRubvUK7GXO4i@nvidia.com>
In-Reply-To: <ZONRRubvUK7GXO4i@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 22 Aug 2023 16:17:31 +0800
Message-ID: <CAKHBV26knnw7WjUP-6kw1v0T9=196d3cJa5zO1tQa4kjteO-fg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/8] iommu/arm-smmu-v3: Perform invalidations over installed_smmus
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	will@kernel.org, nicolinc@nvidia.com, tina.zhang@intel.com, 
	jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 7:58=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> > Since there's now a loop over a series of SMMUs inside
> > arm_smmu_tlb_inv_range_asid, it makes sense to move the check into
> > that loop. This technically works because only SVA is calling
> > arm_smmu_tlb_inv_range_asid but can (IMO) risk introducing bugs in
> > the future since it's not obvious from the function name.
>
> Well, I would remove the duplication and add an argument if you intend
> to share the function that loops

What do you think about this as a final stage:
Once the set_dev_pasid and sva refactor lands, SVA could call a common
arm_smmu_inv_range_domain implementation which would:
1. Skip the TLB invalidation on a per-smmu basis if it detects that
the domain type is SVA, or based on a passed-in parameter that is only
set True by SVA.
2. Issue ATC invalidations with SSIDs found in the arm_smmu_domain.
This common function would be used for all use-cases: invalidations of
domains attached on RIDs, on PASIDs (SVA and non SVA).

Then we have two options for the intermediate stage with this series:
1. Non-SVA code uses arm_smmu_inv_range_domain which calls
arm_smmu_tlb_inv_range_domain(_no_atc) and arm_smmu_atc_range_domain,
SVA code individually calls those two functions.
arm_smmu_tlb_inv_range_domain(_no_atc) accepts a parameter to skip the
invalidation if BTM feature is set.
2. Same as option 1, but SVA also calls arm_smmu_inv_range_domain.
arm_smmu_inv_range_domain accepts both a parameter to skip TLB inv
when BTM is set, as well as an SSID for the atc invalidation. SSID
would be 0 in non-sva callers, and mm->pasid for SVA.
