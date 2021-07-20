Return-Path: <SRS0=9TsP=MM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2C2C07E95
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 08:49:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DBAE6120D
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 08:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBAE6120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6964E402EA;
	Tue, 20 Jul 2021 08:49:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bnLCzbAhUWmx; Tue, 20 Jul 2021 08:49:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ECA3340241;
	Tue, 20 Jul 2021 08:49:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE9E5C001A;
	Tue, 20 Jul 2021 08:49:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05A46C000E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 08:49:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD2296082F
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 08:49:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6UQh8vmQNXah for <iommu@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 08:49:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 667F96065D
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 08:49:18 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BFD261209;
 Tue, 20 Jul 2021 08:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626770957;
 bh=E4QrzgjbXqoC6VoGREB4ON7zH4nlyit8ndwfY+7siow=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k123DOUQxQ4obwuzQkIdMIG6t+Ua5MrHYjUv2KgMPb+7zK0H134oz62TGEEG/ng2E
 w+mYHKIlzb3tL/+E38PfoCMzkRyaWjHajmr0NzTqFAGqR4kOMpXZohvV0poCKhl+DJ
 +Nm1t7ToczHqqUJWYZJaHK9MZcWOoJfZ4PKsJQuqCj0VBSWBczqY2ErqUeXEEmxCSB
 mZUZY6rvQgOx3WRCGqezMlmskiwhVHHqZgVg44wQkYaYf7GLa/sXfx9ZmIQO1Pe966
 Qywv+/sRIfrLBpqV/aYxPZfdOx31mHZa9uoyHTXU0nd/aIQAYsXgQwKJbqKvrVy1Jh
 Qj5u79A1/sZ6Q==
Date: Tue, 20 Jul 2021 09:49:12 +0100
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] swiotlb: Point io_default_tlb_mem at static allocation
Message-ID: <20210720084912.GB8089@willie-the-truck>
References: <20210719123054.6844-1-will@kernel.org>
 <20210719123054.6844-3-will@kernel.org>
 <20210720075112.GB17565@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210720075112.GB17565@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 iommu@lists.linux-foundation.org, Claire Chang <tientzu@chromium.org>,
 Robin Murphy <robin.murphy@arm.com>, Guenter Roeck <linux@roeck-us.net>
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

On Tue, Jul 20, 2021 at 09:51:12AM +0200, Christoph Hellwig wrote:
> I'd prefer if the next patch is merged into this one, to avoid the
> confusing state inbetween entirely.

Of course. For some reason, I half thought this patch would need to go to
stable, but the restricted DMA stuff didn't land so there's no backporting
to worry about.

I'll merge 'em for v2.

Thanks for having a look!

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
