Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1EAC43217
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 02:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B1AC840463;
	Wed, 11 May 2022 02:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ko3j-QS0i-F0; Wed, 11 May 2022 02:32:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8839E4017A;
	Wed, 11 May 2022 02:32:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57CE3C0032;
	Wed, 11 May 2022 02:32:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24893C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 02:32:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2ED882CFD
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 02:32:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ncsxdUIL8fNr for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:32:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B040827FB
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 02:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652236341; x=1683772341;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=GD5SNKppixG33DS3SuVjSEMLGzo8y1WE3tk191fvhtc=;
 b=alOC50RR4mD98r0zJdAibwsQcayOGH30NnrSqHa/wJdQZXXsLRqT5+Di
 FXwGZ/1bpvHPRSPkLy0z9FIfbHMIeIYLROGFV0ZoiRVckj9JQanMEawgV
 knMNH1SQRzU4jeLjZo11+44hOxSLa0mUsFmE+SSKVb6JeH1TQthicKYZJ
 UAmXjpKIg3rlzRbT5+N97311Rfr/lALP6XHksYuJ7lpIsCYOleK+LlX7K
 P95+4aCei0JB4xnmEth0tA3RQl7R248KLaPGcvtnR45uiYb2NrONCuw/P
 Xg313bJwUsVrGRakYXNWNheV3zNlCkMgHfxcHscCZ+TlfTTHIpCghyrB5 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="355986183"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; d="scan'208";a="355986183"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2022 19:32:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; d="scan'208";a="542093731"
Received: from chenji3x-mobl1.ccr.corp.intel.com (HELO [10.255.30.10])
 ([10.255.30.10])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2022 19:32:16 -0700
Message-ID: <f56ea479-aa82-37ae-91c3-754816a4ed8b@linux.intel.com>
Date: Wed, 11 May 2022 10:32:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 03/12] iommu: Add attach/detach_dev_pasid domain ops
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-4-baolu.lu@linux.intel.com>
 <20220510140238.GD49344@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220510140238.GD49344@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On 2022/5/10 22:02, Jason Gunthorpe wrote:
> On Tue, May 10, 2022 at 02:17:29PM +0800, Lu Baolu wrote:
> 
>> This adds a pair of common domain ops for this purpose and adds helpers
>> to attach/detach a domain to/from a {device, PASID}.
> 
> I wonder if this should not have a detach op - after discussing with
> Robin we can see that detach_dev is not used in updated
> drivers. Instead attach_dev acts as 'set_domain'
> 
> So, it would be more symmetrical if attaching a blocking_domain to the
> PASID was the way to 'detach'.
> 
> This could be made straightforward by following the sketch I showed to
> have a static, global blocing_domain and providing a pointer to it in
> struct iommu_ops
> 
> Then 'detach pasid' is:
> 
> iommu_ops->blocking_domain->ops->attach_dev_pasid(domain, dev, pasid);
> 
> And we move away from the notion of 'detach' and in the direction that
> everything continuously has a domain set. PASID would logically
> default to blocking_domain, though we wouldn't track this anywhere.

I am not sure whether we still need to keep the blocking domain concept
when we are entering the new PASID world. Please allow me to wait and
listen to more opinions.

Best regards,
baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
