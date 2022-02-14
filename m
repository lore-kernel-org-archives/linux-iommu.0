Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2CCC433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 17:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7295B823AB;
	Mon, 14 Feb 2022 17:25:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sZjdICiZv1gG; Mon, 14 Feb 2022 17:25:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5B75481C18;
	Mon, 14 Feb 2022 17:25:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43208C001A;
	Mon, 14 Feb 2022 17:25:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1280FC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 17:25:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4CA84092D
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 17:25:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="SJoIEu+z";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="RUraRs3W"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eVtXgaTLPief for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 17:25:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5878640909
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 17:25:29 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1644859527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IghW1yCinRwuBjJx96OYf7MGD4W3BpFS4t1OFpWxVSI=;
 b=SJoIEu+zLBfbz6vLUXj9gi0gd07aWubitxSgMTJPpUwLAfs0fzPkU8lQo8iw6FRMAPfZwh
 +MQ55maPhXPwHtfR4DIycocNvWKWOteRwVUetW2c4n2UND92FeVkJe3qFsFL4M6N7i2WlZ
 P6bFMf4WdSrMZqiHsTOzNnZs/Fy0YjiMp5C1NvK4HVZx1If5GuKnnzO0OSamq98fr6BhuW
 oXX6gqqFJ/QV10xyuMP4nn+K5MpBMgLfdJ++bVkWlRgBTcl+9NMadoFNYt598UaxHTOC71
 QvdCgUau0gpqRWVIHlbB6+EMWbyu5i0e7S7Coq+7G654Be8R62qm4wfSgHn7fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1644859527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IghW1yCinRwuBjJx96OYf7MGD4W3BpFS4t1OFpWxVSI=;
 b=RUraRs3WKaydP/V+PymWCuyEhkM1iPNtIRvbGsRlGzJV2xkqE01bl1/JChsJJ6bYPM6ths
 HHhS6pGEglO1nSCw==
To: Fenghua Yu <fenghua.yu@intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy
 Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Ashok
 Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v4 11/11] docs: x86: Change documentation for SVA
 (Shared Virtual Addressing)
In-Reply-To: <20220207230254.3342514-12-fenghua.yu@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-12-fenghua.yu@intel.com>
Date: Mon, 14 Feb 2022 18:25:26 +0100
Message-ID: <87pmnpqs1l.ffs@tglx>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
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

On Mon, Feb 07 2022 at 15:02, Fenghua Yu wrote:
> Since allocating, freeing and fixing up PASID are changed, the
> documentation is updated to reflect the changes.
>
> Originally-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
