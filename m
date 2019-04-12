Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E961DC10F14
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 11:03:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7FD2186A
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 11:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7FD2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4A6AF1468;
	Fri, 12 Apr 2019 11:03:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8604E1407
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 11:03:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 17475F4
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 11:03:19 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 451FB21D; Fri, 12 Apr 2019 13:03:17 +0200 (CEST)
Date: Fri, 12 Apr 2019 13:03:15 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v9 0/3] vfio/mdev: IOMMU aware mediated device
Message-ID: <20190412110315.GH4518@8bytes.org>
References: <20190412041326.19914-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190412041326.19914-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Message-ID: <20190412110315.s9cLH050FhrcUzw7nXMhTy4SZbGVjg1g6ObZdy4BBKc@z>

On Fri, Apr 12, 2019 at 12:13:23PM +0800, Lu Baolu wrote:
> Lu Baolu (3):
>   vfio/mdev: Add iommu related member in mdev_device
>   vfio/type1: Add domain at(de)taching group helpers
>   vfio/type1: Handle different mdev isolation type

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
