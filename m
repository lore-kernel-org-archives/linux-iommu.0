Return-Path: <SRS0=3Hz1=2H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AA3C2D0CD
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 20:40:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A244F21582
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 20:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ocv21ogc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A244F21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7E9D386CC7;
	Tue, 17 Dec 2019 20:40:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tj+kDfrCftTZ; Tue, 17 Dec 2019 20:40:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9C61F86ACB;
	Tue, 17 Dec 2019 20:40:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 851F0C1AE8;
	Tue, 17 Dec 2019 20:40:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 587E0C077D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 20:40:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4372286546
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 20:40:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sWlAA06tjkm9 for <iommu@lists.linux-foundation.org>;
 Tue, 17 Dec 2019 20:40:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6ACC186505
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 20:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576615200;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3pm/HT4ZIaGozPB6mMkf61xkwKmu8TGFcOacsu4Vtco=;
 b=Ocv21ogclqElU/RHCOPFcyCSVHglN2PlFcCwp2//wV6Mw6+L5z930DSBX93luR1+Eu3WjM
 OnWuCo50TMI48d7xK917Yg/x8fjxhvl90rWndG5uLX+n+Tt52t9ZYy9vo5FoW+sHT7gfgR
 2Idexy1GmdJ02mmg46efQIys1lpdqfA=
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80--0i3hPr5O5C98SYyCV7FkQ-1; Tue, 17 Dec 2019 15:39:57 -0500
Received: by mail-yw1-f70.google.com with SMTP id 16so9109623ywz.5
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 12:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=3pm/HT4ZIaGozPB6mMkf61xkwKmu8TGFcOacsu4Vtco=;
 b=NIwCPTpIvHykG1TkVcHhzF/T7l3SntXDLJK++6OVuBGMGw+qtcrulFiBnjIENBKo/G
 SElmE17gZkWe89iI3dbFdrRRrE4Ecb5CtDXpOputk3E/7s2kmfxW2bg7herHgqBzKS63
 GsbZv1mb70VgR9HmU5baWcLxoOlyEjZXDpfdJwdGt59wsi1SLlIK7xNHDZ/lweWlqjIt
 NXy2nUr+rzrGKwsrNyUdEMWX/1yEjkzQGCTZ2obyPm6rxCLcuNB+AD4aTGWiB/+AhVgl
 t+sdiTeivof/gCxO47Vc/FX+cRzrZ0RbDnhbI41xqnnmVrEZJ1sH1targBYpfsRNABlt
 dkHQ==
X-Gm-Message-State: APjAAAUW4+1u1xpvRzo1CyUVjd6dsvSAQCyyfcbR0qzvT+dPS5HVkPcE
 yOc/V0/H0GtnYRmZ3uFaYXmDX4a+owGHBv+paF7CVbUbEGiED6Ojj6sc9KfwqbOdCvgu1ph2HK0
 upoJ8exZJgetJIAeNlu+H5L5yGenZNg==
X-Received: by 2002:a81:230a:: with SMTP id j10mr461124ywj.485.1576615196725; 
 Tue, 17 Dec 2019 12:39:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxtU49wyAxi7xKA/49CEmgPcUA8/v4V+raPU1xTW68hh6vfM2yR6HVIizvmuD2T2ghrDKCWpQ==
X-Received: by 2002:a81:230a:: with SMTP id j10mr461105ywj.485.1576615196427; 
 Tue, 17 Dec 2019 12:39:56 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id e186sm10201174ywb.73.2019.12.17.12.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 12:39:55 -0800 (PST)
