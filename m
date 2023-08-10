Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8CB634
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 01:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691630614; x=1723166614;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I3CngUi8vhKHabYkxIW1a+jmYrp3dBujJNCcldodz6s=;
  b=lfxazE4ns1iGajA7g63GkfRJHQgAKXLKrk2g2A+SIjEJAr0tKWHpSGy6
   zECEGTsS9+UHi5oiTkSH3DfOFft15R+OsuwsTo0IulbfPT6TwI9wxou/l
   Q0Sw+qqRahoLV1zl4RkBHUCUanZFgeAtoKwbwJCEY59ndfM7VslADyL+y
   UUOoUUpNG9ocgDXIwh0Zbs4G0SHRWw4PV7Q8sE6bipiFSGUMjm42E+V/o
   URma/EabzeN3rtd8dHZEjOhwfylNIngASLtecNUj7lS/fHihVI/adTXYN
   EpD595/EgY4ncRChlbSMsaUN8vFVMMcFMzK1ndPTUINOlyg1CVEepE1q4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="351573639"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="351573639"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 18:23:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="978601698"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="978601698"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.239]) ([10.254.214.239])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 18:23:25 -0700
Message-ID: <84ee4ce8-8589-68da-b105-f96c961ade16@linux.intel.com>
Date: Thu, 10 Aug 2023 09:23:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com, Tina Zhang <tina.zhang@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Michael Shavit <mshavit@google.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Share sva domains with all devices bound to a mm
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <184044ad-880f-5452-727b-f7fd18330c22@linux.intel.com>
 <ZNOmsfE3Eheuelv8@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZNOmsfE3Eheuelv8@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/9 22:46, Jason Gunthorpe wrote:
> On Wed, Aug 09, 2023 at 08:18:18AM +0800, Baolu Lu wrote:
>> On 2023/8/8 15:49, Tina Zhang wrote:
>>> A sva domain's lifetime begins with binding a device to a mm and ends
>>> by releasing all the bound devices from that sva domain. Technically,
>>> there could be more than one sva domain identified by the mm PASID for
>>> the use of bound devices issuing DMA transactions.
>>>
>>> To support mm PASID 1:n with sva domains, each mm needs to keep both a
>>> reference list of allocated sva domains and the corresponding PASID.
>>> However, currently, mm struct only has one pasid field for sva usage,
>>> which is used to keep the info of an assigned PASID. That pasid field
>>> cannot provide sufficient info to build up the 1:n mapping between PASID
>>> and sva domains.
>> Is it more appropriate to have the same life cycle for sva domain and mm
>> pasid? I feel that they represent the same thing, that is, the address
>> space shared by mm to a device.
> No! The iommu_domain and the PASID are totally seperate objects with
> their own lifecycles.
> 
> The SVA domain should NEVER be tied to the mm enqcmd PASID.

Okay. Fair enough.

> 
> We might decide to free all the domains and keep the PASID around (can
> we even revoke the enqcmd pasid while the MM is alive?)

We ever did this and was removed to make code simple.

Best regards,
baolu
