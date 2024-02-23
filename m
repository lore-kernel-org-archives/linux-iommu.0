Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26612E7D
	for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708673729; cv=none; b=fmeDnA6EuIBBhscjuPsI9DQ0CfHE5uHeEKtG04EFr9AvKRq/3MNSiogFRxpX+YX1ud11JMnBV4jkDP6ZueClO51jCQnCY5KqpxyC5uuXs7mYuACcCjMnsHorBv8+N+WlHZYg9k7Y8BBwHHeQJypoOR6CKRuwPfow+O9aabHp7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708673729; c=relaxed/simple;
	bh=eBnTWhjdcjzGBQGM4lj/0XFmDSyQvrKqnnc7evSd3sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=deQls3h+zrrcGng/WJfcecAwadrpsRviGjRxLLdfs7TKA2pqF0wLJ4rwBOdckZp1Z1Oo0mI13RCErSRn703sz0k8qXBugYHT+kQuM/pcbDTKM6FbMLeyEUmgf66Mmc4h6hZF6s/UJraBuw0MRXXDSGJjRcMSGQitp1giTYYCq70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IFgCtHd3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFgCtHd3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708673727; x=1740209727;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eBnTWhjdcjzGBQGM4lj/0XFmDSyQvrKqnnc7evSd3sk=;
  b=IFgCtHd3EYv/t5XQdcDaJI11Dg75gjMZzPi8/a9VfBO6/FtGlJl7yKle
   vaMhga0n8MKBWvG4fO+sknRotVAVkEXLpCVnMIfXpNu+qk9MxUUl1Tt5F
   eTQxGr/FxCnvmYlun9Rt8ZseD2NyltRNLabg/5ExQSmpB/jnS89iVDN+h
   tcHpoW9w4eH3XFepTcTDY5mrf2TwzCe0KHS8Go8V1iBXXfjG6lU1YkFhi
   D5TngbwpH6F7knQY1opATdDiK2ltu82bULf9lY9ctMU6JokpuTesHW+hi
   KWnwgxrDETShdrPVE+BavqsKgpEJ/VjCFBpnzwpzat8sx78jr2gP1zEVT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6760658"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6760658"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 23:35:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5833025"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.255.30.59]) ([10.255.30.59])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 23:35:20 -0800
Message-ID: <c241efc5-9baf-4069-8fe5-d156fd281601@linux.intel.com>
Date: Fri, 23 Feb 2024 15:35:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/3] PCI: make pci_dev_is_disconnected() helper public
 for other drivers
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Baolu Lu <baolu.lu@linux.intel.com>
Cc: bhelgaas@google.com, robin.murphy@arm.com, jgg@ziepe.ca,
 kevin.tian@intel.com, dwmw2@infradead.org, will@kernel.org, lukas@wunner.de,
 yi.l.liu@intel.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, Haorong Ye <yehaorong@bytedance.com>
References: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
 <20240222090251.2849702-2-haifeng.zhao@linux.intel.com>
 <9c4637d5-6496-4c68-b2db-4be1e56ca746@linux.intel.com>
 <88915639-b6cc-43f7-9ac7-8e2dde982757@moroto.mountain>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <88915639-b6cc-43f7-9ac7-8e2dde982757@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/23/2024 2:47 PM, Dan Carpenter wrote:
> I'm not a PCI maintainer, but first two patches seem good to me.  For
> the third patch, my complaints were really minor.  Let's just add a
> Fixes tag for sure, the rest is okay.
>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks Dan.

>
> regards,
> dan carpenter
>
