Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284E2C43217
	for <iommu@archiver.kernel.org>; Mon, 24 Jan 2022 20:21:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCA1060F16;
	Mon, 24 Jan 2022 20:21:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cK45-OIe9nRT; Mon, 24 Jan 2022 20:21:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A704960EED;
	Mon, 24 Jan 2022 20:21:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B273C0039;
	Mon, 24 Jan 2022 20:21:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B05E6C002F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 20:21:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A1C541723
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 20:21:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="R1P7/uDq";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="hzlU/SjN"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L0qWcxa9O4qZ for <iommu@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 20:21:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE87B415A2
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 20:21:28 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1643055685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5FTeBFVoufuU7ZebHlDAFZY8PMUgfTQm18f5SfOHL8s=;
 b=R1P7/uDqxqfBfk6N4xEy69WETfs1Jhu/2hRwCYOe8xPmYjIrg8SFqoZzucC0OcvPxGC7gE
 5o4eT4spbf9a2ZqK7eh9QlzJNBKyf+ZApSxLDIzy/x5B94QW+Qz6zpqCKEdWp1IUDVNkXi
 GYfV8E0MbwnGXMV3FJvetYWqtILk1ViWaKaz/QYbxXSq9U0fH7KpHObVTFwMWrGkAqCu/N
 cl5gbESO88l9KqBeU+mOEeqASkjarlsDg43xmRuM8k87sqN3ZMUO/r1AZ7D/O7XYWNZ+yq
 JSjH0RaYGsijeqNc8VmEpNnMPIpsZBmy23yo4XiUmbLqWnyg2sefiMDe1hbZ4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1643055685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5FTeBFVoufuU7ZebHlDAFZY8PMUgfTQm18f5SfOHL8s=;
 b=hzlU/SjNn/fwwC/H/KRPQL79VdGm9mE7ZHkHxDA4MC0SLgFIgF2pfhSDFoTcrjigCCscSE
 EYTOdPC2MJzUZHAw==
To: Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Ashok
 Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v2 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <20211217220136.2762116-6-fenghua.yu@intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-6-fenghua.yu@intel.com>
Date: Mon, 24 Jan 2022 21:21:24 +0100
Message-ID: <87ee4w6g1n.ffs@tglx>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
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

On Fri, Dec 17 2021 at 22:01, Fenghua Yu wrote:
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index bd41405d34e9..ee2294e02716 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -18,8 +18,7 @@ static DECLARE_IOASID_SET(iommu_sva_pasid);
>   *
>   * Try to allocate a PASID for this mm, or take a reference to the existing one
>   * provided it fits within the [@min, @max] range. On success the PASID is
> - * available in mm->pasid, and must be released with iommu_sva_free_pasid().
> - * @min must be greater than 0, because 0 indicates an unused mm->pasid.
> + * available in mm->pasid and will be available for the lifetime of the mm.
>   *
>   * Returns 0 on success and < 0 on error.
>   */
> @@ -33,38 +32,24 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>  		return -EINVAL;
>  
>  	mutex_lock(&iommu_sva_lock);
> -	if (mm->pasid) {
> -		if (mm->pasid >= min && mm->pasid <= max)
> -			ioasid_get(mm->pasid);
> -		else
> +	/* Is a PASID already associated with this mm? */
> +	if (pasid_valid(mm->pasid)) {
> +		if (mm->pasid < min || mm->pasid >= max)
>  			ret = -EOVERFLOW;
> -	} else {
> -		pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> -		if (pasid == INVALID_IOASID)
> -			ret = -ENOMEM;
> -		else
> -			mm->pasid = pasid;
> +		goto out;
>  	}
> +
> +	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> +	if (!pasid_valid(pasid))
> +		ret = -ENOMEM;
> +	else
> +		mm_pasid_get(mm, pasid);

Hrm. This is odd.

> +/* Associate a PASID with an mm_struct: */
> +static inline void mm_pasid_get(struct mm_struct *mm, u32 pasid)
> +{
> +	mm->pasid = pasid;
> +}

This does not get anything. It sets the allocated PASID in the mm. The
refcount on the PASID was already taken by the allocation. So this
should be mm_pasid_set() or mm_pasid_install(), right?

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
