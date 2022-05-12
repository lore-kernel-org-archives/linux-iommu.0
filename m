Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18605C433F5
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 23:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF1B660AEF;
	Thu, 12 May 2022 23:28:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PHmUZRhQI5GS; Thu, 12 May 2022 23:28:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A4EA660B4B;
	Thu, 12 May 2022 23:28:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A0ACC0039;
	Thu, 12 May 2022 23:28:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A36FAC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 23:28:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7DF3460B4B
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 23:28:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FywdAAPfWgyd for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 23:28:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 943E060AEF
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 23:28:17 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id d19so11690718lfj.4
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 16:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cpfA97nDV4SiW2VW+i5FVHsx+t3FCKmVLBmZii44FdE=;
 b=kqBM6iNykm6TWh3OPtN3KNUqyw5Azl0zC+bz2Ms66O6sKoN0kw9HPHK7MEl25ZBQ9L
 L8CRer3B1+tD6pZKaure8nj8d0GueAO/QsDzbrjXRLcTmLmZTA1q+V0aLQk4KJVG5V1J
 VfF3Pir7FBeGVLVVt8JElNUM90239qH+if7wVSg3Gm9GlDnI1bNPHPIw6cDrL7dFVjqd
 9apTJ1uVsRpixTJaPz8daNI4kRjjhvNTPUuANFkQ4jVRfrKNwdF+Dp3mvgugQDaovRW+
 Hge5USiWx0kOowRq0KnkLp2ADdbQo8qW9kMAg2OtQJUw1oSA5LiBIhlft1FDabsbL6Ce
 L78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cpfA97nDV4SiW2VW+i5FVHsx+t3FCKmVLBmZii44FdE=;
 b=z3TBF8nKgkZp/k/BldhkgOQv6410UED806EEql9TO1i7iyFG4V2ksCjh8+I8AvL/qj
 qWRVyWu+2111bzcGAK202/sdasSV3/iLCZya1WLpJGoIVZ9kKdcKaimA/w+oWLdJ40Pj
 cVpBP+EYSnP83vJTpDTM1b7VWXXQqRD9zAyQNnTMAIVHyxMvWCPP8zuAJYVJ3/frEBDs
 7I2SFBDNEkVbMl2wfSIhEksu0Sx5HlTto4H7iQiY17Z0hGHgjAOFb746x/+bUqcOwnnu
 xywR5xcXd9on4djEQizAH8SAC7TX3K6EvYKVK/36/hBz1c+jFQrJLGegeAWj3NmLRV/o
 Cu4Q==
X-Gm-Message-State: AOAM530fnnpgJ2Yy0xrsNbrxUMpCLspny7xOybvuZOSYZJNly3Em464w
 7kDK58vw/m8zy7crU14STRw=
X-Google-Smtp-Source: ABdhPJwmqcj7YqvF8NValKykWtMU500lUt5tUdBLW712+Zaujy4N8cbSQS3/q4FBv9Z1peRo/Q5rXw==
X-Received: by 2002:a19:4f55:0:b0:472:1f2b:6d12 with SMTP id
 a21-20020a194f55000000b004721f2b6d12mr1434763lfk.388.1652398095274; 
 Thu, 12 May 2022 16:28:15 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
 by smtp.gmail.com with ESMTPSA id
 r18-20020ac24d12000000b0047255d2111csm131806lfi.75.2022.05.12.16.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 May 2022 16:28:14 -0700 (PDT)
Date: Fri, 13 May 2022 02:28:11 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 01/26] dma-direct: take dma-ranges/offsets into
 account in resource mapping
Message-ID: <20220512232811.6epllnb3ivb7vegq@mobilestation>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
 <20220503225104.12108-2-Sergey.Semin@baikalelectronics.ru>
 <20220509061552.GA17190@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220509061552.GA17190@lst.de>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
 linux-pci@vger.kernel.org, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 Serge Semin <Sergey.Semin@baikalelectronics.ru>, dmaengine@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, Vladimir Murzin <vladimir.murzin@arm.com>,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, May 09, 2022 at 08:15:52AM +0200, Christoph Hellwig wrote:
> So I think the big problem pointed out by Robin is that existing DTs
> might not take this into account. 

I'd say that the biggest problem isn't in the DT part but in the
drivers using the dma_map_resource() method since they don't expect
the non-uniform DMA-direct mapping can be available.

> So I think we need to do a little
> research and at least Cc all maintainers and lists for relevant in-tree
> DTs for drivers that use dma_map_resource to discuss this.

Right. I'll send the next patchset revision out with all possibly
interested maintainers and lists in Cc of this patch.

-Sergey

> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
