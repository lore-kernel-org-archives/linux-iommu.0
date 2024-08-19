Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E7B132124
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082065; cv=none; b=rhfDUEKevIfTId7iztxX/r03UTYHMpCN1/0ev8PPOOPGJ0bMNah2n3fVP7ru4aC+9O7cmgeb1ALsH0lcZ6aUBTqMzsuShqd/m6mD+uLZR4Q5DleOyt7ev49RdnMWfGAjlq8nNTlTCW5aNK6xHV7oy6B+T5RG9fH6va2fFKTON5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082065; c=relaxed/simple;
	bh=GtDAaJmFfaH4+QMA7jpe2RwFm8+Al0atud9c5END1G0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQVzm8VERDObiX7DLvJxxDZ4EkDYPtZiZgYOph6gJ1MUPIkAdN8xEuu2tfiX/xhizNrU7azK6XKkWs5i4GGuioeX3t4o9vbVCYnnF/F+IzeWwVkC8EOjGzsAAuI+27yIeeUJaEKPu0o5jGjgVJOVHG52sJ/s/EhURZARhHnVYvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FuLCwpim; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FuLCwpim"
Received: from DESKTOP-0403QTC. (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4A87C20B7165;
	Mon, 19 Aug 2024 08:40:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A87C20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724082057;
	bh=sFr1FN+e4y3O4P7dVsVd8RcdSO7zZRmuxvlh01KKTlg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FuLCwpimvBAmMAe371Ecry1sq9La6BolAAOiA5LNynbEbdHnXTiq42makLKTwyu5o
	 JCupL5q0Sr+7Da+0o3xxvts4W0Iae3QUkldS6zf+1TZPmGUajMyM4VDghENbpP6G+q
	 DSNaqfdNj+kRmVylbYlg5PCKkA3X/QfQRFVm+lEM=
Date: Mon, 19 Aug 2024 08:40:56 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Tina Zhang <tina.zhang@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iommu/vt-d: Introduce batched cache invalidation
Message-ID: <20240819084056.298a9924@DESKTOP-0403QTC.>
In-Reply-To: <afec1d30-4bb3-4d39-9ff1-eb8ecb26bed3@linux.intel.com>
References: <20240815065221.50328-1-tina.zhang@intel.com>
	<20240815065221.50328-5-tina.zhang@intel.com>
	<20240816093846.40dbd623@DESKTOP-0403QTC.>
	<afec1d30-4bb3-4d39-9ff1-eb8ecb26bed3@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Aug 2024 11:28:21 +0800
Baolu Lu <baolu.lu@linux.intel.com> wrote:

> On 2024/8/17 0:38, Jacob Pan wrote:
> > On Thu, 15 Aug 2024 14:52:21 +0800
> > Tina Zhang <tina.zhang@intel.com> wrote:
> >   
> >> @@ -270,7 +343,8 @@ static void cache_tag_flush_iotlb(struct
> >> dmar_domain *domain, struct cache_tag * u64 type =
> >> DMA_TLB_PSI_FLUSH; 
> >>   	if (domain->use_first_level) {
> >> -		qi_flush_piotlb(iommu, tag->domain_id, tag->pasid,
> >> addr, pages, ih);
> >> +		qi_batch_add_piotlb(iommu, tag->domain_id,
> >> tag->pasid, addr,
> >> +				    pages, ih, domain->qi_batch);
> >>   		return;
> >>   	}
> >>   
> >> @@ -287,7 +361,8 @@ static void cache_tag_flush_iotlb(struct
> >> dmar_domain *domain, struct cache_tag * }
> >>   
> >>   	if (ecap_qis(iommu->ecap))
> >> -		qi_flush_iotlb(iommu, tag->domain_id, addr | ih,
> >> mask, type);
> >> +		qi_batch_add_iotlb(iommu, tag->domain_id, addr |
> >> ih, mask, type,
> >> +				   domain->qi_batch);
> >>     
> > If I understand this correctly, IOTLB flush maybe deferred until the
> > batch array is full, right? If so, is there a security gap where
> > callers think the mapping is gone after the call returns?  
> No. All related caches are flushed before function return. A domain
> can have multiple cache tags. Previously, we sent individual cache
> invalidation requests to hardware. This change combines all necessary
> invalidation requests into a single batch and raise them to hardware
> together to make it more efficient.
I was looking at the code below, if the index does not reach
QI_MAX_BATCHED_DESC_COUNT. There will be no flush after
cache_tag_flush_iotlb() returns, right?

+static void qi_batch_increment_index(struct
intel_iommu *iommu, struct qi_batch *batch) +{
+	if (++batch->index == QI_MAX_BATCHED_DESC_COUNT)
+		qi_batch_flush_descs(iommu, batch);
+}
+
+static void qi_batch_add_iotlb(struct intel_iommu *iommu, u16 did, u64
addr,
+			       unsigned int size_order, u64 type,
+			       struct qi_batch *batch)
+{
+	qi_desc_iotlb(iommu, did, addr, size_order, type,
&(batch->descs[batch->index]));
+	qi_batch_increment_index(iommu, batch);
+}

> Thanks,
> baolu

