Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19089134BE
	for <iommu@lists.linux.dev>; Thu,  9 May 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275492; cv=none; b=ZFVtq2il2iZlKAJBHt0CyVR6UM7r3VHUsLaW3rWdpTwAj9SRSN8mGyjIOcGOl9eQ3QeFwJXavBj+OYDgGKIxtpAWRwG7OhFC53KmfLyFvdCmmWQHA8lkTZgQGZHxnvHV/kCoLfuwJHO8foinaaKIzxdTN6+n94b9Lm+Y3KZKZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275492; c=relaxed/simple;
	bh=BfvNu7u5zEXtNHSnM2iaOFRez3vkVrs3uX/KIxs7kAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=paRYxk9DYZhFsEJihGYY/III0Q4DrPzcLA83JWtXG5tLf/JT9GV8PeTEsY/lLVXbyhF4I82TUx8XiaK2U1WGXSclXDaO8jy0CgwOp2cm1PLDljb5cvCVa0FM6ZgqyGi7ANGUAc5hkII8XyUTdU5VA/299byZrr1pwS9OJJeN6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kc0mXtqy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kc0mXtqy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715275490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dN3mVDgSm5aZZcDfFdyE7HVjIbcX8OOP6lyXBu9YxD8=;
	b=Kc0mXtqyU7Lc0eYJSWh+nA6A10bWpCVJs0thcAZYyqGf3bKX88FMngRTreVia/uhLNotp/
	ZOtIFj5qAn2wtx8Yea0kSnxuPlf7YaePFmf2tAB162rh3s280Dh/qOOIJFCA/V/1z4ZMrC
	C8RR8TsxpX/7U9tXuYk40M+eTrxE+ls=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-uFiAFJyvPreKh3isLYxnMg-1; Thu, 09 May 2024 13:24:48 -0400
X-MC-Unique: uFiAFJyvPreKh3isLYxnMg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3c84dc9a073so1041919b6e.1
        for <iommu@lists.linux.dev>; Thu, 09 May 2024 10:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715275488; x=1715880288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dN3mVDgSm5aZZcDfFdyE7HVjIbcX8OOP6lyXBu9YxD8=;
        b=eFQ6r9it7pR3ECiMzwOUHRwomRhNkTs7PdZtb0LKe9L/plCFO+T2PPs9eMkgZzzNZ5
         s+LAAjYmZhy8Iv+FNXGKyifFqe5IXImtOUORqKrnnFZF2SGom5y7OS7UtRlOyQLJLX6+
         gmDN0xEBsBIwQgRAk4VeqaYFhAHtYBt3dlV1cv3aNXdB7d4Qc/gNV6/gXWSmpEWihYx2
         +rfedq040V2JHEpLjF2OIiLPX6MGLHa7Qsx0zCjpgksCYs2xGv3qKiS6/K/aFLzsL432
         lZfb9amH5VEmJoZ+70r3VUY9akO7QXpGA1/W+MvV9Iiv5K2G2KlFoXHBwgDFHTVMKo5o
         /8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSPqbkjT/fgPiWtRMD0oP7BBAoDymPYSGxUPixkBR3qIq1EM8hsENiRiaK+pJdkIAwrQOhc8F2rInP8+H2aDELkmVlGsY=
X-Gm-Message-State: AOJu0Yx3dQibkY3VAfg7C9bmiPLT9EHEbPYWzIqIPLY0AOAbyiFnLOyI
	fXOsatd99Hg3k7CBlyol68G2zcIPl2d0kQuywuUi3VlWXT1Q1SDkKgSOp+twJa6FqueNdXRh+DB
	hHc0WUqnpJzX7u5sekZ40/eDlXsoiwllo3LF0OtPcj7CVzp5LIxRP
X-Received: by 2002:a05:6808:220f:b0:3c5:f4b3:e0e3 with SMTP id 5614622812f47-3c9970bd300mr286219b6e.41.1715275488072;
        Thu, 09 May 2024 10:24:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERz9OZu4Vs0+Z3gt8paCkYjhtvrP89WeQpg9/Q+iVvg3dEPqiQQVKKTjLpRqPe+HAnl2n43g==
X-Received: by 2002:a05:6808:220f:b0:3c5:f4b3:e0e3 with SMTP id 5614622812f47-3c9970bd300mr286195b6e.41.1715275487718;
        Thu, 09 May 2024 10:24:47 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f194babsm8827836d6.62.2024.05.09.10.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 10:24:46 -0700 (PDT)
Date: Thu, 9 May 2024 10:24:45 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Subject: Re: Oops on nvidia orin system booting the eln 6.9-rc7 kernel
Message-ID: <jto5e3ili4auk6sbzpnojdvhppgwuegir7mpd755anfhwcbkfz@2u5gh7bxb4iv>
References: <cxrm4bwy6knoex6orhxv5hgpni5hfi2tlcxzds7grk2hfto5ej@6r3cvm7kxkp7>
 <20240509171653.GU4718@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240509171653.GU4718@ziepe.ca>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 09, 2024 at 02:16:53PM GMT, Jason Gunthorpe wrote:
