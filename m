Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795404619;
	b=kPSs4kC2yIixQSh1goRXAjrSieirfUalRkLfjKx4eXxL7ITo6KG93+gadzc0hQ9KNBaq
	 1Dukh89zVVaIyf95lbayXYBWwtAXgHqL8CX6vLDWI3WFwCkHu+l2GtaBejQibkvZ3H5ra
	 jhVxWw49R0nAojfKQOmyZbozG6pNfJEu/IVhcDvXYIkpiMbVblmBrvn2SZnFn+V6XEm51
	 X7xml08Mn7oYqtWdJTd+od5BhRY/RBhoCD3UH8MSoQArbDVHqA/EHG+52ripfvpTiQqFL
	 FuktzvtnYOQ/bbZr7Px5IxZE+tadiSRGv/1eCRPd3cDG93z0JQfljWsPrVneqM5YjhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795404619;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=+OVrc8f7SUe5j7bd8dyYAonTbCTM23PZtBQVesUqE24=;
	b=c8NzFmEJFFkEc7+2/SlNYL8fOosVAZhNI/Y4sIk8VtjnSFPUWOzz/6N45KV6dDJ5Xo4N
	 ehADquhD6cVb2w6bcgFWtnTPn9f/CF1plTLKD+zFl1dAe62BlkIZ2EcQNPYRj5K1ugN/Z
	 STScs2ujtrgA94oN704FTw5LN9kEsNwdSvpyCYhKud5jwXg1TwzgfDxboGFkgvzOk0ElP
	 rBg4NRgRzu/Hl4XaX8LS1QFthJkikhKRNz/4Z8Leooqs2CJC4q/EApRU2E3TvOjgRD7C6
	 cbTzmW7hvhmfFAbKT0KWL59QCNW9jO/0mLU7M8wgklRbyH/zc/MlrcvL3R5veWo4/Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cv8N9fr7;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E42E606A31A;
	Mon, 23 Nov 2026 03:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E42E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cv8N9fr7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795404619; x=1826940619;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xQIf2XWpxRiu8ABULLh3LCmmUoL/rgjSVpR1sePhql4=;
  b=cv8N9fr7RUcqfk1PGwMYHJciMYHleIDBheBowwAjty9hCHC19ZlktLAo
   +4ZOKLQzJrYgjxlRRa2YWckgE1zLvdZ56SmJtOFMBO8bT/pIMOW9g/i3X
   thG2n6X7UUcOPzjGjc96bET6twKy/8Dzl2bJzotEp/TnvbCFqC2Hp3rfx
   jTmIehrymAEjkZ24XlyOun52EpwfcSSR7XWRP5SXd/q+2TabDT7mfCnrU
   RVq5z+3QlglyNCiyLOqNFU/AcOAay9wwjBUG55yYZV7vmP1e3P38cYK9/
   wWsUTBnTK3YPeaQ1smuFuPLK/wWvQZbCL7XFjEFi3vWRrSwGP0LTzvn/C
   Q==;
