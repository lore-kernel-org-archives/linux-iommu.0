Return-Path: <SRS0=vTls=FU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948CCC4361B
	for <iommu@archiver.kernel.org>; Wed, 16 Dec 2020 11:24:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B301B2312E
	for <iommu@archiver.kernel.org>; Wed, 16 Dec 2020 11:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B301B2312E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 39C0D86856;
	Wed, 16 Dec 2020 11:24:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j-y+4jh185Kj; Wed, 16 Dec 2020 11:24:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1112A8684F;
	Wed, 16 Dec 2020 11:24:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E189CC0893;
	Wed, 16 Dec 2020 11:24:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 844A7C013B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 11:24:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7B7EA86855
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 11:24:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U7IyWPKYk86Y for <iommu@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 11:24:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 689A68684F
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 11:24:43 +0000 (UTC)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cwt6t5pxrzkqBb;
 Wed, 16 Dec 2020 19:23:50 +0800 (CST)
Received: from [10.63.139.185] (10.63.139.185) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 19:24:31 +0800
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To: Bjorn Helgaas <helgaas@kernel.org>, Zhangfei Gao <zhangfei.gao@linaro.org>
References: <20200623150427.GA2403606@bjorn-Precision-5520>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5FD9EE6E.1040505@hisilicon.com>
Date: Wed, 16 Dec 2020 19:24:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20200623150427.GA2403606@bjorn-Precision-5520>
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Cc: Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
 jean-philippe <jean-philippe@linaro.org>,
 Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci <linux-pci@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>, "open
 list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Bjorn
 Helgaas <bhelgaas@google.com>, kenneth-lee-2012@foxmail.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020/6/23 23:04, Bjorn Helgaas wrote:
> On Fri, Jun 19, 2020 at 10:26:54AM +0800, Zhangfei Gao wrote:
>> Have studied _DSM method, two issues we met comparing using quirk.
>>
>> 1. Need change definition of either pci_host_bridge or pci_dev, like adding
>> member can_stall,
>> while pci system does not know stall now.
>>
>> a, pci devices do not have uuid: uuid need be described in dsdt, while pci
>> devices are not defined in dsdt.
>>     so we have to use host bridge.
> 
> PCI devices *can* be described in the DSDT.  IIUC these particular
> devices are hardwired (not plug-in cards), so platform firmware can
> know about them and could describe them in the DSDT.
> 
>> b,  Parsing dsdt is in in pci subsystem.
>> Like drivers/acpi/pci_root.c:
>>        obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid,
>> 1,
>>                                 IGNORE_PCI_BOOT_CONFIG_DSM, NULL);
>>
>> After parsing DSM in pci, we need record this info.
>> Currently, can_stall info is recorded in iommu_fwspec,
>> which is allocated in iommu_fwspec_init and called by iort_iommu_configure
>> for uefi.
> 
> You can look for a _DSM wherever it is convenient for you.  It could
> be in an AMBA shim layer.
> 
>> 2. Guest kernel also need support sva.
>> Using quirk, the guest can boot with sva enabled, since quirk is
>> self-contained by kernel.
>> If using  _DSM, a specific uefi or dtb has to be provided,
>> currently we can useQEMU_EFI.fd from apt install qemu-efi
> 
> I don't quite understand what this means, but as I mentioned before, a
> quirk for a *limited* number of devices is OK, as long as there is a
> plan that removes the need for a quirk for future devices.
> 
> E.g., if the next platform version ships with a DTB or firmware with a
> _DSM or other mechanism that enables the kernel to discover this
> information without a kernel change, it's fine to use a quirk to cover
> the early platform.
> 
> The principles are:
> 
>   - I don't want to have to update a quirk for every new Device ID
>     that needs this.

Hi Bjorn and Zhangfei,

We plan to use ATS/PRI to support SVA in future PCI devices. However, for
current devices, we need to add limited number of quirk to let them
work. The device IDs of current quirk needed devices are ZIP engine(0xa250, 0xa251),
SEC engine(0xa255, 0xa256), HPRE engine(0xa258, 0xa259), revision id are
0x21 and 0x30.

Let's continue to upstream these quirks!

Best,
Zhou

> 
>   - I don't really want to have to manage non-PCI information in the
>     struct pci_dev.  If this is AMBA- or IOMMU-related, it should be
>     stored in a structure related to AMBA or the IOMMU.
> .
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
