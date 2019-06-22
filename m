Return-Path: <SRS0=H1gU=UV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC7DC43613
	for <iommu@archiver.kernel.org>; Sat, 22 Jun 2019 08:54:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BE32089C
	for <iommu@archiver.kernel.org>; Sat, 22 Jun 2019 08:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BE32089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F313515E9;
	Sat, 22 Jun 2019 08:54:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 061D215AB
	for <iommu@lists.linux-foundation.org>;
	Sat, 22 Jun 2019 08:54:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A9D1B27B
	for <iommu@lists.linux-foundation.org>;
	Sat, 22 Jun 2019 08:54:00 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	22 Jun 2019 01:54:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,403,1557212400"; d="scan'208";a="336056533"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga005.jf.intel.com with ESMTP; 22 Jun 2019 01:53:58 -0700
Subject: Re: Use after free from intel_alloc_iova
To: Chris Wilson <chris@chris-wilson.co.uk>, iommu@lists.linux-foundation.org
References: <156112367995.2401.1422585153542339642@skylake-alporthouse-com>
	<025d7ab7-fdc2-92ea-909f-8479842001cb@linux.intel.com>
	<156119095667.18296.6689711629853658701@skylake-alporthouse-com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2eac41e8-499e-1b6d-0f92-d55ba525cf2f@linux.intel.com>
Date: Sat, 22 Jun 2019 16:46:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <156119095667.18296.6689711629853658701@skylake-alporthouse-com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

On 6/22/19 4:09 PM, Chris Wilson wrote:
> Quoting Lu Baolu (2019-06-22 07:49:22)
>> Hi Chris,
>>
>> Thanks for the test and report.
>>
>> On 6/21/19 9:27 PM, Chris Wilson wrote:
>>> We see a use-after-free in our CI about 20% of the time on a Skylake
>>> iommu testing host, present since enabling that host. Sadly, it has not
>>> presented itself while running under KASAN.
>>>
>>> <4> [302.391799] general protection fault: 0000 [#1] PREEMPT SMP PTI
>>> <4> [302.391803] CPU: 7 PID: 4854 Comm: i915_selftest Tainted: G     U            5.2.0-rc5-CI-CI_DRM_6320+ #1
>>
>> Since it's CI-CI_DRM_6320+, what kind of patches have you applied on top
>> of 5.2.0-rc5?
> 
> $ git diff --stat v5.2-rc5..intel/CI_DRM_6320
> ...
> 1383 files changed, 62481 insertions(+), 35301 deletions(-)
> 
> The usual drivers/gpu churn, and nothing inside drivers/iommu.

Can this be reproduced with any bare mainline rc's? So that people can
reproduce and debug it.

Best regards,
Baolu

> 
> Our oldest report (when the machine was configured) was with
> 4.19.0-CI-CI_DRM_5049. The tags are available from
> git://git.freedesktop.org/git/gfx-ci/linux
> -Chris
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
