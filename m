Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B48AC433F5
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 06:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 299B641B95;
	Wed, 25 May 2022 06:26:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NpfEUHlXl6_h; Wed, 25 May 2022 06:26:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C7B8A410C9;
	Wed, 25 May 2022 06:26:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B8F9C0039;
	Wed, 25 May 2022 06:26:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 008CAC002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 06:26:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E12C0408F3
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 06:26:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NawtneRW88JF for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 06:26:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4AE6C40198
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 06:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653460002; x=1684996002;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=lbi++CXcaekGLCTBDHq57kBFex4czpZ+/tgqoBHU1dU=;
 b=LOXMuG+Gx8x7J8nv52VrS9z72EXRR3T+7vxHBz32MprbCtwi8iQ8z0Ou
 B73ByZ+AHcvfAmSev+n/8+UAztB8yzFGJskxx+R4dzYC1ibXpb4OVnysT
 AP5yNW2EFcrCpw3szKZ32cwg/XK/D31dXfCLbEfrKDxQ241xYVi2Rsjfw
 Y1MicZRM2bjzKJ/TEQewVGXaqcYT47DsJWFsaehqAL0LceT+NsqtXZiVB
 3r8GfmCRG7napTYcDjs91V62HCnwzp/vNt5XOPbYNwPLkXk3Y0/ydwzRg
 LDNatSuJ1EglCsUKi3Z+zavLWrOQt1EE414j2xlPjtdXYeQz8IY5yPWW0 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="253603714"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="253603714"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 23:26:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="601683714"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139])
 ([10.255.29.139])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 23:26:38 -0700
Message-ID: <63369db0-cf7f-aa53-bf9f-de2b0b2289ac@linux.intel.com>
Date: Wed, 25 May 2022 14:26:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] iommu: Add Visconti5 IOMMU driver
Content-Language: en-US
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
References: <20220525013147.2215355-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20220525013147.2215355-2-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220525013147.2215355-2-nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, yuji2.ishikawa@toshiba.co.jp,
 linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/5/25 09:31, Nobuhiro Iwamatsu wrote:
> +static const struct iommu_ops visconti_atu_ops = {
> +	.domain_alloc = visconti_atu_domain_alloc,
> +	.probe_device = visconti_atu_probe_device,
> +	.release_device = visconti_atu_release_device,
> +	.device_group = generic_device_group,
> +	.of_xlate = visconti_atu_of_xlate,
> +	.pgsize_bitmap = ATU_IOMMU_PGSIZE_BITMAP,
> +	.default_domain_ops = &(const struct iommu_domain_ops) {
> +		.attach_dev = visconti_atu_attach_device,
> +		.detach_dev = visconti_atu_detach_device,

The detach_dev callback is about to be deprecated. The new drivers
should implement the default domain and blocking domain instead.

> +		.map = visconti_atu_map,
> +		.unmap = visconti_atu_unmap,
> +		.iova_to_phys = visconti_atu_iova_to_phys,
> +		.free = visconti_atu_domain_free,
> +	}
> +};

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
