Return-Path: <SRS0=Vrxx=HH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518C1C433DB
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 08:45:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1DD064FBB
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 08:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DD064FBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 624118730C;
	Fri,  5 Feb 2021 08:45:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fc6LmXS69Xx4; Fri,  5 Feb 2021 08:45:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0D5D387305;
	Fri,  5 Feb 2021 08:45:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02608C0174;
	Fri,  5 Feb 2021 08:45:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B51A0C013A
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 08:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9A00F86E67
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 08:45:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YDgEf7OsTImn for <iommu@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 08:45:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 373E286E56
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 08:45:53 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 5561038F; Fri,  5 Feb 2021 09:45:51 +0100 (CET)
Date: Fri, 5 Feb 2021 09:45:49 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH v2 0/2] VMD MSI Remapping Bypass
Message-ID: <20210205084549.GD27686@8bytes.org>
References: <20210204190906.38515-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210204190906.38515-1-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Nirmal Patel <nirmal.patel@intel.com>, Will Deacon <will@kernel.org>,
 linux-pci@vger.kernel.org, Kapil Karkra <kapil.karkra@intel.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On Thu, Feb 04, 2021 at 12:09:04PM -0700, Jon Derrick wrote:
> Jon Derrick (2):
>   iommu/vt-d: Use Real PCI DMA device for IRTE
>   PCI: vmd: Disable MSI/X remapping when possible
> 
>  drivers/iommu/intel/irq_remapping.c |  3 +-
>  drivers/pci/controller/vmd.c        | 60 +++++++++++++++++++++++------
>  2 files changed, 50 insertions(+), 13 deletions(-)

This probably goes via Bjorn's tree, so

	Acked-by: Joerg Roedel <jroedel@suse.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
