Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73536AD50
	for <iommu@lists.linux.dev>; Fri,  4 Nov 2022 21:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667597240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YoZ/g2DAWgongxe9b4hSKenV+1Uju4Pu+Tb56vnaUnc=;
	b=Y0YAndLmOxEUpvp0rXx+IX9akdc/syItKns7d72r8qZG9WQpBh5+YPIZpMjXGb3iFUP79i
	7o0y/0bIOwCC8V2a39N2BaL9+5jNqDS3XpYaMfpD8iX+XcEVRzwCIrKg96RFhXI5GtdQBp
	MYTg9hojxEAwDGqrgcURvU/5aeVLMGc=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-34-VI4Fi2sHPkOzMUFsdWGyjA-1; Fri, 04 Nov 2022 17:27:17 -0400
X-MC-Unique: VI4Fi2sHPkOzMUFsdWGyjA-1
Received: by mail-il1-f200.google.com with SMTP id j20-20020a056e02219400b00300a22a7fe0so4675392ila.3
        for <iommu@lists.linux.dev>; Fri, 04 Nov 2022 14:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoZ/g2DAWgongxe9b4hSKenV+1Uju4Pu+Tb56vnaUnc=;
        b=3OZ5SA0QADyu2M5B2mNkzLfkTJXICwSAFHfK1aWfzzIC4eSirENXqoO5uaYBAD0TdA
         uMS5jw8j4YyIWM2f+suKb+7H3qKvYmuVKXyGb1eiLwl8AHk47xQ2qgv3vyRJzV5Uya1Z
         7PQ/vi7Emp/Z19vtYIq6XlZJ924gg9TED9eBo56qGw7n4JmSZoZp6PS0ZTLD6WcnyLGS
         yLjY51pMZdUOvbSBmFH0nyLkAJVIq4ugEUEdm457xGuIZTU/T1CIltSQXnwfs/JRk6+9
         a0/Zm1ptUlXh5dFaool4g77f+XftF5DVE5OSsV84yOUaqk9FserIxU1MhyakOtbz4bvs
         57WQ==
X-Gm-Message-State: ACrzQf3nwjzD3bV7XaizRYqcbAOxPz8CrYCv0UAITED/N62SpiJthzA9
	DUJvEA40Z4KzHMFaZTj3LMmV3Ck+yCnU2ONG6gUDTPaWl5xLNWvfTNki60lls1TI7AiZX+rwIT3
	H9mxjTKEFZfO5bEM=
X-Received: by 2002:a05:6e02:214f:b0:2fb:cffb:3182 with SMTP id d15-20020a056e02214f00b002fbcffb3182mr22382688ilv.161.1667597236130;
        Fri, 04 Nov 2022 14:27:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6xntdoFJKVfpeppsLDlrkfZ0zh5SfnW45NbHgq32Vi/+W9JWLm/9wuAT8FlOqwG8d2w81aMQ==
X-Received: by 2002:a05:6e02:214f:b0:2fb:cffb:3182 with SMTP id d15-20020a056e02214f00b002fbcffb3182mr22382662ilv.161.1667597235835;
        Fri, 04 Nov 2022 14:27:15 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id 67-20020a020a46000000b003636c046e73sm30446jaw.95.2022.11.04.14.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:27:15 -0700 (PDT)
Date: Fri, 4 Nov 2022 15:27:13 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, Kevin Tian
 <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Shuah Khan
 <shuah@kernel.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Daniel
 Jordan <daniel.m.jordan@oracle.com>, David Gibson
 <david@gibson.dropbear.id.au>, Eric Auger <eric.auger@redhat.com>, Eric
 Farman <farman@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Joao Martins
 <joao.m.martins@oracle.com>, kvm@vger.kernel.org, Matthew Rosato
 <mjrosato@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Nicolin
 Chen <nicolinc@nvidia.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Yi Liu
 <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 00/15] IOMMUFD Generic interface
