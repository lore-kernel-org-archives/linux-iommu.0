Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5DFC433DF
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 14:45:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE121207D8
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 14:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE121207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 67ADB24B78;
	Wed, 27 May 2020 14:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dsTVTkAWSnFM; Wed, 27 May 2020 14:45:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id ADD2C204DD;
	Wed, 27 May 2020 14:45:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 931BAC0881;
	Wed, 27 May 2020 14:45:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B55BC016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 14:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6A40C8484B
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 14:45:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4KwYK0ZeqBQi for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 14:45:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CC93C84812
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 14:45:25 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 985AE3C3; Wed, 27 May 2020 16:45:22 +0200 (CEST)
Date: Wed, 27 May 2020 16:45:21 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/2] ia64: Hide the archdata.iommu field behind generic
 IOMMU_API
Message-ID: <20200527144521.GL5221@8bytes.org>
References: <20200518120855.27822-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200518120855.27822-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Mon, May 18, 2020 at 02:08:54PM +0200, Krzysztof Kozlowski wrote:
> There is a generic, kernel wide configuration symbol for enabling the
> IOMMU specific bits: CONFIG_IOMMU_API.  Implementations (including
> INTEL_IOMMU driver) select it so use it here as well.
> 
> This makes the conditional archdata.iommu field consistent with other
> platforms and also fixes any compile test builds of other IOMMU drivers,
> when INTEL_IOMMU is not selected).
> 
> For the case when INTEL_IOMMU and COMPILE_TEST are not selected, this
> should create functionally equivalent code/choice.  With COMPILE_TEST
> this field could appear if other IOMMU drivers are chosen but
> INTEL_IOMMU not.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> See:
> https://lore.kernel.org/lkml/202005181412.frC4juFy%25lkp@intel.com/
> ---
>  arch/ia64/include/asm/device.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied both to iommu/fixes.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
