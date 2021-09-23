Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E45C433F5
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 07:17:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40EFD61050
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 07:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 40EFD61050
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0815340704;
	Thu, 23 Sep 2021 07:17:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jr0D6IbnN6OG; Thu, 23 Sep 2021 07:17:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 73B5F406F1;
	Thu, 23 Sep 2021 07:17:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AE3DC000F;
	Thu, 23 Sep 2021 07:17:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E99BFC000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 07:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3E448434A
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 07:17:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vsdNImj2Xl0f for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 07:17:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A0D18428C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 07:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=wiTqtJ6sksxlMa3WLP5zy8iX0qeEG49ono78xA+0et0=; b=McpsbcT3Fqx+WK3yjJcovN6ZlR
 54WeOwpZBhEq9CWctYQaLbYB3uj/0LiX0f8rpBoFqR6kG+ZXmMHSDyJVs61KfLSyD7M22BULUIE/T
 95d/NWPFB+Bc/bYJTI16yApIL5fITZbTKv08c8ACw9BbJtU0ngiM/7LpC9W2lvpIXyIT10ltVQOSd
 8HUwwrmP7Nz9YsQ+NPJwBG2iVmyUA8eDQVJbIASqLU4DZ+PmADSMLwbDYCqivS0Q37PSJG7GZOiAD
 h5InkYL8Y4cmgQ/6HBXo+b1z1OMhGmpL3HE5rkZXJP5+OzdvkCvEhp+0NzsD3rsq3GT8lz2tC80Ov
 hVJHiJzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTIyc-005AeP-Tr; Thu, 23 Sep 2021 07:17:03 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1754A300250;
 Thu, 23 Sep 2021 09:17:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id F2BDA2133B1A2; Thu, 23 Sep 2021 09:17:01 +0200 (CEST)
Date: Thu, 23 Sep 2021 09:17:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 7/8] tools/objtool: Check for use of the ENQCMD
 instruction in the kernel
Message-ID: <YUwp7VkjApRQr/pb@hirez.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-8-fenghua.yu@intel.com>
 <20210922210343.GU4323@worktop.programming.kicks-ass.net>
 <YUu/6YPYwvaDwthy@otcwcpicx3.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YUu/6YPYwvaDwthy@otcwcpicx3.sc.intel.com>
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

On Wed, Sep 22, 2021 at 11:44:41PM +0000, Fenghua Yu wrote:

> > Since you're making it a fatal error, before doing much of anything
> > else, you might at well fail decode and keep it all in the x86/decode.c
> > file, no need to spread this 'knowledge' any further.

> Is the following updated patch a right one?

Yes, that's what I was thinking of.

> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index bc821056aba9..3e0f928e28a5 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -110,7 +110,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
>  {
>  	struct insn insn;
>  	int x86_64, ret;
> -	unsigned char op1, op2,
> +	unsigned char op1, op2, op3,
>  		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
>  		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
>  		      sib = 0, /* sib_scale = 0, */ sib_index = 0, sib_base = 0;
> @@ -137,6 +137,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
>  
>  	op1 = insn.opcode.bytes[0];
>  	op2 = insn.opcode.bytes[1];
> +	op3 = insn.opcode.bytes[2];
>  
>  	if (insn.rex_prefix.nbytes) {
>  		rex = insn.rex_prefix.bytes[0];
> @@ -489,6 +490,16 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
>  			/* nopl/nopw */
>  			*type = INSN_NOP;
>  
> +		} else if (op2 == 0x38 && op3 == 0xf8) {
> +			if (insn.prefixes.nbytes == 1 &&
> +			    insn.prefixes.bytes[0] == 0xf2) {
> +				/* ENQCMD cannot be used in the kernel. */
> +				WARN("ENQCMD instruction at %s:%lx", sec->name,
> +				     offset);
> +
> +				return -1;
> +			}

The only concern here is if we want it to be fatal or not. But otherwise
this seems to be all that's required.

> +
>  		} else if (op2 == 0xa0 || op2 == 0xa8) {
>  
>  			/* push fs/gs */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
