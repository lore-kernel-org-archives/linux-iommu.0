Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02B25150
	for <iommu@lists.linux.dev>; Thu,  3 Aug 2023 16:32:45 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-40a47e8e38dso299861cf.1
        for <iommu@lists.linux.dev>; Thu, 03 Aug 2023 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691080365; x=1691685165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14b7Rs9Wd8rjA7nDFTSpP6ZFmJxIiJvGTB/lP995Sd8=;
        b=HwprDZDqMPrL7Zj654wYgowyjPBT5Je+693PMPHj+04LTiEevklzjorIkYL1sGAIZ5
         YU3tNKDGyDj2VPd8GqIMGVzK/DZrx9rxl69XF+FxnJ9ps1Fvni7mZUp5GI4/pyrbRfPb
         muZo4nrqyOUZ6Qd0MPcKToJ+mT7D71OMoS61TiRWzVHT7IdKdaBEpSdL/a+iuvefhpIO
         MgDmRRrfFCHNZx6FSLdq6XC5GpeYHoJHucn7TZjrgm/ZKiCJcBrbbgaf67aYmfZKazPg
         wKI0wX12z8j5b9WOdQjutTB55iU/3yo8MG2n6cdOrDdgvncFyyEaiQ1W/guYydVtAWiA
         kIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691080365; x=1691685165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14b7Rs9Wd8rjA7nDFTSpP6ZFmJxIiJvGTB/lP995Sd8=;
        b=M0gGP/fhQyOkXS+OxG6q/bI2qPP/cubwnVoDUyhkarebqfO0mWyG5x/0zoNt+TGwY0
         9UI8fjAW6Ei4TwmftW1m2xdZXBu3YD6IB2YEcvirHfBSP1aILxAz16gOWn4bEmVUSfiB
         BhFcarQEmT0Y7R3pdmoBqdP29JRsDucQ2cdP82X8xVul3VzFijC925hx2J5N8iOjiVHa
         HWa52z1emy+SUF3cH/4/YZhwdDib/cTMjcgnwk8R5ElU+4tCdrFowx121EGu074SgvWL
         TvI6AE3ILAxIVYWEgcOMk/FZBQ938UcGkq8OiAKSo2RuKQzqVnw+W4iCpaLhk6XEqPoK
         X+uQ==
X-Gm-Message-State: ABy/qLYbSHCAoDLcI8w4JJUzEQkIm3yXWBzNmgNrY7SW+PSiEddlAWry
	rVot6n0kp2XfCJsu93do5i1aESp+t9abiXCaY3q0nw==
X-Google-Smtp-Source: APBJJlHlLJg4KvOewFU7IA5p+IkO63/clWuytJZE4rymDY1Rle14ashYNxENtNsonVB2915jj7wiHiP56PCPsPnXllE=
X-Received: by 2002:ac8:7f12:0:b0:40f:ec54:973 with SMTP id
 f18-20020ac87f12000000b0040fec540973mr185916qtk.22.1691080364836; Thu, 03 Aug
 2023 09:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230803101351.1561031-1-mshavit@google.com> <20230803181225.v5.2.I8db07b9eaef3bd5ef9bfc5c8c6d44768a4d95293@changeid>
 <ZMvKzwx2IhgXO+F8@nvidia.com>
In-Reply-To: <ZMvKzwx2IhgXO+F8@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 4 Aug 2023 00:32:08 +0800
Message-ID: <CAKHBV27q-KdcoKZu7TeFdRWGvKkU7C13yOdxRNZ5cGEEbPumCw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] iommu/arm-smmu-v3: Keep track of attached ssids
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com, will@kernel.org, 
	jean-philippe@linaro.org, robin.murphy@arm.com, nicolinc@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 3, 2023 at 11:42=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Aug 03, 2023 at 06:12:22PM +0800, Michael Shavit wrote:
> > The arm-smmu-v3 driver keeps track of all masters that a domain is
> > attached to so that it can re-write their STEs when the domain's ASID i=
s
> > upated by SVA.
>
> Wah?
>
> A domain's ASID shouldn't change, why does it change for SVA? Doesn't
> SVA use CDTE's only? Why would it ever change a STE? I'm confused what
> you are trying to explain here.

Urh right, I mixed up CD entry and STE here. Before this patch, SVA
keeps tracks of all the masters attached to a CD domain, and updates
the CD entry 0 in their CD table. Now that a CD domain can be attached
on non-zero SSIDs, SVA can't simply update slot 0 in the table; it
must know which slot(s) this domain is attached to.

>
> What is a "primary domain"? Why can't we fix SVA first so it doesn't
> have this weird "piggybacks" or:
>
...
>
> This patch is not making sense to me, the goal in the commit message
> seems logical, but why is tracking CD entries introducing this concept
> of a primary domain and doing special stuff for SSID=3D0?

I'd argue this patch isn't introducing anything the driver isn't
already doing. It's just making the status-quo explicit since it has
to handle it. I do have a patch series in the works to properly fix
SVA, but it's growing quite large and I was trying to get this feature
out first. At a high level, the subsequent series:
1. Nests the list of attached masters in a list of SMMUs the domain is
installed in. Updates SMMU-level operations (such as invalidations) to
iterate over said list.
2. Checks the compatibility of a domain when attaching to a new SMMU
instead of outright rejecting, to allow attaching a domain to multiple
SMMUs.
3. Thus allowing SVA to alloc a single domain for the MM struct (which
the series maps from multiple SVA domains internally, pending support
at the iommu core layer)
4. And allowing SVA to use the same set_dev_pasid implementation used
here on that domain.

Now having said that, it might be possible to get rid of piggybacking
sooner if we create an MM per master instead of per "primary-domain",
but I'm not too sure about performance implications. AFAICT, the only
downside might be for invalidate_range commands that could no longer
be sent as a batched command to the SMMU (since each mmu notifier
would be called independently).
