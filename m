Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95709C433EF
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 14:47:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2444B60B30;
	Fri, 24 Jun 2022 14:47:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2444B60B30
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hk79lsm3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C-StuIxEBQp2; Fri, 24 Jun 2022 14:47:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 95E8760B22;
	Fri, 24 Jun 2022 14:47:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 95E8760B22
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C324C0039;
	Fri, 24 Jun 2022 14:47:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6846C002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 14:47:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8FD974176C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 14:47:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8FD974176C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hk79lsm3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ahi1KE6BqVlb for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 14:47:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AEBDE4175E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AEBDE4175E
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656082059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=56kxpmdsfng9SmPwULsxX/tNoTTIqn2VJXkxLEHFluw=;
 b=hk79lsm3AR+J8CWRn/x7xoSe41w6hL8sWrkXSU+NRHMS+4D9R+j4bKParF+QpUDkz4NeOT
 6wfLQBaZwVPELnMJyqcxHjbtWqNVjVK7u6hAaT/v7Y+u3xmbye1dSkMUL1GQnnues0Qmq9
 4ICaSyOghaAgKXCqlqcKq6DhihekDGc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-SBBaueM_Nq27UqzqjBmIRg-1; Fri, 24 Jun 2022 10:47:37 -0400
X-MC-Unique: SBBaueM_Nq27UqzqjBmIRg-1
Received: by mail-pf1-f199.google.com with SMTP id
 by4-20020a056a00400400b005251029fd97so1364750pfb.9
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 07:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=56kxpmdsfng9SmPwULsxX/tNoTTIqn2VJXkxLEHFluw=;
 b=7l1HazK2V3JjPDkjB1fTP/DFbRy+GOOT6iSwzTbPEMkR2YgYIb4zDTes7pr5qrTE20
 lKtDPEbqCUTTBtr38tcn1hf2BiE0r3GqR6N7K/4A+YRMqi6TzSNF87jL0fRX+Vi7uvIe
 GoaZZb7QxuxrRKsCqeiC3CnHaw2vtgzoTjBPSPSKDxeHDNzZAhDrlYTs1TlBljrAS1f1
 YwdCnvKOqD7dh41GnLNqhHzXkcGcke3zQUuMTiGFeaXnK0BJa8he1RpNSyj+RK6/R+FJ
 22/axQUDuBdnJNq8nFvNt5rofRy4KVlMXKhMqlL8fx4X1sH915cauacOpEX6hI0Aq8pe
 9mQg==
X-Gm-Message-State: AJIora8zsJCMP1SSpP5AV9PJ9+UcCMac6xK8jbT94jqilO5V0Nm5wq1H
 ggRb74K+kbXTEc77canC9eV538wyMkgrjDjRctb74ToWF3J0d0csrog5WZVBmen9P7129NK/ysz
 WrO4Vh68jcuStNGKXc6b+kgnsK/icvQ==
X-Received: by 2002:a63:5a13:0:b0:3c6:3d28:87e5 with SMTP id
 o19-20020a635a13000000b003c63d2887e5mr12615279pgb.452.1656082052567; 
 Fri, 24 Jun 2022 07:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uIljnNmnjkK85u0cwvJPEXY1fkQCt41EvjeoiKywRzDmWQy3ebTKUMu6VyrB+AuCzw1cAhEw==
X-Received: by 2002:a63:5a13:0:b0:3c6:3d28:87e5 with SMTP id
 o19-20020a635a13000000b003c63d2887e5mr12615239pgb.452.1656082052154; 
 Fri, 24 Jun 2022 07:47:32 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id
 w185-20020a6262c2000000b0052523f7050bsm1813051pfb.118.2022.06.24.07.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jun 2022 07:47:31 -0700 (PDT)
Date: Fri, 24 Jun 2022 07:47:30 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: iommu_sva_bind_device question
Message-ID: <20220624144730.a6ork4dbjixnfhbf@cantor>
References: <20220623170232.6whonfjuh3m5vcoy@cantor>
 <6639b21c-1544-a025-4da5-219a1608f06e@linux.intel.com>
 <20220624011446.2bexm4sjo2vabay5@cantor>
 <552074ff-fd32-8cdb-cc10-1d71319c71db@linux.intel.com>
 <20220624134102.qxid72gqghjhyozn@cantor>
