Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499206;
	b=C+eeRAHTpVi0oyNQ8UvaRgcNdmMHrnvwJ1l0fz7HZ6PN2X2IemG59yUZ/Uq0cpVN7TJ8
	 EUmtfxJQAUOaRxziV0OxDny8saqaQAGJP4de7yiT9VXGbN4OyzT5MMqb+hCzinMZ0DEue
	 qb161h1mFf+BnTxYEoPPxf1AyAaJFK6NjLXci67YdcI2Egaq5IHTlkkyZqcwZ8imOvXdL
	 ia4cCZ9ZYg4SFYnW5rtXYoKwd9LN0tmadsZkUohmQy4yqeBAJIldzzjrZWXOBklghT6di
	 8HUSCERRb9zDQr/dIFKOZU5vBL9+c/30mN2QdCDsgWdCIUWIc53U/9nWMueZogWEF4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499206;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Guk8hOxSxZsVVyDu6dmZjVN3ruStpWgA4u4UsRW4Y0o=;
	b=DpkPe8Gpv9/17xFkW4BCAqILDf7Mmuy8zeb7QZb1WerE8iYsE7Wl2bFDrFHXo7CyhNZp
	 czFB4sLzLlvKXalww0eaK+qmOq7BxLvYh6ePKH+9fE5gnxOxnbPTxiY68aNdb/MOp3Y3l
	 DPBf/GcqGydqYbda+1pYqhIO1G2Cmz+nbvnGql0d0K10MSKzAXYJRu5437eYm51FvxpYT
	 apXy8AxqxUT6OLz4lpbOseRNHcbZK2Yeygkwz1BI+DIfH7Ql/rr2wp+zgnKCapP8TkDfT
	 gOPAcrdCaNkDClDux/OLStmiSBXHUb5epFbXH+6rPfCjJzKWFEa7X61DXVXuxAbLmng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BO4qeyBo;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A0606A325
	for <iommu@lists.linux.dev>; Sun,  1 Nov 2026 02:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 990A0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BO4qeyBo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793499206; x=1825035206;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QR9k1q5311EW/AfCDkoFYdwYVJyyH8f3uvJGyNJPUw8=;
  b=BO4qeyBoAUgDVJc79j8TojQ3PsENhWXOotngB5MDYEU05qQNTOUuDENW
   SdvYnXdLelAKsxF9UlHpkT/cBcnoeabL9A7nfg57GVR5lptD2VlL1yaGh
   Xv9p0+Czl8jV9j5BUnhhu/lfw2IM8MRX9HzUOfKAqSZtiUN28V4W2mLWK
   TWgDczQ+1vrqC6XfDr6H5nrORM6ENKHtlsGxO+FxGWbs4AbYJII0qVOTG
   Y59TXhrIv/YDr18Nq2xCp2ouwB2mp0ltES4a4V16RQPykecB3DS2IuAWY
   LBWLdm/ZKbq6d8KKkHjMiZdPTQGFApFenPxo61aqTWRrgFxog4K4E0iGq
   w==;
X-CSE-ConnectionGUID: cWID9NGjRyaBiMvFWlhtvg==
X-CSE-MsgGUID: mglG8vq4TJSrC9S6KS3WuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2252717"
X-IronPort-AV: E=Sophos;i="6.27,189,1787036400"; 
   d="scan'208";a="2252717"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 19:13:25 -0700
X-CSE-ConnectionGUID: z6/eXgFfRZmxTEcwmpXpew==
X-CSE-MsgGUID: AfEumrtbTcqAmATvoou2gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,189,1787036400"; 
   d="scan'208";a="5631974"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 19:13:23 -0700
Message-ID: <762aa8ba-8e4a-420f-81d6-607c79d9363a@linux.intel.com>
Date: Sun, 1 Nov 2026 10:13:20 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] iommu: Unpublish the attach handle before the
 PASID detach callback
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
 Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1790718296.git.nicolinc@nvidia.com>
 <3d6731c5c3502380b4de3c90a1f6ba5547f0dd85.1790718296.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3d6731c5c3502380b4de3c90a1f6ba5547f0dd85.1790718296.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/2026 5:51 AM, Nicolin Chen wrote:
> iommu_detach_device_pasid() erases the group->pasid_array entry only once
> __iommu_remove_group_pasid() has returned, so the detaching handle stays
> visible to iommu_attach_handle_get() for the whole of that callback, and
> the caller frees it as soon as the detach returns.
> 
> Erase the entry ahead of the callback, for the same reason the group path
> does: a fault raised in the meantime must not resolve to a domain that is
> on its way out.
> 
> Fixes: 16603704559c ("iommu: Add attach/detach_dev_pasid iommu interfaces")
> Cc:stable@vger.kernel.org
> Assisted-by: LLM

ditto

> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a062a84686c29..19b880d23314b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3818,8 +3818,12 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
>   	struct iommu_group *group = dev->iommu_group;
>   
>   	mutex_lock(&group->mutex);
> -	__iommu_remove_group_pasid(group, pasid, domain);
> +	/*
> +	 * Unpublish the handle first, so it would not resolve to the detaching
> +	 * domain once the driver is detaching it.
> +	 */
>   	xa_erase(&group->pasid_array, pasid);
> +	__iommu_remove_group_pasid(group, pasid, domain);
>   	mutex_unlock(&group->mutex);
>   }
>   EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
