Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337E4C433F5
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 23:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEC0D82849;
	Fri, 13 May 2022 23:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ryH5-Qz98E-I; Fri, 13 May 2022 23:13:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F5BD826AA;
	Fri, 13 May 2022 23:13:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72BE5C0032;
	Fri, 13 May 2022 23:13:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8430BC002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 23:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5DCDB60AD1
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 23:13:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id THYLzuzJMXF7 for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 23:13:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9039607FE
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 23:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652483586; x=1684019586;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RwN3h2frQEmuTLpALiwJVKiux9iit8+Y3qd7tVOSlJg=;
 b=fxmXik6QJGG2xgOwrO8vrWaONEC4D1f4qqzWNqk3NVF7ODugy+oGqFeW
 cgRGxbXUsqSGRWNXerAlwzB0c9SF9L+Ph07ZBCpy1e5XIOWYMA3qnrse5
 6qNC0bOsapAunq70VxYaUDbyn6N2+BibB0Hwr1TssmEyxwCVhhxb0gLQO
 pK5Bz9Dt3emKEUfHElK7cEPy0w0vdL7mFNgDWWc0iV3BpgGq27KOWXkDT
 SiHT0qMqZVuaUX/YweI2qXkpAfU0j87v3Lw007ak+f5r8mcrl0NP22VyO
 /UqMJizdvnyYDkMYKJL1mzjmiC65RSc6T363Q44OAq/BJY9zFqjLff9A8 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270563671"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="270563671"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2022 16:13:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="573202350"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by fmsmga007.fm.intel.com with ESMTP; 13 May 2022 16:13:04 -0700
Date: Fri, 13 May 2022 16:16:40 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 20/29] init/main: Delay initialization of the lockup
 detector after smp_init()
Message-ID: <20220513231640.GA9074@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-21-ricardo.neri-calderon@linux.intel.com>
 <1652178524.7j2o02lrl8.astroid@bobo.none>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1652178524.7j2o02lrl8.astroid@bobo.none>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 Ricardo Neri <ricardo.neri@intel.com>, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw2@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
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

On Tue, May 10, 2022 at 08:38:22PM +1000, Nicholas Piggin wrote:
> Excerpts from Ricardo Neri's message of May 6, 2022 9:59 am:
> > Certain implementations of the hardlockup detector require support for
> > Inter-Processor Interrupt shorthands. On x86, support for these can only
> > be determined after all the possible CPUs have booted once (in
> > smp_init()). Other architectures may not need such check.
> > 
> > lockup_detector_init() only performs the initializations of data
> > structures of the lockup detector. Hence, there are no dependencies on
> > smp_init().
> 

Thank you for your feedback Nicholas!

> I think this is the only real thing which affects other watchdog types?

Also patches 18 and 19 that decouple the NMI watchdog functionality from
perf.

> 
> Not sure if it's a big problem, the secondary CPUs coming up won't
> have their watchdog active until quite late, and the primary could
> implement its own timeout in __cpu_up for secondary coming up, and
> IPI it to get traces if necessary which is probably more robust.

Indeed that could work. Another alternative I have been pondering is to boot
the system with the perf-based NMI watchdog enabled. Once all CPUs are up
and running, switch to the HPET-based NMI watchdog and free the PMU counters.

> 
> Acked-by: Nicholas Piggin <npiggin@gmail.com>

Thank you!

BR,
Ricardo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
