Return-Path: <SRS0=QSWf=I3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0F8C433DB
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 16:26:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F9661919
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 16:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F9661919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 650744012E;
	Mon, 29 Mar 2021 16:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kDVfpekf-LaP; Mon, 29 Mar 2021 16:26:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4BC0B40149;
	Mon, 29 Mar 2021 16:26:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCDB3C0013;
	Mon, 29 Mar 2021 16:26:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E29D3C000C
 for <iommu@lists.linux-foundation.org>; Mon, 29 Mar 2021 16:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD57860713
 for <iommu@lists.linux-foundation.org>; Mon, 29 Mar 2021 16:26:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R5qsxU2GKb_2 for <iommu@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 16:26:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2749A60711
 for <iommu@lists.linux-foundation.org>; Mon, 29 Mar 2021 16:26:09 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id x16so13467481wrn.4
 for <iommu@lists.linux-foundation.org>; Mon, 29 Mar 2021 09:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=T74W0nsf8Eu00PANoOWWFVGfSYum6qWwsn0Bw2THZ+s=;
 b=YUIEgiI1qQRI29mfubywR7B14Uyqk60nwvE2KF7gqROs2K/Or1NYVxhiZL1RMZ9LIb
 sxYMJOnaFcJ3QryDjmsfpUP4evW0yxJ3rw8eNH8PHzeO+fHHzIgI/Y0wybDi44c6cS0p
 QD0Yt7+edAu6/oJ0axLyyHLhGCJaiV+68wfh48hVfETIQjrodfMWWyd+Il3hV/R+JQ4o
 cyRYUBscybFXnPjsct6pzbq61epkXDbc8+yQhoNk/cjCgWp2QmhEqfFS91Bxoq0/v6At
 TaRW1iDGlxWbVJKNyQv0AhTpMf6zO8lTwMDtFHfw9Hf03gYJdaNK09LuH1HAz/RAPwuU
 eMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=T74W0nsf8Eu00PANoOWWFVGfSYum6qWwsn0Bw2THZ+s=;
 b=nX9Ksjyr/GrvydFKKvcUHr41SmX6aD0D//wZ9zF8FpEklo6G2dZampKkf1CA6Kv7XO
 yB3rYnvN1DabtDBsLlWlyWbGoEn+Z9ZsLB7cN+zLDJE/yZ3ksXkKKhH2UNiIqbZqTS3m
 APdsYFX70bAF3Nm1+jJBpi/MjkEK4i2rHI8v3BlSvRjWdvF6wiHjFKJqI1P02I13qE1w
 bKncTA0I1INjaEwbqODdBGtfvhgmAIvzgH+3GdtXCygDTvhBIKOr5GgvYTW0n+eET+iX
 xQV6WIpFkMWG8u8IEvB+BWv4B+oQXG6SPVeuP6AWDBYeyi3dmo02iHl0roxhAYb4q8vR
 bEJg==
X-Gm-Message-State: AOAM533rpPehi99Dxev2ABW4rUauvZXVOwm87lunB3vfeaSSHrgSTf/s
 LH3ZrjF1RFhd3+UFXIfJ3rPADw==
X-Google-Smtp-Source: ABdhPJyAv1xefDsH4RnBTD3wTIb5bRlvWKvplwmh2Mjf9I5mC7dc85r3sKdv9DNWLYwkDvTL7Er6sg==
X-Received: by 2002:a05:6000:18d2:: with SMTP id
 w18mr29581974wrq.88.1617035167386; 
 Mon, 29 Mar 2021 09:26:07 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m3sm30135465wme.40.2021.03.29.09.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Mar 2021 09:26:07 -0700 (PDT)
Date: Mon, 29 Mar 2021 18:25:48 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Kumar Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 02/15] iommu: Add a simple PASID table library
Message-ID: <YGH/jJPeG9ltT8uu@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-3-vivek.gautam@arm.com>
 <YD/DU8XNYHlTzTay@myrica>
 <cd030006-2701-206d-5fca-e0e7afff316a@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cd030006-2701-206d-5fca-e0e7afff316a@arm.com>
X-TUID: 5GTwZm4l3gMS
Cc: kevin.tian@intel.com, alex.williamson@redhat.com, mst@redhat.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
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

On Fri, Mar 12, 2021 at 06:17:55PM +0530, Vivek Kumar Gautam wrote:
> > Regarding the overall design, I was initially assigning page directories
> > instead of whole PASID tables, which would simplify the driver and host
> > implementation. A major complication, however, is SMMUv3 accesses PASID
> > tables using a guest-physical address, so there is a messy negotiation
> > needed between host and guest when the host needs to allocate PASID
> > tables. Plus vSMMU needs PASID table assignment, so that's what the host
> > driver will implement.
> 
> By assigning the page directories, you mean setting up just the stage-1 page
> table ops, and passing that information to the host using ATTACH_TABLE?

Yes. And we can support nested translation with SMMUv2 that way. But with
SMMUv3 the guest has to manage the whole PASID table.

> Right now when using kvmtool, the struct iommu_pasid_table_config is
> populated with the correct information, and this whole memory is mapped
> between host and guest by creating a mem bank using
> kvm__for_each_mem_bank().
> Did I get you or did I fail terribly in understanding the point you are
> making here?

Makes sense

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
