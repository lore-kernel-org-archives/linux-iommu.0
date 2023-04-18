Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C48AFC3
	for <iommu@lists.linux.dev>; Tue, 18 Apr 2023 17:36:54 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id u3so23250529ejj.12
        for <iommu@lists.linux.dev>; Tue, 18 Apr 2023 10:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1681839413; x=1684431413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Q8SFl2ULkIvm8UXfuATBUNzL9reEo3S5ggP65kxjqk=;
        b=GSZdVVEt1lfl8sp96Vt7492JQfCpH5jKib5smE+5R34WwS9qBdzCLIY8Hf86Wcmn5W
         WfMPUOxJu+AWYIsuMcPetFseZVPpjeX1SXkVA0ZzWSMgOsOeQfg1ddJqAnEE85lxL3H0
         /o4UUTj+Kd5lL4L+L3K38H+0gp8aZi5cVcZmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681839413; x=1684431413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Q8SFl2ULkIvm8UXfuATBUNzL9reEo3S5ggP65kxjqk=;
        b=AO+6dYuqsy9U/0J7HEX35uJCiW/khjKupzdOdeE4ryVapRDMw2+4llJXrUXCyjb5WL
         BfXVTF5i5zUpHYycPivI+sUAB4RrW2U8uJMixEa+ihZluWC6ZopfpHa6AT3SdGZyzw1H
         ljqlHZR0oudKeQcXzdO8NMMW2W2u84xOMizR+PqfoOF93Nhxx8i/g2OcVGNhIldK3sT6
         J3V/qtDMNqje+bneWSiMizOgq56nrSGAurSQlIAe3mG03/lMwyQRA4sQEeSUFNSYroLZ
         wHqYAirhANjuEa17xwpjuXpXvPCFkfvpWZF4zNPE98eGJILxuDlJM5Ew8BM9O3dO2wgf
         wkSw==
X-Gm-Message-State: AAQBX9eNQIb18El2v6a++CDbjffJOQahO//YhZpegLGk5XLr7vhbjY+5
	h+SI6mbg/u2c/rFKN7/iekYZYvxcB3okVkQTCqsTgQ==
X-Google-Smtp-Source: AKy350YHeSD/ZrEGRCiULJI3tnbRDklesc6XpXAjJyEf0RsJNaHvTXEQy859JaR1aYJXZGmR/Dunlw==
X-Received: by 2002:a17:906:844d:b0:94e:d17f:eacf with SMTP id e13-20020a170906844d00b0094ed17feacfmr12302136ejy.23.1681839412828;
        Tue, 18 Apr 2023 10:36:52 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906328700b0094e1344ddfdsm8196332ejw.34.2023.04.18.10.36.51
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 10:36:52 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id kt6so37077219ejb.0
        for <iommu@lists.linux.dev>; Tue, 18 Apr 2023 10:36:51 -0700 (PDT)
X-Received: by 2002:a17:906:7b52:b0:94a:597f:30ee with SMTP id
 n18-20020a1709067b5200b0094a597f30eemr5082326ejo.15.1681839411548; Tue, 18
 Apr 2023 10:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
 <21e49cd7-ee15-5ebd-7805-37d5f347635f@amd.com> <6b14b2a0-cf1c-fbfb-5028-d7a6974ef39f@oracle.com>
In-Reply-To: <6b14b2a0-cf1c-fbfb-5028-d7a6974ef39f@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 18 Apr 2023 10:36:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whogEk1UJfU3E7aW18PDYRbdAzXta5J0ECg=CB5=sCe7g@mail.gmail.com>
Message-ID: <CAHk-=whogEk1UJfU3E7aW18PDYRbdAzXta5J0ECg=CB5=sCe7g@mail.gmail.com>
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
To: John Garry <john.g.garry@oracle.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, 
	will@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2023 at 3:20=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> JFYI, Since you are using NVMe, you could also alternatively try
> something like which I did for some SCSI storage controller drivers to
> limit the request_queue max_sectors soft limit, like:

That patch is not only whitespace-damaged, it's randomly missing one
'+' character so it makes no sense even ignoring the whitespace
problems. _and_ it has a nonsensical cast to 'unsigned int' which
makes that 'min()' possibly do crazy and invalid things (ie imagine
dma_opt_mapping_size() returning 4GB).

You can't cast things to the smaller size just to get rid of a
warning, for chrissake!

In fact, even without the cast, it seems entirely broken, since the
fallback for dma_opt_mapping_size() is to return 0 (admittedly _that_
case only happens with HAS_DMA=3Dn).

Finally, doing this inside the

        if (ctrl->max_hw_sectors) {

conditional seems entirely wrong, since any dma mapping limits would
be entirely independent of any driver maximum hw size, and in fact
*easier* to hit if the block device itself doesn't have any max
limits.

So please burn that patch in the darkest pits of hell and let's try to
forget it ever existed. Ok?

Also, shouldn't any possible dma mapping size affect not
'max_sectors', but 'max_segment_size'? At least the docs imply that
dma_opt_mapping_size() is about the max size of a _single_ mapping,
not of the whole thing?

Anyway, if this is actually an issue, to the point that it's now being
discussed for a _second_ block driver subsystem, then shouldn't the
queue handling just do this all automatically, instead of adding
random crap to random block driver architectures?

And no, I don't know this code, so maybe I'm entirely missing
something, but that patch just raised my hackles enough that I had to
say something.

              Linus
