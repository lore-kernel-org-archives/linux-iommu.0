Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534D1C433DF
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 15:32:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8F2207ED
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 15:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8F2207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 231108643D;
	Mon, 18 May 2020 15:32:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1idAL9YDCFxJ; Mon, 18 May 2020 15:32:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D9C6E86374;
	Mon, 18 May 2020 15:32:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BACF5C0888;
	Mon, 18 May 2020 15:32:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72BD0C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 15:32:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6052786435
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 15:32:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4TjcYS_XJgjW for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 15:32:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8978686374
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 15:32:09 +0000 (UTC)
Received: from mail-pl1-f200.google.com ([209.85.214.200])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1jahkN-0002Gp-9T
 for iommu@lists.linux-foundation.org; Mon, 18 May 2020 15:32:07 +0000
Received: by mail-pl1-f200.google.com with SMTP id q7so7718695plr.4
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 08:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=DSec870v7lcetS/nj+jERIYNbmyiptV5Gs1Gq6B0yDE=;
 b=BF//jrtaptp3AdOqX43XEVkDextIxxdgVQHlaN62lb2mjnO+7VFyDB+nauntFjbMD4
 hvBxhg9rXNpe0vrnrro5/9JBcsKk57bcH8F9FxrGfiG/apd3xEteA6fBJJVud/8Z6sFw
 3FcjXgvZ2Jr29F/ffsfaQNWX5ZyPzVCNWiYVHbQMRDvF1PkRsJGDGrCKYlTjwgBG0VVB
 P9celB7bqdppASRclbmJM6Uj3HhOheTk1M5HuTyA1HIBx5TJ+Vopgb2erlQzWKRv8LdU
 qy+deM11VP6uXYojA8OSBhfGgMrVQcIEvp/QAAtpfpunt7eXk4vbqij1wpZKmb6rPwmj
 9U+g==
X-Gm-Message-State: AOAM533gO5i3Wp1C3YIjbLD8xGqA6cKqoPB61376Lnx8hKsT/uMpmhrg
 k47Bke32J6nM2eIdzkdYHjjwXbsuLdU19NmV3gvr+P2TqqiuImRpj3q/mThl01TYFLaP1iw28z3
 g7PnZexyemesF9qSgFClcv5xBQjU3BQhvzRgQOdef1s27bHg=
X-Received: by 2002:a62:e91a:: with SMTP id j26mr17396666pfh.61.1589815925911; 
 Mon, 18 May 2020 08:32:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGxZm/plZKIuJE3WpwUAsM+BGrbLgozR6Kn1MCOfBfyaSgIZ8IrE5uES428hzb66aufTbupg==
X-Received: by 2002:a62:e91a:: with SMTP id j26mr17396636pfh.61.1589815925588; 
 Mon, 18 May 2020 08:32:05 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net.
 [220.133.187.190])
 by smtp.gmail.com with ESMTPSA id m3sm8646593pjs.17.2020.05.18.08.32.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 May 2020 08:32:04 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [Regression] "iommu/amd: Relax locking in dma_ops path" makes tg3
 ethernet transmit queue timeout
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <381D21C9-C913-4C33-A6F4-0440B5D11670@canonical.com>
Date: Mon, 18 May 2020 23:32:02 +0800
Message-Id: <8D375E06-A763-4B5E-9C6D-DA5EBC62530E@canonical.com>
References: <4E9B03FB-9DA5-4831-B4CE-A0AA645D3F22@canonical.com>
 <20200518133209.GM8135@suse.de>
 <381D21C9-C913-4C33-A6F4-0440B5D11670@canonical.com>
To: Joerg Roedel <jroedel@suse.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Cc: iommu@lists.linux-foundation.org, open list <linux-kernel@vger.kernel.org>
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



> On May 18, 2020, at 22:05, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> 
> 
>> On May 18, 2020, at 21:32, Joerg Roedel <jroedel@suse.de> wrote:
>> 
>> On Mon, May 18, 2020 at 05:06:45PM +0800, Kai-Heng Feng wrote:
>>> Particularly, as soon as the spinlock is removed, the issue can be reproduced.
>>> Function domain_flush_complete() doesn't seem to affect the status.
>>> 
>>> However, the .map_page callback was removed by be62dbf554c5
>>> ("iommu/amd: Convert AMD iommu driver to the dma-iommu api"), so
>>> there's no easy revert for this issue.
>>> 
>>> This is still reproducible as of today's mainline kernel, v5.7-rc6.
>> 
>> Is there any error message from the IOMMU driver?
>> 
> 
> As of mainline kernel, there's no error message from IOMMU driver.
> There are some complains from v4.15-rc1:
> https://pastebin.ubuntu.com/p/qn4TXkFxsc/

Just tested v5.7-rc6, the issue disappears as soon as kernel boots with "iommu=off".

Kai-Heng

> 
> Kai-Heng

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
