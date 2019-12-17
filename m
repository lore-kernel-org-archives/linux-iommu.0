Return-Path: <SRS0=3Hz1=2H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24F5C43603
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 20:50:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23972146E
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 20:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZJi5kGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23972146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 729848756D;
	Tue, 17 Dec 2019 20:50:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cXNwcFCUMcG2; Tue, 17 Dec 2019 20:50:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1389886E6A;
	Tue, 17 Dec 2019 20:50:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB29EC1AE8;
	Tue, 17 Dec 2019 20:50:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C25A6C077D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 20:50:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AA5E2204D4
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 20:50:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lYcJ-PKvmkDG for <iommu@lists.linux-foundation.org>;
 Tue, 17 Dec 2019 20:50:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id D1A0020452
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 20:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576615801;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=J73YVZfMxZAcikPu3TQX3XB3CLXiyf6r8SXyDPM2a/Q=;
 b=NZJi5kGx134qHbNoJ4n6jjWQmYY75BmORKtJBKaOb0K8WXFQnQRndcskqOmxcg9cNJeZfA
 fyIMmZhDt9XgIogxWawF+f9G+PZWMEkxzfg1p7jOMprYC/PzwNcevc7Bo149RS+DTenwW4
 8pXLrXHQj/8T/XdiOz9mAVOlwbtJgDM=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-4_raT3kBNuiAIf-7ey4WAg-1; Tue, 17 Dec 2019 15:50:00 -0500
Received: by mail-yb1-f199.google.com with SMTP id y204so7978039yby.18
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 12:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=J73YVZfMxZAcikPu3TQX3XB3CLXiyf6r8SXyDPM2a/Q=;
 b=BQpDaK+YgFXdzrS294UWoDxIXw3Usas4q7cSjaqMAS/dL5vIHoSLmgEZEfEwudS3RO
 NcGZDOxVJ21knNDUZkQOjAt7STjNjMpO64kimMShb8YvmPZ1eDKB4+ujTvbKXSZmeYea
 sbZM+CCL9puN8P0bM6hkCJJkhxou6hhSttsZRM70g4b+PSRGpGaBmQswJ2srcY9asEXp
 cV8ll8LUT0pv7yn5OBxDQNHIVzUIOMEY8aOSHveZd5nexCotuKoMCBcP8ngvwyGYiYK6
 lsxx3femTwjG8uCeLaSQBgaoxJxlbG2enkuASTWEQXPBwuXuzXL3S1lTvuXkLuIv9Msw
 tNqg==
X-Gm-Message-State: APjAAAWYT4/Q7fVi2k/hNz83QPPx68ZVDHNZGdKHqF6yOzvZ8Eca6WgI
 7UjX5JBa4iC9hdSYETctX9ZvuDCtwiahVrhhIfkdyQ894sOKZUmbxuIJ+RRZ0YF1kTpTYmx0ypI
 Jq1mgArp5xAvDw94Y6YbJna5o83oYKg==
X-Received: by 2002:a81:a7c3:: with SMTP id e186mr544964ywh.7.1576615799114;
 Tue, 17 Dec 2019 12:49:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqw2euIojC/x9hatXJUaQw8cCQt9qSXTwZErl80ZyUUPVkzXxI5EZizUVgOUgo9pf9yiFFJMOw==
X-Received: by 2002:a81:a7c3:: with SMTP id e186mr544945ywh.7.1576615798795;
 Tue, 17 Dec 2019 12:49:58 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id 144sm7031975ywy.20.2019.12.17.12.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 12:49:58 -0800 (PST)
Date: Tue, 17 Dec 2019 13:49:48 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Joerg Roedel <jroedel@suse.de>,
 David Woodhouse <dwmw2@infradead.org>, stable@vger.kernel.org
Subject: Re: [RFC PATCH] iommu/vt-d: avoid panic in __dmar_remove_one_dev_info
Message-ID: <20191217204948.p6pgnls2rrlr2nnk@cantor>
Mail-Followup-To: linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 David Woodhouse <dwmw2@infradead.org>, stable@vger.kernel.org
References: <20191217175542.22187-1-jsnitsel@redhat.com>
 <20191217203954.6xfaw5jto75q4nxm@cantor>
