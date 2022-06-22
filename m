Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA04BC433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 14:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32FBF41CBD;
	Wed, 22 Jun 2022 14:52:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 32FBF41CBD
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qasqf8a1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 65D2rc_FMyQo; Wed, 22 Jun 2022 14:52:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 53C5241B9E;
	Wed, 22 Jun 2022 14:52:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53C5241B9E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21F7EC0039;
	Wed, 22 Jun 2022 14:52:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D8E0C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3019D41CBD
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:52:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3019D41CBD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OWXGezW1-8N3 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 14:52:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B39C141B9E
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B39C141B9E
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 14:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655909566; x=1687445566;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=GdP+v9rWFJruBYGDlVuNU2He/W1X7NsvVGksa2exDM0=;
 b=Qasqf8a1gg+TLy1jP+hc1kGShLi/U57FUWkT1ITSIf/4zulAYpR0Gv3Q
 8Q5yRR1mTmvylg9qWpTTjJ78kmdujf7cbS2qcLvjZb6+gRaXDpANVdQoW
 ZLTyXekObl9xYomP3zy5Gw7p+Q5keTNNjTEeQDe2CfFmW3XymHJqDI1qM
 fVpwxTmOyiB20yOypeMP6NKLY/fbZ6Krvk+wdaHd63JBqJgMKB3itoxpN
 yGoIfuFvtM1GF+4zkYBqF4T3mku0Jcr1PvpRYIKTi9UBCJkZ9XHrXsAQa
 TkWuLCuibXLE5Y9vEzSFyvlnoL/yZK9xX4/WafAD9NIdb4ZK/0ILNdj/M w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="260866905"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; d="scan'208";a="260866905"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 07:52:29 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; d="scan'208";a="834148065"
Received: from xzhan99-mobl1.ccr.corp.intel.com (HELO [10.249.172.26])
 ([10.249.172.26])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 07:52:27 -0700
Message-ID: <96984350-3a04-812a-60f1-a09138014fac@linux.intel.com>
Date: Wed, 22 Jun 2022 22:52:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Content-Language: en-US
To: Steve Wahl <steve.wahl@hpe.com>, Joerg Roedel <jroedel@suse.de>,
 Kyung Min Park <kyung.min.park@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Kevin Tian <kevin.tian@intel.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>
References: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
 <20220615183650.32075-1-steve.wahl@hpe.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220615183650.32075-1-steve.wahl@hpe.com>
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

On 2022/6/16 02:36, Steve Wahl wrote:
> To support up to 64 sockets with 10 DMAR units each (640), make the
> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> set.
> 
> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> remapping doesn't support X2APIC mode x2apic disabled"; and the system
> fails to boot properly.
> 
> Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> ---
> 
> Note that we could not find a reason for connecting
> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> it seemed like the two would continue to match on earlier processors.
> There doesn't appear to be kernel code that assumes that the value of
> one is related to the other.
> 
> v2: Make this value a config option, rather than a fixed constant.  The default
> values should match previous configuration except in the MAXSMP case.  Keeping the
> value at a power of two was requested by Kevin Tian.
> 
> v3: Make the config option dependent upon DMAR_TABLE, as it is not used without this.
> 
>   drivers/iommu/intel/Kconfig | 7 +++++++
>   include/linux/dmar.h        | 6 +-----
>   2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index 39a06d245f12..07aaebcb581d 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -9,6 +9,13 @@ config DMAR_PERF
>   config DMAR_DEBUG
>   	bool
>   
> +config DMAR_UNITS_SUPPORTED
> +	int "Number of DMA Remapping Units supported"
> +	depends on DMAR_TABLE
> +	default 1024 if MAXSMP
> +	default 128  if X86_64
> +	default 64

With this patch applied, the IOMMU configuration looks like:

[*]   AMD IOMMU support
<M>     AMD IOMMU Version 2 driver
[*]     Enable AMD IOMMU internals in DebugFS
(1024) Number of DMA Remapping Units supported   <<<< NEW
[*]   Support for Intel IOMMU using DMA Remapping Devices
[*]     Export Intel IOMMU internals in Debugfs
[*]     Support for Shared Virtual Memory with Intel IOMMU
[*]     Enable Intel DMA Remapping Devices by default
[*]     Enable Intel IOMMU scalable mode by default
[*]   Support for Interrupt Remapping
[*]   OMAP IOMMU Support
[*]     Export OMAP IOMMU internals in DebugFS
[*]   Rockchip IOMMU Support

The NEW item looks confusing. It looks to be a generic configurable
value though it's actually Intel DMAR specific. Any thoughts?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
