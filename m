Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998E361
	for <iommu@lists.linux.dev>; Sun, 25 Dec 2022 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671974177; x=1703510177;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0AUUMSVBSULgI6+gop4YNd2amu+IyDWT9Tic3OuWVe0=;
  b=SAfNJ8OSueVP7rHxFBgaXzO5s5qzRGFlTY/0Z31XWURa+FsCe84mSs2G
   0n8XZK2VNYGyO3J2qBuROFqvehK28XFSi9JZlwPT3JqDUB05qmCklzxr2
   JIJQ61AFnEC0NiLhgoHRjGJRkN2pPhHGzmtUKtbvhn+sHisos+MFBZuT2
   j2kVZ0VJSgMX/SiQoL6qku9h789VF7WuDBfcJwronxzDJEIjzzK+usSHt
   CTiARPh+Ncruqoq/r+qFHAXk3xAE9S2jyU37GfOhnJKNxrrra+RMgtiqd
   TqyOrY+DMA0/MUBT0LOs4QXob1wRclE2dYK8Bcc9AGYW+s2zEKU7o2hHT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="384892608"
X-IronPort-AV: E=Sophos;i="5.96,273,1665471600"; 
   d="scan'208";a="384892608"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2022 05:16:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="652545816"
X-IronPort-AV: E=Sophos;i="5.96,273,1665471600"; 
   d="scan'208";a="652545816"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.120]) ([10.254.211.120])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2022 05:16:14 -0800
Message-ID: <6531c0eb-5ca7-9026-a8b7-eb4442629d0d@linux.intel.com>
Date: Sun, 25 Dec 2022 21:16:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, dwmw2@infradead.org, iommu@lists.linux.dev,
 joro@8bytes.org, jroedel@suse.de, robin.murphy@arm.com, will@kernel.org,
 yangyingliang@huawei.com
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix PCI device reference count leak in
 has_external pci()
To: Zeno Davatz <zdavatz@gmail.com>, wangxiongfeng2@huawei.com
References: <D41A3A42-2412-4722-9090-01565058E525@gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <D41A3A42-2412-4722-9090-01565058E525@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/12/25 20:11, Zeno Davatz wrote:
> Hi
> 
> I am getting this hang with kernel 6.1. See attachment.
> 
> Is this related to your patch?
> 
> Kernel 6.1 does not boot for me. Kernel 6.0 was fine.

It seems unlikely.

Have you located the patch through the bisect tool? Or does it boot well
if you revert this patch?

--
Best regards,
baolu
