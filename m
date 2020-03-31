Return-Path: <SRS0=6vqp=5Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5E4C43331
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 06:35:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8A82072A
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 06:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8A82072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 52E468618F;
	Tue, 31 Mar 2020 06:35:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 50K0qKw3Y5lv; Tue, 31 Mar 2020 06:35:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3604785FF3;
	Tue, 31 Mar 2020 06:35:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 279F3C1AE8;
	Tue, 31 Mar 2020 06:35:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8ECE3C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 06:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7E73588400
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 06:35:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1cqX437vB+kT for <iommu@lists.linux-foundation.org>;
 Tue, 31 Mar 2020 06:35:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8EDDB883F1
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 06:35:14 +0000 (UTC)
IronPort-SDR: OzypfppR6BErHd7wJqpCEV8//3hB1BaqaxiPz7qDzddQ2G7TSJeX+pKLVwgSdYD/WrtJTVizhM
 p5shu3JyKpTQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 23:35:14 -0700
IronPort-SDR: mU6pStwPFYGu0M94JQjxJM+3SvfamtjAOlCPQ1DezUR97gQuUe6yzJSzqhbYhJ6rRPhMgr74Yw
 Vizk80G+7nXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; d="scan'208";a="448555984"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga005.fm.intel.com with ESMTP; 30 Mar 2020 23:35:14 -0700
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 23:35:13 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx163.amr.corp.intel.com (10.18.125.72) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 23:35:13 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.22]) with mapi id 14.03.0439.000;
 Tue, 31 Mar 2020 14:35:09 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [PATCH v1 0/2] vfio/pci: expose device's PASID capability to VMs
Thread-Topic: [PATCH v1 0/2] vfio/pci: expose device's PASID capability to VMs
Thread-Index: AQHWAEVE1+HhDDDknUKu1iBKdD1ORKhiSCUA
Date: Tue, 31 Mar 2020 06:35:08 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D801252@SHSMSX104.ccr.corp.intel.com>
References: <1584880394-11184-1-git-send-email-yi.l.liu@intel.com>
In-Reply-To: <1584880394-11184-1-git-send-email-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lu,
 Baolu" <baolu.lu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Wu,
 Hao" <hao.wu@intel.com>
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

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Sunday, March 22, 2020 8:33 PM
> 
> From: Liu Yi L <yi.l.liu@intel.com>
> 
> Shared Virtual Addressing (SVA), a.k.a, Shared Virtual Memory (SVM) on
> Intel platforms allows address space sharing between device DMA and
> applications. SVA can reduce programming complexity and enhance security.
> 
> To enable SVA, device needs to have PASID capability, which is a key
> capability for SVA. This patchset exposes the device's PASID capability
> to guest instead of hiding it from guest.
> 
> The second patch emulates PASID capability for VFs (Virtual Function) since
> VFs don't implement such capability per PCIe spec. This patch emulates such
> capability and expose to VM if the capability is enabled in PF (Physical
> Function).
> 
> However, there is an open for PASID emulation. If PF driver disables PASID
> capability at runtime, then it may be an issue. e.g. PF should not disable
> PASID capability if there is guest using this capability on any VF related
> to this PF. To solve it, may need to introduce a generic communication
> framework between vfio-pci driver and PF drivers. Please feel free to give
> your suggestions on it.

I'm not sure how this is addressed on bate metal today, i.e. between normal 
kernel PF and VF drivers. I look at pasid enable/disable code in intel-iommu.c.
There is no check on PF/VF dependency so far. The cap is toggled when 
attaching/detaching the PF to its domain. Let's see how IOMMU guys 
respond, and if there is a way for VF driver to block PF driver from disabling
the pasid cap when it's being actively used by VF driver, then we may
leverage the same trick in VFIO when emulation is provided to guest.

Thanks
Kevin

> 
> Regards,
> Yi Liu
> 
> Changelog:
> 	- RFC v1 -> Patch v1:
> 	  Add CONFIG_PCI_ATS #ifdef control to avoid compiling error.
> 
> Liu Yi L (2):
>   vfio/pci: Expose PCIe PASID capability to guest
>   vfio/pci: Emulate PASID/PRI capability for VFs
> 
>  drivers/vfio/pci/vfio_pci_config.c | 327
> ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 324 insertions(+), 3 deletions(-)
> 
> --
> 2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
