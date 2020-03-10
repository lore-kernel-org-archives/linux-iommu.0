Return-Path: <SRS0=VQ5+=43=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03AEC18E5A
	for <iommu@archiver.kernel.org>; Tue, 10 Mar 2020 09:25:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6ACA2051A
	for <iommu@archiver.kernel.org>; Tue, 10 Mar 2020 09:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6ACA2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8E531883D2;
	Tue, 10 Mar 2020 09:25:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jbIXnelwkcAd; Tue, 10 Mar 2020 09:25:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E8FC68829A;
	Tue, 10 Mar 2020 09:25:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4F86C18D3;
	Tue, 10 Mar 2020 09:25:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F636C0177
 for <iommu@lists.linux-foundation.org>; Tue, 10 Mar 2020 09:25:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8BE8986C51
 for <iommu@lists.linux-foundation.org>; Tue, 10 Mar 2020 09:25:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VMu9X39bDfve for <iommu@lists.linux-foundation.org>;
 Tue, 10 Mar 2020 09:25:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D9E2A85EF3
 for <iommu@lists.linux-foundation.org>; Tue, 10 Mar 2020 09:25:09 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 99002AC84;
 Tue, 10 Mar 2020 09:25:07 +0000 (UTC)
Date: Tue, 10 Mar 2020 10:25:05 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [iommu:arm/omap 4/4]
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c:134:20: error: implicit
 declaration of function 'vmap'; did you mean 'bmap'?
Message-ID: <20200310092505.GD7028@suse.de>
References: <202003050833.Dk7aJf6k%lkp@intel.com>
 <CAJKOXPcXSJs=a1x3XWksHzJnS7pb+UesPeZ+_5J7_cyn3yUtBg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJKOXPcXSJs=a1x3XWksHzJnS7pb+UesPeZ+_5J7_cyn3yUtBg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, kbuild-all@lists.01.org,
 kbuild test robot <lkp@intel.com>, Heiko Stuebner <heiko@sntech.de>
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

On Thu, Mar 05, 2020 at 09:50:57AM +0100, Krzysztof Kozlowski wrote:
> +Cc Heiko,
> 
> This is already fixed in drm-misc here:
> https://patchwork.freedesktop.org/patch/347106/

Is it possible to carry this fix in the IOMMU tree?


Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
