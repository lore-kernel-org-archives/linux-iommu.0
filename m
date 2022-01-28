Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E8FC433EF
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 02:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00F0941608;
	Fri, 28 Jan 2022 02:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s-c8B5W6_Gv5; Fri, 28 Jan 2022 02:42:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B3670415FD;
	Fri, 28 Jan 2022 02:42:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9391CC0011;
	Fri, 28 Jan 2022 02:42:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A9C1C000B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 02:42:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 214D684E67
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 02:42:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DvajObwLiRXD for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 02:42:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A77684E62
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 02:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643337726; x=1674873726;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qJGD54+z4s9uimUk4jVCMGmOmDNCKMZ5udJCxiNXpGY=;
 b=E9z1ka3gHVU9M5OoRnrT5suKnqkxFfaGVWm3DxXK60g8VWsuQt4zD2te
 7+OTNBnYPKWQCUsORG4MleotogsZz8b/tjeTZBAkecTuW4LidRlT/q05u
 ElQv9RK2s1T7N2nxKEyxVs2sqITJv9h6/565zRizK4euRJ0kKx6L6mqoN
 TfvV8nfJYxoH7AJhl6HKThfrFAQGjgxDkLjJoyr3ivCdYeW9MkiEANnXw
 9FBd1RFCGxWPbdxVi+XTLfKhszpSy7F752jT9CamqpOXuYe/gVLAu1SwS
 R7wPDESVc6rfrzV5edxmFsC6Ligk+DcekCI7YOpmGSmV5Gxc8Kxed5JeR g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227697341"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; d="scan'208";a="227697341"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2022 18:42:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; d="scan'208";a="769962897"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2022 18:42:05 -0800
Date: Thu, 27 Jan 2022 18:42:00 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YfNVBzN67rSu/QcE@otcwcpicx3.sc.intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-6-fenghua.yu@intel.com>
 <87ee4w6g1n.ffs@tglx> <87bl006fdb.ffs@tglx>
 <Ye8RmmKpJT8brmDE@otcwcpicx3.sc.intel.com> <878rv46eg3.ffs@tglx>
 <YfAUutQhqS6ejUFU@otcwcpicx3.sc.intel.com> <87k0em4lu9.ffs@tglx>
 <YfGGk7kWNc9q2YwV@otcwcpicx3.sc.intel.com> <8735la41qb.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8735la41qb.ffs@tglx>
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

Hi, Thomas,

On Wed, Jan 26, 2022 at 10:38:04PM +0100, Thomas Gleixner wrote:
> On Wed, Jan 26 2022 at 09:36, Fenghua Yu wrote:
> > On Wed, Jan 26, 2022 at 03:23:42PM +0100, Thomas Gleixner wrote:
> >> On Tue, Jan 25 2022 at 07:18, Fenghua Yu wrote:
> >> While looking at ioasid_put() usage I tripped over the following UAF
> >> issue:
> >> 
> >> --- a/drivers/iommu/intel/iommu.c
> >> +++ b/drivers/iommu/intel/iommu.c
> >> @@ -4817,8 +4817,10 @@ static int aux_domain_add_dev(struct dma
> >>  	auxiliary_unlink_device(domain, dev);
> >>  link_failed:
> >>  	spin_unlock_irqrestore(&device_domain_lock, flags);
> >> -	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
> >> +	if (list_empty(&domain->subdevices) && domain->default_pasid > 0) {
> >>  		ioasid_put(domain->default_pasid);
> >> +		domain->default_pasid = INVALID_IOASID;
> >> +	}
> >>  
> >>  	return ret;
> >>  }
> >> @@ -4847,8 +4849,10 @@ static void aux_domain_remove_dev(struct
> >>  
> >>  	spin_unlock_irqrestore(&device_domain_lock, flags);
> >>  
> >> -	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
> >> +	if (list_empty(&domain->subdevices) && domain->default_pasid > 0) {
> >>  		ioasid_put(domain->default_pasid);
> >> +		domain->default_pasid = INVALID_IOASID;
> >> +	}
> >>  }
> >>  
> >>  static int prepare_domain_attach_device(struct iommu_domain *domain,
> >
> > The above patch fixes an existing issue. I will put it in a separate patch,
> > right?
> 
> Correct.
> 
> > It cannot be applied cleanly to the upstream tree. Do you want me to base
> > the above patch (and the whole patch set) to the upstream tree or a specific
> > tip branch?
> 
> Against Linus tree please so that the bugfix applies.
> 
> > I will fold the following patch into patch #5. The patch #11 (the doc patch)
> > also needs to remove one paragraph talking about refcount.
> >
> > So I will send the whole patch set with the following changes:
> > 1. One new bug fix patch (the above patch)

When I study your above aux_domain bug fix path, I find more aux_domain bugs.
But then I find aux_domain will be completely removed because all aux_domain
related callbacks are not called and are dead code (no wonder there are
so many bugs in aux_domain). Please see this series: https://lore.kernel.org/linux-iommu/20220124071103.2097118-4-baolu.lu@linux.intel.com/
For the series, Baolu confirms that he is "pretty sure that should be part
of v5.18". And I don't find the series calls any IOASID function after
removing the aux_domain code.

So that means we don't need to fix those issues in the dead aux_domain
code any more because it will be completely removed in 5.18, right?

If you agree, I will not include the aux_domain fix patch or any other
aux_domain fix patches in the up-coming v3. Is that OK?

> > 2. Updated patch #5 (with the following patch folded)

I will still change ioasid_put() in the aux_domain callbacks to ioasid_free()
in patch #5. So compilation will pass. Baolu's series will remove
the entire aux_domain code in 5.18.

> > 3. Updated patch #11 (removing refcount description)
> 
> Looks good.
> 

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
