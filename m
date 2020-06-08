Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BFFC433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 21:04:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3D72068D
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 21:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NDE9XGnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3D72068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E8DE587B25;
	Mon,  8 Jun 2020 21:04:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7vIx69Be8IFE; Mon,  8 Jun 2020 21:04:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6275883CBF;
	Mon,  8 Jun 2020 21:04:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5752DC07FF;
	Mon,  8 Jun 2020 21:04:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 184CCC016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 21:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0FB4685FE6
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 21:04:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ihaZzmRbx-FW for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 21:04:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 850F285FA2
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 21:04:18 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id r10so9279712pgv.8
 for <iommu@lists.linux-foundation.org>; Mon, 08 Jun 2020 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=eSnM3Wp5cYoCyZSe8AmKJn6Xd5E1PvqbOrfDYBEtlVE=;
 b=NDE9XGnGI9GYA5H7RMhAelnFzVf+AvRcTPveRM4qk/20TZGUzk7Nl5BFlxeKNEqqk1
 Cl1giFXgHlqX15N7iQucJJcOoPHw6fZ6ffQdKr0X2W7LKnaUuGDih/MGil6dsPc32JUA
 DBqX50+ae1zSTFqe7EhMBHlw2YclobMchWAJUAC2Mv5dF9lx25Vg/7VhyNy/xEEldbm2
 IrHs7R46EfOtXDCmt6m4EYGEQIzbiFgPU8dQ5bTTeYADq9Eh2A/mVZiBurdYo7gb6YMz
 RWF57ZajeU3jjvemUOpsXll7rfy2utMv2pNLaRFQ8W5zk9lFK1MSWKvKDbuRQ1clzKgD
 jJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=eSnM3Wp5cYoCyZSe8AmKJn6Xd5E1PvqbOrfDYBEtlVE=;
 b=qAiAvjlnbgFkjX6821F9OvcFckbIMvuwNJXyVSKhX0/yiLdCOnAdrA1PbAHmbIUZHk
 5hxXQj5hDvkhktJG0yc0LzJ0BvKrPHdepdiL3ViOv4aYPUhPjqQWydjeaMt5LJ3WWXX9
 n/ZjxyzOzaRK26Kn4oR8aonUitmFoH6Do4i5KxnzFWny/JBLNcW6spMHxDBAFLNGWN1W
 81jq51p/0N6nFxe5WSCXT/eRwyFj922D+GSsTawTdKHNYj5+dqvmDkyp3qCzUuOBunrq
 wNSqANbLZbzjEZfCDhmvctHq+6yjIlH3u0fhceZ2zJZ7yP9c+vA5SMRfykQLrypHOJ8r
 6qJQ==
X-Gm-Message-State: AOAM5301WbwvQ7fS5R95sJTjDvz8g+B6qv/GwcpZZwrtALTsBYFrp7MO
 D5M5tXeV+Tts3Lmvnsg/aE3m5w==
X-Google-Smtp-Source: ABdhPJzonYIXqxiYM91Tp1oE684RePKN0QCjQ24SQclrVHvlV0Njla7yv6NdSMJO4WJRGV1vzs0mDQ==
X-Received: by 2002:a65:6107:: with SMTP id z7mr21088332pgu.341.1591650257907; 
 Mon, 08 Jun 2020 14:04:17 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id z8sm360368pjr.41.2020.06.08.14.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 14:04:17 -0700 (PDT)
Date: Mon, 8 Jun 2020 14:04:16 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
In-Reply-To: <20200608132217.29945-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2006081403560.71460@chino.kir.corp.google.com>
References: <20200608132217.29945-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, 8 Jun 2020, Geert Uytterhoeven wrote:

> On systems with at least 32 MiB, but less than 32 GiB of RAM, the DMA
> memory pools are much larger than intended (e.g. 2 MiB instead of 128
> KiB on a 256 MiB system).
> 
> Fix this by correcting the calculation of the number of GiBs of RAM in
> the system.  Invert the order of the min/max operations, to keep on
> calculating in pages until the last step, which aids readability.
> 
> Fixes: 1d659236fb43c4d2 ("dma-pool: scale the default DMA coherent pool size with memory capacity")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

This works as well and is much more readable.  Thanks Geert!

Acked-by: David Rientjes <rientjes@google.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
