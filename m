Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8B2C31E4E
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 18:17:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B432177E
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 18:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B432177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DF044168F;
	Fri, 14 Jun 2019 18:17:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 28B8B143D
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 18:17:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7E7A97C3
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 18:17:40 +0000 (UTC)
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
	by Galois.linutronix.de with esmtpsa
	(TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hbqlM-0006Wc-Mn; Fri, 14 Jun 2019 20:17:20 +0200
Date: Fri, 14 Jun 2019 20:17:14 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [RFC PATCH v4 04/21] x86/hpet: Add hpet_set_comparator() for
	periodic and one-shot modes
In-Reply-To: <1558660583-28561-5-git-send-email-ricardo.neri-calderon@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1906142010230.1760@nanos.tec.linutronix.de>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1558660583-28561-5-git-send-email-ricardo.neri-calderon@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
	SHORTCIRCUIT=-0.0001
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
	Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	iommu@lists.linux-foundation.org, Tony Luck <tony.luck@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andi Kleen <andi.kleen@intel.com>, Borislav Petkov <bp@suse.de>,
	Ingo Molnar <mingo@kernel.org>
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

On Thu, 23 May 2019, Ricardo Neri wrote:
> +/**
> + * hpet_set_comparator() - Helper function for setting comparator register
> + * @num:	The timer ID
> + * @cmp:	The value to be written to the comparator/accumulator
> + * @period:	The value to be written to the period (0 = oneshot mode)
> + *
> + * Helper function for updating comparator, accumulator and period values.
> + *
> + * In periodic mode, HPET needs HPET_TN_SETVAL to be set before writing
> + * to the Tn_CMP to update the accumulator. Then, HPET needs a second
> + * write (with HPET_TN_SETVAL cleared) to Tn_CMP to set the period.
> + * The HPET_TN_SETVAL bit is automatically cleared after the first write.
> + *
> + * For one-shot mode, HPET_TN_SETVAL does not need to be set.
> + *
> + * See the following documents:
> + *   - Intel IA-PC HPET (High Precision Event Timers) Specification
> + *   - AMD-8111 HyperTransport I/O Hub Data Sheet, Publication # 24674
> + */
> +void hpet_set_comparator(int num, unsigned int cmp, unsigned int period)
> +{
> +	if (period) {
> +		unsigned int v = hpet_readl(HPET_Tn_CFG(num));
> +
> +		hpet_writel(v | HPET_TN_SETVAL, HPET_Tn_CFG(num));
> +	}
> +
> +	hpet_writel(cmp, HPET_Tn_CMP(num));
> +
> +	if (!period)
> +		return;

TBH, I hate this conditional handling. What's wrong with two functions?

> +
> +	/*
> +	 * This delay is seldom used: never in one-shot mode and in periodic
> +	 * only when reprogramming the timer.
> +	 */
> +	udelay(1);
> +	hpet_writel(period, HPET_Tn_CMP(num));
> +}
> +EXPORT_SYMBOL_GPL(hpet_set_comparator);

Why is this exported? Which module user needs this?

Thanks,

	tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
