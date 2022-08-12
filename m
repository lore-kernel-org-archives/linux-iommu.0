Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A291366
	for <iommu@lists.linux.dev>; Fri, 12 Aug 2022 03:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660275835; x=1691811835;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G7EWEWn+e0D+6PSc/7cEd7OI0+k/W+9AAEuBQz8vlds=;
  b=SU/eCHcCC5plEZTpB8I9rIynlYzCJ1c6KESDTZyrQmvo1XR/R3uwRT7v
   AYIytQCSVRJAFy0n9G6UjBkEWAa8bQDjY1j2zFvbJH1m2balNTEUe/vMb
   584thTOa3caq2TSzakEWb6dOiDpK+7clZQvc235JP/zpXsiWrPCRbkpmP
   ywaUSOfOWJTQc6/n/x1kCCEoaQU9gLc2JlaaajJxJ68m8mzR+dlk7qf9i
   J12w+X7L9DA2sHDkWA3NgFZmoQQw1lYZfzZWAbcj6IgJfqVPY/TpNX5b1
   rP9HbMDz6UHQBcZ/nadFS6F5tmS/sdbh60ASdh5cGmhpExKuKVuOmWOgG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="290269429"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="290269429"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 20:43:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="665662478"
Received: from jzhou16-mobl2.ccr.corp.intel.com (HELO [10.254.214.221]) ([10.254.214.221])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 20:43:52 -0700
Message-ID: <ed90e585-d5e8-15b6-6285-67ecc53f05ca@linux.intel.com>
Date: Fri, 12 Aug 2022 11:43:50 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Wen Jin <wen.jin@intel.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix kdump kernels boot failure with
 scalable mode
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20220808034612.1691470-1-baolu.lu@linux.intel.com>
 <20220808162146.jrykclf5ez4o7j2t@cantor>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220808162146.jrykclf5ez4o7j2t@cantor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jerry,

On 2022/8/9 00:21, Jerry Snitselaar wrote:
> On Mon, Aug 08, 2022 at 11:46:12AM +0800, Lu Baolu wrote:
>> The translation table copying code for kdump kernels is currently based
>> on the extended root/context entry formats of ECS mode defined in older
>> VT-d v2.5, and doesn't handle the scalable mode formats. This causes
>> the kexec capture kernel boot failure with DMAR faults if the IOMMU was
>> enabled in scalable mode by the previous kernel.
>>
>> The ECS mode has already been deprecated by the VT-d spec since v3.0 and
>> Intel IOMMU driver doesn't support this mode as there's no real hardware
>> implementation. Hence this converts ECS checking in copying table code
>> into scalable mode.
>>
>> The existing copying code consumes a bit in the context entry as a mark
>> of copied entry. This marker needs to work for the old format as well as
>> for extended context entries. It's hard to find such a bit for both
>> legacy and scalable mode context entries. This replaces it with a per-
>> IOMMU bitmap.
>>
>> Fixes: 7373a8cc38197 ("iommu/vt-d: Setup context and enable RID2PASID support")
>> Cc:stable@vger.kernel.org
>> Reported-by: Jerry Snitselaar<jsnitsel@redhat.com>
>> Tested-by: Wen Jin<wen.jin@intel.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
> I did a quick test last night, and it was able to harvest the vmcore,
> and boot back up. Before you mentioned part of the issue being that it
> couldn't get to the PGTT field in the pasid table entry. Was that not
> the case, 

It is the case from IOMMU hardware point of view.

> or is it looking at the old kernel pasid dir entries and
> table entries through the pasid dir pointer in the copied context
> entry?

Yes. It reuses the pasid table in old kernel and replaces it until the
new device driver takes over and starts the first DMA operation.

Best regards,
baolu
