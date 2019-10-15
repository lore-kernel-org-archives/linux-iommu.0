Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A73ECE59E
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 21:36:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496A620873
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 21:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1u4ZjfYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496A620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 18AB9AB5;
	Tue, 15 Oct 2019 21:36:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E1AFA9E7
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 21:36:37 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A90376C5
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 21:36:37 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 1CB0D20854;
	Tue, 15 Oct 2019 21:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571175397;
	bh=aMw709beM1rE8T7vybZcuJLSLiqFPzJHotrEtAZ9suw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=1u4ZjfYyt3WgWzgBm8iqJwwNFm27RBd6GtDbCEvm1NexWbrPYkkyyIlQ/Kgj4LF8V
	kTRc6IUZyGmxMdyN332GwEFVn2nBCD1+SwnRwIAgf08rOuNMkDAzWpQSfdNXLO4aub
	cnMbsgaHG9rmVnqghp9hGuZAP72kWnarIRjXJc9g=
Date: Tue, 15 Oct 2019 16:36:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI/ATS: Clean up unnecessary stubs and exports
Message-ID: <20191015213635.GA177798@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191009225354.181018-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Krzysztof Wilczynski <kw@linux.com>, Ashok Raj <ashok.raj@intel.com>,
	linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
	iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On Wed, Oct 09, 2019 at 05:53:51PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Most of the ATS/PRI/PASID interfaces are only used by IOMMU drivers that
> can only be built statically, not as modules.  A couple are only used by
> the PCI core and don't need to be visible outside at all.
> 
> These are intended to be cleanup only, but let me know if they would break
> something.
> 
> Bjorn Helgaas (3):
>   PCI/ATS: Remove unused PRI and PASID stubs
>   PCI/ATS: Remove unnecessary EXPORT_SYMBOL_GPL()
>   PCI/ATS: Make pci_restore_pri_state(), pci_restore_pasid_state()
>     private
> 
>  drivers/pci/ats.c       | 14 --------------
>  drivers/pci/pci.h       |  4 ++++
>  include/linux/pci-ats.h | 15 ---------------
>  3 files changed, 4 insertions(+), 29 deletions(-)

I applied these to pci/virtualization for v5.5, with Kuppuswamy's
Reviewed-by on the first and Joerg's on all three.  Thank you both for
taking a look!

Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
