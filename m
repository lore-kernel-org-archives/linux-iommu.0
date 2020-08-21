Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2C8C433DF
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 13:43:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D6B2075E
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 13:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D6B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D2344884EA;
	Fri, 21 Aug 2020 13:43:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nn+npWDWxyRS; Fri, 21 Aug 2020 13:43:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A0AC7884CE;
	Fri, 21 Aug 2020 13:43:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83E23C0889;
	Fri, 21 Aug 2020 13:43:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18830C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:43:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0662286CEF
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:43:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RAzdxHIRXoS9 for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:43:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 56A3C86CC5
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:43:04 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 342BFACB8;
 Fri, 21 Aug 2020 13:43:30 +0000 (UTC)
Date: Fri, 21 Aug 2020 15:43:00 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [Regression] "iommu/amd: Relax locking in dma_ops path" makes
 tg3 ethernet transmit queue timeout
Message-ID: <20200821134300.GM3354@suse.de>
References: <4E9B03FB-9DA5-4831-B4CE-A0AA645D3F22@canonical.com>
 <20200518133209.GM8135@suse.de>
 <381D21C9-C913-4C33-A6F4-0440B5D11670@canonical.com>
 <8D375E06-A763-4B5E-9C6D-DA5EBC62530E@canonical.com>
 <CFC22DE4-E342-4F32-B758-6A690755C498@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CFC22DE4-E342-4F32-B758-6A690755C498@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, open list <linux-kernel@vger.kernel.org>
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

Hi Kai,

On Mon, Jun 29, 2020 at 08:33:22PM +0800, Kai-Heng Feng wrote:
> I am still seeing the issue on v5.8-rc3. The issue goes away as soon
> as "iommu=off" is added.

Can you probably help with debugging this issue? I've had no luck so far
getting my hands on a machine with tg3 hardware and an AMD IOMMU.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
