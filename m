Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84801C433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 08:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24D44826FB;
	Thu, 28 Apr 2022 08:39:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cb0KGQh9iRxY; Thu, 28 Apr 2022 08:39:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EE793824B4;
	Thu, 28 Apr 2022 08:39:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B814EC0039;
	Thu, 28 Apr 2022 08:39:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B3DFC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 50CD441975
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:39:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 70w61rcMXxpY for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 08:39:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D46864196E
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:39:54 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id z19so4650710edx.9
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 01:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=D5+nFt6Ea7EC31s7wJHU5grETay07mE4VfWqd3ItgC0=;
 b=Ry01M9KA22nld0bRc5AXSR/k/WhEpT5PZniJo9iJBPUEkcgnabxgqnnAh0vpcJPVOJ
 qZZwhh7qmARlsHt0iAvt4oQYA7UYL6VZqpo/v4SwSczI4mv7k9ySJTS38/f2BHEy0gPN
 y7wHKxIU/q7oAwVDWmXglq8smOrQyZ7xmILZvBYzujXAr/5nps1MtSulZfyAQTJ/j+5W
 i+n2PKxANZPiF5e4bUQhc0deXWKTjfgn9mP4defuhSAY5ne6OIO+BjDgQBExG+AWU5ms
 Dc6kCx9pi9v3Y0Mi5z3/ljYEH8V55knGQm9GYit3TIOB2kfdIuDSiAd1Aq8K5Uzd2A2B
 Q1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=D5+nFt6Ea7EC31s7wJHU5grETay07mE4VfWqd3ItgC0=;
 b=datxofqQI4q1DVSJ6ICnuElmuoMg3kPl1tsP4hLEsiX0KE2Hk454viiFr6Lyz5xvQY
 y9ywIp0q1rAj/52BIMyueCyrgstBpHPgAnSONwEDrRtqImMbbH02WQi+vjcnc2IoMi8e
 3sV+zQZw/+8LIBJeZyZw0+CJ/givmMmfQohbygAqYHycu1Rt6iletcX3yNdIb9jB+ckN
 W5WKS4EBLz5pxougQeuGOdLn64fplcsLL2oU4huGIsknH17t0EeuMtpxPJCeTuIgsaSe
 fomzCqMSimE1Pn0Wj+F2H3HDkPHv+QszijTzb8HEshtXDEvNU5J8ojgVXf2EOKLrByDQ
 pFuA==
X-Gm-Message-State: AOAM532hRztXI0klDKTmNdx5VAy2jfnyrcDfBNrBcR/I42Cx+kX0nU7v
 QC1z84bhwlGEbCJF9cnxeKC7NA==
X-Google-Smtp-Source: ABdhPJwBPNHeb/K2J5VGKPrZ+4Y/Qy4hkj466iMlH8I6yasOvr5Ab1dpRZVkytuOmwHBu2gkcRU6SQ==
X-Received: by 2002:aa7:d609:0:b0:425:d94b:4119 with SMTP id
 c9-20020aa7d609000000b00425d94b4119mr24113038edr.282.1651135192971; 
 Thu, 28 Apr 2022 01:39:52 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 x24-20020a1709064bd800b006ef606fe5c1sm8064976ejv.43.2022.04.28.01.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 01:39:52 -0700 (PDT)
Date: Thu, 28 Apr 2022 09:39:27 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YmpSv48aPIbVXqGi@myrica>
References: <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica>
 <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com>
 <YmbO/l5IwfBCHrl8@myrica>
 <8c044e49-74bb-df56-8a60-663013c0910e@intel.com>
 <YmgiQZZyFxsJ+9um@myrica>
 <63582490-a794-fd11-0380-44b27cc660b7@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <63582490-a794-fd11-0380-44b27cc660b7@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, robin.murphy@arm.com,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, zhangfei.gao@linaro.org,
 Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
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

On Tue, Apr 26, 2022 at 04:31:57PM -0700, Dave Hansen wrote:
> On 4/26/22 09:48, Jean-Philippe Brucker wrote:
> > On Tue, Apr 26, 2022 at 08:27:00AM -0700, Dave Hansen wrote:
> >> On 4/25/22 09:40, Jean-Philippe Brucker wrote:
> >>> The problem is that we'd have to request the device driver to stop DMA
> >>> before we can destroy the context and free the PASID. We did consider
> >>> doing this in the release() MMU notifier, but there were concerns about
> >>> blocking mmput() for too long (for example
> >>> https://lore.kernel.org/linux-iommu/4d68da96-0ad5-b412-5987-2f7a6aa796c3@amd.com/
> >>> though I think there was a more recent discussion). We also need to drain
> >>> the PRI and fault queues to get rid of all references to that PASID.
> >> Is the concern truly about blocking mmput() itself?  Or, is it about
> >> releasing the resources associated with the mm?
> > The latter I think, this one was about releasing pages as fast as possible
> > if the process is picked by the OOM killer. 
> 
> We're tying the PASID to the life of the mm itself, not the mm's address
> space.  That means the PASID should be tied to
> mmgrab()/mmdrop()/mm->mm_count.
> 
> The address space is what the OOM killer is after.  That gets refcounted
> with mmget()/mmput()/mm->mm_users.  The OOM killer is satiated by the
> page freeing done in __mmput()->exit_mmap().
> 
> Also, all the VMAs should be gone after exit_mmap().  So, even if
> vma->vm_file was holding a reference to a device driver, that reference
> should be gone by the time __mmdrop() is actually freeing the PASID.

I agree with all that. The concern was about tearing down the PASID in the
IOMMU and device from the release() MMU notifier, which would happen in
exit_mmap(). But doing the teardown at or before __mmdrop() is fine. And
since the IOMMU drivers need to hold mm->mm_count anyway between bind()
and unbind(), I think Fenghua's fix works.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
