Return-Path: <SRS0=u5nN=W5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77404C3A59E
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 13:39:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD8221881
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 13:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD8221881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C69BBEA5;
	Mon,  2 Sep 2019 13:39:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 11160E4D
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 13:39:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 490C2709
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 13:38:57 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id p13so14703111wmh.1
	for <iommu@lists.linux-foundation.org>;
	Mon, 02 Sep 2019 06:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:date:from:subject:references
	:in-reply-to:cc:cc:to;
	bh=VHM7wVxbM3iFjk6g2BqysfNSZL4bn6Yh6NOKIm6VeQ8=;
	b=qh1tEtyvwQodDSyA6BIc88k/xg69+PHjKWbUcsQKXarTLCA9rsvIaic6Mg31NMD86v
	Blys6TwC7jplCvctK5EiTszGd/9fqJs58ZZs/oc8iNXGRYGSlp//thkjmUB08KtelL9+
	oTPupcAzscX3qAGbBWrf043CYexn2tCilSTuYCPlgTGDdBw+1Ae8kqQMG7o1u1KwA9wk
	SuqsuGEYQpGevWIO+9vLR40xpXTqMxc7RL6LwWPS9kZTvmuaCr2N69wKO2L4qDkmha3m
	sM3h1ig4ulni8J/S/LCX8A2senWjrT5yYtIRwTs1jIiAbdAi5E1Z0DnkjgNFoNDDLb54
	Tm1A==
X-Gm-Message-State: APjAAAXOWitI6qfgEkAcyFaof6234mW/rwZRl/+RpPX/pDWCr2TS6pqO
	3ILehn/qGTHVB31eZCpsWQ==
X-Google-Smtp-Source: APXvYqy0KNBQfCwq+9RzjWG+pvrwpi4rW7y8999LenlesG4VEWMuewwgiR5JlpctG/2+f2gTGGix0A==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr4331454wmj.93.1567431535461;
	Mon, 02 Sep 2019 06:38:55 -0700 (PDT)
Received: from localhost ([212.187.182.166]) by smtp.gmail.com with ESMTPSA id
	h8sm16761794wrq.49.2019.09.02.06.38.54
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 02 Sep 2019 06:38:54 -0700 (PDT)
Message-ID: <5d6d1b6e.1c69fb81.c6a88.9b11@mx.google.com>
Date: Mon, 02 Sep 2019 14:38:54 +0100
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] iommu: Implement of_iommu_get_resv_regions()
References: <20190829111407.17191-1-thierry.reding@gmail.com>
	<20190829111407.17191-2-thierry.reding@gmail.com>
In-Reply-To: <20190829111407.17191-2-thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: , devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, 29 Aug 2019 13:14:06 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This is an implementation that IOMMU drivers can use to obtain reserved
> memory regions from a device tree node. It uses the reserved-memory DT
> bindings to find the regions associated with a given device. These
> regions will be used to create 1:1 mappings in the IOMMU domain that
> the devices will be attached to.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/iommu/of_iommu.c | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/of_iommu.h |  8 ++++++++
>  2 files changed, 47 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
