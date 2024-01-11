Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027FF815
	for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 02:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpIyvaVl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704941202; x=1736477202;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RxYhOnVKcdyE+mpRMR1JHS3uYWZrk1eIb63EEi3VR/U=;
  b=VpIyvaVlmFMwbdGuZiBG8jDF27UJyEcklyWTZW+Yio+54w0SFRaAaeqS
   ZwSoSRdP3b/l5tqJkYVAwM26WXIW5v4IS6oSe9zvEp/yYIDlVbhb612hn
   +6tI4bW2rQ/qP2HBnLEwXBfL5QvoAr/YmRCt+3H3m1WSf64wLrHYqTzuv
   QBrYoFP6ZIZ1nkxprlvFcaIFvr52KKGlCIyenIDI5slEMboHjt+Dc0d1A
   4uNwMC5mKEpSW5NZb27w0fZ8A0sdco+SZq/qxbmY3y3H6b+o4WnTGNeZC
   A2kGUaLG0ikgCZxSus6/AFPYoa1RDUcNCuC9siu8QduKRt5J1n4piu4Bb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5804354"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="5804354"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 18:46:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="775451985"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="775451985"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 10 Jan 2024 18:46:39 -0800
Message-ID: <e4ac7050-25aa-4418-b252-c8f6bd76fe6f@linux.intel.com>
Date: Thu, 11 Jan 2024 10:41:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com
Subject: Re: IOMMU iotlb cache question
Content-Language: en-US
To: Muzammil Ashraf <m.muzzammilashraf@gmail.com>, iommu@lists.linux.dev
References: <CAJHePoZXinTe_8=4mshWhkV315qGcV9xNwSv=CEE_Cog99j2aw@mail.gmail.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CAJHePoZXinTe_8=4mshWhkV315qGcV9xNwSv=CEE_Cog99j2aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/10/24 5:55 PM, Muzammil Ashraf wrote:
> Hi All,
> 
> I am working with iommu on Linux. What is the maximum number of
> entries iommu iotlb cache can hold?
This seems to be hardware implementation-specific. Currently, I don't
see any interfaces for the OS to query this capacity.

Best regards,
baolu
