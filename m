Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E253C43461
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 07:53:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D0F21D7F
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 07:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jahzhXRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D0F21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2F1252E16D;
	Thu, 17 Sep 2020 07:53:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ig+Gk+2XeoXh; Thu, 17 Sep 2020 07:53:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 179531FEDF;
	Thu, 17 Sep 2020 07:53:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD7D0C0859;
	Thu, 17 Sep 2020 07:53:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A05EC0051
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 07:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 85A3C86BBD
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 07:53:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VNC7LBhoZqz4 for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 07:53:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 34F1486BEC
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 07:53:49 +0000 (UTC)
Received: from zn.tnic (p200300ec2f1053007b81a97eebdb4df7.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f10:5300:7b81:a97e:ebdb:4df7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F19EE1EC0286;
 Thu, 17 Sep 2020 09:53:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1600329226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=ewrYTBLqmR0WdfUwbHvpOSzEiXe9R9x+7NtUrZAyuck=;
 b=jahzhXRj6VqJO/u8dRJrB6L/MOuZjY9smlFNVagk55dbglzgn9wOm6eYabLOPPJHzddEKe
 iw9Bp6bs5HWH6CcFiM3g9kuEjxizytl3FF/vT+ANglOWtc1wSI/mN0xJGGZcIFfERAJbhE
 5xkQQU1Cfslq+Fh+Pl2qMf7FlJXmsIQ=
Date: Thu, 17 Sep 2020 09:53:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v8 3/9] Documentation/x86: Add documentation for SVA
 (Shared Virtual Addressing)
Message-ID: <20200917075338.GC31960@zn.tnic>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-4-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1600187413-163670-4-git-send-email-fenghua.yu@intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Tony Luck <tony.luck@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Andy Lutomirski <luto@kernel.org>,
 H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw2@infradead.org>, x86 <x86@kernel.org>
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

On Tue, Sep 15, 2020 at 09:30:07AM -0700, Fenghua Yu wrote:
> +Background
> +==========
> +
> +Shared Virtual Addressing (SVA) allows the processor and device to use the
> +same virtual addresses avoiding the need for software to translate virtual
> +addresses to physical addresses. SVA is what PCIe calls Shared Virtual
> +Memory (SVM).
> +
> +In addition to the convenience of using application virtual addresses
> +by the device, it also doesn't require pinning pages for DMA.
> +PCIe Address Translation Services (ATS) along with Page Request Interface
> +(PRI) allow devices to function much the same way as the CPU handling
> +application page-faults. For more information please refer to the PCIe
> +specification Chapter 10: ATS Specification.
> +
> +Use of SVA requires IOMMU support in the platform. IOMMU also is required
> +to support PCIe features ATS and PRI. ATS allows devices to cache
> +translations for virtual addresses. The IOMMU driver uses the mmu_notifier()
> +support to keep the device TLB cache and the CPU cache in sync. PRI allows
> +the device to request paging the virtual address by using the CPU page tables
> +before accessing the address.

That still reads funny, the "the device to request paging the virtual
address" part. Do you mean that per chance here:

"Before the device can access that address, the device uses the PRI in
order to request the virtual address to be paged in into the CPU page
tables."

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
