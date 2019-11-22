Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295D9C432C0
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 15:33:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F327E20715
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 15:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AgTSYuNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F327E20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D32E487FEB;
	Fri, 22 Nov 2019 15:33:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6JDr7XAhGxfB; Fri, 22 Nov 2019 15:33:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5EF3A87B85;
	Fri, 22 Nov 2019 15:33:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 590D4C1D74;
	Fri, 22 Nov 2019 15:33:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29B35C18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 15:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2301D2637D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 15:33:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WZnnVT6Xsbqw for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 15:33:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 262D22635C
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 15:33:06 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id s5so9141458wrw.2
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 07:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=LQ0qY4Da80FqTT8SCe/q1MMW5kmKX6FKTTmrD9FMwQA=;
 b=AgTSYuNm6XEfw9a1bin5Mb4/xCbTQ+NinMuVrvghSeEv3dFsAecF1XJPbn2iv1M6hY
 p0cpqzbGPXGEzyjwmISfMojE0LxhDCyXfa7O2GrFOBPRPXKuA+np+l5lv+sd9iltRTGl
 40ixAedr0XBP0RObe/d0u6Kl85Lo7q6+M9uiiTyuCvGh/7qkjHt2Zq4kMpQER1oGToOy
 rUOFCo4z9GDEZTsAvXfugh8vyqyedf0J0SPQLCi87POM0biTYvmX+sFQlV/zavO9a9u0
 P8VMOSvA9vHtkz3cLbYbYkxR93aPdU1+xJbHJ1IsxNrJ+8+Zdneft3cnMtP6yGDS/0pX
 XQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LQ0qY4Da80FqTT8SCe/q1MMW5kmKX6FKTTmrD9FMwQA=;
 b=T4l+fESleAmpen3hwCFSfFeaC2wiN3p6JwswevJmwQA6wAG8IOy18GfIw/eRBJnUes
 nkitpMSLR3JWi237Dl586RQFOGRtTF1QJ+RK0eejIueJqfUC/Bd997+IihKslsGjLaOl
 XXcT/pVJlCejpUYQiFbirXxwcN80ikLWTdhw7wM4f1t+cd3Ffrr5eOeqQ2N7Z8XJK2Es
 hCdQK/hx/e9oeCmFURpga/PPAb/LgtWDpbmo091Qkv5j1mT5gCZ/pvz5l0JyxdJWYFcf
 TwC6bMban52tTleNUlNFkHdfHWPppY6H4qgQlqidXLTL8Yr0BVji7CU5QHEETOqoyifS
 g9Xg==
X-Gm-Message-State: APjAAAUnFh76Y9FaF9TW5GPDGiyexgrIWdhABH6VZnNeQQ8aJ99gsNjo
 zO5rVS7UvAlypJ8sHfnpDhQnvA==
X-Google-Smtp-Source: APXvYqzX6JrW+q24Zk8k1hZ/pOgzDIL1U2YSPMN1DIk72zz9G9tgaPGNFMdZipoYaSd2Rw5YaSO23g==
X-Received: by 2002:adf:f20d:: with SMTP id p13mr17340480wro.325.1574436784658; 
 Fri, 22 Nov 2019 07:33:04 -0800 (PST)
Received: from lophozonia (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
 by smtp.gmail.com with ESMTPSA id y6sm8172846wrw.6.2019.11.22.07.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 07:33:03 -0800 (PST)
Date: Fri, 22 Nov 2019 16:33:01 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v2 8/8] iommu/arm-smmu-v3: Add support for PCI PASID
Message-ID: <20191122153301.GC810215@lophozonia>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
 <20191108152508.4039168-9-jean-philippe@linaro.org>
 <20191111160529.00006dcd@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191111160529.00006dcd@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, robin.murphy@arm.com,
 sudeep.holla@arm.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, guohanjun@huawei.com,
 zhangfei.gao@linaro.org, will@kernel.org, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
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

Hi Jonathan,

On Mon, Nov 11, 2019 at 04:05:29PM +0000, Jonathan Cameron wrote:
> On Fri, 8 Nov 2019 16:25:08 +0100
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > Enable PASID for PCI devices that support it. Since the SSID tables are
> > allocated by arm_smmu_attach_dev(), PASID has to be enabled early enough.
> > arm_smmu_dev_feature_enable() would be too late, since by that time the
> > main DMA domain has already been attached. Do it in add_device() instead.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Seems straightforward.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Thanks for working on this stuff.  I hope we an move to get the rest of the
> SVA elements lined up behind it so everything moves quickly in the next
> cycle (or two).

Thanks a lot for the thorough review. I'm aiming for v5.6 for the PASID
series, and then realistically v5.7 for the rest of SVA, but I'll try to
send it sooner.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
