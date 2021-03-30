Return-Path: <SRS0=H7Zn=I4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC79FC433C1
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 17:18:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E02619CD
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 17:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E02619CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B82B404CA;
	Tue, 30 Mar 2021 17:18:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qf3z5P_N8J5G; Tue, 30 Mar 2021 17:18:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3926404C8;
	Tue, 30 Mar 2021 17:18:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1704C000C;
	Tue, 30 Mar 2021 17:18:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54163C000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 17:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 407B1404C9
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 17:18:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rQakx1wZ2B6w for <iommu@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 17:18:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B9E3404C8
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 17:18:16 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 r10-20020a05600c35cab029010c946c95easo8810173wmq.4
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wv5s2hFIUo2gKQ4gDxjTXneaufMswuUrX5PqppLDZlw=;
 b=seDS3AbA2YxPNbqBPGSiqi1kOqb8GqtxtF3q5yGUPHMl1LYormxa50YHLOoSgwqCDW
 5d6MoW+Pws1fvmGJqeXGtRh+udchEEFs0PXDaL+xsUI3W2PRpkxMMPcg3sr1EHiDYOJQ
 EA23RAX+U3yXZ65A3V6zan94Pho1p3fVlmwrVbF7LAQ9ua0EcVcxCTWE2Et65UYpX45O
 Zd5wznq/kir0bQmALsIbGIcMeJbRm9e0tWOY/vSjITj429wVOiULFcgCRU8G/r16D96I
 BjWkLOry9XIGmTIz4QIkexKAzhE7SrJloVxD7zET0HsPEGAw4JTdwMlyQpcZ0Jkkyr/z
 SH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wv5s2hFIUo2gKQ4gDxjTXneaufMswuUrX5PqppLDZlw=;
 b=rwOBlMtH/mFII9TS0fk+UTP2uNndPgOvrhtcuvH0exTr0aa1WNeS+AsQF0NtGvYPoB
 kAPZ2edIiPNNdVpmGSiPTKnQ//pw7vb/KdN4KVtD/CrVzxSFsp/5/ObeswxdFRgbNtfC
 4P5PVv0Q5L75HQ3TZvrSjEzIY3Ifkq79u59KYz4JXGI9NFUB3yCay8J+WxSsFVcP3dle
 LnTkymAr1jw8qTxYJYOxUUuTzlBZKkE7D4Y+k8f+TbBLhDWu6CyKxtN2TyttlIa1b6Nv
 nLOEqD+inI/T2s1lZtuFpxIMM1Fn8d56xCKmKvwQ2kgs7nLiph6/28f52TJMDx5+oeSN
 kBMQ==
X-Gm-Message-State: AOAM530aATVmklddXuWHnHyyttUPE4w8HXansAETjsCsFhiaeGVnccEz
 AGYJZhdoDWHvN6xBuGdWe+hMvQ==
X-Google-Smtp-Source: ABdhPJxWMhf+gc+wpTtm59XgeUZsbWjnVM7+DjvkPDd2IW2QmwXRwSkIh4AEvc7E/VkGQxzV/6eMNw==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr5130672wml.97.1617124694446;
 Tue, 30 Mar 2021 10:18:14 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id a6sm6542927wmm.0.2021.03.30.10.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Mar 2021 10:18:13 -0700 (PDT)
Date: Tue, 30 Mar 2021 19:17:55 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org, will@kernel.org
Subject: Re: [PATCH v13 00/10] iommu: I/O page faults for SMMUv3
Message-ID: <YGNdQ863Mohizx7A@myrica>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210302092644.2553014-1-jean-philippe@linaro.org>
Cc: vivek.gautam@arm.com, guohanjun@huawei.com, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
 robin.murphy@arm.com, linux-accelerators@lists.ozlabs.org
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

Hi Will, Joerg,

On Tue, Mar 02, 2021 at 10:26:36AM +0100, Jean-Philippe Brucker wrote:
> Add stall support to the SMMUv3 driver, along with a common I/O Page
> Fault handler.

I only have review/ack tags and one assert_lockdep to add to this series.
Should I send a v14 now or wait a little longer?  Just making sure we can
get at least patches 1-6 in v5.13.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
