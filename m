Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4865CC433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 10:43:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5AD861294;
	Wed, 22 Jun 2022 10:43:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5AD861294
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=effxifTe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cWy8U7hfc28s; Wed, 22 Jun 2022 10:43:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 81D0061178;
	Wed, 22 Jun 2022 10:43:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81D0061178
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3624FC0039;
	Wed, 22 Jun 2022 10:43:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BF7AC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 10:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C872241A20
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 10:43:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C872241A20
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=effxifTe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tDIW3i_tQXSW for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 10:43:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AACBF419F6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AACBF419F6
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 10:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=d9qh4ClogxgC0O6hF1eUSJPidsyvY/LbjmD7UJqICRw=; b=effxifTebkgcG6rotJpwJVDCEb
 zxQ0vXZ8GXZVYpoyvSB61V6hix18oqpmTo90l9csCV6ATv+Pk5ieUQHdhOIdf47JOA0//38Gf5qcN
 +jWUcehjbts8XSqtewFPNB1gT0HkHI07OrEc0IyqY8pa7JCbLaghfQtJ1HaGGalSBsAtgdwVgpDZa
 cZJxQ0Kn7Ahhmy4ugrHuqxjX16mwkf6uZry8P3xVjNa4AsfUfsOURPtZCwuC/P1t81bzrtsN4q+VU
 qC6NxfSLsSchTAyeOWpPZAJVDP4jvPMxwpqA28hLJF0jL/Omn3EzS0NFAeOsvMgfSRH0Bdn9obc/n
 r50sqR7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1o3xpj-009yMX-Ac; Wed, 22 Jun 2022 10:43:39 +0000
Date: Wed, 22 Jun 2022 03:43:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH v1 0/4] swiotlb: some cleanup
Message-ID: <YrLyWzL48no3a6cS@infradead.org>
References: <20220611082514.37112-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220611082514.37112-1-dongli.zhang@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: corbet@lwn.net, dave.hansen@linux.intel.com, linux-doc@vger.kernel.org,
 x86@kernel.org, joe.jin@oracle.com, linux-kernel@vger.kernel.org,
 hch@infradead.org, iommu@lists.linux-foundation.org, mingo@redhat.com,
 bp@alien8.de, tglx@linutronix.de
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

Thanks,

I've applied all 4 to the dma-mapping tree for Linux 5.20.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
