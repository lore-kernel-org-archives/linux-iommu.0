Return-Path: <SRS0=ThSx=EQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4932C5517A
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 17:06:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159D4206D8
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 17:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4+3CV7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159D4206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BC5D5871F1;
	Tue, 10 Nov 2020 17:06:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id egGoFe4+pnWs; Tue, 10 Nov 2020 17:06:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F1A4E87201;
	Tue, 10 Nov 2020 17:05:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF35BC1AD8;
	Tue, 10 Nov 2020 17:05:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C415C016F
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 16:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2C46322C44
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 16:26:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QSAqou0Y4Piw for <iommu@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 16:26:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by silver.osuosl.org (Postfix) with ESMTPS id C6C562042B
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 16:26:24 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id cq7so13162739edb.4
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 08:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2NcAsVTPsYA/NoTEYktfl6/AwcvS1dbUOsrpH4IcvMo=;
 b=m4+3CV7fPBedSyDJNc3NrHQ+qEZyL//4m+o1MBQ1SyAd3as1QYsZ0A+sxlrZs+uIBn
 yXNI4cZL68ADq/I0ZyxXYVCK2gb0McEZkv4gKqsjCydl8dU+mlJMWRyABu/nd9KTCdBZ
 MUJt5PGaJYpyiCWdjnuVMpGp7qDIAF0RZrA2F6eKU+V1OeeEIYStcp3tyWmrRKr85gdk
 4eOEFGPkX9HCdfDO/lKXjvgNb+rVCYlwxq5GL7cXg6/gANObk+NZkUbEiTZcAFAfd0aT
 L5myAHFx41BljRl6tWYRQiiiACg9WQWHFlN/yHaxOStPSDwV/KZzcIUQM6MzVt0Tc+SR
 RXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2NcAsVTPsYA/NoTEYktfl6/AwcvS1dbUOsrpH4IcvMo=;
 b=qRpVF8DYwS5x5r618gqg9dl3yJ4CuUDKt3HFuTIyvkDU9dn8YxlQzjmK3rp1Vcm5Us
 7C6dzBC1NIaN4sXY1i6DiLl7B6z1WM4/zRqCULej7ZY+EUObh0gPDo3r3/IA8O2U8jkv
 QwIjN4UAwNL9u6sK/q4QVCF8CapcgNryh+/vaLGPUOLuBFyjPCxI1Yq5cxOHhbrJBLLu
 N8dRi2m26xt3ohlWebUuMltZdDcC3ugwD8Z2z+R/MnlUTBrapM2/uE0sGU5YNNfl0u8m
 8tRpsEta98AzxLqIPC+qYbUrSH7qBDr+MULqVFEa7zEJBq9VcsDF759X8LF3XoIv3gUy
 axnA==
X-Gm-Message-State: AOAM533YTsHhy8sM7q5VIydlRA9caIOWMwGBIV6vAKXm9Jbfib+W7+/F
 NeqE01h1Hk8SLTaIRyUbh0Y=
X-Google-Smtp-Source: ABdhPJwuSP6VnkfK3b2egRw4V5auLe2FLUmM5/5ZMiBr4Avs7VrFlqlnVw0CmhEpsMDOWn3cUuiyhw==
X-Received: by 2002:aa7:c704:: with SMTP id i4mr93729edq.51.1605025583211;
 Tue, 10 Nov 2020 08:26:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.googlemail.com with ESMTPSA id q15sm11048192edt.95.2020.11.10.08.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2020 08:26:22 -0800 (PST)
Subject: Re: [PATCH v3 19/35] x86/io_apic: Cleanup trigger/polarity helpers
To: David Woodhouse <dwmw2@infradead.org>, Qian Cai <cai@redhat.com>,
 x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Tom Murphy <murphyt7@tcd.ie>
References: <e6601ff691afb3266e365a91e8b221179daf22c2.camel@infradead.org>
 <20201024213535.443185-1-dwmw2@infradead.org>
 <20201024213535.443185-20-dwmw2@infradead.org>
 <085029af45f045dcf5b7fb2173d560421b00b44d.camel@redhat.com>
 <23e0a29faad5a9cc43582ba7d40a3073f2fb8c87.camel@infradead.org>
From: Paolo Bonzini <bonzini@gnu.org>
Message-ID: <e213d85f-b29b-e663-29db-10d987feb8d7@gnu.org>
Date: Tue, 10 Nov 2020 17:26:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <23e0a29faad5a9cc43582ba7d40a3073f2fb8c87.camel@infradead.org>
Content-Language: en-US
X-Mailman-Approved-At: Tue, 10 Nov 2020 17:05:57 +0000
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-hyperv@vger.kernel.org,
 kvm <kvm@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>, maz@misterjones.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 10/11/20 09:59, David Woodhouse wrote:
> Hm, attempting to reproduce this shows something else. Ever since
> commit be62dbf554c5 ("iommu/amd: Convert AMD iommu driver to the dma-
> iommu api") in 5.5 the following stops working for me:
> 
> $ qemu-system-x86_64 -serial mon:stdio -kernel bzImage  -machine q35,accel=kvm,kernel-irqchip=split -m 2G -device amd-iommu,intremap=off -append "console=ttyS0 apic=verbose debug" -display none
> 
> It hasn't got a hard drive but I can watch the SATA interrupts fail as
> it probes the CD-ROM:
> 
> [    7.403327] ata3.00: qc timeout (cmd 0xa1)
> [    7.405980] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> 
> Adding 'iommu=off' to the kernel command line makes it work again, in
> that it correctly panics at the lack of a root file system, quickly.

That might well be a QEMU bug though, AMD emulation is kinda experimental.

Paolo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
