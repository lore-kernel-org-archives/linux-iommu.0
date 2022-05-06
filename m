Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7E5C433FE
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 21:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B47E60B71;
	Fri,  6 May 2022 21:41:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vi7qIzKcPK7h; Fri,  6 May 2022 21:41:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4C189608A5;
	Fri,  6 May 2022 21:41:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0DA2C0039;
	Fri,  6 May 2022 21:41:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E2EDC002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 21:41:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72C3C608A5
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 21:41:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21kwWJXOb1RY for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 21:41:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8B71607B5
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 21:41:15 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1651873274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEBD3i+RCMCV6ItWgJTNpoS5Qp50+5gg+1MUzDbcFWU=;
 b=0gf5bTX4NIQykq3iPPRZunSuSvrZWoWSo2b1NIiTagpKSMaW3qdtrw7UmeRdrKArDQE/+S
 Zy8ijWhMlujrmAIZPJRjxCHh90monbTV12KDhye6vQM/3CAQqw8JRQAdzQBwiG/t4sAVLj
 VGlEJ6vxHVjRXIiYcdNdyHl9i3CHV9mgzff5fRJV7Md00WfSlsUarMqfVzZqx0g0/sFCEG
 xHPKgvCjYezzLHm0ZxrVkOJkWlQ9+ITm9Ner24gSmKr1U37+vm+cp040VQJzXjfoPeTXFE
 2Z1+E0/StooqcZKBaNaiZO9gcjhFy0aSijMrtLORg57UfwyNDwEREhdL85JJhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1651873274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEBD3i+RCMCV6ItWgJTNpoS5Qp50+5gg+1MUzDbcFWU=;
 b=EPFGmOCZQqvpMfXX+kTEn3pMBEYvOWTDsHxx4zzYwsn3Efr3jSRiPe+y2939MMnRZZC56U
 K4PVioMmImoIJ3Dw==
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v6 15/29] x86/hpet: Add helper function
 hpet_set_comparator_periodic()
In-Reply-To: <20220506000008.30892-16-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-16-ricardo.neri-calderon@linux.intel.com>
Date: Fri, 06 May 2022 23:41:13 +0200
Message-ID: <87mtfufifa.ffs@tglx>
MIME-Version: 1.0
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 Ricardo Neri <ricardo.neri@intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> Programming an HPET channel as periodic requires setting the
> HPET_TN_SETVAL bit in the channel configuration. Plus, the comparator
> register must be written twice (once for the comparator value and once for
> the periodic value). Since this programming might be needed in several
> places (e.g., the HPET clocksource and the HPET-based hardlockup detector),
> add a helper function for this purpose.
>
> A helper function hpet_set_comparator_oneshot() could also be implemented.
> However, such function would only program the comparator register and the
> function would be quite small. Hence, it is better to not bloat the code
> with such an obvious function.

This word salad above does not provide a single reason why the periodic
programming function is required and better suited for the NMI watchdog
case and then goes on and blurbs about why a function which is not
required is not implemented. The argument about not bloating the code
with an "obvious???" function which is quite small is slightly beyond my
comprehension level.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
