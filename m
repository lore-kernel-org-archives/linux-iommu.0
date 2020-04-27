Return-Path: <SRS0=6Sm1=6L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA55AC4CECD
	for <iommu@archiver.kernel.org>; Mon, 27 Apr 2020 20:14:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B0D42072D
	for <iommu@archiver.kernel.org>; Mon, 27 Apr 2020 20:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0D42072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 65CA2860C4;
	Mon, 27 Apr 2020 20:14:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vWiPLpBY-VSJ; Mon, 27 Apr 2020 20:14:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4B47585DF6;
	Mon, 27 Apr 2020 20:14:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 365ADC0172;
	Mon, 27 Apr 2020 20:14:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0B4CC003B
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 20:14:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8EA1C87F1F
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 20:14:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BdesMdhHhPYe for <iommu@lists.linux-foundation.org>;
 Mon, 27 Apr 2020 20:14:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BD3F387EE8
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 20:14:54 +0000 (UTC)
IronPort-SDR: 7K/HvPczqWMju7la0FJvuOz8LCTp/kaftq24J7r/UrXx5qao0tqY8I46eWiQ+SRFsOfPs7O0+x
 ELfVy7Ls2JdQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 13:14:54 -0700
IronPort-SDR: oSH1QzudxMhvrNKYYa85wCPYgn+CzdEisFQatM2S+MaevgrPdVt+tmmUWR2NSoLtOYQv8SqrGt
 31V5QV9sFD6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; d="scan'208";a="404431741"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga004.jf.intel.com with ESMTP; 27 Apr 2020 13:14:53 -0700
Date: Mon, 27 Apr 2020 13:13:57 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/7] docs: x86: Add a documentation for ENQCMD
Message-ID: <20200427201357.GB242333@romley-ivt3.sc.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-2-git-send-email-fenghua.yu@intel.com>
 <87368qtsqz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87368qtsqz.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, H Peter Anvin <hpa@zytor.com>,
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

On Sun, Apr 26, 2020 at 01:02:12PM +0200, Thomas Gleixner wrote:
> Fenghua Yu <fenghua.yu@intel.com> writes:
> 
> s/Add a documentation/Add documentation/
> 
> > From: Ashok Raj <ashok.raj@intel.com>
> >
> > ENQCMD and Data Streaming Accelerator (DSA) and all of their associated
> > features are a complicated stack with lots of interconnected pieces.
> > This documentation provides a big picture overview for all of the
> > features.
> >
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  Documentation/x86/enqcmd.rst | 185 +++++++++++++++++++++++++++++++++++
> 
> How is that hooked up into the Documentation index?
> 
>  Documentation/x86/enqcmd.rst: WARNING: document isn't included in any toctree
> 
> > +++ b/Documentation/x86/enqcmd.rst
> > @@ -0,0 +1,185 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Improved Device Interaction Overview
> 
> So the document is about ENQCMD, right? Can you please make that in some
> way consistently named?
> 
> > +
> > +== Background ==
> 
> This lacks any docbook formatting.... The resulting HTML looks like ...
> 
> > +
> > +Shared Virtual Addressing (SVA) allows the processor and device to use the
> > +same virtual addresses avoiding the need for software to translate virtual
> > +addresses to physical addresses. ENQCMD is a new instruction on Intel
> > +platforms that allows user applications to directly notify hardware of new
> > +work, much like doorbells are used in some hardware, but carries a payload
> > +that carries the PASID and some additional device specific commands
> > +along with it.
> 
> Sorry that's not background information, that's an agglomeration of
> words.
> 
> Can you please explain properly what's the background of SVA, how it
> differs from regular device addressing and what kind of requirements it
> has?
> 
> ENQCMD is not related to background. It's part of the new technology.
> 
> > +== Address Space Tagging ==
> > +
> > +A new MSR (MSR_IA32_PASID) allows an application address space to be
> > +associated with what the PCIe spec calls a Process Address Space ID
> > +(PASID). This PASID tag is carried along with all requests between
> > +applications and devices and allows devices to interact with the process
> > +address space.
> 
> Sigh. The important part here is not the MSR. The important part is to
> explain what PASID is and where it comes from. Documentation has similar
> rules as changelogs:
> 
>       1) Provide context
> 
>       2) Explain requirements
>       
>       3) Explain implementation
> 
> The pile you provided is completely backwards and unstructured.

Ok. Will address all of the comments.

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
