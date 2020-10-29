Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393FFC4363A
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 06:34:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF2421548
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 06:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF2421548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C85F587541;
	Thu, 29 Oct 2020 06:34:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O6fGLKuvZ0-Z; Thu, 29 Oct 2020 06:34:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6961E87537;
	Thu, 29 Oct 2020 06:34:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 325C9C0859;
	Thu, 29 Oct 2020 06:34:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2562C0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 06:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E4A7B869A0
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 06:34:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lSehavVpdTFE for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 06:34:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 98B7C86995
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 06:34:43 +0000 (UTC)
IronPort-SDR: sG4N1MnXa5P924pLnBkNlAo+96Ap4aj1N4CVfSQKO7rw4hxGy7FK3M0ZkR7EJ6+pDDzGA+1/4A
 LaHs9v/2HPbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="164888524"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; d="scan'208";a="164888524"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2020 23:34:43 -0700
IronPort-SDR: TO89TgFWTBwxKI1wY/dCWuN+2xZpIKFfD6OZHHKIi+BrK8tmn4aUkmjc/QmsD+amF7DblA7KJy
 ArXxYTG5KI9Q==
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; d="scan'208";a="536544945"
Received: from yisun1-ubuntu.bj.intel.com (HELO yi.y.sun) ([10.238.156.116])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA256;
 28 Oct 2020 23:34:41 -0700
Date: Thu, 29 Oct 2020 14:30:02 +0800
From: Yi Sun <yi.y.sun@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v1 2/3] iommu: Fix an issue in iommu_page_response()
 flags check
Message-ID: <20201029063002.GE27139@yi.y.sun>
References: <1603849018-6578-1-git-send-email-yi.y.sun@linux.intel.com>
 <1603849018-6578-3-git-send-email-yi.y.sun@linux.intel.com>
 <20201028091356.GB2328726@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201028091356.GB2328726@myrica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: linux-kernel@vger.kernel.org, dwmw2@infradead.org,
 iommu@lists.linux-foundation.org
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

On 20-10-28 10:13:56, Jean-Philippe Brucker wrote:
> Hi,
> 
> On Wed, Oct 28, 2020 at 09:36:57AM +0800, Yi Sun wrote:
> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > 
> > original code fails when LAST_PAGE is set in flags.
> 
> LAST_PAGE is not documented to be a valid flags for page_response.
> So isn't failing the right thing to do?
> 
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > ---
> >  drivers/iommu/iommu.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 8c470f4..053cec3 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1200,9 +1200,11 @@ int iommu_page_response(struct device *dev,
> >  		return -EINVAL;
> >  
> >  	if (msg->version != IOMMU_PAGE_RESP_VERSION_1 ||
> > -	    msg->flags & ~IOMMU_PAGE_RESP_PASID_VALID)
> > +		!(msg->flags & IOMMU_PAGE_RESP_PASID_VALID)) {
> 
> It should be OK not to have PASID_VALID set, we're just checking for
> undefined flags here.
> 
Thanks! You are right. Per published spec, we should not care LAST_PAGE
for page_response. I will remove this patch in next version.
 
> Thanks,
> Jean
> 
> > +		dev_warn_ratelimited(dev, "%s:Invalid ver %x: flags %x\n",
> > +				__func__, msg->version, msg->flags);
> >  		return -EINVAL;
> > -
> > +	}
> >  	/* Only send response if there is a fault report pending */
> >  	mutex_lock(&param->fault_param->lock);
> >  	if (list_empty(&param->fault_param->faults)) {
> > -- 
> > 2.7.4
> > 
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
