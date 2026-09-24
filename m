Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12983E958F
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238066; cv=none; b=seWeU3ZByDEnh+GoNWmiaAELgcojH5pmHSZzNK2Gl6FSM54pBjqblOCt0vP1Eq7X3OCwpdPlgHKTxrxRDP1eR3fVKKb/IxKNTKriKUwNfmGUNg/xakJi/EW9yebXldTZV2h3CAC9cHPPgowLlcogmVMm8nMNY4h9FGd0e99oW+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238066; c=relaxed/simple;
	bh=xLKwIgImHArSoDRxKNReWtyWPgR8tM7wwg9leeIrudk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMspFohrd/hZqDXPgpe7xjKnAa1rQoZoGdSR3E0/NUEAo6lM5h0c6jd8fXHPHH9fCK6GxBoTLmVmMECwmHZlFSuyTu/VmFKOAL+QcGla2qOVaLFFreYBXyP+R9b2brrQ82G6N2xn/uRflajMywao69PFNdnshYyzy1IaXbfpTJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jEv6Olah; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jEv6Olah"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49e65a8f70eso26675e9.0
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790238063; x=1790842863; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TBbUmiE2dRkBbSKytOyHEBRYcqAsz7TnE/aajFa/CtM=;
        b=jEv6Olahfcbyp2W8iOIch8Av7sXBkdBdcWR112W9sQ5sAgNT6S+N+j6g0hJi7jJOsP
         GyQY611ya/OncsspZn0CCnblzmnVqOFDo9Ij+UY+ekeW+osu22rl6Tl4wk7+XJO5qsm/
         fQrrmQ0VSZX1VCtc5brYSyXdfLatK9pNA34Wkw/0jagPy0zapTpxYiUBkuHcUW13E1Dd
         GBfFrIMVkZk5I0iW9fqzpxO2mtlE2DLfAGANE1IZbtgh+bID7TkhlmIR9s7uFxP1xML0
         4ajM5FcCITtJxGdyFRjY3E9t4To3zfqAZhPMF4RkcLPT+rX1MMk5yeVwoY1n+dHPlP74
         cXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238063; x=1790842863;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TBbUmiE2dRkBbSKytOyHEBRYcqAsz7TnE/aajFa/CtM=;
        b=hP49qaXR2ghAYdssHWGyGklE246z9jBUpTuDd5LzKKsisjEGrzy+NcGS2pirOpxsb6
         aida9YYWq6pYCt/GbL1aDdJdJTzzRedMFRdzfyP13XACpShMlpCMNdgxur42fQSnkAWX
         I4L8pWk/0sHM4EjobGGJQBvmTAKI8lBppi0W+YLFFDBImTuy0hPLZPb2kRskUwAUo0xX
         34jQ+2r+PbAwDccZ2Icd3pQR5RlId+AYiBC6BXrCJzl8JV+LcfUDDmqoABsgcLmf6BUC
         twe7irXEMzz4+CtkhvN53JD55VnE6AHOplVYglcycyG3vmAomEXhic5CgmrVTCJHwfiq
         PR6g==
X-Forwarded-Encrypted: i=1; AKwUvBx5Iw1G5g+GGPwru26SdOEABAHbO5v/MXGrq5u+qxFUvQdmcAjcpQBfZBaq+xs+jIQNixNRGA==@lists.linux.dev
X-Gm-Message-State: AFuF++mHvAeeiQkKvhkFXanG6RhNi/EK7Faw9LW237au/Ec1vpL2r2HH
	drzqP74lsBSsRvfbhqYDTSFlCTWNDVgrYYSoONHoMbcL++ZX6GLkZLrxslRvzKQA9A==
