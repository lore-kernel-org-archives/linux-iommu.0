Return-Path: <SRS0=jPbF=ND=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D48AC4338F
	for <iommu@archiver.kernel.org>; Thu, 12 Aug 2021 11:29:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69C36103E
	for <iommu@archiver.kernel.org>; Thu, 12 Aug 2021 11:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D69C36103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F4D16062A;
	Thu, 12 Aug 2021 11:29:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xItDO4MKLKui; Thu, 12 Aug 2021 11:29:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F2F4A605F1;
	Thu, 12 Aug 2021 11:29:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0AA1C001A;
	Thu, 12 Aug 2021 11:29:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 081E6C000E
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 11:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE9F8405CD
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 11:29:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="eGZ1Bd0r";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="QFI1pDJf"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QGeQtdjyCbYP for <iommu@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 11:29:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A209D40583
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 11:29:04 +0000 (UTC)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 63474221F9;
 Thu, 12 Aug 2021 11:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628767742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rR4RmHIu++uj6JeRB+a/EK/3folVsSLZ9Kkd4P169bc=;
 b=eGZ1Bd0rggmj6Qx943oj8hKeHogAVbZQjw83m5iNEnwLU+eMZjlgRSpSyzQFs71HY3I9CR
 JveherTIgVF2i9E41BQ5CzcULbeQn4chGKcpdWXM69oT/7hjRLo+/4Ekfw5sjBKPE3jFHg
 Zf7LDGiD/b0x9SKvwAomnvrR1q/y/+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628767742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rR4RmHIu++uj6JeRB+a/EK/3folVsSLZ9Kkd4P169bc=;
 b=QFI1pDJfo3aSR6UQFzJ6Oyu45ElTk61/Cq7AACEOAL0OVsvIiu6rq8BUX494YUwq51Apbc
 jabTS9fMDgGjpBBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 26C0213A1E;
 Thu, 12 Aug 2021 11:29:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id xneuB/4FFWFrNwAAGKfGzw
 (envelope-from <jroedel@suse.de>); Thu, 12 Aug 2021 11:29:02 +0000
Date: Thu, 12 Aug 2021 13:29:00 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Sven Peter <sven@svenpeter.dev>
Subject: Re: [iommu:apple/dart 3/3] drivers/iommu/apple-dart.c:730:17: error:
 initialization of 'size_t (*)(struct iommu_domain *, long unsigned int,
 size_t,  struct iommu_iotlb_gather *)' {aka 'long unsigned int (*)(struct
 iommu_domain *, long unsigned int,  long unsigned int,  struct iom...
Message-ID: <YRUF/JNi5tclQo6L@suse.de>
References: <202108100801.aYU4IXvh-lkp@intel.com>
 <0589c725-401b-482f-ba2b-0707c02ea40a@www.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0589c725-401b-482f-ba2b-0707c02ea40a@www.fastmail.com>
Cc: iommu@lists.linux-foundation.org, kbuild-all@lists.01.org,
 kernel test robot <lkp@intel.com>
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

Hi Sven,

On Tue, Aug 10, 2021 at 08:09:53AM +0200, Sven Peter wrote:
> This happens because apple/dart is missing the "Optimizing iommu_[map/unmap] performance"
> series which is already in the core branch [1].
> The same commit works fine in iommu/next since that branch merges both iommu/core and
> apple/dart.

Okay, thanks. I re-based the DART patches on-top of my core branch,
which contains the changes for iommu_[map/unmap] performance. I
generally don't like rebasing topic branches, but made an exception here
to not break bisectability.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
