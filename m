Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBD8C43331
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 14:00:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE55206F6
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 14:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MzmEe8Wb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE55206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0C1B32040E;
	Wed,  1 Apr 2020 14:00:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nfnAeFSOp94C; Wed,  1 Apr 2020 14:00:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E695B20028;
	Wed,  1 Apr 2020 14:00:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D86F8C1D7F;
	Wed,  1 Apr 2020 14:00:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26D8BC089F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 14:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 13CF2203CE
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 14:00:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YLW0-SC+U8e8 for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 14:00:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by silver.osuosl.org (Postfix) with ESMTPS id C1E3D20028
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 14:00:16 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id w10so173586wrm.4
 for <iommu@lists.linux-foundation.org>; Wed, 01 Apr 2020 07:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7rS/8GAVkEamS2Iw0cTDnTD2JAlO3q0kknKABrOv+d8=;
 b=MzmEe8Wb1f4sYGiJmM/FaLWztqC5DpKffgfWvkmSMbDUSKl/5csxUbFnp2rh1rRYxs
 ab0BaMovVvXe39LftLGa1bpjTKqwju0QfjYj7kH/IRXTrKVr0BH9wuz73PVUigZya9ta
 uyMfaAKFZ0V8HqWLCbSlP5VfjdSwHhWfcIBlqSH64R9bOD+8VyLK4n47eFxqf038ci/Q
 VTZ5qrtE3sRpWzx5GwWyhtoqRm3lsODzbMD/NL0mhfeOQihZpbpsSbD44GqA0Mclmx1M
 XMlYygz8TatBnLWtDdPQOn/XuCMST+rR4XvKbnqZCKFRqtbLOaRsmp4Q/uiEzqhvtRTO
 B6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7rS/8GAVkEamS2Iw0cTDnTD2JAlO3q0kknKABrOv+d8=;
 b=oQ44LgbX7xD77yup1yx1WUzaHFlPm1szWK8U7AYKi563QGRhtAE9O0PDRYfRWP8e6a
 PxO5TLTccb4aUD/q5cGLy1Eeqdj671z0w2A7zsHIdCay435jDyzruxKP8vBjwfZcZY4+
 GAvSxYMJI5deqbSRBfYY7MT1nTwauKurGICNOpL9R40U9i+eX8hHpMSgIz8p43uRgPnb
 aaqz3AoaUSIAKAjYUQpXh7EBh1cZA7pCPgNsJUdB3Gmb09PzsPw2GSxUfTq79Cx6Km+f
 4LPfM9IEPdeTX80UdQONd4KRAlsUeFw9VCCwMHVB6zsJO5oaUmjdKoqINYpK2xlX60Yk
 +0zw==
X-Gm-Message-State: ANhLgQ1z1TjbvVdmkroxS161bDHa+CQjVEwTDJ27PzAyb2Fw6GZyjyZH
 LCJ0d95aLBwbjddvmBW1PWcU+g==
X-Google-Smtp-Source: ADFU+vveXkKZf5++LKfsqGZzL6IVUMB7L+TaJuGsujpDR3D5zTli+cX5tEZUdUtZJLYdCR8P3IaCPQ==
X-Received: by 2002:a5d:604a:: with SMTP id j10mr25552947wrt.126.1585749615283; 
 Wed, 01 Apr 2020 07:00:15 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
 by smtp.gmail.com with ESMTPSA id 19sm2765896wmi.32.2020.04.01.07.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 07:00:14 -0700 (PDT)
Date: Wed, 1 Apr 2020 16:00:06 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 08/10] iommu/ioasid: Introduce notifier APIs
Message-ID: <20200401140006.GI882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-9-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1585158931-1825-9-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

On Wed, Mar 25, 2020 at 10:55:29AM -0700, Jacob Pan wrote:
> IOASID users fit into the publisher-subscriber pattern, a system wide
> blocking notifier chain can be used to inform subscribers of state
> changes. Notifier mechanism also abstracts publisher from knowing the
> private context each subcriber may have.
> 
> This patch adds APIs and a global notifier chain, a further optimization
> might be per set notifier for ioasid_set aware users.
> 
> Usage example:
> KVM register notifier block such that it can keep its guest-host PASID
> translation table in sync with any IOASID updates.

When you talk about KVM, is it for

  [PATCH 0/7] x86: tag application address space for devices

or something else as well? (I don't see mentions of KVM in that series)

> 
> VFIO publish IOASID change by performing alloc/free, bind/unbind
> operations.

I was rather seeing IOASID as the end of the VFIO-IOMMU-IOASID chain,
putting it in the middle complicates locking. If you only need to FREE
notifier for this calse, maybe VFIO could talk directly to the IOMMU
driver before freeing an IOASID?  gpasid_unbind() should already clear the
PASID contexts, no?

Thanks,
Jean

> IOMMU driver gets notified when IOASID is freed by VFIO or core mm code
> such that PASID context can be cleaned up.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
