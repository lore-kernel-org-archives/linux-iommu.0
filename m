Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8B125CC
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 18:36:44 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-3f98276f89cso31071cf.1
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686076603; x=1688668603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A56IwHY5+byjNKAjh+uwXHK8afHF+U37XZljvsbVqKs=;
        b=LD+ckuYjLtWV1YRQOg3PLufZlPloFGyMumfiFUHPb4PBL1WCTqVPAQMQ+xscCKGRWG
         jvhqH0VitY0Hw5VHu9dgxZoKwmZ8ua2KENbtrMLxUu2H3CcyIukos1btHsetvY1toFnw
         v4L2FSosY5QfRfgdxLSSMU3LWMS+zcASQ2xoXi4EK+kt1Tji1vPehXZ+yJD9FmZhJwJG
         po9U+HA9pve1AhbZs1C0GpsZUILNLZOQTKefnxEQJf6uWS9MxJn4D9EFGT9T2+0vo1n+
         fa1h2u/0OLMS633XRELsU4a8vauYWjLENRT9Fg6HQmpbt2STJsTy6vpKFe8CXamlTnP/
         mUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686076603; x=1688668603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A56IwHY5+byjNKAjh+uwXHK8afHF+U37XZljvsbVqKs=;
        b=KF+yJB+fZTbHkv64KGUnCLdp2mv9C3x96i6jgmIUI7vlEJKWtoshGWqsx5AiCW8tPo
         OCXiBgT6cET/t4gC9F4S4X1GZLNFcsNarpq58rJoC8gMbV1FrjDitiHeNENvvZzpqeRQ
         WVRwETz3q/T0fkufEHNwAjwWvfKRznhKZWTjf79UbmVaVs1cO5R0Z7wHBaxf08jm75Vn
         JZMx/LLFO/GSeofmt+7U4V5fgLwnNGyi62QreunpzWkHO/9VRDrD4pH2AW9gk5/EwBD4
         1o+rhZobT5+XnjY6BwVppfFNX+A+mXk4Z7jDS1XeYYH6CrT+aNTcvnvIGEFmdWLT9eK0
         09kA==
X-Gm-Message-State: AC+VfDxJtxWxNMo+38r51QR4yZC06wVbNPn4TPOAN12RjWm+jJjhvD3u
	nAq19UrT1z912yVrd2EyBJjP/wHV5Aj6neW5c+iMsg==
X-Google-Smtp-Source: ACHHUZ5NDwRXuNiM755ldBiztJFRxN0R1USqy0SysmBtk902kWPW7QxwDPIR+i1U/wbViR3XHPzaCyE576EXCgNdH0k=
X-Received: by 2002:a05:622a:144e:b0:3f4:f0fd:fe7e with SMTP id
 v14-20020a05622a144e00b003f4f0fdfe7emr13637qtx.3.1686076603516; Tue, 06 Jun
 2023 11:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com> <20230606120854.4170244-15-mshavit@google.com>
 <ZH9oQMmI8CezMCnx@nvidia.com>
In-Reply-To: <ZH9oQMmI8CezMCnx@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 7 Jun 2023 00:06:07 +0530
Message-ID: <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared CDs
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 6, 2023 at 10:39=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Jun 06, 2023 at 08:07:50PM +0800, Michael Shavit wrote:
> > SVA may attach a CD to masters that have different upstream SMMU
> > devices. The arm_smmu_domain structure can only be attached to a single
> > upstream SMMU device however.
>
> Isn't that pretty much because we don't support replicating
> invalidations to each of the different SMMU instances?
....
> I would expect different SMMU devices to be handled by allowing single
> domains to be attached to a list of masters where the masters can all
> be from different instances.

Oh you're right! When I first looked at this, arm_smmu_domain still
held an arm_smmu_s1_cfg which depends on the SMMU device. But
attaching a single (stage 1) arm_smmu_domain to multiple SMMUs looks
much more tractable after the first half of this patch series. We can
add a handle to the smmu device in the new arm_smmu_attached_domain
struct for this purpose.

> What we definately shouldn't do is try to have different SVA
> iommu_domain's pointing at the same ASID. That is again making SVA
> special, which we are trying to get away from :)

Fwiw, this change is preserving the status-quo in that regard;
arm-smmu-v3-sva.c is already doing this. But yes, I agree that
resolving the limitation is a better long term solution... and
something I can try to look at further.

> You might try to stop your series here and get the first batch of
> patches done. This latter bit seems to be a seperate topic?

The main motivation for this part of the series is to reduce
inconsistencies with the smmu_domain->attached_domains list and
arm-smmu-v3 functions that rely on that list. Specifically to reach
the last patch in the series: "iommu/arm-smmu-v3-sva: Remove
atc_inv_domain_ssid".

Splitting this part into a follow-up patch series would definitely be
easier and helpful if you're all ok with it :) .
