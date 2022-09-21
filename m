Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D566E4
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 17:28:06 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-127dca21a7dso10036911fac.12
        for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 10:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oIcVLFk7zmQbQSkhtXNMtiXqG0YYuFNHIOlQIXgkdXw=;
        b=IpQtuPeAaqwDBdNxq8AGBqSy7sk3hE4//SgQa9KtcKybm3kBqzMfOZ87h/cWoGMili
         5N9eOFmNgbGxtV7goomqVEG65TQXTTYoPpUfiGLeyvgCM6TRGFQeBQIi+/QJV8OAfvMh
         BQYj9iFOz0rdCkPj9BVrIcyuTv/Lz+F3ZtvgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oIcVLFk7zmQbQSkhtXNMtiXqG0YYuFNHIOlQIXgkdXw=;
        b=nr2Duqlf2AgyYzYUzo9PZBNjD2rwUU8jnlQowwczpveigRR2DOcA9O8/ma5suLJ+kt
         FZ9MAyG9nUMyGJyoOFjXYcjmNf12J6Xlz+SyAIw144EfXvpDzRwnwiUaPPmNROoGuOCW
         bOr5fzSoXNXO1LaWG9VL9hiv9RXeyK9MhnHlyGu0uNv1MdyEgsIfExvA7ZNanvfQRsfQ
         fodKtEAx+MCHwA82zzVULSwzjjQK3eunTER0jdpqjomdBsoWAI3uFz/6xZx9fxbG8PlJ
         pD18ra+2fiU8zoXlzZlYCeSTKPjYmv174YlyIyC1ZlQmSzapBiOsuFOJlhNvynVdxbcc
         69Yw==
X-Gm-Message-State: ACrzQf05QDLKLUJ769JEb43nS1b8DuUA8SCK5AUPX6KRBstC9udEkl6m
	yLFpcqM6jUCe6hqpf62G8gh+/kaLVuM0Vw==
X-Google-Smtp-Source: AMsMyM5WbrBkrs05jvPRfE8h0kLdKSseAEYvsPDmmu1ThZKBnnzJtl648ctmJB/C4Mbw8M90miuTNA==
X-Received: by 2002:a05:6870:c0c1:b0:10d:96:737f with SMTP id e1-20020a056870c0c100b0010d0096737fmr5788891oad.101.1663781284892;
        Wed, 21 Sep 2022 10:28:04 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id f11-20020a4abb0b000000b00425806a20f5sm1242698oop.3.2022.09.21.10.28.03
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 10:28:04 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id t62so8906103oie.10
        for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 10:28:03 -0700 (PDT)
X-Received: by 2002:a05:6808:11cf:b0:34b:8f4f:314b with SMTP id
 p15-20020a05680811cf00b0034b8f4f314bmr4438561oiv.126.1663781283650; Wed, 21
 Sep 2022 10:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2b0ca6254dd0102bf559b2a73e9b51da089afbe3.1663764627.git.robin.murphy@arm.com>
 <CAHk-=whdwG2LaaktZTYab2JO2TkPYEmSc-sOJ=qL5wtOWpRpKA@mail.gmail.com> <574fe371-033e-a316-4ace-8a3fd9b19329@arm.com>
In-Reply-To: <574fe371-033e-a316-4ace-8a3fd9b19329@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Sep 2022 10:27:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMzxSF9=3MuUs_TcgDgkxDvWQzW9HG17wDLbDrYrXtBg@mail.gmail.com>
Message-ID: <CAHk-=wgMzxSF9=3MuUs_TcgDgkxDvWQzW9HG17wDLbDrYrXtBg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu: Optimise PCI SAC address trick
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 21, 2022 at 10:01 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> If you do want to have a play though, compile-tested cherry-pick below.

Works for me.

Except for you having "format=flowed" and some whitespace damage. But
I fixed that up manually.

                Linus
