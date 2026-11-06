Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977745;
	b=tnvQdrXVEqoSkK4eprYKMRE7VICrSRk4j4KYvhv/FKPyVns5OILuLjX8Qf9xVAcx5xKu
	 phEXqgZtXZ8N4FKAGdTy3vWvwZ1HMr0j8Wa0wZRG5JQp2GPXEDByooiZeUq2GA781uKwQ
	 eviOxxyyZeuAuSPL/NTkIfLSJEMiKFKazws6NmjEBd1FKhhmc4yAfpBsAufNufu0M4gEk
	 EjltVjZ9aiPQaf8uL6rtu501yscrMgMv5EsJB08VlSLma8cNnyibMpV8hqEpoyxh8yIfQ
	 92c3QeQsIkssoRuscC/4TDkWLPSK3gbhR8rVgKz0NmyyWMLT4a+Z+/zgCs5rh0nDBCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Sjb/CGptteVJ6mRSv5fy7p+QoZN56Caycv45okK6XdU=;
	b=DbqYnhjBKzWt+1UP6xX6FkoBXNrYYJ4/rYkRxITASFrMvTzccqdudsYYdFMVIVeTgv5j
	 H2Q8kCLDVXi78g4Tmuwxj6ENBszUe30YTJHoFSDhG7ZVYG0ONT84ZnI04F5sUQ5aGEDLx
	 gXg74sDgfjb+y5VEMeoxy38OG82CUq6IRc//8NLtoRSHn5dduCyp3mu8YbbyaVIrmCv4h
	 UQfAxP+othpOA5cIJbyQCiGvWelP5gJ2cNB7StdjHTuvkslynUrxL1jE2ncD6V4iuLzpd
	 tx9eJHD/lM2eDUyMGNpCBhQy2Jagri82WGtbXQ+TO2o3GOrs9wTnzax4G9uB2XHIIuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eW2Hze9b;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693C6606A32C
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 15:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 693C6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eW2Hze9b
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c34bff61551so117852066b.2
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 07:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793977744; x=1794582544; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sjb/CGptteVJ6mRSv5fy7p+QoZN56Caycv45okK6XdU=;
        b=eW2Hze9bCZzw+AK/1XuX+r1okA+7Um2MpccuWGbByfDPe2H0KUd/vU4jzTYep2fike
         zVrFMUxeVkvNy1UUKjrlZCcIuHGzqdVJsr7QasS0t4djIDuLVz7uufVHegyfy8Apv9rY
         6mFe5E/E+7Cx669/dOPLmQ8lGEV1hXifLL4ahdfuQFQ3AYBx6NWlHx9cfQkjbCHDUyZb
         7pyHX+YRsN8v54Abe6NzowM28XnG1T3+qw5MiPrZOMPmmQIwj9jalKWoS7rXTspoOJL6
         hrH1qZHDFAxB/MJtmWl7E7UGfJVcckGYYvZE/G9sGLH9UQXtHuPzFrpFqxRmDSKIAiK8
         WCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977744; x=1794582544;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sjb/CGptteVJ6mRSv5fy7p+QoZN56Caycv45okK6XdU=;
        b=qDDpsWqJgX2urtDVYWtGWZGC1gAvEkCTsDoJabrxqlZLS9Bmc+4uVwJ5bsc8P0eIdw
         TXUwPteHgNaywYiKlGd45yYS/tyz0qgK4HH3svd+Jmug1NaqyiqP8FpIz5uD3s8b3gUm
         N2MnfWkdLMLsPXSTA9twwnD5dWJggpnp9xbw44nxmIkRE4T4IVIQxWY/wXqYfa1aclAX
         sO6HR0VhOWEun63gVGAvJNuUpXDl+iAASlx+XVJCwi9Buol85oRHsEPHVguaSv9GK5NR
         zQE13ESfdxbLjo3/l2C25lQ01ipm2/iYZlSpXpUz8q4TGDvslvgIjGI/qpvQ3rHTz3HH
         v4LQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/f9moYnsLoU+19Y2JfIBAq+b3zrOQcij+ZN8LSD23EunDhz8g4K8zDAIGawZXSYVDNkC0mg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9DUi1CpWXSF9QR4Ob5IAKjrqRfYCgVfuEFyOyvFr2ESDd4c6tK
	6Ou6IwzfGIN8vHiLhpOTUjnKT1yWSjLHVfSdeNz1HE6SalLOUDcYkZHJ
