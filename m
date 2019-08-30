Return-Path: <SRS0=ODk1=W2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D49C3A59B
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 16:20:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 742D32341B
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 16:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W17LJbvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742D32341B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2AD7660CD;
	Fri, 30 Aug 2019 16:20:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C862E62FC
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 16:18:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8FF8AEC
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 16:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I09fo0Z72elrZNTtFC7i1aCRoS4BvE/ve/oDk4fjlIs=;
	b=W17LJbvvnqhDwgrfqSVNFz6uW
	/ysTEHWWEgOWA/hTDj5uwUkmg1oJhx4y+Wrnp5+qkbj+prf+jbJtzOgNYNnGrJ2AmRzLxxXyoBUwY
	btk5HYQTEjvYtn2luICzXICZc9P/Y72hS78Yz3WDcN9b9uT1KZJKsZfGOyj8bJjd2WEcQKsfv5PxB
	QdNPQxoNNss2RWPBZAgsVVh5hKgixig2DztZFjQe+41EZBb3GLp/J717qOT9P+ksZV4wpSGxmMNIc
	idYGJjDaNNVe0nK8WnaMLAG0+a0pd3OCzES4/kiNv1s3a6Wx81ofNR81JyKO4o3nQrElzdVZ8tIY0
	NlOhydYNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
	Linux)) id 1i3jbk-0002ZI-QE; Fri, 30 Aug 2019 16:18:40 +0000
Date: Fri, 30 Aug 2019 09:18:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Krzysztof Wilczynski <kw@linux.com>
Subject: Re: [PATCH] PCI: Move ATS declarations to linux/pci.h
Message-ID: <20190830161840.GA9733@infradead.org>
References: <20190830150756.21305-1-kw@linux.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190830150756.21305-1-kw@linux.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
	Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Aug 30, 2019 at 05:07:56PM +0200, Krzysztof Wilczynski wrote:
> Move ATS function prototypes from include/linux/pci-ats.h to
> include/linux/pci.h so users only need to include <linux/pci.h>:

Why is that so important?  Very few PCI(e) device drivers use ATS,
so keeping it out of everyones include hell doesn't seem all bad.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
