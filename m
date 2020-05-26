Return-Path: <SRS0=1lY2=7I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E26BC433E0
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 14:47:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 357CB2075F
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 14:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iFU/FK7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357CB2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EF4A9861AF;
	Tue, 26 May 2020 14:47:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id stVcA8G5Fr-B; Tue, 26 May 2020 14:47:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B4B20861B2;
	Tue, 26 May 2020 14:47:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9ADF1C0888;
	Tue, 26 May 2020 14:47:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE7D0C016F
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 14:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B991187C69
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 14:47:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U+CnxnjigXTa for <iommu@lists.linux-foundation.org>;
 Tue, 26 May 2020 14:47:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 44E2F87B21
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 14:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0Lm8kIZucM9N101SLlLcwGvyzcwDFh9rh0/kpGAsWR8=; b=iFU/FK7WgcwuU1nzH+IvLCDEOD
 YW7VLT4NCbBO4cOYoghFHPWsHEwrpF4u0zer832+q3IxpnxJl8WDMI88a5n0shvG+FnLOoglo6l7m
 nBwOdx29rjE2SXhYw9An4k+rTcd3zEWAbd4T3H/2czviIm9e1FgwaCa4ecfsOuFylZmMf66QNPWs+
 6mzmPJOUafuLVb3g45f1LeBEz6HRq9V37zOT3LER8/BKQPtI/WSburZIopEnE2UKazsrtlu2QzVH1
 Pd3yDpx5Z4HpRq6oYD/qL7uamCmt81uIRkA46myiz5qRqe1u7cgEMkkmlUNal1fWdOAApqtTrftfn
 UyN0pNcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jdaqq-0005YE-Ty; Tue, 26 May 2020 14:46:44 +0000
Date: Tue, 26 May 2020 07:46:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 1/2] PCI: Introduce PCI_FIXUP_IOMMU
Message-ID: <20200526144644.GA20784@infradead.org>
References: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
 <1590493749-13823-2-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1590493749-13823-2-git-send-email-zhangfei.gao@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, linux-crypto@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 kenneth-lee-2012@foxmail.com, linux-arm-kernel@lists.infradead.org,
 Len Brown <lenb@kernel.org>
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

On Tue, May 26, 2020 at 07:49:08PM +0800, Zhangfei Gao wrote:
> Some platform devices appear as PCI but are actually on the AMBA bus,
> and they need fixup in drivers/pci/quirks.c handling iommu_fwnode.
> Here introducing PCI_FIXUP_IOMMU, which is called after iommu_fwnode
> is allocated, instead of reusing PCI_FIXUP_FINAL since it will slow
> down iommu probing as all devices in fixup final list will be
> reprocessed.

Who is going to use this?  I don't see a single user in the series.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
