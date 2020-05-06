Return-Path: <SRS0=YHJ+=6U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C179AC47247
	for <iommu@archiver.kernel.org>; Wed,  6 May 2020 02:18:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C65206A4
	for <iommu@archiver.kernel.org>; Wed,  6 May 2020 02:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="MmdjAnPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C65206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5AD8D885FD;
	Wed,  6 May 2020 02:18:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oY-ddnL3WThj; Wed,  6 May 2020 02:18:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B43DF885F1;
	Wed,  6 May 2020 02:18:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B28DC088B;
	Wed,  6 May 2020 02:18:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E752C0859
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 02:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EAF69885F1
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 02:18:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W3EfvlnKviyM for <iommu@lists.linux-foundation.org>;
 Wed,  6 May 2020 02:17:58 +0000 (UTC)
X-Greylist: delayed 00:08:09 by SQLgrey-1.7.6
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 15F3B87EA9
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 02:17:57 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id k12so199002qtm.4
 for <iommu@lists.linux-foundation.org>; Tue, 05 May 2020 19:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w8gbY87jwoL79rOzujZxuWgYYqNEcM3nQ5vgXMTM9zM=;
 b=MmdjAnPhIcXZFa/Uyr2pGKHtAwLyCHq71NtdsW+6NUKV0VZFYzZT7rIdvsNGn3gk3H
 0/9pErNgqlnBrxGf26yCELIuS9YkBDu6AJyKh1eOUMlYQnR8alRkBPM1355aSY3xRjcR
 v69Wai+kEuOqB5MVlfi54N/CWIjX/pOkBYe7/gZuQyAk8gWmeHtaHzFtbIrdM/mSp89l
 Py1VXrwLrpaSYt+7fZTK4vIhYXDTh1maRxX/gu/3aL8ORh7o794YvS9HJBepVNgJtlWp
 8ZmhAWcRtcJQ7wOwAuqZ5xaMVnpoc9Dfum3JwE/VoRSkLlgwSQPgbQuIz+/Fc1oK9EMF
 Gm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w8gbY87jwoL79rOzujZxuWgYYqNEcM3nQ5vgXMTM9zM=;
 b=TnBeNK7WpgXrdsLkMOxk+eaGy8ZZXhd3LiCgl3xX4rmxR5UENckqO/F4C9cC/4X5nj
 7E2QBVEBSUncxEDSdPLcyx3Zn/CkbqIl+xc/zwHbezLSeYDp1rOSS08OR/u9n7ojcO7W
 cedikLfnDM3fCu2Wb4Q9yOD7anCBrlLVgPPnRrEas9VCZFn13B/fUZFOhCnP4qk3+bXl
 1gXqssdR7fMVDMHTu3OVlCIGpmouEZJfAuN3wyMsG/efYFjzxVavZLF/dBBBLrozYwMR
 vWUPw8rpPFGxlymaihJeUM31iAW+lMGj8fzOlKOAfmQV4sifB5jUS8Cs00b1YboHUc8y
 LG5A==
X-Gm-Message-State: AGi0PuYSPCQ17rBvLU7PWsaUe+wfSerzXf0O4zq/4/0tC/FTsZRA4eh+
 p84dkL1AfeFhPtcXgimcJuNwzFcg0Vb4CdDRmgQfz5eJn/qy6g==
X-Google-Smtp-Source: APiQypLm3V841UNO/xQjYTQ0MN5YrL0FALdP+pBATlxbGvy3OP/IDrcxxlRnz8fLpIrZwLvOu32AXS3gBeQL+h5jtXE=
X-Received: by 2002:ac8:3877:: with SMTP id r52mr5976506qtb.47.1588730988716; 
 Tue, 05 May 2020 19:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200506015947.28662-1-baolu.lu@linux.intel.com>
In-Reply-To: <20200506015947.28662-1-baolu.lu@linux.intel.com>
From: Daniel Drake <drake@endlessm.com>
Date: Wed, 6 May 2020 10:09:37 +0800
Message-ID: <CAD8Lp47E2CDmHTEGSpqYfxxKB4a+JY6VzZdL9e65P7YxqfL9Ag@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Replace private domain with per-group default
 domain
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Derrick Jonathan <jonathan.derrick@intel.com>
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

On Wed, May 6, 2020 at 10:03 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
> https://lkml.org/lkml/2020/4/14/616
> [This has been applied in iommu/next.]
>
> Hence, there is no need to keep the private domain implementation
> in the Intel IOMMU driver. This patch series aims to remove it.

I applied these patches on top of Joerg's branch and confirmed that
they fix the issue discussed in the thread:

[PATCH v2] iommu/vt-d: consider real PCI device when checking if
mapping is needed
(the patch there is no longer needed)

Tested-by: Daniel Drake <drake@endlessm.com>

Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
