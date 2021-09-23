Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC76C433F5
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 15:26:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8A061019
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 15:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D8A061019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0BFC83E9D;
	Thu, 23 Sep 2021 15:26:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z1J1vhXfYR3i; Thu, 23 Sep 2021 15:26:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CCEDC83313;
	Thu, 23 Sep 2021 15:26:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9817AC0011;
	Thu, 23 Sep 2021 15:26:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71556C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 15:26:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C64140204
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 15:26:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4n8huA7X8rnW for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 15:26:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 66E47400B5
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 15:26:18 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="309425876"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="309425876"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 08:26:16 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="702771098"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 08:26:16 -0700
Date: Thu, 23 Sep 2021 15:26:14 +0000
From: Fenghua Yu <fenghua.yu@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 7/8] tools/objtool: Check for use of the ENQCMD
 instruction in the kernel
Message-ID: <YUycliX+lPSMhWfR@otcwcpicx3.sc.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-8-fenghua.yu@intel.com>
 <20210922210343.GU4323@worktop.programming.kicks-ass.net>
 <YUu/6YPYwvaDwthy@otcwcpicx3.sc.intel.com>
 <YUwp7VkjApRQr/pb@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YUwp7VkjApRQr/pb@hirez.programming.kicks-ass.net>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

Hi, Peter,

On Thu, Sep 23, 2021 at 09:17:01AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 22, 2021 at 11:44:41PM +0000, Fenghua Yu wrote:
> 
> > > Since you're making it a fatal error, before doing much of anything
> > > else, you might at well fail decode and keep it all in the x86/decode.c
> > > file, no need to spread this 'knowledge' any further.
> 
> > Is the following updated patch a right one?
> 
> Yes, that's what I was thinking of.
> 
> > diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> > index bc821056aba9..3e0f928e28a5 100644
> > --- a/tools/objtool/arch/x86/decode.c
> > +++ b/tools/objtool/arch/x86/decode.c
> > @@ -110,7 +110,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
> >  {
> >  	struct insn insn;
> >  	int x86_64, ret;
> > -	unsigned char op1, op2,
> > +	unsigned char op1, op2, op3,
> >  		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
> >  		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
> >  		      sib = 0, /* sib_scale = 0, */ sib_index = 0, sib_base = 0;
> > @@ -137,6 +137,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
> >  
> >  	op1 = insn.opcode.bytes[0];
> >  	op2 = insn.opcode.bytes[1];
> > +	op3 = insn.opcode.bytes[2];
> >  
> >  	if (insn.rex_prefix.nbytes) {
> >  		rex = insn.rex_prefix.bytes[0];
> > @@ -489,6 +490,16 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
> >  			/* nopl/nopw */
> >  			*type = INSN_NOP;
> >  
> > +		} else if (op2 == 0x38 && op3 == 0xf8) {
> > +			if (insn.prefixes.nbytes == 1 &&
> > +			    insn.prefixes.bytes[0] == 0xf2) {
> > +				/* ENQCMD cannot be used in the kernel. */
> > +				WARN("ENQCMD instruction at %s:%lx", sec->name,
> > +				     offset);
> > +
> > +				return -1;
> > +			}
> 
> The only concern here is if we want it to be fatal or not. But otherwise
> this seems to be all that's required.

objtool doesn't fail kernel build on this fatal warning.

Returning -1 here stops checking the rest of the file and won't report any
further warnings unless this ENQCMD warning is fixed. Not returning -1
continues checking the rest of the file and may report more warnings.
Seems that's the only difference b/w them.

Should I keep this "return -1" or not? Please advice.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
