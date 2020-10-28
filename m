Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CC1C4363A
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 21:14:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C34924834
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 21:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DvOqsTCf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R8WZe//0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C34924834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F0C2B2038F;
	Wed, 28 Oct 2020 21:13:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SDT3FzS4LOuc; Wed, 28 Oct 2020 21:13:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BA11220382;
	Wed, 28 Oct 2020 21:13:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E090C0859;
	Wed, 28 Oct 2020 21:13:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2797EC0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 21:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0F4FF864B2
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 21:13:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5EAC+1rDVjRk for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 21:13:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 63583864A4
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 21:13:56 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1603919633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZN7gTMaQE9rZtoF/3JClNUhpDPOWII3Z0v/zsk1pW7Y=;
 b=DvOqsTCfJb//Gu7QniTg8aS3rdwxklw2TVI+sHxcDpoVjSql6wCXVQXYegUolgA+d1mElE
 tbylmYcxS3byoU49CeslFOqrj1SYPqXk00NPmWPVNsNwpSvKMJbJ7jx2c7G4WRXXhIFAC+
 CPeUOshJVPkcBe0C4CLLDINzO4Ec0dvdzld+HhYYl+S82ZxoHUg/xsH9fGPq22aoDNGL/K
 mhGheXQunw7P8/igcnAToSOwKUisFT9x6VVPdFHJvbqpamRoRYUcy7ziiLKenlaGpxR3+0
 0crL/f5reEyrGLxAE4MFUM+fQBN8sakeQnHRmtIKDhu6afo1sUoigwWkXXdIow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1603919633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZN7gTMaQE9rZtoF/3JClNUhpDPOWII3Z0v/zsk1pW7Y=;
 b=R8WZe//0NE888iRDVHM3pZcAHWnxRbe/zZzK4/MnQh4TllKWr+JrVaCiEyALu4243gwqiZ
 Q37ahmWu/3/IosDA==
To: Kees Cook <keescook@chromium.org>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 15/35] PCI: vmd: Use msi_msg shadow structs
In-Reply-To: <202010281347.2943F5B7@keescook>
References: <e6601ff691afb3266e365a91e8b221179daf22c2.camel@infradead.org>
 <20201024213535.443185-1-dwmw2@infradead.org>
 <20201024213535.443185-16-dwmw2@infradead.org>
 <202010281347.2943F5B7@keescook>
Date: Wed, 28 Oct 2020 22:13:52 +0100
Message-ID: <87blgmf3zj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: linux-hyperv@vger.kernel.org, kvm <kvm@vger.kernel.org>, x86@kernel.org,
 Dexuan Cui <decui@microsoft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, maz@misterjones.org,
 Paolo Bonzini <pbonzini@redhat.com>
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

On Wed, Oct 28 2020 at 13:49, Kees Cook wrote:
> On Sat, Oct 24, 2020 at 10:35:15PM +0100, David Woodhouse wrote:
>> +	memset(&msg, 0, sizeof(*msg);
>
> This should be:
>
> +	memset(msg, 0, sizeof(*msg);

        memset(msg, 0, sizeof(*msg));

Then it compiles _and_ is correct :)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
