Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0B5ECE58E
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 10:04:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D582089C
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 10:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p8gST8Pm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D582089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 916DDAF0;
	Tue, 15 Oct 2019 10:04:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 52B7C89B
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 10:04:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 02E3314D
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 10:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KeSiQTLT5+yUYgIlTjDJIYnfdPX9XyC/fQqAdAFrXwA=;
	b=p8gST8Pmdk8tN5w1R3L7qghN0
	wvgF183kCQmYV1dcdqLrMf0q+n25gOlLCWOJJX4Icj4VB/IXiGYE4/acROOU0l6Axq85KfjPoVKos
	D1lMywlCB/rrSFvteE5GmN/0tm7LPO/jc9Mm1e3FJYm8xhBtV+bn1TswBFJQGE+flh/fLJo5GccyW
	jM4j2hGgiRtbyzpgWl8+XdqJbp2diK/jRAhGmBTvmxh8kyDu+W1Od/73ux0av5o42qUwQxGo4VgoY
	pDIUBPQlCz/VO+5sIuBwGqUhdtHq+xVmzjWw3FCG3P6seqzLgX2WmNHAZ+AGgz/Uflww0PCYeoUUw
	tbckxSJWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
	Hat Linux)) id 1iKJgs-0003gF-EB; Tue, 15 Oct 2019 10:04:30 +0000
Date: Tue, 15 Oct 2019 03:04:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH RFC 2/5] ARM: introduce arm_dma_direct
Message-ID: <20191015100430.GA13893@infradead.org>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
	<20191014183108.24804-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191014183108.24804-3-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: mbrugger@suse.com, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	iommu@lists.linux-foundation.org, f.fainelli@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-rpi-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
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

I think we just need to byte the bullet and move over arm to dma-direct
entirely.  This needs a careful audit of what differs, but the biggest
item is that we need to ensure dmabounce keeps working (or is replaced
with swiotlb in a suitable way, but that might be a lot more work).
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
