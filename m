Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CEDC433F5
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 13:45:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE4561353
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 13:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8EE4561353
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5ED1283AEF;
	Thu, 30 Sep 2021 13:45:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 50MppuBzCk07; Thu, 30 Sep 2021 13:45:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 12B94837C0;
	Thu, 30 Sep 2021 13:45:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4E97C0011;
	Thu, 30 Sep 2021 13:45:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3281C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 13:45:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E32606071F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 13:45:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e_LOMj1kRfI7 for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 13:45:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 768C4607DE
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 13:45:09 +0000 (UTC)
Received: by mail.wantstofly.org (Postfix, from userid 1000)
 id 065FF7F530; Thu, 30 Sep 2021 16:45:06 +0300 (EEST)
Date: Thu, 30 Sep 2021 16:45:06 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH,RFC] iommu/amd: Recover from event log overflow
Message-ID: <YVW/YhaxkI0GfPHO@wantstofly.org>
References: <YSEaIloMR1VAMXLo@wantstofly.org>
 <YVLWKtc3ZaL5fvq9@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YVLWKtc3ZaL5fvq9@8bytes.org>
Cc: iommu@lists.linux-foundation.org
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

On Tue, Sep 28, 2021 at 10:45:30AM +0200, Joerg Roedel wrote:

> Hi Lennert,

Hi Joerg,

Thanks for your feedback!


> > +/*
> > + * This function restarts event logging in case the IOMMU experienced
> > + * an event log buffer overflow.
> > + */
> > +void amd_iommu_restart_event_logging(struct amd_iommu *iommu)
> > +{
> > +	iommu_feature_disable(iommu, CONTROL_EVT_LOG_EN);
> > +	iommu_feature_enable(iommu, CONTROL_EVT_LOG_EN);
> > +}
> 
> A few more things need to happen here. First of all head and tail are
> likely equal when the event buffer overflows, so the events will not be
> polled and reported.

I applied the following change on top of my patch, to check the state
of the event log ring buffer when we enter the IRQ handler with an
overflow condition pending:

--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -752,6 +752,18 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
        struct amd_iommu *iommu = (struct amd_iommu *) data;
        u32 status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
 
+       if (status & MMIO_STATUS_EVT_OVERFLOW_INT_MASK) {
+               u32 events;
+
+               events = readl(iommu->mmio_base + MMIO_EVT_TAIL_OFFSET) -
+                        readl(iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
+               if (events & 0x80000000)
+                       events += EVT_BUFFER_SIZE;
+               events /= EVENT_ENTRY_SIZE;
+
+               pr_info("Overflow with %d events queued\n", events);
+       }
+
        while (status & AMD_IOMMU_INT_MASK) {
                /* Enable interrupt sources again */
                writel(AMD_IOMMU_INT_MASK,

And that gives me:

[   33.304821] AMD-Vi: Overflow with 511 events queued
[   35.304812] AMD-Vi: Overflow with 511 events queued
[   39.304791] AMD-Vi: Overflow with 511 events queued
[   40.304792] AMD-Vi: Overflow with 511 events queued
[   41.304782] AMD-Vi: Overflow with 511 events queued
[   44.009920] AMD-Vi: Overflow with 511 events queued
[   45.304768] AMD-Vi: Overflow with 511 events queued
[   46.304782] AMD-Vi: Overflow with 511 events queued
[   46.385028] AMD-Vi: Overflow with 511 events queued
[   51.304733] AMD-Vi: Overflow with 511 events queued
[   53.318892] AMD-Vi: Overflow with 511 events queued
[   60.304681] AMD-Vi: Overflow with 511 events queued
[   63.304676] AMD-Vi: Overflow with 511 events queued

In other words, it seems that the hardware considers the event log to
be full when there's still one free entry in the ring buffer, and it
will not actually fill up the last free entry and make the head and
tail pointer equal by doing so.  This seems consistent across Ryzen
3700X, Ryzen 5950X, EPYC 3151, EPYC 3251, RX-421ND, RX-216TD.

The docs talk about "When the Event Log has overflowed", but they don't
define exactly when that happens (i.e. when tail becomes equal to head or
one entry before that), but I did find this phrase that talks about the
overflow condition:

	The host software must make space in the event log after an
	overflow by reading entries (by adjusting the head pointer) or
	by resizing the log.  Event logging may then be restarted.

This seems to suggest that the hardware will never consume the last
entry in the ring buffer and thereby advance tail to be equal to head,
because if it would, then there would be no need for "reading entries
(by adjusting the head pointer)" to make space in the event log buffer,
because the 'empty' and 'full' conditions would be indistinguishable
in that case.

If there _is_ some variation of the hardware out there that does
advance the tail pointer to coincide with the head pointer when there
are already N-1 entries in the log and it has one more entry to write,
then this patch would still work OK on such hardware -- we would just
lose a few more events in that case than we otherwise would, but the
point of the patch is to be able to recover after a burst of I/O page
faults, at which point we've very likely already lost some events, so
I think such hypothetical lossage would be acceptable, given that none
of the hardware I have access to seems to behave that way and from the
wording in the docs it is unlikely to behave that way.

In fact, thinking about it a bit more, by the time an event log
overflow condition is handled, it is actually possible for the event
log ring buffer to be empty and not full.  Imagine this scenario:

- We enter the IRQ handler, EVT status bit is set, the ring buffer is
  full but it hasn't overflowed yet, so OVERFLOW is not set.

- We read interrupt status and clear the EVT bit.

- Before we call iommu_poll_events(), another event comes in, which
  causes the OVERFLOW flag to be set, since we haven't advanced head yet.

- iommu_poll_events() is called, and it processes all events in the
  ring buffer, which is now empty (and will remain empty, since the
  overflow bit is set).

- The MMIO_STATUS_OFFSET re-reading at the end of the IRQ loop finds
  the OVERFLOW bit set and loops back to the beginning of the loop.

- We signal status & MMIO_STATUS_EVT_OVERFLOW_INT_MASK in the next
  loop iteration, but there are actually no events in the ring buffer
  anymore, since we cleared those all out in the previous loop.

In other words, even if there is hardware out there that uses up every
entry in the ring buffer (and will thus let tail become equal to head),
on such hardware we cannot be sure that every entry in the ring buffer
is valid by the time we signal the overflow condition, as it might also
be the case that the ring buffer is now entirely empty and not full,
and the overflow handling code therefore cannot just go ahead and
report every entry in the ring buffer when an overflow happens.

(We _could_ deal with this by reading head and tail and then re-reading
the interrupt status bit after that to check for an overflow condition
once again, but I think that that's probably more trouble than it's
worth, given that we're talking about hypothetical hardware here.  The
way I did it is probably the simplest way of handling overflows, I think.)


> And next it is also a good idea to reset the head and tail pointers of
> the event log to 0 after the events have been polled.

What difference would this make?  It would cost two MMIO writes, and I
don't see what the advantage of doing this would be, as it's fine for
the IOMMU to resume writing events at any index in the ring buffer, and
we will handle that just fine.


Some more testing suggests that this would be a good change to make:  ;-)

@@ -775,7 +775,7 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
 #endif
 
                if (status & MMIO_STATUS_EVT_OVERFLOW_INT_MASK) {
-                       pr_info("AMD-Vi: IOMMU event log overflow\n");
+                       pr_info_ratelimited("IOMMU event log overflow\n");
                        amd_iommu_restart_event_logging(iommu);
                }
 

I can resubmit the patch with that change applied.


Thanks,
Lennert
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
