Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A88EC433F5
	for <iommu@archiver.kernel.org>; Wed,  2 Feb 2022 13:23:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B47B60FAF;
	Wed,  2 Feb 2022 13:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BN3gcT6oSDPp; Wed,  2 Feb 2022 13:23:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F03CF60B34;
	Wed,  2 Feb 2022 13:23:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C634DC0011;
	Wed,  2 Feb 2022 13:23:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A520C000B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 13:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29BFA401B9
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 13:23:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QokkcyMTAh_e for <iommu@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 13:23:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A6EB40188
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 13:23:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49719ED1;
 Wed,  2 Feb 2022 05:23:12 -0800 (PST)
Received: from [10.57.68.47] (unknown [10.57.68.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65DE23F718;
 Wed,  2 Feb 2022 05:23:08 -0800 (PST)
Message-ID: <862bfda8-5c95-3743-3758-2e63faa7ac3e@arm.com>
Date: Wed, 2 Feb 2022 13:22:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 0/2] x86/hyperv/Swiotlb: Add swiotlb_alloc_from_low_pages
 switch
Content-Language: en-GB
To: Christoph Hellwig <hch@infradead.org>, Tianyu Lan <ltykernel@gmail.com>
References: <20220126161053.297386-1-ltykernel@gmail.com>
 <Yfo84XYBsV7tA6Xd@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yfo84XYBsV7tA6Xd@infradead.org>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com, hch@lst.de,
 wei.liu@kernel.org, sthemmin@microsoft.com, x86@kernel.org,
 decui@microsoft.com, michael.h.kelley@microsoft.com, mingo@redhat.com,
 parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com
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

On 2022-02-02 08:12, Christoph Hellwig wrote:
> I think this interface is a little too hacky.  In the end all the
> non-trusted hypervisor schemes (including the per-device swiotlb one)
> can allocate the memory from everywhere and want for force use of
> swiotlb.  I think we need some kind of proper interface for that instead
> of setting all kinds of global variables.

Right, if platform/hypervisor code knows enough to be able to set magic 
non-standard allocation flags correctly, surely it could equally just 
perform whatever non-standard allocation it needs and call 
swiotlb_init_with_tbl() instead of swiotlb_init().

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
