Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1935CC2D0C1
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 14:45:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B2F21655
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 14:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zbSeAtQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B2F21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B24BF86E65;
	Thu, 19 Dec 2019 14:45:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a11uQxVycElw; Thu, 19 Dec 2019 14:45:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4D31E86E56;
	Thu, 19 Dec 2019 14:45:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39A9BC1AE8;
	Thu, 19 Dec 2019 14:45:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7D79C077D
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 14:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A738D86E56
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 14:45:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U6gpFlm3vdI9 for <iommu@lists.linuxfoundation.org>;
 Thu, 19 Dec 2019 14:45:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3CF0E86E41
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 14:45:01 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8CA5B2053B;
 Thu, 19 Dec 2019 14:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576766701;
 bh=vAaulfw1pF77O08ApVOdriNy2OT8rG3mQpywJSyfN4s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zbSeAtQhWyT+0vUu5L4MnKkNI7dV1law3SZgt+khmgC/2FgFiEjBGgv8sk9KSRXoy
 h/tbaj4fG3hnf1MNHYwjeLNW/RfP9hIuVxIaVpiGSrIWipV3gx/cB15yZdA3cCzJcU
 Ipcgpu1lc5HK9h6Y6Grly6oI7eow1PF6MCQRn8Xg=
Date: Thu, 19 Dec 2019 15:44:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 00/16] iommu: Permit modular builds of ARM SMMU[v3]
 drivers
Message-ID: <20191219144458.GB1959534@kroah.com>
References: <20191219120352.382-1-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191219120352.382-1-will@kernel.org>
Cc: iommu@lists.linuxfoundation.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Saravana Kannan <saravanak@google.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>
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

On Thu, Dec 19, 2019 at 12:03:36PM +0000, Will Deacon wrote:
> Hi all,
> 
> This is version four of the patches I previously posted here:
> 
>   v1: https://lore.kernel.org/lkml/20191030145112.19738-1-will@kernel.org/
>   v2: https://lore.kernel.org/lkml/20191108151608.20932-1-will@kernel.org
>   v3: https://lore.kernel.org/lkml/20191121114918.2293-1-will@kernel.org
> 
> Changes since v3 include:
> 
>   * Based on v5.5-rc1
>   * ACPI/IORT support (thanks to Ard)
>   * Export pci_{enable,disable}_ats() (thanks to Greg)
>   * Added review tags
> 
> I tested this on AMD Seattle by loading arm-smmu-mod.ko from the initrd.

All look good to me!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
