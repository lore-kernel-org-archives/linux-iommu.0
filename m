Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83D52115
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 19:48:56 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id y7so1437427qtv.5
        for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 11:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VCsX8uc4cCu1oNFGRmQtZZmdp5RBV4+wTc8HN1xnvho=;
        b=e+cndpq5AbJCc9ropmy8+4Yd1TlOSMPwhQX6qeOHJmbJ4npOBH+R4Rgtl0Qp4/BK2G
         sJIdxB8UWVpBrXxGOV6Semfw2WkqB9XY+7S+V8VS+YyVe98F2na5c+Wsnj02XNGXg6Wt
         VYa2jZYY2i5Mre4MYmOrBY0C2RdWKQtTVUNLU3wnGoPuUYloUFmRibD39QKHMnFbcm8V
         4QAhBuLCMXHDygbkQhOBzebF5ckjucVjZvZGHA1xpp45CkDNmWJ/cOlPydNz7rM0XUEf
         PfKIszSirtyvvhSY0gdp7LZ0j2ohnw1RAbYfmVeuf7OixQXYvAGuFrUurJHwXwRv45wt
         kIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCsX8uc4cCu1oNFGRmQtZZmdp5RBV4+wTc8HN1xnvho=;
        b=uLO8HMEVJnTS+44bdEyAngfO8Q2I53KF3Dgx1Nko7rRExOCV1MenOnxWs9hkSBVREF
         /pmEfHNFGoaSOPk8pi5MvW+GXE9PWxUTzR1b47dT/y3pL4aeApJID+CzfP/GJzxDZJZ4
         V2sO3aq03UuLkAlTUSJF8+3n+aJWyFoF9u1vBgKjaR7JmZzk1Zrao1PqwaI1O7US2MF6
         nsSdZia2YfkPVx/ELVmvFmF7Ed/WBT+SkjnXC7NPn6AhT9twwNmyBkT0uNtkyfupNkIK
         s67KdCUhyasBe+gWqOCMlCifN6+e466lkiR+Wl3war9yS7w58zDsdxCjYuFm9nM8nawk
         FlyQ==
X-Gm-Message-State: AFqh2kqOt7+9zPsICUx4XjS4/G8M53ViwTABs1cNoHcD5KF+btEsqS5E
	059zuhJUW4e5ZIKAQn0p8dmfkQ==
X-Google-Smtp-Source: AMrXdXtm3RrwRr6RHb4naiD4l5n6+JmgDWK7TdiQX//Ern7jngXe0ppdvazLqngqV/8wLCwN25LO2g==
X-Received: by 2002:a05:622a:1e99:b0:39c:da1f:f817 with SMTP id bz25-20020a05622a1e9900b0039cda1ff817mr124418233qtb.61.1673639335588;
        Fri, 13 Jan 2023 11:48:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id az31-20020a05620a171f00b006fbbdc6c68fsm13212326qkb.68.2023.01.13.11.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:48:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pGQ2o-00AgoL-Fw;
	Fri, 13 Jan 2023 15:48:54 -0400
Date: Fri, 13 Jan 2023 15:48:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/fsl_pamu: Fix compile error after adding
 set_platform_dma_ops
Message-ID: <Y8G1puXtbsHrXZfn@ziepe.ca>
References: <20230113191528.23638-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113191528.23638-1-joro@8bytes.org>

On Fri, Jan 13, 2023 at 08:15:28PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The struct initializer for set_platform_dma_ops uses a semicolon as
> separator where a comma is required. Fix the compile error by using the
> correct separator.
> 
> Fixes: c1fe9119ee70 ("iommu: Add set_platform_dma_ops callbacks")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/fsl_pamu_domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I'd probably just squash these :\

Jason
