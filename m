Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4CF12B83
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 15:35:52 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-40e268fe7ddso33753981cf.3
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 08:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691508952; x=1692113752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=473CqHc/PxOWz4U7yZYFf0ch/8FPP3OC9NEc7IoxEfE=;
        b=V56Y2GI2M40uUWYPpJic7pxygW9MAe7KCmaaIkT9dx417oeibQTSIE3xmcp/TIfE/4
         NI1Lfic9jwKfsO491jwXn9iSeyNLnND2rHJ5vKLfzGBL/d1PEJQIBqeqoTErymTj2zNS
         2cErKjdsa7ptIBW4MX7gQz8a2vUH//XEoerjqt0iFtNJ2YhscSQr5dUuk/Nruh36Ae/m
         yN8Ea5jYqRfvGtwH7ahB039OYlgJMsOH1yrbPhYRyw+aKMeVvKS+THboE1RT+eRBiun3
         HUkoCIt4KAZbwhUXeXiO0dphzUkij9oj0GOYRauQCVSd0tnXHUPdDE7utdlfP9YTYA/R
         24WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691508952; x=1692113752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=473CqHc/PxOWz4U7yZYFf0ch/8FPP3OC9NEc7IoxEfE=;
        b=lBwNDQK8r7uwQA0II5s5jyQBUsyTD13ZcHoBowC8YqAC1xvg+AjWpit2VMyRwoktHx
         vlsR1tl/NAs/WGWIsBNzsQJA9+a23NjU07KMgUQ42HXohyyc91ClnAVZ4WpJ0n5PdSEJ
         ZXPto5XxVDXaS0+XuRX4tAonqOKhiGW7FPWZZVIQ30FwuSARDaMCs9g9Ea3vit+1RI7P
         xt93y6sqx2QurFB1HouqCqWUJXrcrEotsSBRJD2IcCFUvJ6u5Cd4Es/oic58J/Re4dH3
         Bpwf0/ejDbGZyRPYdwR0a3xQaX8KXo8CoMJAlRET+pOdY3k96OZbJKBgqiHssltRXap/
         uuuA==
X-Gm-Message-State: AOJu0YxON0ISTMj0EviMbqSC2ewxDJ2L5nYPCPxaTXKc94MyR9toNLgA
	37KifguUSFKNixNYwbl0RnHRAg==
X-Google-Smtp-Source: AGHT+IFTdf0xPfmFF8WhUj+1oRoLwgGIaWVWNoa78EdhdQ2N4Z1pb7Zl7RSIsMBqi+QvVpPG/EaXWQ==
X-Received: by 2002:ac8:7d03:0:b0:40c:63d1:7bd6 with SMTP id g3-20020ac87d03000000b0040c63d17bd6mr118450qtb.34.1691508951881;
        Tue, 08 Aug 2023 08:35:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id iv8-20020a05622a6f0800b004055c555d2dsm3381589qtb.21.2023.08.08.08.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:35:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTOkQ-004dOo-W9;
	Tue, 08 Aug 2023 12:35:51 -0300
Date: Tue, 8 Aug 2023 12:35:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH 04/11] iommu/amd: Use protection_domain.flags to check
 page table mode
Message-ID: <ZNJg1mUd+WXBDVaD@ziepe.ca>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-5-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808100232.5977-5-vasant.hegde@amd.com>

On Tue, Aug 08, 2023 at 10:02:25AM +0000, Vasant Hegde wrote:
> Page table mode (v1, v2 or pt) is per domain property. Recently we have
> enhanced protection_domain.pd_mode to track per domain page table mode.
> Use that variable to check the page table mode instead of global
> 'amd_iommu_pgtable' in {map/unmap}_pages path.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This is OK, but IMHO, it is much better to provide different ops for
the v1/v2 page table map/unmap functions since they don't really share
any code.

eg having a function pointer that does nothing other than call another
function pointer:

	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
	if (ops->map_pages) {
		ret = ops->map_pages(ops, iova, paddr, pgsize,
				     pgcount, prot, gfp, mapped);
	}

Is quite inefficient these days. If you start with a map_pages_v2
domain op then you can just directly call iommu_v2_map_pages().

We did alot of work on the core side to enable this.

Jason
