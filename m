Return-Path: <SRS0=58s/=DO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD42C47095
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 16:15:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D039121707
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 16:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i3r5Nrb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D039121707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3A1D186B04;
	Wed,  7 Oct 2020 16:15:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id geAzzCcp8Dx2; Wed,  7 Oct 2020 16:15:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 29CB586AFF;
	Wed,  7 Oct 2020 16:15:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11582C016F;
	Wed,  7 Oct 2020 16:15:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27D84C0051
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 16:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0B64C86B03
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 16:15:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A8PQiDDyhfVu for <iommu@lists.linux-foundation.org>;
 Wed,  7 Oct 2020 16:15:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1A27E86AFF
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 16:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Message-ID:From:CC:To:Subject:
 Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
 Date:Sender:Reply-To:Content-ID:Content-Description;
 bh=Q6S7G7tGIHEqMVdJUjNSVW5hIw+z7ajO0YGWhkaXjSI=; b=i3r5Nrb74EDsnzTQBZt426eZe6
 lhKaUTzwFykgLMHJIO9OgQlL4q1LwPDiWCtoZkxbt+rOyshpP0Sd2sFad9uGV0Za1Qr7L/9U6jKE2
 sr6l2Fi4NRgzf++ci9sF7M8RzzIzflkeKGEODWBKiWe1qJWU53ZP3e2rTYxAbmDhIQ6NINBfu0qmx
 9pX3HbVZQgxWh9kpWoyD60hm8ze4PSznFcKIB8mPZpEmKNNFw+jIEyjS7TTKAuIuIfVRrBmV1CxUO
 rNkSnSsEyKmpx7F3DACHLp42gF+HxNWNHGhPtZOw/t9UTC4ifHPMq+VNmtjm3lkO+26b037kcV+7U
 pIE+/r6w==;
Received: from [2001:8b0:10b:1:ad95:471b:fe64:9cc3]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQC6Y-0005hC-Mm; Wed, 07 Oct 2020 16:15:50 +0000
Date: Wed, 07 Oct 2020 17:15:48 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <877ds23txo.fsf@nanos.tec.linutronix.de>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
 <20201005152856.974112-10-dwmw2@infradead.org>
 <87d01v58bw.fsf@nanos.tec.linutronix.de>
 <d34efce9ca5a4a9d8d8609f872143e306bf5ee98.camel@infradead.org>
 <874kn65h0r.fsf@nanos.tec.linutronix.de>
 <F9476D19-3D08-4CE6-A535-6C1D2E9BA88D@infradead.org>
 <87imbm3zdq.fsf@nanos.tec.linutronix.de>
 <1b1fda3079627748e1f5084ddae8a686258c78d9.camel@infradead.org>
 <877ds23txo.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Subject: Re: [PATCH 10/13] x86/irq: Limit IOAPIC and MSI domains' affinity
 without IR
To: Thomas Gleixner <tglx@linutronix.de>,x86@kernel.org
From: David Woodhouse <dwmw2@infradead.org>
Message-ID: <244EB899-6273-416C-8376-68FBCE0DA47A@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 merlin.infradead.org. See http://www.infradead.org/rpr.html
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 iommu <iommu@lists.linux-foundation.org>, linux-hyperv@vger.kernel.org,
 kvm <kvm@vger.kernel.org>
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



On 7 October 2020 17:02:59 BST, Thomas Gleixner <tglx@linutronix.de> wrote:
>On Wed, Oct 07 2020 at 15:23, David Woodhouse wrote:
>> On Wed, 2020-10-07 at 16:05 +0200, Thomas Gleixner wrote:
>>> On Wed, Oct 07 2020 at 14:08, David Woodhouse wrote:
>>> > On 7 October 2020 13:59:00 BST, Thomas Gleixner
><tglx@linutronix.de> wrote:
>>> > > On Wed, Oct 07 2020 at 08:48, David Woodhouse wrote:
>>> > > > To fix *that* case, we really do need the whole series giving
>us per-
>>> > > > domain restricted affinity, and to use it for those
>MSIs/IOAPICs that
>>> > > > the IRQ remapping doesn't cover.
>>> > > 
>>> > > Which do not exist today.
>>> > 
>>> > Sure. But at patch 10/13 into this particular patch series, it
>*does*
>>> > exist.
>>> 
>>> As I told you before: Your ordering is wrong. We do not introduce
>bugs
>>> first and then fix them later ....
>>
>> I didn't introduce that bug; it's been there for years. Fixing it
>> properly requires per-irqdomain affinity limits.
>>
>> There's a cute little TODO at least in the Intel irq-remapping
>driver,
>> noting that we should probably check if there are any IOAPICs that
>> aren't in the scope of any DRHD at all. But that's all.
>
>So someone forgot to remove the cute little TODO when this was added:
>
>       if (parse_ioapics_under_ir()) {
>                pr_info("Not enabling interrupt remapping\n");
>                goto error;
>        }

And HPET, and PCI devices including those that might be hotplugged in future and not be covered by any extant IOMMU's scope?

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
