Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DE2C10F0E
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D1B2171F
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQI9uJli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D1B2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 170E5DD9;
	Fri, 12 Apr 2019 15:30:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8AB38DD4
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 15:30:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3BC9687C
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 15:30:08 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555083008;
	bh=1tOsJ3H5oRJ+mSd5NRSdKnvjzqdv+pwa0IGk5X8RX6g=;
	h=From:In-Reply-To:References:Date:To:Cc:From;
	b=QQI9uJliauPicbBqWNXhTKggcITNgHvsRNJ6Bj+axe4hr7ezTLJtEXWiAltFc3qEL
	kgi640n2zR7ROcFf5sDr2dQwtJFdQOivu0jWSGHdBFs53JtmhislDwVl5SonQ9DnG9
	PMUSKORXf876eVA6xhrdGRy4Mknfj52JmAxYYa6U=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190412151901.GA14497@infradead.org>
References: <20190412151901.GA14497@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190412151901.GA14497@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
	tags/dma-mapping-5.1-1
X-PR-Tracked-Commit-Id: 8c5165430c0194df92369162d1c7f53f8672baa5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ee15f3248660f85102a47410079d408615723d4
Message-Id:
 <155508300802.31973.10103032526645452851.pr-tracker-bot@kernel.org>
Date: Fri, 12 Apr 2019 15:30:08 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux-foundation.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190412153008.NxfzTxQ0EjbrdueBxQ5MXypY6EZfVo8I3QzHaTlp_2I@z>

The pull request you sent on Fri, 12 Apr 2019 17:19:01 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ee15f3248660f85102a47410079d408615723d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
