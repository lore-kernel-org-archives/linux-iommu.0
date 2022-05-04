Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C09C433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 08:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E76960E33;
	Wed,  4 May 2022 08:49:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VN24Uvrur1n8; Wed,  4 May 2022 08:49:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 210B160C2A;
	Wed,  4 May 2022 08:49:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFAFFC0039;
	Wed,  4 May 2022 08:49:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AD60C0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6828760D60
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:49:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3mibBUt5Qn3n for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 08:49:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6E2060C2A
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:49:39 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 5A61167B; Wed,  4 May 2022 10:49:37 +0200 (CEST)
Date: Wed, 4 May 2022 10:49:36 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: Re: [PATCH v2] iommu: fix an incorrect NULL check on list iterator
Message-ID: <YnI+IPP0VIftWwPA@8bytes.org>
References: <20220501132823.12714-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220501132823.12714-1-xiam0nd.tong@gmail.com>
Cc: will@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, agross@kernel.org, sricharan@codeaurora.org
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

On Sun, May 01, 2022 at 09:28:23PM +0800, Xiaomeng Tong wrote:
> The bug is here:
> 	if (!iommu || iommu->dev->of_node != spec->np) {
> 
> The list iterator value 'iommu' will *always* be set and non-NULL by
> list_for_each_entry(), so it is incorrect to assume that the iterator
> value will be NULL if the list is empty or no element is found (in fact,
> it will point to a invalid structure object containing HEAD).
> 
> To fix the bug, use a new value 'iter' as the list iterator, while use
> the old value 'iommu' as a dedicated variable to point to the found one,
> and remove the unneeded check for 'iommu->dev->of_node != spec->np'
> outside the loop.
> 
> Cc: stable@vger.kernel.org
> Fixes: f78ebca8ff3d6 ("iommu/msm: Add support for generic master bindings")
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
> changes since v1:
>  - add a new iter variable (suggested by Joerg Roedel)

This is now applied. I had to manually apply it because the patch was
malformed at line 36 and git-am complained.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
