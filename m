Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F07E5
	for <iommu@lists.linux.dev>; Wed, 31 Aug 2022 23:52:56 +0000 (UTC)
Received: by mail-ua1-f47.google.com with SMTP id z14so6064949uam.10
        for <iommu@lists.linux.dev>; Wed, 31 Aug 2022 16:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dB/Ygu4p0hlR5xc5n0QdJ7utzSAVujm8LkOKbdwdxZo=;
        b=TTZRTgyinQmb9tXu1/58oyS1vRReaulbY6sg+mYeCtxDE0gmiSTwGHJhnpoLo4rnol
         FEOqEvawWWLah6qOsOhxE0ZknAEMGZr5A2C1e2wCTsSff3YQX60ct9Z/kZYeKNEBRDfL
         hmRi55KGcZ1P7IRJsmIw8FKVEcHbAtjjwqzuvfDP18sXhHtqVCWF5lwrmgEi87I/J5rf
         kSDFG760CKP/0PMKEcaCEkXjjmKL7s/KGIAA2GkdRky96W7blG82kWfpFrCVe5+GEgfE
         sD66DkLcfpA7G01yAn4uyBI1rEySbdlHEPF9+xSylnmryp2+/+qTWW9uykXAmehm2LDd
         +pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dB/Ygu4p0hlR5xc5n0QdJ7utzSAVujm8LkOKbdwdxZo=;
        b=R2RsfeXLrOQkO0Y/Da2BuCXSY6FZ3ZwAi54cZfTVUwRMou9UXQRkcxlvPY4MdfXkuF
         NSm+4E7IBH82+U0nUmXIJSYWDpBTNrZjB/h6Ib0v01eF7idPJApBm4atn9+j3kFc4ivR
         xH0zSA31Wngochjt+cJ1+iL/IGgNHGaZjz8u2X+uSv6hO1NDgnMq721DJ2EsK+P25+Ir
         YleC7pllRhLBajM96iOJ8Rp8o3EwTaKbBIj4p4RB5UKnQ5jYKwtlk+4SYplM9TthNBhX
         3oM7BHKB4UMxebk8psxaYcYfSb3goHC7yyNFLss6aB+2SJtiIet65s5atzWN1Tul/9GL
         9Kug==
X-Gm-Message-State: ACgBeo2n3H4Le8CSM1GO9BDJElnocNMpvTHtYlqq6q4JDHIskUut10l4
	PV8Wk0t1b1F1dygrBlawTC7TpwwkdyMesYNsvhG32w==
X-Google-Smtp-Source: AA6agR6gV/O1dKGBMeIJ5VWnArZrpcd9hDk6vFY3nL1JOYKPLFbQPcA4C6aQ8QYasBuBQSMHSCeypEeo9nvGZdgyhqM=
X-Received: by 2002:ab0:14c3:0:b0:39e:f748:a1e8 with SMTP id
 f3-20020ab014c3000000b0039ef748a1e8mr8093976uae.59.1661989974466; Wed, 31 Aug
 2022 16:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220829232934.3277747-1-yuzhao@google.com> <Yw9lOwlKrXyRsB8+@xsang-OptiPlex-9020>
In-Reply-To: <Yw9lOwlKrXyRsB8+@xsang-OptiPlex-9020>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 31 Aug 2022 17:52:18 -0600
Message-ID: <CAOUHufaa2P471xL-8jCG-188386pkcKUBYPnM-mzq-f0W1eh8g@mail.gmail.com>
Subject: Re: [swiotlb] b253fbc6b9: WARNING:at_kernel/dma/direct.h:#dma_direct_map_page
To: kernel test robot <oliver.sang@intel.com>
Cc: lkp@lists.01.org, kernel test robot <lkp@intel.com>, iommu@lists.linux.dev, 
	Christoph Hellwig <hch@infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Dongli Zhang <dongli.zhang@oracle.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 31, 2022 at 7:42 AM kernel test robot <oliver.sang@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-11):
>
> commit: b253fbc6b9640aeebffc73d72bf0177c2a1ede1e ("[PATCH] Revert "swiotlb: panic if nslabs is too small"")
> url: https://github.com/intel-lab-lkp/linux/commits/Yu-Zhao/Revert-swiotlb-panic-if-nslabs-is-too-small/20220830-073123
> patch link: https://lore.kernel.org/lkml/20220829232934.3277747-1-yuzhao@google.com

Thanks.

It was reported and followed up on yesterday [1].

https://lore.kernel.org/r/20220831063818.3902572-1-yuzhao@google.com/
