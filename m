Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BADC433EF
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 05:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2311D606FF;
	Fri,  6 May 2022 05:57:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oYNPsRBIsmeC; Fri,  6 May 2022 05:57:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F076E607AA;
	Fri,  6 May 2022 05:57:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8146C0032;
	Fri,  6 May 2022 05:57:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEC56C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB89241504
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id en7TCC_kUzpE for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 05:57:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A20E414C4
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651816627; x=1683352627;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OL2oJRFDVdmovflg5mLwCF3EJPwhcMaRX4sx8VlaeHk=;
 b=JENPw+MCqAoB16ni/NXha4c57VaGPa4dctPGntAaXcLqHalbjBhOrfyh
 S3AOOTNVVzaAkslPkDXsEusftL8JQiWyMvrkFy9HZTBNRhIwFzGhKTUpM
 ZvYsJzBS+k1DxryPtGndI24+nBdFZ09vkaKzQAIMKu7LilYEqkJExmlr+
 q7EUBZZQ6dQCe19KwTwVoGIa6Ym1EiBZ1IMuyzEXe/wKO8q8btZMbUMBC
 PRMCD4g6bOQcfr5kz5FAotm1S2wzmenG1ItX05dv5BdmOMmTOK6sj5NTP
 Bu80pClUgp+YfEb2kGbgsJBwmdeogrLXMD+2+HlvJqSx+gkZvPRlrzVjC g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248267846"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="248267846"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 22:57:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="735415841"
Received: from sunyanwa-mobl1.ccr.corp.intel.com (HELO [10.255.31.183])
 ([10.255.31.183])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 22:57:02 -0700
Message-ID: <e2afd89c-b1cf-9fde-4ce2-4be3c1fdaf07@linux.intel.com>
Date: Fri, 6 May 2022 13:57:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/vt-d: Increase DMAR_UNITS_SUPPORTED
Content-Language: en-US
To: Steve Wahl <steve.wahl@hpe.com>, Joerg Roedel <jroedel@suse.de>,
 Kyung Min Park <kyung.min.park@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, "Tian, Kevin" <kevin.tian@intel.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220505194658.246121-1-steve.wahl@hpe.com>
Cc: Mike Travis <mike.travis@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
 linux-kernel@vger.kernel.org, Russ Anderson <russ.anderson@hpe.com>
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

On 2022/5/6 03:46, Steve Wahl wrote:
> Increase DMAR_UNITS_SUPPORTED to support 64 sockets with 10 DMAR units
> each, for a total of 640.
> 
> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> remapping doesn't support X2APIC mode x2apic disabled"; and the system
> fails to boot.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> Reviewed-by: Mike Travis <mike.travis@hpe.com>
> ---
> 
> Note that we could not find a reason for connecting
> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> it seemed like the two would continue to match on earlier processors.
> There doesn't appear to be kernel code that assumes that the value of
> one is related to the other.

+Kevin

This maximum value was introduced by below commit. And I don't see any
hardware/software restrictions that we can't enlarge it after ten years.

commit 1b198bb04ad72669d4bd6575fc9945ed595bfee0
Author: Mike Travis <travis@sgi.com>
Date:   Mon Mar 5 15:05:16 2012 -0800

     x86/iommu/intel: Increase the number of iommus supported to 
MAX_IO_APICS

     The number of IOMMUs supported should be the same as the number
     of IO APICS.  This limit comes into play when the IOMMUs are
     identity mapped, thus the number of possible IOMMUs in the
     "static identity" (si) domain should be this same number.
[...]

> 
>   include/linux/dmar.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> index 45e903d84733..9d4867b8f42e 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -19,7 +19,7 @@
>   struct acpi_dmar_header;
>   
>   #ifdef	CONFIG_X86
> -# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
> +# define	DMAR_UNITS_SUPPORTED	640
>   #else
>   # define	DMAR_UNITS_SUPPORTED	64
>   #endif

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