X-Gm-Gg: AYBFou13kaEdC1wqG0VTn2X55WD1lS6CZi4Z8f+AizqK1VjAvjZZJHH1hrnaOD1qkAu
	5llVMm/HzBuJ7ShZG2HAKJkRswmC5qqanZxx3iQ/hWNqtGgF5j01tQRTAazQnKvrvUB8NfUhAWL
	cs3Kl4D65IT2T3+VAA0g3qa8VifGtKL+xQMpHTB6EPy1IdF4wcVNxUhSFa18it9jUYPyZsNrwbz
	Lfk/6ZqVq2oE5RQnhmSucm/wmeF/I9lOjKDKlNcqs4DtWgl6QXEYmSXzRFIyhdhq51UeMHB+3/C
	wT6WO2WpyHIlgQXB32kt81fn0Btnl6uoqaNE3+258W1Bo0dKYJapGB9civbgCggnwdPkW9Xi0jb
	1bOPCGnjZKCNm2wJtN337EfLHWjMAwuJzPyHAibYsn52PSYiNvaOJnBmh6ZLUIG/7dUdy9cmYNz
	K4Rwdt5Fb4V5pZCkTI4JQ8Ij13ChPtq+AKHrdAjPG2/B+JUT6h34AnvmseCXWsz8s8n9MkkrGI/
	zOVxIZDtmQVWKGkiltqrYR0gfX81jG/qNyscy/u/2R01ya4Rp+NYY31ic/SPW/NZE2rtdsWR/eT
	ja3NfTN2XcLtBBY2iLzhzWZlfP3TLnYOd9dabebb/9axw+cl88kELAkm9Z2HGIM6zW58F6vIda0
	FgZ91yHJxgzVRKE7HwkUuSUCwZ1DVXYWF2Aq7ClL9Tp0qZHVS/bk8fnyGuyCROFk89c8KYztU/X
	Y+ONF6wYiu+x4VWqkTK9ITZ2vCcr2uCfgUwdSmymj52fcvk0EIHfEPpTnKGDTMY10=
X-Received: by 2002:a17:907:80a:b0:c49:ca4e:b978 with SMTP id a640c23a62f3a-c4d34d43ca7mr263019966b.49.1793977743633;
        Fri, 06 Nov 2026 07:09:03 -0800 (PST)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3567142fsm86548566b.34.2026.11.06.07.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 07:09:02 -0800 (PST)
Message-ID: <08037337-f8ac-4bca-b849-4c856d0bb68c@gmail.com>
Date: Fri, 6 Nov 2026 16:08:38 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [iommu?] memory leak in iommu_fwspec_init
To: syzbot <syzbot+fe84fc6a684e0beb86e2@syzkaller.appspotmail.com>,
 iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com,
 linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 syzkaller-bugs@googlegroups.com, will@kernel.org
