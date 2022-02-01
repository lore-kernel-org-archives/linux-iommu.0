Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82590C433F5
	for <iommu@archiver.kernel.org>; Tue,  1 Feb 2022 18:52:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3201982B1B;
	Tue,  1 Feb 2022 18:52:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PVTzINVqOLFH; Tue,  1 Feb 2022 18:52:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2851182A4F;
	Tue,  1 Feb 2022 18:52:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A232C0011;
	Tue,  1 Feb 2022 18:52:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9BB2C000B
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 18:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A3DEF82A87
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 18:52:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 19_iCqo_Ecz5 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Feb 2022 18:52:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 087E182A4F
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 18:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643741568; x=1675277568;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CQwFrYX1FI0R9WdeDI/dWEHu7Crdzf7Lns9n0HGRFbM=;
 b=UObPOVn4hwjbZNsRxe30iq2NvZ7ZSSNlplgu18vagfz16rFMbWZgjUjP
 dNbWTGmBlrDIyxq5wAdjVQuC1Ar1f0DGHzP2zf90povB3v5i+DoRr7jG/
 usQVFgEP5kgtu3pjrc7kKkIavgZz2xgMakLUEoo+i6GP1u50+tuhz/DJZ
 BBCu1VJ0EHNv/xSWiei9EbU+sHDQ4Xl12NGhIaYaXaJutW1MwK4E6e0hm
 Q3lHQDL9j8CkWnFGad9mtyONy+7oXlhGEHUM0U/13uXMrrlPtzXSuuLEj
 UEwzC5XdqZBeq7jacsZGeUfz+3wraVPniUNiyN6bThQ0ebR4FzzNAaI1a g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="246594354"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; d="scan'208";a="246594354"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2022 10:52:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; d="scan'208";a="565689263"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2022 10:52:47 -0800
Date: Tue, 1 Feb 2022 10:55:40 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix PCI bus rescan device hot add
Message-ID: <20220201105540.5fe7eb7d@jacob-builder>
In-Reply-To: <YfZBlzYTN/RfCGnE@8bytes.org>
References: <20220128031002.2219155-1-baolu.lu@linux.intel.com>
 <20220128031002.2219155-2-baolu.lu@linux.intel.com>
 <YfZBlzYTN/RfCGnE@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Zhang@8bytes.org, iommu@lists.linux-foundation.org,
 Guoqing Jiang <guoqing.jiang@linux.dev>, Bernice <bernice.zhang@intel.com>
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

Hi Joerg,

On Sun, 30 Jan 2022 08:43:19 +0100, Joerg Roedel <joro@8bytes.org> wrote:

> Hi Jacob, Baolu,
> 
> On Fri, Jan 28, 2022 at 11:10:01AM +0800, Lu Baolu wrote:
> > During PCI bus rescan, adding new devices involve two notifiers.
> > 1. dmar_pci_bus_notifier()
> > 2. iommu_bus_notifier()
> > The current code sets #1 as low priority (INT_MIN) which resulted in #2
> > being invoked first. The result is that struct device pointer cannot be
> > found in DRHD search for the new device's DMAR/IOMMU. Subsequently, the
> > device is put under the "catch-all" IOMMU instead of the correct one.  
> 
> There are actually iommu_ops pointers invoked from iommu_bus_notifier()
> into IOMMU driver code. Can those be used to enforce the ordering in a
> more reliable way?
> 
The race condition is between PCI/ACPI and IOMMU subsystems, I don't see
how having IOMMU internal ops can solve the external race.  Perhaps we
should merge into one notifier to have direct control of the ordering, is
that what you are suggesting? It seems to be a good albeit larger clean-up
I can look into.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
