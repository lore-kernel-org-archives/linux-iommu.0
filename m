Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB4DC433F5
	for <iommu@archiver.kernel.org>; Mon, 27 Dec 2021 17:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CA74402BF;
	Mon, 27 Dec 2021 17:51:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cuKjzxkN2zVx; Mon, 27 Dec 2021 17:51:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3ED76402EE;
	Mon, 27 Dec 2021 17:51:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 101D4C002F;
	Mon, 27 Dec 2021 17:51:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 232B0C0012
 for <iommu@lists.linux-foundation.org>; Mon, 27 Dec 2021 17:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09E8C60E27
 for <iommu@lists.linux-foundation.org>; Mon, 27 Dec 2021 17:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8ho292Bgec4h for <iommu@lists.linux-foundation.org>;
 Mon, 27 Dec 2021 17:51:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 04BF3605AC
 for <iommu@lists.linux-foundation.org>; Mon, 27 Dec 2021 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640627466; x=1672163466;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=iPDSX7fY/NKEUf5rzPU4pa5rtlpdbe9mM+k8gcJXJUc=;
 b=CV36Phx2Ib634vGIUJVp9NNyfdVMsJ9sYOIJO4C3VGqsznBdhnoXFeNb
 T0Y1vDW23099iTx84nR3pWpFREbLin7/38oAldp7l7u3Y35MSy086jWvL
 OfOM3REsuxdtyakKD3jnUgHiMuCejWznT2XmLR3cAq9pilHhRjzwJHKsg
 IGq6qMuzV2F5VmelUqCAi/kJE5NsFWVjEz1lEAtyXxUm8pUD3meUmtjhI
 fL8V+wbvWoorhqMgND0crqnSwuq1FKauRt75hQ2xvSx84diDfRWc1mb2j
 xOwj31B2kcMWouHD4QVbiZmaouaOhe4gtzKL/dmwKA4f4lIYMEFR1gYaX A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="221249267"
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; d="scan'208";a="221249267"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Dec 2021 09:51:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; d="scan'208";a="686353442"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Dec 2021 09:51:05 -0800
Date: Mon, 27 Dec 2021 09:50:58 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 10/11] tools/objtool: Check for use of the ENQCMD
 instruction in the kernel
Message-ID: <Ycn9AqoxPuKxHLZi@otcwcpicx3.sc.intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-11-fenghua.yu@intel.com>
 <20211217225706.32ahbyf5yeuzrhre@treble>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211217225706.32ahbyf5yeuzrhre@treble>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
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

Hi, Josh,

On Fri, Dec 17, 2021 at 02:57:06PM -0800, Josh Poimboeuf wrote:
> On Fri, Dec 17, 2021 at 10:01:35PM +0000, Fenghua Yu wrote:
> > The ENQCMD implicitly accesses the PASID_MSR to fill in the pasid field
> > of the descriptor being submitted to an accelerator. But there is no
> > precise (and stable across kernel changes) point at which the PASID_MSR
> > is updated from the value for one task to the next.
> > 
> > Kernel code that uses accelerators must always use the ENQCMDS instruction
> > which does not access the PASID_MSR.
> > 
> > Check for use of the ENQCMD instruction in the kernel and warn on its
> > usage.
> > 
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > ---
> > v2:
> > - Simplify handling ENQCMD (PeterZ and Josh)
> 
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Thank you!

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
