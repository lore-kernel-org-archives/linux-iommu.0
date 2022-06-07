Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07202C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 08:10:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D5F5404F3;
	Tue,  7 Jun 2022 08:10:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8aHfrb8f39Bn; Tue,  7 Jun 2022 08:10:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5F849404B0;
	Tue,  7 Jun 2022 08:10:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D8AFC0039;
	Tue,  7 Jun 2022 08:10:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59214C002D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 08:10:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3324660BE1
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 08:10:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JB0I8iV5J3Vp for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 08:10:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8131C60B49
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 08:10:07 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id A73387F; Tue,  7 Jun 2022 10:10:04 +0200 (CEST)
Date: Tue, 7 Jun 2022 10:10:03 +0200
From: Joerg Roedel <joro@8bytes.org>
To: keliu <liuke94@huawei.com>
Subject: Re: [PATCH] drivers: iommu: Directly use ida_alloc()/free()
Message-ID: <Yp8H24w5pGxDj7vQ@8bytes.org>
References: <20220527070307.2359150-1-liuke94@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220527070307.2359150-1-liuke94@huawei.com>
Cc: iommu@lists.linux-foundation.org, will@kernel.org,
 linux-kernel@vger.kernel.org
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

On Fri, May 27, 2022 at 07:03:07AM +0000, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>

Please change the subject to: "iommu: Directly use ida_alloc()/free()"
to match the IOMMU tree conventions. Also include all acks and
reviewed-by tags when re-sending.

Thanks,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
