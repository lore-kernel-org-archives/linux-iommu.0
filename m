Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D418DC433B4
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 03:54:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8146191D
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 03:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8146191D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B1ED60698;
	Tue, 11 May 2021 03:54:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qN87V00jtTWH; Tue, 11 May 2021 03:54:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10C47606A0;
	Tue, 11 May 2021 03:54:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1B5AC000E;
	Tue, 11 May 2021 03:54:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEEB9C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 03:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD31C40186
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 03:54:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3J6PAvsrN6bY for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 03:54:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12F05400C3
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 03:54:12 +0000 (UTC)
IronPort-SDR: 0mNkaxn/44Avsi386CcAwHtlPaNIcj9nMNN58kXTcpmj9dVBPbI1GWMFqjyh6V2asWvnkEAUcN
 LWIgLdyFnmzg==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199024670"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="199024670"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 20:54:08 -0700
IronPort-SDR: BGkUROo0isoG62lW2JllWLXLCmesj1plEIE8OeOyfJmGo/B2YJ6alU7HCdoy+34HdAxDy4SOl8
 qxbcEgvx9lNw==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="408616471"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 20:54:08 -0700
Date: Mon, 10 May 2021 20:56:32 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210510205632.13ff7308@jacob-builder>
In-Reply-To: <20210510234500.GI1002214@nvidia.com>
References: <YJOZhPGheTSlHtQc@myrica> <20210506122730.GQ1370958@nvidia.com>
 <20210506163240.GA9058@otc-nc-03>
 <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210510123729.GA1002214@nvidia.com>
 <20210510152502.GA90095@otc-nc-03>
 <20210510153111.GB1002214@nvidia.com>
 <20210510162212.GB90095@otc-nc-03>
 <20210510163956.GD1002214@nvidia.com>
 <20210510152854.793ee594@jacob-builder>
 <20210510234500.GI1002214@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu, 
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

Hi Jason,

On Mon, 10 May 2021 20:45:00 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, May 10, 2021 at 03:28:54PM -0700, Jacob Pan wrote:
> 
> > To satisfy your "give me a PASID for this RID" proposal, can we just use
> > the RID's struct device as the token? Also add a type field to
> > explicitly indicate global vs per-set(per-RID). i.e.  
> 
> You've got it backwards, the main behavior should be to allocate PASID
> per RID.
> 
Sure, we can make the local PASID as default. My point was that the
ioasid_set infrastructure's opaque token can support RID-local allocation
scheme. Anyway, this is a small detail as compared to uAPI.

> The special behavior is to bundle a bunch of PASIDs into a grouping
> and then say the PASID number space is shared between all the group
> members. 
> 
> /dev/ioasid should create and own this grouping either implicitly or
> explicitly. Jumping ahead to in-kernel APIs has missed the critical
> step of defining the uAPI and all the behaviors together in a
> completed RFC proposal.
> 
Agreed, the requirements for kernel API should come from uAPI.

> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
