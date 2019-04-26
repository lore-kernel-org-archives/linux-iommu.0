Return-Path: <SRS0=codQ=S4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D1EC43218
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 15:47:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A461205ED
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 15:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A461205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EB48028CF;
	Fri, 26 Apr 2019 15:47:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DF56B2738
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 15:44:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7C02382A
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 15:44:48 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	26 Apr 2019 08:44:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,398,1549958400"; d="scan'208";a="139087744"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga006.jf.intel.com with ESMTP; 26 Apr 2019 08:44:47 -0700
Date: Fri, 26 Apr 2019 08:47:31 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: iommu/vt-d: drop mm use count if address is not canonical
Message-ID: <20190426084731.7481d384@jacob-builder>
In-Reply-To: <20190426133846.GC24576@8bytes.org>
References: <1555492377-79859-1-git-send-email-bianpan2016@163.com>
	<20190426133846.GC24576@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Pan Bian <bianpan2016@163.com>, David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190426154731.bO31G6Z2eeDbtbs_jyZuaU7XPWPYc73F0-t42iwBz54@z>

On Fri, 26 Apr 2019 15:38:46 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> [ Adding more people. ]
> 
> On Wed, Apr 17, 2019 at 05:12:57PM +0800, Pan Bian wrote:
> > The use count of svm->mm is incremented by mmget_not_zero. However,
> > it is not dropped when the address is not canonical. This patch
> > fixes the bug.
> > 
> > Fixes: 9d8c3af31607("iommu/vt-d: IOMMU Page Request needs to check
> > if address is canonical.")
> > 
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> > ---
> >  drivers/iommu/intel-svm.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index 3a4b09a..2630d2e 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -574,8 +574,10 @@ static irqreturn_t prq_event_thread(int irq,
> > void *d) goto bad_req;
> >  
> >  		/* If address is not canonical, return invalid
> > response */
> > -		if (!is_canonical_address(address))
> > +		if (!is_canonical_address(address)) {
> > +			mmput(svm->mm);
> >  			goto bad_req;
> > +		}
> >  
> >  		down_read(&svm->mm->mmap_sem);
> >  		vma = find_extend_vma(svm->mm, address);  
> 
> I think it is better to move the canonical address check before
> mmget_not_zero() like in the diff below. But I let David and Jacob
> comment on this.
> 
Looks good to me. Tested with PRQ and fake non canonical address then
send an invalid page response.

 Tested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>


> Regards,
> 
> 	Joerg
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 8f87304f915c..5e9e1eee8336 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -586,14 +586,15 @@ static irqreturn_t prq_event_thread(int irq,
> void *d)
>  		 * any faults on kernel addresses. */
>  		if (!svm->mm)
>  			goto bad_req;
> -		/* If the mm is already defunct, don't handle
> faults. */
> -		if (!mmget_not_zero(svm->mm))
> -			goto bad_req;
>  
>  		/* If address is not canonical, return invalid
> response */ if (!is_canonical_address(address))
>  			goto bad_req;
>  
> +		/* If the mm is already defunct, don't handle
> faults. */
> +		if (!mmget_not_zero(svm->mm))
> +			goto bad_req;
> +
>  		down_read(&svm->mm->mmap_sem);
>  		vma = find_extend_vma(svm->mm, address);
>  		if (!vma || address < vma->vm_start)

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
