Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3D39D
	for <iommu@lists.linux.dev>; Sat, 15 Jul 2023 03:19:21 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9936b3d0286so351269766b.0
        for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 20:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689391159; x=1691983159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bH4YNFQ85GLtLQVvtYry9jNegNVh6BuHBSS+rjBmUNk=;
        b=OJq8ZudGCI5Xr+dsQCSNVCTOjLcYwJ82eRtCM6/LTQ0lFWpf3l3ac0GF3SwEdSvlqG
         v4vsx9ZAtZkDQc4GzCpZ3y4k/L8c8Gq6FSumVGRxFjpU/ef5AbWM0pC9xpH3wPtIwCbj
         w3P3HhMHbgug0PR99rdirxzz3bEWzU4wdiAS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689391159; x=1691983159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bH4YNFQ85GLtLQVvtYry9jNegNVh6BuHBSS+rjBmUNk=;
        b=OesuXkR8HjTqycEPQnWCWvXQfPRQpHX4CuDpaw+U32T6OiZMRmcFLz9OpavtvNYYPG
         t/DNMlvxjsL5fTSDIDB2CsHWAOAXLmbmQgYkxxZDkQfAitEeoJZYQWDLJJ8Jlije3G6P
         HZ+zu9rD73YkEBquH2/znVO1MNBuo2O2SwMywo02LF6xIV2QXgo1upn6ZfhfghAD27ma
         2YYYP6LHaAJltcDTijB4+DfZNV80mT5d253XFbWNyuDPfKvQFnH11FV/PxvQ7DaXbiZD
         i4sT+/9M2HngYRDLjSlI37XLlTmN/9l2kgeeifGyDJMAR1no1ttKhEt2jVUZ29eK8Z8h
         bAyA==
X-Gm-Message-State: ABy/qLbdYrKMo831DxNqMwWk6J9Emr52obkM413zh4/BLFckt+M82Gtg
	MknzZ8DD6U/17bI70EsC0TU+7axiHnnv/MTMu6qrtw==
X-Google-Smtp-Source: APBJJlGoMJeagsE/5+Qik+s/nSEabf5A6y+PsOnr2NF9cUVp0s0T6Wc04vaR1Ml1fXxYg76eR0qbCw==
X-Received: by 2002:a17:906:3f1c:b0:991:fef4:bb9 with SMTP id c28-20020a1709063f1c00b00991fef40bb9mr5735337ejj.58.1689391158697;
        Fri, 14 Jul 2023 20:19:18 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id bt23-20020a170906b15700b0098d93142ce1sm6181330ejb.109.2023.07.14.20.19.17
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 20:19:17 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9936b3d0286so351266466b.0
        for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 20:19:17 -0700 (PDT)
X-Received: by 2002:a17:906:2201:b0:98d:fc51:b3dd with SMTP id
 s1-20020a170906220100b0098dfc51b3ddmr5283965ejs.41.1689391157559; Fri, 14 Jul
 2023 20:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZLGwoGoJNAG6Db4v@8bytes.org>
In-Reply-To: <ZLGwoGoJNAG6Db4v@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Jul 2023 20:19:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgppEZ9SswgkQEMVA5UW8Epnc4PgKjKSo=6MEK=X70MEg@mail.gmail.com>
Message-ID: <CAHk-=wgppEZ9SswgkQEMVA5UW8Epnc4PgKjKSo=6MEK=X70MEg@mail.gmail.com>
Subject: Re: [git pull] IOMMU Fixes for Linux v6.5-rc1
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Jul 2023 at 13:31, Joerg Roedel <joro@8bytes.org> wrote:
>
> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
>
>   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git iommu-fixes-v6.5-rc1

Nope. Nothing there.

Guys, 'git request-pull' should be *warning* you if what you claim is
there isn't actually there.

Why don't people look at what they do?

                 Linus
