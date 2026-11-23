Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407519;
	b=tI28/0u3cPH5PLI24qbETDXNVbP27k0AntsfSE2myV8L01uwhJV/vnfqhv7yId1VLcHm
	 UY5KyPQ32/XgvQ0AFjZJyzahkC9zZ5pVhs6dK+GKs1rQLCMtTSb2IEJtfs1eNNwe8eMhE
	 KIBEspWqVP8R00wX/l6e2ArZsqJvjO8NZI1ZS8+WCtKQbxalHWm1qOOKrBMFb05SZRC6y
	 fA1dkXXYufAtZtz2rzvRi6ueb1PuqHo+8hSkgYhnUu7wzNFFHgwrEMZH49to6rve6uihr
	 sjrUidlNL1oWX/yolRcZ7oDLxzDRdt3UR33yH7OiDjaP8OVUoU8sBlXwNZ/zCZ+QhCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407519;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=OboeEQwN2DSTx/ZhMkIP+Y0ItKq3Ok17t5dAL2d50wU=;
	b=1WtVlK98fxaDDwz6/oics6NOpJqhZQexg9C6xpLzut1ws5d6AR94AA5f+xjk68/xL9GK
	 8+eLkRYYd2e5PvU01OSbsLNriWpcvyCBKJwfbjG/6JqpdmyWMEObjaHeaxCRz0KmwjZdU
	 s5nb9QonilaM6Gsj/uxgwxZ98dyKWJszyhp/t1kKgSh9HZrLy9lR8GELt9Q4cl5pz4XrQ
	 lr5U99ECpxvPRFMmBweX81TA4eFlUoex4ysJBYTH1jhpT+xz/HjT5jsxVv758WBoi7pZz
	 SIvYApO+PKqHwu97XqefmD/1TOqFQnYQBPKHJr/Q+Sf9k1i2dsmeBKDmiViUrmJqj2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NtlLlRNE;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E28606A31E;
	Mon, 23 Nov 2026 04:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4E28606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NtlLlRNE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795407519; x=1826943519;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sxfmlOqgbG1BdG0keawdWgiWbllTvI9Wx2mxgRVK8MI=;
  b=NtlLlRNEUhtTpHvZyJ7F4Fc1woz9IZMegzqFU9R3oZEHTki7u5Q4G+YT
   Tyn03yzeWYJ7ttFDqMHGzDGuAJ+S5FveomFmq4MXGdf3v+zNw0AgJAfXW
   SZ+4oKWeJk+DthDVSWiehfQCZYnsstaAS3Pso1My5z0nQTLPZqedSKLfL
   v/R+co2Pxhfit/cewJk7qosfe1H0b3ALzWHQ/w1Vy4Cob7zGYT7/vxtnk
   7XFqLvWO1A5v7va0Hk9JxRTx2AXOyoVxEBAxfoC8KuCSbZZVqkKwj84tJ
   crgLPVQiDvnRfdZb+TGJ/+Kcmtpc98WqzNdPmVR8XHsTq8AOjHXO0Ho4V
   A==;
X-CSE-ConnectionGUID: qfbW4P67RT2lHNBxbMT/Yw==
X-CSE-MsgGUID: 4GUerx0xSsuxQqwxjXvxRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4114432"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4114432"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 20:18:38 -0800
X-CSE-ConnectionGUID: BLlZDDyWTliRYZty8NwoZw==
X-CSE-MsgGUID: cupNifp9QZ6Z6cj8qgjxTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11766555"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 20:18:35 -0800
Message-ID: <d77bab15-3e35-4185-b328-99712f607435@linux.intel.com>
Date: Mon, 23 Nov 2026 12:18:32 +0800
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
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, x86@kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, yilun.xu@linux.intel.com,
 xiaoyao.li@intel.com, Chao Gao <chao.gao@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] coco/tdx-host: Add skeleton to support PCI link
 encryption
To: Binbin Wu <binbin.wu@linux.intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-8-baolu.lu@linux.intel.com>
 <de1011bc-1cc0-4409-af76-4e90dcef6cf4@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <de1011bc-1cc0-4409-af76-4e90dcef6cf4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/2026 10:52 AM, Binbin Wu wrote:
> On 11/12/2026 12:30 PM, Lu Baolu wrote:
>> Register a Link TSM instance to support host side TSM operations for
>> TDISP, when the TDX Connect support bit is set by TDX Module in
>> tdx_feature0.
>>
>> This is the main purpose of an independent tdx-host module out of TDX
>> core. Recall that a TEE Security Manager (TSM) is a platform agent that
>> speaks the TEE Device Interface Security Protocol (TDISP) to PCIe
>> devices and manages private memory resources for the platform. An
>> independent tdx-host module allows for device-security enumeration and
>> initialization flows to be deferred from other TDX Module initialization
>> requirements. Crucially, when / if TDX Module init moves earlier in x86
>> initialization flow this driver is still guaranteed to run after IOMMU
>> and PCI init (i.e. subsys_initcall() vs device_initcall()).
>>
>> The ability to unload the module, or unbind the driver is also useful
>> for debug and coarse grained transitioning between PCI TSM operation and
>> PCI CMA operation (native kernel PCI device authentication).
>>
>> For now only check for TDX Connect support in the TDX Module and
>> register the Link TSM. The TSM support is basic boilerplate with
>> operation flows to be added later.
>>
>> Based on work by Yilun and Dan.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> [...]
> 
>>   
>>   static int tdx_host_probe(struct faux_device *fdev)
>>   {
>> -	return seamldr_init(&fdev->dev);
>> +	int ret;
>> +
>> +	ret = seamldr_init(&fdev->dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return tdx_tdisp_init(&fdev->dev);
> If tdx_tdisp_init() fails, it will also disable TDX module update and the
> version sysfs attributes.  If this is intended, could you add some description
> in the change log about it?

You are right. That side effect is unnecessary. Module update and the
version attributes don't depend on TDISP. How about fixing this by
making the TDISP failure non-fatal so tdx-host still provides module
update?

Something like:

-static int tdx_tdisp_init(struct device *dev)
+static void tdx_tdisp_init(struct device *dev)
  {
      const struct tdx_sys_info *sysinfo = tdx_get_sysinfo();
      struct tsm_dev *link;

      if (!sysinfo || !tdx_supports_tdisp(sysinfo))
-		return 0;
+		return;

      link = tsm_register(dev, &tdx_tsm_link_ops);
-	if (IS_ERR(link))
-		return dev_err_probe(dev, PTR_ERR(link),
-				     "failed to register TSM\n");
+	if (IS_ERR(link)) {
+		dev_warn(dev, "failed to register TSM: %pe\n", link);
+		return;
+	}

-	return devm_add_action_or_reset(dev, unregister_link_tsm, link);
+	if (devm_add_action_or_reset(dev, unregister_link_tsm, link))
+		dev_warn(dev, "failed to register TSM cleanup\n");
  }
@@
  static int tdx_host_probe(struct faux_device *fdev)
  {
      int ret;

      ret = seamldr_init(&fdev->dev);
      if (ret)
          return ret;

-	return tdx_tdisp_init(&fdev->dev);
+	tdx_tdisp_init(&fdev->dev);
+
+	return 0;
  }

Thanks,
baolu
