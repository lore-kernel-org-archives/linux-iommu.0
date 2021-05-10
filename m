Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E2CC433ED
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 22:26:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD9561585
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 22:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD9561585
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03D8083E4D;
	Mon, 10 May 2021 22:26:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YUmwh4YUSp-7; Mon, 10 May 2021 22:26:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCD3E83DB7;
	Mon, 10 May 2021 22:26:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C353BC000D;
	Mon, 10 May 2021 22:26:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 350A4C0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 22:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 230EA608DF
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 22:26:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VlFtISXM2kek for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 22:26:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 77ECD60781
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 22:26:30 +0000 (UTC)
IronPort-SDR: JLDmbmO1qv/35h/zon0j1xnyPNP4DH+5Q+LRrWpjCnr/AprSLVaADr3hxrE0rs2/aJMusye63x
 vMTH8y8ygYaw==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199353450"
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; d="scan'208";a="199353450"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 15:26:29 -0700
IronPort-SDR: yCwHeJ6rRkGtKNof8GEjqbaKxAz/e7UvMdOJ0H5gQ+/vROArz2qCNRf+ThKjmZy9CsF3QLI59T
 YjeHavqKiVRA==
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; d="scan'208";a="430065112"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 15:26:29 -0700
Date: Mon, 10 May 2021 15:28:54 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210510152854.793ee594@jacob-builder>
In-Reply-To: <20210510163956.GD1002214@nvidia.com>
References: <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder> <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>
 <20210506163240.GA9058@otc-nc-03>
 <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210510123729.GA1002214@nvidia.com>
 <20210510152502.GA90095@otc-nc-03>
 <20210510153111.GB1002214@nvidia.com>
 <20210510162212.GB90095@otc-nc-03>
 <20210510163956.GD1002214@nvidia.com>
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

On Mon, 10 May 2021 13:39:56 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> I still think it is smarter to push a group of RID's into a global
> allocation group and accept there are potential downsides with that
> than to try to force a global allocation group on every RID and then
> try to fix the mess that makes for non-ENQCMD devices.
The proposed ioasid_set change in this set has a token for each set of
IOASIDs.

/**
 * struct ioasid_set - Meta data about ioasid_set
 * @nh:		List of notifiers private to that set
 * @xa:		XArray to store ioasid_set private IDs, can be used for
 *		guest-host IOASID mapping, or just a private IOASID namespace.
 * @token:	Unique to identify an IOASID set
 * @type:	Token types
 * @quota:	Max number of IOASIDs can be allocated within the set
 * @nr_ioasids:	Number of IOASIDs currently allocated in the set
 * @id:		ID of the set
 */
struct ioasid_set {
	struct atomic_notifier_head nh;
	struct xarray xa;
	void *token;
	int type;
	int quota;
	atomic_t nr_ioasids;
	int id;
	struct rcu_head rcu;
	struct misc_cg *misc_cg; /* For misc cgroup accounting */
};

To satisfy your "give me a PASID for this RID" proposal, can we just use
the RID's struct device as the token? Also add a type field to explicitly
indicate global vs per-set(per-RID). i.e.

ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
		       int type, void *private)
Where flags can be:
enum ioasid_hwid_type {
	IOASID_HWID_GLOBAL,
	IOASID_HWID_PER_SET,
};

We are really talking about the HW IOASID, just a reminder.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
