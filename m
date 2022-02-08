Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1E6C433EF
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 02:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2740B817C3;
	Tue,  8 Feb 2022 02:41:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mfQjErTRtKvl; Tue,  8 Feb 2022 02:41:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ECAA8815AC;
	Tue,  8 Feb 2022 02:41:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9552C0011;
	Tue,  8 Feb 2022 02:41:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43681C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 02:41:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 317AD400CF
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 02:41:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ko_l9PrLxAMZ for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 02:41:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A41E40012
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 02:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644288089; x=1675824089;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=clZCN2d5mdaipuHu+jawY18XiyXmctriiRxBVPXsw70=;
 b=fUSAfbPoP5kjbaJB/OngNGt4AkRK8w6/NbIfZ+HWnY7eveOmh0pzzMUg
 NBI1/QXKkS9480H+4aIpiDu1fF8qvLf8FlTTnKxAseXfFbBAnMh/8b+vR
 KN8WuYAeJxn3CE1cCu+ewdX+AtX06kPpoG9AXpUx92X8BW2VTipnsBM/N
 ylC2t4SBblV+YtsHZX6ANhGX+q9zJArnJNJvEsaHxXZSHh9R8kSyc6jt4
 H89ntspAPzCGIanPHW7RgyxSsmO7Ay8DL18Mfg9ZbaSZbqjLyMT0gPw/8
 DURqOgcaDX6zs1mPh5k6xZvWu2p7jrDwj7sY73fyHGZ3tNuErUIE9V0Xv A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="247693665"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="247693665"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 18:41:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="677965770"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 18:41:25 -0800
Message-ID: <d8e4a38a-a7e2-1915-0b95-ac4dadf5c3dc@linux.intel.com>
Date: Tue, 8 Feb 2022 10:40:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 02/11] mm: Change CONFIG option for mm->pasid field
Content-Language: en-US
To: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-3-fenghua.yu@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220207230254.3342514-3-fenghua.yu@intel.com>
Cc: iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
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

On 2/8/22 7:02 AM, Fenghua Yu wrote:
> This currently depends on CONFIG_IOMMU_SUPPORT. But it is only
> needed when CONFIG_IOMMU_SVA option is enabled.
> 
> Change the CONFIG guards around definition and initialization
> of mm->pasid field.
> 
> Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> v4:
> - Add "Reviewed-by: Thomas Gleixner <tglx@linutronix.de>" (Thomas).
> 
> v2:
> - Change condition to more accurate CONFIG_IOMMU_SVA (Jacob and Tony)
> 
>   include/linux/mm_types.h | 2 +-
>   kernel/fork.c            | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5140e5feb486..c5cbfd7915ad 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -631,7 +631,7 @@ struct mm_struct {
>   #endif
>   		struct work_struct async_put_work;
>   
> -#ifdef CONFIG_IOMMU_SUPPORT
> +#ifdef CONFIG_IOMMU_SVA
>   		u32 pasid;
>   #endif
>   	} __randomize_layout;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d75a528f7b21..6ee7551d3bd2 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1021,7 +1021,7 @@ static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
>   
>   static void mm_init_pasid(struct mm_struct *mm)
>   {
> -#ifdef CONFIG_IOMMU_SUPPORT
> +#ifdef CONFIG_IOMMU_SVA
>   	mm->pasid = INIT_PASID;
>   #endif
>   }

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
