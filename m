Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DCCC433EF
	for <iommu@archiver.kernel.org>; Thu, 31 Mar 2022 14:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3380D41B4A;
	Thu, 31 Mar 2022 14:04:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SOMYuYr9n09F; Thu, 31 Mar 2022 14:04:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 87B8A4197D;
	Thu, 31 Mar 2022 14:04:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B1F0C002C;
	Thu, 31 Mar 2022 14:04:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DE36C0012
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 06:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5639D83EB9
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 06:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=baylibre-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FC1JGVP8uA81 for <iommu@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 06:39:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D6FA883403
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 06:39:33 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id n18so22529234plg.5
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 23:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ssMn3LgcqyUmnx75/iLOLIWP4zeXASia6Tnjq8mIfrE=;
 b=NpXDVqGKFymC1XLJQ7htr7fWp09/zeOVf2qamz4txb2GoFA8suoKmqOmvqGS0c4ddL
 n5y2p0W9VGETLvZ1DeAKeXRUtpKzWheOE9gR/+iqV7bWME+zwexmsyaPEeJJVU6Y7sOx
 42X9aPuUnFn1cyzVJQu1YcO87Ksg5lhmpP+ldNO6tZPdW9SXMGQhhLCctUT/HC79/YnW
 Y9AthoXOozNyu0OfDH6rOH1m4P4uMszaaORnqwm9k73BvhjI9CxTpfisiWbgw8hGF59u
 qZuwu3dLUQ4Z0zr4RYZBvPQznZ26FxuUs6soLQucuj0chwCUYDAVC7+njK8vrbizVXMw
 L8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ssMn3LgcqyUmnx75/iLOLIWP4zeXASia6Tnjq8mIfrE=;
 b=NYkxWqgXDUJirN6cFAl/OVWaMwJqRQWJVsRX12KZhhSDtPV1WzUMCzVbJvgKSxY1Ls
 J6yszyASQHWvXYDb7IRznrvOe9G2rX7vSSSN43BYcaeXFvxmFEU8VF5v5dq/QDf0Tf8Q
 e5oQsway25vgKvq13uF43I4Trnuj5B+pxeQ227Xomv2ySYOm3GDHt6t1Up5tI2BJ9wWg
 hDsHLpQtxV0Z+eUJC1xB+/YdqDksHqS/URyEdZh3y3WYQ1XCxkZolmeVJyz6PufgYzIj
 nLQc+0puTw8QtfBAavM7cqApksi+G0wAuQA0+4SWOYb5gOcMz5KBgaXGqhda2Ej1v5eU
 zl1g==
X-Gm-Message-State: AOAM5326nPvVbf+q6s7rKF8vicvCOLs98mFlA8sMMlpB5qGFIzeTSsv+
 /6pPEl3HOvsfY6/PWNwGd3y1zA==
X-Google-Smtp-Source: ABdhPJxg8Jd/wIlfmFWYs83KmW+WvyXG2lBhmNylpzP+JkKECZPF1xUHOZgVBSQLSA9OugBSKYFxhw==
X-Received: by 2002:a17:90b:250f:b0:1b8:f257:c39 with SMTP id
 ns15-20020a17090b250f00b001b8f2570c39mr4384147pjb.135.1648708772867; 
 Wed, 30 Mar 2022 23:39:32 -0700 (PDT)
Received: from x1 ([2601:1c2:1001:7090:feed:61b1:ff4a:b7d5])
 by smtp.gmail.com with ESMTPSA id
 u62-20020a638541000000b00382791c89efsm21306861pgd.13.2022.03.30.23.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Mar 2022 23:39:32 -0700 (PDT)
Date: Wed, 30 Mar 2022 23:40:19 -0700
From: Drew Fustini <dfustini@baylibre.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 8/9] iommu: Remove unused argument in is_attach_deferred
Message-ID: <YkVM05q2/fBbq51E@x1>
References: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
 <20220216025249.3459465-9-baolu.lu@linux.intel.com>
 <YkRiawC2T9g+CHSJ@atomide.com>
 <20220330142340.GA2111031@nvidia.com>
 <YkSRKZcJO0q3v5WL@atomide.com>
 <20220330173323.GA2120790@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220330173323.GA2120790@nvidia.com>
X-Mailman-Approved-At: Thu, 31 Mar 2022 14:04:15 +0000
Cc: regressions@lists.linux.dev, David Airlie <airlied@linux.ie>,
 Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Tony Lindgren <tony@atomide.com>, Ben Skeggs <bskeggs@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Mar 30, 2022 at 02:33:23PM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 30, 2022 at 08:19:37PM +0300, Tony Lindgren wrote:
> 
> > > > __iommu_probe_device from probe_iommu_group+0x2c/0x38
> > > > probe_iommu_group from bus_for_each_dev+0x74/0xbc
> > > > bus_for_each_dev from bus_iommu_probe+0x34/0x2e8
> > > > bus_iommu_probe from bus_set_iommu+0x80/0xc8
> > > > bus_set_iommu from omap_iommu_init+0x88/0xcc
> > > > omap_iommu_init from do_one_initcall+0x44/0x24c
> > > > 
> > > > Any ideas for a fix?
> > > > 
> > > > It would be good to fix this quickly so we don't end up with a broken
> > > > v5.18-rc1..
> > > > 
> > > > For reference, this is mainline commit 41bb23e70b50 ("iommu: Remove unused
> > > > argument in is_attach_deferred").
> > > 
> > > Are you confident in the bisection? I don't see how that commit could
> > > NULL deref..
> > 
> > Oops sorry you're right, the breaking commit is a different patch, it's
> > 3f6634d997db ("iommu: Use right way to retrieve iommu_ops") instead. I must
> > have picked the wrong commit while testing.
> 
> That makes alot more sense
>  
> > > Can you find the code that is the NULL deref?
> > 
> > I can debug a bit more tomorrow.
> 
> Looks like omap's omap_iommu_probe_device() is buggy, it returns 0 on
> error paths:
> 
> 	num_iommus = of_property_count_elems_of_size(dev->of_node, "iommus",
> 						     sizeof(phandle));
> 	if (num_iommus < 0)
> 		return 0;
> 
> This function needs to return an errno -ENODEV
> 
> Otherwise it causes a NULL dev->iommu->iommu_dev and dev_iommu_ops() will
> crash.
> 
> Jason

I tried to boot current mainline (787af64d05cd) on am57xx-evm and it
failed to boot. I made the change you suggested and it boots okay now:
https://gist.github.com/pdp7/918eefe03b5c5db3b5d28d819f6a27f6

thanks,
drew

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 4aab631ef517..d9cf2820c02e 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1661,7 +1661,7 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
        num_iommus = of_property_count_elems_of_size(dev->of_node, "iommus",
                                                     sizeof(phandle));
        if (num_iommus < 0)
-               return 0;
+               return ERR_PTR(-ENODEV);

        arch_data = kcalloc(num_iommus + 1, sizeof(*arch_data), GFP_KERNEL);
        if (!arch_data)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
