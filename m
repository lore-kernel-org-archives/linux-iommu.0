Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4455C4363D
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 20:46:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2686A20866
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 20:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e4W7SWtA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K8TBdKok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2686A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C7CDF85F66;
	Tue,  6 Oct 2020 20:45:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MVIrxEUnCJHw; Tue,  6 Oct 2020 20:45:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 335B385F57;
	Tue,  6 Oct 2020 20:45:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21DE2C07FF;
	Tue,  6 Oct 2020 20:45:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B5F9C0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 20:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 256BA867B2
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 20:45:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7oB7vGkYNDHn for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 20:45:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BA709867B5
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 20:45:56 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1602017153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=x8PBGKW1YFjQr3oglR9eLdmhsqjcfHmqCT2LlUTGLOM=;
 b=e4W7SWtA094G/E5QqbF3+PJqU6PUCpdgUq/IsecAJg6rJGv7NpL2fNMGDOv6YrrFBPWI43
 /At/3FcNjP6DMeygAGU9gzxyFADLwVgcD7taKVyMC3Bic8MaBKJj8CYoeGdeglElyZ7gyS
 3IuBDsSU7PhQrFtLOIV/V1UIR+FZLypZF8if9oTQvKwmruhx6XFSrZTZ7ht4hJeuxPGC7j
 KQqM1UOXcLmkJGWADmKPl/3A7fH25cVGyMIdTbejWT3pKIVGzvfHbijDm5L+j2F5fFr6Rx
 i8LOIZdqPcHAd5v8jdsRdPjsZjuKhdRWGgSWVpqn5NAwQ/4+7DyAgqzJb5QMHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1602017153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=x8PBGKW1YFjQr3oglR9eLdmhsqjcfHmqCT2LlUTGLOM=;
 b=K8TBdKokFbXMu9SjeVNl/PwtI14Ub8N5UFQnHrWRhVM7CD57x46IsI4/6AuINN+3aCkni2
 DyIYHMP7C49pfYCA==
To: David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
Subject: Re: [PATCH 02/13] x86/msi: Only use high bits of MSI address for DMAR
 unit
In-Reply-To: <20201005152856.974112-2-dwmw2@infradead.org>
Date: Tue, 06 Oct 2020 22:45:53 +0200
Message-ID: <87v9fn5bi6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 iommu <iommu@lists.linux-foundation.org>, linux-hyperv@vger.kernel.org,
 kvm <kvm@vger.kernel.org>
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

On Mon, Oct 05 2020 at 16:28, David Woodhouse wrote:
> -static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
> +static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg, int dmar)

bool dmar?

> +/*
> + * The Intel IOMMU (ab)uses the high bits of the MSI address to contain the
> + * high bits of the destination APIC ID. This can't be done in the general
> + * case for MSIs as it would be targeting real memory above 4GiB not the
> + * APIC.
> + */
> +static void dmar_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	__irq_msi_compose_msg(irqd_cfg(data), msg, 1);
> +
> +
> +

Lots of stray newlines...

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
