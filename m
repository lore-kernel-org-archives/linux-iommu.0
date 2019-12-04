Return-Path: <SRS0=m57D=Z3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1595C2BD09
	for <iommu@archiver.kernel.org>; Thu,  5 Dec 2019 08:12:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7917F24653
	for <iommu@archiver.kernel.org>; Thu,  5 Dec 2019 08:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zWTADLrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7917F24653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2689187179;
	Thu,  5 Dec 2019 08:12:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ogWUJsIME_E; Thu,  5 Dec 2019 08:12:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8DE4686F85;
	Thu,  5 Dec 2019 08:12:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A9C5C18DD;
	Thu,  5 Dec 2019 08:12:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B98CFC077D
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 08:12:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A4B3487807
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 08:12:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KATYC3XMWre3 for <iommu@lists.linux-foundation.org>;
 Thu,  5 Dec 2019 08:12:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 170408757E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 08:12:32 +0000 (UTC)
Received: from localhost (unknown [193.47.165.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 22C3F206DB;
 Thu,  5 Dec 2019 08:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575533551;
 bh=ky657dThfKjbVCpIILkr6VubSyzgvjEQ7qr2LeYt6TY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zWTADLrRypv69ffcx5KeP3fiz0Z9hUuW2eeE9r2qjy2Q2u06vOT0cjeLRos5fN18Q
 sppeEg3dnSGvTz70LpCz/WxVXkTth+7KVp6rQAJ5RJFfexkW8hV+GIYj6xxZYbBu/t
 BZXTk0kbrZ1SYTl64LBHBAQbPQUI9zGCkth/Fk+8=
Date: Wed, 4 Dec 2019 16:17:25 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v4 7/8] linux/log2.h: Fix 64bit calculations in
 roundup/down_pow_two()
Message-ID: <20191204141725.GA4939@unreal>
References: <20191203114743.1294-1-nsaenzjulienne@suse.de>
 <20191203114743.1294-8-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191203114743.1294-8-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: linux-pci@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 "J. Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org,
 Edward Cree <ecree@solarflare.com>, linux-clk@vger.kernel.org,
 f.fainelli@gmail.com, Herbert Xu <herbert@gondor.apana.org.au>,
 Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, maz@kernel.org,
 phil@raspberrypi.org, Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Chen-Yu Tsai <wens@csie.org>,
 Chuck Lever <chuck.lever@oracle.com>, Martin Habets <mhabets@solarflare.com>,
 wahrenst@gmx.net, Tom Lendacky <thomas.lendacky@amd.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 Maxime Ripard <mripard@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 Anna Schumaker <anna.schumaker@netapp.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 linux-arm-kernel@lists.infradead.org, Mirko Lindner <mlindner@marvell.com>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>, mbrugger@suse.com,
 Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org,
 Yishai Hadas <yishaih@mellanox.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 "David S. Miller" <davem@davemloft.net>,
 Stephen Hemminger <stephen@networkplumber.org>, linux-rdma@vger.kernel.org,
 iommu@lists.linux-foundation.org, Moni Shoua <monis@mellanox.com>,
 Eric Biederman <ebiederm@xmission.com>, james.quinlan@broadcom.com,
 Thomas Graf <tgraf@suug.ch>, Robin Murphy <robin.murphy@arm.con>,
 David Woodhouse <dwmw2@infradead.org>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>
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

On Tue, Dec 03, 2019 at 12:47:40PM +0100, Nicolas Saenz Julienne wrote:
> Some users need to make sure their rounding function accepts and returns
> 64bit long variables regardless of the architecture. Sadly
> roundup/rounddown_pow_two() takes and returns unsigned longs. It turns
> out ilog2() already handles 32/64bit calculations properly, and being
> the building block to the round functions we can rework them as a
> wrapper around it.
>
> Suggested-by: Robin Murphy <robin.murphy@arm.con>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/clk/clk-divider.c                    |  8 ++--
>  drivers/clk/sunxi/clk-sunxi.c                |  2 +-
>  drivers/infiniband/hw/hfi1/chip.c            |  4 +-
>  drivers/infiniband/hw/hfi1/init.c            |  4 +-
>  drivers/infiniband/hw/mlx4/srq.c             |  2 +-
>  drivers/infiniband/hw/mthca/mthca_srq.c      |  2 +-
>  drivers/infiniband/sw/rxe/rxe_qp.c           |  4 +-


Thanks, for infiniband.
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
