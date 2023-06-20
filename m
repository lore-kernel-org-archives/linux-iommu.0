Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF62AB3A
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 17:47:48 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-bd61dd9a346so5038793276.2
        for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687283267; x=1689875267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEQQedTfk3CvXMUEMnX/qgx0uD7Zg1KalwFUtarcHWE=;
        b=X/h+sRHNzsC5FcGaSJrO3tW4Rxpa34N3Cmd54bilvTz2qbld2ShNygzXL/zF3Wgqle
         CDVm9DgJt8tLMxVoBvVepefDiFSu1w1y7L5sZ7UfLCLDo1XvLZ6a7dsZdqO7QjzJB5NA
         5ZdUE/wxeA5cSFZML9vW0f1d3UWGXpjBv1RqsbdfK1kXFusynnjw5nYDl+k2UAdQCLUK
         VjRGCApYXDho5KvtigNiBCfsv4Nal8NCc4EkKTJfVlFJ2VnxAN4ZiV9RQpPqa6EgFOFT
         ZNQJtgo5NT/eG67C4qRuPwrIYglj8cobVjHPzMBKhdw/wkm5H83kdSSEq2Ih8Zk3eB1/
         q58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687283267; x=1689875267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEQQedTfk3CvXMUEMnX/qgx0uD7Zg1KalwFUtarcHWE=;
        b=MkvhQAx1it9nxApT5f2rYQbshzv306bTYglUKgVCVXoCn9RZScGsvhYqolRTDyiVK4
         6URXrSAN61e0OIoWUSmbzghBUIM4KfssHqOGpFK/vhkvLH2WK0Vw3BbFBXyV0whiYmie
         hNB9TFYd+8SKKfwVWZJgUFRNJIuwujuUX9CwME3Oh4CDqwAW5ZR8Wy/D31oO3TBL3Buh
         gRH8pBbXoQrPz8nN7tb9RHJBqKOoCk4r2KpYdScAX5cKnmxJhLrjLkX3Mc7hRPIySh2d
         Gw6FNbYmhtylIi7XtvXQLdvJDa99XYSQBF4/DPzv15T8RjkP9Ngg19x69nsxveRhuj9g
         oOCA==
X-Gm-Message-State: AC+VfDx36rLGAZnsvNnG6fuR60TBqBnUvoFr/KDFyXRVw9fU3Pz6nsc6
	GIrhFsWSO/UqdKdtHMSviff6AKnkVkOkUNuGDK0=
X-Google-Smtp-Source: ACHHUZ7HqkDEoGGZvLpAudJce8uaN/hmAuzPQsH1Ct+zekBEVf+h6LTLWNg25zLA1ducjT2NIXe8PkpbzKGJgjsGEmE=
X-Received: by 2002:a81:468b:0:b0:573:98a3:f01a with SMTP id
 t133-20020a81468b000000b0057398a3f01amr951191ywa.40.1687283267004; Tue, 20
 Jun 2023 10:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com> <ZIiRK2Dzl2/9Jqle@ziepe.ca>
 <BN9PR11MB52765C24405D2475CF3CBEBE8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZIxTmGU4a5dniEY3@nvidia.com> <CAKgT0UfmdOOPSD5YvpHnh1A02URn9zxVLbyXJM_67On7xojLcA@mail.gmail.com>
 <520e2be4-726f-c680-c010-a308cdddbae0@arm.com> <ZIyxFpzh3WG+ifws@nvidia.com>
 <90823b33-1f44-8789-9a38-282407fd9f15@arm.com> <ZJBf5DP60prFH5R2@nvidia.com>
 <CAKgT0UccM=_D-gJdzjqeUmRZWnSHVaUABjgQBEamLYauE8WTCA@mail.gmail.com> <ZJHaE2+XOgQj1q2k@nvidia.com>
In-Reply-To: <ZJHaE2+XOgQj1q2k@nvidia.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 20 Jun 2023 10:47:09 -0700
Message-ID: <CAKgT0UdbjDDkwV_uUGCTONGj2Xw_+Tb6J5enAX_+Wq0eKt=nGA@mail.gmail.com>
Subject: Re: Question about reserved_regions w/ Intel IOMMU
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, "Tian, Kevin" <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 9:55=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Jun 20, 2023 at 07:57:57AM -0700, Alexander Duyck wrote:
>
> > I think this may have gone off down a rathole as my original question
> > wasn't anything about adding extra reserved regions. It was about
> > exposing what the IOVA is already reserving so it could be user
> > visible.
>
> Your question points out that dma-iommu.c uses a different set of
> reserved regions than everything else, and its set is closer to
> functionally correct.
>
> IMHO the resolution to what you are talking about is not to add more
> debugging to dma-iommu but to make the set of reserved regions
> consistently correct for everyone, which will make them viewable in
> sysfs.

Okay, that makes sense to me, and I agree. If we had a consistent set
of reserved regions then it would make it easier to understand. If
nothing else my request would be to expose the iova reserved regions
and then most likely the other ones could be deprecated since they
seem to all be consolidated in the IOVA anyway.

Thanks,

- Alex
