Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D46C4727E
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 10:19:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C24C42074A
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 10:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24C42074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 730C286DE2;
	Wed, 30 Sep 2020 10:19:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4I8UfmkUjpyq; Wed, 30 Sep 2020 10:19:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A96CF86D88;
	Wed, 30 Sep 2020 10:19:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FC0CC0890;
	Wed, 30 Sep 2020 10:19:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41E26C016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 10:19:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3B910856F6
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 10:19:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 452X2wgQOKJX for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 10:19:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B53BC85317
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 10:19:14 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id g4so1240449edk.0
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 03:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OfTJRaa/8TAarxg+Kx9m69UamnCj7/6BcDzFIhg9imE=;
 b=q/bWJskBj0euekY1BUSKAn+n0S8dg+M1MSYwz1G6Q/H8JqMHcDmF9ijnRGpflM6f8Y
 2OVIUG7nGeb/or4sVJmZLMdZg5fruhaT1JVbt8nnIbFt3VLOXysqecTQAXP5m4OeQT47
 3M2i3p7Dj/LuY80bpn95JnG4Wc7EUQbMQOjQDWw4h4Nh/ALZ7Xm6z00h65QlLvqA94Kz
 BL5XXx6UXhakNm7mIugjgdpdGrMrLvBwFWbE+4N0C8Covpr5WpVJ/ZDuWv9p5j6aLkSq
 +NtdEMUpuNUzTVv2zS31eY9+e3pWSF+tUP5s8JksPZKLaNtBQALtsaFgq7kROyrRkWMy
 jGQw==
X-Gm-Message-State: AOAM532IZ265jNsDOw6Kmpl17VznWusk3rIjZJ54COGQuRtieIvNxY5p
 7QMfFsZfEyTY2dSJWwKWsiY=
X-Google-Smtp-Source: ABdhPJxI9G3fz0Hy5adUFLWMdVySYAPVnzVYqZbp+i4LqrLXxP4uBbfGGky5VyDcqZvwZvjDV53EMw==
X-Received: by 2002:a50:cc8d:: with SMTP id q13mr1857004edi.298.1601461153186; 
 Wed, 30 Sep 2020 03:19:13 -0700 (PDT)
Received: from pi3 ([194.230.155.194])
 by smtp.googlemail.com with ESMTPSA id g11sm1032053edj.85.2020.09.30.03.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 03:19:12 -0700 (PDT)
Date: Wed, 30 Sep 2020 12:19:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20200930101909.GA1147@pi3>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <CAJKOXPeF8D0A6PGVbi_7RedO-DFd70sjGcJOjx-gCJ7Cd8k0YQ@mail.gmail.com>
 <20200930094032.GA6686@Asurada-Nvidia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200930094032.GA6686@Asurada-Nvidia>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, digetx@gmail.com
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

On Wed, Sep 30, 2020 at 02:40:32AM -0700, Nicolin Chen wrote:
> On Wed, Sep 30, 2020 at 11:21:14AM +0200, Krzysztof Kozlowski wrote:
> > On Wed, 30 Sep 2020 at 10:48, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > >
> > > Previously the driver relies on bus_set_iommu() in .probe() to call
> > > in .probe_device() function so each client can poll iommus property
> > > in DTB to configure fwspec via tegra_smmu_configure(). According to
> > > the comments in .probe(), this is a bit of a hack. And this doesn't
> > > work for a client that doesn't exist in DTB, PCI device for example.
> > >
> > > Actually when a device/client gets probed, the of_iommu_configure()
> > > will call in .probe_device() function again, with a prepared fwspec
> > > from of_iommu_configure() that reads the SWGROUP id in DTB as we do
> > > in tegra-smmu driver.
> > >
> > > Additionally, as a new helper devm_tegra_get_memory_controller() is
> > > introduced, there's no need to poll the iommus property in order to
> > > get mc->smmu pointers or SWGROUP id.
> > >
> > > This patch reworks .probe_device() and .attach_dev() by doing:
> > > 1) Using fwspec to get swgroup id in .attach_dev/.dettach_dev()
> > > 2) Removing DT polling code, tegra_smmu_find/tegra_smmu_configure()
> > > 3) Calling devm_tegra_get_memory_controller() in .probe_device()
> > > 4) Also dropping the hack in .probe() that's no longer needed.
> > >
> > > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > > ---
> > >
> > > Changelog
> > > v2->v3
> > >  * Used devm_tegra_get_memory_controller() to get mc pointer
> > >  * Replaced IS_ERR_OR_NULL with IS_ERR in .probe_device()
> > > v1->v2
> > >  * Replaced in .probe_device() tegra_smmu_find/tegra_smmu_configure()
> > >    with tegra_get_memory_controller call.
> > >  * Dropped the hack in tegra_smmu_probe().
> > >
> > >  drivers/iommu/tegra-smmu.c | 144 ++++++++++---------------------------
> > >  1 file changed, 36 insertions(+), 108 deletions(-)
> > >
> > > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> > > index 6a3ecc334481..636dc3b89545 100644
> > > --- a/drivers/iommu/tegra-smmu.c
> > > +++ b/drivers/iommu/tegra-smmu.c
> > > @@ -61,6 +61,8 @@ struct tegra_smmu_as {
> > >         u32 attr;
> > >  };
> > >
> > > +static const struct iommu_ops tegra_smmu_ops;
> > 
> > I cannot find in this patch where this is assigned.
> 
> Because it's already set in probe():
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/iommu/tegra-smmu.c#n1162
> 
> And my PATCH-3 sets it for PCI bus also.

OK, good point. Thanks for explanation.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
