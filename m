Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA429A8
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 16:35:52 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1aad6f2be8eso47510015ad.3
        for <iommu@lists.linux.dev>; Wed, 03 May 2023 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683131752; x=1685723752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/389qplif+CNkXxtQ/HgIFDi4dycC02/rtil8xXRXc=;
        b=Z4Cs5R4/s1pDP2FSeVmU9xT76qMP3wouwY1Ps65fLeCYqjQMaYVvejB0JItUP+T4RT
         nWx4lT9WzEfq5aY3guO9R76KVrFDtaYaUEQ25Elo5NPmaZMniCMb9/o9TulI0KS66Wcc
         YYCLdO6ngyzuKE+06qHF3wji8nd2xQW3m1k3e5rdxhRItiF1X5TFu+t0PF7PfWXTDJOq
         vmBjGIGV1qcWBiu9R9ccyJNV/Zfw+WN6u7iyvNY1trl87oBHYSdkRTgtdNd6mx7MobO6
         19aTGTAzKUXos+LOcg5oYQLOH1Cb1ebcesa6IZ5JP32gGVOeFxZhN7B5M0PhCbOvncdK
         9/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131752; x=1685723752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/389qplif+CNkXxtQ/HgIFDi4dycC02/rtil8xXRXc=;
        b=fwICNWZpnLa+HtnP80RTLJnXtrwZNtje+SNO2QffAoXK+Gtse67BmZsa8p+MRqPFIN
         ZfzfnwznRsyzhPdqcQ/C3rXQklaEcXXf1rDw68eMHpRcpogyd8sdHXxP1YqTCv+5uNoM
         EvdzsiHf5NGkz0rjdZn2z0V8AAIBjHoxtMm6Hx66jEemAdFz/tjYajI78+pc5AppIdc2
         1Vg2O/7n34GWVr3fA2qwudBnV3Ok/dUF2ydYxtO8OsqpfuGCh4NymnlwhLBjNpgnC2nu
         jN/+KQQK5u/qvfJnyFXspvWB2CBXg610O9ir4XJ0LezyQpR3n99JTu7eKiyoxPzTPJLe
         U02g==
X-Gm-Message-State: AC+VfDwIPNIFb2+DYbnzVXNeDginlQaUicTxOwg4zvmvQUK/jcm3tfhc
	KLcIedGK/uUacTWBRrco2dw=
X-Google-Smtp-Source: ACHHUZ7oH0uCOdfhzFzAfAEqMGAC0lMcQXIsRmBhYh8cE2yZXFGKpt64wEgV0/NPP4dhRRVPYCfDvA==
X-Received: by 2002:a17:902:82c3:b0:1a9:1b4:9fd5 with SMTP id u3-20020a17090282c300b001a901b49fd5mr589673plz.68.1683131751882;
        Wed, 03 May 2023 09:35:51 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6454])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902a9c500b001a4fa2f7a23sm21823336plr.274.2023.05.03.09.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 09:35:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 May 2023 06:35:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
	akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
	ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	keescook@chromium.org, ndesaulniers@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH 00/40] Memory allocation profiling
Message-ID: <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
References: <20230501165450.15352-1-surenb@google.com>
 <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan>
 <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <ZFIVtB8JyKk0ddA5@moria.home.lan>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFIVtB8JyKk0ddA5@moria.home.lan>

Hello, Kent.

On Wed, May 03, 2023 at 04:05:08AM -0400, Kent Overstreet wrote:
> No, we're still waiting on the tracing people to _demonstrate_, not
> claim, that this is at all possible in a comparable way with tracing. 

So, we (meta) happen to do stuff like this all the time in the fleet to hunt
down tricky persistent problems like memory leaks, ref leaks, what-have-you.
In recent kernels, with kprobe and BPF, our ability to debug these sorts of
problems has improved a great deal. Below, I'm attaching a bcc script I used
to hunt down, IIRC, a double vfree. It's not exactly for a leak but leaks
can follow the same pattern.

There are of course some pros and cons to this approach:

Pros:

* The framework doesn't really have any runtime overhead, so we can have it
  deployed in the entire fleet and debug wherever problem is.

* It's fully flexible and programmable which enables non-trivial filtering
  and summarizing to be done inside kernel w/ BPF as necessary, which is
  pretty handy for tracking high frequency events.

* BPF is pretty performant. Dedicated built-in kernel code can do better of
  course but BPF's jit compiled code & its data structures are fast enough.
  I don't remember any time this was a problem.

Cons:

