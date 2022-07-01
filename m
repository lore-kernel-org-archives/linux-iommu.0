Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC01ACCA488
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 20:10:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 168B3423C1;
	Fri,  1 Jul 2022 20:10:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 168B3423C1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=sholland.org header.i=@sholland.org header.a=rsa-sha256 header.s=fm3 header.b=mK5frjjp;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hcCVwh1P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xwNQCSixmaYH; Fri,  1 Jul 2022 20:10:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 55F8D423BA;
	Fri,  1 Jul 2022 20:10:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 55F8D423BA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D549C0082;
	Fri,  1 Jul 2022 20:10:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97846C002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F656423B9
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F656423B9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fy4Fh_kTs-Za for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 20:10:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CEAE141765
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CEAE141765
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:48 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id 28AC058020B;
 Fri,  1 Jul 2022 16:01:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Fri, 01 Jul 2022 16:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:sender:subject:subject:to:to;
 s=fm3; t=1656705670; x=1656712870; bh=h3WN3AcddFJuwhQ39XPEdgr5t
 ejPWmRF9a5JWUKLi6w=; b=mK5frjjpRETCdaizhOvpq/mQo5UlOZqfHCt356wLu
 +SqVP3qKJ9LvP7YyRWEopUxCgCJ/Co0nb1GRIXbVwdtlJ5JrYoRlSvc+27WDag9+
 3jqJC6Nc5lLjDB1EbFnpv2S6VMiJgoGG3ESQyrzvFx4wbwb1+hfvfkj14nzE1iZ9
 iHVs2Uh7tOwAj5coKNt98E1KuIr4Dy7ZidSi8Si+tRxxbGIc8g9/Wkp/PXxkdKWp
 GwXvkDhS2Mkt7Y8U+OzIUgUEfaENyM7PjR+7UVXgmM8J+652ddmFvBKyk157w8wr
 Skl8C3hKCbHheCLVFZJbuy7hz1/cffoSdxxCfnrh8YV+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1656705670; x=1656712870; bh=h3WN3AcddFJuwhQ39XPEdgr5tejPWmRF9a5
 JWUKLi6w=; b=hcCVwh1PvSeKLtV/WWesjzpJEJOw4znKr5Z/2vhxnZuKQA9kLw4
 /4+bCBG81guTmscsfsRlkY2MRf/An6IfLb4PqUB9cFC2NzaudqFlvP/yY19K+3XC
 pDHCoLiIcwUV2Xv5FAIqCmEYAOVR+oCL2f261uukUnOGmb9sZJ1Wjru1FpMPNx9q
 O20C8qlSGZIk/uqxcd6LnT2yDuqwiTmpUUWND72se1ELzfF/mrU6icJu6Gm0jlH3
 iWOFR5OoOCZxlEPQplc7c7ud1SjE6qek/nk6mnJ70FNjkvapXHjyVwlAV5qpv1MZ
 45+fzYTFXAvc9YboPqeOQ31my0wQpPDiZ5Q==
X-ME-Sender: <xms:e1K_YqJAKXaKPgqyd59ldyt87npfqKJCG8Fa8IiJ1JGRiUiSXx5JZg>
 <xme:e1K_YiIt8LjVqOvwpx_JqZXxhJz3pskkEoDpx0DfqF9QwrmlD77DvYrLphtzsH91c
 60EnwaE7sSCA8LhkQ>
X-ME-Received: <xmr:e1K_YqsbiJXFwsSStjJJO67Bifhg0yOnU6Z4_h1F4ezRCF_0D6gcyJ1rBH7JskXj8BCpGV4CECN0ypLF1eSiq5ghfDtA6Nb3u4bteUm49CHrPVJYe6DLnAKCGajaiAQKWL5-Lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehfedgudeggecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
 lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
 frrghtthgvrhhnpeekheffteehtdetfffgfeetteejvdefleeuvedufffguedtjedvheel
 vddvfffhveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
 ugdrohhrgh
X-ME-Proxy: <xmx:e1K_YvbVVgQANbs4tH6mMUrH5LaNLres37xpgQFzFinmY6f7nPb4Fg>
 <xmx:e1K_YhbiP6yq2Gi3AoIAcfhp4QohMreFnvgTLD9awWXIWatRIZ3Cjw>
 <xmx:e1K_YrCjgb2M3iT9zxycFn46jQ9pLIWED1rqKrx13LiM_I0tfM9RnQ>
 <xmx:hlK_YgfaZPstR3sDyiLp39VIN104HgzzMuXBbFWrwe3H_JzEL7MHlA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Jul 2022 16:00:57 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 0/8] genirq: Provide real IRQ affinity masks in non-SMP
 configs
