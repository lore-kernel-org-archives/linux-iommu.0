Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA53C433F5
	for <iommu@archiver.kernel.org>; Tue, 29 Mar 2022 15:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FB0160E6A;
	Tue, 29 Mar 2022 15:24:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6u-Cl-e1eNXF; Tue, 29 Mar 2022 15:24:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5B5CB605E8;
	Tue, 29 Mar 2022 15:24:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B7EEC002C;
	Tue, 29 Mar 2022 15:24:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6828EC0012
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 15:24:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55EDC8176A
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 15:24:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ojhZnA-c5hcP for <iommu@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 15:24:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9A6A81762
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648567471; x=1680103471;
 h=message-id:date:mime-version:to:references:from:subject:
 in-reply-to:content-transfer-encoding;
 bh=EXfw2h4ApJqsKLt0jwN7JfP5ypNKmGZfOtuabYM0CYw=;
 b=TOUhQ3B958jMAsvgCQ1pYN+eFE0E3jWlLDc6jwW4K6fCb+3rqX+IQ0iD
 7xoLR3HWhgUyKeCQoFjmJnU+SkkXpdygJuQUN3RKwVDO+/+d3qtAchI+C
 K0UM4t47gWf4qkkW3jF3eBVZRfR5pw7IFCIwpmnSxRZkaCDbMFe2AP6y3
 dxp4mkqatdU0pQwErDvrk9MiYlowmIH0YGoi1JrhEujTf+eChvW86Q5SW
 uXBdha7/8tlbwfTMjhAcN8VuZ6kfKKE1/Pg/Hb0vz5tCI1e+WaeC8XPMC
 U5b2CtnjnOAzGw835Xlkmgq2gl54XF8+pzosxi3D76Ivd4fAkCggdWnZf A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="284175880"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; d="scan'208";a="284175880"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2022 08:24:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; d="scan'208";a="604840564"
Received: from acstuden-mobl.amr.corp.intel.com (HELO [10.209.45.17])
 ([10.209.45.17])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2022 08:24:30 -0700
Message-ID: <b3998af9-24bc-6191-a8ed-de747e895799@intel.com>
Date: Tue, 29 Mar 2022 08:24:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, corbet@lwn.net, hpa@zytor.com, x86@kernel.org,
 dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
 tglx@linutronix.de, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 will@kernel.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 vasant.hegde@amd.com
References: <20220328172829.718235-1-alexander.deucher@amd.com>
 <20220328172829.718235-2-alexander.deucher@amd.com>
From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V3 1/2] Documentation: x86: Add documentation for AMD IOMMU
In-Reply-To: <20220328172829.718235-2-alexander.deucher@amd.com>
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

On 3/28/22 10:28, Alex Deucher wrote:
> +How is IOVA generated?
> +----------------------
> +
> +Well behaved drivers call dma_map_*() calls before sending command to device
> +that needs to perform DMA. Once DMA is completed and mapping is no longer
> +required, driver performs dma_unmap_*() calls to unmap the region.
> +
> +Fault reporting
> +---------------
> +
> +When errors are reported, the IOMMU signals via an interrupt. The fault
> +reason and device that caused it is printed on the console.

Just scanning this, it looks *awfully* generic.  Is anything in here
AMD-specific?  Should this be in an AMD-specific file?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
