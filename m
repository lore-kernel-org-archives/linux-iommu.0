Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03185C433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 15:20:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D5B64E9C
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 15:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D5B64E9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6D6982046D;
	Mon,  1 Feb 2021 15:20:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YkDzbtJ2Ry+c; Mon,  1 Feb 2021 15:20:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B2E9620395;
	Mon,  1 Feb 2021 15:20:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B843C0FA7;
	Mon,  1 Feb 2021 15:20:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EA64C013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 15:20:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0A25785168
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 15:20:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ik4s1qcUc81I for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 15:20:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 52D478511F
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 15:20:12 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id c4so14276583wru.9
 for <iommu@lists.linux-foundation.org>; Mon, 01 Feb 2021 07:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Cmku5S3IdYnPtrqwdeFlSVFh/nDWdiVLKGao8LWxXgA=;
 b=JqbVGM0UCNG3mit9/UZsdLhah1nWurom48htD5nfPqgCrIDKO88AnVFFjgeU8PHGAN
 BW8utbpUX3UzYrG5TduBBHDR0Bykf1U/mPNECk9CAeP2BJ5xU1/maQPp6TdmWvSxp7kY
 YaRWr2KxZf1lmghsWGCPIcwDMqfE9K6FbmmNMq6gHY0Jz8AKQFReCAkxEqamQ7k25E05
 tww76nG6EjFgx1g6ImqskqU/4QT+Wut06Spo5/okwB798IwVUNUls7lmhj5a+eDAZLFh
 piOGzeHarIzIg/xyItedJcc03d6rBcyoHWFaeuijtP9yye49mw6dbw4S7T1r8qkcImZk
 PFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Cmku5S3IdYnPtrqwdeFlSVFh/nDWdiVLKGao8LWxXgA=;
 b=qheX8JJjgFMk1KhT9eGIGEhZWqFiXst8is3yW/ryv7N9/Whyp45Bk9Iv/htUpT3x0o
 3R3mTIz4LP5P3Pn5M4evpuFHZ83t4bz9LZ0qwiaokh9y4QFNNy92lgU1u1PQ6IfScQau
 eX7HN0D/nDVR6tnaWbEjldNFyWwUgNfVdE934vEqH0H9RXR9Z2ooJthVN4fnwEhwNxeY
 +2eqJFsHqLaQl7agsoYAN6X9e+dWAyABYRzAzYThm742av5oepV4tTzy2y+y8Wys2egQ
 Bwzk8vx+6RtFWT5LvyR+/cR8ucwedq+RLwseokyzzm/UV6ftzGQkAtzAAqwm0hMuUQEO
 v5kA==
X-Gm-Message-State: AOAM533P/FA0S5eDnjPwgGyYx953oxWpMGCJmJEckmbRoqRRxQ49I8SG
 q0TLl21gOuPDP95BXyrS+lk+PQ==
X-Google-Smtp-Source: ABdhPJxNabzA7H0H3DOfoTeFLSfKWAgMXTatTFFBoCico1yZQV+n2lKonsKcsD7PxZ66kwPkc5AE0w==
X-Received: by 2002:a5d:4528:: with SMTP id j8mr19018125wra.352.1612192810877; 
 Mon, 01 Feb 2021 07:20:10 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id q6sm25951090wrw.43.2021.02.01.07.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 07:20:09 -0800 (PST)
Date: Mon, 1 Feb 2021 16:19:50 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v12 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <YBgcFgXQCTEQNowo@myrica>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-11-jean-philippe@linaro.org>
 <0c609eeb-00b0-7573-fed7-5bc1e6c0b0d1@redhat.com>
 <YBfiIwdVP1dXg7Yt@myrica>
 <47a65f65-26cb-de27-049a-48f2d083964a@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47a65f65-26cb-de27-049a-48f2d083964a@redhat.com>
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com,
 linux-acpi@vger.kernel.org, robin.murphy@arm.com, rjw@rjwysocki.net,
 robh+dt@kernel.org, sudeep.holla@arm.com, vivek.gautam@arm.com,
 iommu@lists.linux-foundation.org, linux-accelerators@lists.ozlabs.org,
 guohanjun@huawei.com, zhangfei.gao@linaro.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

On Mon, Feb 01, 2021 at 02:16:16PM +0100, Auger Eric wrote:
> >>> +		flt->type = IOMMU_FAULT_DMA_UNRECOV;
> >>> +		flt->event = (struct iommu_fault_unrecoverable) {
> >>> +			.reason = reason,
> >>> +			.flags = IOMMU_FAULT_UNRECOV_ADDR_VALID |
> >>> +				 IOMMU_FAULT_UNRECOV_FETCH_ADDR_VALID,
> >> nit: shall IOMMU_FAULT_UNRECOV_FETCH_ADDR_VALID be set here? Supported
> >> unrecoverable faults feature the IPA field which is UNKNOWN for S1
> >> translations. fetch_addr rather was
> >> corresponding to WALK_EABT.Fetch_addr to me.
> > 
> > Right I should drop the IPA part entirely, since we don't report S2 faults
> > in this patch.
> OK
> 
> But as I mentioned this can be fixed separately if you don't have other
> comments on this version.

Thanks, I need to resend anyway to fix patch 7.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
