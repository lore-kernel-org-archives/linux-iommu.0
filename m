Return-Path: <SRS0=BMay=CL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1665C433E2
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 21:40:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B832C207EA
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 21:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B832C207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6ECBE86A39;
	Wed,  2 Sep 2020 21:40:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hjsapFnJZKnc; Wed,  2 Sep 2020 21:40:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 651C286A23;
	Wed,  2 Sep 2020 21:40:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51B8EC0052;
	Wed,  2 Sep 2020 21:40:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9584CC0051
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 21:40:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 826AF86A99
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 21:40:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D0M7euFrYlxR for <iommu@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 21:40:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E2DA586A10
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 21:39:59 +0000 (UTC)
IronPort-SDR: h94cSVoDoJIxTOGY21IqJvuOhrUkyLh4Gydnxo39/2uqeb6QnSzOF/9M8tw3aphP2K1dLUzVyB
 7722INeMmhMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="157484784"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="157484784"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:39:59 -0700
IronPort-SDR: 3aN1bVBGjYGTxOItKGjSaxdAAnK0XFpwLvwn33eSYR7d579dGO4MNdI00YPL/2qu7AkYJRhHaH
 WB2X0WmURgiQ==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="331572226"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:39:59 -0700
Date: Wed, 2 Sep 2020 14:47:06 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 3/9] iommu/ioasid: Introduce ioasid_set APIs
Message-ID: <20200902144706.331e1032@jacob-builder>
In-Reply-To: <1be98989-fab3-f9e4-cbd6-cf72a67dc5f1@infradead.org>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200824182848.GB3210689@myrica>
 <1be98989-fab3-f9e4-cbd6-cf72a67dc5f1@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.pan.linux@gmail.com>,
 Raj Ashok <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, Wu Hao <hao.wu@intel.com>
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

On Mon, 24 Aug 2020 11:34:29 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 8/24/20 11:28 AM, Jean-Philippe Brucker wrote:
> >> +/**
> >> + * struct ioasid_set - Meta data about ioasid_set
> >> + * @type:	Token types and other features  
> > nit: doesn't follow struct order
> >   
> >> + * @token:	Unique to identify an IOASID set
> >> + * @xa:		XArray to store ioasid_set private IDs, can be used for
> >> + *		guest-host IOASID mapping, or just a private IOASID namespace.
> >> + * @quota:	Max number of IOASIDs can be allocated within the set
> >> + * @nr_ioasids	Number of IOASIDs currently allocated in the set  
> 
>  * @nr_ioasids: Number of IOASIDs currently allocated in the set
> 
got it. thanks!

> >> + * @sid:	ID of the set
> >> + * @ref:	Reference count of the users
> >> + */
> >>  struct ioasid_set {
> >> -	int dummy;
> >> +	void *token;
> >> +	struct xarray xa;
> >> +	int type;
> >> +	int quota;
> >> +	int nr_ioasids;
> >> +	int sid;
> >> +	refcount_t ref;
> >> +	struct rcu_head rcu;
> >>  };  
> 
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
