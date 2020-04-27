Return-Path: <SRS0=6Sm1=6L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5549C82C07
	for <iommu@archiver.kernel.org>; Mon, 27 Apr 2020 22:46:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3A120775
	for <iommu@archiver.kernel.org>; Mon, 27 Apr 2020 22:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3A120775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 71DDE85F5A;
	Mon, 27 Apr 2020 22:46:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RieS9D9PL_-e; Mon, 27 Apr 2020 22:46:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 277A585F58;
	Mon, 27 Apr 2020 22:46:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A453C0172;
	Mon, 27 Apr 2020 22:46:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 054EDC003B
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 22:46:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E17E2875BB
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 22:46:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YhXD7CFNKtK1 for <iommu@lists.linux-foundation.org>;
 Mon, 27 Apr 2020 22:46:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E9DDE87356
 for <iommu@lists.linux-foundation.org>; Mon, 27 Apr 2020 22:46:47 +0000 (UTC)
IronPort-SDR: 6Wv8iCXbPgL7V5oFbLg2X9u81azZb/BK+C52qVorM1x0fBsqsSfCn/XUC3oCyTX7myv3F3Vjba
 gtBKwF4wKnIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 15:46:47 -0700
IronPort-SDR: UHVzSlXZVdNamgJeTnygmEuXY5wBVq5RZcNSoRgPwHzzqHDm3NcyQ2wPRbh+JCVXcKjUrc6TKD
 /A5HxJvcQb8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; d="scan'208";a="459025738"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
 by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2020 15:46:46 -0700
Date: Mon, 27 Apr 2020 15:46:46 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6/7] x86/traps: Fix up invalid PASID
Message-ID: <20200427224646.GA103955@otc-nc-03>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-7-git-send-email-fenghua.yu@intel.com>
 <87mu6ys20d.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mu6ys20d.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, H Peter Anvin <hpa@zytor.com>,
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

Hi Thomas

On Sun, Apr 26, 2020 at 05:25:06PM +0200, Thomas Gleixner wrote:
> Fenghua Yu <fenghua.yu@intel.com> writes:
> > A #GP fault is generated when ENQCMD instruction is executed without
> > a valid PASID value programmed in.
> 
> Programmed in what?
> 
> > The #GP fault handler will initialize the current thread's PASID MSR.
> >
> > The following heuristic is used to avoid decoding the user instructions
> > to determine the precise reason for the #GP fault:
> > 1) If the mm for the process has not been allocated a PASID, this #GP
> >    cannot be fixed.
> > 2) If the PASID MSR is already initialized, then the #GP was for some
> >    other reason
> > 3) Try initializing the PASID MSR and returning. If the #GP was from
> >    an ENQCMD this will fix it. If not, the #GP fault will be repeated
> >    and we will hit case "2".
> >
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Just for the record I also suggested to have a proper errorcode in the
> #GP for ENQCMD and I surely did not suggest to avoid decoding the user
> instructions.

We certainly discussed the possiblity of adding an error code to 
identiy #GP due to ENQCMD with our HW architects. 

There are only a few cases that have an error code, like move to segment
with an invalid value for instance. There were a few but i don't
recall that entire list. 

Since the error code is 0 in most places, there isn't plumbing in hw to return
this value in all cases. It appeared that due to some uarch reasons it
wasn't as simple as it appears to /me sw kinds :-)

So after some internal discussion we decided to take the current
approach. Its possible that if the #GP was due to some other reason
we might #GP another time. Since this wasn't perf or speed path we took
this lazy approach. 

We will keep tabs with HW folks for future consideration. 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
