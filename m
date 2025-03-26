Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C03C1F63F9
	for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006296; cv=none; b=mFQzq6SrBvVgb0XUfjCzfkHv/vmN+PLX02l6r4WqsPV4BpKA9rp1wlmVM+vcmOeZXgEjpC/krxj6d2+ljDVzp1kLho9O/JCJ7BKdd/inTUCwHBdmzH3bqB5dVupLk3jf1M5kQXYPhK5CvTbq/ww42u5ZK+v1T+V/DYeJtwsrU2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006296; c=relaxed/simple;
	bh=13xJ52BTUyoFYzhI2x5yYfLIZBTKlEKRi8A8vE/wy3o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=i/7f47oB85RRn2abLOnm5ZT01e11kuTk5LFx3cTFS732tKymkiBFNbh9J3SDPolk4i4QIPNRAzDMPdXlfRJasPBXLXQ6fKATNvdb+tNBLiw4zyfShM13Qz9OMdvfv1A4wIoiO5nhqaioBc9P2aJ7XQ4GI7hjTHlhySTvOj2Zqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiL6HIvn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiL6HIvn"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so11657805a12.3
        for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743006293; x=1743611093; darn=lists.linux.dev;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/r+8nNS2HuGHo+LEx+NOI+N1HiRi8iT6B5fjjtbwxu0=;
        b=FiL6HIvniSiAC8gRBIW3jNmOEWoH+xl+vvbJS5Cy0WDMWM+A0JA0ZGsJeoI/aklw5C
         LQu4NTWwfylkSSAv1NtUq6mj7Z258NDP0nlXP/CwsWzB4l7/Xd2zFsglgM+FT9FNsgkb
         zNPxKmSs8f5BSiMXWWGD+vFUE7CfgP7mheu5A54VEzBioakGHnRo+gC+EnQu931K144R
         576ZFBv0weU1P5QuWQKMvPjbeKF0hkTOJbvvjQ5ZkFZTrtsRtHYVvLQyq26ONtlOCeSM
         wRvPhmdsdhEGKWLJngrQ0nenpERWAXwHm96GXjKdvR2j/RShaUJ14S3fYrrjiYIF2vJk
         JJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743006293; x=1743611093;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/r+8nNS2HuGHo+LEx+NOI+N1HiRi8iT6B5fjjtbwxu0=;
        b=N4WEf62/qsOfcnZsXQwNEYC80VQB/6ofw2COENLRIc/XFe4zztsL0Y2mqQIVVrjKWk
         9P2BWNxFs127noYfBDiIJyhdsO57kL0UFE+lLkwj26mUWSBwnSmxe92CfW9DcqURZ+4D
         ju3hlXt7xqBu4cN5V8abjP4m1FLvRXlxjF80EjUPjcbJfsYoywa2K5WkTkSk+c08fz2f
         ymqQJuNX0fW5vpkjQ/u+jzmFN+h6Z41Y40LF9XRS/U8YVt417tyAXlYF62zTR1Krfn1f
         6g1FbyAeF5V9leQppFeJaimP3c2vrOjrJQCVgxNSeQUizUyCzmyOqsf85r0FA4oorYHl
         bqaw==
X-Gm-Message-State: AOJu0YwXRrdLs4FHiOxZMw3n/ksUCOsy0LXgdgQtIwsoGpuAdxoCjvgg
	hREytZw1PxC5Dah5ijVam25zEvbMj3CUmsLTvucJclTGq0Wmz0VxLEeUlw==
X-Gm-Gg: ASbGncsdpSJHZ5O3CtSC89ZLX1hEKzCTiWO9nUILGRnCKypOhm1OqoyxkdMg/8tqIt3
	IusSdDrRFYGl7fIjCzhxUKvVG5yyHCbX40++AJNhNS71nxA5sF2IwLy2ADl20eRP89LI0S2rnRz
	CzMqwI6oQ/YvMTpryLn21Wi03WRa7BgiG6zSuZhI8BC7lI2mr5bACpZI89VeLMOTNNJDe9wlf7v
	9VHBSdoy+KuklZadikKk2vw9UajB0GpkSR0vVR7/z9lanyp3DkL/e144rTnMnEJHewLZ8sF/3nL
	xU/3oXt1nh7hUwRPWu4XnRJDQoaAEf/fHpeA0unmjcyCL0G2BrMZfj/qg6EZ8aLArcWcjClZnD9
	7EsCyuKXUyS3sew0mtJv74xmSQ7kb8rPUxyw5njgjdr0yMwuZKaCN/6QTVIbGXJkt5OxSLkmXS/
	1UqIWl221tpfaRKoXf4QvYr4Vi7J4ATwhKRInH
