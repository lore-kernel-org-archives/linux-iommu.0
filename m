Return-Path: <SRS0=byW0=34=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B9DC35254
	for <iommu@archiver.kernel.org>; Sat,  8 Feb 2020 08:47:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E638217BA
	for <iommu@archiver.kernel.org>; Sat,  8 Feb 2020 08:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E638217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2C10A868D1;
	Sat,  8 Feb 2020 08:47:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oA8dzyNqNHFf; Sat,  8 Feb 2020 08:46:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 42224866F2;
	Sat,  8 Feb 2020 08:46:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20624C0178;
	Sat,  8 Feb 2020 08:46:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46F1BC013E
 for <iommu@lists.linux-foundation.org>; Sat,  8 Feb 2020 08:46:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 311E282476
 for <iommu@lists.linux-foundation.org>; Sat,  8 Feb 2020 08:46:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IYxx4YzojoxX for <iommu@lists.linux-foundation.org>;
 Sat,  8 Feb 2020 08:46:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EE7F887C17
 for <iommu@lists.linux-foundation.org>; Sat,  8 Feb 2020 08:46:54 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Feb 2020 00:46:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,416,1574150400"; d="scan'208";a="250691345"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga002.jf.intel.com with ESMTP; 08 Feb 2020 00:46:53 -0800
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 8 Feb 2020 00:46:53 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 8 Feb 2020 00:46:53 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.5]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.55]) with mapi id 14.03.0439.000;
 Sat, 8 Feb 2020 16:46:50 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [RFC v3 2/8] vfio/type1: Make per-application (VM) PASID quota
 tunable
Thread-Topic: [RFC v3 2/8] vfio/type1: Make per-application (VM) PASID quota
 tunable
Thread-Index: AQHV1pyUqT1ciCuF4kOFYogFFmLhrqgPqnuAgAFZAdA=
Date: Sat, 8 Feb 2020 08:46:50 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A1B5847@SHSMSX104.ccr.corp.intel.com>
References: <1580299912-86084-1-git-send-email-yi.l.liu@intel.com>
 <1580299912-86084-3-git-send-email-yi.l.liu@intel.com>
 <20200207114345.2071a482@jacob-builder>
In-Reply-To: <20200207114345.2071a482@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmVjYjE1M2EtOTUzOS00MTQyLWI0NjctYjAyMjRhMzE1ZWNlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaDE2amUyT0hFa29kR3JHRXNGTG1peEQrTXdBejQ3dmR6b1NabURjWUIxWEp2Z1VlYWU3QXdsV21Wd2NUT24yVyJ9
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

Hi Jacob,

> From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> Sent: Saturday, February 8, 2020 3:44 AM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v3 2/8] vfio/type1: Make per-application (VM) PASID quota tunable
> 
> On Wed, 29 Jan 2020 04:11:46 -0800
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > From: Liu Yi L <yi.l.liu@intel.com>
> >
> > The PASID quota is per-application (VM) according to vfio's PASID
> > management rule. For better flexibility, quota shall be user tunable
> > . This patch provides a VFIO based user interface for which quota can
> > be adjusted. However, quota cannot be adjusted downward below the
> > number of outstanding PASIDs.
> >
> > This patch only makes the per-VM PASID quota tunable. While for the
> > way to tune the default PASID quota, it may require a new vfio module
> > option or other way. This may be another patchset in future.
> >
> One issue we need to solve is how to share PASIDs at the system
> level, e.g. Both VMs and baremetal drivers could use PASIDs.
> 
> This patch is granting quota to a guest w/o knowing the remaining
> system capacity. So guest PASID allocation could fail even within its
> quota.

that's true.

> The solution I am thinking is to enforce quota at IOASID common
> code, since IOASID APIs already used to manage system-wide allocation.
> How about the following changes to IOASID?
> 1. introduce quota in ioasid_set (could have a soft limit for better
> sharing)
>
> 2. introduce an API to create a set with quota before allocation, e.g.
> ioasid_set_id = ioasid_alloc_set(size, token)
> set_id will be used for ioasid_alloc() instead of token.

Is the token the mm pointer? I guess you may want to add one more
API like ioasid_get_set_id(token), thus that other ioasid user could get
set_id with their token. If token is the same give them the same set_id.

> 
> 3. introduce API to adjust set quota ioasid_adjust_set_size(set_id,
> size)
> 
> 4. API to check remaining PASIDs ioasid_get_capacity(set_id); //return
> system capacity if set_id == 0;
> 
> 5. API to set system capacity, ioasid_set_capacity(nr_pasids), e.g. if
> system has 20 bit PASIDs, IOMMU driver needs to call
> ioasid_set_capacity(1<<20) during boot.

yes, this is definitely necessary.

> 6. Optional set level APIs. e.g. ioasid_free_set(set_id), frees all
> IOASIDs in the set.

If this is provided. I think VFIO may be not necessary to track allocated
PASIDs. When VM is down or crashed, VFIO just use this API to reclaim
allocated PASIDs.

> With these APIs, this patch could query PASID capacity at both system
> and set level and adjust quota within range. i.e.
> 1. IOMMU vendor driver(or other driver to use PASID w/o IOMMU) sets
> system wide capacity during boot.
> 2. VFIO Call ioasid_alloc_set() when allocating vfio_mm(), set default
> quota
> 3. Adjust quota per set with ioasid_adjust_set_size() as the tunable in
> this patch.

I think this is abstraction of the allocated PASID track logic in a common
layer. It would simplify user logic.

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
