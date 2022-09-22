Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F82902
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 10:02:25 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id a67so12001365ybb.3
        for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 03:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=46WsTnH5ccNyRkMXYOObMQszQI6d/3B1gqlNg4zGq6w=;
        b=nVTNGq2CMW0LwvvlSXN/KOnp/37iI7xSNaFrA9XbITuGnnjmJSnnY9GDu18y1aXxOz
         /gmR4aOUW2Gy1yNEucIiF3DIdIhi319Gui9QY2tj075u72eupvwa8JC/0QbKWkK2U/gy
         +qGdFZh+Z4R5lTjUo6Us2d1CsZnqBgfshFftr6mozaYr8sFOlqooMO5LNfqE2Nj+b+/x
         rgzLfatp9uV9LGufGTnO2ckk8IxtZH7SZW9w/FWWTM73SeW56DNPzk4qLAB0P4XCL2L9
         lONZ9zOpRo/A6ezxzCTxQLiFXePdvgNueJwIoypkdb3Dt66elZ8T+nhni+QWOf5rDyZt
         vOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=46WsTnH5ccNyRkMXYOObMQszQI6d/3B1gqlNg4zGq6w=;
        b=DDZ/GS1gUMUngFBudvGd0/JKoiNJvAEuPCwD4Fj+YnJRP75acn+ofzKzsqdUILCPLl
         MtKeOSqz6vrjve3l1fBBsuK2DUZ0wbCqYhIg896DLnCnENFqkhNLijtkIJbP6XQnI8JR
         Hkv8Hw6GVFa1iq+S4wTJ/EgiykX51uQBznQdDKmJJJRVqvvJHfM3739WsZhsSR6vZ+0/
         QiAEsA1SZjG/j5ryXmGEtVzbjsUJsM6vGkHzBzF2xz0AqiwCMUfMAv4E2G1xs3aHcJC0
         PkaOlJOgT9PXX0tT7okmkNZRyd3A9Ie4ZXSbfavaZbng25l7OjR/BpBivRNJupAWQilr
         BfCw==
X-Gm-Message-State: ACrzQf1wU15UBIhkRFPsyHYTnM2m9sEmNOaJeBRjomu/GOEuaeM935t/
	AqstyWePNlNtPsUcsnR30i9ibR2pVV1VZ015sEI=
X-Google-Smtp-Source: AMsMyM5LzWME31dkryngzwq4K/qwIch4VrMtIzr27XxPwONL39453ZiIwLkMDNxO2AlqITApER46nnvdEVeWEIdvmg8=
X-Received: by 2002:a5b:842:0:b0:6a3:cf26:755d with SMTP id
 v2-20020a5b0842000000b006a3cf26755dmr2526623ybq.608.1663840943987; Thu, 22
 Sep 2022 03:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220919084744.3043-1-lukas.bulwahn@gmail.com> <20220920064332.GA17325@lst.de>
In-Reply-To: <20220920064332.GA17325@lst.de>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Thu, 22 Sep 2022 12:02:13 +0200
Message-ID: <CAKXUXMx=7oonR05W0TXW+AAN5FmD86mfiTS=QGFnvUMxRWFa_w@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: refurbish SWIOTLB SUBSYSTEM sections
 after refactoring
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 20, 2022 at 8:43 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Sorry for coming up with this only now, but what about just dropping
> the separate swiotlb entry entirely, and just add include/linux/swiotlb.h
> to the dma-mapping entry?

Sure, great idea. I just sent a patch v3 doing so:

https://lore.kernel.org/lkml/20220922100001.12964-1-lukas.bulwahn@gmail.com/

Lukas
