Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249E8C433F5
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 19:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADC5160D70;
	Fri,  6 May 2022 19:48:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sRTHRpwF3u2U; Fri,  6 May 2022 19:48:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 923F360D57;
	Fri,  6 May 2022 19:48:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66535C0039;
	Fri,  6 May 2022 19:48:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48ADCC002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 19:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2FE8141507
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 19:48:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="HioOdTso";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="PhVvmh62"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4yAZAnffYJZF for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 19:48:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C5C0041496
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 19:48:32 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1651866508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=obKDPm1us147PjbB0DX4AOLNMPgBymj9mmgDJjujsNQ=;
 b=HioOdTsoFc6QL4Q5ukxv+Ntea8dHeHBk4X2FT+oa3bbwVlhaaalijyMz3Ud42vI0Xz+Pm5
 5uNcxKXmjg9OVSDh0Dt4tYZQOtxWfVFjjhHrSpCQezPQxTgdp4FY13dtV9rXwDevFIpXv6
 muaKmsTE1yrW4JvMj8a2VNOKwIw/8hiF4TH9d66KAra9PGXIcwgS+d6jJ9pIjFAO9TVsmJ
 7WIXTpeAKzbt2/hokUTls/YOcFf5INx190TqnegdhNw+Iz7enysvt7LGD9aYjh0IdLT2O1
 F9KOHoFhYxx5YN++nCtmpnJKTcTtL7nhOGwRsnjxvDLfRK1XRQCtPb9oaZBu4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1651866508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=obKDPm1us147PjbB0DX4AOLNMPgBymj9mmgDJjujsNQ=;
 b=PhVvmh62AnNYLXZZs9XTvL0zSLIZOMjOmiHCiiYPPKnVJ9DouHuXu7vrlN828CvNAlUl2q
 /dCD5SBWUsoH+LDA==
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v6 01/29] irq/matrix: Expose functions to allocate the
 best CPU for new vectors
In-Reply-To: <20220506000008.30892-2-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-2-ricardo.neri-calderon@linux.intel.com>
Date: Fri, 06 May 2022 21:48:28 +0200
Message-ID: <878rreh27n.ffs@tglx>
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

Ricardo,

On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> Certain types of interrupts, such as NMI, do not have an associated vector.
> They, however, target specific CPUs. Thus, when assigning the destination
> CPU, it is beneficial to select the one with the lowest number of
> vectors.

Why is that beneficial especially in the context of a NMI watchdog which
then broadcasts the NMI to all other CPUs?

That's wishful thinking perhaps, but I don't see any benefit at all.

> Prepend the functions matrix_find_best_cpu_managed() and
> matrix_find_best_cpu_managed()

The same function prepended twice becomes two functions :)

> with the irq_ prefix and expose them for
> IRQ controllers to use when allocating and activating vector-less IRQs.

There is no such thing like a vectorless IRQ. NMIs have a vector. Can we
please describe facts and not pulled out of thin air concepts which do
not exist?

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
