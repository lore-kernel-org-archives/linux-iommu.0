Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B645139B
	for <iommu@lists.linux.dev>; Sat,  6 Aug 2022 20:31:47 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id w19so10340640ejc.7
        for <iommu@lists.linux.dev>; Sat, 06 Aug 2022 13:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=h6TeEL+zwRVR56oMOZRDcH12YoM3CR31tNWgWBUf5pA=;
        b=Z5Tr7NC6JgsKkE9XiNOKBzUM2nRxwEmA5LsMsrsD3MCosdCfDER+TMZteu3pHKDnRA
         b+oSRQwWMeplsoY1nMc/pYY5OoqRolBlVuMg4VWi0RHXg22MpgJ7hKeZoHyu9boeNa5H
         gyecJly17bbyHXvhbk3CXSBAhPTS+R1x2H4fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=h6TeEL+zwRVR56oMOZRDcH12YoM3CR31tNWgWBUf5pA=;
        b=ybw9U1gM+gj3cROeD7smRr9btYzjdOuJ/Y+CN/hAjGRJuI08J+YS3hYuAjQhwEh8fH
         sHQ8ufZyaeIsgU2MbDuU/oNMF05icP2y5gYkB9UFfPBh4s7HCgmlZuW8e2xvLEV+mEmy
         QegKr6mUdyWJNKvT22j/1OoJ3tWjwHrGFncv43s9rHncun3r1ZAU9MunoYp8kl3+wBKY
         LzDUq4Xx8H1HdvUYW1J8sie6itiufc5z46gg0BDmpBFcPluURWLZoVS7gVeIn+krCiE7
         Z7ot2hyVM4NOQUXPVZZmJUZw5wQVb2zyORTlaiw63ym3gZZpDQDLPHo8IL8nqDRoJTfw
         bOUQ==
X-Gm-Message-State: ACgBeo2tXsGQbrJuJ9PoQIQyMxocVFL1Q5ECOeggMQdHiZQiGFvLXlMr
	rXtz1JTWKTzAdHyOcLAJdYhtLUZ0m7RkhN6o
X-Google-Smtp-Source: AA6agR4AqCtnceOu890pIX+7IbJ2LdIu9SvSPWznv05ORe5Nrdm4nyNw4qwI2wat/OFy10qqmjasgQ==
X-Received: by 2002:a17:907:d0f:b0:731:5c2:a9a5 with SMTP id gn15-20020a1709070d0f00b0073105c2a9a5mr4917270ejc.413.1659817905607;
        Sat, 06 Aug 2022 13:31:45 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id w6-20020a056402070600b0043e35ae2610sm1964683edx.27.2022.08.06.13.31.44
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 13:31:45 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id j7so6756392wrh.3
        for <iommu@lists.linux.dev>; Sat, 06 Aug 2022 13:31:44 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr7357268wrw.281.1659817904667; Sat, 06
 Aug 2022 13:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <YuzlAT7RW1U36+ap@8bytes.org> <CAHk-=whs5CR5FRZP_HUksrr9wX6=Rai-S_XTUFJN7jwB5wKN-Q@mail.gmail.com>
In-Reply-To: <CAHk-=whs5CR5FRZP_HUksrr9wX6=Rai-S_XTUFJN7jwB5wKN-Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 6 Aug 2022 13:31:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSxEVW78nTumvz+ZYt2MZcmqe6S0nb_-efKYm636VuGA@mail.gmail.com>
Message-ID: <CAHk-=wiSxEVW78nTumvz+ZYt2MZcmqe6S0nb_-efKYm636VuGA@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v5.20
To: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
	Christoph Hellwig <hch@lst.de>, John Garry <john.garry@huawei.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, Aug 6, 2022 at 12:39 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If it is, it will be reverted as hopelessly optimistic.

Indeed. I should just have verified with the kernel command line, but
I started bisecting when it wasn't entirely obvious what was going on,
so I just finished it.

Commit 4bf7fda4dce2 ("iommu/dma: Add config for PCI SAC address
trick") is reverted in my tree. You can try again in a decade or so,
but at least on x86-64, that config option is basically a "stop modern
machines from working", and I don't want to have that even as an
option.

If somebody wants some debug output to figure out which device it is
that cares, send me a patch, but we're not trying this thing as-is
again.

                 Linus
