Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E02C433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 21:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2605A400AB;
	Tue, 31 May 2022 21:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pFtaFrysaiQ5; Tue, 31 May 2022 21:40:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0259940012;
	Tue, 31 May 2022 21:40:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA1E3C0032;
	Tue, 31 May 2022 21:40:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41340C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 21:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3522B400AB
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 21:40:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nj8K6lEV7Xcd for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 21:40:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A94A240012
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 21:40:35 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7DB346136E;
 Tue, 31 May 2022 21:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D5AC385A9;
 Tue, 31 May 2022 21:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654033233;
 bh=LP+1R1cUBOgcGWazwUCC1e4KihA9N205ZsMLBqH7mAQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JjPa68gOoTmBdt/Vqkgq304UPUbu/1zZFfLqGIJZqjxOTtpqN24LwMYPfBgEd8bHz
 rBlDFyt7h/BQSzR/h/vco5tmQU0IwXb9loR9AfYtb0AgMc/EsBTlKaMIirwYZ9ykaV
 mpHHZbLl0H6MjWdgm7AXfhL6h3Fy2QqKeZsjpgLGB32lviiy/d4TQmTZhgIUULQshM
 mSX9/VXZ30oXT0SM5edj6kvkioERX0KugjNIaD3LOcAMKojdXOn2gOFkpfLAr7kV8Z
 TzD1WFIPQPNhqjcKh4RfFMJXV0T/+MCKUhr61OyCFiNPW6hsR63jiigLMLdhXbh9ad
 9GDhCaFQ6Amug==
Date: Tue, 31 May 2022 15:40:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tony Battersby <tonyb@cybernetics.com>
Subject: Re: [PATCH 08/10] dmapool: cleanup dma_pool_destroy
Message-ID: <YpaLTsAjOOBQhTM9@kbusch-mbp.dhcp.thefacebook.com>
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
 <30fd23ae-7035-5ce3-5643-89a5956f1e79@cybernetics.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <30fd23ae-7035-5ce3-5643-89a5956f1e79@cybernetics.com>
Cc: Tony Lindgren <tony@atomide.com>, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 kernel-team@fb.com, Robin Murphy <robin.murphy@arm.com>
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

On Tue, May 31, 2022 at 02:22:21PM -0400, Tony Battersby wrote:
> +static void pool_free_page(struct dma_pool *pool,
> +			   struct dma_page *page,
> +			   bool destroying_pool)

'destroying_pool' is always true, so I don't think you need it.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
