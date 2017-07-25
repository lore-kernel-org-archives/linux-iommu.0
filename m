From: Artem Savkov <asavkov@redhat.com>
Subject: amd-iommu/x2apic: sleeping function called from invalid context
Date: Tue, 25 Jul 2017 15:56:18 +0200
Message-ID: <20170725135618.hev4vj7w24gm3a5q@shodan.usersys.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: iommu@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi,

Commit 1c3c5ea "sched/core: Enable might_sleep() and smp_processor_id()
checks early" seem to have uncovered an issue with amd-iommu/x2apic.

Starting with that commit the following warning started to show up on AMD
systems during boot:

[    0.140480] smpboot: Max logical packages: 6 
[    0.160000] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:747 
[    0.160000] in_atomic(): 0, irqs_disabled(): 1, pid: 1, name: swapper/0 
[    0.160000] no locks held by swapper/0/1. 
[    0.160000] irq event stamp: 304 
[    0.160000] hardirqs last  enabled at (303): [<ffffffff818a87b6>] _raw_spin_unlock_irqrestore+0x36/0x60 
[    0.160000] hardirqs last disabled at (304): [<ffffffff8235d440>] enable_IR_x2apic+0x79/0x196 
[    0.160000] softirqs last  enabled at (36): [<ffffffff818ae75f>] __do_softirq+0x35f/0x4ec 
[    0.160000] softirqs last disabled at (31): [<ffffffff810c1955>] irq_exit+0x105/0x120 
[    0.160000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc2.1.el7a.test.x86_64.debug #1 
[    0.160000] Hardware name:          PowerEdge C6145 /040N24, BIOS 3.5.0 10/28/2014 
[    0.160000] Call Trace: 
[    0.160000]  dump_stack+0x85/0xca 
[    0.160000]  ___might_sleep+0x22a/0x260 
[    0.160000]  __might_sleep+0x4a/0x80 
[    0.160000]  __mutex_lock+0x58/0x960 
[    0.160000]  ? iommu_completion_wait.part.17+0xb5/0x160 
[    0.160000]  ? register_syscore_ops+0x1d/0x70 
[    0.160000]  ? iommu_flush_all_caches+0x120/0x150 
[    0.160000]  mutex_lock_nested+0x1b/0x20 
[    0.160000]  register_syscore_ops+0x1d/0x70 
[    0.160000]  state_next+0x119/0x910 
[    0.160000]  iommu_go_to_state+0x29/0x30 
[    0.160000]  amd_iommu_enable+0x13/0x23 
[    0.160000]  irq_remapping_enable+0x1b/0x39 
[    0.160000]  enable_IR_x2apic+0x91/0x196 
[    0.160000]  default_setup_apic_routing+0x16/0x6e 
[    0.160000]  native_smp_prepare_cpus+0x257/0x2d5 
[    0.160000]  kernel_init_freeable+0x131/0x2a7 
[    0.160000]  ? kernel_init+0xe/0x104 
[    0.160000]  ? _raw_spin_unlock_irq+0x2c/0x40 
[    0.160000]  ? rest_init+0xe0/0xe0 
[    0.160000]  kernel_init+0xe/0x104 
[    0.160000]  ret_from_fork+0x2a/0x40 
[    0.160010] Switched APIC routing to physical flat. 

-- 
Regards,
  Artem
