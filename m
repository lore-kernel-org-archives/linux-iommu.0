Return-Path: <SRS0=amFV=MT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B3DC4338F
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 12:58:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7947F608FB
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 12:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7947F608FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40D3F6062A;
	Tue, 27 Jul 2021 12:58:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ovpd_LL49P9; Tue, 27 Jul 2021 12:58:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 12F04600B4;
	Tue, 27 Jul 2021 12:58:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E47C7C001A;
	Tue, 27 Jul 2021 12:58:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 611ACC000E
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 12:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 424F6400DB
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 12:58:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pojaK45ns5uX for <iommu@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 12:58:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8EEF9400BF
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 12:58:01 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5C54610D0;
 Tue, 27 Jul 2021 12:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627390681;
 bh=upwwg6+mtRT400miON1xGrEGEisD4k2v28v1j+AGpgk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rw/J9LN5ZJi6FHPU0vYJRZoIqMhSvG1QeCOj60BHUE7+SJtZye8gyJEYrRz5EtlNC
 tNWc1WCz//hQlth7tKzJHPdH/1GTYUjV5Hy1EwYpE3ptni29hD3gYAmgmXwnsS/wGk
 cuFdxRNV/LuSNGQbJQMHybqlrl4e37lEUMg7dOfw3Z42qaU+AgqSzKIgcNqeroEKHe
 8I8GXS0LxK+uzm70wggraYVKBq9FwLrh16CDsIaWb5u6jzcMkjv4bed25MeufxnXjD
 5rsLHSY3ZH4c3GBzvnqGLWMHFR6qS7H3hSLV9EVmz+VbpjNOZ3bVlEjBjJO1xaqU3T
 DVtgQq1zSL2Bg==
Date: Tue, 27 Jul 2021 13:57:55 +0100
From: Will Deacon <will@kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 1/1] s390/pv: fix the forcing of the swiotlb
Message-ID: <20210727125755.GA18586@willie-the-truck>
References: <20210723231746.3964989-1-pasic@linux.ibm.com>
 <YPtejB62iu+iNrM+@fedora>
 <a89f1add-b0fb-1069-cb30-78864e399b19@de.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a89f1add-b0fb-1069-cb30-78864e399b19@de.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Nathan Chancellor <nathan@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Halil Pasic <pasic@linux.ibm.com>, iommu@lists.linux-foundation.org,
 Claire Chang <tientzu@chromium.org>, Konrad Rzeszutek Wilk <konrad@darnok.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
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

On Tue, Jul 27, 2021 at 02:54:14PM +0200, Christian Borntraeger wrote:
> 
> On 24.07.21 02:27, Konrad Rzeszutek Wilk wrote:
> > On Sat, Jul 24, 2021 at 01:17:46AM +0200, Halil Pasic wrote:
> > > Since commit 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for
> > > swiotlb data bouncing") if code sets swiotlb_force it needs to do so
> > > before the swiotlb is initialised. Otherwise
> > > io_tlb_default_mem->force_bounce will not get set to true, and devices
> > > that use (the default) swiotlb will not bounce despite switolb_force
> > > having the value of SWIOTLB_FORCE.
> > > 
> > > Let us restore swiotlb functionality for PV by fulfilling this new
> > > requirement.
> > > 
> > > This change addresses what turned out to be a fragility in
> > > commit 64e1f0c531d1 ("s390/mm: force swiotlb for protected
> > > virtualization"), which ain't exactly broken in its original context,
> > > but could give us some more headache if people backport the broken
> > > change and forget this fix.
> > > 
> > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > > Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > > Fixes: 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing")
> > > Fixes: 64e1f0c531d1 ("s390/mm: force swiotlb for protected virtualization")
> > > Cc: stable@vger.kernel.org #5.3+
> > > 
> > > ---
> > 
> > Picked it up and stuck it in linux-next with the other set of patches (Will's fixes).
> 
> Can you push out to kernel.org?

It's pushed to the swiotlb tree:

https://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git/log/?h=devel/for-linus-5.15

Since none of the restricted DMA series is in mainline yet, I don't think
it's needed anywhere else.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
