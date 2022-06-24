Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E942423B5
	for <iommu@lists.linux.dev>; Fri, 24 Jun 2022 07:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656057393; x=1687593393;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vztMzndG2ocVKYEbsSlsSSVXFya6CxLdUL/XzbaI5lY=;
  b=XeRJFhNo7Y/k1EsJ0a62Qof6ZZQlc6KtlOaEsnn8yUKO87OegG6aeD08
   T3w98vy9tfd3XRPUWY+zjCsj3Q7dvybHWdfeSjgzs+3/30kprTW67kJRa
   tRznKi/4hIcdYZBvrt98vIrvWMDxRU3jlysjMqgn+tXp6Q4iPnhJPO43r
   /ku5tLtK5Ykx73WOd91bOhguyVkrsWq9qeHA0NcbxePDIKR2thvpIlvM0
   MzKNG1D0i+YwRjfNSQuN+AOA6W3n+Vku9B97f+vycm07cjkCywiL2Y9et
   uZaycZ17vkjnjP21/HbZSOZdwSShtv7/pkrcfLJznfaJhw+hHTKizFhoB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="280992313"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="280992313"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 00:56:27 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="593114566"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.209.161]) ([10.254.209.161])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 00:56:22 -0700
Message-ID: <6ef6c341-924c-57a6-154e-b804d8b0f2c7@linux.intel.com>
Date: Fri, 24 Jun 2022 15:56:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/1] iommu/vt-d: Fix RID2PASID setup/teardown failure
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, iommu@lists.linux-foundation.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20220623065720.727849-1-baolu.lu@linux.intel.com>
 <eb2257b1-1213-1001-74bd-085af5d50dad@linux.intel.com>
 <b8a7ab77-935d-459c-7f65-628fcf828fad@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <b8a7ab77-935d-459c-7f65-628fcf828fad@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID: <20220624075620.tMxlMYwTCzCwxfgIkNUShMumHrC0HBD6DDgxuskU53c@z>


在 2022/6/24 14:54, Baolu Lu 写道:
> On 2022/6/24 14:02, Ethan Zhao wrote:
>> 在 2022/6/23 14:57, Lu Baolu 写道:
>>> The IOMMU driver shares the pasid table for PCI alias devices. When the
>>> RID2PASID entry of the shared pasid table has been filled by the first
>>> device, the subsequent device will encounter the "DMAR: Setup RID2PASID
>>> failed" failure as the pasid entry has already been marked as present.
>>> As the result, the IOMMU probing process will be aborted.
>>>
>>> On the contrary, when any alias device is hot-removed from the system,
>>> for example, by writing to /sys/bus/pci/devices/.../remove, the shared
>>> RID2PASID will be cleared without any notifications to other devices.
>>> As the result, any DMAs from those rest devices are blocked.
>>>
>>> Sharing pasid table among PCI alias devices could save two memory pages
>>> for devices underneath the PCIe-to-PCI bridges. Anyway, considering 
>>> that
>>> those devices are rare on modern platforms that support VT-d in 
>>> scalable
>>> mode and the saved memory is negligible, it's reasonable to remove this
>>> part of immature code to make the driver feasible and stable.
>> In my understanding, thus cleanning will make the pasid table become
>> per-dev datastructure whatever the dev is pci-alias or not, and the
>> pasid_pte_is_present(pte)will only check against every pci-alias' own
>> private pasid table,the setup stagewouldn't break, so does the
>> detach/release path, and little value to code otherreference counter
>> like complex implenmataion, looks good to me !
>
> Thanks! Can I add a Reviewd-by from you?
Sure !
>
> Best regards,
> baolu

-- 
"firm, enduring, strong, and long-lived"

