Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3D6C4727E
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 19:19:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43322221EC
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 19:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evGNDMO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43322221EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D390A2E18E;
	Fri, 25 Sep 2020 19:19:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bEoqqN-iLo-e; Fri, 25 Sep 2020 19:19:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0EB102E17D;
	Fri, 25 Sep 2020 19:19:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F28BBC0859;
	Fri, 25 Sep 2020 19:19:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E74CC0051
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 19:19:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 45BE42E18C
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 19:19:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FiN3cgA55fP2 for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 19:19:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 297C52E1F8
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 19:18:46 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id f142so3886462qke.13
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 12:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=6TNafuoIllawQn6PtbN92TdSRIqwBFFijyaKCHiMRO8=;
 b=evGNDMO9ibKnC9IIMxSY5gCKLneXJCbZAtYKRb+b0eqbtNY+YPD55HKTcNzDrgLW7B
 RDI6+vqyV/HAqRXBFq/YlLucPTE0KaXPDrzz9e2ieTaRQl6qSQ5ZtA7SzkBwSGwbXCnt
 kudr+3GWAme8v2znAjGDdFg/jW+i7u3VQLoGfFrfICTqU9KUqBRTmPoTIGw5+GGyIts+
 35hF4aK3bac5Aph6CKLm3caeYXfhSkUxTb3PJuZQyAUzzubotV8eGFy7JGwn603R6O1U
 rz/ExJnyViO8FarBZtevTaGxv4x3fJq6ApLwi/xBUaNxc1ClP7weeQ2yFiTp/YLSTdUv
 8N1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=6TNafuoIllawQn6PtbN92TdSRIqwBFFijyaKCHiMRO8=;
 b=HeADSFb5JXUTcIfCbdLNQpsYLBvOg17RzbalAmSsaYCuUpOgtnKgF3v5d4xVK/6mQI
 eCtKej96c0z3RZV13e7WCHMQWGaMkmDqE5ED72I+Klh4HromhddpjHoZff0ZCd7CrH4R
 KK7pXPnBhtPVjkbBQiaenIEDV5VbRVXkT2JQ7K8ZQSPx6pgkLDt5NUAXMdYqn+3QpD2e
 bDks6zI+TFHpGMO9uyO6aNjMfXgKICVhkfnWiDKV5g3QdGvtb8/m1FR2duzr6i/Ggr0E
 cww9izApXhBE/9z/nsq4boNqCs4hXv17DUvYUPtJ53vtDpozKnyX8EjHRTDhDh8f52n3
 D4aQ==
X-Gm-Message-State: AOAM532qKl3YfEzpXK3y9uOGvRMsE58EifiM4J6FhkYFmb+NhfvAHhdF
 7g3s06BxItRckdzwNuISwNg=
X-Google-Smtp-Source: ABdhPJwbT6a2ae209myBNEn/nx0a/Kuv0M3OuuZlwlLfKUbyg927V++WNXIMfomx0jAiRi2e2zd2xw==
X-Received: by 2002:a37:5cc2:: with SMTP id q185mr1437063qkb.35.1601061524669; 
 Fri, 25 Sep 2020 12:18:44 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
 by smtp.gmail.com with ESMTPSA id m67sm2217409qkf.98.2020.09.25.12.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 12:18:44 -0700 (PDT)
From: Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date: Fri, 25 Sep 2020 15:18:42 -0400
To: Ross Philipson <ross.philipson@oracle.com>
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
Message-ID: <20200925191842.GA643740@rani.riverdale.lan>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
 <20200924173801.GA103726@rani.riverdale.lan>
 <c9ab2edf-1aaf-a1c9-92d5-2d37382a3163@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c9ab2edf-1aaf-a1c9-92d5-2d37382a3163@oracle.com>
Cc: linux-doc@vger.kernel.org, dpsmith@apertussolutions.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 luto@amacapital.net, Arvind Sankar <nivedita@alum.mit.edu>, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, linux-integrity@vger.kernel.org,
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

On Fri, Sep 25, 2020 at 10:56:43AM -0400, Ross Philipson wrote:
> On 9/24/20 1:38 PM, Arvind Sankar wrote:
> > On Thu, Sep 24, 2020 at 10:58:35AM -0400, Ross Philipson wrote:
> > 
> >> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> >> index 97d37f0..42043bf 100644
> >> --- a/arch/x86/boot/compressed/head_64.S
> >> +++ b/arch/x86/boot/compressed/head_64.S
> >> @@ -279,6 +279,21 @@ SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
> >>  SYM_FUNC_END(efi32_stub_entry)
> >>  #endif
> >>  
> >> +#ifdef CONFIG_SECURE_LAUNCH
> >> +SYM_FUNC_START(sl_stub_entry)
> >> +	/*
> >> +	 * On entry, %ebx has the entry abs offset to sl_stub_entry. To
> >> +	 * find the beginning of where we are loaded, sub off from the
> >> +	 * beginning.
> >> +	 */
> > 
> > This requirement should be added to the documentation. Is it necessary
> > or can this stub just figure out the address the same way as the other
> > 32-bit entry points, using the scratch space in bootparams as a little
> > stack?
> 
> It is based on the state of the BSP when TXT vectors to the measured
> launch environment. It is documented in the TXT spec and the SDMs.
> 

I think it would be useful to add to the x86 boot documentation how
exactly this new entry point is called, even if it's just adding a link
to some section of those specs. The doc should also say that an
mle_header_offset of 0 means the kernel isn't secure launch enabled.

> > 
> > For the 32-bit assembler code that's being added, tip/master now has
> > changes that prevent the compressed kernel from having any runtime
> > relocations.  You'll need to revise some of the code and the data
> > structures initial values to avoid creating relocations.
> 
> Could you elaborate on this some more? I am not sure I see places in the
> secure launch asm that would be creating relocations like this.
> 
> Thank you,
> Ross
> 

You should see them if you do
	readelf -r arch/x86/boot/compressed/vmlinux

In terms of the code, things like:

	addl    %ebx, (sl_gdt_desc + 2)(%ebx)

will create a relocation, because the linker interprets this as wanting
the runtime address of sl_gdt_desc, rather than just the offset from
startup_32.

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/arch/x86/boot/compressed/head_64.S#n48

has a comment with some explanation and a macro that the 32-bit code in
startup_32 uses to avoid creating relocations.

Since the SL code is in a different assembler file (and a different
section), you can't directly use the same macro. I would suggest getting
rid of sl_stub_entry and entering directly at sl_stub, and then the code
in sl_stub.S can use sl_stub for the base address, defining the rva()
macro there as

	#define rva(X) ((X) - sl_stub)

You will also need to avoid initializing data with symbol addresses.

	.long mle_header
	.long sl_stub_entry
	.long sl_gdt

will create relocations. The third one is easy, just replace it with
sl_gdt - sl_gdt_desc and initialize it at runtime with

	leal	rva(sl_gdt_desc)(%ebx), %eax
	addl	%eax, 2(%eax)
	lgdt	(%eax)

The other two are more messy, unfortunately there is no easy way to tell
the linker what we want here. The other entry point addresses (for the
EFI stub) are populated in a post-processing step after the compressed
kernel has been linked, we could teach it to also update kernel_info.

Without that, for kernel_info, you could change it to store the offset
of the MLE header from kernel_info, instead of from the start of the
image.

For the MLE header, it could be moved to .head.text in head_64.S, and
initialized with
	.long rva(sl_stub)
This will also let it be placed at a fixed offset from startup_32, so
that kernel_info can just be populated with a constant.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
