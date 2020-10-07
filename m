Return-Path: <SRS0=58s/=DO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD54C41604
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 14:05:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37BA6205F4
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 14:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b6EMJ38h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WbLYp+LR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BA6205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D8B5C86365;
	Wed,  7 Oct 2020 14:05:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HwXB1EeUC4hR; Wed,  7 Oct 2020 14:05:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3BE83862AB;
	Wed,  7 Oct 2020 14:05:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C207C07FF;
	Wed,  7 Oct 2020 14:05:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 947EFC0051
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 14:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 40640871B1
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 14:05:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Wr1PsR5hSMh for <iommu@lists.linux-foundation.org>;
 Wed,  7 Oct 2020 14:05:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 16CDC871AC
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 14:05:24 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1602079522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LzEHXmRA/+S5FieraB+lOb+37CIRymPBPLiuuZ72Uwk=;
 b=b6EMJ38hmOqqUdMLN9WMFDwfP4fMnCTTl8fHq1oNh5Fn7xxrab46j41h8HKuigv/4EySCn
 u28RtIZIYyAYA19YhTq72UPlwsYHxjB4dngvqX4XWiwgvw94/cLbMRqJ1TagClt/+dt0T5
 n0Mx+im9bz+jT0YtBkcNuXOWeqZtPMLYrV3hlpxAOjhmgMsxEzH/IkDaQtJAacFAKEnC4S
 0F9WzKxw4CWmG28NiL4DYWo/PBBVlC37qG2dqkSOjCiPwVpzbWHEFQhCB/7k50BWceRCC3
 5V5eGsE+H1qYqi/npGRe9m4CCa//I4ZSUnQiTyxPLDTtlWhoVJfx2wt8znrz1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1602079522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LzEHXmRA/+S5FieraB+lOb+37CIRymPBPLiuuZ72Uwk=;
 b=WbLYp+LR99UXVn5/klOP92H7Pro/dNqWl0O1lh22POQqCRrntPUpVMGuc5Rvzh48CCVDUv
 urLq7f177+6X/1AQ==
To: David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
Subject: Re: [PATCH 10/13] x86/irq: Limit IOAPIC and MSI domains' affinity
 without IR
In-Reply-To: <F9476D19-3D08-4CE6-A535-6C1D2E9BA88D@infradead.org>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
 <20201005152856.974112-10-dwmw2@infradead.org>
 <87d01v58bw.fsf@nanos.tec.linutronix.de>
 <d34efce9ca5a4a9d8d8609f872143e306bf5ee98.camel@infradead.org>
 <874kn65h0r.fsf@nanos.tec.linutronix.de>
 <F9476D19-3D08-4CE6-A535-6C1D2E9BA88D@infradead.org>
Date: Wed, 07 Oct 2020 16:05:21 +0200
Message-ID: <87imbm3zdq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
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

On Wed, Oct 07 2020 at 14:08, David Woodhouse wrote:
> On 7 October 2020 13:59:00 BST, Thomas Gleixner <tglx@linutronix.de> wrote:
>>On Wed, Oct 07 2020 at 08:48, David Woodhouse wrote:
>>> To fix *that* case, we really do need the whole series giving us per-
>>> domain restricted affinity, and to use it for those MSIs/IOAPICs that
>>> the IRQ remapping doesn't cover.
>>
>>Which do not exist today.
>
> Sure. But at patch 10/13 into this particular patch series, it *does*
> exist.

As I told you before: Your ordering is wrong. We do not introduce bugs
first and then fix them later ....

>>And all of this is completely wrong to begin with.
>>
>>The information has to property of the relevant irq domains and the
>>hierarchy allows you nicely to retrieve it from there instead of
>>sprinkling this all over the place.
>
> No. This is not a property of the parent domain per se. Especially if
> you're thinking that we could inherit the affinity mask from the
> parent, then twice no.
>
> This is a property of the MSI domain itself, and how many bits of
> destination ID the hardware at *this* level can interpret and pass on
> to the parent domain.

Errm what?

The MSI domain does not know anything about what the underlying domain
can handle and it shouldn't.

If MSI is on top of remapping then the remapping domain defines what the
MSI domain can do and not the other way round. Ditto for the non
remapped case in which the vector domain decides.

The top most MSI irq chip does not even have a compose function, neither
for the remap nor for the vector case. The composition is done by the
parent domain from the data which the parent domain constructed. Same
for the IO/APIC just less clearly separated.

The top most chip just takes what the underlying domain constructed and
writes it to the message store, because that's what the top most chip
controls. It does not control the content.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
