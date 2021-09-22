Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB7BC433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 21:04:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0BA611C4
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 21:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF0BA611C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B0F480F34;
	Wed, 22 Sep 2021 21:04:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zr45342Uqku8; Wed, 22 Sep 2021 21:04:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1A6CC80EF9;
	Wed, 22 Sep 2021 21:04:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1676C0011;
	Wed, 22 Sep 2021 21:04:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE69CC000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 21:04:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 995204060C
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 21:04:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id knkCaTzmPLH1 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 21:04:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA76940603
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 21:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=/BsW4+kiX1t3eRyjco/t1BsfDHbZ3KbRhyDVWS+Vt7I=; b=ql0xsTOqfRkR2KMVRyT4j9GQnH
 xBbRjyKytCZUSUJ+9HKAZMqdSGbSfRC9O5UDt/L3Jp1Vhn6snjiEwO5KsILa51CaoOwysWfK+EUPv
 h3FZ/tSwtYWgkt/zUKRmVCfDu7f5880ZDl3/dYYvGq5BJi1Jq3GjjuegL2u199vbn+3gCBfgX3RxG
 hwPs2GQpD15j/fEfI9MYn86gD/5u4aothiVCyqd9WEHPv2vW/BCK6/ur9LSLm1bJ3jGREeuWsi4Tt
 iXkLkTNMLP0Gu1vYRXLBlCcAnC2SUtLDbi/f11t+XqQwiyNgy/b6XF8oZux90f6FmRQHN2MkpAynG
 RQ4XwaZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=worktop.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT9P7-0054sN-5g; Wed, 22 Sep 2021 21:03:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
 id C3C3D9811F0; Wed, 22 Sep 2021 23:03:43 +0200 (CEST)
Date: Wed, 22 Sep 2021 23:03:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 7/8] tools/objtool: Check for use of the ENQCMD
 instruction in the kernel
Message-ID: <20210922210343.GU4323@worktop.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-8-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210920192349.2602141-8-fenghua.yu@intel.com>
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

On Mon, Sep 20, 2021 at 07:23:48PM +0000, Fenghua Yu wrote:


> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e5947fbb9e7a..91d13521d9d6 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -3133,6 +3133,21 @@ static int validate_reachable_instructions(struct objtool_file *file)
>  	return 0;
>  }
>  
> +static int validate_enqcmd(struct objtool_file *file)
> +{
> +	struct instruction *insn;
> +
> +	for_each_insn(file, insn) {
> +		if (insn->type == INSN_ENQCMD) {
> +			WARN_FUNC("enqcmd instruction", insn->sec,
> +				  insn->offset);
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  int check(struct objtool_file *file)
>  {
>  	int ret, warnings = 0;
> @@ -3147,6 +3162,11 @@ int check(struct objtool_file *file)
>  	if (list_empty(&file->insn_list))
>  		goto out;
>  
> +	ret = validate_enqcmd(file);
> +	if (ret < 0)
> +		goto out;
> +	warnings += ret;
> +
>  	if (vmlinux && !validate_dup) {
>  		ret = validate_vmlinux_functions(file);
>  		if (ret < 0)

Since you're making it a fatal error, before doing much of anything
else, you might at well fail decode and keep it all in the x86/decode.c
file, no need to spread this 'knowledge' any further.

There's no actual state associated with it, you just want to avoid the
instruction being present.

Much simpler patch too.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
