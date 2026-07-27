Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D473F412B
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147310; cv=none; b=rx6OKbW54UR2XvC8L5KXiigl0A8TAOydZeEpmyEGaM0Uqn7j0zS/rGnaLV07s8NfUVUMvB/QAhuIy6bPipmktEv9a8AnWot3nenTx4v1u+iaYDRFh/EMGfYgOCJ81/TyNdhQ6GiaJsxFi/XimTpRfMAmLShEEeUk9bt3OKBp26Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147310; c=relaxed/simple;
	bh=VDnyyVNThEQV9k6MNnaFpUVWWjgDaNBDg5/X8Fevi0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lznTOiHAPvWgSt89VBvkiwPGAIkuP84xHQUy1Wp3IlrUbZbkvCYyYWwtRNpL1YVAk0Frr3ALlHmx5whWGndGoGAvepPNaAVxYvfvjllxWEo4XEfnxebIaOFN1uIoFrq7GjxdGQXdh+qxHP9zPN3Mgj5ZXXSEhFQJSlas7vas/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IjDSVMEc; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IjDSVMEc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785147300; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4CYvgooI6FI1FO4hfa2QyxZtukpG/urkU0Q8oDj3wFY=;
	b=IjDSVMEcHgZFyOX+V18xIPYoJI9+sME2wl0ea7Jff/45A6x5YYLNsIXUtkKDeRYVF20DQ5YODVOjLPfvIByxLuV9SD5EnxHc8cex51pG6b2gcy19GJp6GgllUFdejoXQ8TuFCPZ/dQm2R7h1NmGFvJ62Ot9b5HfOnNefPb42dZc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X7torup_1785147297;
Received: from 30.246.177.244(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X7torup_1785147297 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 27 Jul 2026 18:14:58 +0800
Message-ID: <5da226e5-4e84-4b9e-8f46-140323d22706@linux.alibaba.com>
Date: Mon, 27 Jul 2026 18:14:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iommu/sva: Set handle->dev before the SVA handle is
 visible
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "oliver.yang@linux.alibaba.com" <oliver.yang@linux.alibaba.com>,
 "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
References: <cover.1785050951.git.xueshuai@linux.alibaba.com>
 <c22e9af74d113b110348b995879baf2fd4734fe7.1785050951.git.xueshuai@linux.alibaba.com>
 <CO1PR11MB4835CBEA67280A7722E8DCA68CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <CO1PR11MB4835CBEA67280A7722E8DCA68CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/27/26 5:38 PM, Tian, Kevin wrote:
>> From: Shuai Xue <xueshuai@linux.alibaba.com>
>> Sent: Sunday, July 26, 2026 3:43 PM
>>
>> iommu_attach_device_pasid() installs the new SVA attach handle in the
>> group PASID lookup before iommu_sva_bind_device() returns. A concurrent
>> bind can therefore find and reuse the same handle after iommu_sva_lock is
>> dropped.
>>
>> handle->dev was initialized after dropping iommu_sva_lock. This leaves a
>> window where a racing bind can return a handle whose dev pointer is still
>> NULL. A subsequent iommu_sva_unbind_device() can then dereference it via
>> handle->dev->iommu_group.
> 
> ideally this will bail out early:
> 
>          mutex_lock(&iommu_sva_lock);
>          if (!refcount_dec_and_test(&handle->users)) {
>                  mutex_unlock(&iommu_sva_lock);
>                  return;
>          }
> 

Thanks Kevin for pointing this out.

Yes, the non-last reference case should bail out before using
handle->dev. I will wait a bit for other review comments and then decide
whether a v2 is needed to clarify the commit message.

>>
>> Initialize handle->dev before releasing iommu_sva_lock so any visible SVA
>> handle is fully initialized.
>>
>> Fixes: be51b1d6bbff ("iommu/sva: Refactoring
>> iommu_sva_bind/unbind_device()")
>> Cc: stable@vger.kernel.org
>> Assisted-by: Qoder:Qwen-3.8-MAX-Preview
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> but the fix is correct.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thanks for the review.

Best Regards,
Shuai
