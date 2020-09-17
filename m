Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9EFC43461
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 14:37:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B25221E3
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 14:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QGCPcwui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B25221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6912386CE6;
	Thu, 17 Sep 2020 14:37:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pv0GCNWV0i3j; Thu, 17 Sep 2020 14:37:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E513D868BD;
	Thu, 17 Sep 2020 14:37:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C614AC0864;
	Thu, 17 Sep 2020 14:37:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3096EC0051
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2036A86CE6
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:37:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zFl8xmLAPGAZ for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 14:37:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 049D8868BD
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:37:13 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id w5so2341245wrp.8
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=M9gS3287S0Kty1lGdTSSCUjtzHa87iOilMiBEXqgZIk=;
 b=QGCPcwui9PV57DotV3CplBVPzt42u0IkvemUt457Qhs+LHjck33+OGWcTqa7LtXO0s
 uHHrZ8JPmk/b3rEnq+fLJgP1/p0jClEJKL/0bsdwJYEEsIyIEt4nui+gvDAR3XyQsz5R
 rYStTHVP08VBv6suUBEyMYVR1py/TW9AB3eV8cGsVTCM3x1sCxMgxbEukBjucM9bF8Vc
 agHj56m1MLiCSLkt03Pg+BnW8t0jw10/OXMzqMroJqy6WJIMBWcaR0MG7sGor9XlAtTJ
 kqKSL1SPepJb0Sj/FoNlcwaem1AXE2zzX6y79ne5wrBbFML0KNC5iq2EsK2lD7r2xUsl
 3CVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=M9gS3287S0Kty1lGdTSSCUjtzHa87iOilMiBEXqgZIk=;
 b=nXuZoE2x8g6Ze9XRdnnbOZvk4E0pBDwAWe1wka/wlBjiEheC5mgAt2C1Ut8CzvRoPv
 ZBcGV0+gc/fFfPy5BasyT9gpeJlIYh0MT8MLuxhK6ohuVcZWrM44StmDKlaZPXkvlCLv
 gq94Vv370rQY9vNv9Y0nSSSMaWyWVND7YaHk0o3n951GeRXnWKtbl2S7PryM6SgMkjFq
 ncVIHJex0IrqFmV1PzKOjQJkN6j96w4JBrWSznbY/nq3gr/FabuLkHNS8GLaTE21VEF3
 FLXZxV5uIHVX8uRQvOBgPmgfTCrSoB54HncEDfrTp6P1yp3r3z6TCGtq0azh5auioXvc
 AkWA==
X-Gm-Message-State: AOAM533uUNqT5E3A36+UmYwFI08g8lCCa+GbErj7kl4LWcMUl/MjKSWj
 cBBamUG9JLLEXWxaThfLEMalDw==
X-Google-Smtp-Source: ABdhPJy+rAGuUfzGgur2eYJh6s3fwt8jTwpxbS/gPLgICs9OoxIliDD0/uDvO6wDOciThy3TNN1RmQ==
X-Received: by 2002:a5d:56cd:: with SMTP id m13mr32002851wrw.261.1600353431301; 
 Thu, 17 Sep 2020 07:37:11 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id p11sm10707199wma.11.2020.09.17.07.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 07:37:10 -0700 (PDT)
Date: Thu, 17 Sep 2020 16:36:51 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH RESEND v9 03/13] iommu/sva: Add PASID helpers
Message-ID: <20200917143651.GB134903@myrica>
References: <20200817171558.325917-1-jean-philippe@linaro.org>
 <20200817171558.325917-4-jean-philippe@linaro.org>
 <dfdb8dbf-feaa-2c99-3fc8-1ee21515d7f1@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dfdb8dbf-feaa-2c99-3fc8-1ee21515d7f1@redhat.com>
Cc: fenghua.yu@intel.com, will@kernel.org, catalin.marinas@arm.com,
 zhengxiang9@huawei.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On Tue, Sep 08, 2020 at 09:45:02AM +0200, Auger Eric wrote:
> > +int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
> > +{
> > +	int ret = 0;
> > +	ioasid_t pasid;
> > +
> > +	if (min == INVALID_IOASID || max == INVALID_IOASID ||
> > +	    min == 0 || max < min)
> you may add a comment explaining why min == 0 is forbidden.

Right, I'll add to the function doc "@min must be greater than 0 because
0 indicates an unused mm->pasid."

> > +		return -EINVAL;
> > +
> > +	mutex_lock(&iommu_sva_lock);
> > +	if (mm->pasid) {
> > +		if (mm->pasid >= min && mm->pasid <= max)
> > +			ioasid_get(mm->pasid);
> > +		else
> > +			ret = -EOVERFLOW;
> > +	} else {
> > +		pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> > +		if (pasid == INVALID_IOASID)
> > +			ret = -ENOMEM;
> > +		else
> > +			mm->pasid = pasid;
> > +	}
> > +	mutex_unlock(&iommu_sva_lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
> > +
> > +/**
> > + * iommu_sva_free_pasid - Release the mm's PASID
> > + * @mm: the mm.
> > + *
> > + * Drop one reference to a PASID allocated with iommu_sva_alloc_pasid()
> > + */
> > +void iommu_sva_free_pasid(struct mm_struct *mm)
> > +{
> > +	mutex_lock(&iommu_sva_lock);
> > +	if (ioasid_put(mm->pasid))
> > +		mm->pasid = 0;
> ditto: 0 versus INVALID_IOASID
> > +	mutex_unlock(&iommu_sva_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
> > +
> > +/* ioasid wants a void * argument */
> shouldn't it be:
> ioasid_find getter() requires a void *arg?

Ok

Thanks,
Jean

> > +static bool __mmget_not_zero(void *mm)
> > +{
> > +	return mmget_not_zero(mm);
> > +}
> > +
> > +/**
> > + * iommu_sva_find() - Find mm associated to the given PASID
> > + * @pasid: Process Address Space ID assigned to the mm
> > + *
> > + * On success a reference to the mm is taken, and must be released with mmput().
> > + *
> > + * Returns the mm corresponding to this PASID, or an error if not found.
> > + */
> > +struct mm_struct *iommu_sva_find(ioasid_t pasid)
> > +{
> > +	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_sva_find);
> > 
> Thanks
> 
> Eric
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
