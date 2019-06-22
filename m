Return-Path: <SRS0=H1gU=UV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E53C43613
	for <iommu@archiver.kernel.org>; Sat, 22 Jun 2019 09:04:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7E92089C
	for <iommu@archiver.kernel.org>; Sat, 22 Jun 2019 09:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7E92089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7A50F15F3;
	Sat, 22 Jun 2019 09:04:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 63B6915EA
	for <iommu@lists.linux-foundation.org>;
	Sat, 22 Jun 2019 09:04:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from fireflyinternet.com (mail.fireflyinternet.com [109.228.58.192])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9CCD9224
	for <iommu@lists.linux-foundation.org>;
	Sat, 22 Jun 2019 09:04:52 +0000 (UTC)
X-Default-Received-SPF: pass (skip=forwardok (res=PASS))
	x-ip-name=78.156.65.138; 
Received: from localhost (unverified [78.156.65.138]) 
	by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id
	16987232-1500050 for multiple; Sat, 22 Jun 2019 10:04:13 +0100
MIME-Version: 1.0
To: Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <2eac41e8-499e-1b6d-0f92-d55ba525cf2f@linux.intel.com>
References: <156112367995.2401.1422585153542339642@skylake-alporthouse-com>
	<025d7ab7-fdc2-92ea-909f-8479842001cb@linux.intel.com>
	<156119095667.18296.6689711629853658701@skylake-alporthouse-com>
	<2eac41e8-499e-1b6d-0f92-d55ba525cf2f@linux.intel.com>
Message-ID: <156119425158.2401.2472323001036130990@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: Use after free from intel_alloc_iova
Date: Sat, 22 Jun 2019 10:04:11 +0100
Cc: dave.jiang@intel.com
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

Quoting Lu Baolu (2019-06-22 09:46:36)
> Hi,
> 
> On 6/22/19 4:09 PM, Chris Wilson wrote:
> > Quoting Lu Baolu (2019-06-22 07:49:22)
> >> Hi Chris,
> >>
> >> Thanks for the test and report.
> >>
> >> On 6/21/19 9:27 PM, Chris Wilson wrote:
> >>> We see a use-after-free in our CI about 20% of the time on a Skylake
> >>> iommu testing host, present since enabling that host. Sadly, it has not
> >>> presented itself while running under KASAN.
> >>>
> >>> <4> [302.391799] general protection fault: 0000 [#1] PREEMPT SMP PTI
> >>> <4> [302.391803] CPU: 7 PID: 4854 Comm: i915_selftest Tainted: G     U            5.2.0-rc5-CI-CI_DRM_6320+ #1
> >>
> >> Since it's CI-CI_DRM_6320+, what kind of patches have you applied on top
> >> of 5.2.0-rc5?
> > 
> > $ git diff --stat v5.2-rc5..intel/CI_DRM_6320
> > ...
> > 1383 files changed, 62481 insertions(+), 35301 deletions(-)
> > 
> > The usual drivers/gpu churn, and nothing inside drivers/iommu.
> 
> Can this be reproduced with any bare mainline rc's? So that people can
> reproduce and debug it.

Yes. The earlier reports are on code that is all in 5.0.
-Chris
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
