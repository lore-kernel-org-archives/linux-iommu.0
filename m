Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81279C10F14
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 11:43:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB7C21848
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 11:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB7C21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 476C6CA6;
	Tue, 15 Oct 2019 11:43:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8B15BC7C
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 11:43:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F41596D6
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 11:43:50 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 5556F2D9; Tue, 15 Oct 2019 13:43:49 +0200 (CEST)
Date: Tue, 15 Oct 2019 13:43:48 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 0/3] PCI/ATS: Clean up unnecessary stubs and exports
Message-ID: <20191015114347.GK14518@8bytes.org>
References: <20191009225354.181018-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191009225354.181018-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Krzysztof Wilczynski <kw@linux.com>, Ashok Raj <ashok.raj@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Keith Busch <keith.busch@intel.com>, iommu@lists.linux-foundation.org,
	Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>
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

Hi Bjorn,

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

The series looks good to me, for the whole series:

Reviewed-by: Joerg Roedel <jroedel@suse.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
