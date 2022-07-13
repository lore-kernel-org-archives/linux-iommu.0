Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DAD15A9
	for <iommu@lists.linux.dev>; Wed, 13 Jul 2022 05:58:43 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso1900192pjh.1
        for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 22:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H8EPVvGCOOTuMU24GvXfD/nUgTEDDy4NdiN0vVT1vrA=;
        b=pvueZ+MGinFZ5QCN65OEL7NOM/aF/4HZ6hwohPX05k0ZU5mc5JmUk8sPkG3P1ucvN+
         HhCnTR/6M/eerQUiXebFhJDXTcdGUEUPEEyUd1G01C9+Tf+D5M005wdZJnzdnGSUo1Xn
         23oeT0NtLMkDpWUevKchbfVKs7wgE+83XswZ4PeNIHn12iikOTkazmkOgt1/KHbgn+yt
         peKeeXwwJxquDh6kuvigObvFR2Ze8L5yzCpI5TzEx98N+WyyG8jhe26iDnYGgi6SRL63
         Tjyloh373/IEVceiOUpw2oSrrHf9bbVBa78RhmSW4R7HgHlyiFXfsIErLFQcR0RVy1nj
         sZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H8EPVvGCOOTuMU24GvXfD/nUgTEDDy4NdiN0vVT1vrA=;
        b=wJ/lmObSN4XuKbw6wkz7ws7jUM+3ePJmeEIqhNG6L6b5Bvy41C0tCDy42EhKlk6fQU
         iWT3OLBxl2PjWE1P/jksZPZzRqZJcxb2tXZJNq3LBq/p963TE1s6c8qUczqXp4G2A/H3
         nAPlv6ve4LnX15Qu3nYqhrJM1sLJJxZbGRBAHQrkWLqKlvtRpP1ojUShLHGpQhHu74L4
         xUlnEYs77IOTJ2Dz7McGWJaZb1bfqbpSTU/ejD5kVmCpdfSytKVm7ZqMcAouGuSLKkKq
         lEYUQxCtJZlaUrsXoMt8mvWRbD+6riWq1vulE1Wyp9/7A+VRfhq8wi6QrdBAUxsLlvsW
         6l5Q==
X-Gm-Message-State: AJIora/lnzajfEMuAkB4Crzan/MlC3K9Big75GQJA4Hr7iEPLMGpVwot
	Msau06c2KaK8+m/dJ/n8XYU=
X-Google-Smtp-Source: AGRyM1vLISkoN6gOYT3xRJJUwUEBZgOGqHyElNn7uwLDwEox8QNcRgvH/ZhshJlteRGTc71JggxXiw==
X-Received: by 2002:a17:90a:ba97:b0:1ef:91ab:de1e with SMTP id t23-20020a17090aba9700b001ef91abde1emr2015361pjr.237.1657691922843;
        Tue, 12 Jul 2022 22:58:42 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902f68900b0015e8d4eb24fsm7798551plg.153.2022.07.12.22.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 22:58:42 -0700 (PDT)
Message-ID: <c8edfbd4-afad-c018-daf6-aa2ac1f7b2fe@gmail.com>
Date: Wed, 13 Jul 2022 13:58:38 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [EXTERNAL] [swiotlb] 44d89f2248:
 Kernel_panic-not_syncing:swiotlb_init_remap:nslabs=#too_small
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-doc@vger.kernel.org, iommu@lists.linux.dev, lkp@lists.01.org,
 lkp@intel.com
References: <Ys43FtIumAsHPn+y@xsang-OptiPlex-9020>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <Ys43FtIumAsHPn+y@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/13/2022 11:08 AM, kernel test robot wrote:
> [You don't often get email from oliver.sang@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 44d89f22489c65400dbf9ed9ad1d18d2ea064b89 ("swiotlb: split up the global swiotlb lock")
> git://git.infradead.org/users/hch/misc.git swiotlb-cleanup
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +---------------------------------------------------------------+------------+------------+
> |                                                               | 4136ce90f0 | 44d89f2248 |
> +---------------------------------------------------------------+------------+------------+
> | boot_successes                                                | 23         | 0          |
> | boot_failures                                                 | 0          | 18         |
> | Kernel_panic-not_syncing:swiotlb_init_remap:nslabs=#too_small | 0          | 18         |
> +---------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   30.005215][    T0] Unknown kernel command line parameters "RESULT_ROOT=/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kunit/gcc-11/44d89f22489c65400dbf9ed9ad1d18d2ea064b89/3 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kunit/gcc-11/44d89f22489c65400dbf9ed9ad1d18d2ea064b89/vmlinuz-5.19.0-rc3-00015-g44d89f22489c branch=hch-misc/swiotlb-cleanup job=/lkp/jobs/scheduled/vm-snb-102/boot-1-debian-11.1-x86_64-20220510.cgz-44d89f22489c65400dbf9ed9ad1d18d2ea064b89-20220713-11587-2q30ty-2.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-kunit commit=44d89f22489c65400dbf9ed9ad1d18d2ea064b89 vmalloc=256M max_uptime=600 LKP_SERVER=internal-lkp-server selinux=0 softlockup_panic=1 prompt_ramdisk=0 vga=normal", will be passed to user space.
> [   30.015899][    T0] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> [   30.019270][    T0] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [   30.020042][    T0] mem auto-init: stack:off, heap alloc:off, heap free:off
> [   30.020607][    T0] Stack Depot early init allocating hash table with memblock_alloc, 8388608 bytes
> [   30.023950][    T0] Kernel panic - not syncing: swiotlb_init_remap: nslabs = 0 too small
> [   30.024616][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 5.19.0-rc3-00015-g44d89f22489c #1
> [   30.025310][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> [   30.026141][    T0] Call Trace:
> [   30.026399][    T0]  <TASK>
> [ 30.026630][ T0] dump_stack_lvl (kbuild/src/consumer/lib/dump_stack.c:107 (discriminator 1))
> [ 30.026992][ T0] panic (kbuild/src/consumer/kernel/panic.c:292)
> [ 30.027301][ T0] ? panic_print_sys_info+0x60/0x60
> [ 30.027770][ T0] ? vclkdev_alloc (kbuild/src/consumer/drivers/iommu/intel/dmar.c:878)
> [   30.028152][    T0]  ? is_uv_system+0x5/0x40
> [   30.028503][    T0]  ? up_write+0x48/0x80
> [   30.028833][    T0]  swiotlb_init_remap+0x36/0x37
> [   30.029221][    T0]  mem_init+0xe/0x13c
> [   30.029538][    T0]  mm_init+0x63/0x81
> [   30.029848][    T0]  start_kernel+0x143/0x39e
> [   30.030206][    T0]  secondary_startup_64_no_verify+0xe0/0xeb
> [   30.030680][    T0]  </TASK>
> 
> 

Thanks for report. The issue is caused by auto merging between
commit44d89f("swiotlb: split up the global swiotlb lock") and commit 
0bf28fc40(swiotlb: panic if nslabs is too small). nslab is checked 
before initialization.

Christoph, do you prefer to update patch "swiotlb: split up the global 
swiotlb lock" or append a fix patch on current brand?

