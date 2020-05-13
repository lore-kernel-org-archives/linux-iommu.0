Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CD4CA90AF
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 08:40:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A310F20740
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 08:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A310F20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7A30A8821D;
	Wed, 13 May 2020 08:40:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cmJgrmBX6eW7; Wed, 13 May 2020 08:40:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D9EDD881C4;
	Wed, 13 May 2020 08:40:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEAD6C0178;
	Wed, 13 May 2020 08:40:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D80CAC016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 08:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BBF00204D7
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 08:40:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2RtmECMHyhZi for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 08:40:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id E6AD8204CF
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 08:40:33 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 81C26379; Wed, 13 May 2020 10:40:31 +0200 (CEST)
Date: Wed, 13 May 2020 10:40:30 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH -next] iommu/amd: fix variable "iommu" set but not used
Message-ID: <20200513084030.GB9820@8bytes.org>
References: <20200509015645.3236-1-cai@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200509015645.3236-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On Fri, May 08, 2020 at 09:56:45PM -0400, Qian Cai wrote:
> The commit dce8d6964ebd ("iommu/amd: Convert to probe/release_device()
> call-backs") introduced an unused variable,
> 
> drivers/iommu/amd_iommu.c: In function 'amd_iommu_uninit_device':
> drivers/iommu/amd_iommu.c:422:20: warning: variable 'iommu' set but not
> used [-Wunused-but-set-variable]
>   struct amd_iommu *iommu;
>                     ^~~~~
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/iommu/amd_iommu.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied, thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
