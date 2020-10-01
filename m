Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B88C4727C
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 13:53:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 641A421707
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 13:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jDpfVmta";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VUPBvkhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641A421707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2827586959;
	Thu,  1 Oct 2020 13:53:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AXv1NxV3sdI0; Thu,  1 Oct 2020 13:53:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9C6EF86940;
	Thu,  1 Oct 2020 13:53:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9169AC016F;
	Thu,  1 Oct 2020 13:53:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 625CDC0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 13:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5110286ACF
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 13:53:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rNq1O6IhE1Nh for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 13:53:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A2F8686ACA
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 13:53:10 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1601560387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8QlmQU4U707WUFGOJ0XG+Q1YjhMDkPVgYfkVUA/WoFc=;
 b=jDpfVmtaeTkDdW/IvYOq5JTlvoEDvMPuXHKdBkqxDhj9NtP6sTCT7g/kMy5ECqhZUGy2+4
 ++hAJ4Lf+UXj9X848nWTQXsWOUQwa0nSp8X6CBBBUzXU5W59I9y+JhIX+EAI1RusI4giOx
 WoE//JGbOJ/9aovK5UwQd1DPj/14mcwlcfKH5BL9ZmpEPYc59kRKDsf6dp6TQ7Zewxpo4q
 yL8kwmNhWt7cTao5A/py29YkkltUhHrvrLanp3xl0L310qxEaveU9Sh4MqjbrIFJvjOInj
 eMAYvmm8xoIqfs4bQEuXBHHNbgDKRhrRhhHHt1xe5fMSTnynEXYGFUqVvcIPNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1601560387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8QlmQU4U707WUFGOJ0XG+Q1YjhMDkPVgYfkVUA/WoFc=;
 b=VUPBvkhvJ43I0rw6XwXLBzv6cBppoaj+or1uLt5D2g6BaWB0D6BqJUpq/u8iIurpo4fr5G
 aeKaeW8Pag4Xo9Bg==
To: Zi Yan <ziy@nvidia.com>
Subject: Re: Boot crash due to "x86/msi: Consolidate MSI allocation"
In-Reply-To: <2F4EC354-C0BB-44BD-86A5-07F321590C31@nvidia.com>
References: <A838FF2B-11FC-42B9-87D7-A76CF46E0575@nvidia.com>
 <874knegxtg.fsf@nanos.tec.linutronix.de>
 <2F4EC354-C0BB-44BD-86A5-07F321590C31@nvidia.com>
Date: Thu, 01 Oct 2020 15:53:07 +0200
Message-ID: <87h7ref3y4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Wei Liu <wei.liu@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 linux-pci@vger.kernel.org, x86@kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org
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

Yan,

On Thu, Oct 01 2020 at 09:39, Zi Yan wrote:
> On 1 Oct 2020, at 4:22, Thomas Gleixner wrote:
>> Can you please test:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/irq
>>
>> which contains fixes and if it still crashes provide the dmesg of it.
>
> My system boots without any problem using this tree. Thanks.

linux-next of today contains these fixes, so that should work now as
well.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
