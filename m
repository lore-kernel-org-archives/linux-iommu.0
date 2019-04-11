Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4BBC10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 15:20:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 533522083E
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 15:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533522083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 289FF29A3;
	Thu, 11 Apr 2019 15:20:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E5AE9299C
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 15:19:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8803E63D
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 15:19:19 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 7AEA2451; Thu, 11 Apr 2019 17:19:17 +0200 (CEST)
Date: Thu, 11 Apr 2019 17:19:17 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v8 0/9] vfio/mdev: IOMMU aware mediated device
Message-ID: <20190411151917.GA29810@8bytes.org>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190325013036.18400-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: kevin.tian@intel.com, ashok.raj@intel.com, tiwei.bie@intel.com,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	sanjay.k.kumar@intel.com, Kirti Wankhede <kwankhede@nvidia.com>,
	linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
	kvm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	yi.y.sun@intel.com
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
Message-ID: <20190411151917.zLF40AI7D0ojXs0yydWdDN6mNUR1yPOq9BaAH4WgpLA@z>

Hi Lu Baolu,

thanks for these patches!

On Mon, Mar 25, 2019 at 09:30:27AM +0800, Lu Baolu wrote:
> Lu Baolu (9):
>   iommu: Add APIs for multiple domains per device
>   iommu/vt-d: Make intel_iommu_enable_pasid() more generic
>   iommu/vt-d: Add per-device IOMMU feature ops entries
>   iommu/vt-d: Move common code out of iommu_attch_device()
>   iommu/vt-d: Aux-domain specific domain attach/detach
>   iommu/vt-d: Return ID associated with an auxiliary domain

I applied the patches above to my tree. The first patch is in a new
branch called 'api-features' and the other are in the x86/vt-d branch.

>   vfio/mdev: Add iommu related member in mdev_device
>   vfio/type1: Add domain at(de)taching group helpers
>   vfio/type1: Handle different mdev isolation type

Can you please address the minor concern on these patches, add all
review and acks and re-send?

Thanks,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
