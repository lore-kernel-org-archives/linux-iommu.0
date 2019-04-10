Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E2CC10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 12:35:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DCA82082E
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 12:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCA82082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 61F0A17FE;
	Wed, 10 Apr 2019 12:35:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B9B0617FB
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 12:35:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 5A166174
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 12:35:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA54DA78;
	Wed, 10 Apr 2019 05:35:39 -0700 (PDT)
Received: from debian (c02th0x6hf1t.nice.arm.com [10.36.160.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34D883F59C;
	Wed, 10 Apr 2019 05:35:36 -0700 (PDT)
Date: Wed, 10 Apr 2019 14:35:32 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v6 09/22] vfio: VFIO_IOMMU_BIND/UNBIND_MSI
Message-ID: <20190410123531.GA19023@debian>
References: <20190317172232.1068-1-eric.auger@redhat.com>
	<20190317172232.1068-10-eric.auger@redhat.com>
	<20190321170159.38358f38@x1.home>
	<16931d58-9c88-8cfb-a392-408ea7afdf16@redhat.com>
	<20190322160947.3f8dacdb@x1.home>
	<b47128de-88d0-1971-1fbc-86e43439c7ee@redhat.com>
	<20190403113800.51503693@x1.home>
	<4b27b707-4917-2c3e-a13c-3b978e850d09@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4b27b707-4917-2c3e-a13c-3b978e850d09@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: yi.l.liu@linux.intel.com, kevin.tian@intel.com, ashok.raj@intel.com,
	kvm@vger.kernel.org, peter.maydell@linaro.org,
	jean-philippe.brucker@arm.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	christoffer.dall@arm.com, marc.zyngier@arm.com,
	Alex Williamson <alex.williamson@redhat.com>,
	robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu,
	eric.auger.pro@gmail.com
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190410123532.Dcfz4pCjXYOtXrkQZPROnDUfi8IdaBnjF_vZkooU7DI@z>

On Thu, Apr 04, 2019 at 08:55:25AM +0200, Auger Eric wrote:
> Hi Marc, Robin, Alex,
(..)
> Do you think this is a reasonable assumption to consider devices within
> the same host iommu group share the same MSI doorbell?

Hi Eric,

I am not sure this assumption always hold.

Marc, Robin and Alex can correct me, but for example I think the following
topology is valid for Arm systems:

 +------------+  +------------+
 | Endpoint A |  | Endpoint B |
 +------------+  +------------+
            v     v
          /---------\
         |  Non-ACS  |
         |  Switch   |
          \---------/
               v
       +---------------+
       |     PCIe      |
       | Root Complex  |
       +---------------+
               v
         +-----------+
         |   SMMU    |
         +-----------+
               v
  +--------------------------+
  |   System interconnect    |
  +--------------------------+
        v              v
  +-----------+  +-----------+
  |   ITS A   |  |   ITS B   |
  +-----------+  +-----------+

All PCIe Endpoints and ITS could be in the same ITS Group 0, meaning
devices could send their MSI at any ITS in hardware.

For Linux the two PCIe Endpoints would be in the same iommu group, because
the switch in this example does not support ACS.

I think the devicetree msi-map property could be used to "map" the RID of
Endpoint A to ITS A and the RID of Endpoint B to ITS B, which would violate
the assumption.

See the monolithic example in [1], the example system in [2], appendices
D, E and F in [3] and the msi-map property in [4].

Best regards,
Vincent.

[1] https://static.docs.arm.com/100336/0102/corelink_gic600_generic_interrupt_controller_technical_reference_manual_100336_0102_00_en.pdf
[2] http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf
[3] https://static.docs.arm.com/den0029/50/Q1-DEN0029B_SBSA_5.0.pdf
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/pci-msi.txt
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