MIME-Version: 1.0
In-Reply-To: <20191217203954.6xfaw5jto75q4nxm@cantor>
X-MC-Unique: 4_raT3kBNuiAIf-7ey4WAg-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
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
>On Tue Dec 17 19, Jerry Snitselaar wrote:
>>In addition to checking for a null pointer, verify that
>>info does not have the value DEFER_DEVICE_DOMAIN_INFO or
>>DUMMY_DEVICE_DOMAIN_INFO. If info has one of those values
>>__dmar_remove_one_dev_info will panic when trying to access
>>a member of the device_domain_info struct.
>>
>>   [    1.464241] BUG: unable to handle kernel NULL pointer dereference at 000000000000004e
>>   [    1.464241] PGD 0 P4D 0
>>   [    1.464241] Oops: 0000 [#1] SMP PTI
>>   [    1.464241] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W        --------- -  - 4.18.0-160.el8.x86_64 #1
>>   [    1.464241] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 07/21/2019
>>   [    1.464241] RIP: 0010:__dmar_remove_one_dev_info+0x27/0x250
>>   [    1.464241] Code: 00 00 00 0f 1f 44 00 00 8b 05 35 ec 75 01 41 56 41 55 41 54 55 53 85 c0 0f 84 99 01 00 00 48 85 ff 0f 84 92 01 00 00 48 89 fb <4c> 8b 67 50 48 8b 6f 58 $
>>   [    1.464241] RSP: 0000:ffffc900000dfd10 EFLAGS: 00010082
>>   [    1.464241] RAX: 0000000000000001 RBX: fffffffffffffffe RCX: 0000000000000000
>>   [    1.464241] RDX: 0000000000000001 RSI: 0000000000000004 RDI: fffffffffffffffe
>>   [    1.464241] RBP: ffff88ec7a72f368 R08: 0000000000000457 R09: 0000000000000039
>>   [    1.464241] R10: 0000000000000000 R11: ffffc900000dfa58 R12: ffff88ec7a0eec20
>>   [    1.464241] R13: ffff88ec6fd0eab0 R14: ffffffff81eae980 R15: 0000000000000000
>>   [    1.464241] FS:  0000000000000000(0000) GS:ffff88ec7a600000(0000) knlGS:0000000000000000
>>   [    1.464241] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   [    1.464241] CR2: 000000000000004e CR3: 0000006c7900a001 C 00000000001606b0
>>   [    1.464241] Call Trace:
>>   [    1.464241]  dmar_remove_one_dev_info.isra.68+0x27/0x40
>>   [    1.464241]  intel_iommu_add_device+0x124/0x180
>>   [    1.464241]  ? iommu_probe_device+0x40/0x40
>>   [    1.464241]  add_iommu_group+0xa/0x20
>>   [    1.464241]  bus_for_each_dev+0x77/0xc0
>>   [    1.464241]  ? down_write+0xe/0x40
>>   [    1.464241]  bus_set_iommu+0x85/0xc0
>>   [    1.464241]  intel_iommu_init+0x4b4/0x777
>>   [    1.464241]  ? e820__memblock_setup+0x63/0x63
>>   [    1.464241]  ? do_early_param+0x91/0x91
>>   [    1.464241]  pci_iommu_init+0x19/0x45
>>   [    1.464241]  do_one_initcall+0x46/0x1c3
>>   [    1.464241]  ? do_early_param+0x91/0x91
>>   [    1.464241]  kernel_init_freeable+0x1af/0x258
>>   [    1.464241]  ? rest_init+0xaa/0xaa
>>   [    1.464241]  kernel_init+0xa/0x107
>>   [    1.464241]  ret_from_fork+0x35/0x40
>>   [    1.464241] Modules linked in:
>>   [    1.464241] CR2: 000000000000004e
>>   [    1.464241] ---[ end trace 0927d2ba8b8032b5 ]---
>>
>>Cc: Joerg Roedel <jroedel@suse.de>
>>Cc: Lu Baolu <baolu.lu@linux.intel.com>
>>Cc: David Woodhouse <dwmw2@infradead.org>
>>Cc: stable@vger.kernel.org # v5.3+
>>Cc: iommu@lists.linux-foundation.org
>>Fixes: ae23bfb68f28 ("iommu/vt-d: Detach domain before using a private one")
>>Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>>---
>>drivers/iommu/intel-iommu.c | 3 ++-
>>1 file changed, 2 insertions(+), 1 deletion(-)
>>
>>diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>index 0c8d81f56a30..e42a09794fa2 100644
>>--- a/drivers/iommu/intel-iommu.c
>>+++ b/drivers/iommu/intel-iommu.c
>>@@ -5163,7 +5163,8 @@ static void dmar_remove_one_dev_info(struct device *dev)
>>
>>	spin_lock_irqsave(&device_domain_lock, flags);
>>	info = dev->archdata.iommu;
>>-	if (info)
>>+	if (info && info != DEFER_DEVICE_DOMAIN_INFO
>>+	    && info != DUMMY_DEVICE_DOMAIN_INFO)
>>		__dmar_remove_one_dev_info(info);
>>	spin_unlock_irqrestore(&device_domain_lock, flags);
>>}
>>-- 
>>2.24.0
>>
>>_______________________________________________
>>iommu mailing list
>>iommu@lists.linux-foundation.org
>>https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>
>
>Nack this.
>
>Apparently the issue is just being seen with the kdump kernel.  I'm
>wondering if it is already solved by 6c3a44ed3c55 ("iommu/vt-d: Turn
>off translations at shutdown").  Testing a 5.5 build now.

And a minute later I got a response. The 5.5 kernel hits the original
panic when booting into the kdump kernel.

I need to test with this patch on 5.5, but with a test build of our
kernel with this patch the problem just moves to:

[    3.742317] pci 0000:01:00.0: Using iommu dma mapping
[    3.744020] pci 0000:01:00.1: Adding to iommu group 86
[    3.746697] NMI watchdog: Watchdog detected hard LOCKUP on cpu 0Modules linked in:
[    3.746697] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.0-167.el8.iommu6.x86_64 #1
[    3.746697] Hardware name: HP ProLiant DL560 Gen9/ProLiant DL560 Gen9, BIOS P85 07/21/2019
[    3.746697] RIP: 0010:native_queued_spin_lock_slowpath+0x5d/0x1d0
[    3.746697] Code: 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 47 85 c$
[    3.746697] RSP: 0000:ffffc900000f3bd8 EFLAGS: 00000002
[    3.746697] RAX: 0000000000000101 RBX: 0000000000000046 RCX: ffff88887f170000
[    3.746697] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff82e8a600
[    3.746697] RBP: ffff88886fd0ec00 R08: 0000000000000004 R09: ffffc900000f3b94
[    3.746697] R10: 0000000000000001 R11: ffff88887a4e3200 R12: ffff88887cbf6540
[    3.746697] R13: 0000000000000001 R14: ffff88887a4e3480 R15: 0000000000000001
[    3.746697] FS:  0000000000000000(0000) GS:ffff88887f600000(0000) knlGS:0000000000000000
[    3.746697] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.746697] CR2: 0000000000000000 CR3: 000000087de0a001 CR4: 00000000003606b0
[    3.746697] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    3.746697] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    3.746697] Call Trace:
[    3.746697]  _raw_spin_lock_irqsave+0x32/0x40
[    3.746697]  dmar_insert_one_dev_info+0xa3/0x4d0     
[    3.746697]  ? free_unref_page_commit+0x91/0x100
[    3.746697]  ? device_to_iommu+0x1a3/0x220
[    3.746697]  domain_add_dev_info+0x50/0x90
[    3.746697]  intel_iommu_attach_device+0xb7/0x140
[    3.746697]  find_domain+0x41/0x60
[    3.746697]  dmar_insert_one_dev_info+0xaf/0x4d0
[    3.746697]  ? device_to_iommu+0x1a3/0x220
[    3.746697]  domain_add_dev_info+0x50/0x90
[    3.746697]  intel_iommu_add_device+0x137/0x180
[    3.746697]  ? iommu_probe_device+0x40/0x
[    3.746697]  add_iommu_group+0xa/0x20
[    3.746697]  bus_for_each_dev+0x77/0xc0
[    3.746697]  ? down_write+0xe/0x40
[    3.746697]  bus_set_iommu+0x85/0xc0
[    3.746697]  intel_iommu_init+0x4b4/0x777
[    3.746697]  ? e820__memblock_setup+0x63/0x63
[    3.746697]  ? do_early_param+0x91/0x91
[    3.746697]  pci_iommu_init+0x19/0x45
[    3.746697]  do_one_initcall+0x46/0x1c3
[    3.746697]  ? do_early_param+0x91/0x91
[    3.746697]  kernel_init_freeable+0x1af/0x258
[    3.746697]  ? rest_init+0xaa/0xaa
[    3.746697]  kernel_init+0xa/0x103
[    3.746697]  ret_from_fork+0x35/0x40

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
