Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D7FC48BE0
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 04:45:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6306560FEF
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 04:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6306560FEF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3114B40382;
	Thu, 10 Jun 2021 04:45:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RVtrPgA0bUEE; Thu, 10 Jun 2021 04:45:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A5C0740380;
	Thu, 10 Jun 2021 04:45:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FDD6C000D;
	Thu, 10 Jun 2021 04:45:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43C39C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2AEC483B22
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:27:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=fudan.edu.cn
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WD1nXAxlOGvS for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 02:27:54 +0000 (UTC)
X-Greylist: delayed 00:06:39 by SQLgrey-1.8.0
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net
 (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
 by smtp1.osuosl.org (Postfix) with SMTP id 3FDA083B1D
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fudan.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
 In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID; bh=NMsSgl6f+0/76cM6TWJIRwVGyQWYDV2Tj3+p
 XgGcVjw=; b=h0DdnxmDGdxo/ZvlIym9A/BSoYA8FvRFABsDpIC8PpAroL2Fg8Q7
 eMnqA0rb9qKSRA0+qUfiTrQuALWbYnYgGcy0NpfWsvH25n66Ow/yXHrH5ZI9ZyxF
 tYYPBkrc22ILJ7++iGriysV4XdC8KFb8NJ42oEyjuZlrvPZUGRe3aIg=
Received: by ajax-webmail-app2 (Coremail) ; Thu, 10 Jun 2021 10:20:24 +0800
 (GMT+08:00)
X-Originating-IP: [10.162.161.90]
Date: Thu, 10 Jun 2021 10:20:24 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
To: "Robin Murphy" <robin.murphy@arm.com>
Subject: Re: Re: [PATCH] iommu/arm-smmu: Fix arm_smmu_device refcount leak
 when arm_smmu_rpm_get fails
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20200917(8294e55f) Copyright (c) 2002-2021 www.mailtech.cn fudan.edu.cn
In-Reply-To: <e5b8d7f6-862e-bca4-a1e9-35e0de47440e@arm.com>
References: <1623245709-11123-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <e5b8d7f6-862e-bca4-a1e9-35e0de47440e@arm.com>
X-SendMailWithSms: false
X-CM-CTRLDATA: ZmoaFmZvb3Rlcl90eHQ9Mzk1ODoxMA==
MIME-Version: 1.0
Message-ID: <3da0a67a.3d4d.179f3b87d02.Coremail.19210240158@fudan.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: XQUFCgCHTGvodsFgpJpUAw--.21437W
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/1tbiAQwIAVKp4t+ptgACsf
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
X-Mailman-Approved-At: Thu, 10 Jun 2021 04:45:06 +0000
Cc: linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
 iommu@lists.linux-foundation.org, Xin Tan <tanxin.ctf@gmail.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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
From: Xiyu Yang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Xiyu Yang <19210240158@fudan.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


Thanks for your advice, I'll send a v2 patch soon.


> -----Original Messages-----
> From: "Robin Murphy" <robin.murphy@arm.com>
> Sent Time: 2021-06-09 22:12:11 (Wednesday)
> To: "Xiyu Yang" <xiyuyang19@fudan.edu.cn>, "Will Deacon" <will@kernel.org>, "Joerg Roedel" <joro@8bytes.org>, "Nicolin Chen" <nicoleotsuka@gmail.com>, "Bjorn Andersson" <bjorn.andersson@linaro.org>, "Krishna Reddy" <vdumpa@nvidia.com>, "Jordan Crouse" <jordan@cosmicpenguin.net>, "Sai Prakash Ranjan" <saiprakash.ranjan@codeaurora.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
> Cc: yuanxzhang@fudan.edu.cn, "Xin Tan" <tanxin.ctf@gmail.com>
> Subject: Re: [PATCH] iommu/arm-smmu: Fix arm_smmu_device refcount leak when arm_smmu_rpm_get fails
> 
> On 2021-06-09 14:35, Xiyu Yang wrote:
> > arm_smmu_rpm_get() invokes pm_runtime_get_sync(), which increases the
> > refcount of the "smmu" even though the return value is less than 0.
> > 
> > The reference counting issue happens in some error handling paths of
> > arm_smmu_rpm_get() in its caller functions. When arm_smmu_rpm_get()
> > fails, the caller functions forget to decrease the refcount of "smmu"
> > increased by arm_smmu_rpm_get(), causing a refcount leak.
> > 
> > Fix this issue by calling arm_smmu_rpm_put() or jumping to the "rpm_put"
> > label when arm_smmu_rpm_get() fails.
> 
> If only there was some kind of helper function which could encapsulate 
> the correct expected behaviour in a single place...
> 
> In fact with the new pm_runtime_resume_and_get() API I think these two 
> patches boil down to a one-line change.
> 
> Thanks,
> Robin.
> 
> > Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> > Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> > ---
> >   drivers/iommu/arm/arm-smmu/arm-smmu.c | 13 +++++++++----
> >   1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index 6f72c4d208ca..177ee54c5534 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -840,7 +840,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
> >   
> >   	ret = arm_smmu_rpm_get(smmu);
> >   	if (ret < 0)
> > -		return;
> > +		goto rpm_put;
> >   
> >   	/*
> >   	 * Disable the context bank and free the page tables before freeing
> > @@ -857,6 +857,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
> >   	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
> >   	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
> >   
> > +rpm_put:
> >   	arm_smmu_rpm_put(smmu);
> >   }
> >   
> > @@ -1153,7 +1154,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >   
> >   	ret = arm_smmu_rpm_get(smmu);
> >   	if (ret < 0)
> > -		return ret;
> > +		goto rpm_put;
> >   
> >   	/* Ensure that the domain is finalised */
> >   	ret = arm_smmu_init_domain_context(domain, smmu, dev);
> > @@ -1404,7 +1405,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> >   
> >   	ret = arm_smmu_rpm_get(smmu);
> >   	if (ret < 0)
> > -		goto out_cfg_free;
> > +		goto rpm_put;
> >   
> >   	ret = arm_smmu_master_alloc_smes(dev);
> >   	arm_smmu_rpm_put(smmu);
> > @@ -1417,6 +1418,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> >   
> >   	return &smmu->iommu;
> >   
> > +rpm_put:
> > +	arm_smmu_rpm_put(smmu);
> >   out_cfg_free:
> >   	kfree(cfg);
> >   out_free:
> > @@ -1438,8 +1441,10 @@ static void arm_smmu_release_device(struct device *dev)
> >   	smmu = cfg->smmu;
> >   
> >   	ret = arm_smmu_rpm_get(smmu);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> > +		arm_smmu_rpm_put(smmu);
> >   		return;
> > +	}
> >   
> >   	arm_smmu_master_free_smes(cfg, fwspec);
> >   
> > 






_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
