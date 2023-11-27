Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F103233C4
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXn8mUtK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701105278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/lzc/Q0P67zpQSBQ4vjzQ1L40aVP3IrTe077/xfP/I=;
	b=KXn8mUtKhhhfTYJEd9f8nSRuSPnH6R1z0FPxgh1r1TCK4B54IHCyTxfDK4JzSem2XYAGd/
	IUHLibN3xRcE2AMBjLq3GIxB9W/FF0XuN/MdDTcihnh/7eVn61SSpr6zXdKJaCS85jOU2A
	s1DFLTnfomQnAYrkbflsF902S7ginN4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-sRZj14qVMY2JF-q9HxwMoA-1; Mon, 27 Nov 2023 12:14:34 -0500
X-MC-Unique: sRZj14qVMY2JF-q9HxwMoA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b42bd8de5so11504015e9.1
        for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 09:14:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701105273; x=1701710073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/lzc/Q0P67zpQSBQ4vjzQ1L40aVP3IrTe077/xfP/I=;
        b=uWTMb8zSGCQg/gPPqfjptlfehkQnBkAEw3HQ+WSIGJZCybKGZPmHiYnSnnpC/OWpi+
         54ZvaXUVrXNfLyzHJzZmEj2pTe2m+x5TjnJPvgfQrUfiMilIdJLpB3wV4+wOKVIjG50h
         09xtfxZuI9/1DK+T/3hjzgqMgwfewjybK+pr7R4O7uqhN9ixpbvbSTAxYZzbAyIVkEMQ
         ljORRPIw/a3w3FJ/WLGnAxI2mF3OfxifF3wtxB4AUK8j3fjxFOySKvXephgpqONnq5sG
         yKh+2PNK9EfGrC0TGpp+HRy134oPrL9YMXbGTdOZiemsQ9HRRNALN5rhEoWTVTtfaCfG
         UQww==
X-Gm-Message-State: AOJu0Yw2bRR2NmPVDWAg2MWoBDEUa2fVUV+HjMCESvWpevk7VcYh/mce
	wMuCPoROxEBGUjiZoc8RKBVIY1jUGeFpPchplS1UucB3rBI96HlnyLEUsDkx0NN7WngABPGiKNU
	fTjva6VZo7zwSgh8=
X-Received: by 2002:adf:e981:0:b0:332:c9f5:e5b5 with SMTP id h1-20020adfe981000000b00332c9f5e5b5mr9898895wrm.0.1701105273290;
        Mon, 27 Nov 2023 09:14:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMSr48V5gzC1nkMiaXIll+FWd5UWN/RMRktYG6IhAsunTRvT7T0Z6W3FwMe6R9/sHjGaGFsQ==
X-Received: by 2002:adf:e981:0:b0:332:c9f5:e5b5 with SMTP id h1-20020adfe981000000b00332c9f5e5b5mr9898875wrm.0.1701105272985;
        Mon, 27 Nov 2023 09:14:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id f8-20020adff988000000b00332e75eae4asm10663652wrr.85.2023.11.27.09.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 09:14:32 -0800 (PST)
Message-ID: <6fff20dd-46d5-4974-a4a5-fb4e7a59ce44@redhat.com>
Date: Mon, 27 Nov 2023 18:14:30 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/19] iommu/arm-smmu-v3: Remove
 arm_smmu_master->domain
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <14-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <14-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 11/13/23 18:53, Jason Gunthorpe wrote:
> Introducing global statics which are of type struct iommu_domain, not
> struct arm_smmu_domain makes it difficult to retain
> arm_smmu_master->domain, as it can no longer point to an IDENTITY or
> BLOCKED domain.
> 
> The only place that uses the value is arm_smmu_detach_dev(). Change things
> to work like other drivers and call iommu_get_domain_for_dev() to obtain
> the current domain.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

This patch introduces a crash on my machine. See below.

Eric

