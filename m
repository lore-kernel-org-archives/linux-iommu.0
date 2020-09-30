Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B62C4727F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 09:13:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A1CD20739
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 09:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ih7wiuP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1CD20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7AC0820445;
	Wed, 30 Sep 2020 09:13:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mMq5WaSuQUKv; Wed, 30 Sep 2020 09:13:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id ACCCA20419;
	Wed, 30 Sep 2020 09:13:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 938B1C0889;
	Wed, 30 Sep 2020 09:13:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1494FC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EC9A720419
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:13:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K5L7mgPMELCz for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 09:13:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by silver.osuosl.org (Postfix) with ESMTPS id B1854203A9
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:13:32 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id qp15so798565ejb.3
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 02:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=mEZJKyrS5XxrmfX+vKtoicUX8NBQkBoZwbJX2LIAe+0=;
 b=ih7wiuP+bf+la7nGhKd07HAMuQoInCQcuFWhIzkUi+yZzttx4B1krA3bxzI0gPPPff
 hwhxhhYihEhWCdqd03aGcGtKtGroIXUGJUmp5Z5g2IbySHSWU6PB3wlbfx/doVCMMiK1
 KWBlsF7zPkyp7NE/RgiPvqEz9YQOXCXtrpIRia5Fs1tECUA5w+Qxl6EP141d8GMTqHwN
 VXNtI55nBpFEeteRI6wjS4YAhzIuRDCXF19VfdOimjHjua+c3gZ6OG927v/h41r9Bo0s
 7vxONyxWZcl2PD0S0UGVdhjODG0YzCSkhzMACmYevRcqM0+MaGsZ3iNy2XrwaQjK5qgy
 dsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mEZJKyrS5XxrmfX+vKtoicUX8NBQkBoZwbJX2LIAe+0=;
 b=bHhk0rq7roBfWBeJOYT/Be+Jq5Inlz71XkA0kvl0EGnsRzLLvQXNKxuRxslL5LQ2iP
 v6xDNNqEhAjSneumH+rqi1dSeeQidS7gSRJKXBlBYO2tQ89zSeymjQ9Zkv6We8qwozLO
 7t6RVmKVkxVwGaC07eafU99Lg8XCJpqnNB1pRJuQVNx3dljwMcfSYoM/uVOaXJNEjmhg
 WFhA2tjLj+hQE0bEjJaUOEG5arvF0Kc5Ary5jpveodC6dX5WhYn5NNXsemybP0gLXzgi
 iry/wOjYsT3gFuTTQnyp/3mJbYqrpTdSraNp7yBjCuk96jNFc13I+H6LmJ/nfTWfEDKN
 T3gQ==
X-Gm-Message-State: AOAM531pIWfPIGudgLa2sS90/hsrGq1y9KcC5/DqxNOBY+UzG0MtkXfz
 co/+BI8BFtVtCLNRFsPXtuZkeg==
X-Google-Smtp-Source: ABdhPJyMh3NMUfizgJhdMG1kQkO80F7W0pXAlx5WUXKPEzQLQDdIkW8rI5u7n8prFVkjN8R5XRPUbg==
X-Received: by 2002:a17:907:7290:: with SMTP id
 dt16mr447500ejc.508.1601457211229; 
 Wed, 30 Sep 2020 02:13:31 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id q12sm891542edj.19.2020.09.30.02.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 02:13:30 -0700 (PDT)
Date: Wed, 30 Sep 2020 11:13:11 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v10 01/13] mm: Define pasid in mm
Message-ID: <20200930091311.GB1897266@myrica>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200918101852.582559-2-jean-philippe@linaro.org>
 <20200928222250.GA12847@willie-the-truck>
 <20200928224326.GA3252736@otcwcpicx6.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200928224326.GA3252736@otcwcpicx6.sc.intel.com>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, catalin.marinas@arm.com,
 robin.murphy@arm.com, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, zhangfei.gao@linaro.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Sep 28, 2020 at 10:43:26PM +0000, Fenghua Yu wrote:
> Hi, Will and Jean,
> 
> On Mon, Sep 28, 2020 at 11:22:51PM +0100, Will Deacon wrote:
> > On Fri, Sep 18, 2020 at 12:18:41PM +0200, Jean-Philippe Brucker wrote:
> > > From: Fenghua Yu <fenghua.yu@intel.com>
> > > 
> > > PASID is shared by all threads in a process. So the logical place to keep
> > > track of it is in the "mm". Both ARM and X86 need to use the PASID in the
> > > "mm".
> > > 
> > > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > > ---
> > > https://lore.kernel.org/linux-iommu/1600187413-163670-8-git-send-email-fenghua.yu@intel.com/
> > > ---
> > >  include/linux/mm_types.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > 
> > Acked-by: Will Deacon <will@kernel.org>
> 
> FYI. This patch is in x86 maintainers tree tip:x86/pasid now as part of
> the x86 PASID MSR series.

Ah I missed that, glad to see it in v5.10

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
