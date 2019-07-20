Return-Path: <SRS0=zP7B=VR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C23C76186
	for <iommu@archiver.kernel.org>; Sat, 20 Jul 2019 21:47:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588812084D
	for <iommu@archiver.kernel.org>; Sat, 20 Jul 2019 21:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFdoactE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588812084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0F6D0F2E;
	Sat, 20 Jul 2019 21:47:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 37F7EEF3
	for <iommu@lists.linux-foundation.org>;
	Sat, 20 Jul 2019 21:47:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DACB389D
	for <iommu@lists.linux-foundation.org>;
	Sat, 20 Jul 2019 21:47:01 +0000 (UTC)
Received: from localhost (unknown [23.100.24.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 544FD20838;
	Sat, 20 Jul 2019 21:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563659221;
	bh=5ocWBOP9piRvE5hSaMGtsmQvQUd2aJdYEE0t3kJLhPo=;
	h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Cc:Subject:In-Reply-To:References:
	From;
	b=PFdoactEa1DnMZYpOxMqYhvYMl+R3Fv7MISC2NDI71S/QBpInu/3sLoV0hock00BT
	y3zviFwfHrQFko81WOVC33RUau36uNimZa93jxfQIMmdZF68q/DDvLbUJO4sDDcwFJ
	lQusLknbUctkfh4H+sAeLoG50Avu22zIdYh5RC98=
Date: Sat, 20 Jul 2019 21:47:00 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Chris Wilson <chris@chris-wilson.co.uk>
To: iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/iova: Remove stale cached32_node
In-Reply-To: <20190720180848.15192-1-chris@chris-wilson.co.uk>
References: <20190720180848.15192-1-chris@chris-wilson.co.uk>
Message-Id: <20190720214701.544FD20838@mail.kernel.org>
Cc: , Joerg Roedel <jroedel@suse.de>, intel-gfx@lists.freedesktop.org,
	stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: e60aa7b53845 iommu/iova: Extend rbtree node caching.

The bot has tested the following trees: v5.2.1, v5.1.18, v4.19.59.

v5.2.1: Build OK!
v5.1.18: Build OK!
v4.19.59: Failed to apply! Possible dependencies:
    bee60e94a1e2 ("iommu/iova: Optimise attempts to allocate iova from 32bit address range")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

--
Thanks,
Sasha
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