X-Gm-Gg: AYBFou0ISsJRox0HwAtJHTTaNuM3FdFSSQW/7mmassM3lTBdSBAliQvc900UdfD4J4M
	X+15K7Do6NdvG9t5n3mZqYWhJH6KD+mx5yPUJ8MaqaxCelMkO+ou1Z2cZdQV4cXPVa+xfuHTzYo
	NhooI4K4o8hd60aryR4IA38qS3c1Iq+yY89PrgP83mskDLMcnHJ9rjCHdwENvLoa5aU1z3cPOMU
	I5gvj/OC75QX2ObSNam5B2LqeZMCZbR1J0gpFKxDUNYq9rCrnxt6v58AJjaRR+3lLlcedNydbVO
	hyo5ILC4dikLv94K4e13LT0T1zgHl45yB6nxuq0PH1pdqcFwFyEJGRB1jRqHSMVVTA/5vb+PEAF
	SBW0Z5FXMnwk7+s8dNT98cj+hyiK8N3DmNU+cALUu1R1daxYcO8TKbZDOgvYPrNL5pZMslAtOOu
	E9o2DBH71ATTVrYIWB0dnq9ZMVNPZ5KN6UQ9JFcuF6Z6DoYz+s6jpfxnY0pKvuPuO7QlR2G3YdE
	4CsLun9OL35IPtf0tba01FNIxgRtGj5x2HmRHsm
X-Received: by 2002:a7b:c4cb:0:b0:49f:c839:28be with SMTP id 5b1f17b1804b1-49fe5996dc6mr523225e9.3.1790238062399;
        Thu, 24 Sep 2026 01:21:02 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c119sm14042034f8f.15.2026.09.24.01.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:21:01 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:20:58 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	vsethi@nvidia.com, Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v6 06/17] iommu/arm-smmu-v3: Don't rb_erase() a
 never-inserted stream node
Message-ID: <arTdal7U8eK9Z_7j@google.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <76c5f9dde30269995ef842a12a3a5e1ebaa3e6df.1790188510.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76c5f9dde30269995ef842a12a3a5e1ebaa3e6df.1790188510.git.nicolinc@nvidia.com>

On Wed, Sep 23, 2026 at 01:11:25PM -0700, Nicolin Chen wrote:
> arm_smmu_insert_master() skips inserting a stream whose StreamID duplicates
> one the same master already owns (bridged PCI devices can present duplicate
> IDs), leaving that master->streams[i].node zeroed and unlinked from the
> smmu->streams rb-tree.
> 
> Both the insert error-rollback loop and arm_smmu_remove_master() then call
> rb_erase() on every master->streams[i].node unconditionally. rb_erase() on
> a zeroed node sees a NULL parent, treats the node as the tree root and sets
> root->rb_node = NULL, silently emptying the whole SID tree and breaking SID
> lookups (and DMA) for every other master on the SMMU.
> 
> Mark each node with RB_CLEAR_NODE() after sort_nonatomic() reorders the
> array, since sorting relocates the entries and would leave the earlier
> self-referential RB_CLEAR_NODE() pointer stale. An un-inserted node then
> stays RB_EMPTY_NODE() and is skipped in both erase loops; inserted nodes
> are linked by rb_find_add() and erased as before.
> 
> Fixes: b00d24997a11 ("iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids")
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 5732f3ba0122d..082da3dc09e56 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4122,6 +4122,13 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>  	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
>  	     NULL);
>  
> +	/*
> +	 * Clear after sorting: RB_CLEAR_NODE() records the node's own address,
> +	 * which sort_nonatomic() invalidates by relocating the entries.
> +	 */
> +	for (i = 0; i < fwspec->num_ids; i++)
> +		RB_CLEAR_NODE(&master->streams[i].node);
> +
>  	mutex_lock(&smmu->streams_mutex);
>  	for (i = 0; i < fwspec->num_ids; i++) {
>  		struct arm_smmu_stream *new_stream = &master->streams[i];
> @@ -4154,7 +4161,9 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>  
>  	if (ret) {
>  		for (i--; i >= 0; i--)
> -			rb_erase(&master->streams[i].node, &smmu->streams);
> +			if (!RB_EMPTY_NODE(&master->streams[i].node))
> +				rb_erase(&master->streams[i].node,
> +					 &smmu->streams);
>  		kfree(master->streams);
>  		kfree(master->build_invs);
>  	}
> @@ -4174,7 +4183,8 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
>  
>  	mutex_lock(&smmu->streams_mutex);
>  	for (i = 0; i < fwspec->num_ids; i++)
> -		rb_erase(&master->streams[i].node, &smmu->streams);
> +		if (!RB_EMPTY_NODE(&master->streams[i].node))
> +			rb_erase(&master->streams[i].node, &smmu->streams);
>  	mutex_unlock(&smmu->streams_mutex);
>  
>  	kfree(master->streams);
> -- 
> 2.43.0
> 
