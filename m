Return-Path: <SRS0=TfAO=UR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10F3C31E5B
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 15:25:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF0A2085A
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 15:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF0A2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3EF99C6E;
	Tue, 18 Jun 2019 15:25:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 434BDC4E
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 15:25:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B4A81893
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 15:25:20 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 188C34B5; Tue, 18 Jun 2019 17:25:19 +0200 (CEST)
Date: Tue, 18 Jun 2019 17:25:17 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] iommu: fix integer truncation
Message-ID: <20190618152517.GB21128@8bytes.org>
References: <20190617133101.2817807-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190617133101.2817807-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oza Pawandeep <poza@codeaurora.org>, Marc Zyngier <marc.zyngier@arm.com>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Julien Grall <julien.grall@arm.com>,
	Srinath Mannam <srinath.mannam@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
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

On Mon, Jun 17, 2019 at 03:30:54PM +0200, Arnd Bergmann wrote:
> On 32-bit architectures, phys_addr_t may be different from dma_add_t,
> both smaller and bigger. This can lead to an overflow during an assignment
> that clang warns about:
> 
> drivers/iommu/dma-iommu.c:230:10: error: implicit conversion from 'dma_addr_t' (aka 'unsigned long long') to
>       'phys_addr_t' (aka 'unsigned int') changes value from 18446744073709551615 to 4294967295 [-Werror,-Wconstant-conversion]
> 
> Use phys_addr_t here because that is the type that the variable was
> declared as.
> 
> Fixes: aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
