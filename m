Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BC1C433EF
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 10:50:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53D108142F;
	Mon, 21 Mar 2022 10:50:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C8vaVQdO-Ymq; Mon, 21 Mar 2022 10:50:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B927181450;
	Mon, 21 Mar 2022 10:50:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98286C0012;
	Mon, 21 Mar 2022 10:50:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F5CBC000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4C9F660E99
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:50:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iJlTHMy5rzCE for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 10:50:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8FC3860EAE
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647859807; x=1679395807;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fliE/T1LCX93MwQ1Bnv434Gg30/vCZwgY+6LB+3NqUM=;
 b=OmOIqgkKyPKpvmsn/nxnyvb05rPRQm5X4fv2awmnhpqKCh0F1j/FU9Eo
 lxwKKmC+rI8kOoTkCvmOM2qIdf/f+wiO+boMy9F9Q9IH4Zsr9+V941+4j
 Jj2HEr8lz0iSqdxAkKCUgmB7/B5xLoUcszJWFVMSNkn2iAQwZ/vx26oSm
 Ihm+0c41m425eoXojyowNmFWG24MaM8l4ySG4b+csv/MaYHkg0gIwrOAc
 YEhU9aa4IOMM+Gk83AKVfWjg0SpXYYvIjIZGJ6GSy1HuTY0iq3e4PuEh7
 1tQamR+Qg8Cc18j0UQ+nCPbQUcghvufC6lfzX8kWGb1c2XaRuDq33hBiS A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="238126238"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; d="scan'208";a="238126238"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 03:50:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; d="scan'208";a="500128970"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 03:50:00 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 21 Mar 2022 12:48:48 +0200
Date: Mon, 21 Mar 2022 12:48:48 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4 2/2] PCI: ACPI: Support Microsoft's "DmaProperty"
Message-ID: <YjhYEN/ajM71wMn0@lahna>
References: <20220320062907.3272903-1-rajatja@google.com>
 <20220320062907.3272903-2-rajatja@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220320062907.3272903-2-rajatja@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rajat Jain <rajatxjain@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Pavel Machek <pavel@denx.de>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Oliver O'Halloran <oohall@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Will Deacon <will@kernel.org>,
 Jesse Barnes <jsbarnes@google.com>, Dmitry Torokhov <dtor@google.com>,
 Len Brown <lenb@kernel.org>
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

On Sat, Mar 19, 2022 at 11:29:06PM -0700, Rajat Jain wrote:
> The "DmaProperty" is supported and documented by Microsoft here:
> https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
> They use this property for DMA protection:
> https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
> 
> Support the "DmaProperty" with the same semantics. This is useful for
> internal PCI devices that do not hang off a PCIe rootport, but offer
> an attack surface for DMA attacks (e.g. internal network devices).
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
