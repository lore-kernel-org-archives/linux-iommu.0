Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2905BC433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 11:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF6F98123F;
	Tue,  1 Mar 2022 11:53:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6KtaBky-LexV; Tue,  1 Mar 2022 11:53:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E3E0A8124A;
	Tue,  1 Mar 2022 11:53:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B768AC0077;
	Tue,  1 Mar 2022 11:53:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5490FC001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 11:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34D0F60B1E
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 11:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CE8xNGrSLOJe for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 11:53:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A67DA60761
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 11:53:45 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id BD48368AFE; Tue,  1 Mar 2022 12:53:40 +0100 (CET)
Date: Tue, 1 Mar 2022 12:53:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Message-ID: <20220301115340.GA3077@lst.de>
References: <20220214081919.GA18337@lst.de>
 <4f433f07-05be-f81f-43e8-55c3f1af23b3@gmail.com>
 <20220214135834.GA30150@lst.de>
 <8d052867-ccff-f00f-7c89-cc26a4bfa347@gmail.com>
 <23f4a64d-5977-1816-8faa-fe7691ace2ff@gmail.com>
 <20220222080543.GA5412@lst.de>
 <00112505-4999-ac41-877e-49c4cc45312e@gmail.com>
 <20220222160039.GA13380@lst.de>
 <40f91949-58fa-4be2-5b01-ea34dda58670@gmail.com>
 <a80a7efa-f15d-3649-f39f-c24820f9ef2b@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a80a7efa-f15d-3649-f39f-c24820f9ef2b@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com,
 wei.liu@kernel.org, sthemmin@microsoft.com, x86@kernel.org,
 decui@microsoft.com, michael.h.kelley@microsoft.com, mingo@redhat.com,
 parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
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

On Fri, Feb 25, 2022 at 10:28:54PM +0800, Tianyu Lan wrote:
>      One more perspective is that one device may have multiple queues and 
> each queues should have independent swiotlb bounce buffer to avoid spin 
> lock overhead. The number of queues is only available in the device
> driver. This means new API needs to be called in the device driver 
> according to queue number.

Well, given how hell bent people are on bounce buffering we might
need some scalability work there anyway.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
