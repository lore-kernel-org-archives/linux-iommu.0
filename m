Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEE7C4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 17:38:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC41F2396E
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 17:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZOWGP+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC41F2396E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 04E4486BB7;
	Thu, 24 Sep 2020 17:38:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GU3Rr0gO01Mn; Thu, 24 Sep 2020 17:38:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2064586B4A;
	Thu, 24 Sep 2020 17:38:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F4FEC0890;
	Thu, 24 Sep 2020 17:38:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF229C0859
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 17:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A128486A94
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 17:38:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BwojNQ7fXf2Z for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 17:38:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E523786A88
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 17:38:04 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id d20so266188qka.5
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5bhRjdNmwctA9bi8GxsYvmMwgzV/9dcdCn2Ip4F4euc=;
 b=cZOWGP+ALCi4vj4BHTzKgWDrtzwE4tF3jGNpkhuLUh6fG/k8zqpGq1Lo/0dcBLLoIi
 pPGI5IpS/OrzvOjkni8+1PZ149ujLT0LOP6DV/JchuR6Qm2t3wNtyHG6ve58+vpA1a+n
 vo9tdcnK4n/fTNOQCs55j4rhmmB4gid8Yk08zVDqQHhgx6gWFwcbAHR0ggH6v1Hu9XQg
 NWk8LyxkU2lLBfuX9c41Izqi6n4RXF8OzcYv/vBHceR4AQDOinz6HygZUKBdg1Ok6Fhz
 x7PDV/Kr3TTU4rGFdiyUzzj3q20kP8wByDlsqyrvCMsSIga89AVXjSHZt/HQ36A/Zqys
 Zm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=5bhRjdNmwctA9bi8GxsYvmMwgzV/9dcdCn2Ip4F4euc=;
 b=csmhToo5YdqGVQj2jtHeeW85vMtRzItu8+8G/wUEVUNs/gDAZd3Ag5pVI/ZUL/r5ar
 2ynZev6xscPuMoURBHO7ENJ98+AcGpiFSf+NAeZ1mCMNa8kzK+uq+p/wnsOEjP8bcyXr
 Ren7wI0CCV5Iz71jkhDmZzUr3tdossZRPbTXST+qn//R2Hh3GO4xP2xXQiti1jR4dtHC
 BzPqGxyKITh5ejI4MBO8zrScjxXGov53o/qNmYcxtvOcgpQSegrOMO9MDTwDq+NHd7zx
 Bpy7MxQgR7J7Svwxcee7EZrcTzC37CUGMCt4LsBfOO1Tdw2VyBlpYeXtBVX8Je3DhMdK
 aoeQ==
X-Gm-Message-State: AOAM531x1nQ5j0vZISHKIRL8ZueK5TMMOObvinKTsdTdh1lhtmeAs8Uh
 2+e2ppBIFlO9AGSz0v7sSlM=
X-Google-Smtp-Source: ABdhPJzvAQTyLYVuqTgONX5CqLnI4a7/K1S3m2ztmokOk/j35ocAhw/nB+FROtf10E9RL4+9MkjRSg==
X-Received: by 2002:a37:9c8:: with SMTP id 191mr213412qkj.292.1600969083722;
 Thu, 24 Sep 2020 10:38:03 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
 by smtp.gmail.com with ESMTPSA id n136sm96584qkn.14.2020.09.24.10.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 10:38:03 -0700 (PDT)
From: Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date: Thu, 24 Sep 2020 13:38:01 -0400
To: Ross Philipson <ross.philipson@oracle.com>
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
Message-ID: <20200924173801.GA103726@rani.riverdale.lan>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
Cc: linux-doc@vger.kernel.org, dpsmith@apertussolutions.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, luto@amacapital.net,
 iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, linux-integrity@vger.kernel.org,
 trenchboot-devel@googlegroups.com, tglx@linutronix.de
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

On Thu, Sep 24, 2020 at 10:58:35AM -0400, Ross Philipson wrote:
> The Secure Launch (SL) stub provides the entry point for Intel TXT (and
> later AMD SKINIT) to vector to during the late launch. The symbol
> sl_stub_entry is that entry point and its offset into the kernel is
> conveyed to the launching code using the MLE (Measured Launch
> Environment) header in the structure named mle_header. The offset of the
> MLE header is set in the kernel_info. The routine sl_stub contains the
> very early late launch setup code responsible for setting up the basic
> environment to allow the normal kernel startup_32 code to proceed. It is
> also responsible for properly waking and handling the APs on Intel
> platforms. The routine sl_main which runs after entering 64b mode is
> responsible for measuring configuration and module information before
> it is used like the boot params, the kernel command line, the TXT heap,
> an external initramfs, etc.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Which version of the kernel is this based on?

> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 97d37f0..42043bf 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -279,6 +279,21 @@ SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
>  SYM_FUNC_END(efi32_stub_entry)
>  #endif
>  
> +#ifdef CONFIG_SECURE_LAUNCH
> +SYM_FUNC_START(sl_stub_entry)
> +	/*
> +	 * On entry, %ebx has the entry abs offset to sl_stub_entry. To
> +	 * find the beginning of where we are loaded, sub off from the
> +	 * beginning.
> +	 */

This requirement should be added to the documentation. Is it necessary
or can this stub just figure out the address the same way as the other
32-bit entry points, using the scratch space in bootparams as a little
stack?

> +	leal	(startup_32 - sl_stub_entry)(%ebx), %ebx
> +
> +	/* More room to work in sl_stub in the text section */
> +	jmp	sl_stub
> +
> +SYM_FUNC_END(sl_stub_entry)
> +#endif
> +
>  	.code64
>  	.org 0x200
>  SYM_CODE_START(startup_64)
> @@ -537,6 +552,25 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>  	shrq	$3, %rcx
>  	rep	stosq
>  
> +#ifdef CONFIG_SECURE_LAUNCH
> +	/*
> +	 * Have to do the final early sl stub work in 64b area.
> +	 *
> +	 * *********** NOTE ***********
> +	 *
> +	 * Several boot params get used before we get a chance to measure
> +	 * them in this call. This is a known issue and we currently don't
> +	 * have a solution. The scratch field doesn't matter and loadflags
> +	 * have KEEP_SEGMENTS set by the stub code. There is no obvious way
> +	 * to do anything about the use of kernel_alignment or init_size
> +	 * though these seem low risk.
> +	 */

There are various fields in bootparams that depend on where the
kernel/initrd and cmdline are loaded in memory. If the entire bootparams
page is getting measured, does that mean they all have to be at fixed
addresses on every boot?

Also KEEP_SEGMENTS support is gone from the kernel since v5.7, since it
was unused. startup_32 now always loads a GDT and then the segment
registers. I think this should be ok for you as the only thing the flag
used to do in the 64-bit kernel was to stop startup_32 from blindly
loading __BOOT_DS into the segment registers before it had setup its own
GDT.

For the 32-bit assembler code that's being added, tip/master now has
changes that prevent the compressed kernel from having any runtime
relocations.  You'll need to revise some of the code and the data
structures initial values to avoid creating relocations.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
