Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9716DF5A
	for <iommu@lists.linux.dev>; Wed,  6 Sep 2023 13:44:26 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-68e26165676so706075b3a.0
        for <iommu@lists.linux.dev>; Wed, 06 Sep 2023 06:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694007866; x=1694612666; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PBTSwwsb/W1c8hHwSDDAKIWq22po1/l3/4/knj00hG0=;
        b=hpxUZ8xkJdTJYzz6a5mAJYg7Jy3lXtzUpmSuxim4dVJKYka+jB4hAzsk2jyYIVcLLv
         YkVPzj0f60RNAjS2ijmJPv6M7hubbSA8Ocgjx7dHKTcARDUaAlGn0ZdyxadOHQwXBFZ0
         t+5P4Ls8PsYRlOHouhITX+WRHF+Kcfb/mzwe81DzTlJSE9YSQzTsO7nozNrjqA6Eppkd
         muNPj+Lbi/gt6BmKoUXpZ2mYBDA7MCkhArGJ7szDLYxLRnNeNmvqvzxSUq168MhpFOiq
         1al6EnoKzSNOfiBlnEycSH1nXs1XnVYCA41mxmOrJrJ1Ey1NCd966fqzhNof6nD0+Os1
         SX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694007866; x=1694612666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBTSwwsb/W1c8hHwSDDAKIWq22po1/l3/4/knj00hG0=;
        b=NcYq28LjUz9REZDzjCuTXkGkiKf8+TB+AM1Dpo5RB/8E8LBWQR3E+RhceD/JqnZ/t8
         d07qS4q22KTlU3tU7jV+UEO5bnn0v3IIJJ26+ayxT/u82Ks29v2WsbLw9BCDbz2X6akr
         ryY7IXkAZGnfMWZEo/c+VI0qtptQKcnMQB4V4OX1IlT89t/R8c2uxnCwmhELOOxUEQC9
         QiwKDdO5NmtIiwzYk6RYQPxookwV5Dai1KK3m7ZU+HEAlpIjL7mh1elxmkx9BS58Nk4c
         emPd1ms9PRX+xo9ttfov3lcg9f3kDbIMV+OVaYzIUfaxlrvIQ/LInEMJJ0YiE2gi9fbN
         Up0A==
X-Gm-Message-State: AOJu0YyLCAffU77Tf8eY5CiH2/DzDotrP1oQdTUfkt7/b5GTxyO9rwfT
	6FqEYWA+K1Yd8bAXkM2oh6BlWA==
X-Google-Smtp-Source: AGHT+IH3auFQXYhq6wffFgeKtTAEUAj64zbzZu/yQwgY50Aarrfn1j2Sjh0CKkMc+Nt5taNEj2Hfpg==
X-Received: by 2002:a05:6a20:2453:b0:13f:b3b4:1986 with SMTP id t19-20020a056a20245300b0013fb3b41986mr18218727pzc.12.1694007865927;
        Wed, 06 Sep 2023 06:44:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id w12-20020a637b0c000000b005651c9351e1sm11055496pgc.64.2023.09.06.06.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:44:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qdspR-000yKq-GK;
	Wed, 06 Sep 2023 10:44:21 -0300
Date: Wed, 6 Sep 2023 10:44:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jingqi Liu <Jingqi.liu@intel.com>
Cc: iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
	Tian Kevin <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: debugfs: Fix race with iommu unmap when
 traversing
Message-ID: <ZPiCNTbGp64MRfhQ@ziepe.ca>
References: <20230903144050.11277-1-Jingqi.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903144050.11277-1-Jingqi.liu@intel.com>

On Sun, Sep 03, 2023 at 10:40:50PM +0800, Jingqi Liu wrote:
> When traversing page table, it may race with iommu unmap.
> 
> For the page table page pointed to by a PDPE/PDE, there are three
> scenarios in the iommu unmap path.
> 
>   1) The page has been freed.
> 
>      If the page has a refcount of zero, it has been freed. The
>      debugfs should avoid to traverse it.
> 
>      In the debugfs, the refcount of a page table page is checked
>      before traversing it. If its refcount is zero, the page will not
>      be traversed. If the refcount is not zero, increment its refcount
>      before traversal and decrement its refcount after traversal.

No, you can't do this - the page can have been reallocated already.

A sane design would be to RCU free the page table entries and have
this walker be RCU protected. I think I said that already once..

There is some infrastructure we should build to make this sensible,
but it is the right direction.

Jason
