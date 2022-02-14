Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042C0C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 13:27:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B867060F24;
	Mon, 14 Feb 2022 13:27:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KE-HZiiCUAia; Mon, 14 Feb 2022 13:27:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 94C47607F4;
	Mon, 14 Feb 2022 13:27:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7342CC001A;
	Mon, 14 Feb 2022 13:27:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B40D1C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AFE934015E
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oGkk9zrvETrU for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 13:27:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01F33400E0
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:27:51 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id D87802FB; Mon, 14 Feb 2022 14:27:49 +0100 (CET)
Date: Mon, 14 Feb 2022 14:27:48 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Move intel_iommu_ops to header file
Message-ID: <YgpY1IIBkFIxxjbm@8bytes.org>
References: <20220207141240.8253-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220207141240.8253-1-andriy.shevchenko@linux.intel.com>
Cc: Joerg Roedel <jroedel@suse.de>, David Woodhouse <dwmw2@infradead.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

On Mon, Feb 07, 2022 at 04:12:40PM +0200, Andy Shevchenko wrote:
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 69230fd695ea..1036c1900b5c 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -813,6 +813,8 @@ bool context_present(struct context_entry *context);
>  struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
>  					 u8 devfn, int alloc);
>  
> +extern const struct iommu_ops intel_iommu_ops;
> +

The intel_iommu_ops symbol is only used in drivers/iommu/intel, so I
would prefer a header in that directory. But I leave that up to Baolu to
decide.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
