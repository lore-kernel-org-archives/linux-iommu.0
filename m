Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591177464
	for <iommu@lists.linux.dev>; Tue, 16 Apr 2024 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713227949; cv=none; b=MBsiSxOZkcJGdWt19bSVpoKmJBcfoYL+yX14h5R3awG1rDMYjJE+vAtk3jFa6F8aIHTYd6yUl7Fu9hcNKseWVdKrWH0NnE9amLgf7CG0BGhihxvaAlx47y5f1dGPyZZqTDJjj8aBjrmVsG4n+UQXRQsneT75SWE4FPVL93jG2d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713227949; c=relaxed/simple;
	bh=d2bYC2KeiHUqcBLgPzBPOh3gasiU0kpLQmM6QaRtQO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCgWbLHMW6OLEoHloMobQe0k1n3dObXDR52I1SLC5+g8UpdnXLSylwKKauUIe9UhARXhi8FbIkgOj0yorWaDmv/Win8pUYmHVG5YuOUfbzJ68bxOBLmZ7OBNVXvA0PiqOLCG/CzQsVOHHeTeSXgtKGZ4sLIWLLJlWxaIvpPxEgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XvIt/gwX; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XvIt/gwX"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78d5b1a34fdso259007185a.2
        for <iommu@lists.linux.dev>; Mon, 15 Apr 2024 17:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713227945; x=1713832745; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SC+OXs/GZF0u24XHwRAC3c8xEl57m2qiEJ4YV7msZrY=;
        b=XvIt/gwXc5fcgvoBSAN/prDtjpyjBu+11bZHA7eWrR9KxaGQ81kRagaLRddvnxY5/P
         853763NZiL1k9Zxdy+wqVxr/ebioYmbQQJXufe3w/SuNfs2nDzZqSyx6CvLEyE9MzOPn
         oahRBqiMZVyUlGs0zdxt0nxy5ZmgEHeXXNU8YckBVXdhWlBbYKcSe5SYxEJe3wEhWOq4
         cVNIYQJn07GxhmtnTUgWLK5KrakxyXGT89nPCLY22McZpxiJ3aTEZerrEIcVK9KkVJNn
         NTb41+0c2ajC8KwD6s4d7fzXI8e+UxVwHZPqMu6MaxqEwr0pRoZVeYFWyWK9NO3Ov4CB
         KvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713227945; x=1713832745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC+OXs/GZF0u24XHwRAC3c8xEl57m2qiEJ4YV7msZrY=;
        b=mTGy8ca9MxqdRbfcoXRknCnHYbbMp5zgh1tSwH2WlUI0BiA2UzpqD1PVY/zjNUlDtN
         U3RwloftvTiR8Np/F6OS9In2l8Il7OanuGqlQytc4KnJjJcooyMvZ7RoFD346KjoGI6C
         VKzt3dE2T26x/ZOjyN3Ohr6mVXzLrNzWmNS742KIUUh8bnee3H4Dy5mpbQqlD/jSQGyj
         MGM1cwzFjhksc7VzukfmhFJdvDcgNR1EIVL3mMsl2Fu4KsqGFq7kDo7ICQ80G+jTd9Nl
         diHwPnYSfdWvCKOvYxf2eyTi3oJKqfg+EZOOAKizIlCfjq/g1CKTS727suaJAY/CFBji
         /DEg==
X-Forwarded-Encrypted: i=1; AJvYcCUeLaGfQghQk7ucPRFs5XJDS+1f+chb/DszKUIwvhtC0u6jgd9PRTzaWAojDkyMdivGt5ocny2Rew5iIkXHRQr9D0uZTy8=
X-Gm-Message-State: AOJu0Yy99tKopXIojAaTEIzg4h5A/2gIzH7ZozqaFK/plI8jp6upshEr
	j65ohaz8Su6TtcM89cP0LEPWRf12WNAee7Ai3n4OWu6K1WlEMzd3CpEH7cDLAk4=
X-Google-Smtp-Source: AGHT+IGZ3ByVJiZA7dsHED891rzWwy7eaTLceOAgh8WUU2Lful6iQcmJWnPlR6lkZm6ffVA/3NK9Aw==
X-Received: by 2002:ad4:58d1:0:b0:69b:1c78:158d with SMTP id dh17-20020ad458d1000000b0069b1c78158dmr10582744qvb.53.1713227945150;
        Mon, 15 Apr 2024 17:39:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id fb20-20020ad44f14000000b0069b4fe0569fsm6341395qvb.109.2024.04.15.17.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 17:39:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rwWql-007FhP-RG;
	Mon, 15 Apr 2024 21:39:03 -0300
