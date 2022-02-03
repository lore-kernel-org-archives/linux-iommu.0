Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C080C433EF
	for <iommu@archiver.kernel.org>; Thu,  3 Feb 2022 23:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EF2D6400F6;
	Thu,  3 Feb 2022 23:54:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WokWcUpPibmX; Thu,  3 Feb 2022 23:54:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9D84D4022C;
	Thu,  3 Feb 2022 23:54:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71886C001A;
	Thu,  3 Feb 2022 23:54:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 887A5C000B
 for <iommu@lists.linux-foundation.org>; Thu,  3 Feb 2022 23:53:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 61F1260671
 for <iommu@lists.linux-foundation.org>; Thu,  3 Feb 2022 23:53:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eENLFZdDdugf for <iommu@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 23:53:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E59E6059D
 for <iommu@lists.linux-foundation.org>; Thu,  3 Feb 2022 23:53:58 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 53F74B8184E;
 Thu,  3 Feb 2022 23:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC84EC340E8;
 Thu,  3 Feb 2022 23:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643932434;
 bh=tIBMDUl1KSV62Vg/VFyfqCLarqutkx/5NsVZllWQuIU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=IIrLpytIhS33bMp6wD+kg5PysYuMemf04OOa2Lj1gpIMvmPHN1gxyLy1K7HLqJclZ
 c7l3vnEM9Jvc548pHw4nJ3lEO09bchMEB/ZLKPWnTCXwzz0iYkvXvgzDwBB9jqgS/f
 4WG+uTqDKvHAAi8AMh65/hh8PLifsBBX5Sg0WlFQdM6Oqlp9vA60RtDWgWzjQrTPiW
 OXz6dMSeWYbhgRqKfFdPC5GmQonZHLnPVry4ki9FY2iDTTK/DdtbCyWEPE/Nqa7csX
 CFI/COWjUi8SSQ0MM7Xeo4mcBueW81k4CinnEituMznCNOifCfE3L2MJEtJ68kkNGr
 FbovxEEWAEGuw==
Date: Thu, 3 Feb 2022 15:53:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V7 4/5] scsi: storvsc: Add Isolation VM support for
 storvsc driver
Message-ID: <20220203155351.2ca86ab3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20211213071407.314309-5-ltykernel@gmail.com>
References: <20211213071407.314309-1-ltykernel@gmail.com>
 <20211213071407.314309-5-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
 kys@microsoft.com, hch@lst.de, linux-arch@vger.kernel.org, hch@infradead.org,
 wei.liu@kernel.org, sthemmin@microsoft.com, linux-scsi@vger.kernel.org,
 x86@kernel.org, decui@microsoft.com, michael.h.kelley@microsoft.com,
 mingo@redhat.com, jejb@linux.ibm.com, parri.andrea@gmail.com,
 thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com, arnd@arndb.de,
 konrad.wilk@oracle.com, haiyangz@microsoft.com, bp@alien8.de,
 tglx@linutronix.de, martin.petersen@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com, davem@davemloft.net
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

On Mon, 13 Dec 2021 02:14:05 -0500 Tianyu Lan wrote:
> @@ -2078,6 +2079,7 @@ struct hv_device *vmbus_device_create(const guid_t *type,
>  	return child_device_obj;
>  }
>  
> +static u64 vmbus_dma_mask = DMA_BIT_MASK(64);

This breaks the x86 clang allmodconfig build as I presume those
involved know by now:

../drivers/hv/vmbus_drv.c:2082:29: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
                            ^~~~~~~~~~~~~~~~
../include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
#define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                     ^ ~~~
1 error generated.


Is there any ETA on getting the fix into Linus's tree?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
