Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEBEC433FE
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 21:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4775560B56;
	Thu, 28 Apr 2022 21:49:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4GDfuRyHRG2l; Thu, 28 Apr 2022 21:49:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0854D60AAE;
	Thu, 28 Apr 2022 21:49:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4DBEC0039;
	Thu, 28 Apr 2022 21:49:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 369AFC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 21:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E8B383EF0
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 21:49:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lnU7n6SbcgHB for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 21:49:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8DEDC83E57
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 21:49:14 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C0C6E61F8C;
 Thu, 28 Apr 2022 21:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A082EC385AD;
 Thu, 28 Apr 2022 21:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651182552;
 bh=N7ZQRSxaxRoMXrt1DERfRx93WB3JcFzn7TVVB0S9qmw=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=aNKDR2lwKqqTjZzHIfPg3iPMrs4H0KuqbdLlT/nvVSOTZ7MivpG44bUt6Czd5lkJU
 1rGVYKsyXEY+5EvR9fdWwk14DhvVPsqJ57IhUp7KLUL8p+1SYGiBwsMckVcQ6865FL
 VnJ3PKysn2MJwr3sURNXf1JCJc7Dt/yBD7oMjH0VncXglu7gWWixMJpgXZGaukPc/J
 aLvu6wiQI7SLTpiJNsBE68CHAJOMV/3bhZAIQmLyS1nvEWL2MsIxSaK8nuYPvwMFTR
 1AF7toPAqGQneikfdGm54reUsJLy4w0ZccgDiGAaTc/FtSjXMVsmlx9w3IhvcPxkt2
 +OkWezDq+J65Q==
Date: Thu, 28 Apr 2022 14:49:11 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] swiotlb-xen: fix DMA_ATTR_NO_KERNEL_MAPPING on arm
In-Reply-To: <20220428132737.GA13999@lst.de>
Message-ID: <alpine.DEB.2.22.394.2204281449060.915916@ubuntu-linux-20-04-desktop>
References: <20220423171422.1831676-1-hch@lst.de>
 <alpine.DEB.2.22.394.2204261605420.915916@ubuntu-linux-20-04-desktop>
 <20220428132737.GA13999@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: jgross@suse.com, Stefano Stabellini <sstabellini@kernel.org>,
 iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
 boris.ostrovsky@oracle.com, Rahul Singh <Rahul.Singh@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On Thu, 28 Apr 2022, Christoph Hellwig wrote:
> On Tue, Apr 26, 2022 at 04:07:45PM -0700, Stefano Stabellini wrote:
> > > Reported-by: Rahul Singh <Rahul.Singh@arm.com>
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> 
> Do you want to take this through the Xen tree or should I pick it up?
> Either way I'd love to see some testing on x86 as well.

I agree on the x86 testing. Juergen, Boris?

I'd say to take this patch via the Xen tree but Juergen has just sent a
Xen pull request to Linux last Saturday. Juergen do you plan to send
another one? Do you have something else lined up? If not, it might be
better to let Christoph pick it up.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
