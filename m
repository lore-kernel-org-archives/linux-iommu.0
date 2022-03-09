Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80ABC433F5
	for <iommu@archiver.kernel.org>; Wed,  9 Mar 2022 18:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83B59416B7;
	Wed,  9 Mar 2022 18:37:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ivheJuP7lCn; Wed,  9 Mar 2022 18:37:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8EE8C416EF;
	Wed,  9 Mar 2022 18:37:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6022DC001D;
	Wed,  9 Mar 2022 18:37:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 707A7C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 18:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 50D7B8432A
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 18:37:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1_txOXDOzONz for <iommu@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 18:37:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2017F84321
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 18:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646851026; x=1678387026;
 h=message-id:date:mime-version:to:references:from:subject:
 in-reply-to:content-transfer-encoding;
 bh=42SHLVdUmbF7Yr5x/SNRc33O12UExbadboJ1PcWDHxo=;
 b=FC4iCcUno3qtMeks06VbhLBQ4WfeV/+K7T0HYy4y/GZAloof7Ye+BB1E
 Xb+mbuu23X92GWJvH0OkdCotQwDidHHo0xJ/Ow7yPoufGfyl3o3vQn/cz
 oCzQf+zptjoQ3P8frTelZDJ9/L2QjIdiSjXf9ZRiiU+SniF3cMWdoyiA6
 N5dgjnDoHV3k0ow/TXiHoJyGkisOVqk76hBpte5VABDdDyCM9FUljzx3E
 gUe8DrxoQZy8+SczXzEAnMHLS08msomYpFxuv0nYSiqoIRhzWxv2OZ7jQ
 Yqp0XWpQJjLXnpNCZFhQIRw9M5EhqqDVztes0el4wmPVckJtG5mjsmABI w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="279791530"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; d="scan'208";a="279791530"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2022 10:37:05 -0800
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; d="scan'208";a="642257474"
Received: from sli6-mobl.amr.corp.intel.com (HELO [10.209.104.236])
 ([10.209.104.236])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2022 10:36:59 -0800
Message-ID: <42641969-c958-847c-4d6e-baa14d847545@intel.com>
Date: Wed, 9 Mar 2022 10:36:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, corbet@lwn.net, hpa@zytor.com, x86@kernel.org,
 dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
 tglx@linutronix.de, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 will@kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 "Raj, Ashok" <ashok.raj@intel.com>
References: <20220309175805.1298503-1-alexander.deucher@amd.com>
 <20220309175805.1298503-2-alexander.deucher@amd.com>
From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 2/2] Documentation: x86: Clarify Intel IOMMU documenation
In-Reply-To: <20220309175805.1298503-2-alexander.deucher@amd.com>
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

> -ACPI enumerates and lists the different DMA engines in the platform, and
> -device scope relationships between PCI devices and which DMA engine  controls
> +ACPI enumerates and lists the different IOMMUs in the platform, and
> +device scope relationships between PCI devices and which IOMMU controls
>  them.

Isn't this just a really long-winded way of saying:

	ACPI enumerates both the IOMMUs in the platform and which IOMMU
	controls a specific PCI device.

?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
