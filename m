Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BE17499
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 08:03:27 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-403b622101bso189591cf.1
        for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 01:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689321806; x=1691913806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12v+SPtROiuj28H9N1MOzT6JNCiTmCYWUdjB7HIYh9U=;
        b=iDmMZDSqf3iIVvRyT48YiFdmq+VtvdVcdpZrTUHa8AuNtkQDzhSgtzn80pyJOeSdSn
         WthTd0bac9iDmnhxto3e/SJh08OOfhdyqS4S4LAinwn0JhKL8ANCv2EAo7c3y8auT+w1
         Ba28IpqEcKlincwLS/D9tL4sYCR474IumKQBGexhNlQHOw9B8ruCDvFkk7LxP4oUJ0MY
         /DEWJVUg4hRVGRhgbKVRQAXRG+LsQ3EZatz7NR44xbydr0RwXY6D2p/NBirMlaugADB7
         +0eGokxsKNQcA2MxyZdUIdnM+RBST+ojJqHhP4a6loAhuN2oVY7wZGsQJcJDKE8kiYrl
         F5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689321806; x=1691913806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12v+SPtROiuj28H9N1MOzT6JNCiTmCYWUdjB7HIYh9U=;
        b=W4khsfN3hdjIum/aAa9hzkQKgeqR9Kjp9os4nihEAkjmxzAZau60VPOkxSXzon1W3J
         nMd/FlXqE3Q/yYLdxmXcv04THZWAlxa+dHw4xy0WXDaa0oa/f14HluMy74Hho8MdNKsO
         Asw3gITADXc/AEi7zr+ttRI1f0CEMBfIdXDR+ySmMZmRgoSOsJDMuUdQw5u3e0qB+ZZJ
         1UZJM8FwcnUvykD4Wce+Q7y3BL713NaQswZew+3YR80p9oi2YGvGOTbB1AtV/qtToRA0
         6MJbEg56VghtWCalVlcYIqybyjHT2eGH3+kw9eqPaNAe8a2hM8RcLvL7bKpZlwRCILxX
         3uVQ==
X-Gm-Message-State: ABy/qLbjT+SbQIsWcnPJcTgxHj4jz+wGfqSGs0hYtAJn7j3MT4I+gqF8
	NQg+wbIHgtAlpEBbDGD3w1A1ajn+oYw9kskxQ0rL8A==
X-Google-Smtp-Source: APBJJlGKNpfvbfdCqxqjT1YvdZfgE5A04mkwsR12CMTw8mOVWHG7g74SOPl9dWaNq9JuLTwk3VVOv7ZuNeEPP+nMHEE=
X-Received: by 2002:ac8:5905:0:b0:3ef:302c:319e with SMTP id
 5-20020ac85905000000b003ef302c319emr754044qty.8.1689321806537; Fri, 14 Jul
 2023 01:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia> <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com> <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com>
In-Reply-To: <ZLApQjaqoOshT2TJ@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 14 Jul 2023 16:02:50 +0800
Message-ID: <CAKHBV25BRWTxXO0YTGq3q1OdMQHAzop8BqJJaa9CHxdQzxnNbg@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 12:41=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
> The master object owns an optional CD table. If it is exsists it is
> used by every domain that is attached to that master.
>
> In the code flow there are two entry points to attach a domain, attach
> to a PASID or attach to a RID.
>
> For attach to PASID the code should always force the master to have a
> CD table and then attach the domain to the CD table.
>
> For attach to RID the code should do a bunch of checks and decide if
> it should force the master to have a CD table and attach the domain to
> that, or directly attach the domain to the STE.

 Yes. This is the current flow (except that we fail instead of forcing
when a CD table isn't already attached in the PASID flow).
owned_s1_cfg is simply a pre-allocated version of your optional CD
table.

> When the master gains a CD table then the CD table object becomes
> attached to the STE. In all cases we should be able to point to the
> object the STE points at and don't need a cfg or pointer to cfg since
> the object itself can provide the cfg.

Ok, practically speaking, are we just talking about reverting patch 3
and keeping a handle to the primary domain in arm_smmu_master? Instead
of directly accessing the currently active CD table using
arm_smmu_master->s1_cfg, you'd like set_dev_pasid() to look for it by
investigating what kind of domain is attached, and reaching to the
pre-alllocated/optional CD table otherwise if necessary?

> > We want to write something (page-table pointer) to a common CD
> > table. Where should the s1_cfg which owns that common table live?
>
> I would suggest a 'cd table struct' that as all the stuff related to
> the CD table, including an API to cacluate the STE this CD table
> requires. If not in actual code with a real struct, then in a logical
> sense in that a chunk of the master struct is the "CD table".

Sure, that's almost exactly what s1_cfg is today (with these patches)....
  * s1_cfg.arm_smmu_ctx_desc_cfg describes the CD table
  * s1_cfg.s1fmt and s1_cfg.s1cdmax describes attributes of that CD
table. These could technically be deduced-back from
arm_smmu_ctx_desc_cfg's l1_desc and num_l1_ents
  * s1_cfg.stall_enabled was introduced by patch 4 and in retrospect
does not belong there at all. It should have gone in arm_smmu_ctx_desc
instead (ignoring the whole should arm_smmu_ctx_desc even be
precomputed in the first place topic for a second).