[    7.209854] list_del corruption, ffff007f82e5f890->next is NULL
[    7.216154] ------------[ cut here ]------------
[    7.220952] kernel BUG at lib/list_debug.c:52!
[    7.225750] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
[    7.232188] Modules linked in:
[    7.235407] CPU: 3 PID: 263 Comm: kworker/u97:1 Not tainted
6.7.0-rc2-upstream+ #11
[    7.243598] Hardware name: FUJITSU FX700/CMUA        , BIOS 1.8.0 Nov
26 2021
[    7.251073] Workqueue: events_unbound deferred_probe_work_func
[    7.257452] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[    7.264779] pc : __list_del_entry_valid_or_report+0x6c/0xd8
[    7.270736] lr : __list_del_entry_valid_or_report+0x6c/0xd8
[    7.276689] sp : ffff800089def970
[    7.280164] x29: ffff800089def970 x28: ffff8000820f19c0 x27:
ffff007f82e01248
[    7.287869] x26: ffff007f80030f00 x25: ffff007f82e01268 x24:
ffff007f82e00900
[    7.295372] x23: ffff800082580cf8 x22: 0000000000000000 x21:
0000000000000000
[    7.303075] x20: ffff007f82e009d8 x19: ffff007f82e5f880 x18:
ffffffffffffffff
[    7.310773] x17: 0000000000000001 x16: 0000000000000040 x15:
ffff800109def597
[    7.318254] x14: 0000000000000000 x13: 4c4c554e20736920 x12:
7478656e3e2d3039
[    7.325956] x11: 00000000ffff7fff x10: 00000000ffff7fff x9 :
ffff80008012cee4
[    7.333463] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 :
00000000002bffa8
[    7.341161] x5 : 0000000000007fff x4 : 0000000000000000 x3 :
0000000000000000
[    7.348636] x2 : 0000000000000000 x1 : ffff007f824bc840 x0 :
0000000000000033
[    7.356329] Call trace:
[    7.358961]  __list_del_entry_valid_or_report+0x6c/0xd8
[    7.364556]  arm_smmu_detach_dev+0x4c/0x128
[    7.368908]  arm_smmu_attach_dev+0xe0/0x580
[    7.373475]  __iommu_attach_device+0x28/0xf8
[    7.377934]  __iommu_device_set_domain+0x74/0xd8
[    7.382900]  __iommu_probe_device+0x15c/0x270
[    7.387423]  iommu_probe_device+0x20/0x60
[    7.391819]  acpi_dma_configure_id+0xc4/0x150
[    7.396365]  pci_dma_configure+0xe8/0xf8
[    7.400671]  really_probe+0x78/0x3d0
[    7.404412]  __driver_probe_device+0x80/0x178
[    7.409153]  driver_probe_device+0x44/0x120
[    7.413499]  __device_attach_driver+0xb8/0x158
[    7.418369]  bus_for_each_drv+0x84/0xe8
[    7.422387]  __device_attach+0xac/0x1e0
[    7.426407]  device_initial_probe+0x18/0x28
[    7.430946]  bus_probe_device+0xa8/0xb8
[    7.434942]  deferred_probe_work_func+0xb8/0x110
[    7.439918]  process_one_work+0x174/0x3c8
[    7.444110]  worker_thread+0x2c8/0x3e0
[    7.448222]  kthread+0x100/0x110
[    7.451616]  ret_from_fork+0x10/0x20
[    7.455386] Code: d65f03c0 b00062a0 910d2000 97ec9112 (d4210000)
[    7.461832] ---[ end trace 0000000000000000 ]---
[    7.466827] Kernel panic - not syncing: Oops - BUG: Fatal exception
[    7.473439] SMP: stopping secondary CPUs
[    7.477729] Kernel Offset: disabled
[    7.481399] CPU features: 0x0,00000001,90028144,21017203
[    7.487061] Memory Limit: none
[    7.490280] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal
exception ]---

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 21 +++++++--------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 -
>  2 files changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 7d2dd3ea47ab68..23dda64722ea17 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2480,19 +2480,20 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
>  
>  static void arm_smmu_detach_dev(struct arm_smmu_master *master)
>  {
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(master->dev);
> +	struct arm_smmu_domain *smmu_domain;
>  	unsigned long flags;
> -	struct arm_smmu_domain *smmu_domain = master->domain;
>  
> -	if (!smmu_domain)
> +	if (!domain)
>  		return;
>  
> +	smmu_domain = to_smmu_domain(domain);
>  	arm_smmu_disable_ats(master, smmu_domain);
>  
>  	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
>  	list_del(&master->domain_head);
>  	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  
> -	master->domain = NULL;
>  	master->ats_enabled = false;
>  }
>  
> @@ -2546,8 +2547,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  
>  	arm_smmu_detach_dev(master);
>  
> -	master->domain = smmu_domain;
> -
>  	/*
>  	 * The SMMU does not support enabling ATS with bypass. When the STE is
>  	 * in bypass (STE.Config[2:0] == 0b100), ATS Translation Requests and
> @@ -2566,10 +2565,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	case ARM_SMMU_DOMAIN_S1:
>  		if (!master->cd_table.cdtab) {
>  			ret = arm_smmu_alloc_cd_tables(master);
> -			if (ret) {
> -				master->domain = NULL;
> +			if (ret)
>  				goto out_list_del;
> -			}
>  		} else {
>  			/*
>  			 * arm_smmu_write_ctx_desc() relies on the entry being
> @@ -2577,17 +2574,13 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  			 */
>  			ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
>  						      NULL);
> -			if (ret) {
> -				master->domain = NULL;
> +			if (ret)
>  				goto out_list_del;
> -			}
>  		}
>  
>  		ret = arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, &smmu_domain->cd);
> -		if (ret) {
> -			master->domain = NULL;
> +		if (ret)
>  			goto out_list_del;
> -		}
>  
>  		arm_smmu_make_cdtable_ste(&target, master, &master->cd_table);
>  		arm_smmu_install_ste_for_dev(master, &target);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 1be0c1151c50c3..21f2f73501019a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -695,7 +695,6 @@ struct arm_smmu_stream {
>  struct arm_smmu_master {
>  	struct arm_smmu_device		*smmu;
>  	struct device			*dev;
> -	struct arm_smmu_domain		*domain;
>  	struct list_head		domain_head;
>  	struct arm_smmu_stream		*streams;
>  	/* Locked by the iommu core using the group mutex */

