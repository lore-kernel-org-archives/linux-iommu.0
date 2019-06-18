Return-Path: <SRS0=TfAO=UR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9670BC31E5D
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 23:14:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 759CA20B1F
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 23:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759CA20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 372ABCCA;
	Tue, 18 Jun 2019 23:14:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4EC03CBC
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 23:14:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D22B8180
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 23:14:11 +0000 (UTC)
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
	by Galois.linutronix.de with esmtpsa
	(TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hdNIW-0008CH-Mg; Wed, 19 Jun 2019 01:13:52 +0200
Date: Wed, 19 Jun 2019 01:13:45 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [RFC PATCH v4 03/21] x86/hpet: Calculate ticks-per-second in a
	separate function
In-Reply-To: <20190618224800.GD30488@ranerica-svr.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1906190111510.1765@nanos.tec.linutronix.de>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1558660583-28561-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<alpine.DEB.2.21.1906141749330.1722@nanos.tec.linutronix.de>
	<20190618224800.GD30488@ranerica-svr.sc.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
	SHORTCIRCUIT=-0.0001
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
	Ashok Raj <ashok.raj@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Randy Dunlap <rdunlap@infradead.org>, Clemens Ladisch <clemens@ladisch.de>,
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
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

On Tue, 18 Jun 2019, Ricardo Neri wrote:
> On Fri, Jun 14, 2019 at 05:54:05PM +0200, Thomas Gleixner wrote:
> > 
> > So we already have ticks per second, aka frequency, right? So why do we
> > need yet another function instead of using the value which is computed
> > once? The frequency of the HPET channels has to be identical no matter
> > what. If it's not HPET is broken beyond repair.
> 
> I don't think it needs to be recomputed again. I missed the fact that
> the frequency was already computed here.
> 
> Also, the hpet char driver has its own frequency computation. Perhaps it
> could also obtain it from here, right?

No. It's separate on purpose. Hint: IA64, aka Itanic

Thanks,

	tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
