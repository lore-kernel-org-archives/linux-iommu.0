Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6D9C3279D
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 21:07:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCE92087E
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 21:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gyjSY0Fp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCE92087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 840C421511;
	Tue,  6 Oct 2020 21:07:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tCnhEYZmQte0; Tue,  6 Oct 2020 21:07:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1FBD52041D;
	Tue,  6 Oct 2020 21:07:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10F3DC07FF;
	Tue,  6 Oct 2020 21:07:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88E35C0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 21:07:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 770F8867E2
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 21:07:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jE65SNkbRR1g for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 21:07:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A4530867D9
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 21:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Message-ID:From:CC:To:Subject:
 Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
 Date:Sender:Reply-To:Content-ID:Content-Description;
 bh=raBJSUw2Pij7PT/rmhEwVTTdaxcjc+zHVTOGifxTEq0=; b=gyjSY0FpzhPBu92z/xXp6in+HW
 CNRn7wm1Ue5GnjypviGr/n6WwXPtKA3mLrAhl629I0lDHj1gOQmdh7AnTFiM4uyVr8g+zBAobtiw1
 oMNcsgyuAAnLIN1FJpsr5D55fQc+neHiaDLDlOQ6B61p8AG5Lu2/5XVNcgFR9yR38ISnSR2NX9iV2
 A0Bk+bwYFEWaZOe+2W2ZGokjAqbVYgTscw8RfHWrWTLpV+1Tc5VNC12DC0GGKPYh5u1sZ+3Ir9I+X
 WaA9qVsjoNSA713IFdYBe01Qli0aJShZkySZFpr/eB1fNxyW/hRM5E/aJpQ3G16bttEqpKW+0cPe/
 hbi0nacA==;
Received: from [2001:8b0:10b:1:ad95:471b:fe64:9cc3]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPuBF-0003ga-DY; Tue, 06 Oct 2020 21:07:29 +0000
Date: Tue, 06 Oct 2020 22:07:26 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <87r1qb5ash.fsf@nanos.tec.linutronix.de>
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
 <20201005152856.974112-5-dwmw2@infradead.org>
 <87r1qb5ash.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Subject: Re: [PATCH 05/13] genirq: Prepare for default affinity to be passed
 to __irq_alloc_descs()
To: Thomas Gleixner <tglx@linutronix.de>,x86@kernel.org
From: David Woodhouse <dwmw2@infradead.org>
Message-ID: <BC75F5DC-BA63-46D6-B273-E30EEAA3D989@infradead.org>
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



On 6 October 2020 22:01:18 BST, Thomas Gleixner <tglx@linutronix.de> wrote:
>On Mon, Oct 05 2020 at 16:28, David Woodhouse wrote:
>>  
>>  #else /* CONFIG_SMP */
>>  
>> +#define irq_default_affinity (NULL)
>
>...
>
>>  static int alloc_descs(unsigned int start, unsigned int cnt, int
>node,
>>  		       const struct irq_affinity_desc *affinity,
>> +		       const struct cpumask *default_affinity,
>>  		       struct module *owner)
>>  {
>>  	struct irq_desc *desc;
>>  	int i;
>>  
>>  	/* Validate affinity mask(s) */
>> +	if (!default_affinity || cpumask_empty(default_affinity))
>> +		return -EINVAL;
>
>How is that supposed to work on UP?

Hm, good point.

>Aside of that I really hate to have yet another argument just
>because.

Yeah, I was trying to avoid having to allocate a whole array of irq_affinity_desc just to fill them all in with the same default.

But perhaps I need to treat the "affinity_max" like we do cpu_online_mask, and allow affinity to be set even to offline/unreachable CPUs at this point. Then we can be more relaxed about the default affinities.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
