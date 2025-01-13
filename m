Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5B6190692
	for <iommu@lists.linux.dev>; Mon, 13 Jan 2025 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736789123; cv=none; b=MKnck9dBrdyhB+n0TLIe5Zv2n03pTFFq2b19dMUTF0Z2jg0jJ48yuTqt1dYMmG3DMzQqIvjAblUg7BBcFoZW6h0ldFsINkyosPsd5NurfCOwTWxiuualx1LkY6hEYayE1mr+5rvHIqkk0cUv1mPptDRww+TLmtsfaLFht1efSWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736789123; c=relaxed/simple;
	bh=KGzd4ytGkkAu8mAOnGTRBb1s/TFRy2UWUB3jiEoyDv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpSNs5IWoL4keaT6i2BjmM1DrUy36SsLm58DMiTeCPtpV0LTBM0YvAqcuByZcEjsKLghMP1AwfE6G+Ves0q3/yVS+BBM0Qt90axqc2B5seGBn40LRFhVP1qLzyl/D0VuZTFpOzwTnfxoNxnl1GVvXcuLds1vJuFGzCzimurw2CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFCCC12FC;
	Mon, 13 Jan 2025 09:25:49 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE07A3F673;
	Mon, 13 Jan 2025 09:25:20 -0800 (PST)
Message-ID: <0a0a576e-dd4d-402a-a0ea-43eede4e7cd8@arm.com>
Date: Mon, 13 Jan 2025 17:25:18 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] iommu: fix wrong DMA ops for iommu device
To: Charan Teja Kalla <quic_charante@quicinc.com>,
 Will Deacon <will@kernel.org>
Cc: joro@8bytes.org, jgg@ziepe.ca, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241213150415.653821-1-quic_charante@quicinc.com>
 <91d15d11-ec53-4ca2-a385-9fa69d861f2c@quicinc.com>
 <20250103153434.GC3816@willie-the-truck>
 <e8fa02bb-96b7-4010-92c9-7e1eb485a551@quicinc.com>
 <20250107113126.GA6932@willie-the-truck>
 <cb2db54e-37e8-495d-916a-4e63c67019bb@arm.com>
 <acc57f57-6eb5-4d55-bc36-33624051eec9@quicinc.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <acc57f57-6eb5-4d55-bc36-33624051eec9@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/01/2025 1:29 pm, Charan Teja Kalla wrote:
[...]
>>> We need to fix 6.13 before we fix 6.6 unless you can show that 6.13 is
>>> unaffected (in which case, we can backport the fix(es)).
>>
>> Certainly the reasoning can't apply to mainline as given, since
>> arch_setup_dma_ops() stopped touching IOMMU stuff at all back in 6.10
>> (and indeed iommu_dma_ops itself no longer exists since 6.12).
>>
> 
> @Robin
> 
> Agree that we don't have iommu_dma_ops but I can say that same race
> still exists. Although dma_ops is not used, but the decision to call
> into the iommu api's is determined by the 'dev->dma_iommu' flag, which
> again, is set after domain is allocated for a device.
> 
> In the same race mentioned above,
> 1) S: Domain is not allocated but the dev->iommu_group.
> 2) C: Just returns as dev->iommu_group is filled.
> 3) C: Continues probing and succeeds.
> 4) C: Calls dma_alloc/map/.... But, it won't enter into iommu_ api's
> because the 'dev->dma_iommu' is still 'false'.
> 5) S: Domain is allocated and sets the 'dev->dma_iommu' to 'true'.
> 
> 4) above is the problematic step. Although issue exists but seems to me
> that very narrow to get triggered. Please CMIW.

Hmm, yes, I guess there is a fundamental race where async client driver
probe can observe a partially initialised group while the IOMMU driver
itself is still running iommu_device_register()->bus_iommu_probe()...
And in that case, this patch is wrong for two reasons: firstly, bodging
the iommu_probe_device() call (which really should not exist at all)
does not cover all cases; and secondly, forcibly creating the default
domain in that path before we know bus_iommu_probe() has seen all other
existing devices means iommu_get_default_domain_type() may miss their
requirements and thus defeat the whole point of deferred allocation in
the first place.

Having looked a bit closer, I think a more robust solution for now is
probably as below.

Thanks,
Robin.

----->8-----
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d1af0547f553..8d90d196e38d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3120,6 +3120,11 @@ int iommu_device_use_default_domain(struct device *dev)
  		return 0;
  
  	mutex_lock(&group->mutex);
+	/* We may race against bus_iommu_probe() finalising groups here */
+	if (!group->default_domain) {
+		ret = -EPROBE_DEFER;
+		goto unlock_out;
+	}
  	if (group->owner_cnt) {
  		if (group->domain != group->default_domain || group->owner ||
  		    !xa_empty(&group->pasid_array)) {
