Return-Path: <SRS0=BifM=DE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DF5C4346E
	for <iommu@archiver.kernel.org>; Sun, 27 Sep 2020 23:59:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F2821D91
	for <iommu@archiver.kernel.org>; Sun, 27 Sep 2020 23:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F2821D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8B23084E9A;
	Sun, 27 Sep 2020 23:59:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O_9jvbos43B2; Sun, 27 Sep 2020 23:59:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E82E584917;
	Sun, 27 Sep 2020 23:59:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9C90C016F;
	Sun, 27 Sep 2020 23:59:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E5CAC0051
 for <iommu@lists.linux-foundation.org>; Sun, 27 Sep 2020 23:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2629287048
 for <iommu@lists.linux-foundation.org>; Sun, 27 Sep 2020 23:59:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iKKpGIoWkQXw for <iommu@lists.linux-foundation.org>;
 Sun, 27 Sep 2020 23:59:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4925587046
 for <iommu@lists.linux-foundation.org>; Sun, 27 Sep 2020 23:59:11 +0000 (UTC)
IronPort-SDR: N6qaOeZMuO3IjJ+zatO37nmCI7wBZuQZPEb+3LjYMrT0DBU52xXGqM8C6sorISJzYinHgyyqIu
 PPq1Cf7vRomw==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="159299837"
X-IronPort-AV: E=Sophos;i="5.77,311,1596524400"; d="scan'208";a="159299837"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 16:59:10 -0700
IronPort-SDR: opfHP+mi7b+9hDG7K3XH6ZaD53EIAcHlw2mkDousIGYiufJK7+3aBAsiIOhyodytHmlVxPF98w
 WwVfw9OGLLww==
X-IronPort-AV: E=Sophos;i="5.77,311,1596524400"; d="scan'208";a="488339604"
Received: from memara-mobl.ger.corp.intel.com (HELO localhost)
 ([10.252.49.157])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 16:59:07 -0700
Date: Mon, 28 Sep 2020 02:59:08 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH 00/13] x86: Trenchboot secure dynamic launch Linux kernel
 support
Message-ID: <20200927235908.GC5283@linux.intel.com>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <20200925053051.GA165011@linux.intel.com>
 <8329607a-704d-1da0-dc7b-4b97c2440afb@apertussolutions.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8329607a-704d-1da0-dc7b-4b97c2440afb@apertussolutions.com>
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

On Fri, Sep 25, 2020 at 05:32:50PM -0400, Daniel P. Smith wrote:
> The work for this is split across different teams with different
> resourcing levels resulting in one organization working Intel and
> another working AMD. This then raised the concern over submitting a
> single patch set developed by two groups pseudo-independently. In this
> situation the result would be patches being submitted from one
> organization that had no direct development or testing and therefore
> could not sign off on a subset of the patches being submitted.

Not sure if internal team structures qualify as a techical argument for
upstream code.

> > I'd be more motivated to review and test a full all encompassing x86
> > solution. It would increase the patch set size but would also give it
> > a better test coverage, which I think would be a huge plus in such a
> > complex patch set.
> 
> We would not disagree with those sentiments but see the previous
> response about the conflict that exists.

At minimum, you have to make the case that the AMD support is easy to
tackle in to the framework of things you have later on.

/Jarkko
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
