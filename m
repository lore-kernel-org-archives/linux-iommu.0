Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676E6C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 17:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0590540263;
	Mon, 14 Feb 2022 17:24:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XmmnTQxoTqb0; Mon, 14 Feb 2022 17:24:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E4EE940267;
	Mon, 14 Feb 2022 17:24:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7ED3C001A;
	Mon, 14 Feb 2022 17:24:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7168BC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 17:24:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 415C6400A4
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 17:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="FxBkfG5S";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="x0jfrvJ2"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kX-YsnnrhugK for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 17:24:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 78D8C40332
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 17:24:00 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1644859435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d1o25gj0Q/pp9DqFCFKZq8sPPIEkmpv/ZWAOVwPqZ78=;
 b=FxBkfG5SpY54hfO5mDqy+1Z87DlSpfiiv4x2bYaRw8x5L+9YwvfqpIKGDOLMD+3SSHSiob
 RcKOImGYf+gNiUDlMIa5CZdRyGSBtKAo3gWp7xEVJL5lI8kOoKC2SRxLYmmbmHtjLn6C6G
 H2Le+8BSvohX7pK4fz7b8tW3ut6fpcLK7o0vm9QUFEv4FLhVfXYTjRFrgYThCGSSLgV1Wg
 zl4YaVVt87I4RooYsnDSKijmfGiy+Pu513WngKWrTx5xiAWWjzEf99n4IpVuYYdxCXAJ5M
 X+RvPVfwf1DHUA5pJMFOh1EJYaQjjfKcqZyvOneadFcHGfSIbtKq/3+DCqb5sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1644859435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d1o25gj0Q/pp9DqFCFKZq8sPPIEkmpv/ZWAOVwPqZ78=;
 b=x0jfrvJ2Ui8x+bWKo2Eq0MJes/8k37hz73YSpXorf7YsZ7Hm27JRj6iVBmPfkP5LFGsDqU
 +Kj99zAWGSqnhQAg==
To: Fenghua Yu <fenghua.yu@intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy
 Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Ashok
 Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v4 04/11] kernel/fork: Initialize mm's PASID
In-Reply-To: <20220207230254.3342514-5-fenghua.yu@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-5-fenghua.yu@intel.com>
Date: Mon, 14 Feb 2022 18:23:54 +0100
Message-ID: <87v8xhqs45.ffs@tglx>
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

On Mon, Feb 07 2022 at 15:02, Fenghua Yu wrote:

> A new mm doesn't have a PASID yet when it's created. Initialize
> the mm's PASID on fork() or for init_mm to INVALID_IOASID (-1).
>
> INIT_PASID (0) is reserved for kernel legacy DMA PASID. It cannot be
> allocated to a user process. Initializing the process's PASID to 0 may
> cause confusion that why the process uses the reserved kernel legacy DMA
> PASID. Initializing the PASID to INVALID_IOASID (-1) explicitly
> tells the process doesn't have a valid PASID yet.
>
> Even though the only user of mm_pasid_init() is in fork.c, define it
> in <linux/sched/mm.h> as the first of three mm/pasid life cycle
> functions (init/set/drop) to keep these all together.
>
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
