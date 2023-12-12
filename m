Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB15156C3
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 05:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyH+DHnG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702359542; x=1733895542;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=URPPQzLd2OI8UNUzOy+LBsiW7V7L/EcaPm3oslOKIC4=;
  b=fyH+DHnG8dzbokKj0RU0RmEzqx6fvAlNNLgSHOLolBtTN6GJlGGUeayI
   +w3OitBH57j3PQMCLEVb6Mc4kUl5wLBFg+Kfm5tuhfdTbzWyRAqTCPtUH
   We3RJr6gzaSwsGPVcoNE4Mx5zZzXNQN69/TuMSGoaRTZc+1vNzJrKM0b9
   J/lHTJdaMGZxWE3HHqkeU8vLC66E+y2GiU3YV12YZ0NGLHs8R19iaxGlG
   LPgV/dSXSv1Q/jLc2weCL9iM/ksBinlG8vnNKS1WsxokeGrSynXlCItgt
   RbUMkKPy9CAkpi7fEWWAgWumvlmON5ji1xBgPXORJO8Yg7gJnQXUpgxTd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="461231782"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="461231782"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 21:39:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="917149775"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="917149775"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga001.fm.intel.com with ESMTP; 11 Dec 2023 21:38:58 -0800
Message-ID: <11b4b1db-2fde-413c-a203-0734bc18f4f7@linux.intel.com>
Date: Tue, 12 Dec 2023 13:34:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iommu/vt-d: Setup scalable mode context entry in
 probe path
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-2-baolu.lu@linux.intel.com>
 <20231211173826.GE1489931@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231211173826.GE1489931@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/23 1:38 AM, Jason Gunthorpe wrote:
> On Tue, Dec 05, 2023 at 09:21:58AM +0800, Lu Baolu wrote:
>> +/*
>> + * Get the PASID directory size for scalable mode context entry.
>> + * Value of X in the PDTS field of a scalable mode context entry
>> + * indicates PASID directory with 2^(X + 7) entries.
>> + */
>> +static unsigned long context_get_sm_pds(struct pasid_table *table)
>> +{
>> +	unsigned long pds, max_pde;
>> +
>> +	max_pde = table->max_pasid >> PASID_PDE_SHIFT;
>> +	pds = find_first_bit(&max_pde, MAX_NR_PASID_BITS);
>> +	if (pds < 7)
>> +		return 0;
>> +
>> +	return pds - 7;
> This seems like a convoluted way to write
>    max(ilog2(table-max_pasid) - 7,0)
> 
> ?

Yes. :-)

Something like,

     max(ilog2(table->max_pasid >> PASID_PDE_SHIFT) - 7, 0)

Best regards,
baolu
