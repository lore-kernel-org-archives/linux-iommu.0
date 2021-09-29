Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DDDC433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 01:40:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F12613E8
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 01:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 73F12613E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49539606A3;
	Wed, 29 Sep 2021 01:40:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PvMyUQaVD2Pr; Wed, 29 Sep 2021 01:39:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 26E746060E;
	Wed, 29 Sep 2021 01:39:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DA15C000F;
	Wed, 29 Sep 2021 01:39:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4009C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 01:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C25464026B
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 01:39:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NgQcddr8uuAq for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 01:39:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02E94401EC
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 01:39:56 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="285854285"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="285854285"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 18:39:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="476486375"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 28 Sep 2021 18:39:53 -0700
Subject: Re: [PATCH v2 9/9] iommu/vt-d: Use pci core's DVSEC functionality
To: Dan Williams <dan.j.williams@intel.com>,
 Ben Widawsky <ben.widawsky@intel.com>
References: <20210923172647.72738-1-ben.widawsky@intel.com>
 <20210923172647.72738-10-ben.widawsky@intel.com>
 <CAPcyv4i4T4XLW-P=CzdO47mZ8+_Mih7GMeDEXAtgEE+gO9JQHw@mail.gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6bca371c-44e4-3ba7-b49d-78c55a40d3a5@linux.intel.com>
Date: Wed, 29 Sep 2021 09:36:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4i4T4XLW-P=CzdO47mZ8+_Mih7GMeDEXAtgEE+gO9JQHw@mail.gmail.com>
Content-Language: en-US
Cc: Andrew Donnellan <ajd@linux.ibm.com>, Linux PCI <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-cxl@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 "David E. Box" <david.e.box@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Dan,

On 9/29/21 1:54 AM, Dan Williams wrote:
> On Thu, Sep 23, 2021 at 10:27 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>>
>> Reduce maintenance burden of DVSEC query implementation by using the
>> centralized PCI core implementation.
>>
>> Cc: iommu@lists.linux-foundation.org
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 15 +--------------
>>   1 file changed, 1 insertion(+), 14 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index d75f59ae28e6..30c97181f0ae 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -5398,20 +5398,7 @@ static int intel_iommu_disable_sva(struct device *dev)
>>    */
>>   static int siov_find_pci_dvsec(struct pci_dev *pdev)
>>   {
>> -       int pos;
>> -       u16 vendor, id;
>> -
>> -       pos = pci_find_next_ext_capability(pdev, 0, 0x23);
>> -       while (pos) {
>> -               pci_read_config_word(pdev, pos + 4, &vendor);
>> -               pci_read_config_word(pdev, pos + 8, &id);
>> -               if (vendor == PCI_VENDOR_ID_INTEL && id == 5)
>> -                       return pos;
>> -
>> -               pos = pci_find_next_ext_capability(pdev, pos, 0x23);
>> -       }
>> -
>> -       return 0;
>> +       return pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_INTEL, 5);
>>   }
> 
> Same comments as the CXL patch, siov_find_pci_dvsec() doesn't seem to
> have a reason to exist anymore. What is 5?

"5" is DVSEC ID for Scalable IOV.

Anyway, the siov_find_pci_dvsec() has been dead code since commit
262948f8ba57 ("iommu: Delete iommu_dev_has_feature()"). I have a patch
to clean it up. No need to care about it in this series.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
