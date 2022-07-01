Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9729DC433EF
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 20:10:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 11B0D404DD;
	Fri,  1 Jul 2022 20:10:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 11B0D404DD
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=sholland.org header.i=@sholland.org header.a=rsa-sha256 header.s=fm3 header.b=ifFqAwFe;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=P1MvxlIO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4qpE1kjBig-J; Fri,  1 Jul 2022 20:10:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B45D340386;
	Fri,  1 Jul 2022 20:10:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B45D340386
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 858E8C0035;
	Fri,  1 Jul 2022 20:10:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76FC7C002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 39DD584147
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39DD584147
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=sholland.org
 header.i=@sholland.org header.a=rsa-sha256 header.s=fm3 header.b=ifFqAwFe; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b=P1MvxlIO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xq_BknKS0oMx for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 20:10:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E68E784142
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E68E784142
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 20:10:48 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 50D84580357;
 Fri,  1 Jul 2022 16:01:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 01 Jul 2022 16:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1656705717; x=1656712917; bh=mr
 ZZqztLVKSIkpl2ZtG9SZsAXGvA9Vl+x5zOkvs3Bjg=; b=ifFqAwFeM2wxyJCvKE
 TcogHoKvz8Ikgyvbheen4lB6TK8my3nTFtPtZqZwV2EJoW1d675CVWiRCQYrtpCV
 gjmX3xfutUzOU3hClg0Njj4ieVpzITbRxgXZVuosglRi9Ve/QUV4hEboq9Cl6D5q
 5ZUDm0FkkQme2ysoms3ELh8Ej8sCf/bY7d3513Rv+xbTCp2MmH04t4WPs+p30/R/
 NUoTk/RQLxrRh5NqM1X0miI8sZ9j0rcT8Y1gbcNzWv3fehEjbKWta0Zm2a34hcFz
 IRiPSucdZsSIbDrwFJcccZcbWOSp8i+md8XOrmXWaR/5piNMD50Sh8euiQzn0koH
 sIGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1656705717; x=1656712917; bh=mrZZqztLVKSIk
 pl2ZtG9SZsAXGvA9Vl+x5zOkvs3Bjg=; b=P1MvxlIOuM7l0z+qS8yeYED1ddgJs
 ZCs2QYRhK40y97qVVKx50uDXKGc7mEB0wEwGcSiJsX1JtDdjkQWUx99X65YS4sz+
 VfSaSS6Ie4KKuWHsotLfT5em9QY23iuX70+vsHcDY2KRtIP+aVtenEK44OuBMsai
 UBAjIHn3DU+BwynQs3RgoaYjQarWyRcQP7W5Gh2Uup25KvchrpUJqNUtKa3U+bgZ
 BTQhJ+xzfCrqL5QAda74Vyo+egxNHDbWs7GXn2vOV7ssh9klKGGfy1CHr9gnsXME
 J2Ch54d15PxAoSgBunXMCXpz/ijn5crnwUN/1XIG9K1lsPwNHpUnb99dA==
X-ME-Sender: <xms:tVK_Yn0kldOcLkWk3dfIzfXt7vEQSWSDQuQhk6xOyUH6462s2Aafdw>
 <xme:tVK_YmHzembFAoNWd77N3YnMz2ToCVVA3ID83I0u19Nq-hOul4kwoPfowFqG0OJU5
 9Up9yAkJymy0CEPig>
X-ME-Received: <xmr:tVK_Yn4ez4uypnFnFJ_3S-MZZK2rMoSOVkyJcaQENIV3-JxGd7QBPtijtwYnd0ibdz0oyf0Ih3Ol2g8rOwlklU9P9_G8MyY9ieFatffNBjzmGTzr0MCSIh0uclg2SZmSBTnenw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehfedgudeggecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
 uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
 ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
 gfdufeeitdevteenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:tVK_Ys2boEFyZ2b7B1aml8ZopCfvtqe4SBKhfTNbbjUwaL5H_-Vt5w>
 <xmx:tVK_YqFInOCCYvQ6u16XXnQamCJINVqY-HKUCA2295MtRmC9HX0L8w>
 <xmx:tVK_Yt8uHh-EDhML-nWscQ8f9B1_bd-I8tbDH-V2EpmCZ_1zpFsBkg>
 <xmx:tVK_YiGQ7OXgBCgZlUMKnwYghy6mgLV662iTefVRH5xGXr6DzTd3uQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Jul 2022 16:01:54 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 8/8] genirq: Provide an IRQ affinity mask in non-SMP configs
Date: Fri,  1 Jul 2022 15:00:56 -0500
Message-Id: <20220701200056.46555-9-samuel@sholland.org>
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

IRQ affinity masks are not allocated in uniprocessor configurations.
This requires special case non-SMP code in drivers for irqchips which
have per-CPU enable or mask registers.

Since IRQ affinity is always the same in a uniprocessor configuration,
we can provide a correct affinity mask without allocating one per IRQ.

By returning a real cpumask from irq_data_get_affinity_mask even when
SMP is disabled, irqchip drivers which iterate over that mask will
automatically do the right thing.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Use cpumask_of(0) instead of cpu_possible_mask

 include/linux/irq.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 02073f7a156e..996e22744edd 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -151,7 +151,9 @@ struct irq_common_data {
 #endif
 	void			*handler_data;
 	struct msi_desc		*msi_desc;
+#ifdef CONFIG_SMP
 	cpumask_var_t		affinity;
+#endif
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	cpumask_var_t		effective_affinity;
 #endif
@@ -882,13 +884,19 @@ static inline int irq_data_get_node(struct irq_data *d)
 static inline
 const struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
 {
+#ifdef CONFIG_SMP
 	return d->common->affinity;
+#else
+	return cpumask_of(0);
+#endif
 }
 
 static inline void irq_data_update_affinity(struct irq_data *d,
 					    const struct cpumask *m)
 {
+#ifdef CONFIG_SMP
 	cpumask_copy(d->common->affinity, m);
+#endif
 }
 
 static inline const struct cpumask *irq_get_affinity_mask(int irq)
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
