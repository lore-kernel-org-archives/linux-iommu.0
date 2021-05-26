Return-Path: <SRS0=mply=KV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C91BC2B9F7
	for <iommu@archiver.kernel.org>; Wed, 26 May 2021 10:05:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27DA961432
	for <iommu@archiver.kernel.org>; Wed, 26 May 2021 10:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DA961432
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E20AE40575;
	Wed, 26 May 2021 10:05:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vO9CfNlf0xPW; Wed, 26 May 2021 10:05:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id AAB2A40271;
	Wed, 26 May 2021 10:05:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 871F5C000E;
	Wed, 26 May 2021 10:05:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C239C0001
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 10:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4CC9483C30
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 10:05:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 88YxF5J5FPsZ for <iommu@lists.linux-foundation.org>;
 Wed, 26 May 2021 10:05:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 67C3B82ECF
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 10:05:26 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id h16so666903edr.6
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 03:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wN1QhgZSLh/Q1cWPqcMwfOkLFO+D9Okqk24H5LLAjws=;
 b=nPXeq6WiNxgg6lSxeUnm2xUIASnDhmktguH8A6hssAjEktOyNSvFrXb7nk9Jwtb+NO
 yFRlCwYbpgu1I3XfvONpplYhusGl1LZzYH8skxO3FMlur4Ub99+Y+fFTNkOsTrN5w38z
 OVf9eYTP/FPPU3gd8SPWnmbwhEmLy2lOF0pC3GW4VrVUrahiv7yYM6zET6w7Z3my6L0S
 cHNhcGsinerK+PASVPV7OHMOudUBIlgvybDpP7ziWJzNizZCFYD1ZSZ3if2EX1bSR+BK
 ZxzluxhQR+3Vc6n46FiKg0ibO/Yga0tgQunYLwLIIwStAZJn5nD7INiwGK+RxyPP0Qb4
 pUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wN1QhgZSLh/Q1cWPqcMwfOkLFO+D9Okqk24H5LLAjws=;
 b=KMES10V4kfPQMfOrnudqvveCNGFkMwn7ss3qAN+ANVSSFqa8fb6gHyj6eO9r1cB0nz
 nCQATilICkx2l85lnxkuE+nFrbngx1UChtw3cuu+a8dLjxEdX9aCWaygwS7o9JT/6co6
 ZusEuNVAKTkZK/TQ6X6mr2fJBE4q698e5p40VzEcOjkQ4igg5W/aFulmjPyGpDJTqf8o
 IDeUpNHJirFDCIN4kRjLMZj6/I9plwq3BbJjdcTPkjHmLJFSk+QEI2TtGBJsupcR42TH
 UqkmkLiNAeEtdUNSOYBhzT1hWmB4dNgJOLFruKjNSqGXlcElJpLEzjf6f82mWaETU5CD
 L3eg==
X-Gm-Message-State: AOAM531dGexz2HqQhQBX2Vh0gjV0tBjd4MECxTC6aIQ5H7i/lQwbc/qz
 JRdU1RdTB45sNhK68qPQ8AmRiA==
X-Google-Smtp-Source: ABdhPJwLqgT0dI13/qQ6yT3UWt2a30pzQv780qX8pFwjZ6m2oIQpbMs47aFTz509ycnSHGVFoSWOMw==
X-Received: by 2002:a50:bf0f:: with SMTP id f15mr34885274edk.205.1622023525169; 
 Wed, 26 May 2021 03:05:25 -0700 (PDT)
Received: from myrica (adsl-84-226-106-126.adslplus.ch. [84.226.106.126])
 by smtp.gmail.com with ESMTPSA id k22sm10054730ejz.108.2021.05.26.03.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 03:05:24 -0700 (PDT)
Date: Wed, 26 May 2021 12:05:06 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/6] ACPI: Move IOMMU setup code out of IORT
Message-ID: <YK4dUpIS5LJmAU2s@myrica>
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
 <20210423113836.3974972-3-jean-philippe@linaro.org>
 <CAJZ5v0j=vqv3aJb_eitOVtpxgU3j5_j5hKPzyTEeHxfo_5MXdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j=vqv3aJb_eitOVtpxgU3j5_j5hKPzyTEeHxfo_5MXdQ@mail.gmail.com>
Cc: kevin.tian@intel.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robin Murphy <robin.murphy@arm.com>,
 virtualization@lists.linux-foundation.org,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 sebastien.boeuf@intel.com, Hanjun Guo <guohanjun@huawei.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
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

On Fri, May 21, 2021 at 06:42:09PM +0200, Rafael J. Wysocki wrote:
> On Fri, Apr 23, 2021 at 1:57 PM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > Some of the IOMMU setup code in IORT is fairly generic and can be reused
> > by VIOT. Extract it from IORT.
> 
> Except that iort_iommu_configure_id() is not really generic AFAICS.

I'll clarify the commit message: the parts of iort_iommu_configure_id()
that set up the IOMMU infrastructure can be extracted and reused by VIOT.
The rest of the function, that iterates over the IORT subtables, is
specific to the driver.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
