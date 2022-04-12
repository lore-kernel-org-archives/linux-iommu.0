Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4960FC433FE
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 05:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE29E4032E;
	Tue, 12 Apr 2022 05:13:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DvhsHZy0-Tye; Tue, 12 Apr 2022 05:13:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 85F604023F;
	Tue, 12 Apr 2022 05:13:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3409EC0033;
	Tue, 12 Apr 2022 05:13:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9EB2C002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 05:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 82DA7813E7
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 05:13:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nOqcc3WLNT-U for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 05:13:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 09C2C814B4
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 05:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649740423; x=1681276423;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7RIfU1Kze0Bl1IPpLchMd6X7VZcxVVzBh63sfL5BABQ=;
 b=TXieOBzVXM5+FDRl/PnbrEoLoZPmS/fo4qF7VKovBYvVQgEnmT0vXEnJ
 DM6w5lxXjzxSW0hzRXIY3EVMn6vG6Gvnd37EoagxH60whHKAkhOk2VpQ3
 ZVcomKKdPHs8DBkN+n9C63jyhQAX3lGeq9Mr6MVav3n38yNo2CBlPtqJS
 jvUYpaC8T1NjWdTKBN5MhoYXlWOjChHRpOqWmhudKpXMLkrx0rmxt7Xpi
 LeC8S+k/wcvaQWUMEdmehnO9+HWUBe7/XlU9HfvSjPvUKtQME3b14l2q+
 43px0syxTGN10RiPHcP6+4AKcss9aJ+T2ioX3uuQiCsyiE6agUYxbOyB2 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244162086"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="244162086"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 22:13:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="572568841"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.210])
 ([10.254.215.210])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 22:13:40 -0700
Message-ID: <d87918be-9ab8-ca6b-ea1f-b6e9fafb1d44@linux.intel.com>
Date: Tue, 12 Apr 2022 13:13:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/1] iommu/vt-d: Change return type of
 dmar_insert_one_dev_info()
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20220409133006.3953129-1-baolu.lu@linux.intel.com>
 <YlQ6feP5Dd9Ux18Y@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YlQ6feP5Dd9Ux18Y@infradead.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On 2022/4/11 22:26, Christoph Hellwig wrote:
> On Sat, Apr 09, 2022 at 09:30:06PM +0800, Lu Baolu wrote:
>> The dmar_insert_one_dev_info() returns the pass-in domain on success and
>> NULL on failure. This doesn't make much sense. Change it to an integer.
> 
> Looks sensibel.  Why not also merge it with domain_add_dev_info while
> you're at it?

It looks cleaner that way. Thanks a lot!

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
