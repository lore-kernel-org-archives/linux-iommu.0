Return-Path: <SRS0=cgap=PK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9806C433EF
	for <iommu@archiver.kernel.org>; Fri, 22 Oct 2021 12:26:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC4B60EB2
	for <iommu@archiver.kernel.org>; Fri, 22 Oct 2021 12:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8DC4B60EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59102403E4;
	Fri, 22 Oct 2021 12:26:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5eSLANAO4Db1; Fri, 22 Oct 2021 12:26:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3BA2A403EF;
	Fri, 22 Oct 2021 12:26:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD028C0037;
	Fri, 22 Oct 2021 12:26:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93669C0020
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 12:26:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F8CC4029A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 12:26:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9EAsydTb7tBG for <iommu@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 12:26:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3999940283
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 12:26:28 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 67-20020a1c1946000000b0030d4c90fa87so2346900wmz.2
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 05:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=aZFQvfnZGEdbwBxw5pEGK7J96oJw/3Vm2ifW0dTky58=;
 b=NzCAVP49FrO/VizJ86Sr62CXSjtbsytSvEpnjvgBlcsRPk/0y8ys1oJaVf2mefU0gw
 vaKkcoLf0BDtoP0AUDFAAt3NbOGdNNi1kQRl9BHiq1UUGv6LHBPabKWbEfhIkcfj7AS4
 JNlwMqJTx5Nm5NFn8dIo20sskfnls7VR0NlDnz6UJBjQjNa1l4OhapY88fxNFzSJ1lIF
 96tvzMY8KOQk616Bayn9n+P8kX0IGYwQ6Q95lFWthg4hzaArSMuzIzqyXA1DI0ST7KHS
 htRsHceqwJP29Sj8DpmJYK8vGniNXDSOnnqA7rxXaByG6iUnTbb2bkhrZ16QuaJK6g59
 VneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aZFQvfnZGEdbwBxw5pEGK7J96oJw/3Vm2ifW0dTky58=;
 b=y9+dFccCPy/WaffyP7WhWYWVWdgc7ecO669g/df0EnR1w6ANmCTfyAwPqtnVuqKHoh
 2vTknnNh4i3qKuXSYcwXQb9Tc3UnUAY7PQb4QNLlb/C7wwvSOuP2tiNy58fedvBGawyf
 rI4cY//Ea0iiy9f+8UhHTsEnHdQu1LCJkZu3+KOmpS+Py3+vnNYpTZ5ppYX9M3epI+bt
 NMz+BaLjSAuEghP0Y0QSreGcAv239JI5lYMUbo4gaYFAuvY3ucqMi5VveBx6+P/G8qlp
 cPNQtwMWYt+Jm8g/vvHAd6WuYcKs4aFrq3y9iGEg69SfXF0ryy0d9T1YgsQK8cZjszse
 AInA==
X-Gm-Message-State: AOAM530z6pPjwmPBNrXtw3zKMbIA59PtGtgPB0Tq2QU/FmZavj+KPWwL
 aUTmHzhxrME96YWRDGqijR/eyQ==
X-Google-Smtp-Source: ABdhPJwZI+vDwgweaPkgQuwmBfFhOyUYS630RJCMu60Wx4XKBGfH2vpzgZWCofA03tTISCIDafT8Hw==
X-Received: by 2002:a1c:7e4f:: with SMTP id z76mr3510994wmc.10.1634905586526; 
 Fri, 22 Oct 2021 05:26:26 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id h22sm8554130wmq.42.2021.10.22.05.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Oct 2021 05:26:26 -0700 (PDT)
Date: Fri, 22 Oct 2021 13:26:03 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/5] iommu/virtio: Add identity domains
Message-ID: <YXKt2x59VQHnpIWj@myrica>
References: <20211013121052.518113-1-jean-philippe@linaro.org>
 <20211022061534-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211022061534-mutt-send-email-mst@kernel.org>
Cc: kevin.tian@intel.com, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com, will@kernel.org,
 jasowang@redhat.com
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

On Fri, Oct 22, 2021 at 06:16:27AM -0400, Michael S. Tsirkin wrote:
> On Wed, Oct 13, 2021 at 01:10:48PM +0100, Jean-Philippe Brucker wrote:
> > Support identity domains, allowing to only enable IOMMU protection for a
> > subset of endpoints (those assigned to userspace, for example). Users
> > may enable identity domains at compile time
> > (CONFIG_IOMMU_DEFAULT_PASSTHROUGH), boot time (iommu.passthrough=1) or
> > runtime (/sys/kernel/iommu_groups/*/type = identity).
> 
> 
> I put this in my branch so it can get testing under linux-next,
> but pls notice if the ballot does not conclude in time
> for the merge window I won't send it to Linus.

Makes sense, thank you. I sent a new version of the spec change with
clarifications
https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg07969.html

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
