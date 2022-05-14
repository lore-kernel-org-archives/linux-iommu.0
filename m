Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF4BC433F5
	for <iommu@archiver.kernel.org>; Sat, 14 May 2022 08:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0078B60DB7;
	Sat, 14 May 2022 08:17:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s_Y3aYVo0gKA; Sat, 14 May 2022 08:17:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D706A60B42;
	Sat, 14 May 2022 08:17:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A24E2C0032;
	Sat, 14 May 2022 08:17:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1100C002D
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 08:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C650460DB7
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 08:17:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 09AP2vzoX2ov for <iommu@lists.linux-foundation.org>;
 Sat, 14 May 2022 08:17:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3471460B42
 for <iommu@lists.linux-foundation.org>; Sat, 14 May 2022 08:17:41 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1652516259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ptxkYIfclqy5O/gMkPytM7FecBAPXApyhBHx/s6t5+k=;
 b=cHjQpeFhBi4mMqPWUFdjjdKbCNxSUbeCTq7e9TuG54QoSwZllWwAyWn/VA2bxfbp8FS79W
 lpKpONGN1xhSlu8/eUzJRYbZ8z2/7An4yFUXSfE69IHtfw3wF6lHivRNX1/x1EP43Mxg+m
 2YzOH1KhXwKXiNv80jZNKNSgxmxnjKjeDjsWmZo7PZev0MONnAMymFNV4PW0L08JGwT5Dg
 XeCV5Hvab1ALlurGE9Sq5nyeVvDP0baDIxSjf5ud747JWKgjVTe0VrA/BAmffaTatkL5Fl
 PsToyX+G9Z4WITvp+Bj9egqL+hjA9Kgbm3/OPtSDBuAAsUQm8y4Dgg3PUukvnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1652516259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ptxkYIfclqy5O/gMkPytM7FecBAPXApyhBHx/s6t5+k=;
 b=4QyQkuDjHvg4QNWDVHeMxsVLfTUC/+wKMBTajewFUyM/io2iH9gFUIPw+ugISd8SAFk2b1
 J7VmY4C7MwqIN+Bg==
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v6 15/29] x86/hpet: Add helper function
 hpet_set_comparator_periodic()
In-Reply-To: <20220513211944.GE22683@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-16-ricardo.neri-calderon@linux.intel.com>
 <87mtfufifa.ffs@tglx> <20220513211944.GE22683@ranerica-svr.sc.intel.com>
Date: Sat, 14 May 2022 10:17:38 +0200
Message-ID: <87pmkgsf31.ffs@tglx>
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

On Fri, May 13 2022 at 14:19, Ricardo Neri wrote:
> On Fri, May 06, 2022 at 11:41:13PM +0200, Thomas Gleixner wrote:
>> The argument about not bloating the code
>> with an "obvious???" function which is quite small is slightly beyond my
>> comprehension level.
>
> That obvious function would look like this:
>
> void hpet_set_comparator_one_shot(int channel, u32 delta)
> {
> 	u32 count;
>
> 	count = hpet_readl(HPET_COUNTER);
> 	count += delta;
> 	hpet_writel(count, HPET_Tn_CMP(channel));
> }

This function only works reliably when the delta is large. See
hpet_clkevt_set_next_event().

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
