Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07392C0650E
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 20:11:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D902420652
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 20:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D902420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B102712BB;
	Tue, 11 Jun 2019 20:11:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C9BB412B3
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 20:11:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6163179
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 20:11:20 +0000 (UTC)
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
	by Galois.linutronix.de with esmtpsa
	(TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1han6o-0004fr-IZ; Tue, 11 Jun 2019 22:11:06 +0200
Date: Tue, 11 Jun 2019 22:11:04 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [RFC PATCH v4 12/21] watchdog/hardlockup/hpet: Adjust timer
	expiration on the number of monitored CPUs
In-Reply-To: <1558660583-28561-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1906112205170.2214@nanos.tec.linutronix.de>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1558660583-28561-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
	SHORTCIRCUIT=-0.0001
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Stephane Eranian <eranian@google.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Ashok Raj <ashok.raj@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	David Rientjes <rientjes@google.com>, Andi Kleen <andi.kleen@intel.com>,
	Waiman Long <longman@redhat.com>, Borislav Petkov <bp@suse.de>,
	Masami Hiramatsu <mhiramat@kernel.org>, Don Zickus <dzickus@redhat.com>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Byungchul Park <byungchul.park@lge.com>, Babu Moger <Babu.Moger@amd.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Tony Luck <tony.luck@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Jacob Pan <jacob.jun.pan@intel.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Colin Ian King <colin.king@canonical.com>,
	Andrew Morton <akpm@linux-foundation.org>
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
> @@ -52,10 +59,10 @@ static void kick_timer(struct hpet_hld_data *hdata, bool force)
>  		return;
>  
>  	if (hdata->has_periodic)
> -		period = watchdog_thresh * hdata->ticks_per_second;
> +		period = watchdog_thresh * hdata->ticks_per_cpu;
>  
>  	count = hpet_readl(HPET_COUNTER);
> -	new_compare = count + watchdog_thresh * hdata->ticks_per_second;
> +	new_compare = count + watchdog_thresh * hdata->ticks_per_cpu;
>  	hpet_set_comparator(hdata->num, (u32)new_compare, (u32)period);

So with this you might get close to the point where you trip over the SMI
induced madness where CPUs vanish for several milliseconds in some value
add code. You really want to do a read back of the hpet to detect that. See
the comment in the hpet code. RHEL 7/8 allow up to 768 logical CPUs....

Thanks,

	tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
