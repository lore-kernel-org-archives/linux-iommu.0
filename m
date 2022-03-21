Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B22C433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 10:48:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3793A82AB6;
	Mon, 21 Mar 2022 10:48:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PxQBZCeolRH4; Mon, 21 Mar 2022 10:48:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2ACCA82A29;
	Mon, 21 Mar 2022 10:48:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BA55C0012;
	Mon, 21 Mar 2022 10:48:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A30EC000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4926B40186
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:48:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iBfpc6WLBYpR for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 10:48:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD03F4017F
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647859685; x=1679395685;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IQ9KPzVkz3G/2nXFWvcX9d+QrLPKKuVLsDfgQyXtQvw=;
 b=DgY/Rpm55D8IkN5jc/7+V+lOguait5dyAC9pvwBjdQOxTTP73eDlHFXN
 AnGOjiZ8FwuXUHYA4MlcI5KFBTO8fmof/m/MXQDn5TTSDf5DOFLVxFFY2
 pzUW7/qHLBey4sNe+2wy2JdkhGIJEmzE03ruCCoGMv/yjxKgzrsLQFBq+
 DPx6UuQA4xvNXOK8CYotZv+Lik/+CK5k0Xyr4ILYjctDon6tx48jOBaeA
 S9DRjZN64Rhy9Sh/me+EN8/L22TRLRooz2cDJEAGRB5NUMueLjGdoJlm2
 ihRGFQdv9iam6wvOi5+3WC7U1+FJLeb3bNkYVptJM6LN35ex/HCdMDUPW g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="320725796"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; d="scan'208";a="320725796"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 03:48:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; d="scan'208";a="559814338"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 03:47:59 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 21 Mar 2022 12:45:40 +0200
Date: Mon, 21 Mar 2022 12:45:40 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4 1/2] PCI: Rename "pci_dev->untrusted" to
 "pci_dev->poses_dma_risk"
Message-ID: <YjhXVFr4JqKI93Ae@lahna>
References: <20220320062907.3272903-1-rajatja@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220320062907.3272903-1-rajatja@google.com>
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

On Sat, Mar 19, 2022 at 11:29:05PM -0700, Rajat Jain wrote:
> Rename the field to make it more clear, that the device can execute DMA
> attacks on the system, and thus the system may need protection from
> such attacks from this device.
> 
> No functional change intended.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
