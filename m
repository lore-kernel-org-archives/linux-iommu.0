Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D82823CE
	for <iommu@lists.linux.dev>; Mon, 15 Apr 2024 21:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217486; cv=none; b=CUtP+VE06nd2JfB4dsWUC1mRlus5+VD/Wvp/yQaLGm/Ds/NX18STubQ4bBlTBf2iJ0B4FrWSkfCD1MiPu2dTNHwFhGTBpefeHSv+D1C6U5NKzf5dCc1CoQOj61CrDclcn3FfCJl55WLVH7PZeRY+UFqyp+P5gqvgWeOiNKEIei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217486; c=relaxed/simple;
	bh=YaVEnL7fTVUDsWoGF3mIRRcFiRd8xm30iOoRq9T0wwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6vEY8cdhemGtKs0YPZafW6C62PBRTu5C1UvfxubXfLLT0rzvVzaUfMzmPK8u/ir2/sCStW6PIsGkHad2XGtOa6h6fmzyFGQe6rbPAC9bVrRY3RKx7aoPN9HDiRZmlz/UlTBIdAJexckfYOg163miCw+gr/I9MIMRKOqIdSTfr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 574E32F4;
	Mon, 15 Apr 2024 14:45:12 -0700 (PDT)
Received: from [10.57.19.68] (unknown [10.57.19.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FF4B3F738;
	Mon, 15 Apr 2024 14:44:42 -0700 (PDT)
Message-ID: <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com>
Date: Mon, 15 Apr 2024 22:44:34 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
To: Eric Wagner <ewagner12@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
 <20240415163056.GP223006@ziepe.ca>
 <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-15 7:57 pm, Eric Wagner wrote:
> Apologies if I made a mistake in the first bisect, I'm new to kernel
> debugging.
> 
> I tested cedc811c76778bdef91d405717acee0de54d8db5 (x86/amd) and
> 3613047280ec42a4e1350fdc1a6dd161ff4008cc (core) directly and both were good.
> Then I ran git bisect again with e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
> as the bad and 6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3 as the good and the
> bisect log is attached. It ended up at the same commit as before.
> 
> I've also attached a picture of the boot screen that occurs when it hangs.
> 0000:05:00.0 is the PCIe bus address of the RX 580 eGPU that's causing the
> problem.

Looks like 59ddce4418da483 probably broke things most - prior to that, 
the fact that it's behind a Thunderbolt port would have always taken 
precedence and forced IOMMU_DOMAIN_DMA regardless of what the driver may 
have wanted to say, whereas now we ask the driver first, then complain 
that it conflicts with the untrusted status and ultimately don't 
configure the IOMMU at all. Meanwhile the GPU driver presumably goes on 
to believe it's using dma-direct with no IOMMU present, resulting in 
fireworks when its traffic reaches the IOMMU. Great :(

However the other notable thing that also happened between 6.6 and 6.7 
was the removal of the AMD iommu_v2 code, so there's some possibility 
that the GPU driver still may have only been working before due to that 
also subverting the default domain with its own identity domain, so 
whether it would actually work again with 
iommu_get_default_domain_type() sorted out is yet another question... As 
a first step I'd test the quick hack below, but be prepared for things 
to still break slightly differently.

Cheers,
Robin.

----->8-----
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 996e79dc582d..063e1eb32fbd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1774,7 +1774,7 @@ static int iommu_get_default_domain_type(struct 
iommu_group *group,
  				untrusted,
  				"Device is not trusted, but driver is overriding group %u to %s, 
refusing to probe.\n",
  				group->id, iommu_domain_type_str(driver_type));
-			return -1;
+			//return -1;
  		}
  		driver_type = IOMMU_DOMAIN_DMA;
  	}
