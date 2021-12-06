Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF22C433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 14:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D488B401A2;
	Mon,  6 Dec 2021 14:43:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0kUlD8s2vVN4; Mon,  6 Dec 2021 14:43:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CE83A4018C;
	Mon,  6 Dec 2021 14:43:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC84AC001E;
	Mon,  6 Dec 2021 14:43:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3624FC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 31DBC60C2D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:43:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6npuJb5684rH for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 14:43:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A6FFC605C2
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=/a5egbMTKnz+y2PkQ/A6YESbzjYfNwkN7J8oOXJTJpE=; b=un+kJXGRC5lJBrry7pJWW5Ep9W
 s48iuLXdisb2MdlUCWWECgs3n5gxcMRYbw3HbWU+YPNjksRvtYAf0mGW0RO7/eSkS5dEk0nd1Qayy
 ZChUFDtKAiB779/GwiqNlSTyxmxyT5rbz6PFkiWBriuU9rPQ8oqO36aW5JQhMHUR1NE6dCeEzXjbd
 k30bCN5vDwXECDKRiMy1bfaJPMdSedQxfNDVDvkwrO/XU2d+6XdKp0TcrXJl3JUnTleHPMKV+cSVV
 OAQVEWqdn388ngnZSsgBXoHcc0kdZ/IiaL4ELbCM8mVCBs4SqIc5kFxccbclRJvowc7hyUomlpIR6
 IWkUCYqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1muFDH-004GOU-NG; Mon, 06 Dec 2021 14:43:31 +0000
Date: Mon, 6 Dec 2021 06:43:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 12/18] iommu: Add iommu_at[de]tach_device_shared() for
 multi-device groups
Message-ID: <Ya4hk91RWnPWB4nE@infradead.org>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
 <20211206015903.88687-13-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211206015903.88687-13-baolu.lu@linux.intel.com>
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

The new helpers really could use a kerneldoc comment.
Also no need for the refcount_t with it's atomic operations for
attach_cnt either.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
