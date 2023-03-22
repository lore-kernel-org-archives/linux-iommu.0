Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC5328FC
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 12:50:05 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id x8so12040862qvr.9
        for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 05:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679489404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w7gE8texmE3DXA6Si9qcI9IbQl6PzfIzMyuDdUR1aGM=;
        b=Zmsb6zCFzu/kmtgX9pgfKoiphZnKawAnRXfkkAM6tgS4xNN/QcVxADZ/FRRGWXnrab
         J2f5Eoq2GgYVO/M0SALVmy0xbQZb+iixEPkCyuWoBOPZe5PVSC2wjTV8ZTKnWzTXa2lz
         gaRUjJsv1G8VfJ8UJbkgyRpko0RTono1j5VeDpU0+C7AMiRrGBNYFMm/M9QoVEfH3BXp
         oHNqoN4L6EjXEXlE20euDUiPvzvLQAmAMIY4mxt7ztSVV7e7vJchdolzra66iFm4RTOb
         poH15Jsrv6+Q/QNzzeWqctmZFEF18GsTKFsjRJm7XpHEnZk/x8DO9KzfiaynQJg2oKW3
         k/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7gE8texmE3DXA6Si9qcI9IbQl6PzfIzMyuDdUR1aGM=;
        b=5N8OJrKSToNMu3Zb4Mjo4shiz6lbZodHREPG3GXhWzggjxH+G3IPlPPV3PLJL/wmPq
         MshulZra2spCMjy6ZAOxGG1CxRM6qbyPPB8qe1F0WONPonB2qS9RdLhWkyWErOtJRjLn
         OqoWhd3fa1t2IqfPj8NQjpG4JT8yO9yMpPIdQxmF62CHoQo0lRTmtQ7ojN/XTEGT21w6
         qr3nDjifJuaieLWUoPp3H8kPNhMe6RB2qz9QbH3I7O0btsiy6EYSnVu48jKwrZLh/JsD
         yaEkh7hEjiag4g/ymsyd9ZclIBoJ4vMWC0WlKewTwhIJq5J4ybeK+N7hivrxSpZGlvaB
         bZtg==
X-Gm-Message-State: AO0yUKXqhnoYRZawoB4w8M23GhS7zNeRwcV0OvVyj3LzZ3s5Ww9+nCp4
	vFJJgYcq/KrR4Osr7tp345+ccg==
X-Google-Smtp-Source: AK7set+VnGTjKIIgaUl7XLaK5Bz0mAnMGv9q8V5I9Mle27qkRgJWN3VPYUoIH6BqWcnLhci14N1fww==
X-Received: by 2002:a05:6214:acd:b0:5ac:77ef:f76 with SMTP id g13-20020a0562140acd00b005ac77ef0f76mr5491411qvi.44.1679489404535;
        Wed, 22 Mar 2023 05:50:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id c68-20020a379a47000000b00746aa080eefsm1655211qke.6.2023.03.22.05.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:50:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pexul-000mfl-Ct;
	Wed, 22 Mar 2023 09:50:03 -0300
Date: Wed, 22 Mar 2023 09:50:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steven Price <steven.price@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/rockchip: Add missing set_platform_dma_ops callback
Message-ID: <ZBr5e6tn1i7EE/16@ziepe.ca>
References: <20230315164152.333251-1-steven.price@arm.com>
 <ZBnBU9OU4iV6CV0W@ziepe.ca>
 <85607806-b888-2d5e-67a4-e9d63ebd1976@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85607806-b888-2d5e-67a4-e9d63ebd1976@arm.com>

On Wed, Mar 22, 2023 at 09:02:41AM +0000, Steven Price wrote:
> On 21/03/2023 14:38, Jason Gunthorpe wrote:
> > On Wed, Mar 15, 2023 at 04:41:52PM +0000, Steven Price wrote:
> >> Similar to exynos, we need a set_platform_dma_ops() callback for proper
> >> operation on ARM 32 bit after recent changes in the IOMMU framework
> >> (detach ops removal).
> >>
> >> Fixes: c1fe9119ee70 ("iommu: Add set_platform_dma_ops callbacks")
> >> Signed-off-by: Steven Price <steven.price@arm.com>
> >> ---
> >> This fixes a splat I was seeing on a Firefly-RK3288, more details here:
> >> https://lore.kernel.org/all/26a5d1b8-40b3-b1e4-bc85-740409c26838@arm.com/
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Thanks for the review.
> 
> > Do you know what state the iommu is left in after
> > rk_iommu_detach_device()? Ie is it blocking DMA or doing identity or
> > something else?
> 
> To be honest I really don't know for sure. But from my small
> understanding of the code: rk_iommu_detach_device() ends up in
> rk_iommu_disable_paging() which appears to switch to identity mode
> ("Disable memory translation").

Can you consider writing this patch like this instead:

https://lore.kernel.org/linux-iommu/ZBnef7g7GCxogPNz@ziepe.ca/

?

I'd much rather we move toward clearly documenting what is going on
with the HW and remove this undefined "detach" language.

Jason
