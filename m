Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E22C952
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 14:38:14 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id t19so3976686qta.12
        for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679409493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9DVlCgRoSZ9XdR+Dy6Lh3PgMM9vzKokhgsg4QRxt5Aw=;
        b=Ii9vwY2OjmyAvNnxf+T08UQB+cF+jbbCZtE+3u0iN3aU/0+jauV4ZjMJebbSFttUPK
         hUYsjvQ0kbH3NJZhESF3Tr2JFGUWH80Hd9GG9kJSplusYknJKi2MeLejFpoZG4Fws6j7
         aYnqUk750Lm2vq5fA/R+jrxF8qvilvSThOZGCz/dsmgHeLlax1X4TErUYAbb5gK8Eexq
         lC/ZHY1ZIvfZRi7wpzKm0MIMuKGlgcJUiVXuvKLMhGgi+jWlT40mrIl6Zj6B1XoLBuyF
         aWBUOoty+Rxmw9HWXoMmA731Vj07RBjHP4lhxsZP/fxvbEr8xjH+MO4HXIzjTa0HSSMd
         015g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679409493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DVlCgRoSZ9XdR+Dy6Lh3PgMM9vzKokhgsg4QRxt5Aw=;
        b=rUoqtvjTUkFvh8ExEKBzsFGiNioF6hlGqUwAuV00pp3nlLi4+cwuINC37CAKB62I3a
         C+mRG2CvP/Gq6YvUWcYtWqlMXn/04D2m4VdcuTe9pZMb6wFR84KbWxetRvh/i26LEZUT
         dPDtomtVr7UhzZ4W7WWAK7+FOkmRZFvSpb4oGkppDbjx/Grzn5x702DLNqXBws/sY9qz
         Rk1bZzpCOVAxxXCMXf+5HqnF8tkVw9/4k5VtMi3byoG4I+nU5WjfpVBM35lsC5xiEd6B
         alNUGJozDDC24+lojdzTaA9Yp072CvQbSKqPKF1F7jHX3bqbtHzSzzQ5MXAtksfYmz3Y
         nKFQ==
X-Gm-Message-State: AO0yUKVqM0wRDi/PREp3wcDFTyByWIhMTMxYbGP1zCiPgfKxo17WB4o2
	0ZYkXbmg7c9injf/SDfF4HLnEg==
X-Google-Smtp-Source: AK7set+5mApLIf05UV9lI1WrSUTLqjn2u3xMtQ0MG3GtGOXeh/M+a5iOeRv/Y1L8h+HxYiW3FbYnTQ==
X-Received: by 2002:ac8:7d15:0:b0:3dc:ce21:6f87 with SMTP id g21-20020ac87d15000000b003dcce216f87mr191326qtb.11.1679409493048;
        Tue, 21 Mar 2023 07:38:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id z9-20020a376509000000b0074283b87a4esm2198697qkb.90.2023.03.21.07.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:38:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ped7r-000VWi-TM;
	Tue, 21 Mar 2023 11:38:11 -0300
Date: Tue, 21 Mar 2023 11:38:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steven Price <steven.price@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/rockchip: Add missing set_platform_dma_ops callback
Message-ID: <ZBnBU9OU4iV6CV0W@ziepe.ca>
References: <20230315164152.333251-1-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315164152.333251-1-steven.price@arm.com>

On Wed, Mar 15, 2023 at 04:41:52PM +0000, Steven Price wrote:
> Similar to exynos, we need a set_platform_dma_ops() callback for proper
> operation on ARM 32 bit after recent changes in the IOMMU framework
> (detach ops removal).
> 
> Fixes: c1fe9119ee70 ("iommu: Add set_platform_dma_ops callbacks")
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> This fixes a splat I was seeing on a Firefly-RK3288, more details here:
> https://lore.kernel.org/all/26a5d1b8-40b3-b1e4-bc85-740409c26838@arm.com/

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Do you know what state the iommu is left in after
rk_iommu_detach_device()? Ie is it blocking DMA or doing identity or
something else?

Jason
