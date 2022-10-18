Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50B31FAF
	for <iommu@lists.linux.dev>; Tue, 18 Oct 2022 07:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666076419; x=1697612419;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=swoTK/vWWl/9eOLcCFFZcY950xUnWZqIBimY1OD8Jxk=;
  b=GO/E7nbJEAz1edta/aASVijrWbktwsfNSdh5UNy4UZHg4Qm2zMEuMRxt
   REMcCl44jA7gfTa56VW7L+ArTjmZ6O5ij1fySB7pRX7aBjmQ/Ba/0HL8s
   kaI94+tI0Fg4J1Qpk38R3giQJHqSV47xAxIu01Jk2k3kcupypGjJnAgSs
   HQPrvaEErdIvEEqFsMB9LEns/+WfGqYTr4DxMEXD7wNAHfC4IxtIojj/U
   iFx7HFQTQvM2VBlvuVp2GqEiDPM16yDbcVdcdyaFOcgq6rvZLtJFhT0aT
   FfTGtSMyogdg80rCtupgh+/pJ3x/1v6p7Go9hCMffErr63gZ6In5mruKE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="368047120"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="368047120"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 00:00:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="628593088"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="628593088"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.49]) ([10.254.211.49])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 00:00:15 -0700
Message-ID: <7c6dc025-2f7f-b283-a356-8876d6646ce7@linux.intel.com>
Date: Tue, 18 Oct 2022 15:00:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Cc: baolu.lu@linux.intel.com, "Coelho, Luciano" <luciano.coelho@intel.com>,
 "Saarinen, Jani" <jani.saarinen@intel.com>,
 "Mistat, Tomasz" <tomasz.mistat@intel.com>,
 "Furquim, Ulisses" <ulisses.furquim@intel.com>,
 "Dutt, Sudeep" <sudeep.dutt@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: Regression with 6.1-rc1
Content-Language: en-US
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
References: <SJ1PR11MB6129788F0FE9CF4BD02E3A1DB9299@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <DM5PR11MB1627D4E151F38CEC4496B6F7CD299@DM5PR11MB1627.namprd11.prod.outlook.com>
 <DM4PR11MB614148B80837830E33CD9F4FB9289@DM4PR11MB6141.namprd11.prod.outlook.com>
 <c816c409-0a7a-81f6-adbe-087f0f7dd0c3@linux.intel.com>
 <SJ1PR11MB61295C576AC2E506BAF423B6B9289@SJ1PR11MB6129.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <SJ1PR11MB61295C576AC2E506BAF423B6B9289@SJ1PR11MB6129.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/10/18 14:34, Borah, Chaitanya Kumar wrote:
>>> Are you already aware of this issue? Any idea or hint on this?
>> I have proposed below fix:
>>
>> https://lore.kernel.org/all/20220927053109.4053662-1-
>> baolu.lu@linux.intel.com/
>>
>> Does it work for you?
> I have tried applying these patches on top of 6.1-rc1. The original issue seems to be gone but I am being hit by another issue.

Thank you!

