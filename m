Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1E1C433E0
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 18:51:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78143207C4
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 18:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78143207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 484F786C20;
	Mon, 18 May 2020 18:51:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gnJMcuswSycH; Mon, 18 May 2020 18:51:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B047884D3A;
	Mon, 18 May 2020 18:50:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C4B6C0881;
	Mon, 18 May 2020 18:50:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D692DC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 18:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CDF3A87ED6
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 18:50:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TEzST9sPPByU for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 18:50:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 80118856C8
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 18:50:43 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 8AE7333E; Mon, 18 May 2020 20:50:40 +0200 (CEST)
Date: Mon, 18 May 2020 20:50:39 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 00/18] [PULL REQUEST] iommu/vt-d: patches for v5.8
Message-ID: <20200518185038.GF18353@8bytes.org>
References: <20200516062101.29541-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200516062101.29541-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>
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

On Sat, May 16, 2020 at 02:20:43PM +0800, Lu Baolu wrote:
> Jacob Pan (9):
>   iommu/vt-d: Move domain helper to header
>   iommu/vt-d: Use a helper function to skip agaw for SL
>   iommu/vt-d: Add nested translation helper function
>   iommu/vt-d: Add bind guest PASID support
>   iommu/vt-d: Support flushing more translation cache types
>   iommu/vt-d: Add svm/sva invalidate function
>   iommu/vt-d: Add custom allocator for IOASID
>   iommu/vt-d: Report SVA feature with generic flag
>   iommu/vt-d: Replace intel SVM APIs with generic SVA APIs
> 
> Lu Baolu (8):
>   iommu/vt-d: Enlightened PASID allocation
>   iommu/vt-d: Add get_domain_info() helper
>   iommu/vt-d: Multiple descriptors per qi_submit_sync()
>   iommu/vt-d: debugfs: Add support to show inv queue internals
>   iommu/vt-d: Disable non-recoverable fault processing before unbind
>   iommu/vt-d: Add page request draining support
>   iommu/vt-d: Remove redundant IOTLB flush
>   iommu/vt-d: Remove duplicated check in intel_svm_bind_mm()
> 
> Tom Murphy (1):
>   iommu/vt-d: Remove IOVA handling code from the non-dma_ops path

I get these new compile warnings on x86-32 after pulling in these
patches:

    drivers/iommu/intel-pasid.c:818:6: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    drivers/iommu/intel-pasid.c:821:9: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    drivers/iommu/intel-pasid.c:824:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    drivers/iommu/intel-svm.c:343:45: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]

Can you please take a look and send me a fix for these?


Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
