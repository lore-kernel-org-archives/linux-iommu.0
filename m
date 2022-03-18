Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14835C433EF
	for <iommu@archiver.kernel.org>; Fri, 18 Mar 2022 12:01:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CADD2419CB;
	Fri, 18 Mar 2022 12:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u7ibA21E11Lm; Fri, 18 Mar 2022 12:01:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 86A91419BD;
	Fri, 18 Mar 2022 12:01:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 521F8C0033;
	Fri, 18 Mar 2022 12:01:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 061C3C0012
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 12:01:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E70DE81B01
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 12:01:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cmVetqcZP1ma for <iommu@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 12:01:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id EDBA381858
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 12:01:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3269A1424;
 Fri, 18 Mar 2022 05:01:48 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7177A3F7F5;
 Fri, 18 Mar 2022 05:01:46 -0700 (PDT)
Message-ID: <65207fdf-c4ab-5165-dbda-8ab55b51adb7@arm.com>
Date: Fri, 18 Mar 2022 12:01:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Content-Language: en-GB
To: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
 <BL1PR12MB515783C0F998169D49D92A55E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BL1PR12MB51573F55B3C2B3922BAAA7F1E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjRvMk1kcbMwJvx+@lahna>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YjRvMk1kcbMwJvx+@lahna>
Cc: "michael.jamet@intel.com" <michael.jamet@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>
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

On 2022-03-18 11:38, mika.westerberg@linux.intel.com wrote:
> Hi Mario,
> 
> On Thu, Mar 17, 2022 at 08:36:13PM +0000, Limonciello, Mario wrote:
>> Here is a proposal on top of what you did for this.
>> The idea being check the ports right when the links are made if they exist
>> (all the new USB4 stuff) and then check all siblings on TBT3 stuff.
>>
>> diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
>> index 79b5abf9d042..89432456dbea 100644
>> --- a/drivers/thunderbolt/acpi.c
>> +++ b/drivers/thunderbolt/acpi.c
>> @@ -14,6 +14,7 @@
>>   static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
>>                                      void **return_value)
>>   {
>> +       enum nhi_iommu_status iommu_status = IOMMU_UNKNOWN;
>>          struct fwnode_reference_args args;
>>          struct fwnode_handle *fwnode;
>>          struct tb_nhi *nhi = data;
>> @@ -91,6 +92,8 @@ static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
>>                  if (link) {
>>                          dev_dbg(&nhi->pdev->dev, "created link from %s\n",
>>                                  dev_name(&pdev->dev));
>> +                       if (iommu_status != IOMMU_DISABLED)
>> +                               iommu_status = nhi_check_iommu_for_port(pdev);
>>                  } else {
>>                          dev_warn(&nhi->pdev->dev, "device link creation from %s failed\n",
>>                                   dev_name(&pdev->dev));
>> @@ -101,6 +104,7 @@ static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
>>
>>   out_put:
>>          fwnode_handle_put(args.fwnode);
>> +       nhi->iommu_dma_protection = (iommu_status == IOMMU_ENABLED);
>>          return AE_OK;
>>   }
>>
>> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
>> index e12c2e266741..b5eb0cab392f 100644
>> --- a/drivers/thunderbolt/nhi.c
>> +++ b/drivers/thunderbolt/nhi.c
>> @@ -1103,10 +1103,30 @@ static void nhi_check_quirks(struct tb_nhi *nhi)
>>                  nhi->quirks |= QUIRK_AUTO_CLEAR_INT;
>>   }
>>
>> +enum nhi_iommu_status nhi_check_iommu_for_port(struct pci_dev *pdev)
>> +{
>> +       if (!pci_is_pcie(pdev) ||
>> +           !(pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
>> +            pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
>> +               return IOMMU_UNKNOWN;
>> +       }
>> +
>> +       if (!device_iommu_mapped(&pdev->dev)) {
>> +               return IOMMU_DISABLED;
>> +       }
>> +
>> +       if (!pdev->untrusted) {
>> +               dev_info(&pdev->dev,
>> +                       "Assuming unreliable Kernel DMA protection\n");
>> +               return IOMMU_DISABLED;
>> +       }
>> +       return IOMMU_ENABLED;
>> +}
>> +
>>   static void nhi_check_iommu(struct tb_nhi *nhi)
>>   {
>> -       struct pci_dev *pdev;
>> -       bool port_ok = false;
>> +       enum nhi_iommu_status iommu_status = nhi->iommu_dma_protection ?
>> +                                       IOMMU_ENABLED : IOMMU_UNKNOWN;
>>
>>          /*
>>           * Check for sibling devices that look like they should be our
>> @@ -1117,23 +1137,13 @@ static void nhi_check_iommu(struct tb_nhi *nhi)
>>           * otherwise even if translation is enabled for existing devices it
>>           * may potentially be overridden for a future tunnelled endpoint.
>>           */
>> -       for_each_pci_bridge(pdev, nhi->pdev->bus) {
>> -               if (!pci_is_pcie(pdev) ||
>> -                   !(pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
>> -                     pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
>> -                       continue;
>> -
>> -               if (!device_iommu_mapped(&pdev->dev))
>> -                       return;
>> -
>> -               if (!pdev->untrusted) {
>> -                       dev_info(&nhi->pdev->dev,
>> -                                "Assuming unreliable Kernel DMA protection\n");
>> -                       return;
>> -               }
>> -               port_ok = true;
>> +       if (iommu_status == IOMMU_UNKNOWN) {
>> +               struct pci_dev *pdev;
>> +               for_each_pci_bridge(pdev, nhi->pdev->bus)
>> +                       if (iommu_status != IOMMU_DISABLED)
>> +                               iommu_status = nhi_check_iommu_for_port(pdev);
>>          }
>> -       nhi->iommu_dma_protection = port_ok;
>> +       nhi->iommu_dma_protection = (iommu_status == IOMMU_ENABLED);
>>   }
>>
>>   static int nhi_init_msi(struct tb_nhi *nhi)
>>
>> diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
>> index 69083aab2736..1622d49b1763 100644
>> --- a/drivers/thunderbolt/nhi.h
>> +++ b/drivers/thunderbolt/nhi.h
>> @@ -11,6 +11,13 @@
>>
>>   #include <linux/thunderbolt.h>
>>
>> +enum nhi_iommu_status {
>> +       IOMMU_UNKNOWN,
>> +       IOMMU_DISABLED,
>> +       IOMMU_ENABLED,
>> +};
>> +enum nhi_iommu_status nhi_check_iommu_for_port(struct pci_dev *pdev);
>> +
> 
> This adds quite a lot code and complexity, and honestly I would like to
> keep it as simple as possible (and this is not enough because we need to
> make sure the DMAR bit is there so that none of the possible connected
> devices were able to overwrite our memory already).

Shall we forget the standalone sibling check and just make the 
pdev->untrusted check directly in tb_acpi_add_link() then? On reflection 
I guess the DMAR bit makes iommu_dma_protection functionally dependent 
on ACPI already, so we don't actually lose anything (and anyone can come 
back and revisit firmware-agnostic methods later if a need appears).

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