Date: Fri,  1 Jul 2022 15:00:48 -0500
Message-Id: <20220701200056.46555-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
 linux-hyperv@vger.kernel.org, Rich Felker <dalias@libc.org>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Jan Beulich <jbeulich@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Sven Schnelle <svens@stackframe.org>, Rob Herring <robh@kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Samuel Holland <samuel@sholland.org>, Will Deacon <will@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, x86@kernel.org,
 Dexuan Cui <decui@microsoft.com>, Russell King <linux@armlinux.org.uk>,
 Wei Xu <xuwei5@hisilicon.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Ingo Molnar <mingo@redhat.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 xen-devel@lists.xenproject.org, Matt Turner <mattst88@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-xtensa@linux-xtensa.org,
 Kees Cook <keescook@chromium.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Maximilian Heyne <mheyne@amazon.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Juergen Gross <jgross@suse.com>, Chris Zankel <chris@zankel.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Serge Semin <fancer.lancer@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Colin Ian King <colin.king@intel.com>,
 Helge Deller <deller@gmx.de>
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

This series solves some inconsistency with how IRQ affinity masks are
handled between SMP and non-SMP configurations.

In non-SMP configs, an IRQ's true affinity is always cpumask_of(0), so
irq_{,data_}get_affinity_mask now return that, instead of returning an
uninitialized per-IRQ cpumask. This change makes iterating over the
affinity mask do the right thing in both SMP and non-SMP configurations.

To accomplish that:
 - patches 1-3 disable some library code that was broken anyway on !SMP
 - patches 4-7 refactor the code so that irq_{,data_}get_affinity_mask
   can return a const cpumask, since that is what cpumask_of provides
 - patch 8 drops the per-IRQ cpumask and replaces it with cpumask_of(0)

This series was split from the v2 series here, which uses the new
behavior in the RISC-V PLIC irqchip driver:

https://lore.kernel.org/lkml/20220616064028.57933-1-samuel@sholland.org/

Changes in v3:
 - New patch to fix build errors in uniprocessor MIPS configs
 - New patch to drop irq_init_effective_affinity
 - New patch to introduce irq_data_update_affinity
 - New patch to make the returned cpumasks const
 - Use cpumask_of(0) instead of cpu_possible_mask

Changes in v2:
 - New patch to prevent GENERIC_IRQ_IPI from being selected on !SMP

Samuel Holland (8):
  irqchip/mips-gic: Only register IPI domain when SMP is enabled
  genirq: GENERIC_IRQ_IPI depends on SMP
  genirq: GENERIC_IRQ_EFFECTIVE_AFF_MASK depends on SMP
  genirq: Drop redundant irq_init_effective_affinity
  genirq: Refactor accessors to use irq_data_get_affinity_mask
  genirq: Add and use an irq_data_update_affinity helper
  genirq: Return a const cpumask from irq_data_get_affinity_mask
  genirq: Provide an IRQ affinity mask in non-SMP configs

 arch/alpha/kernel/irq.c              |  2 +-
 arch/arm/mach-hisi/Kconfig           |  2 +-
 arch/ia64/kernel/iosapic.c           |  2 +-
 arch/ia64/kernel/irq.c               |  4 +-
 arch/ia64/kernel/msi_ia64.c          |  4 +-
 arch/mips/cavium-octeon/octeon-irq.c |  4 +-
 arch/parisc/kernel/irq.c             |  2 +-
 arch/sh/kernel/irq.c                 |  7 +--
 arch/x86/hyperv/irqdomain.c          |  2 +-
 arch/xtensa/kernel/irq.c             |  7 +--
 drivers/iommu/hyperv-iommu.c         |  2 +-
 drivers/irqchip/Kconfig              | 19 +++----
 drivers/irqchip/irq-bcm6345-l1.c     |  4 +-
 drivers/irqchip/irq-mips-gic.c       | 80 +++++++++++++++++++---------
 drivers/parisc/iosapic.c             |  2 +-
 drivers/pci/controller/pci-hyperv.c  | 10 ++--
 drivers/sh/intc/chip.c               |  2 +-
 drivers/xen/events/events_base.c     |  7 +--
 include/linux/irq.h                  | 34 ++++++++----
 kernel/irq/Kconfig                   |  2 +
 kernel/irq/chip.c                    |  8 +--
 kernel/irq/debugfs.c                 |  2 +-
 kernel/irq/ipi.c                     | 16 +++---
 kernel/irq/manage.c                  | 10 +---
 24 files changed, 140 insertions(+), 94 deletions(-)

-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
