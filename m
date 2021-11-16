Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFC6C433EF
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 06:05:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA40763218
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 06:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA40763218
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9957D80C88;
	Tue, 16 Nov 2021 06:05:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oX_rhORbTGFP; Tue, 16 Nov 2021 06:05:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6C05B80D2E;
	Tue, 16 Nov 2021 06:05:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D144C002E;
	Tue, 16 Nov 2021 06:05:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DF68C0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 06:05:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 47A21607C8
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 06:05:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fBAw9mI4SVwD for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 06:05:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 15887607C2
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 06:05:37 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="319842412"
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; d="scan'208";a="319842412"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 22:05:35 -0800
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; d="scan'208";a="454327607"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.107])
 ([10.254.215.107])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 22:05:29 -0800
Message-ID: <c7add816-853a-c31d-6425-464512a2de61@linux.intel.com>
Date: Tue, 16 Nov 2021 14:05:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20211115221747.GA1587608@bhelgaas>
Content-Language: en-US
Subject: Re: [PATCH 03/11] PCI: pci_stub: Suppress kernel DMA ownership
 auto-claiming
In-Reply-To: <20211115221747.GA1587608@bhelgaas>
Cc: Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-pci@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>
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

On 11/16/21 6:17 AM, Bjorn Helgaas wrote:
> On Mon, Nov 15, 2021 at 10:05:44AM +0800, Lu Baolu wrote:
>> pci_stub allows the admin to block driver binding on a device and make
>> it permanently shared with userspace. Since pci_stub does not do DMA,
>> it is safe. However the admin must understand that using pci_stub allows
>> userspace to attack whatever device it was bound to.
> This commit log doesn't say what the patch does.  I think it tells us
> something about what pci-stub*already*  does ("allows admin to block
> driver binding") and something about why that is safe ("does not do
> DMA").

Yes, you are right. This patch is to keep the pci_stub's existing use
case ("allows admin to block driver binding") after moving the viable
check from the vfio to iommu layer (done by this series).

About "safe" (should not be part of this description), there are two
sides from my understanding:

#1) The pci_stub driver itself doesn't control the device to do any DMA.
     So it won't interfere the user space through device DMA.

#2) The pci_stub driver doesn't access the PCI bar and doesn't build any
     device driver state around any value in the bar. So other devices
     in the same iommu group (assigned to user space) have no means to
     change the kernel driver consistency via p2p access.
> 
> But it doesn't say what this patch changes.  Based on the subject
> line, I expected something like:
> 
>    As of ("<commit subject>"), <some function>() marks the iommu_group
>    as containing only devices with kernel drivers that manage DMA.
> 
>    Avoid this default behavior for pci-stub because it does not program
>    any DMA itself.  This allows <some desirable behavior>.
> 

Sure. I will rephrase the description like above.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
