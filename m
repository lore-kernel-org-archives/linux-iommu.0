Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4871C433F5
	for <iommu@archiver.kernel.org>; Tue, 22 Feb 2022 04:50:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FCCC408FE;
	Tue, 22 Feb 2022 04:50:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6cAwkM-Ft-NG; Tue, 22 Feb 2022 04:50:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 18086408E7;
	Tue, 22 Feb 2022 04:50:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE310C0021;
	Tue, 22 Feb 2022 04:50:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37615C0011
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 04:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31D614058C
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 04:50:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xuByIjnB9BxP for <iommu@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 04:50:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2166640145
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 04:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645505413; x=1677041413;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7bEcFXv/PBrDnpJkRJDcOGeL+LDolQ6d+dndBSOh350=;
 b=OynYmG91V6PR7jjP7JxxeTVU62vdQkFD+Zjpefce0srvegQb9yHN6plE
 OtUs5yutGkGBKdCyzvbb+7i7L/0fbdMEgXVp8TiRbyWafAjP0J/F9LnQx
 S7roeSwOdmJaaMVZ+28YGXNz4BcCNSFlESFfHsouGWjeFxoGW9SH87sPC
 IID+GYc3O5Jx0rv0TJCLrrjpJoxRioLiPYlL+3bmtZOWnvnCm/Z7ek/er
 X+PAtRzUFyDbvgo1NEp7cUucqO/oM6/CrOPyoY/R3rhHlNMfQCHJvxW1u
 WPwuA40o74VilO9YrVU09yI3OsWYbhkLmNbSTkPn/g6/mtsiDO2btamHB A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="232230488"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; d="scan'208";a="232230488"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2022 20:50:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; d="scan'208";a="683385469"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2022 20:50:06 -0800
Message-ID: <c212094a-399e-1038-99e0-7a08d0da2a61@linux.intel.com>
Date: Tue, 22 Feb 2022 12:48:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 02/11] driver core: Add dma_cleanup callback in bus_type
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
 <20220218005521.172832-3-baolu.lu@linux.intel.com>
 <YhCdEmC2lYStmUSL@infradead.org>
 <1d8004d3-1887-4fc7-08d2-0e2ee6b5fdcb@arm.com>
 <20220221234837.GA10061@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220221234837.GA10061@nvidia.com>
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Stuart Yoder <stuyoder@gmail.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

On 2/22/22 7:48 AM, Jason Gunthorpe wrote:
>> since we should only care about ownership at probe, hotplug, and other
>> places well outside critical fast-paths, I'm not sure we really need to keep
>> track of that anyway - it can always be recalculated by walking the
>> group->devices list,
> It has to be locked against concurrent probe, and there isn't
> currently any locking scheme that can support this. The owner_cnt is
> effectively a new lock for this purpose. It is the same issue we
> talked about with that VFIO patch you showed me.
> 
> So, using the group->device_list would require adding something else
> somewhere - which I think should happen when someone has
> justification for another use of whatever that something else is.

This series was originated from the similar idea by adding some fields
in driver structure and intercepting it in iommu core. We stopped doing
that due to the lack of lock mechanism between iommu and driver core.
It then evolved into what it is today.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
