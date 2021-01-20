Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7DFC433E0
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 17:42:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F0D2070A
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 17:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F0D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9908785FD5;
	Wed, 20 Jan 2021 17:42:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k53FZb87HnYb; Wed, 20 Jan 2021 17:42:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 020EA85FD4;
	Wed, 20 Jan 2021 17:42:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2081C088B;
	Wed, 20 Jan 2021 17:42:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD1C4C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 17:42:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B044C20398
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 17:42:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id us9XG+LkAAmI for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 17:42:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by silver.osuosl.org (Postfix) with ESMTPS id 4B0B12038B
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 17:42:18 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id m187so3564436wme.2
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 09:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pZAvuSzWG8A+x8RzKRjMwPsRhtgX7L+uhw4FZKkKEI8=;
 b=zRxQYipj+tDx+56ns7Ze3GNaWKe6r/tz7bvAXtpDr91GVvL23yfQ/xtlLzjs05uev+
 8i2EojAZz56kMZbRSsG/r1NPPpNL4NAj++u8i0kgBaNiyH69hhbSuoegPhOYLhxUauZv
 etfzouMcaNK5lq5RxEmqhb2PX5YGBmfeMI8RlHVmAjZZKZXXTJNZ2thv3JRabF/bMAEw
 J9qYUuqu3b6tTyaYVoJ5slZEJIOPOY+gxpF5WoWwq8y8+y5XcjK+GHVG/GusLGXVC5YZ
 iHAxGPlk2txdevnG/Gf8lL5SwtM7ZYUr/Sa4RQL2z4B1dcjM+Y+GJGW0B5+oA5F+akOT
 BOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pZAvuSzWG8A+x8RzKRjMwPsRhtgX7L+uhw4FZKkKEI8=;
 b=qx/IpMbd2CLGW4wYlOU5KrATP3d47vPP5ZSrF5Kf5TU5hRSXmsNH/EUHR8sPhsRV33
 Qnf1r4L/9ibUeGJUi/tMYxCSq5U3VrApWMo8MY5DtbqU/4FHgPl0cQfikKMojBJz01/7
 EFH5nH73taKzKVQI9Fa4VG9so0EQ8l4UEBW+udtlYbZgZw7OkyWdZl36hYxt1LXdwjNZ
 0ngj5vu4ea/qXecLOWIeCoYX+JiGjjnRgaGbG777f9YoOPuG18hBeqyj9phY6MR2FLYF
 AlGNMClr6BWNbY3omkNM2P0qRSwzxBznzknSdOxBfI5cwgabWK4tQoCZQwzaBiB0tTUW
 A4mA==
X-Gm-Message-State: AOAM5315f0DeR9BJz5WDW3xyrYtbapokwa+P+I9Xxc8EEb+KWOi901Wy
 JhzQ063b+wYH/PwZyeQttMPNFA==
X-Google-Smtp-Source: ABdhPJxYAzTiX4xwllUpQ3tEmFyP+aMrMd1eNh0vdVqNy275RfGfMG77U9ZkyVaxQJ39df7vXopr2A==
X-Received: by 2002:a1c:2783:: with SMTP id n125mr5360381wmn.74.1611164536579; 
 Wed, 20 Jan 2021 09:42:16 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id q9sm5974304wme.18.2021.01.20.09.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jan 2021 09:42:15 -0800 (PST)
Date: Wed, 20 Jan 2021 18:41:56 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v9 01/10] iommu: Remove obsolete comment
Message-ID: <YAhrZFCog5FiIupd@myrica>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-2-jean-philippe@linaro.org>
 <20210119111144.00002130@Huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210119111144.00002130@Huawei.com>
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 robin.murphy@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-accelerators@lists.ozlabs.org, sudeep.holla@arm.com,
 vivek.gautam@arm.com, zhangfei.gao@linaro.org, will@kernel.org,
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

On Tue, Jan 19, 2021 at 11:11:44AM +0000, Jonathan Cameron wrote:
> On Fri, 8 Jan 2021 15:52:09 +0100
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > Commit 986d5ecc5699 ("iommu: Move fwspec->iommu_priv to struct
> > dev_iommu") removed iommu_priv from fwspec. Update the struct doc.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org
> 
> Hi Jean-Philippe,
> 
> Flags parameter doesn't have any docs in this structure and should
> do given kernel-doc should be complete.  It probably spits out a warning
> for this if you build with W=1

Ah right, I had a patch removing the flags field locally, but I'm not
planning to upstream that one anymore. I don't mind fixing up the comment
in next version.

Thanks,
Jean

> 
> Not sure if it makes sense to fix that in this same patch, or as a different
> one as the responsible patch is a different one.
> Looks like that came in:
> Commit 5702ee24182f ("ACPI/IORT: Check ATS capability in root complex nodes")
> 
> Also, good to get this patch merged asap so we cut down on the noise in the
> interesting part of this series!
> 
> FWIW
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Jonathan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
