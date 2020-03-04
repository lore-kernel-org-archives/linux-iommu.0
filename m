Return-Path: <SRS0=48ym=4V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E103C3F2D7
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 14:10:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2A62072A
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 14:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/6/YBab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2A62072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 420912052C;
	Wed,  4 Mar 2020 14:10:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z+r-4YNx04BT; Wed,  4 Mar 2020 14:10:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 12A7520396;
	Wed,  4 Mar 2020 14:10:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDF62C1AE2;
	Wed,  4 Mar 2020 14:10:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9F08C013E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 14:10:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 98AE484519
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 14:10:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2vFhEW005wqJ for <iommu@lists.linux-foundation.org>;
 Wed,  4 Mar 2020 14:10:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BF76984518
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 14:10:54 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id z15so2593629wrl.1
 for <iommu@lists.linux-foundation.org>; Wed, 04 Mar 2020 06:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7HwHHOirHwI1c4j5Tv3u9lHj4prOjYmBbBNbHrFitZg=;
 b=Q/6/YBabh+3hoAX2lwxr9pv+BA6F8RdNG6tLtX1bg/aislj9n8Gmj4CeXizdPlqgft
 CmQpjJEBAbscYl1+fBWSTwIw3Q+wl4TrDmjZJrl5wmkDlW6cEO2OLALqUjnUpgfw44/u
 XRD2SH+U+3LGbzsauCnxCczIwaG31q4mtJq6cN5NZdMgXdtdPJRXNnmjCr+94tPg+lLA
 KHTfh6h5pCiaaBcIZl39MWPMll42zzUvIORJenCDE9jzUv9vXF8eUanvdU7aIzACWArf
 8xEZxTj5/LYzGeCYId9/Id5fwR1H6KylI5CO0NUUG2UMvrQ0U4LwsnJmTGCM23qHOhp1
 tgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7HwHHOirHwI1c4j5Tv3u9lHj4prOjYmBbBNbHrFitZg=;
 b=h+SZ9c1Q26DjYnrts+DB1Wz7oFEQFQfejIia/u5FZO9r+4TJUWa0FPCN706vbmXefD
 G6vY2PmCrBvYeY7HmCta5nGeJ39UE6/i+VXYY7Zm2s9RxZnngZaIjUxy2EwU+iLlMvsp
 RoXAJMbtGR39lh9OU0EAwfeEOecZR4TqmeCkoCn7kyVqH7y1Ztg81gdhPZCpz5bMFQMP
 Z95rQdF83AF3W/7V8XdXBr3a5OuolMCgrIyXtVvfoDSO6ebSVirp7VUs8pLqUP7g3yBB
 JOnrXom30Ave6ZoeU7o410w3VN0lDU1FhriUvjgTPsGonYw5UyGdhVtlmkUKMbuTQ0nc
 xaJw==
X-Gm-Message-State: ANhLgQ2kRPbusSnxO/022mvcyh3G6pBqN2XQh4OkgTBk1V0Af+qrBWS9
 vEsFD8DPLE2iXz2j7vkDTF1qUQ==
X-Google-Smtp-Source: ADFU+vtjRZ/ieGhvG1dNL4yvCidxtjrzWvostamf6vAXdMbRNS014Ivp7HqYWw4uSzXl8u6GytSgWA==
X-Received: by 2002:a5d:698a:: with SMTP id g10mr4347543wru.155.1583331052514; 
 Wed, 04 Mar 2020 06:10:52 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id t124sm4805947wmg.13.2020.03.04.06.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 06:10:52 -0800 (PST)
Date: Wed, 4 Mar 2020 15:10:45 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 07/26] arm64: mm: Pin down ASIDs for sharing mm with
 devices
Message-ID: <20200304141045.GD646000@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-8-jean-philippe@linaro.org>
 <20200227174351.00004d0d@Huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200227174351.00004d0d@Huawei.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, kevin.tian@intel.com,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com,
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

On Thu, Feb 27, 2020 at 05:43:51PM +0000, Jonathan Cameron wrote:
> On Mon, 24 Feb 2020 19:23:42 +0100
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > 
> > To enable address space sharing with the IOMMU, introduce mm_context_get()
> > and mm_context_put(), that pin down a context and ensure that it will keep
> > its ASID after a rollover. Export the symbols to let the modular SMMUv3
> > driver use them.
> > 
> > Pinning is necessary because a device constantly needs a valid ASID,
> > unlike tasks that only require one when running. Without pinning, we would
> > need to notify the IOMMU when we're about to use a new ASID for a task,
> > and it would get complicated when a new task is assigned a shared ASID.
> > Consider the following scenario with no ASID pinned:
> > 
> > 1. Task t1 is running on CPUx with shared ASID (gen=1, asid=1)
> > 2. Task t2 is scheduled on CPUx, gets ASID (1, 2)
> > 3. Task tn is scheduled on CPUy, a rollover occurs, tn gets ASID (2, 1)
> >    We would now have to immediately generate a new ASID for t1, notify
> >    the IOMMU, and finally enable task tn. We are holding the lock during
> >    all that time, since we can't afford having another CPU trigger a
> >    rollover. The IOMMU issues invalidation commands that can take tens of
> >    milliseconds.
> > 
> > It gets needlessly complicated. All we wanted to do was schedule task tn,
> > that has no business with the IOMMU. By letting the IOMMU pin tasks when
> > needed, we avoid stalling the slow path, and let the pinning fail when
> > we're out of shareable ASIDs.
> > 
> > After a rollover, the allocator expects at least one ASID to be available
> > in addition to the reserved ones (one per CPU). So (NR_ASIDS - NR_CPUS -
> > 1) is the maximum number of ASIDs that can be shared with the IOMMU.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> A few more trivial points.

I'll fix those, thanks

Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
