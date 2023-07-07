Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56EBBE6C
	for <iommu@lists.linux.dev>; Fri,  7 Jul 2023 08:30:50 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D2B841FE7B;
	Fri,  7 Jul 2023 08:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688718646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aP3OB0ZCFId8Qrc9kn8zyLUQbkD82C5jAHdpRLDYE4E=;
	b=eUbNpZdKqXG6VLZaOdCXPkOgTLSOChot/P9+AgPmVp0iGnaDSOLmYn266GOAHK6HLcX2tl
	0KUgkdeTVXJN5oG/F16aPyxSM5u/yBV3di5Ue58eIX6q6XhxCDEd07dBiVgXr27KhFAguS
	Y0ouJGvIzDWwOFby+GyE9VxIhqmpZhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688718646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aP3OB0ZCFId8Qrc9kn8zyLUQbkD82C5jAHdpRLDYE4E=;
	b=6JmRYdTRYj4AnFi+ILaAexU4pnLhuAcffEI03MMZceqlhFQuy3RlAjR9itPm7zVZeiLcWA
	8C0Oxs27bI9BUaDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FF39139E0;
	Fri,  7 Jul 2023 08:30:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id NYj+ITbNp2SQPgAAMHmgww
	(envelope-from <jroedel@suse.de>); Fri, 07 Jul 2023 08:30:46 +0000
Date: Fri, 7 Jul 2023 10:30:45 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
	Heiko Stuebner <heiko@sntech.de>, Kevin Tian <kevin.tian@intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH rc] iommu: Fix crash during syfs iommu_groups/N/type
Message-ID: <ZKfNNT1yzDNRj-II@suse.de>
References: <0-v1-5bd8cc969d9e+1f1-iommu_set_def_fix_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0-v1-5bd8cc969d9e+1f1-iommu_set_def_fix_jgg@nvidia.com>

On Mon, Jun 26, 2023 at 12:13:11PM -0300, Jason Gunthorpe wrote:
> The err_restore_domain flow was accidently inserted into the success path
> in commit 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on
> ARM"). It should only happen if iommu_create_device_direct_mappings()
> fails. This caused the domains the be wrongly changed and freed whenever
> the sysfs is used, resulting in an oops:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 1 PID: 3417 Comm: avocado Not tainted 6.4.0-rc4-next-20230602 #3
>   Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS 2.3.6 07/06/2021
>   RIP: 0010:__iommu_attach_device+0xc/0xa0
>   Code: c0 c3 cc cc cc cc 48 89 f0 c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 54 55 48 8b 47 08 <48> 8b 00 48 85 c0 74 74 48 89 f5 e8 64 12 49 00 41 89 c4 85 c0 74
>   RSP: 0018:ffffabae0220bd48 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: ffff9ac04f70e410 RCX: 0000000000000001
>   RDX: ffff9ac044db20c0 RSI: ffff9ac044fa50d0 RDI: ffff9ac04f70e410
>   RBP: ffff9ac044fa50d0 R08: 1000000100209001 R09: 00000000000002dc
>   R10: 0000000000000000 R11: 0000000000000000 R12: ffff9ac043d54700
>   R13: ffff9ac043d54700 R14: 0000000000000001 R15: 0000000000000001
>   FS:  00007f02e30ae000(0000) GS:ffff9afeb2440000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000000 CR3: 000000012afca006 CR4: 0000000000770ee0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    ? __die+0x24/0x70
>    ? page_fault_oops+0x82/0x150
>    ? __iommu_queue_command_sync+0x80/0xc0
>    ? exc_page_fault+0x69/0x150
>    ? asm_exc_page_fault+0x26/0x30
>    ? __iommu_attach_device+0xc/0xa0
>    ? __iommu_attach_device+0x1c/0xa0
>    __iommu_device_set_domain+0x42/0x80
>    __iommu_group_set_domain_internal+0x5d/0x160
>    iommu_setup_default_domain+0x318/0x400
>    iommu_group_store_type+0xb1/0x200
>    kernfs_fop_write_iter+0x12f/0x1c0
>    vfs_write+0x2a2/0x3b0
>    ksys_write+0x63/0xe0
>    do_syscall_64+0x3f/0x90
>    entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>   RIP: 0033:0x7f02e2f14a6f
> 
> Reorganize the error flow so that the success branch and error branches
> are clearer.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on ARM")


Why is this Cc stable? The causing patch is not in any released kernel.

Regards,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany

(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
