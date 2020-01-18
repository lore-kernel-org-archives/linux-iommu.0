Return-Path: <SRS0=Kz9i=3H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62B4C33C9E
	for <iommu@archiver.kernel.org>; Sat, 18 Jan 2020 02:06:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B06A121D7D
	for <iommu@archiver.kernel.org>; Sat, 18 Jan 2020 02:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06A121D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 657752226B;
	Sat, 18 Jan 2020 02:06:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PZB+eOdJf5gA; Sat, 18 Jan 2020 02:06:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 56997203A8;
	Sat, 18 Jan 2020 02:06:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D4B4C1D81;
	Sat, 18 Jan 2020 02:06:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B67BFC077D
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jan 2020 02:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9F6C7870B3
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jan 2020 02:06:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n1I5vx1EPI0x for <iommu@lists.linux-foundation.org>;
 Sat, 18 Jan 2020 02:06:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6674C8706B
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jan 2020 02:06:23 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jan 2020 18:06:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,332,1574150400"; d="scan'208";a="214684983"
Received: from allen-box.sh.intel.com (HELO [10.239.159.138])
 ([10.239.159.138])
 by orsmga007.jf.intel.com with ESMTP; 17 Jan 2020 18:06:19 -0800
Subject: Re: [RFC PATCH 2/4] PCI: Add "pci=iommu_passthrough=" parameter for
 iommu passthrough
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20200117232403.GA142078@google.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bce2cf6c-d030-3265-d8b7-0faa895e3d5a@linux.intel.com>
Date: Sat, 18 Jan 2020 10:04:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117232403.GA142078@google.com>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Hi Bjorn,

On 1/18/20 8:18 AM, Bjorn Helgaas wrote:
> On Wed, Jan 01, 2020 at 01:26:46PM +0800, Lu Baolu wrote:
>> The new parameter takes a list of devices separated by a semicolon.
>> Each device specified will have its iommu_passthrough bit in struct
>> device set. This is very similar to the existing 'disable_acs_redir'
>> parameter.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  5 +++
>>   drivers/pci/pci.c                             | 34 +++++++++++++++++++
>>   drivers/pci/pci.h                             |  1 +
>>   drivers/pci/probe.c                           |  2 ++
>>   4 files changed, 42 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index ade4e6ec23e0..d3edc2cb6696 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3583,6 +3583,11 @@
>>   				may put more devices in an IOMMU group.
>>   		force_floating	[S390] Force usage of floating interrupts.
>>   		nomio		[S390] Do not use MIO instructions.
>> +		iommu_passthrough=<pci_dev>[; ...]
>> +				Specify one or more PCI devices (in the format
>> +				specified above) separated by semicolons.
>> +				Each device specified will bypass IOMMU DMA
>> +				translation.
>>   
>>   	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
>>   			Management.
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 90dbd7c70371..05bf3f4acc36 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6401,6 +6401,37 @@ void __weak pci_fixup_cardbus(struct pci_bus *bus)
>>   }
>>   EXPORT_SYMBOL(pci_fixup_cardbus);
>>   
>> +static const char *iommu_passthrough_param;
>> +bool pci_iommu_passthrough_match(struct pci_dev *dev)
>> +{
>> +	int ret = 0;
>> +	const char *p = iommu_passthrough_param;
>> +
>> +	if (!p)
>> +		return false;
>> +
>> +	while (*p) {
>> +		ret = pci_dev_str_match(dev, p, &p);
>> +		if (ret < 0) {
>> +			pr_info_once("PCI: Can't parse iommu_passthrough parameter: %s\n",
>> +				     iommu_passthrough_param);
>> +
>> +			break;
>> +		} else if (ret == 1) {
>> +			pci_info(dev, "PCI: IOMMU passthrough\n");
>> +			return true;
>> +		}
>> +
>> +		if (*p != ';' && *p != ',') {
>> +			/* End of param or invalid format */
>> +			break;
>> +		}
>> +		p++;
>> +	}
>> +
>> +	return false;
>> +}
> 
> This duplicates a lot of the code in pci_disable_acs_redir().  That
> needs to be factored out somehow so we don't duplicate it.
> 

Sure. I will try to refactor the code in the next version.

> Bjorn
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
