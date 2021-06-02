Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2135C47083
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 10:20:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B966613BF
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 10:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B966613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A812402E6;
	Wed,  2 Jun 2021 10:20:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 91rGyrsuHRXm; Wed,  2 Jun 2021 10:20:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD61C40230;
	Wed,  2 Jun 2021 10:20:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 895D7C000E;
	Wed,  2 Jun 2021 10:20:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0270FC0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 10:20:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D593960705
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 10:20:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="goUuSDeF";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="QFU8uRFn"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E0R6EsQ5ZAOy for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 10:20:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4CD0360595
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 10:20:23 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1622629219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ycehTrtSkbzNyxkb7pYteowZNnr3e/3i4uwrIdUn4ks=;
 b=goUuSDeF84WkaAOZwHO7jxr8b6qzOlP5Z8RALkPRnEgu/QgIAO9AYiqvP3EQePtlz4ISWM
 P9xXodHXj0EhuqHSWGw8w49Xiwpqvtr7ueb0D2IcXvsJSIiJhqyNuzxgW1zZ6lIl7k58Q3
 2mpAA3Mw2hFEToZ19NiMsIab9COwDaUi/+R2WY3Oobff+ok36o2gJDUsOFZKnoeNLt9lfK
 owDobF+aH6xCaqaBxsoqXADNmnwhU9tvV3JIE5rkiloCmw26kJmbDxKs3ctZ905F84gzvH
 XtM2rrAh/5DHvYlG8MViQXAq+YmGW1G30ySblTZSpk7SdDVkJrIBWut8quG2xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1622629219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ycehTrtSkbzNyxkb7pYteowZNnr3e/3i4uwrIdUn4ks=;
 b=QFU8uRFnQvM4DJ8WlmWMQuSSa53t7e7ZnEkgELkmq1CQdCWE4GgFM9XNxOOfO7dszlJ+pX
 EAJJgXit3+y5mDCA==
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and
 remove update_pasid()
In-Reply-To: <YLdZ7bZDPNup1n9c@zn.tnic>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de> <YLdZ7bZDPNup1n9c@zn.tnic>
Date: Wed, 02 Jun 2021 12:20:18 +0200
Message-ID: <87k0nc1sbh.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 H Peter Anvin <hpa@zytor.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, dmaengine@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>
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

On Wed, Jun 02 2021 at 12:14, Borislav Petkov wrote:

> On Sat, May 29, 2021 at 11:17:30AM +0200, Thomas Gleixner wrote:
>> --- a/arch/x86/include/asm/disabled-features.h
>> +++ b/arch/x86/include/asm/disabled-features.h
>> @@ -56,11 +56,8 @@
>>  # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
>>  #endif
>>  
>> -#ifdef CONFIG_IOMMU_SUPPORT
>> -# define DISABLE_ENQCMD	0
>> -#else
>> -# define DISABLE_ENQCMD (1 << (X86_FEATURE_ENQCMD & 31))
>> -#endif
>> +/* Force disable because it's broken beyond repair */
>> +#define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
>
> Yeah, for that to work we need:
>
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Wed, 2 Jun 2021 12:07:52 +0200
> Subject: [PATCH] dmaengine: idxd: Use cpu_feature_enabled()
>
> When testing x86 feature bits, use cpu_feature_enabled() so that
> build-disabled features can remain off, regardless of what CPUID says.
>
> Fixes: 8e50d392652f ("dmaengine: idxd: Add shared workqueue support")
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks for spotting this!

       tglx

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
