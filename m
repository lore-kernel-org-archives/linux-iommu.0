Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2C51B78F3;
	Sat, 18 Apr 2026 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776493670; cv=none; b=ZKt35RHn+OEvVq+OwnwqKovVuf17SPGfioVZBIeufgqc8/9WYEuIkrez1bD4X0Gk/CTXWHgWXst/5qrnbZc2CRfxAUbc2R+shGCW8XyWpmT9Qq/ovj8WIJDBXsRtFlQVSChoKci+sBqSnfjWooCT2mnAyCAQPm9z+6xEo0DgC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776493670; c=relaxed/simple;
	bh=Mhz/eGsy61GjfbrbYNbTyoUXNxEjgcROawMEx6lcnFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nlB1DiLIH6Tj5gik1cW5KMxQ8ARiveILYyf9hFMg68iN7cDO/VS/I3nEYk8LvgWWNru4YwwaZLqeVavy8W/xHLcr1i5TkgDSof/m/ZYZQIhbJ9ZIq8hL5uFwk34vMm+ju0fSBO0bqa5s240cqtbF1VB/vxe4QePtHHUQ/ZCEG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCEkxOD/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCEkxOD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E66C19424;
	Sat, 18 Apr 2026 06:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776493669;
	bh=Mhz/eGsy61GjfbrbYNbTyoUXNxEjgcROawMEx6lcnFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kCEkxOD/ePZreCjZ6jlL9PZDVNJ1/1/v2/JtTAVnDmU+uLWIIr3CipMPf4ZzVcogV
	 g7zZYqjGcbaAxORCxGe4HyIg5s65CCjDi607G9BlFF16jSw0nWkIv4bBXhe2B6A8dH
	 W9iG/jCPhXkG8I6OWGkLwo6gYnjAs/gmsBvx2zCFDeMnzx6EDL1G2K39v5F14ymmDz
	 cNArv2tSG3TcZys9nAti1WEAWi0V6ywQbST3bsWFgsKMV7AZED2cUhwTHgRR5jxlSr
	 fKazqzUSAn9dhRxP55NhqXT12vKIMcjQ1T3P5wcZih6t0DwG/dqGTdo6IkgKPSkoJl
	 AVFLrU8kttlVA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, Mostafa Saleh <smostafa@google.com>
Subject: Re: [RFC PATCH 2/7] dma-direct: use DMA_ATTR_CC_DECRYPTED in
 alloc/free paths
In-Reply-To: <yq5a340tiorj.fsf@kernel.org>
References: <20260417085900.3062416-1-aneesh.kumar@kernel.org>
 <20260417085900.3062416-3-aneesh.kumar@kernel.org>
 <20260417152828.GJ2577880@ziepe.ca> <yq5a340tiorj.fsf@kernel.org>
Date: Sat, 18 Apr 2026 11:57:42 +0530
Message-ID: <yq5ay0ikhjfl.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> Jason Gunthorpe <jgg@ziepe.ca> writes:
>
>> On Fri, Apr 17, 2026 at 02:28:55PM +0530, Aneesh Kumar K.V (Arm) wrote:
>>> Propagate force_dma_unencrypted() into DMA_ATTR_CC_DECRYPTED in the
>>> dma-direct allocation path and use the attribute to drive the related
>>> decisions.
>>> 
>>> This updates dma_direct_alloc(), dma_direct_free(), and
>>> dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.
>>> 
>>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>>> ---
>>>  kernel/dma/direct.c | 34 ++++++++++++++++++++++++++--------
>>>  1 file changed, 26 insertions(+), 8 deletions(-)
>>> 
>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>> index c2a43e4ef902..3932033f4d8c 100644
>>> --- a/kernel/dma/direct.c
>>> +++ b/kernel/dma/direct.c
>>> @@ -201,16 +201,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>>>  {
>>>  	bool remap = false, set_uncached = false;
>>> -	bool mark_mem_decrypt = true;
>>> +	bool mark_mem_decrypt = !!(attrs & DMA_ATTR_CC_DECRYPTED);
>>>  	struct page *page;
>>
>> This is changing the API, I think it should not be hidden in a patch
>> like this, also not sure it even makes sense..
>>
>> DMA_ATTR_CC_DECRYPTED only says the address passed to mapping is
>> decrypted. It is like DMA_ATTR_MMIO in this regard.
>>
>> Passing it to dma_alloc_attrs() is currently invalid, and I think it
>> should remain invalid, or at least this new behavior introduced in its
>> own patch deliberately.
>>

Thinking about this further, I am wondering why you consider passing
DMA_ATTR_CC_DECRYPTED invalid. That could be one way for a T=1 device to
request decrypted memory. We do not fully support that today, but is
there any specific reason you object to allowing DMA_ATTR_CC_DECRYPTED
in the allocation paths?

I understand that DMA_ATTR_CC_DECRYPTED is currently used to describe
already allocated memory, but extending it to also indicate a DMA
address attribute would simplify the allocation path. We could then
avoid passing a separate unencrypted/decrypted flag to the various
functions that already take an attrs argument in the allocation path.

How about making the change below so that we only prevent
dma_alloc_attrs() from accepting DMA_ATTR_CC_DECRYPTED?

modified   kernel/dma/direct.c
@@ -204,11 +204,14 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	bool remap = false, set_uncached = false;
-	bool mark_mem_decrypt = !!(attrs & DMA_ATTR_CC_DECRYPTED);
+	bool mark_mem_decrypt = false;
 	bool allow_highmem = true;
 	struct page *page;
 	void *ret;
 
+	if (attrs & DMA_ATTR_CC_DECRYPTED)
+		return NULL;
+
 	if (force_dma_unencrypted(dev)) {
 		attrs |= DMA_ATTR_CC_DECRYPTED;
 		mark_mem_decrypt = true;
@@ -345,7 +348,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
-	bool mark_mem_encrypted = !!(attrs & DMA_ATTR_CC_DECRYPTED);
+	bool mark_mem_encrypted = false;
 	unsigned int page_order = get_order(size);
 
 	/*

-aneesh
