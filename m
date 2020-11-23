Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B918C2D0E4
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 15:47:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13ADB20B1F
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 15:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqvbywYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13ADB20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6B76A858B8;
	Mon, 23 Nov 2020 15:47:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QkQ7C_e-Exn0; Mon, 23 Nov 2020 15:47:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4B026857BE;
	Mon, 23 Nov 2020 15:47:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F7C7C0891;
	Mon, 23 Nov 2020 15:47:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE7A8C0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 15:47:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A84F220472
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 15:47:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qUxZrICv6tHP for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 15:47:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 6977D20459
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 15:47:11 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B142320B1F;
 Mon, 23 Nov 2020 15:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606146431;
 bh=liw0vFpQnqcjI3i4phcXrlgXpuoa4Cd0IXbxBoIJ3xE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aqvbywYz7pfnV73A8wIB4GNBS+jqx2H8kz1q3qyS8CekS8bvtszw9/CJy8b8rohxU
 v+x/Wx0bv19xr0FVF/CvxJH4R74RTOMxR6jj4ctN662KjLLkhS73tno/olheOZ+04w
 b3YQCBsGvdokA8/oR2+l2pcrA8gahGVWlaFDh6Kg=
From: Will Deacon <will@kernel.org>
To: lkml <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 1/2] arm-smmu-qcom: Ensure the qcom_scm driver has
 finished probing
Date: Mon, 23 Nov 2020 15:46:59 +0000
Message-Id: <160614327473.875458.14207739459234972190.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201112220520.48159-1-john.stultz@linaro.org>
References: <20201112220520.48159-1-john.stultz@linaro.org>
MIME-Version: 1.0
Cc: Maulik Shah <mkshah@codeaurora.org>, Marc Zyngier <maz@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, Robin Murphy <robin.murphy@arm.com>,
 Lina Iyer <ilina@codeaurora.org>, iommu@lists.linux-foundation.org,
 Andy Gross <agross@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 kernel-team@android.com
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

On Thu, 12 Nov 2020 22:05:19 +0000, John Stultz wrote:
> Robin Murphy pointed out that if the arm-smmu driver probes before
> the qcom_scm driver, we may call qcom_scm_qsmmu500_wait_safe_toggle()
> before the __scm is initialized.
> 
> Now, getting this to happen is a bit contrived, as in my efforts it
> required enabling asynchronous probing for both drivers, moving the
> firmware dts node to the end of the dtsi file, as well as forcing a
> long delay in the qcom_scm_probe function.
> 
> [...]

Applied only the first patch to arm64 (for-next/iommu/fixes), thanks!

[1/2] arm-smmu-qcom: Ensure the qcom_scm driver has finished probing
      https://git.kernel.org/arm64/c/72b55c96f3a5

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
