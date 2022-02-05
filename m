Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2454C433EF
	for <iommu@archiver.kernel.org>; Sat,  5 Feb 2022 03:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82D5B82FB1;
	Sat,  5 Feb 2022 03:51:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZafiatjGmLJE; Sat,  5 Feb 2022 03:51:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6BB7783046;
	Sat,  5 Feb 2022 03:51:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44AF9C0011;
	Sat,  5 Feb 2022 03:51:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CAA1C000B
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 03:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA8C560B5A
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 03:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SWwnBD5ApEW0 for <iommu@lists.linux-foundation.org>;
 Sat,  5 Feb 2022 03:51:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CABA060B1E
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 03:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644033067; x=1675569067;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TJ0yFP3NTl42q8F9fgT2ctU0dtnIA2YCDkI5HuQPmm4=;
 b=IxiAornG99x4afPjEpdhglGHU71UnX7fBzuqvDNgbp2DAEEbWTW79Dcr
 4O09cvLmN6BDtx+lJ1ZmFXeEfMzVUYQ0AN3q/+FBwLAX9PE1kBIkyeIde
 +3zCR3TO8XkU9d6x2xMSfxH8Fr9izuUSadouA7q6VtqzLETXSN6Ei1CZv
 T68iR9IBYFHPctGsemuVutgd48G5eE1KzcEmj51uNwJaD0Y7On+JBocXT
 rYbc1UpmEb9AHQzcTbeRt1v7prWYcGmdIftGBMcgElApIwCezPT4faU16
 ZP9B1LJ3LzBJOMsVvahq/x5+FiUmqM/i8edJGjAZCnYuQeoMRwzhEZdpG g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="246073719"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; d="scan'208";a="246073719"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2022 19:51:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; d="scan'208";a="699886297"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.148])
 ([10.254.215.148])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2022 19:51:02 -0800
Message-ID: <6ace7131-4671-6956-944f-df01e5d63470@linux.intel.com>
Date: Sat, 5 Feb 2022 11:50:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-6-fenghua.yu@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220128202905.2274672-6-fenghua.yu@intel.com>
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

Hi Fenghua,

On 2022/1/29 4:28, Fenghua Yu wrote:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 92fea3fbbb11..ef03b2176bbd 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4781,7 +4781,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>   link_failed:
>   	spin_unlock_irqrestore(&device_domain_lock, flags);
>   	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
> -		ioasid_put(domain->default_pasid);
> +		ioasid_free(domain->default_pasid);
>   
>   	return ret;
>   }
> @@ -4811,7 +4811,7 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
>   	spin_unlock_irqrestore(&device_domain_lock, flags);
>   
>   	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
> -		ioasid_put(domain->default_pasid);
> +		ioasid_free(domain->default_pasid);
>   }
>   
>   static int prepare_domain_attach_device(struct iommu_domain *domain,

The domain->default_pasid is not relevant to SVA and it's being cleaned
up by another series. No need to take care of it in this series.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
