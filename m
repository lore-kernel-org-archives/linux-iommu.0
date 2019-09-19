Return-Path: <SRS0=51CA=XO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E02DC4CEC9
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 00:52:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03845218AF
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 00:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LvjG/HWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03845218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B8CB1AF0;
	Thu, 19 Sep 2019 00:52:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B344672A
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 00:52:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
	[209.85.214.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5A3CC76D
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 00:52:27 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id s17so772624plp.2
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 17:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=message-id:mime-version:content-transfer-encoding:in-reply-to
	:references:cc:to:from:subject:user-agent:date;
	bh=aUj5fH8SCIRKe1iMCkfPanIAovLrp8yYl66o/9NYKWo=;
	b=LvjG/HWQ46JzRrzs779G3GUc2EUjja+6eYYCQW+CN+ECtbzPA3uUmtYDCKTNyR9LTE
	vYcTOE+Bdm75vukwGdygoVdqTbrnQDtgCiOcL9mlcxORzWG5D7FSAknjtuIKnOOYd+BG
	lPkVmU8VbFq0PyVn9gLlHjMP6ZEHHkbe9eaB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:mime-version
	:content-transfer-encoding:in-reply-to:references:cc:to:from:subject
	:user-agent:date;
	bh=aUj5fH8SCIRKe1iMCkfPanIAovLrp8yYl66o/9NYKWo=;
	b=N07URwxKaSk53xHw2PfGomwKWm9ZCZwYGjZnX2sIxB0mA1gqf8sD6QqeWIb3t5wQNY
	NdiuPVPDJg4YodgYoBtH66Bsp+RRO+IuWmDwgu1+GVukdD4tA+qKSZR6tAKGpdDt9ww9
	epMY8A+QEJekoFQtuYDzK27bfMhhWysw9ilOdMXzSxidJskszwIusLSmNMdZu2PH6+6/
	roLfkEyXc+y4KysFYCu7uk0GRrtlwtZlHbQvIS7xyPCJEJMPKcUrRXU3aqZDOd0WTS87
	brBoqVa7hmKeB+i0HsbaBxbozBACXpIdpH+YLCqENYAqffKqxF2/aabUmam5IwPvwgHM
	UqDQ==
X-Gm-Message-State: APjAAAXqt2Zr1rdrYpfWIK/XMJindWqdWoA3bIPca4Xv/Eshh1cnDGrS
	5wNGtx9ObTi91n5fEQjUc/yVsg==
X-Google-Smtp-Source: APXvYqxeWv0h8TDVgOgpmXUxVuXAum/bpheCYuG3gMeHHtM7Z7aGY8eDkRDr9gGiEsr+y2TRcL/Pjg==
X-Received: by 2002:a17:902:8b85:: with SMTP id
	ay5mr6635215plb.120.1568854346793; 
	Wed, 18 Sep 2019 17:52:26 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
	by smtp.gmail.com with ESMTPSA id
	u4sm9100156pfu.177.2019.09.18.17.52.26
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 18 Sep 2019 17:52:26 -0700 (PDT)
Message-ID: <5d82d14a.1c69fb81.3a5ca.5ffc@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <20190919002501.GA20859@builder>
References: <cover.1568712606.git.saiprakash.ranjan@codeaurora.org>
	<1513424ecec891d19c1aa3c599ec67db7964b6b2.1568712606.git.saiprakash.ranjan@codeaurora.org>
	<20190919002501.GA20859@builder>
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
	Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCHv6 3/3] iommu: arm-smmu-impl: Add sdm845 implementation hook
User-Agent: alot/0.8.1
Date: Wed, 18 Sep 2019 17:52:25 -0700
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
	Will Deacon <will@kernel.org>
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

Quoting Bjorn Andersson (2019-09-18 17:25:01)
> On Tue 17 Sep 02:45 PDT 2019, Sai Prakash Ranjan wrote:
> 
> > From: Vivek Gautam <vivek.gautam@codeaurora.org>
> > 
> > There are other boards such as cheza whose bootloaders don't enable this
> > logic. Such boards don't implement callbacks to handle the specific SCM
> > call so disabling this logic for such boards will be a no-op.
> > 
[...]
> > diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
> > new file mode 100644
> > index 000000000000..24c071c1d8b0
> > --- /dev/null
> > +++ b/drivers/iommu/arm-smmu-qcom.c
> > @@ -0,0 +1,51 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +#include <linux/qcom_scm.h>
> > +
> > +#include "arm-smmu.h"
> > +
> > +struct qcom_smmu {
> > +     struct arm_smmu_device smmu;
> > +};
> > +
> > +static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
> > +{
> > +     int ret;
> > +
> > +     arm_mmu500_reset(smmu);
> > +
> > +     /*
> > +      * To address performance degradation in non-real time clients,
> > +      * such as USB and UFS, turn off wait-for-safe on sdm845 based boards,
> > +      * such as MTP and db845, whose firmwares implement secure monitor
> > +      * call handlers to turn on/off the wait-for-safe logic.
> > +      */
> > +     ret = qcom_scm_qsmmu500_wait_safe_toggle(0);
> 
> In the transition to this new design we lost the ability to
> enable/disable the safe toggle per board, which according to Vivek
> would result in some issue with Cheza.
> 
> Can you confirm that this is okay? (Or introduce the DT property for
> enabling the safe_toggle logic?)
> 

I can test this on Cheza. Not sure if anything will happen but it's
worth a shot.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
