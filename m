Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341CD161320
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730105031; cv=none; b=bDZC6glJzZ5iu3YnQpOZk2qrA4yqNUv53xMjmkdP0qrYoTch0u23iYxY8r4v9ml0L5HAkhAX3+QD4XYwOK/7EXz+JjnWznqoemSfnJIZskP/edKKhUdccG/ZMemclxuapk5lJVOjq5NrSt0gPs9qCbhdu/Olf04uD2AVIynr6rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730105031; c=relaxed/simple;
	bh=ElzZJyrieqd190PEuJjpBp6wjf41o+f9HkdNs1F6n7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NdfpqRW9fybnMz/sZQSMgDAAbL++deXoOgKEm+HMJOtYOn7o5LMsslUu5+ZQyi0xXPU0bGdFMqilJWhZCR3IsTlxghQw3TWD/xAwaQ7FKHTeWtZgLexmYPD34b9oZch1saBENDmmmBAH8f/LLW7VkDtPxJisyUBRerh6vkXuZ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TG2ZtOct; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TG2ZtOct"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C5F013800E0;
	Mon, 28 Oct 2024 04:43:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 28 Oct 2024 04:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730105028; x=1730191428; bh=ReyKRfrg9jgn4ncfr7UpoS/SCn/KD24UtjL
	BaIo1MUA=; b=TG2ZtOctGmHgfS7tLXfKT6HH9Q881mwPMD2SKWx9b2kGJ4aZ/GN
	tcZ/8NjmHV0iYRI+UQ5biFTo3rcRj5ZgAbtjSgnNsogwlVLb/lUC1aFxPlHnQomc
	bk4NznQAOPO5pMrDSDXhx1DymfnayPWoezRRw5KvQ1PFWepAQSch2WWcO/LMfUwu
	+ulpL5x1UZ6ziKjdmtL1ojQkQWuNl4SiGH59N6K9BK4+5IMXVVg4oiumnWfrSFZg
	7ox48THtzmAKGWlU3DXhtyuqz2Ftv5YCtb3qv3RLLLCIg5bLrio0hG/rrRSmNWRz
	GpfXdlsAKN6imM8LteBrMWfPnh8+GJF7ecA==
X-ME-Sender: <xms:w04fZyD6-0gmsFzRIpxp4AP_NMBIx3k0ALLpeV746wTWScE4DNpaQQ>
    <xme:w04fZ8hbeBP8BsMqYIiowjZhh_ZgQh90ns_PWxge61wU7ttHUKVAdvBoUpqlz6wQg
    q_LbEd5iXoNQSY>
X-ME-Received: <xmr:w04fZ1kcdXAeHQInFWtwn1lHiLHRI4T4HhG5Oj3RlUaZI26BEmU6ud5UaVCv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejjedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkgggtugesthdtredttddtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceo
    ihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvghrnhepvdeijedufe
    dtgfektdejtedvudegveeggfeifeevhfffgfdtlefguefffedvueehnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughosh
    gthhdrohhrghdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepihhomhhmuheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegufi
    hmfidvsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepsggrohhluhdrlhhusehl
    ihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonh
    higidruggvpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:w04fZwx0RK6-A6GffiP3pkRsbx6ct6B_TI4L8dvoXSrDrUgAZUdhHA>
    <xmx:w04fZ3T1u1J8NvQmvj_r28nrq4nNKwlua8MBetms4TiLa9rYdQs-Kw>
    <xmx:w04fZ7ZWZHhOTAsEwo99p2Z_nnoNMBokkFDGGvkXiEbrCv7pR3E_6A>
    <xmx:w04fZwQBBp_v0xE5ZXzVPzx6sGs3InippJbdkdXeNr7fLn7W28wQ1A>
    <xmx:xE4fZ1Ms7TAgIedP1B1fyzh81K07MVPTrN46mkK5qiLl5pWK1vQgyiIE>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 04:43:46 -0400 (EDT)
Date: Mon, 28 Oct 2024 10:43:45 +0200
From: Ido Schimmel <idosch@idosch.org>
To: iommu@lists.linux.dev
Cc: dwmw2@infradead.org, baolu.lu@linux.intel.com, tglx@linutronix.de,
	peterz@infradead.org
Subject: Suspicious RCU usage in enable_drhd_fault_handling()
Message-ID: <Zx9OwdLIc_VoQ0-a@shredder.mtl.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have recently enabled CONFIG_RCU_EXPERT and CONFIG_PROVE_RCU_LIST in
our debug configuration file and started observing the following splat
[1] on one of our machines during boot. Searched the archives, but did
not find a similar report.

Not sure what is the right fix as I am not familiar with this code, but
I can easily test patches.

Thanks

[1]
smp: Bringing up secondary CPUs ...
smpboot: x86: Booting SMP configuration:
.... node  #0, CPUs:      #1 #2 #3
numa_add_cpu cpu 1 node 0: mask now 0-1

=============================
WARNING: suspicious RCU usage
6.12.0-rc4-custom-ge7e8d9b44a86 #1 Not tainted
-----------------------------
drivers/iommu/intel/dmar.c:2059 RCU-list traversed in non-reader section!!

other info that might help us debug this:

rcu_scheduler_active = 1, debug_locks = 1
2 locks held by cpuhp/1/22:
 #0: ffffffff8454e340 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x17e/0x7b0
 #1: ffffffff84550ae0 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x17e/0x7b0

stack backtrace:
CPU: 1 UID: 0 PID: 22 Comm: cpuhp/1 Not tainted 6.12.0-rc4-custom-ge7e8d9b44a86 #1
Hardware name: Mellanox Technologies Ltd. MSN3800/VMOD0007, BIOS 5.11 01/06/2019
Call Trace:
 <TASK>
 dump_stack_lvl+0xf4/0x120
 lockdep_rcu_suspicious+0x215/0x3c0
 enable_drhd_fault_handling+0x316/0x3d0
 cpuhp_invoke_callback+0x3c3/0x9c0
 cpuhp_thread_fun+0x500/0x7b0
 smpboot_thread_fn+0x680/0xa80
 kthread+0x2c9/0x3b0
 ret_from_fork+0x4d/0x80
 ret_from_fork_asm+0x1a/0x30
 </TASK>
numa_add_cpu cpu 2 node 0: mask now 0-2
numa_add_cpu cpu 3 node 0: mask now 0-3
 #4 #5 #6 #7
numa_add_cpu cpu 4 node 0: mask now 0-4
[...]
numa_add_cpu cpu 5 node 0: mask now 0-5
numa_add_cpu cpu 6 node 0: mask now 0-6
numa_add_cpu cpu 7 node 0: mask now 0-7
smp: Brought up 1 node, 8 CPUs
smpboot: Total of 8 processors activated (35120.16 BogoMIPS)
