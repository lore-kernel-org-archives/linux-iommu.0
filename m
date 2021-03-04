Return-Path: <SRS0=KoUT=IC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E475FC433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 17:54:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7234464F67
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 17:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7234464F67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35FAC4B7CF;
	Thu,  4 Mar 2021 17:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pV4q6HjEXt7v; Thu,  4 Mar 2021 17:54:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id C422B4AD93;
	Thu,  4 Mar 2021 17:54:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7454C000B;
	Thu,  4 Mar 2021 17:54:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69C99C0001
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 17:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57F2D83EEF
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 17:54:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rveRQLEVa4Br for <iommu@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 17:54:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B28E83EED
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 17:54:20 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B60411ecb0000>; Thu, 04 Mar 2021 09:54:19 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 17:54:17 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 17:54:09 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 4 Mar 2021 17:54:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFzBJNXY6UbJ/0hFzyMbTSaTEiaaIG8u673XhSLntGj/ZQvf2tO8JVCBI9vA3e/1IwPPmwJXsA7OGgHvvkWlC4sdWVfCzBitjbpsDCzlkUmWtPC8kP9wqrsS2uj+8F+dCAC4Z0mpz8TmlEQP4pOwDVB8L//dvduiG0aHNmjWkigNkjJ1ExSGEAbCA2iSy4RF24rj4eErnTzAgMrqJurBeCQgIgI4hADmoquiUq1AmrrD/W6nHb0EpDDEiHA2n6jZ+yu5+foiZwpwVniFtvSKxe64JX77haDnPIWMTLMxx4aed3UPEFrmYw8YYsUzTQBntNMdR45js297OJLiK5gyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IsSiLJgMTXbIalwO2pbn+VbK2Xk9986eGeD/lKT7yQ=;
 b=BcYW/bq6+Dl2EjG+9BYRDu4AXEkJIBQMYE2o7RTd+ZBcCzgdqqz7SjYOdjr3d29+h7CveoaNcDnqgxXes3HJ2Cuma+vdpSTaURaPch0c5TiSuWeSWoBnmQzPuCnFkj74DtpkWK2t41MhagkShu1mqBjAzNgDIbjBy7utHsGP6r/gjEyfPrXV8pr19fqJkbti7ZZwqnDHxV4drhN+fGeOmFq4GbFzBz0nMuE3Amzs/I/n/QFI5O6A8E0ecTNYMBlxMqzO3qXlnhaKyUq20qsqJ1yCoXEa+vCXAXSauebqq56/ULnFF3LPOp6oOrjax7oHiMvXmM9uvthNkHX1baeH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 17:54:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.017; Thu, 4 Mar 2021
 17:54:04 +0000
Date: Thu, 4 Mar 2021 13:54:02 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC PATCH 15/18] cgroup: Introduce ioasids controller
Message-ID: <20210304175402.GG4247@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <YD+u3CXhwOi2LC+4@slm.duckdns.org> <20210303131726.7a8cb169@jacob-builder>
 <20210303160205.151d114e@jacob-builder> <YECtMZNqSgh7jkGP@myrica>
 <20210304094603.4ab6c1c4@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20210304094603.4ab6c1c4@jacob-builder>
X-ClientProxiedBy: BL1PR13CA0375.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 BL1PR13CA0375.namprd13.prod.outlook.com (2603:10b6:208:2c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.16 via Frontend
 Transport; Thu, 4 Mar 2021 17:54:04 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lHsAk-006gQJ-Ue; Thu, 04 Mar 2021 13:54:02 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614880459; bh=1IsSiLJgMTXbIalwO2pbn+VbK2Xk9986eGeD/lKT7yQ=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-Header;
 b=rDYRwf0dwRc+djrxenqKoY96c9s8HF7iXjhjlMjLqhK7AgVH6nhHtLXOWqj5t6afh
 lRlLZiPC9KLV1CRT6m/HH8hUjiKj4J/qgp8jy29CLE3yY/zivgM0gAL0fTyY7ItEUT
 gAHQeIPZwaga7VM1F/4FXVNfUxC9hE0ZV/HL6apEPfv9s9IMJczvXmjfAiVzbLcjWV
 wbkKRvXO0p6/xkWn+ZArhyau+4P0VUr//MMXazPjODaYUWG7gFwiCOOvQTvKXFiK0q
 5f1xa+nA+hZu6N1SC31B8xRv1PcVkOgp9v2jnkOhuNTtx0++k1MFiF/khEFzvPqp5a
 1uWiZtwPm8+qQ==
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan
 Corbet <corbet@lwn.net>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
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

On Thu, Mar 04, 2021 at 09:46:03AM -0800, Jacob Pan wrote:

> Right, I was assuming have three use cases of IOASIDs:
> 1. host supervisor SVA (not a concern, just one init_mm to bind)
> 2. host user SVA, either one IOASID per process or perhaps some private
> IOASID for private address space
> 3. VM use for guest SVA, each IOASID is bound to a guest process
> 
> My current cgroup proposal applies to #3 with IOASID_SET_TYPE_MM, which is
> allocated by the new /dev/ioasid interface.
> 
> For #2, I was thinking you can limit the host process via PIDs cgroup? i.e.
> limit fork. So the host IOASIDs are currently allocated from the system pool
> with quota of chosen by iommu_sva_init() in my patch, 0 means unlimited use
> whatever is available. https://lkml.org/lkml/2021/2/28/18

Why do we need two pools?

If PASID's are limited then why does it matter how the PASID was
allocated? Either the thing requesting it is below the limit, or it
isn't.

For something like qemu I'd expect to put the qemu process in a cgroup
with 1 PASID. Who cares what qemu uses the PASID for, or how it was
allocated?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
