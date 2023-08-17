Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAAC33D1
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692290398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OM71pDKm3gUMSnzcjBWfpHVt999F5DyS5/mU42PgQHk=;
	b=Cl1xU9giPShyy/fQWa5ev5SiY5GCC1Ht9/RKXQmRWop888wcWLIhSLlbqx+rsHUNUD9MeN
	JeKvk8wPJaiFnvTL1QdT/kJ0dC/uP8QA+pjts9Idt78/TCU7IWXsdBLCrQSkY7mmA5X4TW
	kx1fJaZ8/H5LPuKSY57KxoJm6re6ZHo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-KwtUhrmANmqYIzclEzOJQQ-1; Thu, 17 Aug 2023 12:39:56 -0400
X-MC-Unique: KwtUhrmANmqYIzclEzOJQQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6491907dba4so99606d6.1
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 09:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692290396; x=1692895196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OM71pDKm3gUMSnzcjBWfpHVt999F5DyS5/mU42PgQHk=;
        b=CG7RowvYExg6CYXZ08EeF07jt1CdEzSgloHByFnrnyIvrQdM5TtIhc4HpD7v5RBz+8
         9RDKHJ7g4EFu4ZXvx30jvQWjj2Ei+jGtzE12FOSYEks0NH+spAvmBXDiT6Bcd1Rl3XEs
         slO8QwDf7VnXowoJEudfMmUrTnkAMX7f1gHVMJ6lekWeNE3A633FuPyOL8G4o0moTTKt
         hnk2+YnSz8ga3jEDFUb/l03SK+/azNCtIDK16ldOrKXA4N2ncOKG/bSJCVQbN814V9IU
         v5eJ1yyxTKRqXiaquNNuxU0tgMsSJmZ5VkBaP9FLg6fyM7fu+Jy6hJVnD4Lv+wWhDQwY
         yv7g==
X-Gm-Message-State: AOJu0Yz7URE+7L1pSL1f5EUqCkdEsXzQY/oo+Mnn0QpjiyR6o2vT/IYq
	qGWpwB2vUXr7qklT6JYF7N/x4s1uiAB1pzfq3lNPfOw5xHF/KQ6NaFPFpM2WjTA2mZyIFEDH4es
	P5ehrCqq8F+t4PhM=
X-Received: by 2002:a0c:cb92:0:b0:62d:f04b:b51 with SMTP id p18-20020a0ccb92000000b0062df04b0b51mr4116754qvk.29.1692290396324;
        Thu, 17 Aug 2023 09:39:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3rGMZwPKCKJSH1ZDrAWfDCPAs9BnwaKyJVZAo1qe/UyCfHW0hud9nYbZTP9JZIRVv6URdXw==
X-Received: by 2002:a0c:cb92:0:b0:62d:f04b:b51 with SMTP id p18-20020a0ccb92000000b0062df04b0b51mr4116728qvk.29.1692290396061;
        Thu, 17 Aug 2023 09:39:56 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id y3-20020a0cd983000000b0062ffbf23c22sm5772806qvj.131.2023.08.17.09.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 09:39:55 -0700 (PDT)
Date: Thu, 17 Aug 2023 09:39:54 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, john.g.garry@oracle.com, zhangzekun11@huawei.com
Subject: Re: [PATCH 0/2] iommu/iova: Make the rcache depot properly flexible
Message-ID: <ychdxbopmzkdpebjeyyegkq2xmhknmggtwppc7adman5qxxdn2@kgv4fiok4p2j>
References: <cover.1692033783.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1692033783.git.robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 14, 2023 at 06:53:32PM +0100, Robin Murphy wrote:
> Hi all,
> 
> Prompted by [1], which reminded me I started this a while ago, I've now
> finished off my own attempt at sorting out the horrid lack of rcache
> scalability. It's become quite clear that given the vast range of system
> sizes and workloads there is no right size for a fixed depot array, so I
> reckon we're better off not having one at all.
> 
> Note that the reclaim threshold and rate are chosen fairly arbitrarily -
> it's enough of a challenge to get my 4-core dev board with spinning disk
> and gigabit ethernet to push anything into a depot at all :)
> 
> Thanks,
> Robin.
> 
> [1] https://lore.kernel.org/linux-iommu/20230811130246.42719-1-zhangzekun11@huawei.com
> 
> 
> Robin Murphy (2):
>   iommu/iova: Make the rcache depot scale better
>   iommu/iova: Manage the depot list size
> 
>  drivers/iommu/iova.c | 94 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 65 insertions(+), 29 deletions(-)
> 
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

I'm trying to hunt down a system where we've seen some issues before,
but most of them have involved systems with nvme drives. Commit
3710e2b056cb ("nvme-pci: clamp max_hw_sectors based on DMA optimized
limitation") has helped those cases. I ran the patches overnight with
IOVA_DEPOT_DELAY fixed up on a couple of Genoa based systems (384
cores) without issue.

Regards,
Jerry

