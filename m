Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057D37472
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 13:39:17 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-40c72caec5cso447331cf.0
        for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692625156; x=1693229956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPjzY4omsOysbo+WaFOemYqJ4xkslRZB8mPYNwUSQ6A=;
        b=w0I4haQ45UNsLNRiNXn71OMBdA6RsRmbCrX3Eo4uMIBz6usK8BIz3jjoqHsU58oYRc
         lur/ned6K0IBLZsvTzELh7g4+Swiy+UWxYrbvfmCicIzkcp1FXq4A19Ss7V0Hih3EzSW
         rkrBSnLJMaGCWH6gMU1KeOgXghoXfJNBu4aGsBbLGgeBoKPKu6xZsITNNluHOWjNQeim
         uLAhIKSNrVkpDM950F8nk2R93L6UjkuVdVPFtyIblupJpRfo8IUAptwe5WjMW20meJe2
         0zKHrHhku5m74GQ1Nwl/WdafDuwRGkW/8BmsulXpT32nZlWJswWz40fus+buJR8Q02cP
         aQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692625156; x=1693229956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPjzY4omsOysbo+WaFOemYqJ4xkslRZB8mPYNwUSQ6A=;
        b=BTyhoTaVnddRFT3RVUBQJtPuSuOTjSCcsgL/AHHvzKvdE9ybDpsYoYmphrNl8zGOhb
         phmwfSMh5mQbBCspZraNzT7RXvVeWb6mTPBLTaucvZ2TdTJ1R61hCXiIizwVojobEtAU
         zFe32iEWHXTrw6Mbcgqw7PcuGlDtn4nO7puJin8yeVB5gy96AnVM+Hq9ZrqKFWAirSbm
         5r4cg/x9h4VRmIGohtUSqT3cHnw/wCvsseI6DxrKNtV1X0QDyCUABG/9e4dLuC9y8cCy
         3JfIxdIeeGbHEXyOzI9BdhDsUxiDXkt5JPdRTJt8pfzmSp9hhkw/DumNjnUfhE0hjM5F
         7NaQ==
X-Gm-Message-State: AOJu0YxCp30AoAvl4BSFfh+T12U1KZLGSBCu+0tlcT2s/Jqp+6BTH5EG
	hrPCBf6pFDRejkwtv4KOnjXHl0lR1sP0DW//dCQaCeECm7EwQkLApAM=
X-Google-Smtp-Source: AGHT+IETYip2DW6kZitAYkXOvPOKFFGmGfQS6VsuXvAMuzQdOcSsCUd4w3zy3HaeYzjV4q49oU7NBYYBlP61f1REQBY=
X-Received: by 2002:ac8:5984:0:b0:410:88a5:92f with SMTP id
 e4-20020ac85984000000b0041088a5092fmr395349qte.0.1692625156476; Mon, 21 Aug
 2023 06:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.3.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
 <ZN5pK03Drao/egeF@nvidia.com> <CAKHBV27k8F0ZLy=RA=WhjJ7+C9JMHRRnKs=4W4pJMNmxrMEXxw@mail.gmail.com>
 <ZONQgNh6qarqgA+f@nvidia.com>
In-Reply-To: <ZONQgNh6qarqgA+f@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Mon, 21 Aug 2023 21:38:40 +0800
Message-ID: <CAKHBV26oTZLssq5bopePojqgrEJwukKHYEbhU02nAvHHVB13mw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/8] iommu/arm-smmu-v3-sva: Allocate new ASID from installed_smmus
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, nicolinc@nvidia.com, 
	tina.zhang@intel.com, jean-philippe@linaro.org, robin.murphy@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 7:54=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, Aug 21, 2023 at 05:31:23PM +0800, Michael Shavit wrote:
> > On Fri, Aug 18, 2023 at 2:38=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com=
> wrote:
> > >
> > > On Fri, Aug 18, 2023 at 02:16:25AM +0800, Michael Shavit wrote:
> > > > Pick an ASID that is within the supported range of all SMMUs that t=
he
> > > > domain is installed to.
> > > >
> > > > Signed-off-by: Michael Shavit <mshavit@google.com>
> > > > ---
> > >
> > > This seems like a pretty niche scenario, maybe we should just keep a
> > > global for the max ASID?
> > >
> > > Otherwise we need a code to change the ASID, even for non-SVA domains=
,
> > > when the domain is installed in different devices if the current ASID
> > > is over the instance max..
> >
> > This RFC took the other easy way out for this problem by rejecting
> > attaching a domain if its currently assigned ASID/VMID
> > is out of range when attaching to a new SMMU. But I'm not sure
> > which of the two options is the right trade-off.
> > Especially if we move VMID to a global allocator (which I plan to add
> > for v2), setting a global maximum for VMID of 256 sounds small.
>
> IMHO the simplest and best thing is to make both vmid and asid as
> local allocators. Then alot of these problems disappear

Well that does sound like the most flexible, but IMO quite a lot more
complicated.

I'll post a v2 RFC that removes the `iommu/arm-smmu-v3: Add list of
installed_smmus` patch and uses a flat master list in smmu_domain as
suggested by Robin, for comparison with the v1. But at a glance using a
local allocator would require:
1. Keeping that patch so we can track the asid/vmid for a domain on a
per smmu instance
2. Keeping a map in the smmu struct so that arm_smmu_share_asid can
find any arm_smmu_installed_smmu that need to have their asid updated
(on a loop over every smmu the domain in arm_smmu_mmu_notifier_get is
attached to, which just at a glance looks headache inducing because of
sva's piggybacking on the rid domain.)
