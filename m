Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B708A33EF
	for <iommu@lists.linux.dev>; Tue, 31 Jan 2023 12:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675167911; x=1706703911;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xwpytf7n2WVkp5REBbivE5cf38oXPNvYW56xA7xKr2k=;
  b=HRB/xJLuZJ8Of+vPMUyYZRSNe/UX17NKqDRGOVMoQjrMjJGelB6J2ejt
   8O/ad2aNcBTJdflybVQ+A/1HREewC596/Whot/HPUxNGke998WmKe8NQN
   M6cJbOsLNwFsm641tB9eoutpHMhKzFqbsCST4eAYOQeWnC9Mo7uiO5dVw
   NH1/yuL1aEOLysflC8HlS25DOz+5VnfambDQVhJXqqzcbaFQEA5iYvSIf
   kcZrQNSr6r7QO5uMe/NzQrAu1hL68Hk7VtpcX6TPXOwtf8h3NbNaqG+gK
   BUY7Cwmeq456BW2gzdH4zz3DcxSzUcPTc5QMKvuR1BRy0sXTWM+zCQxGc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="390188362"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="390188362"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 04:25:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657853563"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="657853563"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.172.41]) ([10.249.172.41])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 04:25:07 -0800
Message-ID: <8cb478bf-db44-0a8f-8521-771529ca0706@linux.intel.com>
Date: Tue, 31 Jan 2023 20:25:05 +0800
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
References: <20230130183810.GA1692786@bhelgaas>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230130183810.GA1692786@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/1/31 2:38, Bjorn Helgaas wrote:
> PCIe r6.0, sec 6.20.1:
> 
>    A Function is not permitted to generate Requests using Translated
>    Addresses and a PASID unless both PASID Enable and Translated
>    Requests with PASID Enable are Set.
> 
> You want AMD graphics devices to do DMA with translated addresses and
> PASID, right?  pci_enable_pasid() sets PASID Enable
> (PCI_PASID_CTRL_ENABLE), but I don't see where "Translated Requests
> with PASID Enable" is set.  We don't even have a #define for it.
> 
> I would think we should check "Translated Requests with PASID
> Supported" before setting "Translated Requests with PASID Enable",
> too?

This seems to be an ECN for PCIe 5.x:

https://members.pcisig.com/wg/PCI-SIG/document/14929

What I read from this ECN is that,

With this ECN, translated memory requests for PASIDs are not allowed to
carry a PASID prefix if "Translated Requests with PASID Enabled" is not
set. It does not mean whether the device can generate translated memory
requests for PASID, but whether the memory request can carry a PASID
prefix.

Best regards,
baolu
