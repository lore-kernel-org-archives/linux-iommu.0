Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD52D5349A2
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086173; cv=none; b=I78iY6h3BJ3gF8EB61ZqY70MIC1NKiojfiRaWvrzh7rBrbaJfK+pe0MCvqCbnKGqhgjJqiqJ0ANKnURVN177SXTSEoqTVXUv9J11cgPDEKD4sL2HCbPSkw4Xtgl/JK2eXpHrB6pZ98eLq2FjN0zoCUo/8ITetU7cUIog/iJuRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086173; c=relaxed/simple;
	bh=NbD8A+LTa8evpXL6/fu3DIrID9xBqKnToFLhfhv7WUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnefWrj/jY4sgIC1fLgS0ycRuIJ545glUkg2hm37qF5vhcqiUbANC/EWyoKKw9DjGgPRzMm5RFiTyoK+h+BuphiNdmbdX1vxQtcFW82T3xoFTyon6BXhjDFMqRodgGR7qkglej8ttvUwpmpp5B0VOMOq8g+P2J7zU5nddwm85ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KF//xe6U; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KF//xe6U"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53391022dc0so62270371cf.2
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 10:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792086162; x=1792690962; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PfHGUiq8UZY3e8RsVecaVzk97ckbUa7d3/EsB9oFqL4=;
        b=KF//xe6UIP2BYz6BpyNy7lfo+d9dzoyvvsN/dAp8d97DPTeFIA3WLxGZ3JxOscSc3T
         7twCdOfTeP8EhQVD32Ws7NXlRsFUD+nOnszdCJvn5HEiSGl6fEQIDwrjilNI7nEyF5Ur
         a1fKcL088HMVzQJQ78kidMKpJtKp9z29t1blHc/hqc88rTDy9ZeCUvWfDhH+Kxzgl2gZ
         SMBtN9pKIcKEV0fNxia5d71P96UA39xWxxuWlMza4eUENvS08mjfKgX0nICLYA+EbzGX
         YurhFsGcBIbirK8xvXhzuXXcjZYMW5SIq0h84GKDvi1R/9q8omhkm+av01mLIx/hPvtd
         e2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792086162; x=1792690962;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PfHGUiq8UZY3e8RsVecaVzk97ckbUa7d3/EsB9oFqL4=;
        b=MIMIkTzTo3wpCxNH+T7ClWI/sJbnd6uJ7l/HGTtxBVxJMmC+4WHEc1IeEy/3sGJYST
         2jNywx0EOIyhDTzg+HjfERPMEFsao7LubsKqAnNELoz2c70VZu6l9Bn1SF24mqvje6nh
         oXvF8KWehNg1IC871bvjoeZ/WkQz6Sdp/RsfYtoZQLAEs8gGRr7romKnvnEanUnzNgEQ
         FVaT5pj9C34Allpfhbb3gDxmC9Odmt+EQC1aKSUTAyL7WR/QpwEzl4D+HFoGT7waU0xO
         dnmczz+2IjFFPZYyjwMtl0TfPJiuH4jmKdHe9UAEw+Xj82+7kCYMDwI5OhEElDSdCMCD
         UkhQ==
X-Forwarded-Encrypted: i=1; AKwUvBwck9qqiC848wSVXzSMynirxmLsUnLeaB6eqpOr8sYVArFwzxoPE5WpBVbK876+fjPn+qiEcA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLNZ4JaVWbBhzFR8vMIQmi41N259pr1z47JytfFLKUsuvNd/D/R
	HyVa/pfbvXV0xbnACtT1iEKO7Pi/jSafLoUOqcVG29J+nmNOrqArfh28JTGLslaui3UUL3VMBCn
	I8Fk7
X-Gm-Gg: AYBFou054jgYuBKrW70dFxYMjR3jZbK8U2pNN/ZofNc3mRp4rs3oxwuY+c3tGXgAopQ
	LnSLSZXrlJTt5JxHFajMJYJ7lONPwvgUvORLuxqspXhdxocvRbydCgitw+r7K96mog0vtyXseRs
	IhlVK7u2mMKKzjuKduIheMhOYl2W9K9mQprGDVqlhrOYr5it0nY9fsqDIeq9avIiZyMp39Fhb1M
	LD+tFunt+1WHRdTjVejsTlQLOaLdSs/ebm2g24YA645I+zui+NsMYs3ixx4bAAHqOPG7GO2jMdZ
	BIjnl+PrXTklLBhfPKuFO6qftWkR9waRpgRdBnSL2uZ4pz6nmlAXfjFtgbhURuYACfsRxm9dRHw
	OOHTLQEsHjHfB44sqkHTgpSyAjjixtqZr+P/JYdNsmmjAlB7f35Rn+BjuFtusRvWL5SqsnFM+bv
	jhBGXP/1aHUOlzlJiasT90XC07IBXo8OA/ZDcilrHLvmp9duR4i4OGF/6DDMannl+7x6QoozROr
	oIN5aZQgkQxWSSTrAp7mAnUFE2Dmxs/QwyVUQN6d3//6waiXfavAGx1
