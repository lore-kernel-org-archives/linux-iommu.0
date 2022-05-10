Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75383C433F5
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 11:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3908440364;
	Tue, 10 May 2022 11:44:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SoaJCG-ZPAZr; Tue, 10 May 2022 11:44:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0F0EC400FB;
	Tue, 10 May 2022 11:44:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF9AFC0039;
	Tue, 10 May 2022 11:44:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D790C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 11:44:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C87181460
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 11:44:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="iiIyquw+";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="wrd2WsMh"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EFTO0LSa9vhn for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:44:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 226358143B
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 11:44:09 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1652183045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Js8RDp7iMnj24JVY5ETKpHQgMOnO+QR2UvUOw/t3NVI=;
 b=iiIyquw+8QYZcovxorjqRFjfwhtMfLsHJEqe7bb762UGT/v/l/uDU2MlyH5t4U6gak6twB
 cCyHPEaUDEHU0enPu0J4DBw0J15rjARHL269aYiMpCupYu3BwyjP2tKIEcoTzzuFT76fSs
 Z0yC68PLfuFj70wdQZ68UUH/P13qMaOf9EUpMqUg6EgaWEupFN2HWfhg6OWSZyr0hg/ZGt
 Qzi4v4cd/H7wytmGiF+HHWJ9XcNU3cDxrdhX3LKr8Dq8hqBErcTwz/b/6JL8w7xTiMyZdu
 TWiYR1JW/491ynSImOymZIIK8iEtjvf2oz1jdx2qz/HmDYNZXQ9LjnzhjQSgpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1652183045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Js8RDp7iMnj24JVY5ETKpHQgMOnO+QR2UvUOw/t3NVI=;
 b=wrd2WsMhhsrFIarhn4h+pO3O6mNNt4p+QTgQfzqOJMhou7WWpPXvvVvQJWm3tmm+PLi6JN
 3qRFd4zzo70zIfDQ==
To: Nicholas Piggin <npiggin@gmail.com>, Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v6 28/29] x86/tsc: Restart NMI watchdog after refining
 tsc_khz
In-Reply-To: <1652180070.1r874kr0tg.astroid@bobo.none>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-29-ricardo.neri-calderon@linux.intel.com>
 <1652180070.1r874kr0tg.astroid@bobo.none>
Date: Tue, 10 May 2022 13:44:05 +0200
Message-ID: <87ilqdpq7u.ffs@tglx>
MIME-Version: 1.0
Cc: "Ravi V.
 Shankar" <ravi.v.shankar@intel.com>, Andi Kleen <ak@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, Ricardo Neri <ricardo.neri@intel.com>,
 iommu@lists.linux-foundation.org, Tony Luck <tony.luck@intel.com>,
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

On Tue, May 10 2022 at 21:16, Nicholas Piggin wrote:
> Excerpts from Ricardo Neri's message of May 6, 2022 10:00 am:
>> +	/*
>> +	 * If in use, the HPET hardlockup detector relies on tsc_khz.
>> +	 * Reconfigure it to make use of the refined tsc_khz.
>> +	 */
>> +	lockup_detector_reconfigure();
>
> I don't know if the API is conceptually good.
>
> You change something that the lockup detector is currently using, 
> *while* the detector is running asynchronously, and then reconfigure
> it. What happens in the window? If this code is only used for small
> adjustments maybe it does not really matter but in principle it's
> a bad API to export.
>
> lockup_detector_reconfigure as an internal API is okay because it
> reconfigures things while the watchdog is stopped [actually that
> looks untrue for soft dog which uses watchdog_thresh in
> is_softlockup(), but that should be fixed].
>
> You're the arch so you're allowed to stop the watchdog and configure
> it, e.g., hardlockup_detector_perf_stop() is called in arch/.
>
> So you want to disable HPET watchdog if it was enabled, then update
> wherever you're using tsc_khz, then re-enable.

The real question is whether making this refined tsc_khz value
immediately effective matters at all. IMO, it does not because up to
that point the watchdog was happily using the coarse calibrated value
and the whole use TSC to assess whether the HPET fired mechanism is just
a guestimate anyway. So what's the point of trying to guess 'more
correct'.

Thanks,

        tglx

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