X-Google-Smtp-Source: AGHT+IEcKEwRZqWgXFapLRHFKgldhcyO/p2pr9RZvK57sbCWqPTqgrfDLQnM3LsI/3y4iQ1hF5IwhA==
X-Received: by 2002:a17:907:7f94:b0:ac3:3cfc:a59d with SMTP id a640c23a62f3a-ac6fae46e45mr4984966b.2.1743006292977;
        Wed, 26 Mar 2025 09:24:52 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9caa:b900:904f:7157:ed3d:7c34? (dynamic-2a02-3100-9caa-b900-904f-7157-ed3d-7c34.310.pool.telefonica.de. [2a02:3100:9caa:b900:904f:7157:ed3d:7c34])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac3ef8e5152sm1050222966b.47.2025.03.26.09.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 09:24:52 -0700 (PDT)
Message-ID: <7ca8f10b-94ee-4bae-a3a6-9b601a3b39b9@gmail.com>
Date: Wed, 26 Mar 2025 17:25:13 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Unpatched return thunk in use. This should not happen!
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On latest linux-next I get the following, linux-next from March 12th was still ok.
System is a N100-based mini pc.

calling  iommu_dma_init+0x0/0x40 @ 1
------------[ cut here ]------------
Unpatched return thunk in use. This should not happen!
WARNING: CPU: 0 PID: 1 at arch/x86/kernel/cpu/bugs.c:3107 __warn_thunk+0x26/0x30
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-next-20250326+ #1 PREEMPT(undef)
Hardware name: Default string Default string/Default string, BIOS ADLN.M6.SODIMM.ZB.CY.015 08/08/2023
RIP: 0010:__warn_thunk+0x26/0x30
Code: 90 90 90 90 55 48 89 e5 80 3d a2 20 3a 01 00 74 06 5d c3 cc cc cc cc 48 c7 c7 18 d0 d6 90 c6 05 8c 20 3a 01 01 e8 da f0 03 00 <0f> 0b 5d c3 cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0000:ffffa5960006fe18 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff90576220 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000000003 RDI: 00000000ffffffff
RBP: ffffa5960006fe18 R08: 0000000000000000 R09: ffffffff9114ece8
R10: ffffffff9111eca8 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000053 R14: ffffffff9137e798 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff9dfa66568000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff9df8a3601000 CR3: 0000000122650001 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 warn_thunk_thunk+0x16/0x30
 ? __cpuhp_setup_state_cpuslocked+0x65/0x310
 do_one_initcall+0x54/0x390
 ? debug_smp_processor_id+0x17/0x20
 ? rcu_is_watching+0x11/0x50
 kernel_init_freeable+0x268/0x2b0
 ? __pfx_kernel_init+0x10/0x10
 kernel_init+0x15/0x120
 ret_from_fork+0x35/0x60
 ? __pfx_kernel_init+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
RIP: 1f0f:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 841f0f2e66 ORIG_RAX: 1f0f2e6600000000
RAX: 0000000000000000 RBX: 1f0f2e6600000000 RCX: 2e66000000000084
RDX: 0000000000841f0f RSI: 000000841f0f2e66 RDI: 00841f0f2e660000
RBP: 00841f0f2e660000 R08: 00841f0f2e660000 R09: 000000841f0f2e66
R10: 0000000000841f0f R11: 2e66000000000084 R12: 000000841f0f2e66
R13: 0000000000841f0f R14: 2e66000000000084 R15: 1f0f2e6600000000
 </TASK>
irq event stamp: 6953
hardirqs last  enabled at (6961): [<ffffffff8ff6ce6e>] __up_console_sem+0x5e/0x80
hardirqs last disabled at (6968): [<ffffffff8ff6ce53>] __up_console_sem+0x43/0x80
softirqs last  enabled at (6192): [<ffffffff9068a468>] release_sock+0x98/0xb0
softirqs last disabled at (6190): [<ffffffff9068a3e9>] release_sock+0x19/0xb0
---[ end trace 0000000000000000 ]---
initcall iommu_dma_init+0x0/0x40 returned 0 after 1000 usecs

