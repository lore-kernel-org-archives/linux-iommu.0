Return-Path: <SRS0=FJ9b=3U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B84C33CB7
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 23:46:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62EF82071A
	for <iommu@archiver.kernel.org>; Fri, 31 Jan 2020 23:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62EF82071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 220E886AF2;
	Fri, 31 Jan 2020 23:46:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y2c87XUHiC9e; Fri, 31 Jan 2020 23:46:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8C47286AEB;
	Fri, 31 Jan 2020 23:46:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79B62C0178;
	Fri, 31 Jan 2020 23:46:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC88BC0171
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 23:46:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E6F60882EB
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 23:46:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BYFqMz4QmOn0 for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jan 2020 23:46:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1EE19882C4
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 23:46:11 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 15:46:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,387,1574150400"; d="scan'208";a="247892207"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga002.jf.intel.com with ESMTP; 31 Jan 2020 15:46:10 -0800
Date: Fri, 31 Jan 2020 15:51:25 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 3/3] iommu/uapi: Add helper function for size lookup
Message-ID: <20200131155125.53475a72@jacob-builder>
In-Reply-To: <20200129151951.2e354e37@w520.home>
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277724-66994-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200129144046.3f91e4c1@w520.home>
 <20200129151951.2e354e37@w520.home>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

Hi Alex,
Sorry I missed this part in the previous reply. Comments below.

On Wed, 29 Jan 2020 15:19:51 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> Also, is the 12-bytes of padding in struct iommu_gpasid_bind_data
> excessive with this new versioning scheme?  Per rule #2 I'm not sure
> if we're allowed to repurpose those padding bytes,
We can still use the padding bytes as long as there is a new flag bit
to indicate the validity of the new filed within the padding.
I should have made it clear in rule #2 when mentioning the flags bits.
Should define what extension constitutes.
How about this?
"
 * 2. Data structures are open to extension but closed to modification.
 *    Extension should leverage the padding bytes first where a new
 *    flag bit is required to indicate the validity of each new member.
 *    The above rule for padding bytes also applies to adding new union
 *    members.
 *    After padding bytes are exhausted, new fields must be added at the
 *    end of each data structure with 64bit alignment. Flag bits can be
 *    added without size change but existing ones cannot be altered.
 *
"
So if we add new field by doing re-purpose of padding bytes, size
lookup result will remain the same. New code would recognize the new
flag, old code stays the same.

VFIO layer checks for UAPI compatibility and size to copy, version
sanity check and flag usage are done in the IOMMU code.

> but if we add
> fields to the end of the structure as the scheme suggests, we're
> stuck with not being able to expand the union for new fields.
Good point, it does sound contradictory. I hope the rewritten rule #2
address that.
Adding data after the union should be extremely rare. Do you see any
issues with the example below?
 
 offsetofend() can still find the right size.
e.g.
V1
struct iommu_gpasid_bind_data {
	__u32 version;
#define IOMMU_PASID_FORMAT_INTEL_VTD	1
	__u32 format;
#define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
	__u64 flags;
	__u64 gpgd;
	__u64 hpasid;
	__u64 gpasid;
	__u32 addr_width;
	__u8  padding[12];
	/* Vendor specific data */
	union {
		struct iommu_gpasid_bind_data_vtd vtd;
	};
};

const static int
iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = { /*
IOMMU_UAPI_BIND_GPASID */ {offsetofend(struct iommu_gpasid_bind_data,
vtd)}, ...
};

V2, Add new_member at the end (forget padding for now).
struct iommu_gpasid_bind_data {
	__u32 version;
#define IOMMU_PASID_FORMAT_INTEL_VTD	1
	__u32 format;
#define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
#define IOMMU_NEW_MEMBER_VAL	(1 << 1) /* new member added */
	__u64 flags;
	__u64 gpgd;
	__u64 hpasid;
	__u64 gpasid;
	__u32 addr_width;
	__u8  padding[12];
	/* Vendor specific data */
	union {
		struct iommu_gpasid_bind_data_vtd vtd;
	};
	__u64 new_member;
};
const static int
iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = { /*
IOMMU_UAPI_BIND_GPASID */ 
	{offsetofend(struct iommu_gpasid_bind_data,
	vtd), offsetofend(struct iommu_gpasid_bind_data,new_member)},

};

V3, Add smmu to the union,larger than vtd

struct iommu_gpasid_bind_data {
	__u32 version;
#define IOMMU_PASID_FORMAT_INTEL_VTD	1
#define IOMMU_PASID_FORMAT_INTEL_SMMU	2
	__u32 format;
#define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
#define IOMMU_NEW_MEMBER_VAL	(1 << 1) /* new member added */
#define IOMMU_SVA_SMMU_SUPP	(1 << 2) /* SMMU data supported */
	__u64 flags;
	__u64 gpgd;
	__u64 hpasid;
	__u64 gpasid;
	__u32 addr_width;
	__u8  padding[12];
	/* Vendor specific data */
	union {
		struct iommu_gpasid_bind_data_vtd vtd;
		struct iommu_gpasid_bind_data_smmu smmu;
	};
	__u64 new_member;
};
const static int
iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = {
	/* IOMMU_UAPI_BIND_GPASID */
	{offsetofend(struct iommu_gpasid_bind_data,vtd),
	offsetofend(struct iommu_gpasid_bind_data, new_member),
	offsetofend(struct iommu_gpasid_bind_data, new_member)},
...
};
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
