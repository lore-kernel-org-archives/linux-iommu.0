Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5074C433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 10:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6380460746;
	Mon, 11 Apr 2022 10:43:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g_9OfnDI6z2r; Mon, 11 Apr 2022 10:43:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 135A360681;
	Mon, 11 Apr 2022 10:43:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D60C6C002F;
	Mon, 11 Apr 2022 10:43:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA7BEC002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 10:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A48218138F
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 10:43:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eEtzp1z_UZ6X for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 10:43:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id A729880B50
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 10:43:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5B131692;
 Mon, 11 Apr 2022 03:43:30 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 888913F5A1;
 Mon, 11 Apr 2022 03:43:29 -0700 (PDT)
Message-ID: <97c6b2e1-3d9f-bf03-a14e-df3249d166dd@arm.com>
Date: Mon, 11 Apr 2022 11:43:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] habanalabs: Stop using iommu_present()
Content-Language: en-GB
To: Oded Gabbay <ogabbay@kernel.org>
References: <8201946a5b8b26dab35738b87da24ff27a9f9270.1649166391.git.robin.murphy@arm.com>
 <CAFCwf10bwtpC=syFgcz8Ym5S797x3wmkGx3RFnUNkSsjdeyGgw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAFCwf10bwtpC=syFgcz8Ym5S797x3wmkGx3RFnUNkSsjdeyGgw@mail.gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
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

On 2022-04-10 11:59, Oded Gabbay wrote:
> On Tue, Apr 5, 2022 at 4:46 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> Even if an IOMMU might be present for some PCI segment in the system,
>> that doesn't necessarily mean it provides translation for the device
>> we care about. Replace iommu_present() with a more appropriate check.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/misc/habanalabs/gaudi/gaudi.c | 8 ++++----
>>   drivers/misc/habanalabs/goya/goya.c   | 8 ++++----
>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
>> index 21c2b678ff72..5dc66dc7618e 100644
>> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
>> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
>> @@ -6133,7 +6133,7 @@ static int gaudi_debugfs_read32(struct hl_device *hdev, u64 addr,
>>                          rc = -EIO;
>>
>>          } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
>> -                       user_address && !iommu_present(&pci_bus_type)) {
>> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>>
>>                  *val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
>>
>> @@ -6176,7 +6176,7 @@ static int gaudi_debugfs_write32(struct hl_device *hdev, u64 addr,
>>                          rc = -EIO;
>>
>>          } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
>> -                       user_address && !iommu_present(&pci_bus_type)) {
>> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>>
>>                  *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
>>
>> @@ -6223,7 +6223,7 @@ static int gaudi_debugfs_read64(struct hl_device *hdev, u64 addr,
>>                          rc = -EIO;
>>
>>          } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
>> -                       user_address && !iommu_present(&pci_bus_type)) {
>> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>>
>>                  *val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
>>
>> @@ -6268,7 +6268,7 @@ static int gaudi_debugfs_write64(struct hl_device *hdev, u64 addr,
>>                          rc = -EIO;
>>
>>          } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
>> -                       user_address && !iommu_present(&pci_bus_type)) {
>> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>>
>>                  *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
>>
>> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
>> index ec9358bcbf0b..0c455bf460f4 100644
>> --- a/drivers/misc/habanalabs/goya/goya.c
>> +++ b/drivers/misc/habanalabs/goya/goya.c
>> @@ -4309,7 +4309,7 @@ static int goya_debugfs_read32(struct hl_device *hdev, u64 addr,
>>                          rc = -EIO;
>>
>>          } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
>> -                       user_address && !iommu_present(&pci_bus_type)) {
>> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>>                  *val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
>>
>>          } else {
>> @@ -4369,7 +4369,7 @@ static int goya_debugfs_write32(struct hl_device *hdev, u64 addr,
>>                          rc = -EIO;
>>
>>          } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
>> -                       user_address && !iommu_present(&pci_bus_type)) {
>> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>>                  *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
>>
>>          } else {
>> @@ -4418,7 +4418,7 @@ static int goya_debugfs_read64(struct hl_device *hdev, u64 addr,
>>                          rc = -EIO;
>>
>>          } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
>> -                       user_address && !iommu_present(&pci_bus_type)) {
>> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>>                  *val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
>>
>>          } else {
>> @@ -4465,7 +4465,7 @@ static int goya_debugfs_write64(struct hl_device *hdev, u64 addr,
>>                          rc = -EIO;
>>
>>          } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
>> -                       user_address && !iommu_present(&pci_bus_type)) {
>> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>>                  *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
>>
>>          } else {
>> --
>> 2.28.0.dirty
>>
> 
> Hi Robin,
> Can you please rebase this over the latest habanalabs-next ?
> The code was totally changed, but I think your core change is
> definitely relevant.

Oh, lovely, that makes for a much nicer patch indeed! I'll spin a v2 
shortly.

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
