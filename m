Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8723346B6
	for <iommu@lists.linux.dev>; Thu,  8 Jun 2023 05:45:49 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ae64580e9fso75575ad.1
        for <iommu@lists.linux.dev>; Wed, 07 Jun 2023 22:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686203149; x=1688795149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib8fl235iJ0JhEUcequsAls0ajgM2AbatRtEpzlVvCE=;
        b=BObNijJhiPN3IChRUk57h/SymCh//OGg6p2YQh8XvixlfnbzI/LwzCthumc2/NJgfy
         7DwU0Jobe6BoXidWSLR33aRvp9k54UcJKmXd8kwdNBgIHMS0oUNzChvuS01UaLprepqQ
         m4eH3S+zNWHVwjiqs9hqDrdE7sgwcS9+aSunDrhCZ8Ej80Ln4m9BHr3QjClOeCeMWz29
         jJ9YIKJEBhMBDIJOR7XCKvLt7e3fTOVU3UDTYAcvNVBeBnz5wXXNSnDItZGk+WjTf69d
         y6+F1w9TCaTISJDcW39iBa1wR0qEaes6UgykA0ixHqWyVaRtz/sFFHFQYy2Dz1g+lhla
         ySHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686203149; x=1688795149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ib8fl235iJ0JhEUcequsAls0ajgM2AbatRtEpzlVvCE=;
        b=BmItcrPloFfnYE81LQxhRsoBCNjnykLi/sc14Se1axUs6G53+t1Rcd0WQP4g7xY/MJ
         rn9F4tbR50Dt7waC9yAmA3g9Q0f+UjL6U8b+sICznTb8cn/gLCpGDYTtqDES86WBb2UL
         aS9rabQoiEUv7qs5KTo4Xm7eraMzvSsBEV3XrETm7dQxwR7uGYOpHTp5xnZeCVBez/Os
         cj/EwN2JkUaS8xoJgmx8+CgYmb0wawRp+R6n8j+b4/almVgcL8AITM5JKnvITp6m/aJ3
         Jfautb88Hc21WoeLX/CzXvzZGj0BDSVBJ5yuyR7ff1Ay1AK3+xwuPhASruxbxoX1I00o
         sWNA==
X-Gm-Message-State: AC+VfDzHLBZ40h2Rjo1FEP6jz7TigN9gdkiLuS7vK2K0tfDNRALL59cy
	H2fYbqUdHiBKRnqN6Kj24uKrgao+i9XueHIx5ImP6g==
X-Google-Smtp-Source: ACHHUZ64XuBjYuOaG6KVkutK/ORWpUEtpdz+ZTct7J0q9eqC/Qo24cWMTlt/dxG0Z1mo+C0GaLHrprUGD2Lx6f3mdPo=
X-Received: by 2002:a17:902:e80a:b0:1ae:221b:5894 with SMTP id
 u10-20020a170902e80a00b001ae221b5894mr133673plg.1.1686203148725; Wed, 07 Jun
 2023 22:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230531154836.1366225-1-catalin.marinas@arm.com>
In-Reply-To: <20230531154836.1366225-1-catalin.marinas@arm.com>
From: Isaac Manjarres <isaacmanjarres@google.com>
Date: Wed, 7 Jun 2023 22:45:36 -0700
Message-ID: <CABfwK12_wC1t5J9c8qRmUi9H4GtYc6KR9oeJPi8ucK36prhUzQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/17] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to 8
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ard Biesheuvel <ardb@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron <jic23@kernel.org>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2023 at 8:48=E2=80=AFAM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
> Here's version 6 of the series reducing the kmalloc() minimum alignment
> on arm64 to 8 (from 128). There are patches already to do the same for
> riscv (pretty straight-forward after this series).
Thanks, Catalin for getting these patches out. Please add my "Tested-by:" t=
ag
for the series:

Tested-by: Isaac J. Manjarres <isaacmanjarres@google.com>

With the first 11 patches, I observed a reduction of 18.4 MB
in the slab memory footprint on my Pixel 6 device. After applying the
rest of the patches in the series, I observed a total reduction of
26.5 MB in the
slab memory footprint on my device. These are great results!

--Isaac
