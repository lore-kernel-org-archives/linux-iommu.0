Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794195974;
	b=lceh1iVsjnpOb4H1reClNER0Wh2BIECS9cHwZzTfDWn5nSDog8mfBbac704tKO4G6tte
	 MrnF9byNcbeoH8DFlXsE5ah0MI2c4zewbi0Uh6/+ywISn2pQphdoM98dwCEFrRdYKeY5B
	 QMQU/aGDcsXPXRtcQpfJ9XyPNo9T1kjuZ8hpUCpHMfjF1KVuNkKQz1EqzY3DlWjk5EUwm
	 7Kk1qbWtP0y2JktrY/js11Ae/XB9V4/9OqI8o4T+nqgUUgKkCNSc95pl8ocdUXx2s0PDD
	 RnJRWCfkum13LSXtavgH1VBBgNv8nkvVoL6Wp8H5ey57jqXrtVIDbTBvWJnpv9pIcLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794195974;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=gr96iaWliwZ75RhmyhCPwLKsIFpyS1bTKCZs7TpnfkY=;
	b=dTDyFPX0ugFunAWK7P2fFfSEfKuMbaJX0Adjn5Vv6CpNI5nM7eXRbiIcoI0NO0iNIHe7
	 SjWzLPUDNb3BekdQsylFZZydoivcfPgvWX1FwSg+pcnFKuOQCmObomdkUHj3c94fwfBdi
	 goCX4iSeXV6uQP5MdhcEUax4EfEaOj3IhIahqm0R9V30Nyn55ZTE2m2642UQpSnnZ1Gh+
	 c83HPWfkyJ6QjpvuZ8NhJrknZhdLxkJcy+WgfzXVNnTUw5UC2ZiuaSPrim3AgSrsyH6at
	 ZNgv43oZqTAZo9hMIRx34y7FYAiMi7FKznJ9eOTxcEpXOP6Qe2ZIO9eWiB6KjXfXoZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XSUo7BSD;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E595E606A336
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 03:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E595E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XSUo7BSD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794195973; x=1825731973;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BBS1gsXzLye4daje8OnhsCSPUgDhwifPpec/GQS7W5A=;
  b=XSUo7BSDnpWgClKL2F+WOhETkdGLHHWNcq8FmVChVfesoyk9ykLgoPSB
   NhTyG4xNOIJbZ+jXdwuA5VzMpVDVMk4GscOBfvVrCz2jAcdQxKeS0iQky
   mjSbWUbbMqOdA4Nmxp6dqY+RNbmDAW8akWE6KYQ6FFILsKLYUXZnNugGF
   yPj4BBhbwqRHWLssPeAeyNAym6ktzsyj7X5U4nxiGsklDu4+xfnII3cF4
   vWNkI6bzGTJMPXqdvE3KCGLMwtjnjec28jAC8mqU9cuTqgTtYWOFGvlHa
   xJxtrFkYghHOjBwLcCjZEyM8bvgLMJ5Z5psrODnE9cR18y5zRxswjTm5b
   A==;
X-CSE-ConnectionGUID: HcZsVes1RlSItbkCPo/w2g==
X-CSE-MsgGUID: kNcvrZ/kSQWhOYhZH/TXEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2836536"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2836536"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 19:46:12 -0800
X-CSE-ConnectionGUID: kX3MBr+NRvuhF+mtb/9uAw==
X-CSE-MsgGUID: rTa4fatiTi+HSG1WxC2X9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7658236"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 19:46:10 -0800
Message-ID: <9d2bb2f7-4052-44fc-9ba6-a7ad6267678f@linux.intel.com>
Date: Mon, 9 Nov 2026 11:46:07 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker <jpb@kernel.org>,
 Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] iommu: Reject a same-domain replace in the attach
 handle APIs
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1793729087.git.nicolinc@nvidia.com>
 <1b3a334eade93a5047d51af040f1400cd563189d.1793729087.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1b3a334eade93a5047d51af040f1400cd563189d.1793729087.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/2026 2:07 AM, Nicolin Chen wrote:
> Both iommu_replace_group_handle() and iommu_replace_device_pasid() skip the
> driver callback when the new domain is the one currently attached. In that
> case, nothing flushes the pending faults that may still be holding the old
> handle. Then, the caller frees the old handle once the replace returns, so
> such a fault would hit a use-after-free.
> 
> No caller does this today, since iommufd_device_do_replace() returns early
> when the new hwpt is the old one. However, it is only a caller convention,
> which neither API enforces.
> 
> Reject a same-domain replace in both APIs with a WARN_ON, and document it
> in their kernel-docs.
> 
> Suggested-by: Lu Baolu<baolu.lu@linux.intel.com>
> Reviewed-by: Yi Liu<yi.l.liu@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 36 +++++++++++++++++++++++++++++-------
>   1 file changed, 29 insertions(+), 7 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
