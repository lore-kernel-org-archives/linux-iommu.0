Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43195C433FE
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 10:08:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D271340936;
	Tue,  4 Jan 2022 10:08:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id igQRZku5Iy8J; Tue,  4 Jan 2022 10:08:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E269E4095D;
	Tue,  4 Jan 2022 10:08:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9957C002F;
	Tue,  4 Jan 2022 10:08:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE08FC001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 10:08:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC0C260B90
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 10:08:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XiWZE-uww8TJ for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 10:08:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4442E60B0E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 10:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=He5mJNAVZLGt4B/chvWVA3LBDjigRGtLMa8gtm4wt1s=; b=kL9GzvPou7/2vKXI6TOUjGt7r2
 yfHoQNz8RPyUWqoN9VuZzi+nGb3HWfbLRi/KqJ/sIHDW4e+EFZAnjpdq2ZfDS59ER5zFPhW5HWnfg
 GlQXCKK3V19atr5Yph3p9ocCcAgr0zeiZz2apkrTQcIZdmZXSHU7kCLiOUyZ+7JBAeB8TZYvm456G
 sykxbq6H3ZgrRJtLW2pznfce55bAeSWCgFFBGObwKngmIpI7n4V8RexngUhSsALnef7R4tqupZZs1
 clVk3boIxQdRryu58jMBXFWOr/dQabXvQh6zpW5oRFlR55oUTwq+36CIGmdXxrGmrQXpRK+YjbeVx
 STve0/HA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1n4gk8-00B68W-6b; Tue, 04 Jan 2022 10:08:36 +0000
Date: Tue, 4 Jan 2022 02:08:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 02/14] driver core: Add dma_cleanup callback in bus_type
Message-ID: <YdQcpHrV7NwUv+qc@infradead.org>
References: <20220104015644.2294354-1-baolu.lu@linux.intel.com>
 <20220104015644.2294354-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220104015644.2294354-3-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

All these bus callouts still looks horrible and just create tons of
boilerplate code.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
