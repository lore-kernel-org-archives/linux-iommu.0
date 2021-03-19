Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D66C433DB
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 09:59:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B015064EF6
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 09:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B015064EF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6474146541;
	Fri, 19 Mar 2021 09:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iAXUu2QuyxeL; Fri, 19 Mar 2021 09:59:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24C69467FF;
	Fri, 19 Mar 2021 09:59:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76D0DC000A;
	Fri, 19 Mar 2021 09:59:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0137BC0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 09:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D7E624010E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 09:59:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KuL0Na967u4E for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 09:59:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23715400A8
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 09:59:01 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 a132-20020a1c668a0000b029010f141fe7c2so4753625wmc.0
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 02:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+ew0oK+98acMtQgKLGerzyoNXnWF03GfXmL2rWxicfk=;
 b=UdvS3qSDTfqH6Y/9ofxlqvCMdGhYTHBMlEKvkuSNFIAbXj3Iw7mjRPnscCsrtOHM5G
 MlOFed3B9j8sNv6cKE1CjkDG7IVfJZaejlQLQHjinhmn4md6lO9XFnLYwz+70nP+jRDQ
 Z5fs4LXC67m6l5OhlLif7iHkDnjNtHEEH8Un5AjM4d/DNim7CCkfGj9IPPbiGnACMtVL
 9Zuh84uDGYWvyZbcQ+M9KjO0nCzsdA+CCKhBixRmtofebvqO9UQMbXS2Ktix/fxZ3r4N
 ktpSWYrVOqT0PqvQqWuidhdHYwmu0PFpnGYb/SHBosxdSqn1KgYSTXs5RpmVr3XP5Hqg
 ixMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+ew0oK+98acMtQgKLGerzyoNXnWF03GfXmL2rWxicfk=;
 b=A/uaf4JhguvxzLoB2vGsCJVAAs3ERMNnN78uK04rZuoZDOiyW7pyG22mkXoX4MILnQ
 FFBdM1GT5lfe/3ZU/bLna8zFV8SU6t53zV+BcnNj7dsUL4415KfBVm08LOKC5tjzRang
 hm1zXHqeUvMM0U8iyNHWuKKmiCIko0eFEU2k2p9a36nX4XbT0mHsOoR+SiRrdgCOey/p
 W4A1lsq2GymIg86oumHHnLmqXyZgpT+s5KK6RoZjYrLpOlSPMb7cZzviy8siIgipwxoh
 vP+XdG3kAD8A7p4n4A9Q+2e/QOtprT9JYDe4qB4QH6jZGBuOAX9Dqn2LSjQddRJGUvBJ
 8cDQ==
X-Gm-Message-State: AOAM533pi0tKIB2eBa5Avwr4lZ1UHBkkfx1Izy39Ga2SVNbDpRIemPul
 l6ReGbWvmq18sXPKNC6b0Qysqw==
X-Google-Smtp-Source: ABdhPJywMEYo3x8bbMPypYbibw8Xew0V2G0kK4FRG8qDJBcGfhyk0lGzYJpIvJj3vaFynvVmrw/7UQ==
X-Received: by 2002:a7b:c087:: with SMTP id r7mr2960647wmh.110.1616147940350; 
 Fri, 19 Mar 2021 02:59:00 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id k4sm9039154wrd.9.2021.03.19.02.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Mar 2021 02:58:59 -0700 (PDT)
Date: Fri, 19 Mar 2021 10:58:41 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YFR10eeDVf5ZHV5l@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210318172234.3e8c34f7@jacob-builder>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Li Zefan <lizefan@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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

Hi Jacob,

On Thu, Mar 18, 2021 at 05:22:34PM -0700, Jacob Pan wrote:
> Hi Jean,
> 
> Slightly off the title. As we are moving to use cgroup to limit PASID
> allocations, it would be much simpler if we enforce on the current task.

Yes I think we should do that. Is there a problem with charging the
process that does the PASID allocation even if the PASID indexes some
other mm?

> However, iommu_sva_alloc_pasid() takes an mm_struct pointer as argument
> which implies it can be something other the the current task mm. So far all
> kernel callers use current task mm. Is there a use case for doing PASID
> allocation on behalf of another mm? If not, can we remove the mm argument?

This would effectively remove the mm parameter from
iommu_sva_bind_device(). I'm not opposed to that, but reintroducing it
later will be difficult if IOMMU drivers start assuming that the bound mm
is from current.

Although there is no use for it at the moment (only two upstream users and
it looks like amdkfd always uses current too), I quite like the
client-server model where the privileged process does bind() and programs
the hardware queue on behalf of the client process.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
