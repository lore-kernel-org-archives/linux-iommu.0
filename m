Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EEBC433EF
	for <iommu@archiver.kernel.org>; Thu, 31 Mar 2022 14:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 350CD41B88;
	Thu, 31 Mar 2022 14:55:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EPBUuk5YUGfq; Thu, 31 Mar 2022 14:55:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AFB894196A;
	Thu, 31 Mar 2022 14:55:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E97BC001D;
	Thu, 31 Mar 2022 14:55:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7647CC0012
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 14:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6EF436131B
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 14:55:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z4RxoYAy3xqS for <iommu@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 14:55:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A985C61315
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 14:55:46 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id v13so19920139qkv.3
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=N7LizCHnjlNbTA7L5oo06xRIVouidWsWp/Muu8IQBaI=;
 b=bbuvSgDp27kFRs5kUzXlzygSwI7UT/O0wqkGn5Nc8LhaA2AECwG/JssJQabxdos/4d
 HaWXO9broK+ktqf3/iD4ocQd1QR805aj1GyXgmoXlryjP/ctlK9v99kDJrInxmNmzaOy
 RgiGwf6lZ69twj0tu2VynkLbE11gXaL07HNMRwrIBJLufXB95vgs7J7fjuOMt2zz7xe9
 vktnW0aPLuLc1X9bXkZSHjtzoifZgPG9N49S+ptKRAUq12u3CwtKK/YoJc/UlVP7kDZ+
 VQd1D95r4SCX8k7rqsNe2VAxmOCqsRZk/jr7YQ3wQ+Zo60KAn81MyYqbHvQ8nQtCXU0s
 pQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=N7LizCHnjlNbTA7L5oo06xRIVouidWsWp/Muu8IQBaI=;
 b=t/g3SguQ1p18er7EJLmkPIhxgDgXbB8jFklO8b44K80TQeV9TUF0Kt+8bXlpheDR9f
 g8Ti/9aTWbQYKbOieGvXDVSEY7NKcHuhkIhKZgteQODSibOzJqxHftVUyzsJMkfq2dRX
 B2279j4jtqGyaGvBCmqqmkgvWYvOX0owLGoKLF19WNwKAIJ9z3WieyYm500J1b83LsMO
 rMTKCfRwQT/zIVKOo0x9Car61/mvWqjZXuzQTzrgvMPZswwH2yCXlWzkj4K/hX++f34a
 Bd4wB1aUKzl3hYE/OFWcNxqQOQcvgnQn4XxsSWzTGTZ2YBIIiIu1BA7yVFcsxahVGapf
 NgEg==
X-Gm-Message-State: AOAM5319u1amkVOZv/a2N3xWBfrTaUbBdphP2JGRuvmDdHiVCJcIBd3W
 u85Xq/sBvEPTHExz91tYHnMH5w==
X-Google-Smtp-Source: ABdhPJy5034ceSRr34bKxO0lTD6+//Dl0Iw4VbZPHrTjnUkOt1ayzWxy1rlNeo/zszGJibqXu6Y5xA==
X-Received: by 2002:a05:620a:22cf:b0:67e:e43:239d with SMTP id
 o15-20020a05620a22cf00b0067e0e43239dmr3636919qki.299.1648738545555; 
 Thu, 31 Mar 2022 07:55:45 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129]) by smtp.gmail.com with ESMTPSA id
 h8-20020ac87d48000000b002e1c6faae9csm19564317qtb.28.2022.03.31.07.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Mar 2022 07:55:44 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nZwD9-009v5U-0t; Thu, 31 Mar 2022 11:55:43 -0300
Date: Thu, 31 Mar 2022 11:55:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] iommu/omap: Fix regression in probe for NULL pointer
 dereference
Message-ID: <20220331145543.GN64706@ziepe.ca>
References: <20220331062301.24269-1-tony@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220331062301.24269-1-tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Mar 31, 2022 at 09:23:01AM +0300, Tony Lindgren wrote:
> Commit 3f6634d997db ("iommu: Use right way to retrieve iommu_ops") started
> triggering a NULL pointer dereference for some omap variants:
> 
> __iommu_probe_device from probe_iommu_group+0x2c/0x38
> probe_iommu_group from bus_for_each_dev+0x74/0xbc
> bus_for_each_dev from bus_iommu_probe+0x34/0x2e8
> bus_iommu_probe from bus_set_iommu+0x80/0xc8
> bus_set_iommu from omap_iommu_init+0x88/0xcc
> omap_iommu_init from do_one_initcall+0x44/0x24
> 
> This is caused by omap iommu probe returning 0 instead of ERR_PTR(-ENODEV)
> as noted by Jason Gunthorpe <jgg@ziepe.ca>.
> 
> Looks like the regression already happened with an earlier commit
> 6785eb9105e3 ("iommu/omap: Convert to probe/release_device() call-backs")
> that changed the function return type and missed converting one place.
> 
> Cc: Drew Fustini <dfustini@baylibre.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Suman Anna <s-anna@ti.com>
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Fixes: 6785eb9105e3 ("iommu/omap: Convert to probe/release_device() call-backs")
> Fixes: 3f6634d997db ("iommu: Use right way to retrieve iommu_ops")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/iommu/omap-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
