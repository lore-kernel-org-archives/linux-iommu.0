Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62232146011
	for <iommu@lists.linux.dev>; Mon, 22 Apr 2024 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790154; cv=none; b=qyJvP2SN+HqmIe2Ev4Zk1G5ZgFxwHFLCi/Cv+UiOZ+uWqb8uPXrtwsn3ObNdhB3Lz69xBHQ9ULzV3JfPl3mLGKP3wnhE87xAxN0wzWG/MuO8IiC/8x0fT98uY9hoIc64q5Co1H6VsfLcm1bFeafGsJTu2J9DGIuKA9YNKA2FNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790154; c=relaxed/simple;
	bh=A7WbSxvRhkRaygMuG/XdCIzMmoA1hU8yZHwu37RxCko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kx/U0FaC6sScFWcKzjRUGE6BVR1hGvdhDHwBGyIk0U73s5HLUP9IXEiQo9668N6D5lZ81WFq5bd/xbhPyovUSSvOzK+lAWfHRg68sMkE4sbyyFJ5VbQdQcHMcKakHlnObhSx695wURMkh73/IjDj+oFeVIzzha6hXGwEomgxaJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61ae4743d36so46733707b3.2
        for <iommu@lists.linux.dev>; Mon, 22 Apr 2024 05:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713790149; x=1714394949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqjHhkhZhu016WB+ENEXmAF3a/WNz/OKE8i9tnmvyu0=;
        b=UtI4+3/cxpfV/UcU1s144JbZmvwVs0By8U4gtpoJ2wFHV0DgJesXMcNTyFqjYtpa7r
         ByiN8FDpefWdKWW7MtAEOdWy+qHOZA9kt3AT1at/tN5xWKtpKDpDinNRImdH/7stOg7/
         dY+X60dAl4k/y5kvBQ4jw349nbu3qj9vuCf/M8A3Oyf1plgO+LipIXuimSSL7KZLC9sp
         IQQBPom81b3/D4FylhAEaYyV9vO00YyqT9WeEDWyOvErYErHiuBLAmxw1ZnBK+Us27DB
         tfOzc2kzDUJrrZ0wR1GZt3h1Thac3VwYUyfu62aNf08G+xunojFFgfpg2P/w9ttwsoXT
         ZvPg==
X-Forwarded-Encrypted: i=1; AJvYcCW9NXqFtZs7+jlx9mKwvxS4Rm+3ECM+A8q/YjNnK9Pzq6NO8A2wEpGsqsxZhB0L9t4KdJlkydeal4zeFIkPV0uny0bk83U=
X-Gm-Message-State: AOJu0YzSOhVDrKngYyNfzQ6mYcYOK2njpc16voecE7aMh+7A6FDKCzCc
	34jB3rAeVxX/imuyuh+DbUEcJ3QQAVZeyuC1iPOSJgRc/RBWHpWBo6RIyy7c
X-Google-Smtp-Source: AGHT+IHgagbBEPwy8R3sfrzsjk5h4kyxy2elzITL0wzci8pbP7lDIzh2rQpMuCEqTXN+krFhOEbr2A==
X-Received: by 2002:a05:690c:7306:b0:618:875e:2bc1 with SMTP id jp6-20020a05690c730600b00618875e2bc1mr10059118ywb.21.1713790149231;
        Mon, 22 Apr 2024 05:49:09 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id n9-20020a81af09000000b0061abdf061ccsm1957951ywh.133.2024.04.22.05.49.08
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 05:49:08 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso4240933276.2
        for <iommu@lists.linux.dev>; Mon, 22 Apr 2024 05:49:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6RyfKt+zYLVwhv4kUWM1eh89zqi0gIzo6R33ZvBuWufsPNkOH7N0jXzj3A1p2p9mPVwgDOd7cabl/P3RdYodMwcBOtVI=
X-Received: by 2002:a25:86c7:0:b0:de0:d45f:7c5 with SMTP id
 y7-20020a2586c7000000b00de0d45f07c5mr8238629ybm.20.1713790147656; Mon, 22 Apr
 2024 05:49:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <16-v6-a196d26f289e+11787-iommufd_jgg@nvidia.com>
 <6860aa59-3a8b-74ca-3c33-2f3ec936075@linux-m68k.org> <20240422115435.GB45353@nvidia.com>
In-Reply-To: <20240422115435.GB45353@nvidia.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Apr 2024 14:48:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXqH1rGWz9d-t=XpWCF5jqDNhao4mJBPaUhBS8Ab_OirA@mail.gmail.com>
Message-ID: <CAMuHMdXqH1rGWz9d-t=XpWCF5jqDNhao4mJBPaUhBS8Ab_OirA@mail.gmail.com>
Subject: Re: [PATCH v6 16/19] iommufd: Add kernel support for testing iommufd
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Anthony Krowiak <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Daniel Jordan <daniel.m.jordan@oracle.com>, 
	David Gibson <david@gibson.dropbear.id.au>, Eric Auger <eric.auger@redhat.com>, 
	Eric Farman <farman@linux.ibm.com>, iommu@lists.linux.dev, 
	Jason Wang <jasowang@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Jason Herne <jjherne@linux.ibm.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Yi Liu <yi.l.liu@intel.com>, 
	Yu He <yu.he@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Mon, Apr 22, 2024 at 1:54=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
> On Mon, Apr 22, 2024 at 09:27:18AM +0200, Geert Uytterhoeven wrote:
> > > +if IOMMUFD
> > > +config IOMMUFD_TEST
> > > +   bool "IOMMU Userspace API Test support"
> > > +   depends on DEBUG_KERNEL
> > > +   depends on FAULT_INJECTION
> > > +   depends on RUNTIME_TESTING_MENU
> > > +   default n
> > > +   help
> > > +     This is dangerous, do not enable unless running
> > > +     tools/testing/selftests/iommu
> > > +endif
> >
> > How dangerous is this?
> > I.e. is it now unsafe to run an allyesconfig or allmodconfig kernel?
>
> Depends what you mean by unsafe? This is less unsafe than /dev/mem,
> for instance.. It does nothing unless poked by userspace.

OK, so the test itself does not cause a crash, or data corruption?

> > Probably this symbol should be tristate?
>
> It is not a seperate module.

Perhaps it should be? ;-)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
