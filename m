Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A2CC433E0
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 17:43:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFCF221F8
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 17:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFCF221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C16578686C;
	Wed, 20 Jan 2021 17:43:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xPlTd+vT9N82; Wed, 20 Jan 2021 17:43:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4282B86566;
	Wed, 20 Jan 2021 17:43:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AD69C088B;
	Wed, 20 Jan 2021 17:43:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FC1FC013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 17:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7A74F87113
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 17:43:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qYjXANpesl1V for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 17:43:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1DA528710E
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 17:43:11 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id a9so20460148wrt.5
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 09:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=R7aUUsfcYcxGvSNOE9xOymWakTzVUOFowM4WuU+q4Pg=;
 b=szM7sxtOZH9OiVHN21YHTUe8HZnkap3Ywb7gLquh94qffDgX1HUDgtDLdIT2UNAAB/
 eGVghpwYfIgYXpIRdlxgBKZnl/GUvG12CahWdRXPAu8cbafSWkHfRraIK8cA60s2s6HC
 qipvpOKXiaIgTiTIl7asNU7C0HCb57vaJUx4czGiOpLJmJYZ7g/2/nI7Q7eVFSaEtYiM
 qsFSBfRJ5LYpfvEk7Xn5eKa6w/j9L1fGvGSr30ZmpAqB01ds6MzM62SLmwjmT+D4tSaV
 Gjfr0iEpHI7h3F4C19eRcjONtPk2QloKq6hgMPYDpqeTsH43a/ITxJzC+XutKf9ybAxL
 aHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=R7aUUsfcYcxGvSNOE9xOymWakTzVUOFowM4WuU+q4Pg=;
 b=PC3/ipKeDacMSMTb2UNLI0ZowIZeiqSgSbjO5HEqb6obP1a7GKPNJhkk1+WDG9xx2a
 jYsp/Qz82DJk8S4k3iOta4cf+OFWw7c57wsHLPVVKSh5vqxFlCpd/oUMVab3zJfW0XQU
 BHa5nM5bf7Rkk60sY70snOcYsGVjcDW6vo+++INFq2c+gwOB/iFRVTzt3WIylaTQKKhH
 SmtTUd1/kiBM5G1fGZ1QaUYpRzz637L0SC6vSl6Nb32+sHh9E6lRsNRE2Vf1Ol7mzEDd
 ox/1n/ShP5MTLSxOTfoOvi2LIKbayERoiLI6VtFcLl580ct2qnuf7VaC6XKzFRIXijW/
 JVIQ==
X-Gm-Message-State: AOAM532HKtWLGuIi8h8q6Eg1ATPh5WLU4yI4epNvBEOAQsQ4UCTWfsL7
 rXsqr4IHNbWfg4BOQbcPPY054w==
X-Google-Smtp-Source: ABdhPJzpLHHpsQ2g2E4WmLP34m6i58NPSVmOpjvgaXI5blCKQKW8/fkrv6QK9zAcq3kydE0WVN37Ng==
X-Received: by 2002:adf:f58f:: with SMTP id f15mr10486618wro.388.1611164589594; 
 Wed, 20 Jan 2021 09:43:09 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id j13sm5073106wmi.24.2021.01.20.09.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jan 2021 09:43:08 -0800 (PST)
Date: Wed, 20 Jan 2021 18:42:48 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v9 05/10] uacce: Enable IOMMU_DEV_FEAT_IOPF
Message-ID: <YAhrmLh5I/ysx/kb@myrica>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-6-jean-philippe@linaro.org>
 <20210119122759.000048f9@Huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210119122759.000048f9@Huawei.com>
Cc: vivek.gautam@arm.com, guohanjun@huawei.com, will@kernel.org,
 linux-acpi@vger.kernel.org, zhangfei.gao@linaro.org, lenb@kernel.org,
 devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 linux-accelerators@lists.ozlabs.org
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

On Tue, Jan 19, 2021 at 12:27:59PM +0000, Jonathan Cameron wrote:
> On Fri, 8 Jan 2021 15:52:13 +0100
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > The IOPF (I/O Page Fault) feature is now enabled independently from the
> > SVA feature, because some IOPF implementations are device-specific and
> > do not require IOMMU support for PCIe PRI or Arm SMMU stall.
> > 
> > Enable IOPF unconditionally when enabling SVA for now. In the future, if
> > a device driver implementing a uacce interface doesn't need IOPF
> > support, it will need to tell the uacce module, for example with a new
> > flag.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Hi Jean-Philippe,
> 
> A minor suggestion inline but I'm not that bothered so either way
> looks good to me.

No problem, I'll add the disable function

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
