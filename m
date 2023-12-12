Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A269F1173C
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 06:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZ9SzLBz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702362340; x=1733898340;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kACYgNP4fFKqMuvf/CAgyapT7zWGWBcU7fPSLJDh5J0=;
  b=AZ9SzLBzCE1G0zh4xKXuXLznso2nNEvC/hC6AaqZAcfCi7xDEifd+yRJ
   52mUIKBi6NDBE2hJj+hicBhiMWu9/FVSXjcPLf+rHaqWocMkcQ+9O4wCU
   fB1G/dv4f06YD+Ge9bzNHqPDnHZAWO1UQR0MDP/RP1sSoRIA++rQgtkQl
   /Tgs+CRr6yBH2UkjzGSUEjS08s6Y320UxdMWl7m7jcbd7qs7mRqHiuIVT
   7SG/JdmzhIv4N7yyvSR7iGqurCS/7aF1iJcVaPHnY98xkW9pA+EFufeaQ
   A4ecWgLdDj36qNXKZJAKZ4gOEGSPy2khjvKDiSPihxrRD35J5ScMtMktZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1622587"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="1622587"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 22:25:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="802347749"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="802347749"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga008.jf.intel.com with ESMTP; 11 Dec 2023 22:25:35 -0800
Message-ID: <bef0f903-3665-492f-8999-fe759be5fed4@linux.intel.com>
Date: Tue, 12 Dec 2023 14:20:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] iommu/vt-d: Remove 1:1 mappings from identity
 domain
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52761FF9AB496B422596DDDF8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1161d8aa-9fcc-4e9e-a7d3-c461fee19a54@linux.intel.com>
 <BN9PR11MB5276AC40C423A0BAAE9F40A98C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276AC40C423A0BAAE9F40A98C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 11:58 AM, Tian, Kevin wrote:
>>> there are two cases above which mandates IDENTITY. Have you confirmed
>>> that those platforms support hardware passthrough? otherwise this
>> change
>>> is broken.
>> Those two cases should be hardware quirks for SoC-integrated devices. It
>> makes no reason that a quirk requires IOMMU passthrough translation, but
>> the hardware doesn't support it.
>>
>> If, unfortunately, those quirks turn out to be workarounds for a poorly
>> designed device driver, we should remove those quirks and request the
>> device driver to utilize the DMA ownership framework to achieve the same
>> functionality within the driver itself.
>>
> if that is the case you should fix the drivers first before breaking them.
> 
> But at a glance looks those two quirks are just fine.
> 
> For Azalia sound device the problem is that BIOS enables a dedicated
> DMAR for it but allocates zero TLB entries to cause deadlock. This
> implies a hw passthrough mode otherwise it's still broken.

Yes. It's safe for Azalia sound device.

> 
> For GFX it's a workaround added since day one. there is even still
> an option CONFIG_INTEL_IOMMU_BROKEN_GFX_WA available. But
> now its meaning is really disabling IOMMU instead of using identity.
> 
> sounds like IDENTMAP_GFX can be fully removed now:
> 
> #ifdef CONFIG_INTEL_IOMMU_BROKEN_GFX_WA
> 	dmar_map_gfx = 0;
> #endif

We should already remove the workaround for the 2.6 kernel. :-)

It's default "n". Therefore, if any gfx driver still needs this
workaround, there should already be a bug report.

> 
> 	if (!dmar_map_gfx)
> 		iommu_identity_mapping |= IDENTMAP_GFX;

So with above cleaned up, we have no need to worry about drivers that
are not capable of handling remapped dma address any more.

Did I miss anything?

Best regards,
baolu
