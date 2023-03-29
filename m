Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBF22582
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 13:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680097880; x=1711633880;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AExHvrw0V7PC8KzqoXRL0VYvffyZHdQPRSiqWCChjoQ=;
  b=ih6j7Gp2qKJeWsHtkg7oGhVDu6uf/O49r87fa1H/72JWUQsLAfcbpw1e
   J85TQg/bn2Xc5BUnRe0W62Vo5DKlJv/H2JQ9RFXpd2yAuFgsPGW6APCZI
   +GCIzy2ELijcVQnExo3QUf/i8ZtvSNXS8/1ZTd5unnMI/7cMBGzGdiRzf
   IDJFkDbaQJNWXM3r930Z67BkJDyVpea42a/6E5Oe8n2g2Eu4kiVTPZfCi
   UJkPceCxkTQ73vtgAwQil/9ZJHlEylfmO4U5sNwRdGPbMCuh7cWxqQFDD
   Gbmq1ebF/bs9AVVloti5Afg56j/SE92zhB+goZgXRy+ylCeSTKw8j+kPT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="405823506"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="405823506"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:51:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="684268881"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="684268881"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.217]) ([10.254.214.217])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:51:18 -0700
Message-ID: <0df5511e-6d10-5d68-073d-d8c41056fde6@linux.intel.com>
Date: Wed, 29 Mar 2023 21:51:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: baolu.lu@linux.intel.com, "Ma, Yongwei" <yongwei.ma@intel.com>
Subject: Re: [PATCH 1/4] iommu/vt-d: Fix null pointer access in
 invalidate_range callback
Content-Language: en-US
To: "Zhang, Tina" <tina.zhang@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20230329124654.2698853-1-tina.zhang@intel.com>
 <20230329124654.2698853-2-tina.zhang@intel.com>
 <534e6556-40e8-82f7-b3f6-0d0ad67616c0@linux.intel.com>
 <MW5PR11MB588152CDCD93B26592B7F99C89899@MW5PR11MB5881.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <MW5PR11MB588152CDCD93B26592B7F99C89899@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/29 21:40, Zhang, Tina wrote:
>> -----Original Message-----
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Wednesday, March 29, 2023 9:31 PM
>> To: Zhang, Tina<tina.zhang@intel.com>;iommu@lists.linux.dev
>> Cc:baolu.lu@linux.intel.com; Ma, Yongwei<yongwei.ma@intel.com>
>> Subject: Re: [PATCH 1/4] iommu/vt-d: Fix null pointer access in invalidate_range
>> callback
>>
>> On 2023/3/29 20:46, Tina Zhang wrote:
>>> Add the missing check to avoid null pointer dereference.
>>>
>>> The patch fixes below issue reported by klocwork tool:
>>> Pointer 'info' returned from call to function 'dev_iommu_priv_get'
>>> at line 180 may be NULL and may be dereferenced at line 186.
>>>
>>> This patch can fix a potential null pointer dereference issue of
>>> releasing a device working in svm mode.
>> The svm logic guarantees that __flush_svm_range_dev() only be called after
>> iommu_sva_bind_device() and before iommu_sva_unbind_device(). Thus @info
>> should never be NULL. There's no need to add this check.
> Yes, if the order can be ensured, no need to worry about the null pointer. How about hot-plugging devices? Can we keep the order all the time? Otherwise, it seems adding a null check makes sense.

Removing a device always happens after driver unbinding. The driver
should unbind sva in its release path.

Best regards,
baolu