* BPF has some learning curve. Also the fact that what it provides is a wide
  open field rather than something scoped out for a specific problem can
  make it seem a bit daunting at the beginning.

* Because tracking starts when the script starts running, it doesn't know
  anything which has happened upto that point, so you gotta pay attention to
  handling e.g. handling frees which don't match allocs. It's kinda annoying
  but not a huge problem usually. There are ways to build in BPF progs into
  the kernel and load it early but I haven't experiemnted with it yet
  personally.

I'm not necessarily against adding dedicated memory debugging mechanism but
do wonder whether the extra benefits would be enough to justify the code and
maintenance overhead.

Oh, a bit of delta but for anyone who's more interested in debugging
problems like this, while I tend to go for bcc
(https://github.com/iovisor/bcc) for this sort of problems. Others prefer to
write against libbpf directly or use bpftrace
(https://github.com/iovisor/bpftrace).

Thanks.

#!/usr/bin/env bcc-py

import bcc
import time
import datetime
import argparse
import os
import sys
import errno

description = """
Record vmalloc/vfrees and trigger on unmatched vfree
"""

bpf_source = """
#include <uapi/linux/ptrace.h>
#include <linux/vmalloc.h>

struct vmalloc_rec {
	unsigned long		ptr;
	int			last_alloc_stkid;
	int			last_free_stkid;
	int			this_stkid;
	bool			allocated;
};

BPF_STACK_TRACE(stacks, 8192);
BPF_HASH(vmallocs, unsigned long, struct vmalloc_rec, 131072);
BPF_ARRAY(dup_free, struct vmalloc_rec, 1);

int kpret_vmalloc_node_range(struct pt_regs *ctx)
{
        unsigned long ptr = PT_REGS_RC(ctx);
	uint32_t zkey = 0;
	struct vmalloc_rec rec_init = { };
	struct vmalloc_rec *rec;
	int stkid;

	if (!ptr)
		return 0;

	stkid = stacks.get_stackid(ctx, 0);

        rec_init.ptr = ptr;
        rec_init.last_alloc_stkid = -1;
        rec_init.last_free_stkid = -1;
        rec_init.this_stkid = -1;

	rec = vmallocs.lookup_or_init(&ptr, &rec_init);
	rec->allocated = true;
	rec->last_alloc_stkid = stkid;
	return 0;
}

int kp_vfree(struct pt_regs *ctx, const void *addr)
{
	unsigned long ptr = (unsigned long)addr;
	uint32_t zkey = 0;
	struct vmalloc_rec rec_init = { };
	struct vmalloc_rec *rec;
	int stkid;

	stkid = stacks.get_stackid(ctx, 0);

        rec_init.ptr = ptr;
        rec_init.last_alloc_stkid = -1;
        rec_init.last_free_stkid = -1;
        rec_init.this_stkid = -1;

	rec = vmallocs.lookup_or_init(&ptr, &rec_init);
	if (!rec->allocated && rec->last_alloc_stkid >= 0) {
		rec->this_stkid = stkid;
		dup_free.update(&zkey, rec);
	}

	rec->allocated = false;
	rec->last_free_stkid = stkid;
        return 0;
}
"""

bpf = bcc.BPF(text=bpf_source)
bpf.attach_kretprobe(event="__vmalloc_node_range", fn_name="kpret_vmalloc_node_range");
bpf.attach_kprobe(event="vfree", fn_name="kp_vfree");
bpf.attach_kprobe(event="vfree_atomic", fn_name="kp_vfree");

stacks = bpf["stacks"]
vmallocs = bpf["vmallocs"]
dup_free = bpf["dup_free"]
last_dup_free_ptr = dup_free[0].ptr

def print_stack(stkid):
    for addr in stacks.walk(stkid):
        sym = bpf.ksym(addr)
        print('  {}'.format(sym))

def print_dup(dup):
    print('allocated={} ptr={}'.format(dup.allocated, hex(dup.ptr)))
    if (dup.last_alloc_stkid >= 0):
        print('last_alloc_stack: ')
        print_stack(dup.last_alloc_stkid)
    if (dup.last_free_stkid >= 0):
        print('last_free_stack: ')
        print_stack(dup.last_free_stkid)
    if (dup.this_stkid >= 0):
        print('this_stack: ')
        print_stack(dup.this_stkid)

while True:
    time.sleep(1)
    
    if dup_free[0].ptr != last_dup_free_ptr:
        print('\nDUP_FREE:')
        print_dup(dup_free[0])
        last_dup_free_ptr = dup_free[0].ptr
