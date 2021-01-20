Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01618C433E6
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 17:44:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B4B207C4
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 17:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B4B207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3067A87116;
	Wed, 20 Jan 2021 17:44:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SBKcfgzj1DrI; Wed, 20 Jan 2021 17:44:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A21108710E;
	Wed, 20 Jan 2021 17:44:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7256CC088B;
	Wed, 20 Jan 2021 17:44:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85F8FC013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 17:44:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6EC8A866C7
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 17:44:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PiUKMQZVjRjy for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 17:44:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E26A9866AE
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 17:44:17 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id i63so3549970wma.4
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 09:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XBDrkS1oD3yusqtA8y0OBGE63KTKv7F+ZOLzwqVkI2I=;
 b=PdmTfH14kG9PRl6fGS7BmdZgTQAEoANTBqMuycLSr30LXege/CoUiWzaSqCLGm9c0E
 OI5hofRqmHOYjYrnWw5TlLT2waLaHAR/y+gHT0mYHh6UMy4e0XQNPurmj2iVa6jhLXxm
 uLSuG38XTI7ml4u9pnqSDqXE0ULlRCVhq/fJt+40bn7r6BGPSLKVZRvBwKjFwIzSrWC7
 StUUBtbaje0KKajzY/K3QxyN0qRQ2Z2LehH7r9LDgrZWXV8K/7W44Bx65lZ6pmR/0y2W
 eemmnDKNS6i14YBxwZsqnXg4duRbp2D87JDFqo+paL4iFEDj4k1WBs/jW9Vr5C3Kjj/0
 IsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XBDrkS1oD3yusqtA8y0OBGE63KTKv7F+ZOLzwqVkI2I=;
 b=jT46MPHnv5n0CrrPuXzxf1510OBaycQwKfCmTiFxYpB4Tk9eMzEthiq/oJ1MEsJBQa
 CBO3RraRt4YGKAjDj2qpFn2xbYuLDNnE2p9rejm3lJ0kxg+EwbvIEb7lsHadPMISQ6zB
 Y49FWlUSDoCywXLrq+SvT0qPYYxYGcDnLaJxzKWCBhxAM6uvaO9C7Q6Yr3GAhxCKY+JW
 JDYdNt1ISleu8ZHuP8AAa7WMeJZJncVESzDl4qDwqPwc85ZqTEjqADxrmn2lm4F9nGfy
 2dJYSuu8BHZF2okyT8ylKRi0fjWZVpOZ2gLbQMWYhuhj9Rt1k+TPue89sgcRIQvNtZg4
 9WhA==
X-Gm-Message-State: AOAM531ZhPh5ljjZkxRyR3D/XthA264ZpCi18pr+Ug5V9XsJr18SFkJe
 wzppxrBty/MeuhQYROVDAF6DLw==
X-Google-Smtp-Source: ABdhPJwfZJ22FxfOkxX1mD/qmpstD9sUNv3GPJc1IViT4T+eQrVlLm/n8Bui8NwhbrvqMvOjfSDKmg==
X-Received: by 2002:a7b:c00a:: with SMTP id c10mr5280073wmb.66.1611164656382; 
 Wed, 20 Jan 2021 09:44:16 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id f68sm5575012wmf.6.2021.01.20.09.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jan 2021 09:44:15 -0800 (PST)
Date: Wed, 20 Jan 2021 18:43:55 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v9 06/10] iommu: Add a page fault handler
Message-ID: <YAhr28EbUNNJt08t@myrica>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-7-jean-philippe@linaro.org>
 <20210119133819.000015f6@Huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210119133819.000015f6@Huawei.com>
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

On Tue, Jan 19, 2021 at 01:38:19PM +0000, Jonathan Cameron wrote:
> On Fri, 8 Jan 2021 15:52:14 +0100
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > Some systems allow devices to handle I/O Page Faults in the core mm. For
> > example systems implementing the PCIe PRI extension or Arm SMMU stall
> > model. Infrastructure for reporting these recoverable page faults was
> > added to the IOMMU core by commit 0c830e6b3282 ("iommu: Introduce device
> > fault report API"). Add a page fault handler for host SVA.
> > 
> > IOMMU driver can now instantiate several fault workqueues and link them
> > to IOPF-capable devices. Drivers can choose between a single global
> > workqueue, one per IOMMU device, one per low-level fault queue, one per
> > domain, etc.
> > 
> > When it receives a fault event, supposedly in an IRQ handler, the IOMMU
> 
> Why "supposedly"? Do you mean "most commonly" 
> 
> > driver reports the fault using iommu_report_device_fault(), which calls
> > the registered handler. The page fault handler then calls the mm fault
> > handler, and reports either success or failure with iommu_page_response().
> > When the handler succeeds, the IOMMU retries the access.
> 
> For PRI that description is perhaps a bit missleading.  IIRC the IOMMU
> will only retry when it gets a new ATS query.
> 
> > 
> > The iopf_param pointer could be embedded into iommu_fault_param. But
> > putting iopf_param into the iommu_param structure allows us not to care
> > about ordering between calls to iopf_queue_add_device() and
> > iommu_register_device_fault_handler().
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> One really minor inconsistency inline that made me look twice..
> With or without that tided up FWIW.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks! I'll fix these up and resend
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