Date: Tue, 17 Dec 2019 13:39:54 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iommu/vt-d: avoid panic in __dmar_remove_one_dev_info
Message-ID: <20191217203954.6xfaw5jto75q4nxm@cantor>
Mail-Followup-To: linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 David Woodhouse <dwmw2@infradead.org>, stable@vger.kernel.org
References: <20191217175542.22187-1-jsnitsel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191217175542.22187-1-jsnitsel@redhat.com>
X-MC-Unique: -0i3hPr5O5C98SYyCV7FkQ-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 David Woodhouse <dwmw2@infradead.org>, stable@vger.kernel.org
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue Dec 17 19, Jerry Snitselaar wrote:
>In addition to checking for a null pointer, verify that
>info does not have the value DEFER_DEVICE_DOMAIN_INFO or
>DUMMY_DEVICE_DOMAIN_INFO. If info has one of those values
>__dmar_remove_one_dev_info will panic when trying to access
>a member of the device_domain_info struct.
>
>    [    1.464241] BUG: unable to handle kernel NULL pointer dereference at 000000000000004e
>    [    1.464241] PGD 0 P4D 0
>    [    1.464241] Oops: 0000 [#1] SMP PTI
>    [    1.464241] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W        --------- -  - 4.18.0-160.el8.x86_64 #1
>    [    1.464241] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 07/21/2019
>    [    1.464241] RIP: 0010:__dmar_remove_one_dev_info+0x27/0x250
>    [    1.464241] Code: 00 00 00 0f 1f 44 00 00 8b 05 35 ec 75 01 41 56 41 55 41 54 55 53 85 c0 0f 84 99 01 00 00 48 85 ff 0f 84 92 01 00 00 48 89 fb <4c> 8b 67 50 48 8b 6f 58 $
>    [    1.464241] RSP: 0000:ffffc900000dfd10 EFLAGS: 00010082
>    [    1.464241] RAX: 0000000000000001 RBX: fffffffffffffffe RCX: 0000000000000000
>    [    1.464241] RDX: 0000000000000001 RSI: 0000000000000004 RDI: fffffffffffffffe
>    [    1.464241] RBP: ffff88ec7a72f368 R08: 0000000000000457 R09: 0000000000000039
>    [    1.464241] R10: 0000000000000000 R11: ffffc900000dfa58 R12: ffff88ec7a0eec20
>    [    1.464241] R13: ffff88ec6fd0eab0 R14: ffffffff81eae980 R15: 0000000000000000
>    [    1.464241] FS:  0000000000000000(0000) GS:ffff88ec7a600000(0000) knlGS:0000000000000000
>    [    1.464241] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [    1.464241] CR2: 000000000000004e CR3: 0000006c7900a001 C 00000000001606b0
>    [    1.464241] Call Trace:
>    [    1.464241]  dmar_remove_one_dev_info.isra.68+0x27/0x40
>    [    1.464241]  intel_iommu_add_device+0x124/0x180
>    [    1.464241]  ? iommu_probe_device+0x40/0x40
>    [    1.464241]  add_iommu_group+0xa/0x20
>    [    1.464241]  bus_for_each_dev+0x77/0xc0
>    [    1.464241]  ? down_write+0xe/0x40
>    [    1.464241]  bus_set_iommu+0x85/0xc0
>    [    1.464241]  intel_iommu_init+0x4b4/0x777
>    [    1.464241]  ? e820__memblock_setup+0x63/0x63
>    [    1.464241]  ? do_early_param+0x91/0x91
>    [    1.464241]  pci_iommu_init+0x19/0x45
>    [    1.464241]  do_one_initcall+0x46/0x1c3
>    [    1.464241]  ? do_early_param+0x91/0x91
>    [    1.464241]  kernel_init_freeable+0x1af/0x258
>    [    1.464241]  ? rest_init+0xaa/0xaa
>    [    1.464241]  kernel_init+0xa/0x107
>    [    1.464241]  ret_from_fork+0x35/0x40
>    [    1.464241] Modules linked in:
>    [    1.464241] CR2: 000000000000004e
>    [    1.464241] ---[ end trace 0927d2ba8b8032b5 ]---
>
>Cc: Joerg Roedel <jroedel@suse.de>
>Cc: Lu Baolu <baolu.lu@linux.intel.com>
>Cc: David Woodhouse <dwmw2@infradead.org>
>Cc: stable@vger.kernel.org # v5.3+
>Cc: iommu@lists.linux-foundation.org
>Fixes: ae23bfb68f28 ("iommu/vt-d: Detach domain before using a private one")
>Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>---
> drivers/iommu/intel-iommu.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>index 0c8d81f56a30..e42a09794fa2 100644
>--- a/drivers/iommu/intel-iommu.c
>+++ b/drivers/iommu/intel-iommu.c
>@@ -5163,7 +5163,8 @@ static void dmar_remove_one_dev_info(struct device *dev)
>
> 	spin_lock_irqsave(&device_domain_lock, flags);
> 	info = dev->archdata.iommu;
>-	if (info)
>+	if (info && info != DEFER_DEVICE_DOMAIN_INFO
>+	    && info != DUMMY_DEVICE_DOMAIN_INFO)
> 		__dmar_remove_one_dev_info(info);
> 	spin_unlock_irqrestore(&device_domain_lock, flags);
> }
>-- 
>2.24.0
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

Nack this.

Apparently the issue is just being seen with the kdump kernel.  I'm
wondering if it is already solved by 6c3a44ed3c55 ("iommu/vt-d: Turn
off translations at shutdown").  Testing a 5.5 build now.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
