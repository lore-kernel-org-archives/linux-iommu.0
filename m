Return-Path: <SRS0=0Jvo=UX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F1CC48BD3
	for <iommu@archiver.kernel.org>; Mon, 24 Jun 2019 23:56:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B968206DD
	for <iommu@archiver.kernel.org>; Mon, 24 Jun 2019 23:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B968206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DE387BBC;
	Mon, 24 Jun 2019 23:56:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B0C2EB3E
	for <iommu@lists.linux-foundation.org>;
	Mon, 24 Jun 2019 23:56:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DCE09A7
	for <iommu@lists.linux-foundation.org>;
	Mon, 24 Jun 2019 23:56:36 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 Jun 2019 16:56:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; d="scan'208";a="336667312"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga005.jf.intel.com with ESMTP; 24 Jun 2019 16:56:35 -0700
Date: Mon, 24 Jun 2019 16:59:51 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v4 19/22] iommu/vt-d: Clean up for SVM device list
Message-ID: <20190624165951.0646b788@jacob-builder>
In-Reply-To: <20190618174237.00000556@huawei.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1560087862-57608-20-git-send-email-jacob.jun.pan@linux.intel.com>
	<20190618174237.00000556@huawei.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, 18 Jun 2019 17:42:37 +0100
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Sun, 9 Jun 2019 06:44:19 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > Use combined macro for_each_svm_dev() to simplify SVM device
> > iteration.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > ---
> >  drivers/iommu/intel-svm.c | 79
> > +++++++++++++++++++++++------------------------ 1 file changed, 39
> > insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index 9cbcc1f..66d98e1 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -225,6 +225,9 @@ static const struct mmu_notifier_ops
> > intel_mmuops = { 
> >  static DEFINE_MUTEX(pasid_mutex);
> >  static LIST_HEAD(global_svm_list);
> > +#define for_each_svm_dev() \
> > +	list_for_each_entry(sdev, &svm->devs, list)	\
> > +	if (dev == sdev->dev)				\  
> 
> Could we make this macro less opaque and have it take the svm and dev
> as arguments?
> 
sounds good, it makes the code more readable.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
