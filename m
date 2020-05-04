Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFC8C3A5A9
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 16:36:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C94620705
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 16:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ie+B2GQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C94620705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CFE1B87795;
	Mon,  4 May 2020 16:36:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ZgoBsd2ckFq; Mon,  4 May 2020 16:36:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D06D087794;
	Mon,  4 May 2020 16:36:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1E98C088C;
	Mon,  4 May 2020 16:36:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 397ECC0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 16:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 265768789F
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 16:36:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l+CvsV9Pl2nQ for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 16:36:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1AFD288736
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 16:36:06 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id f13so21707475wrm.13
 for <iommu@lists.linux-foundation.org>; Mon, 04 May 2020 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Kl5xt2RTiHls+O1+Q0mo8BGBZHrI/nlz87XckVdCL1g=;
 b=ie+B2GQn0xE9JMPS6WF8xSO2Nb3Bq/Z6k2tntw6DutFeL6B9N4DPWVklfbNH4FnjaN
 t/FdSJpizjKhO8r7qWYTVIfj5tsh0Pyre46+FgQl/czQpS77eCKBAx7l0fXzqe5oMoJN
 srD+3dXDSZ1b8gDIeuMqWa8VuGSbuKmcgrBbHkW2D7hnwsTKJTes6Tw8OLdAyIdx9DsB
 hoEzpcXksJ2R6iwRnxlq1Hy4FZn4zTesCpGIx+6colQIPrKfNOCzGL8j1llscgSmy5B/
 5cauF3xMhaLP0b+LA+EjuCFSF43vHxSqLu21aoJ22r7LNEmYy0ZayKBxq3kGlHDl94a6
 bpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Kl5xt2RTiHls+O1+Q0mo8BGBZHrI/nlz87XckVdCL1g=;
 b=mD17tRVR1HhTk0d14s8WryOkvAFsRvG0LAiej+ij6Z+AwTF9UkY5FVCvIfXLKBgV39
 dHemI5S6VgFJjq4z+0la5l7q9g/F8dubSKdiyWygju2e/EdbtKG0ft1bHZT6tJPhA5GU
 N0cwWHRJqzOfe9uiIC1msz/vWRrZswS7awKwN2n78A0nAKaW73eST4mWTeo7coJIIQIV
 f/uNmbKyj/jKusfDUl6iZdNX790W+DIovvYKnZL1tRS5wqT53PfRRlXJNdbtp3IWqxgT
 O1tZ84FYMwsfsA+R0MD3cmmgTRKscVoRkmwY9vTIY0aGfQEc6joPF31QYMYQoHcyVGm/
 HXhA==
X-Gm-Message-State: AGi0Pub9DAAgFvcqmjoc6gV3wMvtCq+NB83EQ2RXOY68v4o8+TkjgWEO
 paF1qiksirWeHMHIpYfGT7OpUQ==
X-Google-Smtp-Source: APiQypLd6vuo0MczRTSEBPfkSN84zUGhA14hWPmpa6tAN+ckf2g+Pmwwtmh//IwEutIpZVdWAHOW4g==
X-Received: by 2002:a05:6000:10c4:: with SMTP id
 b4mr20516301wrx.203.1588610164479; 
 Mon, 04 May 2020 09:36:04 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id z1sm13717417wmf.15.2020.05.04.09.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 09:36:03 -0700 (PDT)
Date: Mon, 4 May 2020 18:35:53 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Subject: Re: [PATCH v6 19/25] iommu/arm-smmu-v3: Add support for Hardware
 Translation Table Update
Message-ID: <20200504163553.GI170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-20-jean-philippe@linaro.org>
 <CAJ2QiJLUxiJRnxQmO3O_48ZcTtNwziCWT6i2SJdAruDi+KGEFw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJ2QiJLUxiJRnxQmO3O_48ZcTtNwziCWT6i2SJdAruDi+KGEFw@mail.gmail.com>
Cc: fenghua.yu@intel.com, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 Will Deacon <will@kernel.org>,
 Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>, hch@infradead.org,
 jgg@ziepe.ca, tanmay@marvell.com, Catalin Marinas <catalin.marinas@arm.com>,
 zhangfei.gao@linaro.org, devicetree@vger.kernel.org, kevin.tian@intel.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 felix.kuehling@amd.com, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, christian.koenig@amd.com
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

Hi,

On Mon, May 04, 2020 at 07:54:03PM +0530, Prabhakar Kushwaha wrote:
> Dear Jean,
> 
> On Thu, Apr 30, 2020 at 8:11 PM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > If the SMMU supports it and the kernel was built with HTTU support, enable
> 
> is there any framework/config for HTTU which must be enabled to use this patch?
> 
> 
> > We can enable HTTU even if CPUs don't support it, because the kernel
> > always checks for HW dirty bit and updates the PTE flags atomically.
> >
> I believe, this statement is valid in context of this patch-set only.
> 
> One cannot use code snipped to test HTTU because exiting
> io-pgtable-arm.c driver doesn't have framework to leverage HTTU
> benfits. It by-default sets AF=1 and does not set DBM.

Right, this patch only sets the hardware access and dirty flags for SVA
(page tables shared with the CPU through iommu_bind*()), it doesn't enable
anything for iommu_map/unmap(). Although I remember discussing it for VM
migration, I don't know of any effort to use hardware access/dirty bits
outside of SVA.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
