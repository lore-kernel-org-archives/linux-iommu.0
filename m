Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2563DC433FE
	for <iommu@archiver.kernel.org>; Wed, 26 Jan 2022 21:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AAE2C40AB1;
	Wed, 26 Jan 2022 21:38:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t90gd5ikrOr8; Wed, 26 Jan 2022 21:38:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 08E5A40A63;
	Wed, 26 Jan 2022 21:38:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDE9EC0031;
	Wed, 26 Jan 2022 21:38:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79D33C002D
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 21:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5AD1584DE4
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 21:38:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="J5TRhWXL";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="JEka+zNZ"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WmaZhA9cO35e for <iommu@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 21:38:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B843B84DE3
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 21:38:08 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1643233085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f5fcoWwfmhzNvMjUp+pjH4hD1mIf2d1g2+i2SJzfS4Q=;
 b=J5TRhWXL23NuwdM3hRs+FPxtZmSYLsb36kLeKRr3FWAhvN9lr8SBhLOI+zjjcbnluOWX0J
 La6iQGteVfCwqPIhFSpnJiDFXFF3kAlFjpLmhduP3NkxTDN96Peda9Yc/TMTrVUQcsUiPx
 pj1x0gvkj0KnKpRGFUZy/EzknDDLUbr83/0d3NiXGM4AwgvolreuNsxm8u6AhZy0R3fc/3
 Mu+4iaWJIMSXp6nvn4F8GKRoGFcypVFJovKrtByV6iWptI2gDHd7YdWJCnl72d5j/ahW86
 vxC36v6EePrfe5vdTvwcIpFrclV1jgl3yyAIfSm2HIsCtdaFyOe+vFrsWYPExw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1643233085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f5fcoWwfmhzNvMjUp+pjH4hD1mIf2d1g2+i2SJzfS4Q=;
 b=JEka+zNZXXyLc6D1VvwfqDsXU24l1eYSpl3XbMvwJi7v+170sTD6Z+2Gh27xmdaOmydw/f
 E7/StC2ZRyAae9CA==
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v2 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <YfGGk7kWNc9q2YwV@otcwcpicx3.sc.intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-6-fenghua.yu@intel.com> <87ee4w6g1n.ffs@tglx>
 <87bl006fdb.ffs@tglx> <Ye8RmmKpJT8brmDE@otcwcpicx3.sc.intel.com>
 <878rv46eg3.ffs@tglx> <YfAUutQhqS6ejUFU@otcwcpicx3.sc.intel.com>
 <87k0em4lu9.ffs@tglx> <YfGGk7kWNc9q2YwV@otcwcpicx3.sc.intel.com>
Date: Wed, 26 Jan 2022 22:38:04 +0100
Message-ID: <8735la41qb.ffs@tglx>
MIME-Version: 1.0
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>
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

On Wed, Jan 26 2022 at 09:36, Fenghua Yu wrote:
> On Wed, Jan 26, 2022 at 03:23:42PM +0100, Thomas Gleixner wrote:
>> On Tue, Jan 25 2022 at 07:18, Fenghua Yu wrote:
>> While looking at ioasid_put() usage I tripped over the following UAF
>> issue:
>> 
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4817,8 +4817,10 @@ static int aux_domain_add_dev(struct dma
>>  	auxiliary_unlink_device(domain, dev);
>>  link_failed:
>>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>> -	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
>> +	if (list_empty(&domain->subdevices) && domain->default_pasid > 0) {
>>  		ioasid_put(domain->default_pasid);
>> +		domain->default_pasid = INVALID_IOASID;
>> +	}
>>  
>>  	return ret;
>>  }
>> @@ -4847,8 +4849,10 @@ static void aux_domain_remove_dev(struct
>>  
>>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>>  
>> -	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
>> +	if (list_empty(&domain->subdevices) && domain->default_pasid > 0) {
>>  		ioasid_put(domain->default_pasid);
>> +		domain->default_pasid = INVALID_IOASID;
>> +	}
>>  }
>>  
>>  static int prepare_domain_attach_device(struct iommu_domain *domain,
>
> The above patch fixes an existing issue. I will put it in a separate patch,
> right?

Correct.

> It cannot be applied cleanly to the upstream tree. Do you want me to base
> the above patch (and the whole patch set) to the upstream tree or a specific
> tip branch?

Against Linus tree please so that the bugfix applies.

> I will fold the following patch into patch #5. The patch #11 (the doc patch)
> also needs to remove one paragraph talking about refcount.
>
> So I will send the whole patch set with the following changes:
> 1. One new bug fix patch (the above patch)
> 2. Updated patch #5 (with the following patch folded)
> 3. Updated patch #11 (removing refcount description)

Looks good.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
