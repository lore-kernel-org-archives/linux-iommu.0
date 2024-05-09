Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE094DF6B
	for <iommu@lists.linux.dev>; Thu,  9 May 2024 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275020; cv=none; b=Tdn73zpw6hSHr4Szvb7ZwjJwXtvGK4NkIzOISETABn/qRM1lIt9AgiGyzSddYmrODTX7jpbL9Xn0uv69jbRiyM/qW1OfWPl2VcC4Vhq/TQ+7vASyBTSoIL+yuavwVJlv8IYnleCukwtP61eYe/QNSLYrQyWWYKqUJXjRAMG3evw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275020; c=relaxed/simple;
	bh=HA3KAVom7jfnDPddamKjaOxWlwtw6fgp6133HvKrjjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gm4YpbLDX3Nw8Fjb2t1HoerOAY3Wzthi137nstoGO0dXTaKdUdlUBEz8HxTLmh1Rag9kuznOKAp917ii4vmKh0g3M4eZgBwkroVJy91e06o4JS5xInkg3iRp/pdIgRym8gMdiNeh5rCQpaPjDedlhhj+VLq1jHp97gpwsupAujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RHZMgjm3; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RHZMgjm3"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-434c695ec3dso6661481cf.0
        for <iommu@lists.linux.dev>; Thu, 09 May 2024 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715275015; x=1715879815; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RwQreOzhXHJrVUevh2977wFJC3czV25Uu0/5wtouhJA=;
        b=RHZMgjm3ZEY+1TZU7yn13gZ9F58e8uaWujPKIiAXN+IE5Nk1SaDVVYoXH13m3mQzq2
         XNiy9WHjcgGRFc2j27c9aUbUWeQYtZbcbsHZ/i9NrhAeCXUIIl0VpPgxdzNFMCV6Yy8H
         nfctTPzl9YP69nSMxE7Vfv+hCy0SiRs69ktJ89L/zY8XhD23VleW2mzJp3DG207LB12O
         RS4ykhyQiffuuDj7yFGumtaoJWElQChU2EemQtcEAQT4gytc61wK1d95mxmfnhL8Kr3A
         ydWnd+fmGECXMhOj/MN9c4+3guG5g/FjeP/CYGCpmIfG/k5JbYUQs5CsjuOfqrLyuK9V
         UHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715275015; x=1715879815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwQreOzhXHJrVUevh2977wFJC3czV25Uu0/5wtouhJA=;
        b=usgcV39lXgJ8OiXbdTho2fRtEJAiGg6i3AlH/Hia3slLoG/duVyhXMc7s3+or0mkt+
         MX/iCiVoNZpuGKSRgUIcl4ADzLNPnpjv5WIUNlJoC6PYI07G/1U+s8JIe5geKTKeeTMg
         nNIzWFzwTWizwUWnd1c2SQcjlF80RDHt6xKmp+Hs2u5ABoJ881d4xXE28pLJfMsnJeAK
         Ywm7dE+6OcA8i5qozCSiXLy51KrjhL9zwn2/r2pzb1gUNfLjembmbys9rR6NGRGZYyZ2
         psqFkIqrCCfWaC290V/nrSeJUCz+JLgWwRO8sp4zdzZ46bvx5QciR3QMywVGFP/nVN+Q
         gHyA==
X-Forwarded-Encrypted: i=1; AJvYcCWMRlJADrI+5R/hxNcLYm4xJsRs++gAHVHY+JvlGqZ5/J8S3SRlviVoaWQHUzGAyfGLYq0KmjidGf/nzgdttVVlbSiXt60=
X-Gm-Message-State: AOJu0Yygj16gGfDTIZsayj/Cm7AxLKNIajlq5mKghAHM4CTvwGQ5mhzK
	DBBmGddCQXIQTAIz9AQAH81EesB5bLzSVjiK/c0eYzF5Ql4YXAYNw2ewgMCuvJs=
X-Google-Smtp-Source: AGHT+IGUGemdGmfh6nkzVJ/1i6GxrzTRH567qibwlR5DG9fSEg68mrBJtnX0BfB/qYhWAOzWMBebFA==
X-Received: by 2002:a05:622a:6089:b0:43d:f4d0:1c2a with SMTP id d75a77b69052e-43df4d01f6emr26329791cf.55.1715275015566;
        Thu, 09 May 2024 10:16:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54b5983sm10366361cf.18.2024.05.09.10.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 10:16:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s57O1-004l4f-LN;
	Thu, 09 May 2024 14:16:53 -0300
