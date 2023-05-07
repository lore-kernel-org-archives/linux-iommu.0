Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184FA3239
	for <iommu@lists.linux.dev>; Sun,  7 May 2023 18:52:39 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-965a68abfd4so708433466b.2
        for <iommu@lists.linux.dev>; Sun, 07 May 2023 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683485558; x=1686077558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsECona4C2RMdk3QW+3sdWBFtOEdxVYIeVifcSTdEsg=;
        b=EZTfzpc90ra/8sGz05lyuRTbj6Ft5a3wEPBKVZ9wyrLyIM5xiAyrkgs2S1Vs6kl7jz
         sBofRyWiXqcalrjhYAjwqPLUcPsHf20iblx++0yj7HCaICajroi8H5VKd9aP8zyoxn2d
         /hiMNk0SXEL8jHAJJEs+m+yQtUulaqVDWvfW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683485558; x=1686077558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsECona4C2RMdk3QW+3sdWBFtOEdxVYIeVifcSTdEsg=;
        b=Gh7y1NnYcpx0ssrgK+V2gxSQSwHEb6VlHVyfHTyfjH+Q/AJbACeyqdhG98W6BN70W0
         GbTgX8tqcmrRKiKBU61l6XJiVYjvJNQPnJRsYZoKmMzVRot8N2SOycUqUvJuGSQA+aYX
         OvfO3z03fUjnkzagM90iQWjExg1+e29aYlnJRN/HUJ9oXmCWZayZcPFQq+XqjyiJk6cF
         zp0vlzrZTQXZ1rHj7fJLgWigTQ75cCxTwSQco5rvPfof186qfmk/PvIA3++QyfX7aEbq
         EEM+sGY3NrKAhDnkqjBaKt4Bv8iOPdSt4iNShkt7adYbg6u4u/msyt8RWStzcyAQhxFl
         N8LQ==
X-Gm-Message-State: AC+VfDw/i387TkMt2PtQNuA5pvhLslLaJTucTjT2uFRL22cHEW7U8sPg
	sabfOy0dw05qLrTdLUkV2h/9nQuh1wZGJDV/aUrtNQ==
X-Google-Smtp-Source: ACHHUZ7XqXgl7X0u4L+Mc/N5OmtkrCjmDNnC8WW/9hplOU4C4sfnis8CoGaZsNbjymjdvWaoyIBP+w==
X-Received: by 2002:a17:907:7b9b:b0:957:db05:a35d with SMTP id ne27-20020a1709077b9b00b00957db05a35dmr8681202ejc.48.1683485557979;
        Sun, 07 May 2023 11:52:37 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id ci17-20020a170907267100b00965cfc209d5sm3953189ejc.8.2023.05.07.11.52.35
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 11:52:36 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-956ff2399b1so706740466b.3
        for <iommu@lists.linux.dev>; Sun, 07 May 2023 11:52:35 -0700 (PDT)
X-Received: by 2002:a17:907:7da7:b0:94f:764e:e311 with SMTP id
 oz39-20020a1709077da700b0094f764ee311mr6746310ejc.16.1683485555608; Sun, 07
 May 2023 11:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
 <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com> <20230506150741.2e3d2dcc@jacob-builder>
In-Reply-To: <20230506150741.2e3d2dcc@jacob-builder>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 May 2023 11:52:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmOAQnqJF-pW=fzMXb_Rk_J_Oi4ESBLmVPhxwBK4xfGg@mail.gmail.com>
Message-ID: <CAHk-=wjmOAQnqJF-pW=fzMXb_Rk_J_Oi4ESBLmVPhxwBK4xfGg@mail.gmail.com>
Subject: Re: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker <jean-philippe@linaro.com>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Raj Ashok <ashok.raj@intel.com>, 
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, 
	"Yu, Fenghua" <fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 6, 2023 at 3:03=E2=80=AFPM Jacob Pan <jacob.jun.pan@linux.intel=
.com> wrote:
>
> Right, how about IOMMU_SHARING_CPU_PGTABLE?

I think from a VM / process angle, I'd actually prefer calling the
"pasid" part just that: IOMMU_PASID.

The VM code certainly understands about address space IDs, even if
people have called them different things: normal people called them
ASID's long ago, then Intel at some pointed decided that "PCID" made
sense as a name (narrator: "no it didn't"), and then you got that
combined "PASID" thing.

Now, it may be that this then goes hand-in-hand with other IOMMU code
that isn't *about* PASID itself, but that depends on PASID's being
present, and so I'd just expect IOMMU_PASID to be one of those options
that are selected by other options.

So maybe there is some part of IOMMU_SVA that is not about PASID
itself, but I really think that the PASID code itself should just have
that CONFIG_PASID around it.

End result: from a legibility standpoint, I think it could be as
simple as having that

    config IOMMU_SVA

option have a "select IOMMU_PASID".

Then make the VM/process PASID code depend on that. Maybe the "struct
device *" stuff makes more sense under CONFIG_IOMMU_SVA, ie things
like iopf_queue_add_device() and friends.

How does that sound? Maybe those two options then always end up going
together, but even if that is the case, I think from a VM/process
standpoint it makes a lot more sense to simply have a "PASID enabled"
option. It's much more understandable in that context, while something
like "IOMMU_SVA" really is just a random jumble of letters to a VM
person.

And while the individual words in IOMMU_SHARING_CPU_PGTABLE all make
sense, it's not clear what the combination means, and why it should
have anything to do with then having an address space identifier for
it.

                  Linus
