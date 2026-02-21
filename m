Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E4623ABBE
	for <iommu@lists.linux.dev>; Sat, 21 Feb 2026 06:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771656828; cv=pass; b=aEaCmAOOhggoeowIHih3DH3Iqt5iel9E3N1aHBtOXsgW94VvgTFZnDU1wOlkNwUaBj3n+EUJuH0NsvSfyYGy1gs6U6joKYRkSHLNOPe0y7MkoSkGlM4N3HnEe8IeEucLBvnKVZdjNZ6jUJ0qam2+VjkY2GyVA52nDrgxK89Ad68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771656828; c=relaxed/simple;
	bh=54Zw0WZ+xPTTc/dvrxevnJu2iCmKu1ICvQCjX7Nci+A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CEnh+CEYl4EgilKo5zxnKov2RGHaq+wfZL1LKe1mNb6JmaobzagTRFNDrjS+v4Vf5brISdjqWG/9cZJ2ZSesJOqPqrb7xbaoy4T0FvPkUrn5+Vv0hbo4MfiBxQN53cUfo7VBvt20xsLvhZSQ+PxWEXynwRLZqPOIJ+GjnMD9+6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c81tqArB; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c81tqArB"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50334dd44d2so31957921cf.1
        for <iommu@lists.linux.dev>; Fri, 20 Feb 2026 22:53:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771656826; cv=none;
        d=google.com; s=arc-20240605;
        b=j2ZUTspdffezM7rkJwHSbaFfF9iZ5jycHjDwCy/ebwBqmVoUIrP2aNcQPBf/XrJa8+
         sXHD5QipZiGlHiQzfYEeMshGFrE8xuvoncXFPOT9J939R5C3C9fb8YGnAxHJXrC2Nsbt
         5ZO4+Sg9RhBIkIjtwyNs/4TNckpUtQAcU+cfnbpeeVTZvsDW2zHrLR3QfUehJfHHEZnd
         73MUmOAiiUYCCQxBO2mDx/i38GY2ONTNAbdazKOXIcDcr1sRFQflVLMjSiMgLvFI0x/6
         L9WF+eZslaHBZC4NYOjU66k6AthFmmaBLaKI3cY/FzP7Ry/l6BNS1RokV4CtNkBRZWx0
         XC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=1rxStf/qGHQ1EaSTPNj6R4aztKDomE5LRiMOyJoecnQ=;
        fh=W6UR49wT8+DYeXU71g4JZG5TAgUYf0w9mE2DdioLG70=;
        b=lNZrOq/Baq9E+Bo6x+OBbzTS+PSrHktdUoHsyvg0Xqu05g3uthuAEfts065AtTLYQ5
         CXFl4CU08x/0uj0vlbS0XgJBPSnJaz414/uC+rOYsCjzF4whri4A/yD/YRcHtPizBWei
         /aiViOAelI497v1+8+mXegroR56fOGnK4TnMtQJ3uzUsIFfdAPUaNhaN22XQ5a+1Yat/
         Gn4A/6Kua79sLRDp2BU5byIwH0ddwsCqJEC5UqN2sCs7BWeS4DTbws3XDYWpQ8p4oL3N
         OYm0lOU1uyEyFNDAQpwolKh233pAHRYlULNH72BjsqKeEPiVRJcuTZSzzrzSXPcJqAtS
         JvGg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771656826; x=1772261626; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1rxStf/qGHQ1EaSTPNj6R4aztKDomE5LRiMOyJoecnQ=;
        b=c81tqArBooa1LQPuQAC1JSvun2EM+8HZLVHifvV4wwwUPtY5DNfHX+yTKRBMBS8fNN
         QPRd7K5CiCQRDmRKeyPiXdYbt0sE6xTiI/82x6nrm40ZAYdSBJ4LavwzfwHu5VDcczLN
         nPVR5b4y4kWUaDNTkLt8IMN1KFPJgtfjS5LXWu3CeESwfCM6PPsQyIaytIn6Se2vLxxT
         bnV4vWPru6rE6oOHVAJkcZPuSPQvWXdjhGHEy3DB3oF+/lKbxzbCvtZOt79R4hwN+22M
         56YWw2Uc5XNSzlS9rq2MEZxU+3cPrtLyIT9oh4di1IgckOmZ+LXYnRn31tz9YIJNb0Cp
         xgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771656826; x=1772261626;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rxStf/qGHQ1EaSTPNj6R4aztKDomE5LRiMOyJoecnQ=;
        b=awfMudhEMVF7gCLBOmd0JCNG30n0ysuCx0Ie+4h6rXl3SHVdMHEzkCFe5+TsdlnOr6
         r0H5VYui3Jgo9MXGbke/prHXPZ7k7ef/Bh+3hxwitj9370vOkYw9xKWdH9/kMPzfazHy
         7xTH1FAYydSZaInRk4wKY/VrqML2aIHzgape6bx5DIO5kJr5N3OyOaLXTlxChTMqusu6
         Np8v7LGChefBdBeL2Xu/GMlMLSORMrJmFWAAiKK29NPY6I9EWuiz/scFljUrQ8nhCx70
         t2Ow+dQCz3W5tB6yw0yd1FTTtNK+40IAm7xnFUN53nSNC6MJDyi3nSjSXEMq5psBiVC+
         fmaA==
