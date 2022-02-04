Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61394C43217
	for <iommu@archiver.kernel.org>; Fri,  4 Feb 2022 02:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8980840A7;
	Fri,  4 Feb 2022 02:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R8bkbVkuLp1p; Fri,  4 Feb 2022 02:55:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D585E8409E;
	Fri,  4 Feb 2022 02:55:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7867C0011;
	Fri,  4 Feb 2022 02:55:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA110C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 02:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 920A2840A0
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 02:55:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IPVGl-ovri9M for <iommu@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 02:55:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE9C48409E
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 02:55:43 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A667761AB9;
 Fri,  4 Feb 2022 02:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44D7C340E8;
 Fri,  4 Feb 2022 02:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643943342;
 bh=iFYVFJtjKaIbefdHLdpYqegeVUxQnXuKEpN+3Ch3AIA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dr8qqzYPKFmFJByEK9kO6IpaCaW2bVgGDR5hk16oTTfhfGHTPoaUlr0Z2MKd2sbTW
 zaBeSYK9ycn8fgB8Z8a180clQI9z3bWiKTyHJhz4+uhbMlXyYPkQ4gEZlM5x2szmk9
 drlBO+BE2DeRlnscsGLbH1vqAVjlD+6vzU9SH+ZhT+9yMwvcf2RZMhgUp8rROy9esK
 fJ6SOOMLfaSTdMLABEptYk/mhdKEpf2zEhxhW9QheMEtRF05JB35AR4DPFkp+3Vhjs
 oKHraGBRsNPAWo3JoZptsYDhK+33ru8rNbOXGNRVZ7eKuQ8HsBo0gz5X+iM6m0+PUX
 Vn9EA39y6g5cg==
Date: Thu, 3 Feb 2022 18:55:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V7 4/5] scsi: storvsc: Add Isolation VM support for
 storvsc driver
Message-ID: <20220203185539.3b70a6b9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220203155351.2ca86ab3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211213071407.314309-1-ltykernel@gmail.com>
 <20211213071407.314309-5-ltykernel@gmail.com>
 <20220203155351.2ca86ab3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
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

On Thu, 3 Feb 2022 15:53:51 -0800 Jakub Kicinski wrote:
> On Mon, 13 Dec 2021 02:14:05 -0500 Tianyu Lan wrote:
> > @@ -2078,6 +2079,7 @@ struct hv_device *vmbus_device_create(const guid_t *type,
> >  	return child_device_obj;
> >  }
> >  
> > +static u64 vmbus_dma_mask = DMA_BIT_MASK(64);  
> 
> This breaks the x86 clang allmodconfig build as I presume those
> involved know by now:
> 
> ../drivers/hv/vmbus_drv.c:2082:29: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
> static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
>                             ^~~~~~~~~~~~~~~~
> ../include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
> #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
>                                                      ^ ~~~
> 1 error generated.

Looks like a compiler issue actually, found the discussion now:

https://lore.kernel.org/llvm/202112181827.o3X7GmHz-lkp@intel.com/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
