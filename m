Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7E4C433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 14:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E1A083FF9;
	Fri, 29 Apr 2022 14:35:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Km4f7jbf7Gyc; Fri, 29 Apr 2022 14:35:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1CA1583FF8;
	Fri, 29 Apr 2022 14:35:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2D73C0039;
	Fri, 29 Apr 2022 14:35:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C613EC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3CC4416F3
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:35:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EgSt6EjNKrhb for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 14:35:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4CB0A416B6
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:35:03 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id q20so4747719wmq.1
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 07:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=MNfUquSBQXRdU8AFXuKgswA3BnrGyLe9et79dGaHCHo=;
 b=aCrclNQan4DsysNx5+Nj3TiV0fkI/4mECyTS4zEiZJ1dbrslZNfdTJXWueSAZWJnj9
 DwSOotBRoD0nJ/o2/tSmtSJ5R306TVL+nnpVT5ZaYo5fsHtkNVj8ZEHVmr176n4+JxPx
 SjomnHzojd/oFkir7xR7lTB3rXs3zZOZtmb3rziM8Pbx95QK36YxjUQC9D7AUyOGlfPJ
 6pXmo870wnuuYI1pL69PpSShVXLUfeCJy82zRSiD0TAKehsScy7PPWZdcH+jqaCj02QL
 kFZCgZunayVK8ji/YGjOacvZv+7UCpBUAbWAN+ZvMnrNGupxBZg4rfrn4HU1c5SoPpA/
 JKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MNfUquSBQXRdU8AFXuKgswA3BnrGyLe9et79dGaHCHo=;
 b=ZMaJB09Gf0Mf39JKnnPEpfvnaXV519m1dy3uvc5Z79RyjdV/OYCUQuhVIIgUbsfhqW
 9ce8Rf2+ibwsamtkZ/8ks6JA1n6wZvvIVpuNAzFBs252H2RQ7zFUsAcDfz0zP2sdimUI
 246dGn1xRI+smFX9D5tPPqoDo6WAiDWZUK36mwwlHcgGXWiOSzsnlQqy8mOYmidpAvTd
 bboK9aR8jlf2DtRg2oLojzwsJ0a4GkA1T0MjwTikFYy2sQcJpRh/6pXP0PZIZ8opDoQ+
 LgIbCuUXodjDTW6yXzcIm+JWVehmPTbPh93Rh4ctyy7jL0hH6eKlEpaQdPJ9Nq3K6vmR
 iNfw==
X-Gm-Message-State: AOAM5319E6bUlsWDaO0TuyDLEgU7wdgCKpo1IhTsOc5rU1VstiUAe7aK
 5v1PFlsqLm20Q7plmrG3DaE9UQ==
X-Google-Smtp-Source: ABdhPJxKHrquOOAsrXP0Ic/O71Wk33ou9E5855eyzUO0XSRyB3TpmdWISR92SDQl7rOKCjBmfNPoLA==
X-Received: by 2002:a05:600c:2e08:b0:394:24c:2da4 with SMTP id
 o8-20020a05600c2e0800b00394024c2da4mr3532185wmf.134.1651242901408; 
 Fri, 29 Apr 2022 07:35:01 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 m35-20020a05600c3b2300b00393ebe201a6sm7075995wms.44.2022.04.29.07.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Apr 2022 07:35:00 -0700 (PDT)
Date: Fri, 29 Apr 2022 15:34:36 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <Ymv3fC4xXqe+oMRK@myrica>
References: <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica>
 <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com>
 <YmbO/l5IwfBCHrl8@myrica>
 <8c044e49-74bb-df56-8a60-663013c0910e@intel.com>
 <YmgiQZZyFxsJ+9um@myrica>
 <63582490-a794-fd11-0380-44b27cc660b7@intel.com>
 <YmpSv48aPIbVXqGi@myrica>
 <044595e6-e5d0-26c2-af8e-fc9d06906179@linux.intel.com>
 <YmvtVRlwVJjStXc0@fyu1.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YmvtVRlwVJjStXc0@fyu1.sc.intel.com>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 will@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 zhangfei.gao@linaro.org, Thomas Gleixner <tglx@linutronix.de>,
 robin.murphy@arm.com
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

On Fri, Apr 29, 2022 at 06:51:17AM -0700, Fenghua Yu wrote:
> Hi, Baolu,
> 
> On Fri, Apr 29, 2022 at 03:53:57PM +0800, Baolu Lu wrote:
> > On 2022/4/28 16:39, Jean-Philippe Brucker wrote:
> > > > The address space is what the OOM killer is after.  That gets refcounted
> > > > with mmget()/mmput()/mm->mm_users.  The OOM killer is satiated by the
> > > > page freeing done in __mmput()->exit_mmap().
> > > > 
> > > > Also, all the VMAs should be gone after exit_mmap().  So, even if
> > > > vma->vm_file was holding a reference to a device driver, that reference
> > > > should be gone by the time __mmdrop() is actually freeing the PASID.
> > > 
> > > I agree with all that. The concern was about tearing down the PASID in the
> > > IOMMU and device from the release() MMU notifier, which would happen in
> > > exit_mmap(). But doing the teardown at or before __mmdrop() is fine. And
> > > since the IOMMU drivers need to hold mm->mm_count anyway between bind()
> > > and unbind(), I think Fenghua's fix works.
> > 
> > But I didn't find mmgrab()/mmdrop() get called in both arm and intel
> > IOMMU drivers.
> > 
> > $ git grep mmgrab drivers/iommu/
> > [no output]
> > 
> > Do we need to add these in a separated fix patch, or I missed anything
> > here?
> 
> On both ARM and X86, sva_bind() calls mmu_notifier_register()->mmgrab() and
> sva_unbind() calls mmu_notifier_unregister()/mmu_notifier_put()->mmdrop().

Yes, although for Arm I realized the mmu_notifier grab wasn't sufficient
so I sent a separate fix that should go in 5.18 as well
https://lore.kernel.org/linux-iommu/20220426130444.300556-1-jean-philippe@linaro.org/
The Arm driver still touches the arch mm context after mmu_notifier_put().
I don't think X86 has that problem.

Thanks,
Jean

> So mm->mm_count are already counted in existing ARM and X86 binding and
> unbinding. The fix patch just frees the PASID in __mmdrop() after
> no more mm->mm_count.
> 
> There is no need to add extra  mmgrab() and mmdrop() pair.
> 
> Thanks.
> 
> -Fenghua
> 
>  
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
