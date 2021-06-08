Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE76C4743D
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 14:55:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 777116128D
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 14:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777116128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4001D4012F;
	Tue,  8 Jun 2021 14:55:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4G1et92o8usV; Tue,  8 Jun 2021 14:55:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2849840117;
	Tue,  8 Jun 2021 14:55:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC43BC000D;
	Tue,  8 Jun 2021 14:55:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E09BC0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 14:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F8B883AE6
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 14:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cJf199S4MqKr for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 14:55:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8062383A77
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 14:55:04 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id u18so15862144pfk.11
 for <iommu@lists.linux-foundation.org>; Tue, 08 Jun 2021 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BXIJhrJtCnUwRr3BS6zPrJx1Jt47CrNizQ5dotc5JuM=;
 b=r9YQx1mjItYpJg8dKYY7v+z8vtEZRnEaBoGEki83EOyzIKmBac8w1hvvpwk4MhwWh1
 mBrEmQV6jbXnHYAW85BnGXYKSq1KMOYZsBdRzlr9fGLdwg5BCy2jqB56q5IvJaOvHJMy
 4tH04qu4LNbldjD4k6i0AL1GQ19OIBYG3QOkyY4eAL7AEQNqogQebUxqI66dDmLLIpq2
 VIMJxLhWIfwwP+zfFpXtjMGYFJnCKoa9PL+iBiW/nw4uzdWS2KSCzpFK4kWiuo657rFn
 tYxnyHQfK8pnT4Bp9BMJu3UXy6KIQtkVx4DZN+ueAwql2VR9ULeoYehQtkHTF34MsDFN
 MBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BXIJhrJtCnUwRr3BS6zPrJx1Jt47CrNizQ5dotc5JuM=;
 b=J1d78+xkzZsudBj70EHwBS1B1Pwfai3bcoJgQ7Ay6B1jpFm1HKYp8xPZRgj9pBb5FG
 AJwp6Sl/PQNyMGgCALVyAT4dl9tpTxDM9cPzvZcvnroa7Py9lwFLEMIhaR7JbLatsqO4
 EA8sbYYewKTGMPGa7pqBjfInHnTdqfCn/kHcdda73Ifw9cxQiYCvJlNOCluyoKSah1SV
 YBKchFxPsRvtfAdvwC/R079sLdPLoQ0VmdKZS50uUa6/M6XJAZzZrT+blcfIH3ifEIMT
 CyYcUVWsWV8nd3KjoxPOo0fAiSK++oTsCW9khtvE5lwgTmtXdaxOxYVfpI7Z20k/SCB1
 sv/Q==
X-Gm-Message-State: AOAM5302qzL7fgFqwzH0teUIVGuugAqbGy1VMjlXLHY0Oaz/B5Pam6NU
 rKGOQzaFNBsZz5fLXMM8Otw=
X-Google-Smtp-Source: ABdhPJyKxi1AwxQYdbPLhPt/9PtnIXI+zxCtPTWSSFFYrmDMjiZTlo6M3Xy70SGobC4sSTE6fy/pYQ==
X-Received: by 2002:aa7:8194:0:b029:2aa:db3a:4c1d with SMTP id
 g20-20020aa781940000b02902aadb3a4c1dmr308216pfi.58.1623164103922; 
 Tue, 08 Jun 2021 07:55:03 -0700 (PDT)
Received: from localhost ([103.200.106.115])
 by smtp.gmail.com with ESMTPSA id gg22sm2569437pjb.17.2021.06.08.07.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jun 2021 07:55:03 -0700 (PDT)
Date: Tue, 8 Jun 2021 20:25:00 +0530
From: Amey Narkhede <ameynarkhede03@gmail.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/qcom: Cleanup resources in case of probe error path
Message-ID: <20210608145500.wxtes4wpp4rpw7si@archlinux>
References: <20210421221030.70647-1-ameynarkhede03@gmail.com>
 <20210608092958.GA8935@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210608092958.GA8935@willie-the-truck>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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

On 21/06/08 10:29AM, Will Deacon wrote:
> On Thu, Apr 22, 2021 at 03:40:30AM +0530, Amey Narkhede wrote:
> > If device registration fails, remove sysfs attribute
> > and if setting bus callbacks fails, unregister the device
> > and cleanup the sysfs attribute.
> >
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> >  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> > index 4294abe389b2..5fa128a1f7f0 100644
> > --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> > +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> > @@ -850,10 +850,12 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
> >  	ret = iommu_device_register(&qcom_iommu->iommu, &qcom_iommu_ops, dev);
> >  	if (ret) {
> >  		dev_err(dev, "Failed to register iommu\n");
> > -		return ret;
> > +		goto err_sysfs_remove;
> >  	}
> >
> > -	bus_set_iommu(&platform_bus_type, &qcom_iommu_ops);
> > +	ret = bus_set_iommu(&platform_bus_type, &qcom_iommu_ops);
> > +	if (ret)
> > +		goto err_unregister_device;
> >
> >  	if (qcom_iommu->local_base) {
> >  		pm_runtime_get_sync(dev);
> > @@ -862,6 +864,14 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
> >  	}
> >
> >  	return 0;
> > +
> > +err_unregister_device:
> > +	iommu_device_unregister(&qcom_iommu->iommu);
> > +
> > +err_sysfs_remove:
> > +	iommu_device_sysfs_remove(&qcom_iommu->iommu);
> > +
> > +	return ret;
>
> It looks like we're also missing this logic in arm-smmu/arm-smmu.c and
> arm-smmu-v3/arm-smmu-v3.c. Would you be able to fix those up too, please?
>
> Will

Sure, I will send a v2 with this and new patches.

Thanks,
Amey
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
