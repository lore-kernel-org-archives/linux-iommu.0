Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF662C4727F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 09:12:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F4320738
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 09:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mi3y3DIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F4320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 845632155B;
	Wed, 30 Sep 2020 09:12:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2bSznVCzLjTM; Wed, 30 Sep 2020 09:12:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 709F2203EE;
	Wed, 30 Sep 2020 09:12:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BD46C0889;
	Wed, 30 Sep 2020 09:12:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C22CAC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B764E84FDE
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:12:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HCfhiA_LVqlk for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 09:12:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C874F84806
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:12:44 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id p9so1712617ejf.6
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BQsaKcSiC8aNb23HkSeLq7x1ilVL8+ynGBSHFTMdGWk=;
 b=mi3y3DIGVvmZI34+a54S97B6ZMbeo9l8i+KCp84tBeQZIBVFyMhcMy0Ny+xA+BuhSz
 GuWPD9OzC8purWPx+dqjsrApSsnICwHtWU3iADPKHNDnwTZO//xQynYUXZUBHEyREaOU
 ARH/ah+rx5xPQQbWazO7rfIsvHyqOTjpPYRj+dnyIrpu2DlS/4vYvKUTHV3WWVa7csXU
 NXffTNf/yuZpzSEIP7j7QbYg1FLdJDLYcFAxJ8jzpqEn+AhhTHHhY1pQqvYBWZPIZ5Ym
 0AI8Jh4h43w8EDovCgQfhVpTSsGCJqjQ75HVkDzOGiBatemegBVuK5avacAQc/v0sace
 pYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BQsaKcSiC8aNb23HkSeLq7x1ilVL8+ynGBSHFTMdGWk=;
 b=XMF3EA0N3kRroDRnUiAVpr9SN7aeBglTRtdukoBVwS7HpsRBgiqvxn4LThOFTw0cpe
 h5dRevwMYTgT0uY4UUOiIlGsMFTtGI8yFOV+ulWn00Cx708WcL4iP0LpprlDEhfU6nZ8
 ZMI4z+uG4Hr094pMQrTATgU+WNKv37FXJWPSETYCIWpE5MYpafsKKufeDboImAcLXgMu
 HlDgk81jcLshi72UOvdEkGU7gEAa+RPjitWY/Sns0DW2WtKXZqC/IJL4H0BjSXenoPJU
 evA84CK+kfnJ/TKfC+rccOYa47YxoeZVxXBkCdptaHUgz4s2tITz967TdPGa4ZtUcIls
 wEtg==
X-Gm-Message-State: AOAM531KZyR4MmJP6P75/Tdjc3fzzQ7v05r4OPH1FkHJaph7i3e9rHbx
 b79pLu99S7F4r8+mscdbIJo5Ag==
X-Google-Smtp-Source: ABdhPJwtlYUpWOUk4+wPHkvPUZpdjUDHEzfiF7mK/m1cLMnEo137JN9oZLJ14YQchSt/h/HcjWFPBg==
X-Received: by 2002:a17:906:e88:: with SMTP id
 p8mr1937921ejf.134.1601457163267; 
 Wed, 30 Sep 2020 02:12:43 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id t24sm902244edc.40.2020.09.30.02.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 02:12:42 -0700 (PDT)
Date: Wed, 30 Sep 2020 11:12:23 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v10 00/13] iommu: Shared Virtual Addressing for SMMUv3
 (PT sharing part)
Message-ID: <20200930091223.GA1897266@myrica>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200928164731.GB1459218@myrica>
 <20200928172315.GA11792@willie-the-truck>
 <20200928223901.GB12847@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200928223901.GB12847@willie-the-truck>
Cc: fenghua.yu@intel.com, linux-mm@kvack.org, catalin.marinas@arm.com,
 iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On Mon, Sep 28, 2020 at 11:39:02PM +0100, Will Deacon wrote:
> On Mon, Sep 28, 2020 at 06:23:15PM +0100, Will Deacon wrote:
> > On Mon, Sep 28, 2020 at 06:47:31PM +0200, Jean-Philippe Brucker wrote:
> > > On Fri, Sep 18, 2020 at 12:18:40PM +0200, Jean-Philippe Brucker wrote:
> > > > This is version 10 of the page table sharing support for Arm SMMUv3.
> > > > Patch 1 still needs an Ack from mm maintainers. However patches 4-11 do
> > > > not depend on it, and could get merged for v5.10 regardless.
> > > 
> > > Are you OK with taking patches 4-11 for v5.10?
> > > 
> > > The rest depends on patch 1 which hasn't been acked yet. It's
> > > uncontroversial and I'm sure it will eventually make it. In case it
> > > doesn't, we'll keep track of mm->pasid within the IOMMU subsystem instead.
> > 
> > I was off most of last week, but I plan to see how much of this I can queue
> > tonight. Stay tuned...
> 
> I've queued 4-11 locally, but I've put 4 and 6 on a shared branch with arm64
> (for-next/svm) so I'd like that to hit next before I push out the merge into
> the branch for Joerg.

Great, thanks! I'll split the remainder into two or three small series

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
