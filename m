Return-Path: <SRS0=NWqd=2B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1994C43603
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 21:37:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C11320409
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 21:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ebC2n5Jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C11320409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 27D51233B0;
	Wed, 11 Dec 2019 21:37:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3SAgnwZYLi29; Wed, 11 Dec 2019 21:37:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C82EC20381;
	Wed, 11 Dec 2019 21:37:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF96BC1796;
	Wed, 11 Dec 2019 21:37:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66404C0881
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 21:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 626E786D88
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 21:37:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RsTUjyBKgkB4 for <iommu@lists.linux-foundation.org>;
 Wed, 11 Dec 2019 21:37:10 +0000 (UTC)
X-Greylist: delayed 01:44:53 by SQLgrey-1.7.6
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com
 [209.85.166.201])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C0D9686881
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 21:37:10 +0000 (UTC)
Received: by mail-il1-f201.google.com with SMTP id t13so18249765ilk.16
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 13:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=xTTAjJf21FVVJPXeayVLtKF3IlyrepWpUnexj9VEhJs=;
 b=ebC2n5JyjeehjclWkWSRXyOR7TPsVZVOBkzoZavzbWVbuvVk6Hp8HYxp2OOqkmC+ez
 aOFsny+7gZ9si0XiJvk+i/xDtoxTzZqUTaohUpkO1ajuQ2CethlGM8XFiRwKl+fSOuEd
 T+5DW/4a72q/nViyS8t61thMzb2lu11vcF235Fxd9qdi8B3LtHEE71qX4YspvvBp/jFg
 K/zDE7Eezi84kn9t0JAen4KWjBdYwxyRqtcSK5I5W33Bpg6ky+F1LaWDQ0m2K1fxd+u1
 qKXsq1WeyawYtQwDd0Ixxn1U+YFpw/zFXoXyN+Z+zLLhzRAOPDnSgHP/DaRinnJ04Eye
 26Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=xTTAjJf21FVVJPXeayVLtKF3IlyrepWpUnexj9VEhJs=;
 b=PL2o7npHNvu1u7hl++RaDFinsxNFUFs/Zi8FqgKqa8gVPDb0OMlytbzqXRkBxF9ZBI
 gIq+FnQ6xtn26ylET32VnlX1d9ygrplYAAsQheOW8EFLkAO3ERdX4f80li0nKzkLNcc2
 O12JmxldmuBy4X58WawYbcGiQ2WTTQghxuEKm845OfE0beo8AHEkP/nWpo9bP01oUIJK
 Lnq9qX1GEF+a5odtvdHFHY5Kmzkg8S030SOQBTiJlL53vTp83nL+NxG3kYn7R5YALAnP
 W5pjD45yRtzy06zvQwM2mfgl9d/M0SnUh2CLZ7NeKiHUf6y13KrvjMk2EO80+JtRvXiE
 6snQ==
X-Gm-Message-State: APjAAAVRfyhEryTRy5yuBAtQNgR5z1jBY6gdA7zQJMuX1jthJwZDNxF/
 JEl9V6nBgvCBI4UuEJvizJ3gpBwS
X-Google-Smtp-Source: APXvYqzum264DGIMoJbIoYDlLehggfMENzp1eoSv/AtM2VQGSLXKj3lGJHxjgd3af7xpXcw+E2S6hiPC
X-Received: by 2002:a63:1106:: with SMTP id g6mr6000325pgl.13.1576093597574;
 Wed, 11 Dec 2019 11:46:37 -0800 (PST)
Date: Wed, 11 Dec 2019 14:46:03 -0500
Message-Id: <20191211194606.87940-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH 0/3] iommu/vt-d bad RMRR workarounds
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

Hi -

Commit f036c7fa0ab6 ("iommu/vt-d: Check VT-d RMRR region in BIOS is
reported as reserved") caused a machine to fail to boot for me, but only
after a kexec.

Firmware provided an RMRR entry with base and end both == 0:

	DMAR: RMRR base: 0x00000000000000 end: 0x00000000000000

Yes, firmware should not do that.  I'd like to be able to handle it.

That bad entry was actually OK on a fresh boot, since the region of
0x0000..0x0001 ([start, end + 1)) was type RESERVED due to this e820
update call:

	e820: update [mem 0x00000000-0x00000fff] usable ==> reserved

However, after a kexec, for whatever reason that first entry changed from

	BIOS-e820: [mem 0x0000000000000000-0x000000000009cbff] usable

to

	BIOS-e820: [mem 0x0000000000000100-0x000000000009cbff] usable

It starts at 0x100, not 0x000.  Ultimately, the range for that bad RMRR
[0x0, 0x1) isn't in the e820 map at all after a kexec.

The existing code aborts all of the DMAR parsing, eventually my disk
drivers fail, I can't mount the root filesystem, etc.  If you're
curious, I get a bunch of these errors:

	ata2.00: qc timeout (cmd 0xec)

I can imagine a bunch of ways around this.

One option is to hook in a check for buggy RMRRs in intel-iommu.c.  If
the base and end are 0, just ignore the entry.  That works for my
specific buggy DMAR entry.  There might be other buggy entries out
there.  The docs specify some requirements on the base and end (called
limit) addresses.

Another option is to change the sanity check so that unmapped ranges are
considered OK.  That would work for my case, but only because we're
hiding the firmware bug: my DMAR has a bad RMRR that happens to fall into a
reserved or non-existent range.  The downside here is that we'd
presumably be setting up an IOMMU mapping for this bad RMRR.  But at
least it's not pointing to any RAM we're using.  (That's actually what
goes on in the current, non-kexec case for me.  Phys page 0 is marked
RESERVED, and I have an RMRR that points to it.)  This option also would
cover any buggy firmwares that use an actual RMRR that pointed to memory
that was omitted from the e820 map.

A third option: whenever the RMRR sanity check fails, just ignore it and
return 0.  Don't set up the rmrru.  Right now, we completely abort DMAR
processing.  If there was an actual device that needed to poke this
memory that failed the sanity check (meaning, not RESERVED, currently),
then we're already in trouble; that device could clobber RAM, right?  If
we're going to use the IOMMU, I'd rather the device be behind an IOMMU
with *no* mapping for the region, so it couldn't clobber whatever we
happened to put in that location.

I actually think all three options are reasonable ideas independently of
one another.  This patchset that does all three.  Please take at least
one of them.  =)  (May require a slight revision if you don't take all
of them).

Barret Rhoden (3):
  iommu/vt-d: skip RMRR entries that fail the sanity check
  iommu/vt-d: treat unmapped RMRR entries as sane
  iommu/vt-d: skip invalid RMRR entries

 arch/x86/include/asm/iommu.h |  2 ++
 drivers/iommu/intel-iommu.c  | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.24.0.525.g8f36a354ae-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