X-CSE-ConnectionGUID: Bb777oFyTmKnnhn3/sX63A==
X-CSE-MsgGUID: JMcWGCKFRQGOOMfaZHnNmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4048903"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4048903"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 19:30:18 -0800
X-CSE-ConnectionGUID: j/CYp5VnSHujdnBwlrkLmg==
X-CSE-MsgGUID: HB1n6Xb3SQy5H+W5CZc+DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11081924"
Received: from unknown (HELO [10.238.1.144]) ([10.238.1.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 19:30:15 -0800
Message-ID: <d9f3eecf-5655-4779-9e8a-b3ff4cbdb667@linux.intel.com>
Date: Mon, 23 Nov 2026 11:30:12 +0800
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
 xiaoyao.li@intel.com, Binbin Wu <binbin.wu@linux.intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] coco/tdx-host: Add skeleton to support PCI link
 encryption
To: Chao Gao <chao.gao@intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-8-baolu.lu@linux.intel.com>
 <av1QxRYY9sXtC--P@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <av1QxRYY9sXtC--P@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/2026 3:16 PM, Chao Gao wrote:
> On Thu, Nov 12, 2026 at 12:30:52PM +0800, Lu Baolu wrote:
>> Register a Link TSM instance to support host side TSM operations for
>> TDISP, when the TDX Connect support bit is set by TDX Module in
>> tdx_feature0.
> 
> s/TDX Module/TDX module for the whole patch. Existing code and docs mostly
> use "TDX module".
> 
> Also s/tdx_feature0/tdx_features0.

Updated. Thanks!

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
> 
> This changelog is outdated. TDX module initialization has already moved
> earlier in x86 initialization.

Updated. Thanks!

> 
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
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>> drivers/virt/coco/tdx-host/Kconfig    |   2 +
>> arch/x86/include/asm/tdx.h            |   8 ++
>> drivers/virt/coco/tdx-host/tdx-host.c | 118 +++++++++++++++++++++++++-
>> 3 files changed, 127 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
>> index 57d0c01a4357..f8c8cc29d46c 100644
>> --- a/drivers/virt/coco/tdx-host/Kconfig
>> +++ b/drivers/virt/coco/tdx-host/Kconfig
>> @@ -1,6 +1,8 @@
>> config TDX_HOST_SERVICES
>> 	tristate
>> 	depends on INTEL_TDX_HOST
>> +	depends on PCI
>> 	select FW_LOADER
>> 	select FW_UPLOAD
>> +	select PCI_TSM
>> 	default m
>> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
>> index 0ed0062c9b0a..fc284a555984 100644
>> --- a/arch/x86/include/asm/tdx.h
>> +++ b/arch/x86/include/asm/tdx.h
>> @@ -142,6 +142,14 @@ int tdx_topup_pamt_cache(struct tdx_pamt_cache *cache, unsigned long npages);
>> int tdx_pamt_get(kvm_pfn_t pfn, struct tdx_pamt_cache *cache);
>> void tdx_pamt_put(kvm_pfn_t pfn);
>>
>> +static inline bool tdx_supports_tdisp(const struct tdx_sys_info *sysinfo)
>> +{
>> +	if (!(sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT))
>> +		return false;
>> +
>> +	return false; /* To be enabled when kernel is ready */
>> +}
> 
> Patch 2 open-codes the same TDX_FEATURES0_TDXCONNECT check. Can this
> helper be moved to patch 2 and used there?

These checks serve different purposes: the metadata patch checks whether
the TDX module supports TDX Connect; tdx_supports_tdisp() decides
whether the kernel is ready to register the link tsm. The latter may
include additional checks, such as quirks, so I would like to keep the
helper for the tsm registration.

> 
>> +
>> int tdx_guest_keyid_alloc(void);
>> u32 tdx_get_nr_guest_keyids(void);
>> void tdx_guest_keyid_free(unsigned int keyid);
>> diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
>> index e8ed8dfa526e..0908aaaa28ac 100644
>> --- a/drivers/virt/coco/tdx-host/tdx-host.c
>> +++ b/drivers/virt/coco/tdx-host/tdx-host.c
>> @@ -9,10 +9,14 @@
>> #include <linux/firmware.h>
>> #include <linux/module.h>
>> #include <linux/sysfs.h>
>> +#include <linux/pci.h>
>> +#include <linux/pci-tsm.h>
>> +#include <linux/tsm.h>
>>
>> #include <asm/cpu_device_id.h>
>> #include <asm/seamldr.h>
>> #include <asm/tdx.h>
>> +#include <asm/tdx_global_metadata.h>
>>
>> static const struct x86_cpu_id tdx_host_ids[] = {
>> 	X86_MATCH_FEATURE(X86_FEATURE_TDX_HOST_PLATFORM, NULL),
>> @@ -20,6 +24,112 @@ static const struct x86_cpu_id tdx_host_ids[] = {
>> };
>> MODULE_DEVICE_TABLE(x86cpu, tdx_host_ids);
>>
>> +struct tdx_tsm_link {
>> +	struct pci_tsm_pf0 pci;
>> +};
>> +
>> +static struct tdx_tsm_link *to_tdx_tsm_link(struct pci_tsm *tsm)
>> +{
>> +	return container_of(tsm, struct tdx_tsm_link, pci.base_tsm);
>> +}
>> +
>> +static int tdx_tsm_link_connect(struct pci_dev *pdev)
>> +{
>> +	return -ENXIO;
>> +}
>> +
>> +static void tdx_tsm_link_disconnect(struct pci_dev *pdev)
>> +{
>> +}
>> +
>> +static struct pci_tsm *tdx_tsm_link_pf0_probe(struct tsm_dev *tsm_dev,
>> +					      struct pci_dev *pdev)
>> +{
>> +	int rc;
>> +
>> +	struct tdx_tsm_link *tlink __free(kfree) = kzalloc_obj(*tlink);
> 
> tdx-host goes through the tip tree. It looks like Dave prefers plain
> error handling over __free() [*]. I think we should drop __free() for
> tdx-host code. Same for tdx_tsm_link_fn_probe() below.
> 
> *: https://lore.kernel.org/kvm/691e16318f5ea_1eb85100ce@dwillia2-mobl4.notmuch/

Okay, so I will update it like this:

diff --git a/drivers/virt/coco/tdx-host/main.c 
b/drivers/virt/coco/tdx-host/main.c
index a815dbe5127a..af887c49a027 100644
--- a/drivers/virt/coco/tdx-host/main.c
+++ b/drivers/virt/coco/tdx-host/main.c
@@ -56,17 +56,22 @@ static void tdx_tsm_link_disconnect(struct pci_dev 
*pdev)
  static struct pci_tsm *tdx_tsm_link_pf0_probe(struct tsm_dev *tsm_dev,
  					      struct pci_dev *pdev)
  {
+	struct tdx_tsm_link *tlink;
  	int rc;

-	struct tdx_tsm_link *tlink __free(kfree) = kzalloc_obj(*tlink);
+	tlink = kzalloc_obj(*tlink);
  	if (!tlink)
  		return NULL;

  	rc = pci_tsm_pf0_constructor(pdev, &tlink->pci, tsm_dev);
  	if (rc)
-		return NULL;
+		goto err_free;

-	return &no_free_ptr(tlink)->pci.base_tsm;
+	return &tlink->pci.base_tsm;
+
+err_free:
+	kfree(tlink);
+	return NULL;
  }

  static void tdx_tsm_link_pf0_remove(struct pci_tsm *tsm)
@@ -80,17 +85,22 @@ static void tdx_tsm_link_pf0_remove(struct pci_tsm *tsm)
  static struct pci_tsm *tdx_tsm_link_fn_probe(struct tsm_dev *tsm_dev,
  					     struct pci_dev *pdev)
  {
+	struct pci_tsm *pci_tsm;
  	int rc;

-	struct pci_tsm *pci_tsm __free(kfree) = kzalloc_obj(*pci_tsm);
+	pci_tsm = kzalloc_obj(*pci_tsm);
  	if (!pci_tsm)
  		return NULL;

  	rc = pci_tsm_link_constructor(pdev, pci_tsm, tsm_dev);
  	if (rc)
-		return NULL;
+		goto err_free;

-	return no_free_ptr(pci_tsm);
+	return pci_tsm;
+
+err_free:
+	kfree(pci_tsm);
+	return NULL;
  }

  static struct pci_tsm *tdx_tsm_link_probe(struct tsm_dev *tsm_dev,
-- 
2.43.0


>> +	if (!tlink)
>> +		return NULL;
>> +
>> +	rc = pci_tsm_pf0_constructor(pdev, &tlink->pci, tsm_dev);
>> +	if (rc)
>> +		return NULL;
>> +
>> +	return &no_free_ptr(tlink)->pci.base_tsm;
>> +}
>> +
>> +static void tdx_tsm_link_pf0_remove(struct pci_tsm *tsm)
>> +{
>> +	struct tdx_tsm_link *tlink = to_tdx_tsm_link(tsm);
>> +
>> +	pci_tsm_pf0_destructor(&tlink->pci);
>> +	kfree(tlink);
>> +}
>> +
>> +static struct pci_tsm *tdx_tsm_link_fn_probe(struct tsm_dev *tsm_dev,
>> +					     struct pci_dev *pdev)
>> +{
>> +	int rc;
>> +
>> +	struct pci_tsm *pci_tsm __free(kfree) = kzalloc_obj(*pci_tsm);
>> +	if (!pci_tsm)
>> +		return NULL;
>> +
>> +	rc = pci_tsm_link_constructor(pdev, pci_tsm, tsm_dev);
>> +	if (rc)
>> +		return NULL;
>> +
>> +	return no_free_ptr(pci_tsm);
>> +}

Thanks,
baolu
