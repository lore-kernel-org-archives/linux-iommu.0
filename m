Return-Path: <SRS0=ZMVL=GW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B00C433DB
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 18:33:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD67922CAD
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 18:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD67922CAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8531286847;
	Tue, 19 Jan 2021 17:17:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O4j0eiRly1ac; Tue, 19 Jan 2021 17:17:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 19991867FA;
	Tue, 19 Jan 2021 17:17:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D296C088B;
	Tue, 19 Jan 2021 17:17:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2387C013A
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 17:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 911C986817
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 17:17:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jlr6luqp7qKa for <iommu@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 17:17:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 86BEF867FA
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 17:17:15 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id v184so463579wma.1
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 09:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jDfcg2jk9678vyfqCi9ZzgnTVl/KKx8sZFeEAsCjw7o=;
 b=n6mHkIO//wutRmgNX4lr/ciwWVZy+6JuZYKJ54L0qY7sVfHWbm36v11++Ad5anXmFD
 3oNOk7JyYktLq/I28e2Fxd5Z0H6/ZVgYMdN0+bT660khO0u7FohlpvyK+5t3deGPvj4A
 GBcUDzfshD8u1jZchiNHxqb+EhBym+eqhwBY9UwAcwIJD6bjAqwkQyYD37/gZtxOcpfa
 JLC1vYhK8c2sO7hYFVqg/F0lq4jGl8c8AtCJ3V9h7qP2LyjrM4BLbDbBTvpeq/ze39Le
 4JWZUuPvxbbOo7+oFAp69YBVUWOOJaG7ttadmG5Qjy1U8UH57rxea3WAUVEvqqxfgmto
 jnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jDfcg2jk9678vyfqCi9ZzgnTVl/KKx8sZFeEAsCjw7o=;
 b=EfLj/Bakcc7TdRjWa9tvffWT56ZaAOGrTLMNBtr/55SbRs+TM3WCXKinSwFIS36RwW
 AuGsmIpyAbuVdWcw5XaALJ9G/Rjq9Tt6XJxn6Ee+KHV/4xiF3SAgGQ9YTZn/VnTRFP9J
 Zqy4JQVlRL31EmeMvibxSYxniSMHFi2xstMdvg0qcNv4yJ7bwLGEIV1N0ExZYKz5wgdK
 y783dZEO4OM9kuc/FWUEPOV5hM3UXW0aBPHKu5bmcA6VEgnfAPVrAQjtTZlkxH7nIcsf
 Xl0jv+0ADNBhJw0n2l2FMrqNQPqclag5C9bZCIm4tIqUNDJUWD+FQpGvOEQd1msRZ6TR
 uwlg==
X-Gm-Message-State: AOAM531YnXds1C0DmTxIi/endab7x4Obp6nxR8ELFljmA56bq/tb9BI0
 LMJPBu9po6cJKmDrVs6OWWUVZK16/ePAdRS/AFU=
X-Google-Smtp-Source: ABdhPJz4KcPi8xUUZdVpgsj5Q5Kzuwx0SeRT9GeZatHgWdKcTyuECS3DhM1wGV42sCO5C+PU0ZdZZ/DHYtuXPLe38ks=
X-Received: by 2002:a1c:1b51:: with SMTP id b78mr580821wmb.123.1611076634087; 
 Tue, 19 Jan 2021 09:17:14 -0800 (PST)
MIME-Version: 1.0
References: <1608597876-32367-1-git-send-email-isaacm@codeaurora.org>
 <1608597876-32367-6-git-send-email-isaacm@codeaurora.org>
 <CAF6AEGunsv5r_DmNsMbYwa4KQxRmK9J+5Bd12LYG4pQ=hrCe4Q@mail.gmail.com>
 <20210118213909.GA17971@willie-the-truck>
In-Reply-To: <20210118213909.GA17971@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 19 Jan 2021 09:19:38 -0800
Message-ID: <CAF6AEGutrOnL6dG41ddK37w_RgyV1HHJE_Hyw1t3DAdMtJZfrQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] drm/msm: Add dependency on io-pgtable-arm format
 module
To: Will Deacon <will@kernel.org>
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Android Kernel Team <kernel-team@android.com>, pdaly@codeaurora.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Pratik Patel <pratikp@codeaurora.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Jan 18, 2021 at 1:39 PM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Jan 18, 2021 at 01:16:03PM -0800, Rob Clark wrote:
> > On Mon, Dec 21, 2020 at 4:44 PM Isaac J. Manjarres
> > <isaacm@codeaurora.org> wrote:
> > >
> > > The MSM DRM driver depends on the availability of the ARM LPAE io-pgtable
> > > format code to work properly. In preparation for having the io-pgtable
> > > formats as modules, add a "pre" dependency with MODULE_SOFTDEP() to
> > > ensure that the io-pgtable-arm format module is loaded before loading
> > > the MSM DRM driver module.
> > >
> > > Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> >
> > Thanks, I've queued this up locally
>
> I don't plan to make the io-pgtable code modular, so please drop this patch.
>
> https://lore.kernel.org/r/20210106123428.GA1798@willie-the-truck

Ok, done. Thanks

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
