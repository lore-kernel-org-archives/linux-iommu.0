Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47873C433EF
	for <iommu@archiver.kernel.org>; Sun, 29 May 2022 05:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1EE561153;
	Sun, 29 May 2022 05:22:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H_3pIm2oW76m; Sun, 29 May 2022 05:22:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9F61E60E81;
	Sun, 29 May 2022 05:22:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78ABAC0039;
	Sun, 29 May 2022 05:22:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC9B2C002D
 for <iommu@lists.linux-foundation.org>; Sun, 29 May 2022 05:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB220846A4
 for <iommu@lists.linux-foundation.org>; Sun, 29 May 2022 05:22:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 75C8HNQhuDJW for <iommu@lists.linux-foundation.org>;
 Sun, 29 May 2022 05:22:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E384F83ED3
 for <iommu@lists.linux-foundation.org>; Sun, 29 May 2022 05:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653801772; x=1685337772;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vqd0ws84Ku7p1KlSODDOxug1zK8S6g53o9MNKaqUrrs=;
 b=VuEGaZGzOKPz+3NoPqWnn6uqLdq0wuVV1lX4qPB/nmwuV6852eyjYJfZ
 +kiHUt41n8mqroZOJMrAj/c2OBiMUF9TZTohIFl/4dceIxMkc6Mai0mXq
 RSfg1SCBTQf8X8vKk4CVcHzcPVwEgz4bhxLtcL/00B4TSEeqt5CBnB1SU
 cJW9bu/wifcAK9CsKTdZRxwkjJBzdkJLgTnOHsW6QaJBrZ0HZIuSl0eJm
 SEpVIUShjROVHQeBNCx3idwMSv6B+65bBbdCO1If9sPANLUy0k/tSsW4e
 OvATxC6gyGR1d2bWOmh6YqMs6UuoXKET4u8hLZ9HAE2Fo1y6TbPWM2X5+ g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="273564905"
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; d="scan'208";a="273564905"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2022 22:22:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; d="scan'208";a="575465088"
Received: from unknown (HELO [10.255.28.211]) ([10.255.28.211])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2022 22:22:49 -0700
Message-ID: <a1e27717-3761-a521-79fa-6f74b6f88ffd@linux.intel.com>
Date: Sun, 29 May 2022 13:22:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 03/12] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-4-baolu.lu@linux.intel.com>
 <20220527150108.GS1343366@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220527150108.GS1343366@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Will Deacon <will@kernel.org>
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

On 2022/5/27 23:01, Jason Gunthorpe wrote:
> On Fri, May 27, 2022 at 02:30:10PM +0800, Lu Baolu wrote:
>> The disable_dmar_iommu() is called when IOMMU initialzation fails or
>> the IOMMU is hot-removed from the system. In both cases, there is no
>> need to clear the IOMMU translation data structures for devices.
>>
>> On the initialization path, the device probing only happens after the
>> IOMMU is initialized successfully, hence there're no translation data
>> structures.
>>
>> On the hot-remove path, there is no real use case where the IOMMU is
>> hot-removed, but the devices that it manages are still alive in the
>> system. The translation data structures were torn down during device
>> release, hence there's no need to repeat it in IOMMU hot-remove path
>> either.
> 
> Can you leave behind a 1 statement WARN_ON of some kind to check this?

Sure. As the default domain is the first domain allocated for a device
and the last one freed. We can WARN_ON the case where there's still
domain IDs in use. How do you like this?

+       /*
+        * All iommu domains must have been detached from the devices,
+        * hence there should be no domain IDs in use.
+        */
+       if (WARN_ON(bitmap_weight(iommu->domain_ids, cap_ndoms(iommu->cap))
+                   != NUM_RESERVED_DID))
+               return;

Best regards,
baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
