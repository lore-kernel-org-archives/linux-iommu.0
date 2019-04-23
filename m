Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99904C282CE
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 02:09:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E70320643
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 02:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E70320643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E0F20C4E;
	Tue, 23 Apr 2019 02:09:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AF923AE0
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 02:09:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6D798F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 02:09:33 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	22 Apr 2019 19:09:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,384,1549958400"; d="scan'208";a="339873091"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga006.fm.intel.com with ESMTP; 22 Apr 2019 19:06:40 -0700
Subject: Re: [PATCH v3 07/10] iommu/vt-d: Keep swiotlb on if bounce page is
	necessary
To: Christoph Hellwig <hch@lst.de>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
	<20190421011719.14909-8-baolu.lu@linux.intel.com>
	<20190422164720.GB31181@lst.de>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <68192a07-4eac-4b2e-5c23-075defde9f34@linux.intel.com>
Date: Tue, 23 Apr 2019 10:00:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422164720.GB31181@lst.de>
Content-Language: en-US
Cc: kevin.tian@intel.com, mika.westerberg@linux.intel.com, ashok.raj@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	alan.cox@intel.com, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	pengfei.xu@intel.com, jacob.jun.pan@intel.com,
	David Woodhouse <dwmw2@infradead.org>,
	Mika Westerberg <mika.westerberg@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190423020032.hzkQTufgmabdm4KY2NY7J-VK5eF0DxpND3Zx0x26kHA@z>

Hi,

On 4/23/19 12:47 AM, Christoph Hellwig wrote:
> On Sun, Apr 21, 2019 at 09:17:16AM +0800, Lu Baolu wrote:
>> +static inline bool platform_has_untrusted_device(void)
>>   {
>> +	bool has_untrusted_device = false;
>>   	struct pci_dev *pdev = NULL;
>>   
>>   	for_each_pci_dev(pdev) {
>>   		if (pdev->untrusted) {
>> +			has_untrusted_device = true;
>>   			break;
>>   		}
>>   	}
>>   
>> +	return has_untrusted_device;
> 
> This shouldn't really be in the intel-iommu driver, should it?
> This probably should be something like pci_has_untrusted_devices
> and be moved to the PCI code.
> 

Fair enough.

Best regards,
Lu Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
