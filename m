Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC977B
	for <iommu@lists.linux.dev>; Wed, 29 Jun 2022 00:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656462297; x=1687998297;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gNrBHCQAvCRcX09U/UlWMcKB1+tzLb4/Y4Z/doplvUA=;
  b=LcVpow0jlsl3hf8DwsbTB16DJuWgYk72eRoWH0QXFe2hrajTojfgxyjD
   0e8cJD2AN7rrlsBEyI5FCYv2RDMeaYUF+5dovHzgDjfjDsIoF7APE47qS
   Kg/lAGNQ60gAXEKUfx8EcaTndeOq3I1UFgE1eBC9iEhRE6ZUIWoZYKyaO
   uQP81s4emfx/MB+TIWuHkyQYK71LSp6+ZrLW+BQktComwBBTKyil2Bq3X
   SMJkx9MoopHfh4kES5wRtV0+oHixi9WVGX2zn2HbaahPkCpL2R3yc3NYD
   iyE94O6z7DLBlbb4ukExQbL9+KvZwKDSA9Cm2nIs4OYyhUDArgQHZntD/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="262290644"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="262290644"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 17:24:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="647142607"
Received: from xuepengx-mobl1.ccr.corp.intel.com (HELO [10.255.29.216]) ([10.255.29.216])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 17:24:51 -0700
Message-ID: <bf2ae213-b938-2550-b367-f548fc755e99@linux.intel.com>
Date: Wed, 29 Jun 2022 08:24:49 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, Ethan Zhao <haifeng.zhao@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, iommu@lists.linux-foundation.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
 <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
 <75b17c70-1658-91ea-0992-1be769550943@linux.intel.com>
 <935ca9e3-28c9-99af-5609-41bb1500b2b3@linux.intel.com>
 <YrsOO9E+j+CMgKMA@myrica>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YrsOO9E+j+CMgKMA@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID: <20220629002449._r3tpA_ZL0fFI_v1Y5G2QFpMZi8Qp94sya1Jkaag5wE@z>

On 2022/6/28 22:20, Jean-Philippe Brucker wrote:
> On Tue, Jun 28, 2022 at 07:53:39PM +0800, Baolu Lu wrote:
>>>>> Once the iopf_handle_single() is removed, the name of
>>>>> iopf_handle_group() looks a little weired
>>>>>
>>>>> and confused, does this group mean the iommu group (domain) ?
>>>>> while I take some minutes to
>>>>
>>>> No. This is not the iommu group. It's page request group defined by the
>>>> PCI SIG spec. Multiple page requests could be put in a group with a
>>>> same group id. All page requests in a group could be responded to device
>>>> in one shot.
>>>
>>> Thanks your explaination, understand the concept of PCIe PRG.  I meant
>>>
>>> do we still have the necessity to mention the "group" here in the name
>>>
>>> iopf_handle_group(),  which one is better ? iopf_handle_prg() or
>>>
>>> iopf_handler(),  perhaps none of them ? :)
>>
>> Oh! Sorry for the misunderstanding.
>>
>> I have no strong feeling to change this naming. :-) All the names
>> express what the helper does. Jean is the author of this framework. If
>> he has the same idea as you, I don't mind renaming it in this patch.
> 
> I'm not attached to the name, and I see how it could be confusing. Given
> that io-pgfault is not only for PCIe, 'prg' is not the best here either.
> iopf_handle_faults(), or just iopf_handler(), seem more suitable.

Okay, so I will rename it to iopf_handle_faults() in this patch.

Best regards,
baolu
