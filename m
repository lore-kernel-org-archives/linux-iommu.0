Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8546C433F5
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 16:11:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 977294046D;
	Tue,  4 Jan 2022 16:11:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3FkSt92k8h-J; Tue,  4 Jan 2022 16:10:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5730B40118;
	Tue,  4 Jan 2022 16:10:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EBA9C002F;
	Tue,  4 Jan 2022 16:10:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 735CBC001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 16:10:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5218B40118
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 16:10:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tFCr7rEzEMOX for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 16:10:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A1154046D
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 16:10:55 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id w20so68158106wra.9
 for <iommu@lists.linux-foundation.org>; Tue, 04 Jan 2022 08:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dLfIM00O/Ipr0crkhKZyqpI5imxvGGmn0KKsbMAqWes=;
 b=KkE3dLVLMPaqZVPsu5iREhY5tpfvuR+rbZaGOP4ZmSy5v1n9UswGiPFDyEk3A+eMHq
 eXznXllF8erEPxSsu0FPbNIfBP3FP02HNxTVNsjdTkNT9bhOL4D6oFFs8NCpwa8fct5s
 GRafk6+Hzeisf81PgPbYZASNCUZKGHoFvbb8JW9tOQHwxE39QlPQTK35EkLtyar70nMY
 FSqWMKfZzx3nlDZp6uSBfjGrkBeYE+qFVhqfyHSuba0Eg9u6qIroQLjR7pYObftXB1I5
 kRaH3IDe/BDTIJ9UrakNtJBfE9fU5c7aXmDPG5PAZwQaNsQuBF7zVIjW/LDVf4nzhL55
 8E8A==
X-Gm-Message-State: AOAM533iawkTfvzF3xVURyE7S8mb0C0RTK29ztETAstnY0ZOhtrq0qMR
 IRz2nOx0WMGtFu7rrKDasPE=
X-Google-Smtp-Source: ABdhPJxAPRVEKFC6iEdVbnzKtmgbxeyx+Wsc6yqjkxA1VCzgkvg7TVaN0aQ8+ZqqWU4v4ZEUkUnhNA==
X-Received: by 2002:a5d:420d:: with SMTP id n13mr38257101wrq.498.1641312653549; 
 Tue, 04 Jan 2022 08:10:53 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id h204sm38564690wmh.33.2022.01.04.08.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jan 2022 08:10:53 -0800 (PST)
Date: Tue, 4 Jan 2022 16:10:51 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Swiotlb: Add CONFIG_HAS_IOMEM check around memremap() in
 the swiotlb_mem_remap()
Message-ID: <20220104161051.yyvxjfb7ghg67ryr@liuwe-devbox-debian-v2>
References: <20211231165640.1245751-1-ltykernel@gmail.com>
 <YdKrxgnpT0Dc0t2T@infradead.org>
 <20220104145155.hm7j5byhddn4zhb2@liuwe-devbox-debian-v2>
 <20220104150307.GA23792@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220104150307.GA23792@lst.de>
Cc: parri.andrea@gmail.com, michael.h.kelley@microsoft.com,
 Wei Liu <wei.liu@kernel.org>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 kernel test robot <lkp@intel.com>, konrad.wilk@oracle.com,
 linux-kernel@vger.kernel.org, Tianyu Lan <ltykernel@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 thomas.lendacky@amd.com, brijesh.singh@amd.com, vkuznets@redhat.com,
 kys@microsoft.com, robin.murphy@arm.com
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

On Tue, Jan 04, 2022 at 04:03:07PM +0100, Christoph Hellwig wrote:
> On Tue, Jan 04, 2022 at 02:51:55PM +0000, Wei Liu wrote:
> > > Please stub out all of swiotlb_mem_remap instead of the ifdef inside the
> > > function.
> > 
> > Does this look okay to you?
> 
> Yes, thanks!

Thanks for confirming!

I will turn this into an ack and apply the diff to hyperv-next.

Wei.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
