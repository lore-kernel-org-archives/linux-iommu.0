Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408A8C433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 08:05:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFA7F83F90;
	Fri, 17 Dec 2021 08:05:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hxnGWdrZEQ_D; Fri, 17 Dec 2021 08:05:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B511983E94;
	Fri, 17 Dec 2021 08:05:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 885B4C002F;
	Fri, 17 Dec 2021 08:05:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DFB0C0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:05:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C7CF83F8D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:05:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YUW0ZEEAstnY for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 08:05:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 041C183E94
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:05:35 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id D441136D; Fri, 17 Dec 2021 09:05:33 +0100 (CET)
Date: Fri, 17 Dec 2021 09:05:32 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] iommu: Use correctly sized arguments for bit field
Message-ID: <YbxEzHVdvzCiProP@8bytes.org>
References: <20211215232432.2069605-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211215232432.2069605-1-keescook@chromium.org>
Cc: Yury Norov <yury.norov@gmail.com>, David Woodhouse <dwmw2@infradead.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-hardening@vger.kernel.org, Will Deacon <will@kernel.org>
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

On Wed, Dec 15, 2021 at 03:24:32PM -0800, Kees Cook wrote:
> The find.h APIs are designed to be used only on unsigned long arguments.
> This can technically result in a over-read, but it is harmless in this
> case. Regardless, fix it to avoid the warning seen under -Warray-bounds,
> which we'd like to enable globally:
> 
> In file included from ./include/linux/bitmap.h:9,
>                  from drivers/iommu/intel/iommu.c:17:
> drivers/iommu/intel/iommu.c: In function 'domain_context_mapping_one':
> ./include/linux/find.h:119:37: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'int[1]' [-Warray-bounds]
>   119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
>       |                                     ^~~~~
> drivers/iommu/intel/iommu.c:2115:18: note: while referencing 'max_pde'
>  2115 |         int pds, max_pde;
>       |                  ^~~~~~~
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/iommu/intel/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
