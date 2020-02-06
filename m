Return-Path: <SRS0=jQQH=32=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DC9C2D0B1
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 07:32:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C211120720
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 07:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k0QW1zod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C211120720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 929C685D3D;
	Thu,  6 Feb 2020 07:32:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TyP3k2PB5SUf; Thu,  6 Feb 2020 07:32:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6E65785CFE;
	Thu,  6 Feb 2020 07:32:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53105C1D81;
	Thu,  6 Feb 2020 07:32:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54152C013E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 07:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3CA1684C99
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 07:32:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OCIe-ru2WaQi for <iommu@lists.linux-foundation.org>;
 Thu,  6 Feb 2020 07:32:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BD82081B81
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 07:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=wKS2dna2ZWLnRfXzTY1qmCv1+KkdOP5HPIrpAL96RDk=; b=k0QW1zoda1V1au22RMPPgv+A1W
 XiXP3A+av1NH05g4Bq8JGruOkyr1WwEOY9zScW+CRzD8kznSWq3XEJDfXA1ieutabQCYuNDvBgLHd
 seIAfGZcaYXIrJXDPNPzQGEH+yevCf4pc1woyje1FETptiMuNpoMH+GbWpTT4apmkK4i9U9+cAdaG
 qiMjoKwVVMtV/egiAsLx44Iyem1m9l5se+eofCKUX3QL8j4uQ8B293n2xYqTxx58QfpZAVSeNgiai
 Y7ROgakzy5WsEOXoEPbNahn6EI4YtefEhGwcYJbWDSw+q0Wj6JOaDwmrmn9JUrUvEie5pGY0mhuHl
 RnDhPRXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1izbe9-0007N1-KC; Thu, 06 Feb 2020 07:32:21 +0000
Date: Wed, 5 Feb 2020 23:32:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jian-Hong Pan <jian-hong@endlessm.com>
Subject: Re: [PATCH] iommu/intel-iommu: set as DUMMY_DEVICE_DOMAIN_INFO if no
 IOMMU
Message-ID: <20200206073221.GA27797@infradead.org>
References: <20200203091009.196658-1-jian-hong@endlessm.com>
 <aab0948d-c6a3-baa1-7343-f18c936d662d@linux.intel.com>
 <CAPpJ_edkkWm0DYHB3U8nQPv=z_o-aV4V7RDMuLTXL5N1H6ZYrA@mail.gmail.com>
 <948da337-128f-22ae-7b2e-730b4b8da446@linux.intel.com>
 <CAPpJ_ecM0oCUjYLbG+uTprRk0=OTUBTxZc-d2BGBRDSYWk4uSQ@mail.gmail.com>
 <CAPpJ_efn0jwHf8rWjBm0=BwrFd=z7MATWkNsqNfHuyrn4wAt+w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPpJ_efn0jwHf8rWjBm0=BwrFd=z7MATWkNsqNfHuyrn4wAt+w@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 Linux Upstreaming Team <linux@endlessm.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>
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

On Thu, Feb 06, 2020 at 03:25:48PM +0800, Jian-Hong Pan wrote:
> Here is the original issue: There are more and more laptops equipped
> with Intel Rapid Storage Technology (RST) feature.  That makes the
> NVMe SSD hidden and as the cache.  However, there is no built in
> driver for it.  So, Daniel prepares a driver called intel-nvme-remap
> [1] to remap and show up the hidden NVMe SSD and make it as a normal
> SSD.  The driver is developed and refers to
> drivers/pci/controller/vmd.c.
> 
> Recently, we get a laptop with Intel RST feature enabled in BIOS and
> two NVMe SSDs after the RAID bus controller.  So, those two NVMe SSDs
> are hidden by Intel RST.  Then, intel-nvme-remap is going to remap and
> show up the NVMe SSDs.  But it hits two issues:

So you are using a driver that has been rejeced because it and the
Intel magic it tries to work around are completely broken, and then
complain it doesn't work?  There is no reason to hack up the intel-iommu
to work around your broken patched kernel then.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
