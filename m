Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73469C433EF
	for <iommu@archiver.kernel.org>; Sat, 14 May 2022 14:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19A9260806;
	Sat, 14 May 2022 14:04:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2LK1wwy8iefI; Sat, 14 May 2022 14:04:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3080860D66;
	Sat, 14 May 2022 14:04:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04A37C0039;
	Sat, 14 May 2022 14:04:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEFBCC002D
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 14:04:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9855A83E38
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 14:04:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="LHg9QKXY";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="Wccmxkq4"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8MMtS60_2mdG for <iommu@lists.linux-foundation.org>;
 Sat, 14 May 2022 14:04:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F3D3D83E17
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 14:04:21 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1652537058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KHOIys2lUf5zRjBsSOUOWEZGDpRLn7fWHLTsPdw7f4U=;
 b=LHg9QKXYPrV5G6DpjGAQUj+qfPDVnxCZetHDBfVfH+LeqCXHlJAbKb8WllnreP7S3bNkfN
 4KeQuJ7ASL57SIcHW5e0/ESjXmm27lFLndKPfS7ueia9+AnyVBizDI/I8cVvjyBodAV73C
 KuR6VX1IdjUZkcx7JJgKy1PXR652V3bzFUHb8gWx45QdbM32XdC1pSbLSU5kSVZNHK9CnN
 sYrvtcF6hGd4esjm7UwZp0Jjc3XOn+pTPW63vJAVYDRvjZI2qtcicolrLDuGi3y01KBsGF
 OHVzd6Qv0y0sYGOnTDmWoNHy2dKwZHGvbkDMdo4G48fllgMyGiB+2V0HQQZJAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1652537058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KHOIys2lUf5zRjBsSOUOWEZGDpRLn7fWHLTsPdw7f4U=;
 b=Wccmxkq4ead+q0uv0ac7dDXkCM4gzRqejs0vLHNPNyx0+CzSuVgKfK7pCPPycJh8YJUxj4
 LicVDTm3UgM/NtDA==
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v6 22/29] x86/watchdog/hardlockup: Add an HPET-based
 hardlockup detector
In-Reply-To: <20220513221650.GA8691@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-23-ricardo.neri-calderon@linux.intel.com>
 <877d6uref8.ffs@tglx> <20220513221650.GA8691@ranerica-svr.sc.intel.com>
Date: Sat, 14 May 2022 16:04:17 +0200
Message-ID: <875ym8rz1a.ffs@tglx>
MIME-Version: 1.0
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 Ricardo Neri <ricardo.neri@intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
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

On Fri, May 13 2022 at 15:16, Ricardo Neri wrote:
> On Mon, May 09, 2022 at 04:03:39PM +0200, Thomas Gleixner wrote:
>> > +			/* If we are here, IPI shorthands are enabled. */
>> > +			apic->send_IPI_allbutself(NMI_VECTOR);
>> 
>> So if the monitored cpumask is a subset of online CPUs, which is the
>> case when isolation features are enabled, then you still send NMIs to
>> those isolated CPUs. I'm sure the isolation folks will be enthused.
>
> Yes, I acknowledged this limitation in the cover letter. I should also update
> Documentation/admin-guide/lockup-watchdogs.rst.
>
> This patchset proposes the HPET NMI watchdog as an opt-in feature.
>
> Perhaps the limitation might be mitigated by adding a check for non-housekeeping
> and non-monitored CPUs in exc_nmi(). However, that will not eliminate the
> problem of isolated CPUs also getting the NMI.

Right. It's a mess...
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
