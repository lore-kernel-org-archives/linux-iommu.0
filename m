Return-Path: <SRS0=QSWf=I3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7757FC433E2
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 16:23:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CF361960
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 16:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CF361960
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8399B40336;
	Mon, 29 Mar 2021 16:23:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P5VbjDdYDI_C; Mon, 29 Mar 2021 16:23:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5975B402AF;
	Mon, 29 Mar 2021 16:23:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E33C5C0013;
	Mon, 29 Mar 2021 16:23:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19B8CC000C
 for <iommu@lists.linux-foundation.org>; Mon, 29 Mar 2021 16:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E71B440134
 for <iommu@lists.linux-foundation.org>; Mon, 29 Mar 2021 16:23:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GMh9U7PkY9TO for <iommu@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 16:23:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ED6D84012E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Mar 2021 16:23:22 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id g25so6948028wmh.0
 for <iommu@lists.linux-foundation.org>; Mon, 29 Mar 2021 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KPclp6vfsh1l0llxq/9bcQXpgR0clJ6jmS6dVL/hig8=;
 b=bj77tl0OjsgCgZLbOb3u3k145orUo71nkMcisB/6plOzX/M2mg3Z4Yb5uDisu9c4pB
 Y53SOJe4s4v6Mhp+CFbq6aMAtV0YnUliuYDu7EDJkfI1uYn+lEi44BJeUdxqKS/tx3ru
 OfU2m9joLw9o3CyDSRJhRXWyX6CADErtPac4qLPNqMsBYAMl4Ls7CdOHxBs62aYJ4XaJ
 yUgTz5aupJxIno4XKcDiaBivqeoEJ6rRqOkSeKzkD+lCKQV3ESKONlrbQU0ZLjQ3/915
 /Mff3SI799c/P5lsfxlGS62u7OScJZG9l13uwvkzhwn9CM6+aup1yF/Jf4SM0qj4lLMj
 WW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KPclp6vfsh1l0llxq/9bcQXpgR0clJ6jmS6dVL/hig8=;
 b=R0KTkHeQEKAbKVE/93mHiPzuMgQvVdPNops7xoZc+y//r8ZYqhkhtE4UXvPyxD1wqH
 zhfc9C0qspQkbs1mnYT2w3kiSlLQTkkf2joZ4J87/QLdN/PDXAKvQf+UKvLrHeV12JLq
 DpNwOw3JYdgCrzoOstrgvvFBkVwrJMQY0dVe9qC3OzcBROkn1nce+Bd2zlB/+C6yJEd4
 gepEcCGr95UmJlQyxT9dZhxHRHzR3HyCH6qgFv/Tzbcary4bCFfzHSrK4r3hozdEyRne
 B5YZ6FjZ8kChXwxmQUfHqCqtPxbGD8pu5GWZsYu9Iv9UNorPrpuS6QhaNJy9ucaqFdjs
 UyRA==
X-Gm-Message-State: AOAM532eEQXGXruyXiq8xy89kWZlFGSFJooUdP+6qg4VX+fIoTy67DLf
 AlugAYMdeWDI8JgshmWPBKWunQ==
X-Google-Smtp-Source: ABdhPJwFilW/ot1hZMhT/JWnG2uNUr6y5QBKqC9sEGMBX6tvcW+gfCS/ourdvz2bsJ56tuVkYTAQEw==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr26138332wmk.30.1617035001094; 
 Mon, 29 Mar 2021 09:23:21 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id i8sm29594538wrx.43.2021.03.29.09.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Mar 2021 09:23:20 -0700 (PDT)
Date: Mon, 29 Mar 2021 18:23:02 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Kumar Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 15/15] iommu/virtio: Update fault type and reason
 info for viommu fault
Message-ID: <YGH+5pHtR6gWnimB@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-16-vivek.gautam@arm.com>
 <YD/GjQIKkaJ5+UJM@myrica>
 <d8a81406-12c6-a5e1-7297-49c1a0a800ab@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d8a81406-12c6-a5e1-7297-49c1a0a800ab@arm.com>
X-TUID: vOigyBwZv6w+
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

On Fri, Mar 12, 2021 at 06:39:05PM +0530, Vivek Kumar Gautam wrote:
> To complete the page request we would also need to send the response back to
> the host from virtio backend when handling page request. So the virtio
> command should also be accompanied with a vfio api to send the page request
> response back to the host. Isn't it?
> This is where the host smmuv3 can send PRI_RESP command to the device to
> complete the page fault.

It looks like Eric already has this in the VFIO series:
https://lore.kernel.org/linux-iommu/20210223210625.604517-14-eric.auger@redhat.com/

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
