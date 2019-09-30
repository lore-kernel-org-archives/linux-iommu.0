Return-Path: <SRS0=JlXp=XZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA17AC388F3
	for <iommu@archiver.kernel.org>; Mon, 30 Sep 2019 18:36:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C576E224D7
	for <iommu@archiver.kernel.org>; Mon, 30 Sep 2019 18:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yzJe07xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C576E224D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D22AF1ABE;
	Mon, 30 Sep 2019 18:36:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 814621ADA
	for <iommu@lists.linux-foundation.org>;
	Mon, 30 Sep 2019 18:36:25 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3F4471FB
	for <iommu@lists.linux-foundation.org>;
	Mon, 30 Sep 2019 18:36:25 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
	[209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id EFAB6224F2
	for <iommu@lists.linux-foundation.org>;
	Mon, 30 Sep 2019 18:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569868585;
	bh=Ve9EmbsF4R2T7X2AuYWHttWGyO9wXFWxIJj8J5eaoDE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=yzJe07xvPb1X/lMsvcEm9s7vhsjgVOtzM9TWeZHjaB6SLT95m7stqvhjKv5aoL7rF
	Au6KFV0YzVNY/d8PPnLGj3ZffNV6bhGsyW4EAI74hjCyGKOggKvZZhxHwI07PtdV04
	xhw2ONm0tks6XUhVlyIWpOQbiYQE0ucMo3m+y1GI=
Received: by mail-qk1-f176.google.com with SMTP id z67so8686972qkb.12
	for <iommu@lists.linux-foundation.org>;
	Mon, 30 Sep 2019 11:36:24 -0700 (PDT)
X-Gm-Message-State: APjAAAULM3Iw8tXnwLlysCNDRp/eyEyiV9j9KRgqXsvOpTtrAFjphcHI
	G10AQKKlzueuq1rSSyrB0VNHY04C8DihxQ5DhQ==
X-Google-Smtp-Source: APXvYqy2xChitegAmEHzNRbHSSH0nQKcTnaviLTzqyZbMb41lnr9tCCoVkEfo/b9C0IczxPJCD2HaN7s56mcLD1ZT6M=
X-Received: by 2002:a05:620a:12d5:: with SMTP id
	e21mr1643941qkl.152.1569868584102; 
	Mon, 30 Sep 2019 11:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1569851517.git.robin.murphy@arm.com>
	<20e142e236decbed1b890ef455c5a1ddbdb48b9d.1569851517.git.robin.murphy@arm.com>
In-Reply-To: <20e142e236decbed1b890ef455c5a1ddbdb48b9d.1569851517.git.robin.murphy@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 30 Sep 2019 13:36:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL3P4MrisYO3394ONJrpBXafR1GFhZJJYKJQ6t28AQ4kw@mail.gmail.com>
Message-ID: <CAL_JsqL3P4MrisYO3394ONJrpBXafR1GFhZJJYKJQ6t28AQ4kw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iommu/io-pgtable-arm: Support all Mali
	configurations
To: Robin Murphy <robin.murphy@arm.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Neil Armstrong <narmstrong@baylibre.com>,
	Steven Price <steven.price@arm.com>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Will Deacon <will@kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
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

On Mon, Sep 30, 2019 at 9:11 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> In principle, Midgard GPUs supporting smaller VA sizes should only
> require 3-level pagetables, since level 0 only resolves bits 48:40 of
> the address. However, the kbase driver does not appear to have any
> notion of a variable start level, and empirically T720 and T820 rapidly
> blow up with translation faults unless given a full 4-level table,
> despite only supporting a 33-bit VA size.
>
> The 'real' IAS value is still valuable in terms of validating addresses
> on map/unmap, so tweak the allocator to allow smaller values while still
> forcing the resultant tables to the full 4 levels. As far as I can test,
> this should make all known Midgard variants happy.
>
> Fixes: d08d42de6432 ("iommu: io-pgtable: Add ARM Mali midgard MMU page table format")
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
