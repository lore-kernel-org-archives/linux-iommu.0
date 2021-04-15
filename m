Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C30C43461
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 14:36:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA4361182
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 14:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA4361182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C74A84354;
	Thu, 15 Apr 2021 14:36:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ubl-HZMI1pVy; Thu, 15 Apr 2021 14:36:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27AF183C46;
	Thu, 15 Apr 2021 14:36:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 008BDC000C;
	Thu, 15 Apr 2021 14:36:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D172C000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 14:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3711F40220
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 14:36:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3toK1DDl3f41 for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 14:36:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4238140228
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 14:36:39 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id u21so37208629ejo.13
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 07:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=mjhKqmO4P/HOjUJ1FPn/2ppNQrINwg9izlySqB9JB+o=;
 b=dQZZhJUIg9fPycLxp1hIWYbqTlefJ9fS+5+3rx52g5lZ7R7l35A2B6Jk8Zv1ifQtl1
 FbvQhhMy++oWabaMTxmc3+n7aE2dKX/HhYmxsFwR3ACD/4oXzdGcRmTX7AtZDBI68+XL
 GiZiY7hJuSNwF1xthc6mUuIUt65fEc4YW9S+PFkFCB5OGH31pNIO8a8gPjxAp6ok3M0z
 lb02YlOr9jG1ltSD9X9/TY4ZKNuJnSotaJPn18OAEHFWufO9HQk5HOkecplCbRoUmwzo
 39EWdXnowOPmqd4LXuQEIzd2Sj5Cbr1g5DrpouiwNWVbTLHT/BTs5ZQnehxDa+TAtlCn
 VnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mjhKqmO4P/HOjUJ1FPn/2ppNQrINwg9izlySqB9JB+o=;
 b=KtI38ujbuZ93PArTEewMuK8ccbLCoSlbS+Bf1palXDcztG/TarqL10g3jy04f1Yl5N
 RW0mRh5tfBidMms7QvAtn4xgPvCtcBmDQOnZQfUtOCSZYItiOAA/5M2uaLX1avRDeag9
 ldTKhjN+1MCCaXVRa9w9xXjJmtKobhTTDef/sGKEQ0T+jXnQNGqu6lxhy7rbmeApdwhc
 FJx5Apsm5mZPY5xMhV0VMlLXOtNQJmZFtJVRatVKcZhETw8MP67FOmN/yXNtVOsGC2Lg
 5XllBnhEtqF7zhrOlU8flU1VtbLWUV9TmCnoNoNhVM/3R84rV+BsAIaI7S/FvhEoWlZf
 H7cA==
X-Gm-Message-State: AOAM531j8w/gr6P3ZnEeShtoAdplgu0Br3mN3y2Dwc/m2JdXcib3hCog
 ICqIbI8Xws0pOysA4a6Xguaklw==
X-Google-Smtp-Source: ABdhPJxT42RtxEVSUyx6KmXpl8AEmphR/mLq1GM6Y9HSFmPvxfBq2sTK8w7eGMSiQrfyfZIiwQtvKQ==
X-Received: by 2002:a17:907:20f2:: with SMTP id
 rh18mr3764125ejb.466.1618497397471; 
 Thu, 15 Apr 2021 07:36:37 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id g20sm2776358edu.91.2021.04.15.07.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 07:36:37 -0700 (PDT)
Date: Thu, 15 Apr 2021 16:36:17 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 1/3] ACPICA: iASL: Add definitions for the VIOT table
Message-ID: <YHhPYYXx/gTsx52x@myrica>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <20210316191652.3401335-2-jean-philippe@linaro.org>
 <83d8f573-0a96-5869-2c22-249bf2db7399@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <83d8f573-0a96-5869-2c22-249bf2db7399@redhat.com>
Cc: kevin.tian@intel.com, mst@redhat.com, robin.murphy@arm.com,
 rjw@rjwysocki.net, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, will@kernel.org, lenb@kernel.org
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

On Thu, Mar 18, 2021 at 06:52:44PM +0100, Auger Eric wrote:
> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks, though this patch comes from ACPICA and has now been merged with
the other ACPICA updates:
https://lore.kernel.org/linux-acpi/20210406213028.718796-1-erik.kaneda@intel.com/

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
