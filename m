Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2078C4741F
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 18:55:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A3820774
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 18:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4MkOq3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A3820774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 898EA214D2;
	Tue, 29 Sep 2020 18:55:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AIPhwD3Rt0Z8; Tue, 29 Sep 2020 18:55:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CFEB7204D1;
	Tue, 29 Sep 2020 18:55:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B164DC0889;
	Tue, 29 Sep 2020 18:55:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1042C016F
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 17:26:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E11AF86508
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 17:26:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 45+7iqHP7S4P for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 17:26:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CA782864DA
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 17:26:48 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id a15so4701675ljk.2
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vhk3MbInaaF/6croUvi+/zraDixQnx7wCrXOslWTtys=;
 b=n4MkOq3UvJP9m0yc5Rtex4KtclxrWnItxqOpn6tZJzlS3ahY9sxrZ99wx/IIjkLyvA
 K0GqFxQHjcFt79Rjzd/Zm9P8+hgfC0QYVVFBS3iB5TCojtSzbQJOyd0rGk4g2xAykhL1
 Mpwh64dBzCzV9r1Za8avYcsDcrmErdyZmkPZ9kEoUIO8LDElIUZB0ATuZbnGDNr+fYQS
 fMRGTlsGFAmcXPGzIlYRJpjM9y6G5KnSBPq844V0njnx82hXnbevNRGQZz0ZkAWsenvR
 bKCofziWQTxGJfxBozUMNCYve9GC3OKOVWJ2cqK5v8FXJ+cKBVDwL7pzd68pvgwRMTG2
 wnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vhk3MbInaaF/6croUvi+/zraDixQnx7wCrXOslWTtys=;
 b=dOp3iQxul5heDwQYJzz6hSAtjhyJ+SLOjEd7BrEwrvSxS+neONJnAJJMsPKHnEBHN3
 3YaMCqsYD29t+XydeVYASVHCcGfRp75HzdFnPnwIjimRHDZ+CdUfG9Gg8v0F602uBMXb
 czbL0n+gM7cfp8gKGmIojNZXmrx1fGh13jy+Sy/HOPQB9JH34NyfMU/7I1BOIbPF93Qz
 aC8hKhDg+L+EmAbHl7640LC872J9n2vgwAsbck3wYoTthzSgWtL3LljA+6XkRfZlV2xU
 9hKXEE0GlmzPDXO3wr6ylw0c/Phe0hS9EJu+8lEGgx3SqLtMM37FmKb/BwYHlbhyFBHq
 /a6A==
X-Gm-Message-State: AOAM531Hu841D1hUF/2baHac1W4TDAjrxX5HWk7Jjc+efTrjVKLb0be+
 OUtzZ2Jpd3i9ZVtkskxgVhjf8YXzrfq5ZMuMDb0=
X-Google-Smtp-Source: ABdhPJwxqnsM76aGzSU8gOeBJXlMS/Kp47YaHZhDo+51LyfyeEh9/7V3IF/bZW3wgT6Vd6jz1IR+rbVD/zCvPQOIjpY=
X-Received: by 2002:a2e:8988:: with SMTP id c8mr1422707lji.433.1601400406761; 
 Tue, 29 Sep 2020 10:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-4-git-send-email-ross.philipson@oracle.com>
In-Reply-To: <1600959521-24158-4-git-send-email-ross.philipson@oracle.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Tue, 29 Sep 2020 13:26:34 -0400
Message-ID: <CAKf6xpt=G_SJTGikXpQ36pfpSfXQZf0Upn9qTkf-F+mrY2SRDA@mail.gmail.com>
Subject: Re: [PATCH 03/13] x86: Add early SHA support for Secure Launch early
 measurements
To: Ross Philipson <ross.philipson@oracle.com>
X-Mailman-Approved-At: Tue, 29 Sep 2020 18:55:45 +0000
Cc: linux-doc@vger.kernel.org, Daniel Smith <dpsmith@apertussolutions.com>,
 x86@kernel.org, open list <linux-kernel@vger.kernel.org>, luto@amacapital.net,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-integrity@vger.kernel.org, trenchboot-devel@googlegroups.com,
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

On Thu, Sep 24, 2020 at 11:00 AM Ross Philipson
<ross.philipson@oracle.com> wrote:
>
> The SHA algorithms are necessary to measure configuration information into
> the TPM as early as possible before using the values. This implementation
> uses the established approach of #including the SHA libraries directly in
> the code since the compressed kernel is not uncompressed at this point.
>
> The SHA code here has its origins in the code from the main kernel. That
> code could not be pulled directly into the setup portion of the compressed
> kernel because of other dependencies it pulls in. The result is this is a
> modified copy of that code that still leverages the core SHA algorithms.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/boot/compressed/Makefile       |   4 +
>  arch/x86/boot/compressed/early_sha1.c   | 104 ++++++++++++++++
>  arch/x86/boot/compressed/early_sha1.h   |  17 +++
>  arch/x86/boot/compressed/early_sha256.c |   6 +
>  arch/x86/boot/compressed/early_sha512.c |   6 +
>  include/linux/sha512.h                  |  21 ++++
>  lib/sha1.c                              |   4 +
>  lib/sha512.c                            | 209 ++++++++++++++++++++++++++++++++
>  8 files changed, 371 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/early_sha1.c
>  create mode 100644 arch/x86/boot/compressed/early_sha1.h
>  create mode 100644 arch/x86/boot/compressed/early_sha256.c
>  create mode 100644 arch/x86/boot/compressed/early_sha512.c
>  create mode 100644 include/linux/sha512.h
>  create mode 100644 lib/sha512.c
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index ff7894f..0fd84b9 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -96,6 +96,10 @@ vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
>  efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
>
> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o
> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH_SHA256) += $(obj)/early_sha256.o
> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH_SHA512) += $(obj)/early_sha512.o
> +
>  # The compressed kernel is built with -fPIC/-fPIE so that a boot loader
>  # can place it anywhere in memory and it will still run. However, since
>  # it is executed as-is without any ELF relocation processing performed
> diff --git a/arch/x86/boot/compressed/early_sha1.c b/arch/x86/boot/compressed/early_sha1.c
> new file mode 100644
> index 0000000..198c46d
> --- /dev/null
> +++ b/arch/x86/boot/compressed/early_sha1.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020, Oracle and/or its affiliates.
> + * Copyright (c) 2020 Apertus Solutions, LLC.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/linkage.h>
> +#include <linux/string.h>
> +#include <asm/boot.h>
> +#include <asm/unaligned.h>
> +
> +#include "early_sha1.h"
> +
> +#define SHA1_DISABLE_EXPORT
> +#include "../../../../lib/sha1.c"
> +
> +/* The SHA1 implementation in lib/sha1.c was written to get the workspace
> + * buffer as a parameter. This wrapper function provides a container
> + * around a temporary workspace that is cleared after the transform completes.
> + */
> +static void __sha_transform(u32 *digest, const char *data)
> +{
> +       u32 ws[SHA1_WORKSPACE_WORDS];
> +
> +       sha1_transform(digest, data, ws);
> +
> +       memset(ws, 0, sizeof(ws));
> +       /*
> +        * As this is cryptographic code, prevent the memset 0 from being
> +        * optimized out potentially leaving secrets in memory.
> +        */
> +       wmb();

You can use memzero_explicit instead of open coding it.

Regards,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