MIME-Version: 1.0
In-Reply-To: <20220624134102.qxid72gqghjhyozn@cantor>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org,
 Dave Jiang <dave.jiang@intel.com>
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

On Fri, Jun 24, 2022 at 06:41:02AM -0700, Jerry Snitselaar wrote:
> On Fri, Jun 24, 2022 at 09:43:30AM +0800, Baolu Lu wrote:
> > On 2022/6/24 09:14, Jerry Snitselaar wrote:
> > > On Fri, Jun 24, 2022 at 08:55:08AM +0800, Baolu Lu wrote:
> > > > On 2022/6/24 01:02, Jerry Snitselaar wrote:
> > > > > Hi Baolu & Dave,
> > > > > 
> > > > > I noticed last night that on a Sapphire Rapids system if you boot without
> > > > > intel_iommu=on, the idxd driver will crash during probe in iommu_sva_bind_device().
> > > > > Should there be a sanity check before calling dev_iommu_ops(), or is the expectation
> > > > > that the caller would verify it is safe to call? This seemed to be uncovered by
> > > > > the combination of 3f6634d997db ("iommu: Use right way to retrieve iommu_ops"), and
> > > > > 42a1b73852c4 ("dmaengine: idxd: Separate user and kernel pasid enabling").
> > > > > 
> > > > > [   21.423729] BUG: kernel NULL pointer dereference, address: 0000000000000038
> > > > > [   21.445108] #PF: supervisor read access in kernel mode
> > > > > [   21.450912] #PF: error_code(0x0000) - not-present page
> > > > > [   21.456706] PGD 0
> > > > > [   21.459047] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > > > [   21.464004] CPU: 0 PID: 1420 Comm: kworker/0:3 Not tainted 5.19.0-0.rc3.27.eln120.x86_64 #1
> > > > > [   21.464011] Hardware name: Intel Corporation EAGLESTREAM/EAGLESTREAM, BIOS EGSDCRB1.SYS.0067.D12.2110190954 10/19/2021
> > > > > [   21.464015] Workqueue: events work_for_cpu_fn
> > > > > [   21.464030] RIP: 0010:iommu_sva_bind_device+0x1d/0xe0
> > > > > [   21.464046] Code: c3 cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56 49 89 d6 41 55 41 54 55 53 48 83 ec 08 48 8b 87 d8 02 00 00 <48> 8b 40 38 48 8b 50 10 48 83 7a 70 00 48 89 14 24 0f 84 91 00 00
> > > > > [   21.464050] RSP: 0018:ff7245d9096b7db8 EFLAGS: 00010296
> > > > > [   21.464054] RAX: 0000000000000000 RBX: ff1eadeec8a51000 RCX: 0000000000000000
> > > > > [   21.464058] RDX: ff7245d9096b7e24 RSI: 0000000000000000 RDI: ff1eadeec8a510d0
> > > > > [   21.464060] RBP: ff1eadeec8a51000 R08: ffffffffb1a12300 R09: ff1eadffbfce25b4
> > > > > [   21.464062] R10: ffffffffffffffff R11: 0000000000000038 R12: ffffffffc09f8000
> > > > > [   21.464065] R13: ff1eadeec8a510d0 R14: ff7245d9096b7e24 R15: ff1eaddf54429000
> > > > > [   21.464067] FS:  0000000000000000(0000) GS:ff1eadee7f600000(0000) knlGS:0000000000000000
> > > > > [   21.464070] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > [   21.464072] CR2: 0000000000000038 CR3: 00000008c0e10006 CR4: 0000000000771ef0
> > > > > [   21.464074] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > [   21.464076] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> > > > > [   21.464078] PKRU: 55555554
> > > > > [   21.464079] Call Trace:
> > > > > [   21.464083]  <TASK>
> > > > > [   21.464092]  idxd_pci_probe+0x259/0x1070 [idxd]
> > > > > [   21.464121]  local_pci_probe+0x3e/0x80
> > > > > [   21.464132]  work_for_cpu_fn+0x13/0x20
> > > > > [   21.464136]  process_one_work+0x1c4/0x380
> > > > > [   21.464143]  worker_thread+0x1ab/0x380
> > > > > [   21.464147]  ? _raw_spin_lock_irqsave+0x23/0x50
> > > > > [   21.464158]  ? process_one_work+0x380/0x380
> > > > > [   21.464161]  kthread+0xe6/0x110
> > > > > [   21.464168]  ? kthread_complete_and_exit+0x20/0x20
> > > > > [   21.464172]  ret_from_fork+0x1f/0x30
> > > > > 
> > > > > I figure either there needs to be a check in iommu_sva_bind_device, or
> > > > > idxd needs to check in idxd_enable_system_pasid that that
> > > > > idxd->pdev->dev.iommu is not null before it tries calling iommu_sva_bind_device.
> > > > 
> > > > As documented around the iommu_sva_bind_device() interface:
> > > > 
> > > >   * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first,
> > > > to
> > > >   * initialize the required SVA features.
> > > > 
> > > > idxd->pdev->dev.iommu should be checked in there.
> > > > 
> > > > Dave, any thoughts?
> > > > 
> > > > Best regards,
> > > > baolu
> > > 
> > > Duh, sorry I missed that in the comments.
> > > 
> > > It calls iommu_dev_enable_feature(), but then goes into code that
> > > calls iommu_sva_bind_device whether or not iommu_dev_enable_feature()
> > > fails.
> > > 
> > > You also will get the following warning if you don't have scalable
> > > mode enabled (either not enabled by default, or if enabled by default
> > > and passed intel_iommu=on,sm_off):
> > 
> > If scalable mode is disabled, iommu_dev_enable_feature(IOMMU_SVA) will
> > return failure, hence driver should not call iommu_sva_bind_device().
> > I guess below will disappear if above is fixed in the idxd driver.
> > 
> > Best regards,
> > baolu
> >
> 
> It looks like there was a recent maintainer change, and Fenghua is now
> the maintainer. Fenghua thoughts on this? With 42a1b73852c4
> ("dmaengine: idxd: Separate user and kernel pasid enabling") the code
> no longer depends on iommu_dev_feature_enable succeeding. Testing with
> something like this works (ran dmatest without sm_on, and
> dsa_user_test_runner.sh with sm_on, plus booting with various
> intel_iommu= combinations):
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 355fb3ef4cbf..5b49fd5c1e25 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -514,13 +514,14 @@ static int idxd_probe(struct idxd_device *idxd)
>         if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
>                 if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA))
>                         dev_warn(dev, "Unable to turn on user SVA feature.\n");
> -               else
> +               else {
>                         set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
> 
> -               if (idxd_enable_system_pasid(idxd))
> -                       dev_warn(dev, "No in-kernel DMA with PASID.\n");
> -               else
> -                       set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> +                       if (idxd_enable_system_pasid(idxd))
> +                               dev_warn(dev, "No in-kernel DMA with PASID.\n");
> +                       else
> +                               set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> +               }
>         } else if (!sva) {
>                 dev_warn(dev, "User forced SVA off via module param.\n");
>         }
> 
> The commit description is a bit confusing, because it talks about there
> being no dependency, but ties user pasid to enabling/disabling the SVA
> feature, which system pasid would depend on as well.
> 
> Regards,
> Jerry

