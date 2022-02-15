Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5A9C433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 09:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90694409DD;
	Tue, 15 Feb 2022 09:17:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yfN8NShWFp6J; Tue, 15 Feb 2022 09:17:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7C0BD40943;
	Tue, 15 Feb 2022 09:17:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A2D7C0011;
	Tue, 15 Feb 2022 09:17:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1564C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 09:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DEF7660E55
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 09:17:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GYHfbvDr32El for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 09:17:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4AFEA60B1A
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 09:17:36 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 0760136D; Tue, 15 Feb 2022 10:17:33 +0100 (CET)
Date: Tue, 15 Feb 2022 10:17:32 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 00/10] iommu cleanup and refactoring
Message-ID: <YgtvrJ2eIUV+U84u@8bytes.org>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
 <YgpjzNtQlOdq+1AB@8bytes.org>
 <1d817995-f89b-a1de-6aff-9a2bfe91367f@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1d817995-f89b-a1de-6aff-9a2bfe91367f@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Daniel Vetter <daniel@ffwll.ch>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

Hi Baolu,

On Tue, Feb 15, 2022 at 10:05:42AM +0800, Lu Baolu wrote:
> Do you want me to send a new version with below changes:
> 
> - Remove WARN_ON() in dev_iommu_ops();
> - Merge above two patches.
> 
> Or, you can change above yourself?

Please make the changes and send a new version. I will apply it to the
iommu core branch then. The build-tests with this patch-set went well
and I havn't spotted anything else in my review, so I think it is in
good shape for linux-next testing.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
