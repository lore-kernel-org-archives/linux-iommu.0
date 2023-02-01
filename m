Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9157F4
	for <iommu@lists.linux.dev>; Wed,  1 Feb 2023 05:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675230673; x=1706766673;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UpSfjG2fNdu4lyj9iOWuaj3VrvjjDLnBYjkh3m1GIYY=;
  b=nLS4Gq93azT+dsdaazPk1csB0z+6dMxdc02CK8Kja/xAooxyI4PyQFjI
   sM7eBthY8zExxl+NuNTJ0LBklD3yXWj6o2F1iPx4M3Cx5tN7/tTiwpyyz
   DUlQDRM1Cdx8xYqlY17jnqNH9Ur4WEgazWDHTq4ZIhscya92C5y509ZnS
   tD0ZFXAVDIjc0pPvey5WDgXF/JnIbBZrHQFF0GQGaFjxX4tEIwj6K+tuM
   E8LNFDawTpalYjQa0eXMqsMGYq0wU2npE+9vDvCxE/PePvgqegE5askVq
   OWCe+icA290neDOR5rrORlliWqDFWKy6X5POf1JEYBJ7mY8Fyubjq6okQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="325754969"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="325754969"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 21:51:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="773302025"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="773302025"
Received: from xduan-mobl1.ccr.corp.intel.com (HELO [10.254.215.167]) ([10.254.215.167])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 21:51:09 -0800
Message-ID: <c15d0137-af02-ab85-70f3-def691d8f81b@linux.intel.com>
Date: Wed, 1 Feb 2023 13:51:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 Joerg Roedel <jroedel@suse.de>, Matt Fagnani <matt.fagnani@bell.net>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Tony Zhu <tony.zhu@intel.com>,
 linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20230201001419.GA1776086@bhelgaas>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230201001419.GA1776086@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/2/1 8:14, Bjorn Helgaas wrote:
>> The translated address is specified by the IOMMU driver. The IOMMU
>> driver ensures that the address is a DMA buffer address instead of any
>> P2P address in the PCI fabric. Therefore, any translated memory request
>> will eventually be routed to IOMMU regardless of whether there is ACS
>> control in the up-streaming path.
> A Memory Request with an address that is not a P2P address, i.e., it
> is not contained in any bridge aperture, will*always*  be routed
> toward the RC, won't it? 

Yes.

> Isn't that the case regardless of whether
> the address is translated or untranslated, and even regardless of ACS?

They are different. The translated addresses are approved by the Linux
kernel. But untranslated addresses are not. Malicious or buggy userspace
applications could program the device to DMA to addresses locating in
the P2P aperture.

> IIUC, ACS basically causes peer-to-peer requests to be routed upstream
> instead of directly to the peer.

Yes.

Best regards,
baolu
