Return-Path: <SRS0=5lac=W6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CACC3A5A5
	for <iommu@archiver.kernel.org>; Tue,  3 Sep 2019 06:54:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F47217D7
	for <iommu@archiver.kernel.org>; Tue,  3 Sep 2019 06:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NckRZ4e1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F47217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2481FCA6;
	Tue,  3 Sep 2019 06:54:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 706F6C91;
	Tue,  3 Sep 2019 06:54:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 252D7887;
	Tue,  3 Sep 2019 06:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=T+PF9nI/UzswEFIMDskT8tvvKXEkHyUFFsZIV3W9dq4=;
	b=NckRZ4e1JnfYIjs6wsInfvUGS
	4fwfAQLoC4cCGwbGbVj9yFOF5MHFfTl392qKh9kB2l0RLPCmNVK1+fhXWNMajto2/IalTJSl7Vn0z
	9mCVwRuZ2eS2+6MsSwN1+17ZQ9V4LZI4zgzrX1CL0cn0WZhujA2r6V27/7+LuaG1Ddsho5LGVIhqL
	AU5CpoReMG3TjoYQNWNELQjLDTUegQ0z887aUeUr/TLPwZ8AkMyFAqreJX8B9n8QKkkNwpwo2hgil
	hsx957IysdYrxsnRMxoltaK7PrsUV18dniBryxIIJMdmSbpSbet0Frhn7JmUE7qi2FkC/z4Tsl4U8
	dxxjaey9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
	Linux)) id 1i52iA-0000tZ-LK; Tue, 03 Sep 2019 06:54:42 +0000
Date: Mon, 2 Sep 2019 23:54:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 5/5] iommu: virt: Use iommu_put_resv_regions_simple()
Message-ID: <20190903065442.GB28322@infradead.org>
References: <20190829111752.17513-1-thierry.reding@gmail.com>
	<20190829111752.17513-6-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190829111752.17513-6-thierry.reding@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
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

I think the subject should say virtio instead of virt.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
