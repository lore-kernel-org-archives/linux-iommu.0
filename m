Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AAAC43334
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 06:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEC1F83F8C;
	Fri, 24 Jun 2022 06:12:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEC1F83F8C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aw/fazGY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u8ImbeV1w-Rv; Fri, 24 Jun 2022 06:12:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B523D83F78;
	Fri, 24 Jun 2022 06:12:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B523D83F78
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 890C5C0039;
	Fri, 24 Jun 2022 06:12:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3EFFC002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 06:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8735F612BA
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 06:12:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8735F612BA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=aw/fazGY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FN8O3ucf97St for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 06:12:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB1BB612A9
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB1BB612A9
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 06:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656051153; x=1687587153;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Ep5G+IyesmjSsPbzBhJrTw+Wkt1/vQLTZVGrnR3bOeU=;
 b=aw/fazGYnZTaPgRJZvbzz7tSAbAWwJuKHM+cnVoCbVMm2iJvfZZl87vE
 fjACQsDFtJEl/AhXEX4UNh2BLy6cKxM1Lq+tFVMlyuYZSZXOC8SDR3cav
 vusCILiV1FCh6kkRCHODYnNZ6gclOfqcM6SBsPLad+4mAm33jQxsyHIfb
 phsNy3AtPmOIfdqB7jNKI4fYo2cViyQhcFE6pNihElbJrloeyblNzDEXe
 SJT3Kf8tnCPHCqU2Nk9FBjeb0GL9OCRgI6WG8K5+LYlDF0QFxQ+r6QJrD
 OLhZ2l4RUsaEbtoaSE15OamgsigojoE9mJfKRv7MZO0kuW2LLPSGi5n49 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367251567"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; d="scan'208";a="367251567"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2022 23:12:32 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; d="scan'208";a="915551654"
Received: from rwang105-mobl4.ccr.corp.intel.com (HELO [10.249.168.100])
 ([10.249.168.100])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2022 23:12:30 -0700
Message-ID: <1036ab2c-f854-9746-ddc7-e9fe20cd3d40@linux.intel.com>
Date: Fri, 24 Jun 2022 14:12:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] iommu/vt-d: Fix PCI bus rescan device hot add
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220521002115.1624069-1-yian.chen@intel.com>
 <7149e5dd-c72e-538b-b98f-0fbc89580a95@linux.intel.com>
 <YrVPelnOi9nql/8C@8bytes.org>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YrVPelnOi9nql/8C@8bytes.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Joerg,

On 2022/6/24 13:45, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Wed, May 25, 2022 at 09:40:26AM +0800, Baolu Lu wrote:
>> How do you like it? If you agree, I can queue it in my next pull request
>> for fixes.
> 
> Would it help to tie DMAR and IOMMU components together, so that
> selecting DMAR for IRQ remapping also selects IOMMU? The IOMMU can be in
> PT mode and I think it would simplify a lot of things.

It makes sense as far as I am aware. By putting IOMMUs in pass-through
mode, there will be no run-time costs and things could be simplified a
lot.

Besides the refactoring efforts, we still need this quick fix so that
the fix could be propagated to various stable and vendors' downstream trees.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
