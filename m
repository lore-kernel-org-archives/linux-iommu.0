Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2C8C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 16:48:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2FA64F7C
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 16:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2FA64F7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EB2168696D;
	Wed,  3 Feb 2021 16:48:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Os9lU9-c7Q8B; Wed,  3 Feb 2021 16:48:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DAC1980A61;
	Wed,  3 Feb 2021 16:48:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE257C0FA8;
	Wed,  3 Feb 2021 16:48:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FA49C0174
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 16:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2423186081
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 16:47:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LVjx3OkGj76d for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 16:47:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6DE5C8607D
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 16:47:58 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id j25so564222oii.0
 for <iommu@lists.linux-foundation.org>; Wed, 03 Feb 2021 08:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qZEmNp2ZakxDJznFqcVZ1P80OyQOGPyM6d5UCk5d3vk=;
 b=lrPEG74DOtqh0L7paTBjafFI44X0ikYaEsGMLmHNqbxviTPPH2RmXs68TIGDoMrrC1
 DjwAxBpCyW1/ZZ/A1Mimjxt21m2+NePiopmTdSUrmjhtvyiwZ31SAHWPe++B7SGi6YJV
 dOHc9ig1W+xyZ6263TnU6LVUd8RyDzTwUXkVWh4m0MuUvp7u46NIDMTe1RFSJ03m3QqH
 lhed1HQeGZphcYM/6mCFIxFXlYyKIG4gL4tOl9gr9ChfCJI7lTUqro7G4WXbJDYhRvAW
 tehtMsu6xdSQKpB/mqrFgpd6bs/dy57W3Ay5G60j4GwuamIYASeUDTfiEkTiPdrU6uVR
 yWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qZEmNp2ZakxDJznFqcVZ1P80OyQOGPyM6d5UCk5d3vk=;
 b=Oy/nrTI4TrKUu/X5YIHXgZPJnvloS5ASQbvnN4Qe9attww1wVRPUOKhT2+G/qmJX1E
 1KJqxEn1idXtfV3TdS66Ro6opYwBFvXemjWsUDWA00YU4JoDkcpWLtbja+DTGcgdgO78
 bcI+PpyDTFC6P+QXHMp6GmbJ3iKxR9SWZLeqaXM8nLGwXoChw++K+iifBeVxXC7RcxWu
 YsqdNGW4CyYqJSS8WxEezz07vdHjrwbu5ZKCHmz72PlPvbQpx1XGSZHPzcKmzW1UTSIx
 4BgVRXrs8wMqPyzVgFE3CJUAZXZ/i8BphP4xnPNfkWv98cyKshCaLY/W0OjyVspuvhjn
 kFTw==
X-Gm-Message-State: AOAM532sOFdjZpRZFJiGjdydxlYV1Cv2la8FaufjPvV25Bv3a4nllhPB
 +Xi0MYcT1IQUUlqqzfmUJ+cn7oqb/Z8vADVgwt5tAw==
X-Google-Smtp-Source: ABdhPJz2RpbhkniHRFTWA/PnemwFxygMLB82C8ofE36DFtyCupwdbGrY9bzMHloCpMlEZy/Z9AXkapfX8D+WwztZi8I=
X-Received: by 2002:aca:b9c1:: with SMTP id j184mr2575743oif.63.1612370877454; 
 Wed, 03 Feb 2021 08:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
 <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com>
 <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
 <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
 <20210203133712.GA24674@lst.de>
In-Reply-To: <20210203133712.GA24674@lst.de>
Date: Wed, 3 Feb 2021 08:47:45 -0800
Message-ID: <CAMGD6P1Ksn4DJ0w=O20Ou7BOKAW9yzwJgRV57xaqLdVDK4ATaQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask
 to NVMe driver.
To: Christoph Hellwig <hch@lst.de>
Cc: heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 Saravana Kannan <saravanak@google.com>, bgolaszewski@baylibre.com,
 Marc Orr <marcorr@google.com>, gregkh@linuxfoundation.org,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 axboe@fb.com, iommu@lists.linux-foundation.org, jroedel@suse.de,
 Keith Busch <kbusch@kernel.org>, dan.j.williams@intel.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>
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
From: Jianxiong Gao via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jianxiong Gao <jxgao@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

>
> Please try with this extra patch:
>
I have tried with the extra patch and it still fails to boot.
I have attached dmesg output for the error:

-------------dmesg starts here-----------------
[    6.357755] XFS (nvme0n1p2): Mounting V5 Filesystem
[    6.430092] XFS (nvme0n1p2): Torn write (CRC failure) detected at
log block 0x20d0. Truncating head block from 0x20e0.
[    6.442828] XFS (nvme0n1p2): Starting recovery (logdev: internal)
[    7.272456] XFS (nvme0n1p2): Ending recovery (logdev: internal)
[    7.610250] systemd-journald[434]: Received SIGTERM from PID 1 (systemd).
...
[   10.054121] systemd[755]:
/usr/lib/systemd/system-generators/systemd-rc-local-generator
terminated by signal ABRT.
[   10.726122] audit: type=1400 audit(1612370261.090:4): avc:  denied
{ search } for  pid=783 comm="systemd-sysctl" name="crash"
dev="nvme0n1p2" ino=50789805
scontext=system_u:system_r:systemd_sysctl_t:s0
tcontext=system_u:object_r:kdump_crash_t:s0 tclass=dir permissive=0
[   10.751764] audit: type=1400 audit(1612370261.090:5): avc:  denied
{ search } for  pid=783 comm="systemd-sysctl" name="crash"
dev="nvme0n1p2" ino=50789805
scontext=system_u:system_r:systemd_sysctl_t:s0
tcontext=system_u:object_r:kdump_crash_t:s0 tclass=dir permissive=0
[   12.366607] xfs filesystem being remounted at / supports timestamps
until 2038 (0x7fffffff)
[   12.376379] audit: type=1400 audit(1612370262.740:6): avc:  denied
{ write } for  pid=788 comm="systemd-remount" name="crash"
dev="nvme0n1p2" ino=50789805 scontext=system_u:system_r:init_t:s0
tcontext=system_u:object_r:kdump_crash_t:s0 tclass=dir permissive=0
[   12.413155] systemd-journald[781]: Received request to flush
runtime journal from PID 1
[   12.428917] audit: type=1400 audit(1612370262.793:7): avc:  denied
{ write } for  pid=815 comm="journalctl" name="crash" dev="nvme0n1p2"
ino=50789805 scontext=system_u:system_r:init_t:s0
tcontext=system_u:object_r:kdump_crash_t:s0 tclass=dir permissive=0
[   12.453006] audit: type=1400 audit(1612370262.799:8): avc:  denied
{ write } for  pid=817 comm="systemd-random-" name="crash"
dev="nvme0n1p2" ino=50789805 scontext=system_u:system_r:init_t:s0
tcontext=system_u:object_r:kdump_crash_t:s0 tclass=dir permissive=0
[   13.306030] plymouth[853]: segfault at 0 ip 00007f2eabca8090 sp
00007fffe94d8c08 error 6 in libc-2.28.so[7f2eabbcd000+1b9000]
[   13.318772] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00
[   78.782418] sed[911]: segfault at 0 ip 00007fc3540da090 sp
00007ffdb4373ff8 error 6 in libc-2.28.so[7fc353fff000+1b9000]
[   78.794007] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00
--------------dmesg ends here-----------

-- 
Jianxiong Gao
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