References: <6ae402bb.0c1d3ab6.e3d48.006d.GAE@google.com>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <6ae402bb.0c1d3ab6.e3d48.006d.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/26 03:36, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    65ba8f34ec88 Merge tag 'xtensa-20261027' of https://github..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15067d31580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fbf447a1375a1948
> dashboard link: https://syzkaller.appspot.com/bug?extid=fe84fc6a684e0beb86e2
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b22a3c580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b4e738ce5f2b/disk-65ba8f34.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1de9d1ecbbb6/vmlinux-65ba8f34.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8a3d79b65181/bzImage-65ba8f34.xz
> 
> AI-generated root cause summary:
> A memory leak of `struct dev_iommu` occurs when `iommu_fwspec_init()` allocates
> `dev->iommu` via `dev_iommu_get()`, but subsequently fails on allocating the
> `iommu_fwspec` structure (e.g. via fault injection) and returns -ENOMEM without
> releasing `dev->iommu`. Furthermore, callers such as `iommu_mock_device_add()`
> do not invoke `dev_iommu_free()` on error from `iommu_fwspec_init()`. When
> device initialization fails and the device is released, `dev->iommu` remains
> allocated, causing an unreferenced object memory leak.
> 
> full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=fe84fc6a684e0beb86e2
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fe84fc6a684e0beb86e2@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff88812bad6bc0 (size 64):
>   comm "syz.0.26", pid 5965, jiffies 4294941985
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 0):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>     slab_post_alloc_hook mm/slub.c:4733 [inline]
>     slab_alloc_node mm/slub.c:5033 [inline]
>     __kmalloc_cache_noprof+0x35f/0x3f0 mm/slub.c:5676
>     _kmalloc_noprof include/linux/slab.h:991 [inline]
>     _kzalloc_noprof include/linux/slab.h:1312 [inline]
>     dev_iommu_get drivers/iommu/iommu.c:408 [inline]
>     dev_iommu_get drivers/iommu/iommu.c:399 [inline]
>     iommu_fwspec_init+0x20d/0x240 drivers/iommu/iommu.c:3086
>     iommu_mock_device_add+0x29/0x90 drivers/iommu/iommu.c:385
>     mock_dev_create drivers/iommu/iommufd/selftest.c:1026 [inline]
>     iommufd_test_mock_domain drivers/iommu/iommufd/selftest.c:1068 [inline]
>     iommufd_test+0x1a97/0x2ec0 drivers/iommu/iommufd/selftest.c:2104
>     iommufd_fops_ioctl+0x1ed/0x370 drivers/iommu/iommufd/main.c:556
>     vfs_ioctl fs/ioctl.c:51 [inline]
>     __do_sys_ioctl fs/ioctl.c:597 [inline]
>     __se_sys_ioctl fs/ioctl.c:583 [inline]
>     __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
>     do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>     do_syscall_64+0xe9/0x530 arch/x86/entry/syscall_64.c:84
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
Please move the fix out of iommu_fwspec_init() and into
iommu_mock_device_add(), and leave iommu_fwspec_init() unchanged. The
same core-level approach for this leak was already rejected by Robin
Murphy on 2026-11-02 [1]. iommu_fwspec_init() is designed to run
together with iommu_probe_device() or with a caller that cleans up after
a failure, as of_iommu_configure() does. The defect is the early return
in iommu_mock_device_add().

The leak happens because iommu_mock_device_add() returns the error of
iommu_fwspec_init() without freeing dev->iommu. iommu_fwspec_init() can
allocate dev->iommu with dev_iommu_get() and then fail to allocate the
fwspec. The mock device has not been added at that point, so no bus
notifier will ever call iommu_release_device() for it, and the
put_device() in mock_dev_create() frees only the mock device. When
iommu_fwspec_init() fails, iommu_mock_device_add() should call
dev_iommu_free() if dev->iommu is set. The check is needed because
iommu_fwspec_init() can also fail before it allocates anything, for
example when dev_iommu_get() itself fails. The existing dev_iommu_free()
on the device_add() failure path is correct and must stay. One error
label shared by both failure paths is a clean way to write it.

Please change the tag to:

  Fixes: 2a918911ed3d ("iommufd: Register iommufd mock devices with fwspec")

That commit added the early return that leaks. The current tag names
72acd9df18f1, a v5.7 change, so stable tooling would try to carry a core
change to trees that do not even have the mock helper, which only exists
since v6.18.

The commit message has to describe the new placement: name the early
return in iommu_mock_device_add() as the cause and explain why nothing
else frees dev->iommu for a mock device that was never added.

While rewriting the message, please also keep it short. From the
kmemleak report, the allocation chain (dev_iommu_get, iommu_fwspec_init
and iommu_mock_device_add with their source lines) is enough. The hex
dump, the object address, the comm line and the syscall entry frames can
go. Two or three short paragraphs are enough for this change.

[1] https://lore.kernel.org/all/7e209fb2-4bda-4207-9109-c67c8df41e05@arm.com/

-- 
Krystian Kaniewski