Date: Mon, 15 Apr 2024 21:39:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Cc: Eric Wagner <ewagner12@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
Message-ID: <20240416003903.GR223006@ziepe.ca>
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
 <20240415163056.GP223006@ziepe.ca>
 <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
 <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com>

On Mon, Apr 15, 2024 at 10:44:34PM +0100, Robin Murphy wrote:
> On 2024-04-15 7:57 pm, Eric Wagner wrote:
> > Apologies if I made a mistake in the first bisect, I'm new to kernel
> > debugging.
> > 
> > I tested cedc811c76778bdef91d405717acee0de54d8db5 (x86/amd) and
> > 3613047280ec42a4e1350fdc1a6dd161ff4008cc (core) directly and both were good.
> > Then I ran git bisect again with e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
> > as the bad and 6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3 as the good and the
> > bisect log is attached. It ended up at the same commit as before.
> > 
> > I've also attached a picture of the boot screen that occurs when it hangs.
> > 0000:05:00.0 is the PCIe bus address of the RX 580 eGPU that's causing the
> > problem.
> 
> Looks like 59ddce4418da483 probably broke things most - prior to that, the
> fact that it's behind a Thunderbolt port would have always taken precedence
> and forced IOMMU_DOMAIN_DMA regardless of what the driver may have wanted to
> saywhereas now we ask the driver first, then complain that it conflicts
> with the untrusted status and ultimately don't configure the IOMMU
> at all.

Yes, if the driver wants to force a domain type it should be
forced. Driver knows best. Eg AMD forces IDENTITY when the HW/driver
is incapable of supporting otherwise.

> Meanwhile the GPU driver presumably goes on to believe it's using dma-direct
> with no IOMMU present, resulting in fireworks when its traffic reaches the
> IOMMU. Great :(

I wonder where is the missing error handling.. iommu probe failure
should not go on to allow driver attach, there is no guarentee any DMA
works now that many iommus are booting up in BLOCKED.

> However the other notable thing that also happened between 6.6 and 6.7 was
> the removal of the AMD iommu_v2 code, so there's some possibility that the
> GPU driver still may have only been working before due to that also

Most likely it is the above change interacting with this patch when
they are both combined in the merge:

commit 92e2bd56a5f9fc44313fda802a43a63cc2a9c8f6
Author: Vasant Hegde <vasant.hegde@amd.com>
Date:   Thu Sep 21 09:21:45 2023 +0000

    iommu/amd: Introduce iommu_dev_data.flags to track device capabilities
    
@@ -2471,7 +2481,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
         *    and require remapping.
         *  - SNP is enabled, because it prohibits DTE[Mode]=0.
         */
-       if (dev_data->iommu_v2 &&
+       if (pdev_pasid_supported(dev_data) &&
            !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
            !amd_iommu_snp_en) {
                return IOMMU_DOMAIN_IDENTITY;

Which, IIRC, was intended to be temporary to work around limitations
in the DTE programming logic within the driver. Previously iommu_v2 as
a module option that Eric probably doesn't set, I guess.

The below will probably make it boot, but Vasant should check what
happens if PASID is eventually attached too.

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d35c1b8c8e65ce..f3da6a5b6cb1cb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2758,11 +2758,16 @@ static int amd_iommu_def_domain_type(struct device *dev)
         *    and require remapping.
         *  - SNP is enabled, because it prohibits DTE[Mode]=0.
         */
-       if (pdev_pasid_supported(dev_data) &&
-           !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
-           !amd_iommu_snp_en) {
+       if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT) && !amd_iommu_snp_en)
+               return IOMMU_DOMAIN_IDENTITY;
+
+       /*
+        * For now driver limitations prevent enabling PASID as a paging domain
+        * on the RID together.
+        */
+       if (dev_is_pci(dev) && !to_pci_dev(dev)->untrusted &&
+           pdev_pasid_supported(dev_data))
                return IOMMU_DOMAIN_IDENTITY;
-       }
 
        return 0;
 }

Jason
