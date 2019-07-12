Return-Path: <SRS0=rccM=VJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343ACC742C2
	for <iommu@archiver.kernel.org>; Fri, 12 Jul 2019 14:18:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1145421019
	for <iommu@archiver.kernel.org>; Fri, 12 Jul 2019 14:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1145421019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 97F7D5959;
	Fri, 12 Jul 2019 14:18:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 97CC0590E
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Jul 2019 14:08:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 149FD894
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Jul 2019 14:08:15 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id DF601227A81; Fri, 12 Jul 2019 16:08:12 +0200 (CEST)
Date: Fri, 12 Jul 2019 16:08:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86
	arch code
Message-ID: <20190712140812.GA29628@lst.de>
References: <20190712053631.9814-1-bauerman@linux.ibm.com>
	<20190712053631.9814-4-bauerman@linux.ibm.com>
	<20190712150912.3097215e.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190712150912.3097215e.pasic@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-s390@vger.kernel.org, Mike Anderson <andmike@linux.ibm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
	Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Jul 12, 2019 at 03:09:12PM +0200, Halil Pasic wrote:
> This is the implementation for the guys that don't
> have ARCH_HAS_MEM_ENCRYPT.
> 
> Means sev_active() may not be used in such code after this
> patch. What about 
> 
> static inline bool force_dma_unencrypted(void)
> {
>         return sev_active();
> }
> 
> in kernel/dma/direct.c?

FYI, I have this pending in the dma-mapping tree:

http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/e67a5ed1f86f4370991c601f2fcad9ebf9e1eebb
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
