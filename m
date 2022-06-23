Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0ADC43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 17:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D9AB94057C;
	Thu, 23 Jun 2022 17:02:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D9AB94057C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K8EDHTmb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H56flszI9Vlq; Thu, 23 Jun 2022 17:02:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 72DBF40187;
	Thu, 23 Jun 2022 17:02:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 72DBF40187
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3667CC0039;
	Thu, 23 Jun 2022 17:02:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7191DC002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 17:02:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B3C683E6D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 17:02:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B3C683E6D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=K8EDHTmb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tr-Z8L7I7xkt for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 17:02:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6669D83E3B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6669D83E3B
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 17:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656003757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=IR8O3ARrPXy5UZ3fHDm5YYAHxa9WEtwzHh6wS82OFpM=;
 b=K8EDHTmbUKqoaIDVPDypQmiIK/A++Lz0SAoWx8p2F4suoN7tB/+moVJuugPWu88kgXOrqI
 kj7QiCW/hMAOwrdC/bFQt4isf+serSZkILiU0tED65sakwkHrEdBXy9I8DQvWglZx+BMpX
 akDygob6b7gBKZza2GxBIrrL7Schlpg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-NG4xDCYWNqyY4nDKMZLlbw-1; Thu, 23 Jun 2022 13:02:35 -0400
X-MC-Unique: NG4xDCYWNqyY4nDKMZLlbw-1
Received: by mail-pj1-f69.google.com with SMTP id
 ob5-20020a17090b390500b001e2f03294a7so1506823pjb.8
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 10:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=IR8O3ARrPXy5UZ3fHDm5YYAHxa9WEtwzHh6wS82OFpM=;
 b=tUvexzFzX6LL+YfzySw62oDgh4AffYuCVpBybV3cOjpUMRmqZPr09+iUpiYSCxR6J8
 bqPJjHZmgBB4Q8tUZ5JXItgMjDWWUu4moMZORA7eepv4c28c022e79/Ewxwa3YPcD3nY
 2N+jgy5LTj+xW+vdBA+uE66yTogDjas2WJO5OzWmrunZf4N0HIB3So3aCfEFxjG8P80p
 VyfqbNA8hTBOtMbgJ0UJt6vVo7r14q+vGCVPm01he67LB8H3sVsj86QfDhXO8QQsLtig
 GEf4D9T5Zq5mzfDSxOISim+ATnM6/1JZCFoJ6/MZZV6akXdhABtNEvoIZbT9UkHhhKQ1
 X9UQ==
X-Gm-Message-State: AJIora8ZuWghDrfWVm5gmGQB7QWPuA+diKgxk6BiOXZxIQURAh7H2wij
 6k2kbGgHA3P/PcEQZ6zLXiTwtmyZxBbLTjB97M1f21njruH+rSF8iMZkoYCT6s7n4hQN8UVfDm/
 FWgPHnx5/FKbzzrKmOGmYZd/vmg7f9p4leihh15rKiUAQd2jjYcSyxB3jAA4dKCRor0B60QduYi
 lB/5sFtw==
X-Received: by 2002:a63:f10c:0:b0:40d:4029:b250 with SMTP id
 f12-20020a63f10c000000b0040d4029b250mr5853868pgi.328.1656003754091; 
 Thu, 23 Jun 2022 10:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t32oGQD1jOIEgAPJa90gLIgCSFoyKow73Dl4iQEH39ebjQS6/y3aJremfFdbXM2ZYYUVYdMw==
X-Received: by 2002:a63:f10c:0:b0:40d:4029:b250 with SMTP id
 f12-20020a63f10c000000b0040d4029b250mr5853835pgi.328.1656003753578; 
 Thu, 23 Jun 2022 10:02:33 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a170902710400b0016a1c61c603sm32103pll.154.2022.06.23.10.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jun 2022 10:02:33 -0700 (PDT)
Date: Thu, 23 Jun 2022 10:02:32 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux-foundation.org, Lu Baolu <baolu.lu@linux.intel.com>,
 Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org
