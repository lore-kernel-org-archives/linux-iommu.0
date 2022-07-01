Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B742DCCA492
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 20:10:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EAFF9415CA;
	Fri,  1 Jul 2022 20:10:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EAFF9415CA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=sholland.org header.i=@sholland.org header.a=rsa-sha256 header.s=fm3 header.b=AqGoMTSN;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=oa1e9Su6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kQWkco3lWIFO; Fri,  1 Jul 2022 20:10:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 322E740B76;
	Fri,  1 Jul 2022 20:10:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 322E740B76
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0530AC0082;
	Fri,  1 Jul 2022 20:10:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2CEDC002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC3A460648
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC3A460648
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=sholland.org
 header.i=@sholland.org header.a=rsa-sha256 header.s=fm3 header.b=AqGoMTSN; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b=oa1e9Su6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AuQ9H0KeP3MN for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 20:10:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C0B09607D1
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C0B09607D1
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:49 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id 88D6C5802F4;
 Fri,  1 Jul 2022 16:01:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Fri, 01 Jul 2022 16:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1656705701; x=1656712901; bh=0L
 WuRMkphck+oUsETtbUMciB/g6XpbS+D68bi898KtM=; b=AqGoMTSNUno8lOmyDh
 KCwBkoAA7CbRzCpTwUdrVZNLF/wgidvQ7dsm+84o2fZ7gQevOX9qgVYV5nm/9kgO
 AMuQd8xE3VTWjlAJ7GrdD9VG7BV18Jcp9kKqlP10nOfIKsoMI+rW7kzM0NAfbTyC
 NWr74D8Q3JSoeOaEx9LsHr33xds/373ohmcrmDKPwF8OjXUOpnM+aWDRtp6nuvq9
 kg59XMZJPKD6+LWdXV+szMDXjt+Bh7ouD13imUf0Q05dynZ6LTdGmF8mVgEGl3Bl
 ONZn3X292lorO+Z+uaZEodDFOzhGvINgJHQDr8YSLNCPUjVe/p4PN6U1+nlRcr03
 GbWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1656705701; x=1656712901; bh=0LWuRMkphck+o
 UsETtbUMciB/g6XpbS+D68bi898KtM=; b=oa1e9Su6i+EtxBIhYMfUYN1BBIh7+
 NtLc3K9bSFNOEpdIhhM9orp+f/WF+uOfv1NI8kwLKLdemiOeS5HWJECGkfsHhJiH
 /wrY8WMMNhZUZUQf87Y6I2nlwQL4IKXSCH2sx7h4StxNsLo412pY5+cK8XhqNURa
 IF4psEvV+ZGo699etAF0/P+4jL5LalpbzQlttWsppbNEXfxA/dOghfaTOCAwlKrK
 KEvs69E1t/EoreKt1IwBdd8N4B9H428Bsjz94BHuby3lv0Gnlfekvlya7hY+n98C
 YWKS5+DGo6Bue2FdLbpuwQxoB2okv4DaH6kIF8BDFGbnyGUVJ78Jz+rvQ==
X-ME-Sender: <xms:olK_YsFQaQWqF-aONlCFJ5uetgmJnec1thbISaSBgnaCH8jS6vgdlw>
 <xme:olK_YlXkRgS5TvEifhOxL8eAll0aQOmledIk1hyN2rgNMA13JYmstRmbpGOaRmTU-
 H2H_Gklvg3vNf_76g>
X-ME-Received: <xmr:olK_YmLuD69cpfSzw-R4kmMPgu2jyauTWKCQHkDFAgmSZn9Gis4bbGNPIwkocA_DrrsH3sMvcbGjSDo8KSO7QZfNqsw4dV7PcL3l-1zAidbDC6DmKW4D1HlwVY3xH3m954qqMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehfedgudeggecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
 uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
 ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
 gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:olK_YuH3L90nAfoF2N8s9mi1lvzCGpKg5B0fSYH1opyql0hpPhTvBg>
 <xmx:olK_YiV10CMXHptGh7LyGaSf02IoE_5CXIQLqvsRS8VJkIe4doHZvA>
 <xmx:olK_YhO7Ax5bd7URto_P8m9sgMbfhMUEE1FQyOCxW1mjUcM8gkrmbw>
 <xmx:pVK_YnWNuGw-JrwdgPZRMxAas6DoPrjYmDFLwWpctwyYTLAPtQGZKg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Jul 2022 16:01:36 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 4/8] genirq: Drop redundant irq_init_effective_affinity
Date: Fri,  1 Jul 2022 15:00:52 -0500
Message-Id: <20220701200056.46555-5-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220701200056.46555-1-samuel@sholland.org>
References: <20220701200056.46555-1-samuel@sholland.org>
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

It does exactly the same thing as irq_data_update_effective_affinity.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - New patch to drop irq_init_effective_affinity

 kernel/irq/manage.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 8c396319d5ac..40fe7806cc8c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -205,16 +205,8 @@ static void irq_validate_effective_affinity(struct irq_data *data)
 	pr_warn_once("irq_chip %s did not update eff. affinity mask of irq %u\n",
 		     chip->name, data->irq);
 }
-
-static inline void irq_init_effective_affinity(struct irq_data *data,
-					       const struct cpumask *mask)
-{
-	cpumask_copy(irq_data_get_effective_affinity_mask(data), mask);
-}
 #else
 static inline void irq_validate_effective_affinity(struct irq_data *data) { }
-static inline void irq_init_effective_affinity(struct irq_data *data,
-					       const struct cpumask *mask) { }
 #endif
 
 int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
@@ -347,7 +339,7 @@ static bool irq_set_affinity_deactivated(struct irq_data *data,
 		return false;
 
 	cpumask_copy(desc->irq_common_data.affinity, mask);
-	irq_init_effective_affinity(data, mask);
+	irq_data_update_effective_affinity(data, mask);
 	irqd_set(data, IRQD_AFFINITY_SET);
 	return true;
 }
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