X-Forwarded-Encrypted: i=1; AJvYcCVkBKGZyUcjt+2RxY8UsOdbNcWF12u/6VkJwf/zbRZCprvu2FReVe+fTXnGAHkTjZpUWm6IEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzeI4NsN55h5GDpLklkXarM7C9UDPKX9Pr0lJwYBGfuyFVhnUa
	hUao9RuqyK86CLAZm1Ub7YZRDtid1AcJuqp4g5NOzVckXQO86Z/BaRUtFtphDEOSVTPCgD2hE5Y
	r7zKj3VXXZRz4M749VhJFFLXrjd5PN40=
X-Gm-Gg: AZuq6aJVZG3fKoepsmDBa3rKeyivAOxwhB7ef/5Zi2Y7AZrdSFCWwnbn+W2ho65/WXz
	QN9yfddC8b7uFj77DGhAcV7z2iO/sJev8zeV2qEiwb4cvv3zusEQuaq/Xi9JhDM5I7NEXVriHZn
	H1/GmL4HIpTSy+D1lqMNfIejgpld08Ql81z22lj7lZTAzyIRCviCCcp/+ZYXV9KkI76Lk8j0VR5
	M6o/GHL1UW+dkffbLQ1K44sP6d9LK6OMcIWqRjYw3QOLdBxLBnKODeOoQrepuFsv5Yu59DkO1H4
	5lQl+AV2
X-Received: by 2002:a05:622a:181b:b0:501:4c45:b206 with SMTP id
 d75a77b69052e-5070bcd0a7dmr36878421cf.64.1771656826080; Fri, 20 Feb 2026
 22:53:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Sam Sun <samsun1006219@gmail.com>
Date: Sat, 21 Feb 2026 14:53:35 +0800
X-Gm-Features: AaiRm52pLIKi1yWhJwzxslXRfRAqHMzP7jJpGocHWTXnN4K8iNUA-X3CcJ_Mn9Y
Message-ID: <CAEkJfYMQrwrhK133NCkzhyOa=1Gj1ME5H1g1d15qWxXUdzNhsA@mail.gmail.com>
Subject: [Bug] WARNING in pt_iommu_amdv1_init
To: jgg@ziepe.ca, kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Dear developers and maintainers,

