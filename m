Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327A2565
	for <iommu@lists.linux.dev>; Tue, 26 Jul 2022 13:09:14 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id u5so20083100wrm.4
        for <iommu@lists.linux.dev>; Tue, 26 Jul 2022 06:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LUMaKXkVvWIJpdA+4n1XBPobt062sN0oITrvSdAqdAY=;
        b=LtVuVs60IaQZ8nnPk8iiwP99j3115x2cIPKtiL5B3cX6MtWdYW8/8gUoVQj4dvB8Oq
         TPSfPtuodo6l+Qh7TbHToyERpVXZ7/gzp0jO/ShoRDP7irU6o1XDXdR8lWtm1D35DqN9
         JX5WtvshwGzhBczjT7S/K3LaqhRQN+04YhSq+E/JKAQK57Dr9kKvAPAr7CmO3F6Bq8Gp
         eDjrifok8p96+81rUOZ9nbWe0hlfwVtXTqjmtGkvS9le+A1ueBDA3u0eRwIWahwlJ+Mg
         dbSbh2rhKb2llqAW00sE6VK7SExIT7EsYDTzq375S7bUJZeqVn/4hqbKRk5D1JhxACDe
         M6ZQ==
X-Gm-Message-State: AJIora9zQQXSnvBXgOL1Bp9KCw5N6mvwFyKRkzL2eSoeyhjt2+RjoFYE
	vpHjSLqGn2kUTn6ZAGs5P3U=
X-Google-Smtp-Source: AGRyM1vw7dZ0+zdf7ovRK9cRi5k+lbX+miTo9Z8YAsT302jzpJU2YCBHWsEkZdxiNa4KztoyCFBmGA==
X-Received: by 2002:a5d:62cf:0:b0:21e:6e8c:34a8 with SMTP id o15-20020a5d62cf000000b0021e6e8c34a8mr9768554wrv.154.1658840952226;
        Tue, 26 Jul 2022 06:09:12 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id bg17-20020a05600c3c9100b003a04d19dab3sm3225732wmb.3.2022.07.26.06.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:09:11 -0700 (PDT)
Date: Tue, 26 Jul 2022 13:09:09 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Michael Kelley <mikelley@microsoft.com>, sthemmin@microsoft.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, will@kernel.org, robin.murphy@arm.com,
	samuel@sholland.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 1/1] iommu/hyper-v: Use helper instead of directly
 accessing affinity
Message-ID: <20220726130909.jnj5etogffm4b2c5@liuwe-devbox-debian-v2>
References: <1658796820-2261-1-git-send-email-mikelley@microsoft.com>
 <Yt+Uro8y219/MNFE@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt+Uro8y219/MNFE@8bytes.org>

On Tue, Jul 26, 2022 at 09:15:58AM +0200, Joerg Roedel wrote:
> Hi Michael,
> 
> On Mon, Jul 25, 2022 at 05:53:40PM -0700, Michael Kelley wrote:
> > Recent changes to solve inconsistencies in handling IRQ masks #ifdef
> > out the affinity field in irq_common_data for non-SMP configurations.
> > The current code in hyperv_irq_remapping_alloc() gets a compiler error
> > in that case.
> > 
> > Fix this by using the new irq_data_update_affinity() helper, which
> > handles the non-SMP case correctly.
> > 
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> 
> Please add a fixes tag.
> 
> Where is the change which breaks this currently, in some subsystem tree
> or already upstream?
> 

The offending patch aa081358 is in linux-next.

> In case it is still in a maintainers tree, this patch should be applied
> there. Here is my
> 
> Acked-by: Joerg Roedel <jroedel@suse.de>

I can take this patch via hyperv-next. This is a good improvement
anyway.

Thanks,
Wei.

> 
> for that.
> 