Date: Thu, 9 May 2024 14:16:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Subject: Re: Oops on nvidia orin system booting the eln 6.9-rc7 kernel
Message-ID: <20240509171653.GU4718@ziepe.ca>
References: <cxrm4bwy6knoex6orhxv5hgpni5hfi2tlcxzds7grk2hfto5ej@6r3cvm7kxkp7>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cxrm4bwy6knoex6orhxv5hgpni5hfi2tlcxzds7grk2hfto5ej@6r3cvm7kxkp7>

On Thu, May 09, 2024 at 09:55:27AM -0700, Jerry Snitselaar wrote:

> [    6.477091] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000120
> [    6.485896] Mem abort info:
> [    6.488782]   ESR = 0x0000000096000004
> [    6.492721]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    6.498057]   SET = 0, FnV = 0
> [    6.501209]   EA = 0, S1PTW = 0
> [    6.504358]   FSC = 0x04: level 0 translation fault
> [    6.509345] Data abort info:
> [    6.512144]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    6.517657]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    6.522906]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    6.528422] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000107c9f000
> [    6.534984] [0000000000000120] pgd=0000000000000000, p4d=0000000000000000
> [    6.541638] Internal error: Oops: 0000000096000004 [#1] SMP
> [    6.547237] Modules linked in:
> [    6.550386] CPU: 1 PID: 47 Comm: kworker/u25:0 Not tainted 6.9.0-0.rc7.58.eln136.aarch64 #1
> [    6.558609] Hardware name: Unknown NVIDIA Jetson Orin NX/NVIDIA Jetson Orin NX, BIOS 3.1-32827747 03/19/2023
> [    6.568147] Workqueue: events_unbound deferred_probe_work_func
> [    6.574187] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    6.581183] pc : nvidia_smmu_context_fault+0x1c/0x158
> [    6.586433] lr : __free_irq+0x1d4/0x2e8
> [    6.590196] sp : ffff80008044b6f0
> [    6.593607] x29: ffff80008044b6f0 x28: ffff000080a60b18 x27: ffffd32b5172e970
> [    6.600694] x26: 0000000000000000 x25: ffff0000802f5aac x24: ffff0000802f5a30
> [    6.608045] x23: ffff0000802f5b60 x22: 0000000000000057 x21: 0000000000000000
> [    6.615222] x20: ffff0000802f5a00 x19: ffff000087d4cd80 x18: ffffffffffffffff
> [    6.622483] x17: 6234362066666666 x16: 6630303078302d30 x15: ffff00008156d888
> [    6.629834] x14: 0000000000000000 x13: ffff0000801db910 x12: ffff00008156d6d0
> [    6.637096] x11: 0000000000000003 x10: ffff0000801db918 x9 : ffffd32b50f94d9c
> [    6.644269] x8 : 1fffe0001032fda1 x7 : ffff00008197ed00 x6 : 000000000000000f
> [    6.651532] x5 : 000000000000010e x4 : 000000000000010e x3 : 0000000000000000
> [    6.658619] x2 : ffffd32b51720cd8 x1 : ffff000087e6f700 x0 : 0000000000000057
> [    6.665884] Call trace:
> [    6.668332]  nvidia_smmu_context_fault+0x1c/0x158
> [    6.673058]  __free_irq+0x1d4/0x2e8
> [    6.676558]  free_irq+0x3c/0x80
> [    6.679707]  devm_free_irq+0x64/0xa8
> [    6.683209]  arm_smmu_domain_free+0xc4/0x158
> [    6.687669]  iommu_domain_free+0x44/0xa0
> [    6.691432]  iommu_deinit_device+0xd0/0xf8
> [    6.695457]  __iommu_group_remove_device+0xcc/0xe0
> [    6.700445]  iommu_bus_notifier+0x64/0xa8
> [    6.704470]  notifier_call_chain+0x78/0x148
> [    6.708671]  blocking_notifier_call_chain+0x4c/0x90
> [    6.713484]  bus_notify+0x44/0x70
> [    6.716719]  device_del+0x264/0x3e8

Oh - probably this?

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
index 87bf522b9d2eec..957d988b6d832f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
@@ -221,11 +221,9 @@ static irqreturn_t nvidia_smmu_context_fault(int irq, void *dev)
        unsigned int inst;
        irqreturn_t ret = IRQ_NONE;
        struct arm_smmu_device *smmu;
-       struct iommu_domain *domain = dev;
-       struct arm_smmu_domain *smmu_domain;
+       struct arm_smmu_domain *smmu_domain = dev;
        struct nvidia_smmu *nvidia;
 
-       smmu_domain = container_of(domain, struct arm_smmu_domain, domain);
        smmu = smmu_domain->smmu;
        nvidia = to_nvidia_smmu(smmu);

