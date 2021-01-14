Return-Path: <SRS0=IUlV=GR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00214C433E6
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 17:32:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8823823B40
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 17:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8823823B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3854B86BE8;
	Thu, 14 Jan 2021 17:32:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BwDffOa72b7F; Thu, 14 Jan 2021 17:32:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 865CB86BE7;
	Thu, 14 Jan 2021 17:32:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7054CC088B;
	Thu, 14 Jan 2021 17:32:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3807CC013A
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 17:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 06EB120405
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 17:32:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vLSrKA4+KHhf for <iommu@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 17:32:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by silver.osuosl.org (Postfix) with ESMTPS id 22CB1203BA
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 17:32:35 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id d17so9346767ejy.9
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 09:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oaLk6K/ziP0JrSWjUd9yUznepJpKpHz8SodeDVZyc4g=;
 b=GWCGEwBUT89R8ID7PJjuDrp5S3/2qLBz8lkSEggHBoncpJhuQX05ohgD3pibnBXJdi
 W/wjaMWx6cX60jzbnFHzbnh6eCuUIEFyAJ6ZNJbjNBuZcpAFm30vEyoFX0OX7sLCfQ4H
 VBGdlONQQCthSTN9lUkdHxVXmxa5Wwba+So89oDc3hDiAC9lD0o2w3oCuPt9V9T1dNVE
 uS3KkqkupscVrlg43emIU6KBxshTWcjcSyN7OszKlUL3h/iedyxOlz6rn4DfD9f2hWu2
 37xuugp76VAJh3BP8R1ZQyS4EExUjFJSmBGIyEyPgIeSizJ4dmyBRr0xzwBjbW8Z19+S
 31VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oaLk6K/ziP0JrSWjUd9yUznepJpKpHz8SodeDVZyc4g=;
 b=jvHMq47e8gwcut6bHu+Qu/auxUwS+rVSekMe1rzaFWq+TmTQbReEzrsk3gVdXiFNc9
 Wi3uIIKJsAEmmgk62fy4/IbW7pjq6NSKqIX+2UiluXwn8qUtxwCWUAbyncPu5uOQsnZm
 aBURZhIua3dQoGg2elxhS9vbWxJpMGWVDORZVX23yyndzeB8YJWEDD0YvDMdhSoyfFUU
 wvUSI0998gGvngqE0QNI2xo9hrjHAPAj40FD31IPCPIdCmdrzEOCtk1M4s2Jcp+4CkbX
 Yi9+5CwdYcxEilvBEyxH79If/xpfP99arWb1PVZQSuFMZ2qd/o3Ehra587H0XAT4dKOs
 e8ZA==
X-Gm-Message-State: AOAM533Rx1Wgq3bMB5xBeAmgF01whlps7GdTtN41VHhVBroERn/KMIhN
 wk727QGOjqJeeWDES/7PDuxP3g==
X-Google-Smtp-Source: ABdhPJyWGuNgbGnfn6qKQQM5KwVrs3KxAw/sQ5/Phdx+0TwP4Nqgd8PsrwlAs/HuCHWwhAWmPewspQ==
X-Received: by 2002:a17:906:17c3:: with SMTP id
 u3mr5870629eje.304.1610645553317; 
 Thu, 14 Jan 2021 09:32:33 -0800 (PST)
Received: from larix.localdomain ([2001:1715:4e26:a7e0:ed35:e18a:5e36:8c84])
 by smtp.gmail.com with ESMTPSA id n2sm2235623ejj.24.2021.01.14.09.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jan 2021 09:32:32 -0800 (PST)
Date: Thu, 14 Jan 2021 18:33:17 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v13 07/15] iommu/smmuv3: Allow stage 1 invalidation with
 unmanaged ASIDs
Message-ID: <YACAXaG+opCwDFTL@larix.localdomain>
References: <20201118112151.25412-8-eric.auger@redhat.com>
 <1606829590-25924-1-git-send-email-wangxingang5@huawei.com>
 <2e69adf5-8207-64f7-fa8e-9f2bd3a3c4e3@redhat.com>
 <e10ad90dc5144c0d9df98a9a078091af@huawei.com>
 <20201204095338.GA1912466@myrica>
 <2de03a797517452cbfeab022e12612b7@huawei.com>
 <0bf50dd6-ef3c-7aba-cbc1-1c2e17088470@redhat.com>
 <d68b6269-ee99-9ed7-de30-867e4519d104@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d68b6269-ee99-9ed7-de30-867e4519d104@redhat.com>
Cc: Xieyingtai <xieyingtai@huawei.com>, wangxingang <wangxingang5@huawei.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "maz@kernel.org" <maz@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 qubingbing <qubingbing@hisilicon.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "will@kernel.org" <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
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

Hi Eric,

On Thu, Jan 14, 2021 at 05:58:27PM +0100, Auger Eric wrote:
> >>  The uacce-devel branches from
> >>> https://github.com/Linaro/linux-kernel-uadk do provide this at the moment
> >>> (they track the latest sva/zip-devel branch
> >>> https://jpbrucker.net/git/linux/ which is roughly based on mainline.)
> As I plan to respin shortly, please could you confirm the best branch to
> rebase on still is that one (uacce-devel from the linux-kernel-uadk git
> repo). Is it up to date? Commits seem to be quite old there.

Right I meant the uacce-devel-X branches. The uacce-devel-5.11 branch
currently has the latest patches

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