Message-ID: <20221104152713.3ae1c409.alex.williamson@redhat.com>
In-Reply-To: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Oct 2022 15:12:09 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> [
> At this point everything is done and I will start putting this work into a
> git tree and into linux-next with the intention of sending it during the
> next merge window.
> 
> I intend to focus the next several weeks on more intensive QA to look at
> error flows and other things. Hopefully including syzkaller if I'm lucky
> ]

In case this one hasn't been reported yet (with IOMMUFD_VFIO_CONTAINER):

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc3+ #133 Tainted: G            E     
------------------------------------------------------
qemu-system-x86/1731 is trying to acquire lock:
ffff90d3f5fe3e08 (&iopt->iova_rwsem){++++}-{3:3}, at: iopt_map_pages.part.0+0x85/0xe0 [iommufd]

but task is already holding lock:
ffff90d3f5fe3d18 (&iopt->domains_rwsem){.+.+}-{3:3}, at: iopt_map_pages.part.0+0x18/0xe0 [iommufd]

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&iopt->domains_rwsem){.+.+}-{3:3}:
       down_read+0x2d/0x40
       iommufd_vfio_ioctl+0x2cc/0x640 [iommufd]
       iommufd_fops_ioctl+0x14e/0x190 [iommufd]
       __x64_sys_ioctl+0x8b/0xc0
       do_syscall_64+0x3b/0x90
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&iopt->iova_rwsem){++++}-{3:3}:
       __lock_acquire+0x10dc/0x1da0
       lock_acquire+0xc2/0x2d0
       down_write+0x2b/0xd0
       iopt_map_pages.part.0+0x85/0xe0 [iommufd]
       iopt_map_user_pages+0x179/0x1d0 [iommufd]
       iommufd_vfio_ioctl+0x216/0x640 [iommufd]
       iommufd_fops_ioctl+0x14e/0x190 [iommufd]
       __x64_sys_ioctl+0x8b/0xc0
       do_syscall_64+0x3b/0x90
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&iopt->domains_rwsem);
                               lock(&iopt->iova_rwsem);
                               lock(&iopt->domains_rwsem);
  lock(&iopt->iova_rwsem);

 *** DEADLOCK ***

2 locks held by qemu-system-x86/1731:
 #0: ffff90d3f5fe3c70 (&obj->destroy_rwsem){.+.+}-{3:3}, at: get_compat_ioas+0x2b/0x90 [iommufd]
 #1: ffff90d3f5fe3d18 (&iopt->domains_rwsem){.+.+}-{3:3}, at: iopt_map_pages.part.0+0x18/0xe0 [iommufd]

stack backtrace:
CPU: 0 PID: 1731 Comm: qemu-system-x86 Tainted: G            E      6.1.0-rc3+ #133
Hardware name: System manufacturer System Product Name/P8H67-M PRO, BIOS 3904 04/27/2013
Call Trace:
 <TASK>
 dump_stack_lvl+0x56/0x73
 check_noncircular+0xd6/0x100
 ? lock_is_held_type+0xe2/0x140
 __lock_acquire+0x10dc/0x1da0
 lock_acquire+0xc2/0x2d0
 ? iopt_map_pages.part.0+0x85/0xe0 [iommufd]
 ? lock_release+0x137/0x2d0
 down_write+0x2b/0xd0
 ? iopt_map_pages.part.0+0x85/0xe0 [iommufd]
 iopt_map_pages.part.0+0x85/0xe0 [iommufd]
 iopt_map_user_pages+0x179/0x1d0 [iommufd]
 iommufd_vfio_ioctl+0x216/0x640 [iommufd]
 iommufd_fops_ioctl+0x14e/0x190 [iommufd]
 __x64_sys_ioctl+0x8b/0xc0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd1eee7c17b
Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ed ac 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd9787b9a8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd1eee7c17b
RDX: 00007ffd9787b9e0 RSI: 0000000000003b71 RDI: 000000000000001c
RBP: 00007ffd9787ba10 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000c0000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

