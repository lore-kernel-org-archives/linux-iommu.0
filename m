Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D10C433EF
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 02:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 598254055E;
	Fri, 13 May 2022 02:09:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tne9UdTmnOVd; Fri, 13 May 2022 02:09:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 15D21404FF;
	Fri, 13 May 2022 02:09:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D38A2C007B;
	Fri, 13 May 2022 02:09:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8113CC002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 02:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6975583054
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 02:09:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oaWw7Ytsuhb3 for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 02:09:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 08D218302F
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 02:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652407793; x=1683943793;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=z65torRcig/enwY4e/08U9dWxV9t8BfziP29ghWb42o=;
 b=eTifv0R8TZVkCdm3pzuixp2kZU2MeAkgfAyK5QSA4oF19Sy+fTPdMWh7
 rJUPqRDCuSY6QmjEl28r+gRGLxsLL+88Sv+YKegi3tBIdpxMRz+PYq975
 l6wJ+DE37J86dFY2GmunvdDQ7vV0i1wAly9bAqGsU8F4Mk6KkdrFDVhD4
 RMc++uXyFo6Y3RCIaGozCtrX0v3rJ/Cb+qhFwwU7G8b5f13lyhQKu2a0i
 UKDtuz2QCKbbt/MIdzhb+S+HnmVrCtqXvvaH3jyaNDQqzpX/KHpzy9ooF
 UQBn5mBo9pOlurfv+FF18HQ9H6zdK6WhbluOGoercIMwh67pUCXQhRSlo g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="269861277"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; d="scan'208";a="269861277"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2022 19:09:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; d="scan'208";a="739965747"
Received: from liujing-mobl.ccr.corp.intel.com (HELO [10.249.175.174])
 ([10.249.175.174])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2022 19:09:48 -0700
Message-ID: <2c65b8cf-3813-3ddf-3f5b-c374cc842678@linux.intel.com>
Date: Fri, 13 May 2022 10:09:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Content-Language: en-US
To: Steve Wahl <steve.wahl@hpe.com>, Joerg Roedel <jroedel@suse.de>,
 David Woodhouse <dwmw2@infradead.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
 <Yn2UYst0ETp42uzq@swahl-home.5wahls.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yn2UYst0ETp42uzq@swahl-home.5wahls.com>
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

On 2022/5/13 07:12, Steve Wahl wrote:
> On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
>> To support up to 64 sockets with 10 DMAR units each (640), make the
>> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
>> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
>> set.
>>
>> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
>> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
>> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
>> remapping doesn't support X2APIC mode x2apic disabled"; and the system
>> fails to boot properly.
>>
>> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> 
> I've received a report from the kernel test robot <lkp@intel.com>,
> that this patch causes an error (shown below) when
> CONFIG_IOMMU_SUPPORT is not set.
> 
> In my opinion, this is because include/linux/dmar.h and
> include/linux/intel-iommu are being #included when they are not really
> being used.
> 
> I've tried placing the contents of intel-iommu.h within an #ifdef
> CONFIG_INTEL_IOMMU, and that fixes the problem.
> 
> Two questions:
> 
> A) Is this the desired approach to to the fix?

Most part of include/linux/intel-iommu.h is private to Intel IOMMU
driver. They should be put in a header like drivers/iommu/intel
/iommu.h. Eventually, we should remove include/linux/intel-iommu.h
and device drivers interact with iommu subsystem through the IOMMU
kAPIs.

Best regards,
baolu

> 
> B) Should it be a separate patch, or added onto this patch as a v3?
> 
> Error message:  ------------------------------
> 
>     In file included from include/linux/intel-iommu.h:21,
>                      from arch/x86/kvm/x86.c:44:
>>> include/linux/dmar.h:21:33: error: 'CONFIG_DMAR_UNITS_SUPPORTED' undeclared here (not in a function); did you mean 'DMAR_UNITS_SUPPORTED'?
>        21 | #define DMAR_UNITS_SUPPORTED    CONFIG_DMAR_UNITS_SUPPORTED
>           |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/intel-iommu.h:531:35: note: in expansion of macro 'DMAR_UNITS_SUPPORTED'
>       531 |         unsigned int iommu_refcnt[DMAR_UNITS_SUPPORTED];
>           |                                   ^~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +21 include/linux/dmar.h
> 
>      20
>    > 21  #define DMAR_UNITS_SUPPORTED    CONFIG_DMAR_UNITS_SUPPORTED
>      22
> 
> Initial stab at fixing it: ------------------------------
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 2f9891cb3d00..916fd7b5bcb5 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -10,6 +10,8 @@
>   #ifndef _INTEL_IOMMU_H_
>   #define _INTEL_IOMMU_H_
>   
> +#ifdef CONFIG_INTEL_IOMMU
> +
>   #include <linux/types.h>
>   #include <linux/iova.h>
>   #include <linux/io.h>
> @@ -831,4 +833,6 @@ static inline const char *decode_prq_descriptor(char *str, size_t size,
>   	return str;
>   }
>   
> +#endif /* CONFIG_IOMMU_SUPPORT */
> +
>   #endif
> 
> 
> Thanks.
> 
> --> Steve Wahl
> 
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
