Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8892D652
	for <iommu@lists.linux.dev>; Wed, 31 Aug 2022 06:20:02 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id m66so13620655vsm.12
        for <iommu@lists.linux.dev>; Tue, 30 Aug 2022 23:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5Uji14+TdZrnvcT0vtEfCUN+mbWQ8EBkoUebh8FZEU8=;
        b=Y2jD8zNY3VvF7yFZcZLYhg5Gfzu1o+2UpwAtIZ2QspR4u/sFWVRH4h00lTQdl/47MW
         U5odU8htYcZ2Axj1dl79B3wZsOZ6AaAPdjRQHp0WvPY18nb6X5oZ7E/qv2UrdCqSqcvZ
         fcm5ILO5TV8jpnS/soWNXWi/byQir7ZtOy2l6E/jPNrxOkqN9uQhq344Wv4lLGrr1sG3
         +X5uaZ6rKLsXBsGJpEd6Qw01wUEnqrQcnhJ7fvdlYWjpk58o8N+20uN7tysYr0ICkUCb
         aZdQZEo8jA8A1s3kXHfKh/Al/ymnrr3XYS0CpXGICVRZbwu2b/gMHYq+pxWvc293raeZ
         +sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5Uji14+TdZrnvcT0vtEfCUN+mbWQ8EBkoUebh8FZEU8=;
        b=x8W6ovYUDAMcoNq2cK7JqGWwBn7YYFnq6RfFqX7lw4WxUY5rLhxmO18TPaajT7lXoi
         UfOCYO8ahY4dc59+DoC1OxLzS38o+C0oe+SQ7aPkBYCRI+F2wpUvim4dORU2Pfmo7Adi
         vyakd3RfJUy5xvNg8pZ4ZO+epXZfv2iAE/mHrXU4jbxCOFiuroEe7YnOWMHNK3x/rEJz
         D9FSfvNnREUCHY2ixhoM7lpckH5IRAMqP0oPlwwy3vtqcMe44RrIRYOQPEayMzae+k8i
         XiSaZ5dIv1iQgP8pLIiMj8+sa1RF6/qE4PM5jpJW/U4KocPttKLMRHdhTcZpPsSnwwfR
         ivFw==
X-Gm-Message-State: ACgBeo0M5tPpExktrVFKSGUp/OL4QtizvrSb50qX+YLi7ku1L8wGBYOp
	rgu92jBTCLIuvLEv0ql56QFzPcF4NxpXzRe6mxEh6A==
X-Google-Smtp-Source: AA6agR4394e/N2qvqEWV8UddKMjybUgjOSmpGyCbjDt0hIzivYq9pWESRkiTrl7QLWA8RmaV5T+80kojoXyYUB3pVqA=
X-Received: by 2002:a05:6102:e93:b0:390:d839:9aa2 with SMTP id
 l19-20020a0561020e9300b00390d8399aa2mr5535835vst.65.1661926801397; Tue, 30
 Aug 2022 23:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220829232934.3277747-1-yuzhao@google.com> <202208310701.LKr1WDCh-lkp@intel.com>
In-Reply-To: <202208310701.LKr1WDCh-lkp@intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 31 Aug 2022 00:19:25 -0600
Message-ID: <CAOUHufbnaZpNZ-rarVzOE+S6Wya8OmJF5sbNF29S-Y_XLNRooQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "swiotlb: panic if nslabs is too small"
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: kbuild@lists.01.org, Christoph Hellwig <hch@infradead.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org, 
	iommu@lists.linux.dev, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 31, 2022 at 12:01 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hi Yu,
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Zhao/Revert-swiotlb-panic-if-nslabs-is-too-small/20220830-073123
> base:   c40e8341e3b3bb27e3a65b06b5b454626234c4f0
> config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220831/202208310701.LKr1WDCh-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> kernel/dma/swiotlb.c:334 swiotlb_init_remap() error: uninitialized symbol 'nslabs'.
>
> vim +/nslabs +334 kernel/dma/swiotlb.c
>
> 7374153d294eb5 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-14  307  void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
> 7374153d294eb5 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-14  308                int (*remap)(void *tlb, unsigned long nslabs))
>                                                                                                                               ^^^^^^
>
> abbceff7d7a884 lib/swiotlb.c           FUJITA Tomonori   2010-05-10  309  {
> 6424e31b1c050a kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-15  310        struct io_tlb_mem *mem = &io_tlb_default_mem;
> 20347fca71a387 kernel/dma/swiotlb.c    Tianyu Lan        2022-07-08  311        unsigned long nslabs;
>                                                                                               ^^^^^^
> Merge issue?  How does this compile?

Sorry, I deleted an extra line while resolving the conflict.

Resending the patch.
