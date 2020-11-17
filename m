Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0694C63697
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 23:24:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4621420A8B
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 23:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJ5yCFwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4621420A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DE45B203B2;
	Tue, 17 Nov 2020 23:24:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qAmOVtB-DYSf; Tue, 17 Nov 2020 23:24:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5E7AC20370;
	Tue, 17 Nov 2020 23:24:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C2E8C0800;
	Tue, 17 Nov 2020 23:24:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2785C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 23:24:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E089A8522E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 23:24:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vzlbBSUQo44H for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 23:24:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 87F0184CAA
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 23:24:38 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 406D720E65;
 Tue, 17 Nov 2020 23:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605655478;
 bh=ykBfaRygbX5Nw3if+S2/MztoXt+36i7yOP+dAhUU160=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hJ5yCFwnqDrHfIUSeFtOe7Y7I/hz5GzuTTM6WqQ5rxOKayYl3T/BMO7PwZnyLtWaO
 IKd/ZAKW9b0YoaJ2x5p4bPH15w8iWEDXwp3o9YSBdtzlDfEGEPy+9jX9j4riZ+LzTw
 QW72i6M5fUrcnzA9hihBFkQeIgc+ITMUvrol46Yk=
From: Will Deacon <will@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Liu Yi L <yi.l.liu@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux-foundation.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] iommu/vt-d: include conditionally on
 CONFIG_INTEL_IOMMU_SVM
Date: Tue, 17 Nov 2020 23:24:28 +0000
Message-Id: <160565219047.2773717.5820442945194882017.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201115205951.20698-1-lukas.bulwahn@gmail.com>
References: <20201115205951.20698-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Cc: kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>,
 Nathan Chancellor <natechancellor@gmail.com>, kernel-team@android.com
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

On Sun, 15 Nov 2020 21:59:51 +0100, Lukas Bulwahn wrote:
> Commit 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
> introduced intel_iommu_sva_invalidate() when CONFIG_INTEL_IOMMU_SVM.
> This function uses the dedicated static variable inv_type_granu_table
> and functions to_vtd_granularity() and to_vtd_size().
> 
> These parts are unused when !CONFIG_INTEL_IOMMU_SVM, and hence,
> make CC=clang W=1 warns with an -Wunused-function warning.
> 
> [...]

Applied to arm64 (for-next/iommu/vt-d), thanks!

[1/1] iommu/vt-d: include conditionally on CONFIG_INTEL_IOMMU_SVM
      https://git.kernel.org/arm64/c/68dd9d89eaf5

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