> 
> [   15.661691] ======================================================
> [   15.661691] WARNING: possible circular locking dependency detected
> [   15.661692] 6.1.0-rc1-withfix+ #1 Not tainted
> [   15.661693] ------------------------------------------------------
> [   15.661693] cpuhp/0/16 is trying to acquire lock:
> [   15.661694] ffff888101136678 (&(&priv->bus_notifier)->rwsem){++++}-{3:3}, at: blocking_notifier_call_chain+0x24/0x60
> [   15.661700]
>                 but task is already holding lock:
> [   15.661700] ffffffff82649140 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x43/0x1f0
> [   15.661703]
>                 which lock already depends on the new lock.
> 
> [   15.661703]
>                 the existing dependency chain (in reverse order) is:
> [   15.661703]
>                 -> #3 (cpuhp_state-up){+.+.}-{0:0}:
> [   15.661705]        lock_acquire+0xd2/0x300
> [   15.661708]        cpuhp_thread_fun+0xa1/0x1f0
> [   15.661708]        smpboot_thread_fn+0x1bc/0x270
> [   15.661710]        kthread+0xeb/0x120
> [   15.661710]        ret_from_fork+0x1f/0x30
> [   15.661712]
>                 -> #2 (cpu_hotplug_lock){++++}-{0:0}:
> [   15.661714]        lock_acquire+0xd2/0x300
> [   15.661715]        __cpuhp_state_add_instance+0x44/0x1d0
> [   15.661716]        iova_domain_init_rcaches+0x164/0x190
> [   15.661719]        iommu_setup_dma_ops+0x12c/0x3f0
> [   15.661720]        bus_iommu_probe+0x266/0x2c0
> [   15.661721]        iommu_device_register+0xbc/0x120
> [   15.661722]        intel_iommu_init+0xe11/0x1039
> [   15.661725]        pci_iommu_init+0x9/0x31
> [   15.661728]        do_one_initcall+0x53/0x2f0
> [   15.661728]        kernel_init_freeable+0x189/0x1d7
> [   15.661729]        kernel_init+0x11/0x120
> [   15.661750]        ret_from_fork+0x1f/0x30
> [   15.661751]
>                 -> #1 (&domain->iova_cookie->mutex){+.+.}-{3:3}:
> [   15.661752]        lock_acquire+0xd2/0x300
> [   15.661754]        __mutex_lock+0x95/0xf20
> [   15.661756]        iommu_setup_dma_ops+0xd5/0x3f0
> [   15.661757]        iommu_probe_device+0x9e/0x170
> [   15.661758]        iommu_bus_notifier+0x2d/0x40
> [   15.661759]        notifier_call_chain+0x3e/0xb0
> [   15.661760]        blocking_notifier_call_chain+0x3e/0x60
> [   15.661761]        device_add+0x3f8/0x930
> [   15.661763]        pci_device_add+0x255/0x580
> [   15.661765]        pci_scan_single_device+0xa3/0xc0
> [   15.661766]        pci_scan_slot+0x79/0x1b0
> [   15.661767]        pci_scan_child_bus_extend+0x35/0x2a0
> [   15.661767]        vmd_probe+0x631/0x950
> [   15.661769]        pci_device_probe+0x95/0x110
> [   15.661770]        really_probe+0xd9/0x350
> [   15.661772]        __driver_probe_device+0x73/0x170
> [   15.661773]        driver_probe_device+0x19/0xa0
> [   15.661774]        __driver_attach+0xc0/0x190
> [   15.661775]        bus_for_each_dev+0x73/0xc0
> [   15.661776]        bus_add_driver+0x1ac/0x200
> [   15.661777]        driver_register+0x67/0xd0
> [   15.661778]        do_one_initcall+0x53/0x2f0
> [   15.661778]        kernel_init_freeable+0x189/0x1d7
> [   15.661779]        kernel_init+0x11/0x120
> [   15.661780]        ret_from_fork+0x1f/0x30
> [   15.661781]
>                 -> #0 (&(&priv->bus_notifier)->rwsem){++++}-{3:3}:
> [   15.661782]        check_prev_add+0x90/0xc60
> [   15.661784]        __lock_acquire+0x151b/0x1f60
> [   15.661784]        lock_acquire+0xd2/0x300
> [   15.661786]        down_read+0x39/0x140
> [   15.661786]        blocking_notifier_call_chain+0x24/0x60
> [   15.661788]        device_add+0x3f8/0x930
> [   15.661788]        platform_device_add+0xe4/0x230
> [   15.661790]        coretemp_cpu_online+0xf1/0x170 [coretemp]
> [   15.661794]        cpuhp_invoke_callback+0x179/0x870
> [   15.661795]        cpuhp_thread_fun+0x182/0x1f0
> [   15.661795]        smpboot_thread_fn+0x1bc/0x270
> [   15.661796]        kthread+0xeb/0x120
> [   15.661797]        ret_from_fork+0x1f/0x30
> [   15.661798]
>                 other info that might help us debug this:
> 
> [   15.661798] Chain exists of:
>                   &(&priv->bus_notifier)->rwsem --> cpu_hotplug_lock --> cpuhp_state-up
> 
> [   15.661799]  Possible unsafe locking scenario:
> 
> [   15.661800]        CPU0                    CPU1
> [   15.661800]        ----                    ----
> [   15.661800]   lock(cpuhp_state-up);
> [   15.661801]                                lock(cpu_hotplug_lock);
> [   15.661801]                                lock(cpuhp_state-up);
> [   15.661802]   lock(&(&priv->bus_notifier)->rwsem);
> [   15.661802]
>                  *** DEADLOCK ***
> 
> [   15.661803] 2 locks held by cpuhp/0/16:
> [   15.661803]  #0: ffffffff82646a70 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x43/0x1f0
> [   15.661805]  #1: ffffffff82649140 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x43/0x1f0
> [   15.661807]
>                 stack backtrace:
> [   15.661807] CPU: 0 PID: 16 Comm: cpuhp/0 Not tainted 6.1.0-rc1-withfix+ #1
> ...
> [   15.661810] Call Trace:
> [   15.661811]  <TASK>
> [   15.661812]  dump_stack_lvl+0x57/0x81
> [   15.661813]  check_noncircular+0x131/0x150
> [   15.661815]  ? __lock_acquire+0x5aa/0x1f60
> [   15.661816]  check_prev_add+0x90/0xc60
> [   15.661818]  __lock_acquire+0x151b/0x1f60
> [   15.661819]  lock_acquire+0xd2/0x300
> [   15.661821]  ? blocking_notifier_call_chain+0x24/0x60
> [   15.661823]  down_read+0x39/0x140
> [   15.661824]  ? blocking_notifier_call_chain+0x24/0x60
> [   15.661825]  blocking_notifier_call_chain+0x24/0x60
> [   15.661827]  device_add+0x3f8/0x930
> [   15.661828]  ? dev_set_name+0x4e/0x70
> [   15.661830]  platform_device_add+0xe4/0x230
> [   15.661832]  coretemp_cpu_online+0xf1/0x170 [coretemp]
> [   15.661835]  ? create_core_data+0x500/0x500 [coretemp]
> [   15.661838]  cpuhp_invoke_callback+0x179/0x870
> [   15.661839]  cpuhp_thread_fun+0x182/0x1f0
> [   15.661840]  ? smpboot_thread_fn+0x27/0x270
> [   15.661841]  smpboot_thread_fn+0x1bc/0x270
> [   15.661842]  ? sort_range+0x20/0x20
> [   15.661842]  kthread+0xeb/0x120
> [   15.661843]  ? kthread_complete_and_exit+0x20/0x20
> [   15.661845]  ret_from_fork+0x1f/0x30
> [   15.661847]  </TASK>
> [   15.662814] i915 0000:00:02.0: [drm] VT-d active for gfx access

Does this happen to be the same problem as what is being discussed
below?

https://lore.kernel.org/linux-iommu/20220922101036.87457-1-janusz.krzysztofik@linux.intel.com/

Best regards,
baolu
