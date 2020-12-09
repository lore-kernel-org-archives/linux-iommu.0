Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F012C433FE
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 14:12:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C5023B53
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 14:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C5023B53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2F3B52076B;
	Wed,  9 Dec 2020 14:12:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p-ncgWMThzBL; Wed,  9 Dec 2020 14:12:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 500A120460;
	Wed,  9 Dec 2020 14:12:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BEA0C0893;
	Wed,  9 Dec 2020 14:12:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D688C013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 14:12:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5D002871AA
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 14:12:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id me34dJWLlsyo for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 14:12:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C58F18718B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 14:12:43 +0000 (UTC)
Date: Wed, 9 Dec 2020 14:12:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607523163;
 bh=FAI/30k4kJrlpskHB/PfBKqSeCQ0aih1cBOMGE821UE=;
 h=From:To:Cc:Subject:From;
 b=Jwed7xDpuN9x4w57KLlIz4Z0VcspD08U6jWr2hmBYNIkFB47HgyWWxZmIkIL3BZo1
 5/l0U7I2Uia4pTcNoHfpvpgtzQM+1srtYEurcc5MKnXo+eCF9SrMEpsP0gGgvG1xrp
 WoKLv0sQlBjo0kmISb+FTRiIdo3xmVwt7Fwv8XcM3I5v2LZHbEVqmsnMC3y8V//q6P
 dTXiD/tQFBxu3aM/35XS20idj2VJHXB0yrmZu8oVeOF/iwXdLB8y57HtRqeQ02JZVa
 NtJ5Ub0vf4iCslV73T2F2oP+ouuM1RVj2J1lE7Oqjw0T/7AP7j/xDeNtobmjPQ0/9Z
 tPdlf1ZK/xYEg==
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Subject: [GIT PULL] IOMMU fix for 5.10 (-final)
Message-ID: <20201209141237.GA8092@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

Hi Linus,

Please pull this one-liner AMD IOMMU fix for 5.10. It's actually a fix
for a fix, where the size of the interrupt remapping table was increased
but a related constant for the size of the interrupt table was forgotten.

Cheers,

Will

--->8

The following changes since commit d76b42e92780c3587c1a998a3a943b501c137553:

  iommu/vt-d: Don't read VCCAP register unless it exists (2020-11-26 14:50:24 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes

for you to fetch changes up to 4165bf015ba9454f45beaad621d16c516d5c5afe:

  iommu/amd: Set DTE[IntTabLen] to represent 512 IRTEs (2020-12-07 11:00:24 +0000)

----------------------------------------------------------------
iommu fix for 5.10

- Fix interrupt table length definition for AMD IOMMU

----------------------------------------------------------------
Suravee Suthikulpanit (1):
      iommu/amd: Set DTE[IntTabLen] to represent 512 IRTEs

 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
