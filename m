Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61896290D
	for <iommu@lists.linux.dev>; Fri, 27 Jan 2023 13:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674827436; x=1706363436;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1HoU09wxIsmJZMeT/Je08YK0drRTOVXFBoeOmomdWNc=;
  b=UGa7SqqhQaY/KM4PDQhoY2VBbeNwzfIjWvpZy9WJSPF395gNgPponPOr
   zF3Iqr1lDin4IbuHBQ9ZGCV2rrrPP/RpgW4MTwOlAvWhvvpXTmrM2/uz7
   NfWknL6vGcmxfdcV2hhbg5aKsgp8ULJdzEj5iZ07T+PouEDXR8lyU2yHv
   MLRyN2FTGi03z4S70Luqq/xae/OTAmx/zZQcoEEi8shT58PrFRfpkvzHG
   ND4yH2lLnJPWYXIWphX9ZtOyxOtthLX1f7pq5vH5vppmS5Z5WunCI/Yx2
   H5aDIJk7HJ6cHyJoJnkiPB0lesvkGgwmO08uhEZn2GbEisbj9EG0ES7bh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="325760612"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="325760612"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 05:50:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="656599660"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="656599660"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.130]) ([10.252.191.130])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 05:50:32 -0800
Message-ID: <b6b55688-1390-4e92-8184-770154a8955d@linux.intel.com>
Date: Fri, 27 Jan 2023 21:50:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org, hch@lst.de,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iommu: Decouple iommu_present() from bus ops
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
References: <cover.1673978700.git.robin.murphy@arm.com>
 <1fb168b22cbbb5c24162d29d2a9aca339cda2c72.1673978700.git.robin.murphy@arm.com>
 <c96aaa6c-0f46-39dc-0c72-f38394e37cc3@linux.intel.com>
 <ce25dcdc-99a9-61ff-0cad-6c6cd9552680@arm.com> <Y9KRBRKdwSIRrvQw@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y9KRBRKdwSIRrvQw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/1/26 22:41, Jason Gunthorpe wrote:
> On Thu, Jan 26, 2023 at 02:21:29PM +0000, Robin Murphy wrote:
> 
>> The "check" is inherent in the fact that it's been called at all. VFIO
>> noiommu*is*  an IOMMU driver in the sense that it provides a bare minimum of
>> IOMMU API functionality (i.e. creating groups), sufficient to support
>> (careful) usage by VFIO drivers. There would not seem to be a legitimate
>> reason for some*other*  driver to be specifically querying a device while it
>> is already bound to a VFIO driver (and thus may have a noiommu group).
> Yes, the devices that VFIO assigns to its internal groups never leak
> outside VFIO's control during their assignment - ie they are
> continuously bound to VFIO never another driver.
> 
> So no other driver can ever see the internal groups unless it is
> messing around with devices it is not bound to 😄

Fair enough. I was thinking that probably we could make it like below:

/**
  * device_iommu_mapped - Returns true when the device DMA is translated
  *                       by an IOMMU
  * @dev: Device to perform the check on
  */
static inline bool device_iommu_mapped(struct device *dev)
{
         return (dev->iommu && dev->iommu->iommu_dev);
}

The iommu probe device code guarantees that dev->iommu->iommu_dev is
valid only after the IOMMU driver's .probe_device returned successfully.

Any thoughts?

Best regards,
baolu
