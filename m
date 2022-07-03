Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2561C3F2D4
	for <iommu@archiver.kernel.org>; Sun,  3 Jul 2022 15:05:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FA6140923;
	Sun,  3 Jul 2022 15:05:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3FA6140923
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Vh7pwmFr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8zynlvNYE5cx; Sun,  3 Jul 2022 15:05:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B4350408F4;
	Sun,  3 Jul 2022 15:05:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4350408F4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73747C0032;
	Sun,  3 Jul 2022 15:05:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4054C002D
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 15:05:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F665405BA
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 15:05:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6F665405BA
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=Vh7pwmFr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gXsyIBXFV4FO for <iommu@lists.linux-foundation.org>;
 Sun,  3 Jul 2022 15:05:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A627A40017
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A627A40017
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 15:05:36 +0000 (UTC)
Received: by mail-yb1-xb2f.google.com with SMTP id 64so3278323ybt.12
 for <iommu@lists.linux-foundation.org>; Sun, 03 Jul 2022 08:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4QgHhJo99e7BP4qELBN4r2lriKbWdLtk6/DKUxmzOGg=;
 b=Vh7pwmFrp/ki5XJ76jyI5hNuUV1PKQWxt+H19V/GLJ3etny3Ed4qf9e0QV9OMyCnks
 +V7tZtdw1VniQ6BdZSdBWajNOZDP/9WVdUA9+J37kLhzlbC4xMvQ7twWstXyRhygrgEk
 OySwdBIMfbZujBrURcg8GdeODfqyyz4SIitS0W7F6ysxNT0VLPBddMx3/a/GvGvQdxvo
 iMowCy/4ZchQtcTLw19pWaXjlYPd52toUo7sie8xXqMfjy5oNYUEW0ViDYOw6PUrk0C5
 G34+Zs4D16S3OjNGlDvG+54xupVbs4o/Tt1NVLksn8dVuCTj0pxBkrj4yh/fdGcgDAoR
 8k/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4QgHhJo99e7BP4qELBN4r2lriKbWdLtk6/DKUxmzOGg=;
 b=EFHFSF4VwhNhzJm5//XbSteOAM3NtNvNN0kbzOrGD8cwyo85C9vNTv7+RDXw73JtuJ
 VsnoESHsJ+vl7g3fgbwiMcgNrB2QyKbwPqXo2u47cvEXmdWjk4AQRFgh8/ENDvp5ayBs
 JMSk5rDnMZtFbjsFaSt38Eb/+zfCmOQTF13bPy54yYHo7XbGTrlA9keH0y+JEI12LSll
 y6LQGLwn+rCJyRkstRlDgYEIonUBVLUQrBVKqN+GhZsGHSQPpKirZ8qig2AmtCXVch/o
 F/jjBKk0w48Nkx7WlB7B0tarH4+mEqYLCwfMOi79SwBuGWucTfyfywVv2PKo0qc+CbUh
 IGdQ==
X-Gm-Message-State: AJIora+xk9/SuJJShui/tTNsEOo34GcAx5gK7VZD3qFsq74f9JdHs0wG
 pTT54c+dYOKWPiCNIq9njmD6xYHxnOItA7TciPI=
X-Google-Smtp-Source: AGRyM1uAuVW9IWphg5kSjbYsSYjb/TM871XbOL+Xts9oBKQbm/sejVIg7QWw6bS/e6Nkvrm3x1W/9pxqPUjTrwcE74M=
X-Received: by 2002:a25:858e:0:b0:66e:4898:63e2 with SMTP id
 x14-20020a25858e000000b0066e489863e2mr673140ybk.296.1656860735358; Sun, 03
 Jul 2022 08:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220701200056.46555-1-samuel@sholland.org>
 <20220701200056.46555-8-samuel@sholland.org>
In-Reply-To: <20220701200056.46555-8-samuel@sholland.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 3 Jul 2022 17:04:58 +0200
Message-ID: <CAHp75VccKxO+Gtw46GvxSiPo4ShfpaZPOBehAp6gCoq3gT_9Cw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] genirq: Return a const cpumask from
 irq_data_get_affinity_mask
To: Samuel Holland <samuel@sholland.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Linux-SH <linux-sh@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Jan Beulich <jbeulich@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Sven Schnelle <svens@stackframe.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rob Herring <robh@kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Marc Zyngier <maz@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Russell King <linux@armlinux.org.uk>,
 Wei Xu <xuwei5@hisilicon.com>, iommu@lists.linux.dev,
 Ingo Molnar <mingo@redhat.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 xen-devel@lists.xenproject.org, Matt Turner <mattst88@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-xtensa@linux-xtensa.org,
 Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Maximilian Heyne <mheyne@amazon.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Richard Henderson <rth@twiddle.net>, Juergen Gross <jgross@suse.com>,
 Chris Zankel <chris@zankel.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Serge Semin <fancer.lancer@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 linux-alpha@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Colin Ian King <colin.king@intel.com>, Helge Deller <deller@gmx.de>
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

On Fri, Jul 1, 2022 at 10:01 PM Samuel Holland <samuel@sholland.org> wrote:
>
> Now that the irq_data_update_affinity helper exists, enforce its use
> by returning a a const cpumask from irq_data_get_affinity_mask.
>
> Since the previous commit already updated places that needed to call
> irq_data_update_affinity, this commit updates the remaining code that
> either did not modify the cpumask or immediately passed the modified
> mask to irq_set_affinity.

When we refer to functions, we use parentheses, e.g. func().

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