X-Received: by 2002:a05:622a:144a:b0:533:3bf7:49e5 with SMTP id d75a77b69052e-5359facf0e9mr295381921cf.23.1792086162563;
        Thu, 15 Oct 2026 10:42:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcba45dffsm1165226d6.12.2026.10.15.10.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:42:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHPTV-0000000H6tQ-0dMP;
	Thu, 15 Oct 2026 14:42:41 -0300
Date: Thu, 15 Oct 2026 14:42:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kevin Mitchell <kevmitch@arista.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Nicolin Chen <nicolinc@nvidia.com>,
	stable@vger.kernel.org, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/amd: remove obsolete domain pointer warning on
 release
Message-ID: <20261015174241.GW14213@ziepe.ca>
References: <20261013222402.673852-2-kevmitch@arista.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013222402.673852-2-kevmitch@arista.com>

On Tue, Oct 13, 2026 at 03:23:56PM -0700, Kevin Mitchell wrote:
> A warning is triggered in amd_iommu_release_device() on removal of a
> device with an IOMMU_RESV_DIRECT region. The warning is based on the
> false assumption that correct attachment to the release_domain will
> always result in a NULL dev_data->domain pointer. For devices with
> IOMMU_RESV_DIRECT (and consequently dev->iommu->require_direct), the
> release domain is the permanent identity_domain which sets
> itself to dev_data->domain on attach.
> 
> This behaviour was added in commit e94160488e65 ("iommu: Generic support
> for RMRs during device release"). Commit c21b34762e2f ("iommu/amd: Set
> release_domain to blocked_domain") caused it to take effect for AMD
> IOMMU.
> 
> Remove the warning as it is no longer strictly an error to have a non-NULL
> domain pointer. As this leaves amd_iommu_release_device() empty, remove it.
> 
> The warning was observed for a device with direct mapped region:
> 
> /sys/bus/pci/devices/0000:04:00.0/iommu_group/reserved_regions:
> 
>   0x00000000fee00000 0x00000000feefffff msi
>   0x000000fd00000000 0x000000ffffffffff reserved
>   0x0000fffd00000000 0x0000ffffffffffff direct
> 
> Upon hotunplug:
> 
> [   28.715475] pcieport 0000:00:03.1: pciehp: Slot(0-3): Link Down
> [   28.715482] pcieport 0000:00:03.1: pciehp: Slot(0-3): Card not present
> [   28.715601] ------------[ cut here ]------------
> [   28.715603] WARNING: drivers/iommu/amd/iommu.c:2521 at amd_iommu_release_device+0x5d/0x70, CPU#4: irq/29-pciehp/99
> [   28.715657] RIP: 0010:amd_iommu_release_device+0x5d/0x70
> [   28.715687] Call Trace:
> [   28.715689]  <TASK>
> [   28.715694]  iommu_deinit_device+0x84/0x110
> [   28.715699]  __iommu_group_remove_device+0xa8/0xd0
> [   28.715703]  iommu_bus_notifier+0x48/0x70
> [   28.715707]  notifier_call_chain+0x48/0xe0
> [   28.715712]  blocking_notifier_call_chain+0x45/0x60
> [   28.715716]  bus_notify+0x3b/0x60
> [   28.715720]  device_del+0x259/0x3b0
> [   28.715730]  pci_remove_bus_device+0x85/0x100
> [   28.715735]  pciehp_unconfigure_device+0x9d/0x180
> [   28.715743]  __pciehp_disable_slot+0x47/0xe0
> [   28.715747]  pciehp_handle_presence_or_link_change+0x80/0x5e0
> [   28.715753]  pciehp_ist+0x162/0x290
> 
> Fixes: c21b34762e2f ("iommu/amd: Set release_domain to blocked_domain")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
> ---
> Changes in v2:
> - Remove the warning alltogether as well as the now-empty
>   amd_iommu_release_device()
> - Link to v1: https://lore.kernel.org/r/20261008202530.14501-2-kevmitch@arista.com
> 
>  drivers/iommu/amd/iommu.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
