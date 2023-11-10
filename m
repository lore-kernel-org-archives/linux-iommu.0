Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8151C698
	for <iommu@lists.linux.dev>; Fri, 10 Nov 2023 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CRMA1DWD"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b3f938331fso1120102b6e.1
        for <iommu@lists.linux.dev>; Fri, 10 Nov 2023 07:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699629270; x=1700234070; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMq1v3p4HQgOttJjlBnBYwrQ6535gvD/7NO5PHEOGK4=;
        b=CRMA1DWDWv5wuRvh0VfsachJBUWFjGvMlR6nciBp7kHJDfHX7/KP6dbJdICQFI4NAj
         x1WPCFQ3vWE0Jec0NDrT5Pbl98q8i70t39OdF2AzO+PE/3fmsv2XyUiUW5vfLLgIq4ye
         U3skxk4Zph+8ceP0SQYc6q3RtuWX9fRim0xSJWDZzRHpgqNMS3zjEv8DtsZESfQRep6V
         c+8SbP8fMtBILmmmsCIlPXcfZVuBIU2Mx7Qfu2869dk3m+bnNfdQdbKM++c3dyHvNJxA
         qyDd5CxxeKMuvchZ0NrFMlyti64xkdGyUs6DHGfgIC6C4fznlTuKv3ejcf/LY8Vni5rJ
         2pGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699629270; x=1700234070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMq1v3p4HQgOttJjlBnBYwrQ6535gvD/7NO5PHEOGK4=;
        b=j2znF0a2B+bd2E21RH3V7oL0ziC8zNgfE0VILEq9YoZMowXJRa9wlS49Gb7sc2Bggs
         B2iQu/EMfQ5DZEScScsQc1UhDxlyTMt63AgD44W8JqyPeTwxGYVB9vGgrbcQYhGq3kaR
         IoazXl5TG1DukfIJyxFZ4jPVrmIaJpi+hgbM5zh68+BzH8URuxwxECbSj61COerF2ITf
         dzblhinTUdGM29a264HQHoEJEKuFMzzlwU2PzrKBOumiKZaxHBHMLjdOdtCteCrmnibC
         T/lMK0lkxjQF8erEJXOcxX9J16EAYslyc7KE/1eGpMauUoyKS6PVxjMKAPo2ZfXANv65
         17PQ==
X-Gm-Message-State: AOJu0YwcMJMhfeqNpvOTqug0WzFGbQeIyEAVtFYfvmci10CwFk/N/MIf
	H1QPfczfmxew/ZrlpERNI8o8eQ==
X-Google-Smtp-Source: AGHT+IGuh1b5v1kCUEbOXbs/awEXDd6LUow2Eg27ekh7iqFCop1h457YmE1lrZUZmqI+kjyq/ulirA==
X-Received: by 2002:a05:6808:2222:b0:3b2:f4a2:e7fc with SMTP id bd34-20020a056808222200b003b2f4a2e7fcmr1398117oib.25.1699629269804;
        Fri, 10 Nov 2023 07:14:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id x12-20020a05680801cc00b003b2e4754cc2sm413795oic.26.2023.11.10.07.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 07:14:29 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r1TDI-001w4a-6x;
	Fri, 10 Nov 2023 11:14:28 -0400
Date: Fri, 10 Nov 2023 11:14:28 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Rob Clark <robdclark@gmail.com>,
	Gaurav Kohli <quic_gkohli@quicinc.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] iommu: Allow passing custom allocators to pgtable
 drivers
Message-ID: <20231110151428.GJ4634@ziepe.ca>
References: <20231110094352.565347-1-boris.brezillon@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110094352.565347-1-boris.brezillon@collabora.com>

On Fri, Nov 10, 2023 at 10:43:50AM +0100, Boris Brezillon wrote:
> Hello,
> 
> This patchset is an attempt at making page table allocation
> customizable. This is useful to some GPU drivers for various reasons:
> 
> - speed-up upcoming page table allocations by managing a pool of free
>   pages
> - batch page table allocation instead of allocating one page at a time
> - pre-reserve pages for page tables needed for map/unmap operations and
>   return the unused page tables to some pool

Why would these topics be unique to GPU drivers as a user?

Shouldn't improving the allocator in the io page table be done
generically?

> A real example of how such custom allocators can be used is available
> here[1]. v2 of the Panthor driver is approaching submission, and I
> figured I'd try to upstream the dependencies separately, which is
> why I submit this series now, even though the user of this new API
> will come afterwards. If you'd prefer to have those patches submitted
> along with the Panthor driver, let me know.

Patches like this should come with users, but I think you should
refocus this effort to improving the io pagetable itself not allowing
a GPU driver to replace its insides. That seems like a cop-out.

Jason
