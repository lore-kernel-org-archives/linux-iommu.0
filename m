Return-Path: <SRS0=6vqp=5Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFB4C43331
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 07:08:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC3B20658
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 07:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC3B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 22F29864A4;
	Tue, 31 Mar 2020 07:08:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i9cWHuV4-x16; Tue, 31 Mar 2020 07:08:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4FB2786365;
	Tue, 31 Mar 2020 07:08:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 449B6C1D85;
	Tue, 31 Mar 2020 07:08:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8ECD8C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 07:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 752C822798
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 07:08:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3q28yEZvjlzY for <iommu@lists.linux-foundation.org>;
 Tue, 31 Mar 2020 07:08:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 622D420420
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 07:08:35 +0000 (UTC)
IronPort-SDR: dUiWURKhxbu/2RUTuxY91xMWUFYcWJVzFchuMn/1KB8/WOa0f2/sYrx77EViQJexI4vw8Y03by
 R1YdGhHswA/g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 00:08:34 -0700
IronPort-SDR: LAcVC48tXZVNzrIzsW1uRGGaOLpng05aY2x0BJTn0dHY1nGGSlzZrj1UeRPTxkE9oc3ynp5abx
 B2/CAwssU0eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; d="scan'208";a="267183304"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.112])
 ([10.254.210.112])
 by orsmga002.jf.intel.com with ESMTP; 31 Mar 2020 00:08:26 -0700
Subject: Re: [PATCH v1 0/2] vfio/pci: expose device's PASID capability to VMs
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
References: <1584880394-11184-1-git-send-email-yi.l.liu@intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D801252@SHSMSX104.ccr.corp.intel.com>
From: "Lu, Baolu" <baolu.lu@intel.com>
Message-ID: <ce615f64-a19b-a365-8f8e-ca29f69cc6c0@intel.com>
Date: Tue, 31 Mar 2020 15:08:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D801252@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, baolu.lu@intel.com,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>
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

On 2020/3/31 14:35, Tian, Kevin wrote:
>> From: Liu, Yi L<yi.l.liu@intel.com>
>> Sent: Sunday, March 22, 2020 8:33 PM
>>
>> From: Liu Yi L<yi.l.liu@intel.com>
>>
>> Shared Virtual Addressing (SVA), a.k.a, Shared Virtual Memory (SVM) on
>> Intel platforms allows address space sharing between device DMA and
>> applications. SVA can reduce programming complexity and enhance security.
>>
>> To enable SVA, device needs to have PASID capability, which is a key
>> capability for SVA. This patchset exposes the device's PASID capability
>> to guest instead of hiding it from guest.
>>
>> The second patch emulates PASID capability for VFs (Virtual Function) since
>> VFs don't implement such capability per PCIe spec. This patch emulates such
>> capability and expose to VM if the capability is enabled in PF (Physical
>> Function).
>>
>> However, there is an open for PASID emulation. If PF driver disables PASID
>> capability at runtime, then it may be an issue. e.g. PF should not disable
>> PASID capability if there is guest using this capability on any VF related
>> to this PF. To solve it, may need to introduce a generic communication
>> framework between vfio-pci driver and PF drivers. Please feel free to give
>> your suggestions on it.
> I'm not sure how this is addressed on bate metal today, i.e. between normal
> kernel PF and VF drivers. I look at pasid enable/disable code in intel-iommu.c.
> There is no check on PF/VF dependency so far. The cap is toggled when
> attaching/detaching the PF to its domain. Let's see how IOMMU guys
> respond, and if there is a way for VF driver to block PF driver from disabling
> the pasid cap when it's being actively used by VF driver, then we may
> leverage the same trick in VFIO when emulation is provided to guest.

IOMMU subsystem doesn't expose any APIs for pasid enabling/disabling.
The PCI subsystem does. It handles VF/PF like below.

/**
  * pci_enable_pasid - Enable the PASID capability
  * @pdev: PCI device structure
  * @features: Features to enable
  *
  * Returns 0 on success, negative value on error. This function checks
  * whether the features are actually supported by the device and returns
  * an error if not.
  */
int pci_enable_pasid(struct pci_dev *pdev, int features)
{
         u16 control, supported;
         int pasid = pdev->pasid_cap;

         /*
          * VFs must not implement the PASID Capability, but if a PF
          * supports PASID, its VFs share the PF PASID configuration.
          */
         if (pdev->is_virtfn) {
                 if (pci_physfn(pdev)->pasid_enabled)
                         return 0;
                 return -EINVAL;
         }

/**
  * pci_disable_pasid - Disable the PASID capability
  * @pdev: PCI device structure
  */
void pci_disable_pasid(struct pci_dev *pdev)
{
         u16 control = 0;
         int pasid = pdev->pasid_cap;

         /* VFs share the PF PASID configuration */
         if (pdev->is_virtfn)
                 return;


It doesn't block disabling PASID on PF even VFs are possibly using it.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
