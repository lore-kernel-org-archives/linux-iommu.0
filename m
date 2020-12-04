Return-Path: <SRS0=gcKa=FI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF980C4361A
	for <iommu@archiver.kernel.org>; Fri,  4 Dec 2020 09:54:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC0822838
	for <iommu@archiver.kernel.org>; Fri,  4 Dec 2020 09:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC0822838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9E30320460;
	Fri,  4 Dec 2020 09:54:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tr9q1LbVOcR6; Fri,  4 Dec 2020 09:54:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CD7502041D;
	Fri,  4 Dec 2020 09:54:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAE57C0FA7;
	Fri,  4 Dec 2020 09:54:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15D3CC013B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Dec 2020 09:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E875A87743
 for <iommu@lists.linux-foundation.org>; Fri,  4 Dec 2020 09:54:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yTPrD21yjU9l for <iommu@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 09:54:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0EC37876FA
 for <iommu@lists.linux-foundation.org>; Fri,  4 Dec 2020 09:54:00 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id n26so7798592eju.6
 for <iommu@lists.linux-foundation.org>; Fri, 04 Dec 2020 01:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Uv2efItsQUhEgfX7SeOo28N5gNOKYGwcTRvbk7tp5sk=;
 b=Y+yQmo30CQFiR5TTzDwrmyJatxpqtANqRpaIncgY2A8s2nWuzGUeyn1tlf4gOxugd2
 hh8E3nHhmj4zo93RilCZjKplbsTkCbNxNPF8uYID9W5PuMKVGbJigGgWD9afGHl880zK
 58XjKXOHPeMO/smMTfgANFsLPDLJ7SGTQmRGvK5+9rVbt5ynuxcXqQInlbHiTr3T4N4V
 w8Wu7TpMV552x6QPPvqgAlSK6lmA7BRml4jRWHiI63XOeYUq0EO1/mbxl22WqthPcaDm
 nfWp3DFvC6vgW0kGiJ+NqG+v0vXx7/6/rIRANPewGZH1nMCdkpAXWjUQbYAPRfIXi/R1
 CaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Uv2efItsQUhEgfX7SeOo28N5gNOKYGwcTRvbk7tp5sk=;
 b=nNmeLuqHvNNepm4Qg1rWVh/AKSjZi8xazf1dVff6fPS6PZuvyVswrs7d3Xu3Fagdto
 DgbBA478WKTMteapr6vEMVPYj9XWvxlf4UtSEnxdOQgHjtsj7yvMlRPPeFGfxXC20E2S
 zrduiG26NJDQpqfh3xUri+602pJHrSY0PQJpQ3vJGn3nnMfqo7j06fhns2UQAZ8CzZZi
 dGlu5l+EMRVe1owQ5jDqYSlqseEEJwKxRgJ8hvgEe9h+/3cNlahWQ1qeWXtFKSRfIqN0
 3O9Gk3lofN2zBVd3ZZTTyvGMIued3FYgX+FtCWOg+np09m2/a5RtH1Z4HYgK8U/iJdWM
 Qg2A==
X-Gm-Message-State: AOAM530Qxizr7C5VmbLWkyQDpIvE0Mv1fNroGYoRaU/yYBx6Jm5k8ytq
 50H5qm8VYJLpM02X8lIwsrvhiQ==
X-Google-Smtp-Source: ABdhPJwXvl8nLosqnGM8eU8JP87XsB+l9fv0jbHDns3+jJMfPKJqM1nwHazVtadoe4qIEMJGSczwsg==
X-Received: by 2002:a17:906:81ca:: with SMTP id
 e10mr6195735ejx.449.1607075638385; 
 Fri, 04 Dec 2020 01:53:58 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id k2sm2690147ejp.6.2020.12.04.01.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Dec 2020 01:53:57 -0800 (PST)
Date: Fri, 4 Dec 2020 10:53:38 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v13 07/15] iommu/smmuv3: Allow stage 1 invalidation with
 unmanaged ASIDs
Message-ID: <20201204095338.GA1912466@myrica>
References: <20201118112151.25412-8-eric.auger@redhat.com>
 <1606829590-25924-1-git-send-email-wangxingang5@huawei.com>
 <2e69adf5-8207-64f7-fa8e-9f2bd3a3c4e3@redhat.com>
 <e10ad90dc5144c0d9df98a9a078091af@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e10ad90dc5144c0d9df98a9a078091af@huawei.com>
Cc: Xieyingtai <xieyingtai@huawei.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 wangxingang <wangxingang5@huawei.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 qubingbing <qubingbing@hisilicon.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "will@kernel.org" <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

Hi Shameer,

On Thu, Dec 03, 2020 at 06:42:57PM +0000, Shameerali Kolothum Thodi wrote:
> Hi Jean/zhangfei,
> Is it possible to have a branch with minimum required SVA/UACCE related patches
> that are already public and can be a "stable" candidate for future respin of Eric's series?
> Please share your thoughts.

By "stable" you mean a fixed branch with the latest SVA/UACCE patches
based on mainline?  The uacce-devel branches from
https://github.com/Linaro/linux-kernel-uadk do provide this at the moment
(they track the latest sva/zip-devel branch
https://jpbrucker.net/git/linux/ which is roughly based on mainline.)

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