Subject: iommu_sva_bind_device question
Message-ID: <20220623170232.6whonfjuh3m5vcoy@cantor>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Baolu & Dave,

I noticed last night that on a Sapphire Rapids system if you boot without
intel_iommu=on, the idxd driver will crash during probe in iommu_sva_bind_device().
Should there be a sanity check before calling dev_iommu_ops(), or is the expectation
that the caller would verify it is safe to call? This seemed to be uncovered by
the combination of 3f6634d997db ("iommu: Use right way to retrieve iommu_ops"), and
42a1b73852c4 ("dmaengine: idxd: Separate user and kernel pasid enabling").

[   21.423729] BUG: kernel NULL pointer dereference, address: 0000000000000038 
[   21.445108] #PF: supervisor read access in kernel mode 
[   21.450912] #PF: error_code(0x0000) - not-present page 
[   21.456706] PGD 0  
[   21.459047] Oops: 0000 [#1] PREEMPT SMP NOPTI 
[   21.464004] CPU: 0 PID: 1420 Comm: kworker/0:3 Not tainted 5.19.0-0.rc3.27.eln120.x86_64 #1 
[   21.464011] Hardware name: Intel Corporation EAGLESTREAM/EAGLESTREAM, BIOS EGSDCRB1.SYS.0067.D12.2110190954 10/19/2021 
[   21.464015] Workqueue: events work_for_cpu_fn 
[   21.464030] RIP: 0010:iommu_sva_bind_device+0x1d/0xe0 
[   21.464046] Code: c3 cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56 49 89 d6 41 55 41 54 55 53 48 83 ec 08 48 8b 87 d8 02 00 00 <48> 8b 40 38 48 8b 50 10 48 83 7a 70 00 48 89 14 24 0f 84 91 00 00 
[   21.464050] RSP: 0018:ff7245d9096b7db8 EFLAGS: 00010296 
[   21.464054] RAX: 0000000000000000 RBX: ff1eadeec8a51000 RCX: 0000000000000000 
[   21.464058] RDX: ff7245d9096b7e24 RSI: 0000000000000000 RDI: ff1eadeec8a510d0 
[   21.464060] RBP: ff1eadeec8a51000 R08: ffffffffb1a12300 R09: ff1eadffbfce25b4 
[   21.464062] R10: ffffffffffffffff R11: 0000000000000038 R12: ffffffffc09f8000 
[   21.464065] R13: ff1eadeec8a510d0 R14: ff7245d9096b7e24 R15: ff1eaddf54429000 
[   21.464067] FS:  0000000000000000(0000) GS:ff1eadee7f600000(0000) knlGS:0000000000000000 
[   21.464070] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
[   21.464072] CR2: 0000000000000038 CR3: 00000008c0e10006 CR4: 0000000000771ef0 
[   21.464074] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 
[   21.464076] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400 
[   21.464078] PKRU: 55555554 
[   21.464079] Call Trace: 
[   21.464083]  <TASK> 
[   21.464092]  idxd_pci_probe+0x259/0x1070 [idxd] 
[   21.464121]  local_pci_probe+0x3e/0x80 
[   21.464132]  work_for_cpu_fn+0x13/0x20 
[   21.464136]  process_one_work+0x1c4/0x380 
[   21.464143]  worker_thread+0x1ab/0x380 
[   21.464147]  ? _raw_spin_lock_irqsave+0x23/0x50 
[   21.464158]  ? process_one_work+0x380/0x380 
[   21.464161]  kthread+0xe6/0x110 
[   21.464168]  ? kthread_complete_and_exit+0x20/0x20 
[   21.464172]  ret_from_fork+0x1f/0x30

I figure either there needs to be a check in iommu_sva_bind_device, or
idxd needs to check in idxd_enable_system_pasid that that
idxd->pdev->dev.iommu is not null before it tries calling iommu_sva_bind_device.

Regards,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