> On Thu, May 09, 2024 at 09:55:27AM -0700, Jerry Snitselaar wrote:
> 
> > [    6.477091] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000120
> > [    6.485896] Mem abort info:
> > [    6.488782]   ESR = 0x0000000096000004
> > [    6.492721]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [    6.498057]   SET = 0, FnV = 0
> > [    6.501209]   EA = 0, S1PTW = 0
> > [    6.504358]   FSC = 0x04: level 0 translation fault
> > [    6.509345] Data abort info:
> > [    6.512144]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> > [    6.517657]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > [    6.522906]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [    6.528422] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000107c9f000
> > [    6.534984] [0000000000000120] pgd=0000000000000000, p4d=0000000000000000
> > [    6.541638] Internal error: Oops: 0000000096000004 [#1] SMP
> > [    6.547237] Modules linked in:
> > [    6.550386] CPU: 1 PID: 47 Comm: kworker/u25:0 Not tainted 6.9.0-0.rc7.58.eln136.aarch64 #1
> > [    6.558609] Hardware name: Unknown NVIDIA Jetson Orin NX/NVIDIA Jetson Orin NX, BIOS 3.1-32827747 03/19/2023
> > [    6.568147] Workqueue: events_unbound deferred_probe_work_func
> > [    6.574187] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    6.581183] pc : nvidia_smmu_context_fault+0x1c/0x158
> > [    6.586433] lr : __free_irq+0x1d4/0x2e8
> > [    6.590196] sp : ffff80008044b6f0
> > [    6.593607] x29: ffff80008044b6f0 x28: ffff000080a60b18 x27: ffffd32b5172e970
> > [    6.600694] x26: 0000000000000000 x25: ffff0000802f5aac x24: ffff0000802f5a30
> > [    6.608045] x23: ffff0000802f5b60 x22: 0000000000000057 x21: 0000000000000000
> > [    6.615222] x20: ffff0000802f5a00 x19: ffff000087d4cd80 x18: ffffffffffffffff
> > [    6.622483] x17: 6234362066666666 x16: 6630303078302d30 x15: ffff00008156d888
> > [    6.629834] x14: 0000000000000000 x13: ffff0000801db910 x12: ffff00008156d6d0
> > [    6.637096] x11: 0000000000000003 x10: ffff0000801db918 x9 : ffffd32b50f94d9c
> > [    6.644269] x8 : 1fffe0001032fda1 x7 : ffff00008197ed00 x6 : 000000000000000f
> > [    6.651532] x5 : 000000000000010e x4 : 000000000000010e x3 : 0000000000000000
> > [    6.658619] x2 : ffffd32b51720cd8 x1 : ffff000087e6f700 x0 : 0000000000000057
> > [    6.665884] Call trace:
> > [    6.668332]  nvidia_smmu_context_fault+0x1c/0x158
> > [    6.673058]  __free_irq+0x1d4/0x2e8
> > [    6.676558]  free_irq+0x3c/0x80
> > [    6.679707]  devm_free_irq+0x64/0xa8
> > [    6.683209]  arm_smmu_domain_free+0xc4/0x158
> > [    6.687669]  iommu_domain_free+0x44/0xa0
> > [    6.691432]  iommu_deinit_device+0xd0/0xf8
> > [    6.695457]  __iommu_group_remove_device+0xcc/0xe0
> > [    6.700445]  iommu_bus_notifier+0x64/0xa8
> > [    6.704470]  notifier_call_chain+0x78/0x148
> > [    6.708671]  blocking_notifier_call_chain+0x4c/0x90
> > [    6.713484]  bus_notify+0x44/0x70
> > [    6.716719]  device_del+0x264/0x3e8
> 
> Oh - probably this?
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> index 87bf522b9d2eec..957d988b6d832f 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> @@ -221,11 +221,9 @@ static irqreturn_t nvidia_smmu_context_fault(int irq, void *dev)
>         unsigned int inst;
>         irqreturn_t ret = IRQ_NONE;
>         struct arm_smmu_device *smmu;
> -       struct iommu_domain *domain = dev;
> -       struct arm_smmu_domain *smmu_domain;
> +       struct arm_smmu_domain *smmu_domain = dev;
>         struct nvidia_smmu *nvidia;
>  
> -       smmu_domain = container_of(domain, struct arm_smmu_domain, domain);
>         smmu = smmu_domain->smmu;
>         nvidia = to_nvidia_smmu(smmu);
> 

Yeah, that is probably it. I'll let you know in just a bit.

Regards,
Jerry

