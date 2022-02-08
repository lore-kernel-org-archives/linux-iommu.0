Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6505BC433F5
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 16:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07EBB81366;
	Tue,  8 Feb 2022 16:22:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pyRbDo5GxTL6; Tue,  8 Feb 2022 16:22:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D667F8250B;
	Tue,  8 Feb 2022 16:22:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8202C001A;
	Tue,  8 Feb 2022 16:22:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED4BBC000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 16:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C97AF405C2
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 16:22:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lKy-m-xxGyqm for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 16:22:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 66D9E405C1
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 16:22:06 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id AD189B81916;
 Tue,  8 Feb 2022 16:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F12C004E1;
 Tue,  8 Feb 2022 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644337322;
 bh=UaVxOWmsbivSkU9vIw/GYJbDCYQehGoFF7tme6i5Rgw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V9Q0TqQSdjW4iYnYCrU2P4W7USzsBBA/Ckk5QjBhmR1VitF63RGskEr/3mzgYnuuj
 qIgjoH+EVmb/4V3v6GpxKPcPmvoaxIALpXP1kKpDKkG9jVps2momdSLPeMz30DOJZY
 0utjHzP133Ov84Z9EZUuZjW1zLOzf7Q3LGTHQZvxXQTm1WSZ1a6EvJl2FS0rCWi3tQ
 7cGVMz8vbvMv7173RfD+zf0bI6YrSvcmwDNfBWoRuLFYy7TmqdwM3W6bsrENAp7VlU
 PiXhNaFzBSwKS53bHCu+fSxEgcCsJ1Ib8Wq28M8D4hIoazgXSBo+SP9jdhMUdgF7xC
 mbXo2FXH7L7fQ==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Avoid open coded arithmetic in
 memory allocation
Date: Tue,  8 Feb 2022 16:21:51 +0000
Message-Id: <164433570600.932619.3193725963159387011.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <3f7b9b202c6b6f5edc234ab7af5f208fbf8bc944.1644274051.git.christophe.jaillet@wanadoo.fr>
References: <3f7b9b202c6b6f5edc234ab7af5f208fbf8bc944.1644274051.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kernel-team@android.com,
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

On Mon, 7 Feb 2022 23:50:48 +0100, Christophe JAILLET wrote:
> kmalloc_array()/kcalloc() should be used to avoid potential overflow when
> a multiplication is needed to compute the size of the requested memory.
> 
> So turn a devm_kzalloc()+explicit size computation into an equivalent
> devm_kcalloc().
> 
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] iommu/arm-smmu-v3: Avoid open coded arithmetic in memory allocation
      https://git.kernel.org/will/c/98b64741d611
[2/2] iommu/arm-smmu-v3: Simplify memory allocation
      https://git.kernel.org/will/c/fcdeb8c34043

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
