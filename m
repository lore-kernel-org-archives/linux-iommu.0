Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75824C63682
	for <iommu@archiver.kernel.org>; Wed, 26 Jan 2022 00:01:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12D8C829B1;
	Wed, 26 Jan 2022 00:01:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TF6rzhG2muEL; Wed, 26 Jan 2022 00:01:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E9C3882A0E;
	Wed, 26 Jan 2022 00:01:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDB44C0039;
	Wed, 26 Jan 2022 00:01:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37998C002F
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 00:01:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11E1482A2E
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 00:01:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UB3Ld6xDu9JQ for <iommu@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 00:01:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 853F482A0E
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 00:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643155288; x=1674691288;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=SpDhNbUZcRauXonP/+d7u6so8MOKDyCHLSxBXrM0t8M=;
 b=AocUpLUeIkni6iS+5yQRrcG8eqhtBSovR5/IU3nlN+nZUFx70HxRjCrX
 nO+ov4ML9iJ9z6i6VAV9AuWcqDZep2LUKFHPpRXyJdl1f3k8+Ry9BZlki
 56pRRR46e2f1k/tP34Z/EZMbEZcjNNvQ6Vg5aOhC7O6hZAOmwh5Q/IYjB
 DP1GBmI38hcJBbocdagEVrUqW96KnsIbqNVnKbiymAr2Rqv/WGBI2LRk8
 gOKssLSUYbBwqbZNTRddiQMnzW9qQkZ96vFCaOZ9Sj4Q0UL/5ocQFqywT
 PMV62TkEtWGMvQ5lUWvSA3196Qtt6vZn4fNVKBAvF2P22X4tmEHrEuhZb g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="332798085"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; d="scan'208";a="332798085"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2022 16:01:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; d="scan'208";a="534956436"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 25 Jan 2022 16:01:25 -0800
Subject: Re: [PATCH v2] iommu/vt-d: Fix PCI bus rescan device hot add
To: Jacob Pan <jacob.jun.pan@intel.com>, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>
References: <1642148470-11949-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <20220125105704.2375daed@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e83922c1-59af-6e65-abc5-802400ecb4e3@linux.intel.com>
Date: Wed, 26 Jan 2022 08:00:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220125105704.2375daed@jacob-builder>
Content-Language: en-US
Cc: "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 Raj Ashok <ashok.raj@intel.com>
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

Hi Jacob,

On 1/26/22 2:57 AM, Jacob Pan wrote:
> Hi all,
> 
> Just wondering if there are any other comments? This fixes a
> regression that can cause system hang.

This looks fine to me. I will queue it for v5.17 if there's no further
comments.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
