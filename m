Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB73CC2D0A8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 03:25:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA8B20791
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 03:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA8B20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F3C6686078;
	Wed, 30 Sep 2020 03:25:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sotc-VcNhsLx; Wed, 30 Sep 2020 03:25:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 704E985F57;
	Wed, 30 Sep 2020 03:25:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50245C0890;
	Wed, 30 Sep 2020 03:25:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF485C016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 03:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B1CA220446
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 03:24:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OmpaBseeOLtS for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 03:24:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by silver.osuosl.org (Postfix) with ESMTPS id D5EFC20422
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 03:24:58 +0000 (UTC)
IronPort-SDR: Gre9ISFgtGkOp0mGLa+Job3A9BR9RpBSQOV2ZxcquYPFuU6h1zcBSoG4kiNsc9mb0oekZUsJEY
 gnnT5+Tk/c8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="159684529"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; d="scan'208";a="159684529"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2020 20:24:58 -0700
IronPort-SDR: GT/qSFOvF4oYuTG2A/9XYSrD3W+UzzTNynL976fGHG/yA2DvfjNSOhO7QDqygJiupSkkx1jS4Y
 THWrgClUOKpQ==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; d="scan'208";a="495110304"
Received: from xinpan-mobl.ger.corp.intel.com (HELO localhost)
 ([10.249.35.239])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2020 20:24:54 -0700
Date: Wed, 30 Sep 2020 06:24:52 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH 05/13] x86: Add early TPM1.2/TPM2.0 interface support for
 Secure Launch
Message-ID: <20200930032452.GA880758@linux.intel.com>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-6-git-send-email-ross.philipson@oracle.com>
 <20200925054313.GB165011@linux.intel.com>
 <bf1d8df9-ec79-2cc6-534f-ce1f0a58f123@apertussolutions.com>
 <20200930031952.GA880396@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200930031952.GA880396@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: linux-doc@vger.kernel.org, Ross Philipson <ross.philipson@oracle.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net,
 iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, linux-integrity@vger.kernel.org,
 trenchboot-devel@googlegroups.com, tglx@linutronix.de
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

On Wed, Sep 30, 2020 at 06:19:57AM +0300, Jarkko Sakkinen wrote:
> On Tue, Sep 29, 2020 at 07:47:52PM -0400, Daniel P. Smith wrote:
> > TrenchBoot's AMD Secure Loader (LZ). The former is not well supported
> > and the latter will be getting maintenance under TB. While this is not
> > preferred, we had to weigh this versus trying to convince you and the
> > other TPM driver maintainers on a significant refactoring of the TPM
> > driver. It was elected for the reuse of a clean implementation that can
> > be replaced later if/when the TPM driver was refactored. When we
> > explained this during the RFC and it was not rejected, therefore we
> > carried it forward into this submission.
> 
> What does it anyway mean when you say "RFC was not rejected"? I don't
> get the semantics of that sentence. It probably neither was ack'd,
> right? I do not really care what happened with the RFC. All I can say
> is that in the current state this totally PoC from top to bottom.
> 
> > > How it is now is never going to fly.
> > 
> > We would gladly work with you and the other TPM maintainers on a
> > refactoring of the TPM driver to separate core logic into standalone
> > files that both the driver and the compressed kernel can share.
> 
> Yes, exactly. You have to refactor out the common parts. This is way too
> big patch to spend time on giving any more specific advice. Should be in
> way smaller chunks. For (almost) any possible, this is of unacceptable
                                               ^ " patch"
> size.
> 
> I think that it'd be best first to keep the common files in
> drivers/char/tpm and include them your code with relative paths in the
> Makefile. At least up until we have clear view what are the common
> parts.
> 
> You might also want to refactor drivers/char/tpm/tpm.h and include/linux
> TPM headers to move more stuff into include/linux.
> 
> If you are expecting a quick upstreaming process, please do not. This
> will take considerable amount of time to get right.

/Jarkko
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
