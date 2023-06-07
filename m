Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460203B3E0
	for <iommu@lists.linux.dev>; Wed,  7 Jun 2023 23:04:31 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so7290093a12.2
        for <iommu@lists.linux.dev>; Wed, 07 Jun 2023 16:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686179070; x=1688771070;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEQmXBu5dD2JANi2wiTQk+OaHV1+Cn5N+E2Jx9Z9qA4=;
        b=RylNv+3BIY+SkOFVAD23uBHZj3gl+6CGLSkAPg+jewP+TXl+yMgPLX6SW4utvQFk5H
         EH7z/qzntgcgtmMbuBotoKMWdu1zz6kl61hyvmvMZemO0yBPxR5qJxn+hlm5VEyDdIwX
         ASrRHvjOICNXkznM1ujPM6yNPppmEjhbN5H/OcrhR9xY+BAYQUVBWXyfAd28VEcEAGRJ
         W6uwAK3z8RHShgB+B3TR+0qli2YJ9J5nN2uHEiUIy7UAHQcBknMD0d05qMnd5aL4gqcd
         LdwMS7BKs1bMUBiJQvpGkweej2mWnwYJKjDUZ1rkkTAvpN2mrpqTEaFdTLdsRAZvO1eR
         yk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686179070; x=1688771070;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEQmXBu5dD2JANi2wiTQk+OaHV1+Cn5N+E2Jx9Z9qA4=;
        b=Q0LXMhFiRPVFribE0i9pHx5JI4WXZVLUdnVyYHBqPvqlu8wis4NY68VGrmpVlWGH4G
         twKUGXXWX7soqQtTNY82cmBySpLq+Z5RtIIhsNcdonIKCr9Gb+1lEVNyq68T+WYj1x7e
         ++XwAUILdUasdLvZILD9++crmPeMk1ENYg1PPZQmquHWJALACW2pmNjGvKYPeEps2v4m
         q+fRNiv07xlk5hwGU/ut6SnmgBOF149QwtcAjuOrcT6HK31GlbyFt4AKq3x2eSMSK5PS
         6Gd4yLC+2wjCW+a0VeMnBsbK0n83/LuL5iI/5htYa9NU+DTlEJFYbivQWKbo/OEXUpBq
         mYsA==
X-Gm-Message-State: AC+VfDyJTmGiLaDUW6K5DlHoG7h8XEeNwTV+7XM3lcWvJeSONjKu9v/3
	ryMzXtvoirbfp6FXV6YheWpsbQ769ggmdoytAWM=
X-Google-Smtp-Source: ACHHUZ72aumlNuKAoBEIFQvO8H4ETvfhLNixmshgtGFlUP5g7IApmZyyIjopu2EXDuiSlejJtibjp5Y+wkJnk1Q5LAs=
X-Received: by 2002:a17:90b:4a08:b0:256:4217:b955 with SMTP id
 kk8-20020a17090b4a0800b002564217b955mr5585682pjb.35.1686179070356; Wed, 07
 Jun 2023 16:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
In-Reply-To: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 7 Jun 2023 16:03:54 -0700
Message-ID: <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
Subject: Re: Question about reserved_regions w/ Intel IOMMU
To: LKML <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 7, 2023 at 3:40=E2=80=AFPM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> I am running into a DMA issue that appears to be a conflict between
> ACS and IOMMU. As per the documentation I can find, the IOMMU is
> supposed to create reserved regions for MSI and the memory window
> behind the root port. However looking at reserved_regions I am not
> seeing that. I only see the reservation for the MSI.
>
> So for example with an enabled NIC and iommu enabled w/o passthru I am se=
eing:
> # cat /sys/bus/pci/devices/0000\:83\:00.0/iommu_group/reserved_regions
> 0x00000000fee00000 0x00000000feefffff msi
>
> Shouldn't there also be a memory window for the region behind the root
> port to prevent any possible peer-to-peer access?

Since the iommu portion of the email bounced I figured I would fix
that and provide some additional info.

I added some instrumentation to the kernel to dump the resources found
in iova_reserve_pci_windows. From what I can tell it is finding the
correct resources for the Memory and Prefetchable regions behind the
root port. It seems to be calling reserve_iova which is successfully
allocating an iova to reserve the region.

However still no luck on why it isn't showing up in reserved_regions.
