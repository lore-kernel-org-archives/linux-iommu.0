Return-Path: <SRS0=QAQK=UU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAFEC43613
	for <iommu@archiver.kernel.org>; Fri, 21 Jun 2019 02:30:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6664206E0
	for <iommu@archiver.kernel.org>; Fri, 21 Jun 2019 02:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6664206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 64082AD1;
	Fri, 21 Jun 2019 02:30:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EFC00AC7
	for <iommu@lists.linux-foundation.org>;
	Fri, 21 Jun 2019 02:30:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9BFD37DB
	for <iommu@lists.linux-foundation.org>;
	Fri, 21 Jun 2019 02:30:24 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 01B753086228;
	Fri, 21 Jun 2019 02:30:24 +0000 (UTC)
Received: from xz-x1 (unknown [10.66.60.170])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 640D15D9D2;
	Fri, 21 Jun 2019 02:30:22 +0000 (UTC)
Date: Fri, 21 Jun 2019 10:30:20 +0800
From: Peter Xu <peterx@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: VT-d deadlock issue on device_domain_lock and iommu lock (5.2-rc5)
Message-ID: <20190621023020.GA9371@xz-x1>
References: <20190620104418.GA9657@xz-x1>
	<de430ed1-a9f0-6970-a3b3-682fb3dbd8ac@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <de430ed1-a9f0-6970-a3b3-682fb3dbd8ac@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 21 Jun 2019 02:30:24 +0000 (UTC)
Cc: Linux IOMMU Mailing List <iommu@lists.linux-foundation.org>,
	dave.jiang@intel.com
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

On Fri, Jun 21, 2019 at 09:58:28AM +0800, Lu Baolu wrote:
> Hi Peter,
> 
> I agree with you that 7560cc3ca7d9 ("iommu/vt-d: Fix lock inversion between
> iommu->lock and device_domain_lock") isn't a good fix. There
> is also another thread, https://lkml.org/lkml/2019/6/18/996, which
> reported this.
> 
> I think we can revert this patch now. I will try to reproduce the
> original issue and try to find a new fix.
> 
> Can you please submit the revert patch?

Sure, I'll post a formal patch soon.  Thanks,

-- 
Peter Xu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