Things like that warning message "Unable to turn on user SVA feature" when
iommu_dev_enable_feature fails though seems to be misleading with user
inserted in there. I'll leave it to the idxd folks to figure out.


> 
> > > 
> > > [   24.645784] idxd 0000:6a:01.0: enabling device (0144 -> 0146)
> > > [   24.645871] idxd 0000:6a:01.0: Unable to turn on user SVA feature.
> > > [   24.645932] ------------[ cut here ]------------
> > > [   24.645935] WARNING: CPU: 0 PID: 422 at drivers/iommu/intel/pasid.c:253 intel_pasid_get_entry.isra.0+0xcd/0xe0
> > > [   24.675872] Modules linked in: intel_uncore(+) drm_ttm_helper isst_if_mbox_pci(+) idxd(+) snd i2c_i801(+) isst_if_mmio ttm isst_if_common mei fjes(+) soundcore intel_vsec i2c_ismt i2c_smbus idxd_bus ipmi_ssif acpi_ipmi ipmi_si acpi_pad acpi_power_meter pfr_telemetry pfr_update vfat fat fuse xfs crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel igc wmi pinctrl_emmitsburg ipmi_devintf ipmi_msghandler
> > > [   24.716612] CPU: 0 PID: 422 Comm: kworker/0:2 Not tainted 5.19.0-0.rc3.27.eln120.x86_64 #1
> > > [   24.716621] Hardware name: Intel Corporation EAGLESTREAM/EAGLESTREAM, BIOS EGSDCRB1.SYS.0067.D12.2110190954 10/19/2021
> > > [   24.716625] Workqueue: events work_for_cpu_fn
> > > [   24.716645] RIP: 0010:intel_pasid_get_entry.isra.0+0xcd/0xe0
> > > [   24.716656] Code: a9 d1 ff ff 48 89 c7 48 85 c0 75 9e 31 c0 5b 5d 41 5c 41 5d c3 cc 41 83 e4 3f 5b 5d 49 c1 e4 06 4a 8d 04 27 41 5c 41 5d c3 cc <0f> 0b 31 c0 eb de 48 8b 05 e6 dd 59 01 eb 87 0f 1f 40 00 0f 1f 44
> > > [   24.716664] RSP: 0018:ff848155c79bfd00 EFLAGS: 00010046
> > > [   24.716671] RAX: 0000000000000206 RBX: ff3deaf807bfdcc0 RCX: 0000000000000001
> > > [   24.716677] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ff3deb0789f53240
> > > [   24.716682] RBP: ff3deb0789f53780 R08: 0000000000000001 R09: 0000000000000003
> > > [   24.716688] R10: ff848155c79bfcf8 R11: 0000000000000000 R12: 0000000000000003
> > > [   24.716693] R13: 0000000000000001 R14: 0000000000000001 R15: ffffffff84e10000
> > > [   24.716700] FS:  0000000000000000(0000) GS:ff3deb073f600000(0000) knlGS:0000000000000000
> > > [   24.716705] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   24.716709] CR2: 0000558a19e81c58 CR3: 0000000108252005 CR4: 0000000000771ef0
> > > [   24.716714] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > [   24.716719] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> > > [   24.716723] PKRU: 55555554
> > > [   24.716726] Call Trace:
> > > [   24.716731]  <TASK>
> > > [   24.716738]  intel_pasid_setup_first_level+0x36/0x200
> > > [   24.716753]  intel_svm_bind+0x2f8/0x3a0
> > > [   24.716767]  iommu_sva_bind_device+0x9b/0xe0
> > > [   24.716785]  idxd_pci_probe+0x259/0x1070 [idxd]
> > > [   24.716866]  local_pci_probe+0x3e/0x80
> > > [   24.716890]  work_for_cpu_fn+0x13/0x20
> > > [   24.716900]  process_one_work+0x1c4/0x380
> > > [   24.716912]  worker_thread+0x1ab/0x380
> > > [   24.716922]  ? _raw_spin_lock_irqsave+0x23/0x50
> > > [   24.716945]  ? process_one_work+0x380/0x380
> > > [   24.716954]  kthread+0xe6/0x110
> > > [   24.716967]  ? kthread_complete_and_exit+0x20/0x20
> > > [   24.716976]  ret_from_fork+0x1f/0x30
> > > [   24.716999]  </TASK>
> > > [   24.717000] ---[ end trace 0000000000000000 ]---
> > > [   24.717019] ------------[ cut here ]------------
> > > 
> > > regards,
> > > Jerry
> > > 
> > 
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
