Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0AE3A785C
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789023346; cv=none; b=thr3GTvAyZyB+swD8kwGjoVLkZjHUJ0FfK95NUOtPkmgZTrg5ZdRYmpou2aF4ET4UrmmYMUT9YOFcQlYOW+zevVgXh1xc3xGGhBpWhfYW/S23oNuikcyOD92yy2n8l2R9BiGoIiPQha9Zrp6/KhdS9l33UKgajYCfHLaMzoDaso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789023346; c=relaxed/simple;
	bh=Nv+I0RNdwzf6AstOSUSy6pZKd3pcHzupoCEKAqMrplE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LONXHuIl6XKERLXUpf+iuvgRqsVGCH+RmBtmc2FNHWprv8TCMHcvKWDHChgYEntRw8llDpsUnq6awN3KMxUFTCTqXcDZY5i0z3Qr5+4naNqARNr5pkSTi2KNmlCtGIp/G0HhA+Znp1PoFGSCcr7e+rnrpRpRAIGPOC4Qen5ekZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqTYy6Vc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqTYy6Vc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9BC1F00893;
	Thu, 10 Sep 2026 06:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789023344;
	bh=2ppyMVf6o5Ao81HKc3ta7j6fgbkG/0SWr/iD0d0NsGQ=;
	h=From:To:Subject:In-Reply-To:References:Date;
	b=aqTYy6VcpGUu5ny1rT5wmZR4THcHBw1Acx1Pze3HyAKnytd61QsYrQ6HFL+bWupB/
	 XNeH9yuNm9r5ZHtfbr8EB+FnVhzDc+1I1uq772qgEQi5tHYWzVhwiVvUTIB3tQoDMy
	 WRxznLiya9hxR2QEUpmVoCYnsYCAqsvAqMrVzkpGb8v8aynZRy17AjjAXehmtVDknM
	 OgMau/Yx3A+UhzF8RoMZXKugIRND0nvv7XXIeJ7kNaVLT96Lz9HIKYCC8VnWeQRHKU
	 vgMRvxu1mzeko6aKVciASxoY11jJj6F+UZ8810igfz2kNxPGLOI6+PZO0Na26x04cW
	 aQwWbs91vs6/A==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>, iommu@lists.linux.dev
Subject: Re: [PATCH] x86/mm: Don't force unencrypted DMA for IOMMU-backed
 devices
In-Reply-To: <da147aa4-79b6-4388-bdf4-d1af28b1ae77@amd.com>
References: <20260908113232.247457-1-aneesh.kumar@kernel.org>
 <da147aa4-79b6-4388-bdf4-d1af28b1ae77@amd.com>
Date: Thu, 10 Sep 2026 12:25:40 +0530
Message-ID: <yq5ao6e5a93n.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Alexey Kardashevskiy <aik@amd.com> writes:

> On 8/9/26 21:32, Aneesh Kumar K.V (Arm) wrote:
>> Commit 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select
>> them via attrs") exposed an issue with force_dma_unencrypted() on
>> systems using host memory encryption.
>> 
>> force_dma_unencrypted() checks whether the device DMA mask can address
>> the encryption bit and, if not, requires DMA allocations to use
>> unencrypted memory. However, this check is not applicable when the
>> device is using the IOMMU. In that case, the device DMA mask constrains
>> the IOVA seen by the device, not the backing physical address, so it
>> does not need to cover the C-bit.
>> 
>> This currently causes dma_alloc_attrs() to set
>> __DMA_ATTR_ALLOC_CC_SHARED for such devices. iommu_dma_alloc() does not
>> support that attribute and rejects the allocation, causing DMA
>> allocations to fail.
>> 
>> Do not force DMA allocations to be unencrypted when the device is using
>> the IOMMU. This allows the IOMMU to map the encrypted physical pages as
>> before and avoids incorrectly requesting CC_SHARED allocations.
>> 
>> Fixes: 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select them via attrs")
>> Reported-by: Timo Witte <timo.witte@gmail.com>
>> Link: https://lore.kernel.org/all/CANB4YXR7h8V5Xp=MXVZeSdvw9UiriSagp=E+ju5RRDNghoPHLQ@mail.gmail.com
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>   arch/x86/mm/mem_encrypt.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
>> index 912f22ca838f..a349d8d21569 100644
>> --- a/arch/x86/mm/mem_encrypt.c
>> +++ b/arch/x86/mm/mem_encrypt.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/cc_platform.h>
>>   #include <linux/mem_encrypt.h>
>>   #include <linux/virtio_anchor.h>
>> +#include <linux/iommu-dma.h>
>>   
>>   #include <asm/sev.h>
>>   
>> @@ -30,7 +31,7 @@ bool force_dma_unencrypted(struct device *dev)
>>   	 * device does not support DMA to addresses that include the
>>   	 * encryption mask.
>>   	 */
>> -	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
>> +	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) && !use_dma_iommu(dev)) {
>>   		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
>>   		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
>>   						dev->bus_dma_limit);
>
> if we drop this whole "if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))"
> chunk, won't dma_alloc_attrs()&co be able to figure out this from
> dev->bus_dma_limit and other DMA masks we have all over the place? I
> should probably just try it... Thanks,
>


That would imply that, with host memory encryption, no device requires
unencrypted DMA. IIUC, that is not true. There are three cases:

1. Host memory encryption with an IOMMU: unencrypted DMA is not required.
2. Host memory encryption without an IOMMU, where the device's DMA addressing constraints cannot cover the C-bit: unencrypted DMA is required.
3. Host memory encryption without an IOMMU, where the device can address the C-bit: unencrypted DMA is not required.

-aneesh
