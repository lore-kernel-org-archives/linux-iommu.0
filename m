Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2760944B
	for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 10:11:29 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-407db3e9669so195531cf.1
        for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 03:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692699088; x=1693303888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0aet74oNs6B6aZP3zHJL6DaqiBdyTa5krwOSRs1jkQ=;
        b=4GJe1s1p0dY/EO/sMeo5l6OKEUn71iv5GbmtHxGECQ8G/c5zDLKlIlFi40ib7LoXvl
         ZFR4TSzXPfpheajQlUMeeaRE7HUxb+7jE8aCWVdMm7+gIZkc+tXKxQ2Za//LU1HNKZqq
         zi4X5jb+krb4KS+LQuOZn/ZvIK7VFr+0LIn2q7mLtOvEITBMAr+hY4pTFQw0ZeQQYVSr
         yCvJgzRSso1wAYkD4kbxBEjra8JXQqwsU4Pec676km9oVHP9aQ2sVBJBekokcTxAfIie
         2H4lY7r75W8dFGfDUOVaQgWoT62bRsRPRkHYDJupZfcGMzkdnNUcoQPTZvR+f81GdhXA
         YB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692699088; x=1693303888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0aet74oNs6B6aZP3zHJL6DaqiBdyTa5krwOSRs1jkQ=;
        b=huxVOOMufCc5U+SYtOwkbBxhL5hyIOlP1PHE5eR2IX0oQdwDP3PI42oa0Bcd1Xyf8I
         fdIMnadsjhQrX9tQpknA77Vkx8xh55pHJ9JRDI3Ty5ZI7898MnQMBxhz5RFFifpTpMJ3
         4l986z8xwmPw4zoaRG3jQV34g6UXXjZXGl5S+DoNDNDALoocnj52UvLTmZ8wzBALwFAl
         QvejKhrFyN4wqObO5EC04FEjZ+voJFjS+F3PNaWQk6G9EJZZhDk/8/GOmiMieLOIF3/d
         0QR+S2gsW1BZbkmFbZ9okjp2Dwsn78eMMYowKJalcUoxjzhk7TYavnHpJ0Xxh5NkkLZv
         s/wQ==
X-Gm-Message-State: AOJu0YyYDe2Q3Dogb5AdVG2o6MAoK25Au1LEBXOV/RzsVJIiOEOUFC4f
	KgixiRefP4KzeC1e4dzJGvsOLbGBUnpaQF8ovC17Rg==
X-Google-Smtp-Source: AGHT+IGcQQaJL1MF5GoPI5g2wwpYi0Dn/HGeGyVPl//rTVuMcMIa6CvOGMmzWZOZ+vKc0dtbZaAdUydM/3jqynFQ+Gc=
X-Received: by 2002:ac8:7f4c:0:b0:40d:eb06:d3cc with SMTP id
 g12-20020ac87f4c000000b0040deb06d3ccmr179947qtk.7.1692699088079; Tue, 22 Aug
 2023 03:11:28 -0700 (PDT)
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
 <ZONRRubvUK7GXO4i@nvidia.com> <CAKHBV26knnw7WjUP-6kw1v0T9=196d3cJa5zO1tQa4kjteO-fg@mail.gmail.com>
In-Reply-To: <CAKHBV26knnw7WjUP-6kw1v0T9=196d3cJa5zO1tQa4kjteO-fg@mail.gmail.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 22 Aug 2023 18:10:51 +0800
Message-ID: <CAKHBV25n4pbcNXaxeG3KMN=cM3LUK4_+JK8C5WmN8fYSyNrA1Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/8] iommu/arm-smmu-v3: Perform invalidations over installed_smmus
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	will@kernel.org, nicolinc@nvidia.com, tina.zhang@intel.com, 
	jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 4:17=E2=80=AFPM Michael Shavit <mshavit@google.com>=
 wrote:
>
> On Mon, Aug 21, 2023 at 7:58=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> =
wrote:
> >
> > > Since there's now a loop over a series of SMMUs inside
> > > arm_smmu_tlb_inv_range_asid, it makes sense to move the check into
> > > that loop. This technically works because only SVA is calling
> > > arm_smmu_tlb_inv_range_asid but can (IMO) risk introducing bugs in
> > > the future since it's not obvious from the function name.
> >
> > Well, I would remove the duplication and add an argument if you intend
> > to share the function that loops
>
> What do you think about this as a final stage:
> Once the set_dev_pasid and sva refactor lands, SVA could call a common
> arm_smmu_inv_range_domain implementation which would:
> 1. Skip the TLB invalidation on a per-smmu basis if it detects that
> the domain type is SVA, or based on a passed-in parameter that is only
> set True by SVA.
> 2. Issue ATC invalidations with SSIDs found in the arm_smmu_domain.
> This common function would be used for all use-cases: invalidations of
> domains attached on RIDs, on PASIDs (SVA and non SVA).
>
> Then we have two options for the intermediate stage with this series:
> 1. Non-SVA code uses arm_smmu_inv_range_domain which calls
> arm_smmu_tlb_inv_range_domain(_no_atc) and arm_smmu_atc_range_domain,
> SVA code individually calls those two functions.
> arm_smmu_tlb_inv_range_domain(_no_atc) accepts a parameter to skip the
> invalidation if BTM feature is set.
> 2. Same as option 1, but SVA also calls arm_smmu_inv_range_domain.
> arm_smmu_inv_range_domain accepts both a parameter to skip TLB inv
> when BTM is set, as well as an SSID for the atc invalidation. SSID
> would be 0 in non-sva callers, and mm->pasid for SVA.

Ugh, ok, there's a reason arm_smmu_tlb_inv_range_asid duplicates
arm_smmu_tlb_inv_range_domain!
The invalidation isn't performed with the smmu_domain's ASID... but
with the CD's ASID (because the domain is the RID domain.... again).

I think we better leave this out of scope for this series as well.
Let's keep the redundancy for now, and add a parameter to make things
explicit. We can clean things up when the above is fixed.
