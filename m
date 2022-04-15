Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8CEC433F5
	for <iommu@archiver.kernel.org>; Fri, 15 Apr 2022 19:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8AB283F90;
	Fri, 15 Apr 2022 19:07:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dFU6X5_87mCp; Fri, 15 Apr 2022 19:07:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9041B83F7B;
	Fri, 15 Apr 2022 19:07:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69398C002F;
	Fri, 15 Apr 2022 19:07:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 719F1C002C
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 19:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4EC65419C5
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 19:07:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Y5aH6zi3UfT for <iommu@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 19:07:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 722D4419B3
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 19:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650049635; x=1681585635;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=N5QZMTpSuxuuC/JrRfv1HnnxupDIgOPC/dOq/bciEhQ=;
 b=aH0OzNrCz+TeW5MVtPfu3JQVmfQSULG/BZrq4JE4lTYMjGlLrNK5Kj1C
 JDi72bRM9CMwHsLe73SOdXu5QgbjDUZ7XcFnnl5qe5LfG1v27jIMLPOOo
 V9B7WCsdZK1FEtsWA0Yq/Zu2X2WRuIjau2JlvIFXRaVKAlSSSdRasASvJ
 VCggaDeGh8ymVjzbxBvmhGDQbBK04oBLmrHnUkGzHuKWkJdtE4B7zdJ4+
 J4Ex4mSMZdrgExtY7/WrgcsPH68dXCJwu52nh/ZhnANG5IEDzewEBS7Aw
 gj8yME1ZU6gtSUUJdI20rv5S6X4TVFPBu1ZklR/soIPMU6PzsQ+pAGc7/ w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="349660574"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; d="scan'208";a="349660574"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2022 12:07:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; d="scan'208";a="553275527"
Received: from fyu1.sc.intel.com ([172.25.103.126])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2022 12:07:14 -0700
Date: Fri, 15 Apr 2022 12:07:44 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YlnCgJ6Mc7TtQSFQ@fyu1.sc.intel.com>
References: <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
 <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
 <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, jean-philippe <jean-philippe@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

Hi, Zhangfei,

On Fri, Apr 15, 2022 at 07:52:03PM +0800, zhangfei.gao@foxmail.com wrote:
> > On my X86 machine, nginx doesn't trigger the kernel sva binding function
> > to allocate ioasid. I tried pre- nstalled nginx/openssl and also tried my built
> > a few versions of nginx/openssl. nginx does call OPENSSL_init_ssl() but
> > doesn't go to the binding function. Don't know if it's my configuration issue.
> > Maybe you can give me some advice?
> I am using openssl engine, which use crypto driver and using sva via uacce.
> nginx -> openssl -> openssl engine -> sva related.

uacce is not used on X86. That's why I cannot test IOASID/PASID by nginx
on X86.

I only can test the RFC patch by other test tools via IDXD driver which uses
PASID on X86.

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
