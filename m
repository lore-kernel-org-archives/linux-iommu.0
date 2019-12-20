Return-Path: <SRS0=Sm7F=2K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FA0C2D0D4
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 08:43:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4812E2467F
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 08:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4812E2467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 06D20886B9;
	Fri, 20 Dec 2019 08:43:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YVkcIhj4QHZv; Fri, 20 Dec 2019 08:43:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 52CA6880C7;
	Fri, 20 Dec 2019 08:43:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AFDDC18DC;
	Fri, 20 Dec 2019 08:43:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E5EAC077D
 for <iommu@lists.linuxfoundation.org>; Fri, 20 Dec 2019 08:43:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0EB562277A
 for <iommu@lists.linuxfoundation.org>; Fri, 20 Dec 2019 08:43:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C6NuU6JPMguH for <iommu@lists.linuxfoundation.org>;
 Fri, 20 Dec 2019 08:43:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 79A3D2039C
 for <iommu@lists.linuxfoundation.org>; Fri, 20 Dec 2019 08:43:11 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 97A4B46B; Fri, 20 Dec 2019 09:43:08 +0100 (CET)
Date: Fri, 20 Dec 2019 09:43:03 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 03/16] PCI/ATS: Restore EXPORT_SYMBOL_GPL() for
 pci_{enable,disable}_ats()
Message-ID: <20191220084303.GA9347@8bytes.org>
References: <20191219120352.382-1-will@kernel.org>
 <20191219120352.382-4-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191219120352.382-4-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linuxfoundation.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>,
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

Hi Bjorn,

On Thu, Dec 19, 2019 at 12:03:39PM +0000, Will Deacon wrote:
> From: Greg Kroah-Hartman <gregkh@google.com>
> 
> Commit d355bb209783 ("PCI/ATS: Remove unnecessary EXPORT_SYMBOL_GPL()")
> unexported a bunch of symbols from the PCI core since the only external
> users were non-modular IOMMU drivers. Although most of those symbols
> can remain private for now, 'pci_{enable,disable_ats()' is required for
> the ARM SMMUv3 driver to build as a module, otherwise we get a build
> failure as follows:
> 
>   | ERROR: "pci_enable_ats" [drivers/iommu/arm-smmu-v3.ko] undefined!
>   | ERROR: "pci_disable_ats" [drivers/iommu/arm-smmu-v3.ko] undefined!
> 
> Re-export these two functions so that the ARM SMMUv3 driver can be build
> as a module.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@google.com>
> [will: rewrote commit message]
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/pci/ats.c | 2 ++
>  1 file changed, 2 insertions(+)

Are you fine with this change? I would apply this series to my tree
then.

Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
