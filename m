Return-Path: <SRS0=zmEc=24=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D7AC282DD
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 19:22:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B07F20656
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 19:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="pfn+eN2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B07F20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3C2E58778F;
	Tue,  7 Jan 2020 19:22:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PJsYa8b9PrgT; Tue,  7 Jan 2020 19:22:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C31528763E;
	Tue,  7 Jan 2020 19:22:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2207C1796;
	Tue,  7 Jan 2020 19:22:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E9D2C0881
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 19:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9AA80876F2
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 19:22:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uGoepIaf3gVq for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jan 2020 19:22:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com
 [209.85.166.201])
 by hemlock.osuosl.org (Postfix) with ESMTPS id ECDB88763E
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 19:22:18 +0000 (UTC)
Received: by mail-il1-f201.google.com with SMTP id l13so370311ils.1
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jan 2020 11:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=sJ1qiuOaFddjvV3EMxT41XqJKgGLuuRJHE45bF9B8p8=;
 b=pfn+eN2a9Rhsgq25lRpdSPWFyexvrpgZxlkFxEffR4y2X33KinzvvzUEOliF9ZQXOa
 E9Zi2ic+Cfqxvy8R8Xp2NJI8gMfjf1W+jZbZoKcTdsYB7iiFZBP2EaBMbgYS5DqpzwbV
 oLHxtWvAaWs+zZMFzsUfQoncykLzPOePuvMA5QJ1U0XCUYcNWB/ca9CsJzVFIVBu3BI2
 D2lQNHBi196qYBwh3pHdylg1lq6hQ25y/ppShxK+ARBePcb2uc6tcQVtn663/Xe38XmE
 obk68R+QC9jVqcBuOFHZHkcFnjomB79L+YnaU0rqjx200WEp8/+dsOA18NDtaeluiLFL
 ds7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=sJ1qiuOaFddjvV3EMxT41XqJKgGLuuRJHE45bF9B8p8=;
 b=nuUSrOiJ+yNn87rJz7ViYKoYrgVxBdNl4NOlBbnzk2MFNWs7MAgY8r7HKEUuMNgxwY
 jU7BS0KAhRakM9i2B5+PNPGPga3RrhwUb4S5tp54nRvd3GL9Ej78V1cMbRodSvmqZ+E8
 2yZBKpaP62DSw3eO2H4ujjPAFRilrLPTrOLaiUXslfO/nvGh7VvsRVf4sPDVuvmCNMSs
 kiKUQFcT4qN68ptVZDaURwaK/ftkq0WkG55eLsnvoaqXFjOAE0l5hiZcwLrDNsi4WPLw
 XUFU+f+X1oZoMaN6Y5LAvIBSfF/S9YWgp1tlkMDp4oNxnX+JW7ceCtL/lJ4wTZGB+3ql
 anwQ==
X-Gm-Message-State: APjAAAWdhkXMKezMZ27O4TTL28Qpa2eaYqLGUqx9owIphD50c9WfYXgb
 K1/36+Be5NMtgFXayRVyLBmNFHsE
X-Google-Smtp-Source: APXvYqwMv03rImdYnn2HT29d0/88N85XQwfq+7kYtU+0TlQRwOEQO7ZfsOWZXNizMiJDGtrzHo5xlgQz
X-Received: by 2002:a63:f403:: with SMTP id g3mr1104543pgi.62.1578424581543;
 Tue, 07 Jan 2020 11:16:21 -0800 (PST)
Date: Tue,  7 Jan 2020 14:16:08 -0500
Message-Id: <20200107191610.178185-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 0/2] iommu/vt-d bad RMRR workarounds
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, 
 "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, 
 Yian Chen <yian.chen@intel.com>, Sohil Mehta <sohil.mehta@intel.com>
Cc: iommu@lists.linux-foundation.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
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
From: Barret Rhoden via iommu <iommu@lists.linux-foundation.org>
Reply-To: Barret Rhoden <brho@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Commit f036c7fa0ab6 ("iommu/vt-d: Check VT-d RMRR region in BIOS is
reported as reserved") caused a machine to fail to boot for me, but only
after a kexec.

Buggy firmware provided an RMRR entry with base and end both == 0.  That
is an invalid RMRR format, and only happens to pass the RMRR sanity
check.  After a kexec, that entry fails the RMRR sanity check, due to a
slight change in the first e820 mapping.  See the v1 link for details.

v1->v2:
v1: https://lore.kernel.org/lkml/20191211194606.87940-1-brho@google.com/
- Added the TAINT_FIRMWARE_WORKAROUND
- Dropped the commit that treated missing e820 regions as "RMRR OK"


Barret Rhoden (2):
  iommu/vt-d: skip RMRR entries that fail the sanity check
  iommu/vt-d: skip invalid RMRR entries

 drivers/iommu/intel-iommu.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

-- 
2.24.1.735.g03f4e72817-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
