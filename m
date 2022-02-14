Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DB8C433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 10:31:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CAE260DE5;
	Mon, 14 Feb 2022 10:31:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PD3s2Lz46uZO; Mon, 14 Feb 2022 10:31:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2052860DB2;
	Mon, 14 Feb 2022 10:31:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03FB0C0011;
	Mon, 14 Feb 2022 10:31:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAADAC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 10:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AB7E460EB6
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 10:31:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WPy3hl2IOCgh for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 10:31:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F05360EC9
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 10:31:11 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 358A336D; Mon, 14 Feb 2022 11:31:08 +0100 (CET)
Date: Mon, 14 Feb 2022 11:31:03 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix PCI bus rescan device hot add
Message-ID: <YgovZzFR1HNQP2Nk@8bytes.org>
References: <20220128031002.2219155-1-baolu.lu@linux.intel.com>
 <20220128031002.2219155-2-baolu.lu@linux.intel.com>
 <YfZBlzYTN/RfCGnE@8bytes.org>
 <d9c35bb7-e6f5-a439-505b-5352c34f5621@arm.com>
 <YfgFqp+lR9wRdUWn@8bytes.org>
 <20220201111918.48aadfdf@jacob-builder>
 <20220203082150.qjsssis6ygh34yen@8bytes.org>
 <20220209135249.690b8a08@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220209135249.690b8a08@jacob-builder>
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Guoqing Jiang <guoqing.jiang@linux.dev>, Bernice <bernice.zhang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>
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

Hi Jacob,

On Wed, Feb 09, 2022 at 01:52:49PM -0800, Jacob Pan wrote:
> Another option Ashok and I discussed is that we can make DMAR cache persist
> (which should be for explicitly listed devices in each DRHD) across PCI
> remove-rescan cycle, then we don't need the DMAR PCI bus notifier at all.
> 
> This bug only impacts RCIEP device hotplug, which is not the most reasonable
> use case, we have the space to look into a proper fix.

Even better if you can make the notifier obsolete. Looking forward to
the fix.

Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
