Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839F9C433DF
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 16:08:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481ED20722
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 16:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vJES/+xz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481ED20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 17B8088B26;
	Mon,  6 Jul 2020 16:08:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LUvxf8ph2flq; Mon,  6 Jul 2020 16:08:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A28F488B21;
	Mon,  6 Jul 2020 16:08:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F734C0891;
	Mon,  6 Jul 2020 16:08:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68C08C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 16:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 56FB588B26
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 16:08:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O-Mgb7V7bcXQ for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 16:08:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6458B88B21
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 16:08:09 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id w16so43161110ejj.5
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jul 2020 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1xUXHKj/YS+LMXJkB0rL4tXNdCvgKAcEoLN/OkMmiNU=;
 b=vJES/+xzdUqwhhJUFgO089lN1T7eUjgt8TfB3iBwPvCtp++QgR0DlF4ZWoxXXJCCEG
 OADqA3qt+pPtLqUnSgvUuGh16D6h8P6Sbp13a00Wbr4VgWLrkrtf9HCImMl3ylMA+At2
 PGtlalmUUd7tJpP8pXe/EYHZsNdaTzPL9a9WB1xeNekiVS2MEeKYI/u475QRwZeovqhx
 qUaTrS49vBXHBVA0AQDzS0WEE5ZrPiSEFNwUyaDVajRB4s0ljWrFf3TcY8F9HVsx0v9P
 bnw7DfflCTjZyXq1dFBzxtK70MQgte2e2a7lhwgCjqBjOVVHEjGpcGK0MT0u7hkYoZ2X
 Zwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1xUXHKj/YS+LMXJkB0rL4tXNdCvgKAcEoLN/OkMmiNU=;
 b=g/ZpqJraNX5SakGiAUks1Fzqrws5AUuBRvOWH6ssFqronOddf9wzTSAgrGshBwxywF
 aJhL4V8dc5GMMDNTTZEseJQw3F6Yu7GLKE6Z67E78bl0w/Pwr6pEPeH1fHM22GsIj6A3
 u8HZWLzZg8UAqpYNwndTOZD4lVDGLYn7lhrquwKKLFZYPLSvPZ1SLMxMyHC92X8ctLsS
 J1sKeFGEdykJYT1Kmmpby85nacTB5Gkb28YbzTo2IaTLKufVaQqecr3cfqNnfSiWtrM5
 lXFS4rJ2ephELC8FUsN9+L5mbRvWfDiCsGMqTWSqHFST+p+B/aa5VI6fJpjIDFRIrLGb
 kMAg==
X-Gm-Message-State: AOAM533BG9LCqw4T8/15xq1m0v7EgV3WXWmVVgwMmqQA64LcQmZRDmNF
 1DK9Pvbgb0Z4asz4JCSXwGljQg==
X-Google-Smtp-Source: ABdhPJyqhjNzsIQVK3sx/+PbtHoTptnYcLcBiN/qpkKug5wTizE32WmmJkFDoGC2JkQANvNOR8AJMA==
X-Received: by 2002:a17:906:7208:: with SMTP id
 m8mr45768067ejk.544.1594051687699; 
 Mon, 06 Jul 2020 09:08:07 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id 23sm25955379edw.63.2020.07.06.09.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 09:08:07 -0700 (PDT)
Date: Mon, 6 Jul 2020 18:07:55 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Xiang Zheng <zhengxiang9@huawei.com>
Subject: Re: [PATCH v8 08/12] iommu/arm-smmu-v3: Seize private ASID
Message-ID: <20200706160755.GB3214@myrica>
References: <20200618155125.1548969-1-jean-philippe@linaro.org>
 <20200618155125.1548969-9-jean-philippe@linaro.org>
 <c3ee2919-bec1-33ba-59f6-c3438e128ed5@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c3ee2919-bec1-33ba-59f6-c3438e128ed5@huawei.com>
Cc: fenghua.yu@intel.com, catalin.marinas@arm.com, robin.murphy@arm.com,
 hch@infradead.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Wang Haibin <wanghaibin.wang@huawei.com>, zhangfei.gao@linaro.org,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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

Hi Xiang,

On Mon, Jul 06, 2020 at 08:40:27PM +0800, Xiang Zheng wrote:
> > @@ -1836,7 +1880,20 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
> >  
> >  	arm_smmu_init_cd(cd);
> >  
> > +	/*
> > +	 * Serialize against arm_smmu_domain_finalise_s1() and
> > +	 * arm_smmu_domain_free() as we might need to replace the private ASID
> > +	 * from an existing CD.
> > +	 */
> > +	mutex_lock(&asid_lock);
> >  	old_cd = arm_smmu_share_asid(asid);
> > +	if (!old_cd) {
> > +		ret = xa_insert(&asid_xa, asid, cd, GFP_KERNEL);
> 
> Should we use "xa_store" here? If "asid" has already been used for private, old_cd would be NULL and
> the entry indexed by "asid" in the asid_xa remains.

Great catch, that's a bug introduced in v7. arm_smmu_share_asid() would
allocate a new asid for the private context but does not remove the old
entry. For the fix I think it looks clearer if arm_smmu_share_asid()
erases the old entry before returning.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