We encountered a bug in the iommufd selftest framework that triggers a
kernel warning, which can lead to a kernel panic when panic_on_warn is
enabled. The issue was observed on kernel version 6.19.0 (commit
2961f841b025), using syzbot kernel config to compile
(https://syzkaller.appspot.com/text?tag=KernelConfig&x=e2f061f80b102378).

We analyzed the root cause of this bug. In
drivers/iommu/iommufd/selftest.c, the mock_domain_alloc_pgtable()
function configures the mock AMDv1 domain with the PT_FEAT_DYNAMIC_TOP
feature flag. However, the generic page table framework strictly
requires any driver requesting this feature to implement specific
hardware callbacks in driver_ops (specifically change_top and
get_top_lock).

Since the mock driver is only for testing and does not provide these
driver_ops callbacks, the sanity check in pt_iommu_amdv1_init fails
and triggers the warning. A possible fix for this issue is that the
PT_FEAT_DYNAMIC_TOP flag should simply be removed from its
configuration.

Here is the proposed patch to fix the issue:

--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -483,8 +483,7 @@ mock_domain_alloc_pgtable(struct device *dev,

         cfg.common.hw_max_vasz_lg2 = 64;
         cfg.common.hw_max_oasz_lg2 = 52;
- cfg.common.features = BIT(PT_FEAT_DYNAMIC_TOP) |
-      BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
+ cfg.common.features = BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
                       BIT(PT_FEAT_AMDV1_FORCE_COHERENCE);
         cfg.starting_level = 2;
         mock->domain.ops = &amdv1_ops;

Reproducer:
The issue can be reproduced using the following syzkaller program:

# {Threaded:false Repeat:false RepeatTimes:0 Procs:1 Slowdown:1
Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false
NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false
KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false
Wifi:false IEEE802154:false Sysctl:false Swap:false UseTmpDir:false
HandleSegv:false Trace:false CallComments:true
LegacyOptions:{Collide:false Fault:false FaultCall:0 FaultNth:0}}
open_by_handle_at(0xffffffffffffffff,
&(0x7f0000000240)=@reiserfs_2={0x8, 0x2, {0xb, 0xb}}, 0x0)
r0 = openat$iommufd(0xffffffffffffff9c, &(0x7f0000000080), 0x0, 0x0)
ioctl$IOMMU_IOAS_ALLOC(r0, 0x3b81, &(0x7f00000000c0)={0xc, 0x0, <r1=>0x0})
ioctl$IOMMU_TEST_OP_MOCK_DOMAIN(r0, 0x3ba0, &(0x7f0000000100)={0x48,
0x2, r1, 0x0, 0x0, 0x0, <r2=>0x0})
ioctl$IOMMU_HWPT_ALLOC$TEST(r0, 0x3b89, &(0x7f0000000200)={0x28, 0x2,
r2, r1, 0x0, 0x0, 0xdead, 0x8, &(0x7f0000000240)})

C reproducer:
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <endian.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

uint64_t r[3] = {0xffffffffffffffff, 0x0, 0x0};

int main(void)
{
    syscall(__NR_mmap, /*addr=*/0x1ffffffff000ul, /*len=*/0x1000ul,
/*prot=*/0ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul,
/*fd=*/(intptr_t)-1, /*offset=*/0ul);
    syscall(__NR_mmap, /*addr=*/0x200000000000ul, /*len=*/0x1000000ul,
/*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/7ul,
/*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul,
/*fd=*/(intptr_t)-1, /*offset=*/0ul);
    syscall(__NR_mmap, /*addr=*/0x200001000000ul, /*len=*/0x1000ul,
/*prot=*/0ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul,
/*fd=*/(intptr_t)-1, /*offset=*/0ul);
    const char* reason;
    (void)reason;
    intptr_t res = 0;
    if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {}
    *(uint32_t*)0x200000000240 = 8;
    *(uint32_t*)0x200000000244 = 2;
    *(uint32_t*)0x200000000248 = 0xb;
    *(uint32_t*)0x20000000024c = 0xb;
    syscall(__NR_open_by_handle_at, /*mountdirfd=*/(intptr_t)-1,
/*handle=*/0x200000000240ul, /*flags=*/0ul);
    memcpy((void*)0x200000000080, "/dev/iommu\000", 11);
    res = syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul,
/*file=*/0x200000000080ul, /*flags=*/0, /*mode=*/0);
    if (res != -1)
        r[0] = res;
    *(uint32_t*)0x2000000000c0 = 0xc;
    *(uint32_t*)0x2000000000c4 = 0;
    res = syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0x3b81,
/*arg=*/0x2000000000c0ul);
    if (res != -1)
        r[1] = *(uint32_t*)0x2000000000c8;
    *(uint32_t*)0x200000000100 = 0x48;
    *(uint32_t*)0x200000000104 = 2;
    *(uint32_t*)0x200000000108 = r[1];
    *(uint32_t*)0x20000000010c = 0;
    res = syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0x3ba0,
/*arg=*/0x200000000100ul);
    if (res != -1)
        r[2] = *(uint32_t*)0x200000000118;
    *(uint32_t*)0x200000000200 = 0x28;
    *(uint32_t*)0x200000000204 = 2;
    *(uint32_t*)0x200000000208 = r[2];
    *(uint32_t*)0x20000000020c = r[1];
    *(uint32_t*)0x200000000214 = 0;
    *(uint32_t*)0x200000000218 = 0xdead;
    *(uint32_t*)0x20000000021c = 8;
    *(uint64_t*)0x200000000220 = 0x200000000240;
    *(uint32_t*)0x200000000240 = 0xbadbeef;
    syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0x3b89, /*arg=*/0x200000000200ul);
    return 0;
}

If you have any other questions, please let me know.

Best regards,
Yue
