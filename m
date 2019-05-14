Return-Path: <SRS0=TkeE=TO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B02C04AB4
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:24:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0680821473
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pRBtj6f/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0680821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C6EE9D67;
	Tue, 14 May 2019 14:24:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B8A275AA
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:24:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1CAB782C
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209;
	h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+pHfppsKADb8o6U6hdDNOJ8jDyczo+OIxy2VLKb7Gg4=;
	b=pRBtj6f/JLam2sMyBn4ZdgAYKS
	zV9Vex9eWiisqNd2+PQluuaGecaLSPF+AtgTLqPGXsfieNdnu19a7JnmpgnlKxwX7gZXKI4q6rO1a
	0JdeJU/m/bn4Aq0otIxNfKN1/Fv2AU76Jryq56VRQ8bN5eWCytZ0sK6QLIpf95AipfO1wd3r1owgs
	r8cRvcdoEBtcgeOqxV1EeloCdDEFJhfaNYi3R3wJcVJEzLof6bvXa0E+odtqfqEkXetKlAo/t893/
	wpPR180CGByLo06yNxyC4YZ+S+A+jhM0hwynYCR1vvQYAV6DMvLm8vyXhNRn8qoL8dyegdukSx4A6
	lSWSCV+A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16]
	helo=midway.dunlab)
	by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hQYLP-0008K4-CU; Tue, 14 May 2019 14:23:52 +0000
Subject: Re: [RFC PATCH v3 03/21] x86/hpet: Calculate ticks-per-second in a
	separate function
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@suse.de>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1557842534-4266-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <25922025-d551-0865-b364-b53ef34e6b6a@infradead.org>
Date: Tue, 14 May 2019 07:23:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557842534-4266-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
Content-Language: en-US
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Tony Luck <tony.luck@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	iommu@lists.linux-foundation.org,
	Philippe Ombredanne <pombredanne@nexb.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 5/14/19 7:01 AM, Ricardo Neri wrote:
> It is easier to compute the expiration times of an HPET timer by using
> its frequency (i.e., the number of times it ticks in a second) than its
> period, as given in the capabilities register.
> 
> In addition to the HPET char driver, the HPET-based hardlockup detector
> will also need to know the timer's frequency. Thus, create a common
> function that both can use.
> 
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Andi Kleen <andi.kleen@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Cc: x86@kernel.org
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  drivers/char/hpet.c  | 31 ++++++++++++++++++++++++-------
>  include/linux/hpet.h |  1 +
>  2 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index d0ad85900b79..bdcbecfdb858 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -836,6 +836,29 @@ static unsigned long hpet_calibrate(struct hpets *hpetp)
>  	return ret;
>  }
>  
> +u64 hpet_get_ticks_per_sec(u64 hpet_caps)
> +{
> +	u64 ticks_per_sec, period;
> +
> +	period = (hpet_caps & HPET_COUNTER_CLK_PERIOD_MASK) >>
> +		 HPET_COUNTER_CLK_PERIOD_SHIFT; /* fs, 10^-15 */
> +
> +	/*
> +	 * The frequency is the reciprocal of the period. The period is given
> +	 * femtoseconds per second. Thus, prepare a dividend to obtain the

	 * in femtoseconds per second.

> +	 * frequency in ticks per second.
> +	 */
> +
> +	/* 10^15 femtoseconds per second */
> +	ticks_per_sec = 1000000000000000uLL;

	ULL is overwhelmingly used in the kernel.

> +	ticks_per_sec += period >> 1; /* round */
> +
> +	/* The quotient is put in the dividend. We drop the remainder. */
> +	do_div(ticks_per_sec, period);
> +
> +	return ticks_per_sec;
> +}
> +
>  int hpet_alloc(struct hpet_data *hdp)
>  {
>  	u64 cap, mcfg;
> @@ -844,7 +867,6 @@ int hpet_alloc(struct hpet_data *hdp)
>  	struct hpets *hpetp;
>  	struct hpet __iomem *hpet;
>  	static struct hpets *last;
> -	unsigned long period;
>  	unsigned long long temp;
>  	u32 remainder;
>  
> @@ -894,12 +916,7 @@ int hpet_alloc(struct hpet_data *hdp)
>  
>  	last = hpetp;
>  
> -	period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
> -		HPET_COUNTER_CLK_PERIOD_SHIFT; /* fs, 10^-15 */
> -	temp = 1000000000000000uLL; /* 10^15 femtoseconds per second */
> -	temp += period >> 1; /* round */
> -	do_div(temp, period);
> -	hpetp->hp_tick_freq = temp; /* ticks per second */
> +	hpetp->hp_tick_freq = hpet_get_ticks_per_sec(cap);
>  
>  	printk(KERN_INFO "hpet%d: at MMIO 0x%lx, IRQ%s",
>  		hpetp->hp_which, hdp->hd_phys_address,
> diff --git a/include/linux/hpet.h b/include/linux/hpet.h
> index 8604564b985d..e7b36bcf4699 100644
> --- a/include/linux/hpet.h
> +++ b/include/linux/hpet.h
> @@ -107,5 +107,6 @@ static inline void hpet_reserve_timer(struct hpet_data *hd, int timer)
>  }
>  
>  int hpet_alloc(struct hpet_data *);
> +u64 hpet_get_ticks_per_sec(u64 hpet_caps);
>  
>  #endif				/* !__HPET__ */
> 


-- 
~Randy
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
