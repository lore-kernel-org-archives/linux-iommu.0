Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EADC47082
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 17:31:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02A6613AD
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 17:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02A6613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A585405A7;
	Thu,  3 Jun 2021 17:31:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y0P3HpiPfEmU; Thu,  3 Jun 2021 17:31:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4AB71404FE;
	Thu,  3 Jun 2021 17:31:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D36EC000E;
	Thu,  3 Jun 2021 17:31:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18BB9C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 17:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4CC3405A7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 17:31:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oT0UCx3_mj5D for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 17:31:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 380C4404FE
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 17:31:38 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14028600EF;
 Thu,  3 Jun 2021 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622741497;
 bh=CYn3EZTKJSh4MDX20btEjoQc2gajFSLKSEiCLpjOtyY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=UAfQrL/7OJGOkvO3MmOhUAvtCeD/mHVyyYbGmRCp6YswxdYsZq38j7rp2gh0G4bhW
 L98RJBLj9EVzi9azrc/Av2CuAvjOzYOtDhxzLz819aT/E3Wm/eBofItZHJb+he3jFe
 gMhfZD35ABXCWbxTpPJMR4U3aAkVMD3MMzM9724UXggGSCuSLk95MHApGY0Vrnq435
 /Ql2LfZn30+bGoyfvo7j9QMIrgh83CLd7NlfSlJQORtxTenr6qxgIoe3eK8FcA/f0f
 WvyPBLVV1JHqbQ0MGwJOd3CStKpYjqJOFOiOhGphNIJ8I8AErF1fedToDDc5a7AOi3
 wPMrxiTypLfQQ==
Subject: Re: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and
 remove update_pasid()
To: "Luck, Tony" <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Borislav Petkov <bp@alien8.de>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de> <YLShmFEzddfm7WQs@zn.tnic>
 <87y2bv438p.ffs@nanos.tec.linutronix.de>
 <36866b38ec92425b879881a88acf547b@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Message-ID: <db552f51-76ee-b7f5-20f1-14f1c703d423@kernel.org>
Date: Thu, 3 Jun 2021 10:31:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <36866b38ec92425b879881a88acf547b@intel.com>
Content-Language: en-US
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, "Hansen, Dave" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 H Peter Anvin <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>
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

On 6/2/21 1:37 PM, Luck, Tony wrote:
>>> ... so on a PASID system, your trivial reproducer would theoretically
>>> fire the same way and corrupt FPU state just as well.
>>
>> This is worse and you can't selftest it because the IPI can just hit in
>> the middle of _any_ FPU state operation and corrupt state.
> 
> That sounds like we should abandon the "IPI all the other threads
> to force enable the PASID for them" approach. It would just be a
> nightmare of papering over cracks when the IPI was delivered at
> some inconvenient moment when the recipient was in the middle
> of touching xsave state.
> 
> I've told Fenghua to dig out the previous iteration of this patch where
> the plan was to lazily fix the PASID_MSR in other threads in the #GP
> handler.

Blech.  Also this won't work for other PASID-like features.

I have a half-written patch to fix this up for real.  Stay tuned.

> Seems like a better direction than trying to fix the IPI method. The virtualization
> folks will like this way more because IPI in guest causes a couple of VMEXIT
> so is somewhat expensive.

It happens at most once per PASID-using process.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
