Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20E1C433EF
	for <iommu@archiver.kernel.org>; Wed,  2 Feb 2022 08:12:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 567F281BB0;
	Wed,  2 Feb 2022 08:12:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C8kIBpblUtRv; Wed,  2 Feb 2022 08:12:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 477F7825C7;
	Wed,  2 Feb 2022 08:12:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FC31C0011;
	Wed,  2 Feb 2022 08:12:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F732C000B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 08:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 17F2360B32
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 08:12:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9d4zzthcGgUe for <iommu@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 08:12:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E42960B31
 for <iommu@lists.linux-foundation.org>; Wed,  2 Feb 2022 08:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=8GJ5K7tr5w0SjCFIVP9oFwV+EwJP4fhHZpV9DwIIpaE=; b=SaGPsaGm+57lnEX5wGtjbquwYs
 y8VdTUH21OF8ClB7mCR/yuaOGdMU+QSmNNGfgDNZK0aHXR2qD2kxSIwKdV/GtvONfnjYwAh9ZWHmN
 ZT2UVS034FkvfUNR/OO/aN79vJbTp4fdp7wjgCIFWiuh/5fjK3h2B24/wgGHjYf/0rne5OnZP81JP
 6CT/gjgpYnXS+wR4Rz1JLY54WPHi1DpoCsokzuS5a6YzmnkaJy9c892/Hbv1WDvBfLH2/4tMEWfBC
 FXd0ASzVCeEdjr4P1ojkJiRx6Mf+Qzu+Y0xhoY5dt8JOLPV8p+0cne7OHjfTUoRZt8U5g/D+dJB+P
 Azxf9qLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nFAkT-00EX17-VS; Wed, 02 Feb 2022 08:12:17 +0000
Date: Wed, 2 Feb 2022 00:12:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH 0/2] x86/hyperv/Swiotlb: Add swiotlb_alloc_from_low_pages
 switch
Message-ID: <Yfo84XYBsV7tA6Xd@infradead.org>
References: <20220126161053.297386-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220126161053.297386-1-ltykernel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com, hch@lst.de,
 hch@infradead.org, wei.liu@kernel.org, sthemmin@microsoft.com, x86@kernel.org,
 decui@microsoft.com, michael.h.kelley@microsoft.com, mingo@redhat.com,
 parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com
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

I think this interface is a little too hacky.  In the end all the
non-trusted hypervisor schemes (including the per-device swiotlb one)
can allocate the memory from everywhere and want for force use of
swiotlb.  I think we need some kind of proper interface for that instead
of setting all kinds of global variables.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
