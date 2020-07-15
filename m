Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73269C433E1
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 22:06:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC522065F
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 22:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC522065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EFB0289BBF;
	Wed, 15 Jul 2020 22:06:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EkQTC9N-4IKf; Wed, 15 Jul 2020 22:06:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 559CB89BBC;
	Wed, 15 Jul 2020 22:06:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41384C07FF;
	Wed, 15 Jul 2020 22:06:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38ACEC0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 22:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 566ED8824B
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 22:06:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rQ4zKUhlcZaR for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 22:06:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1455A89569
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 22:06:13 +0000 (UTC)
IronPort-SDR: D39iSILSAEkWfEw85E4jhzDqJJYCBqfn2YaeGxQZx0UUyvqrapIURqUweiOe+TaH6vv4p8egIt
 OKFlMCVl99dA==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="148425822"
X-IronPort-AV: E=Sophos;i="5.75,356,1589266800"; d="scan'208";a="148425822"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 15:06:12 -0700
IronPort-SDR: iRsrS99HS6MdNE/ujfwpMklUKMIuF8aus3svltBIRJ1DtYDwGdUXXLIkBEqJN+RtwwwIlxsK1C
 /CKUf9AKQQpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,356,1589266800"; d="scan'208";a="360848017"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga001.jf.intel.com with ESMTP; 15 Jul 2020 15:06:12 -0700
Date: Wed, 15 Jul 2020 15:12:54 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v4 1/5] docs: IOMMU user API
Message-ID: <20200715151254.511ab0b5@jacob-builder>
In-Reply-To: <20200714130412.0ef8f00c@x1.home>
References: <1594165429-20075-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1594165429-20075-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200713164842.693ff2ff@x1.home>
 <20200713220023.35f7c79b@jacob-builder>
 <20200714130412.0ef8f00c@x1.home>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
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

On Tue, 14 Jul 2020 13:04:12 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> > >  The
> > > mangling of the user provided argsz above makes me cringe a
> > > little too for that reason, once we start modifying the user
> > > values in the core it could get messy for the vendor drivers.
> > >     
> > We do have vendor specific union in bind_gpasid UAPI. Could you
> > elaborate your concern?  
> 
> The vendor driver is no longer seeing the value the user provided,
> what if some future vendor structure ends with something like:
> 
> 	__u32 nr_entries;
> 	__u32 entries[];
> }
> 
> The core code clobbered the user value, so the vendor driver wouldn't
> be able to perform any additional user copies.  Clearly that's also a
> bug that could be fixed at the time such functionality becomes
> necessary, it seems unnecessary to perform that clobbering in the
> first place if everyone is on guard for user supplied data.  Thanks,
Sorry I missed this in my last reply.

Make sense not to clobber user data in the core. So we should pass the
argsz as is to the vendor driver, but copy from user only up to the
size of the current kernel supports.
i.e.

	/*
	 * User might be using a newer UAPI header which has a larger data
	 * size, we shall support the existing flags within the current
	 * size. Copy the remaining user data _after_ minsz but not more
	 * than the current kernel supported size.
	 */
	if (copy_from_user((void *)&inv_info + minsz, uinfo + minsz,
				min(inv_info.argsz, maxsz) - minsz))
		return -EFAULT;

Currently, vendor driver does not handle user pointer. Once the
extension as you described above becomes necessary, we can change the
vendor driver interface. Is that a reasonable plan?

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
