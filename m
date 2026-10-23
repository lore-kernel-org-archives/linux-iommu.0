Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762445;
	b=m2fDRq8y9TPwOpHo3gv3kuVRYGxFy0xtYCTXOU/HYhzZ/EhnzGtYFLTOVWNBrfx1nokE
	 38iGV+n/SmsEqjm3k7mmSBxkhktuggmNV/CUcqGQxEylt2/SQhkQLLzm+WJ6ezVWJQUUs
	 GqY3iYC3xARWIG2Lo6LSEMDd8uUB3GJtr5UrJULdPkVpkQNOL9RyDa8DTIiH+Ji3B7p1l
	 4oNN9wc5lhckvPqRBu+eOjk3JWadTulZEhpqCUXu2PxAdhyA5zdZ3urqQenFZjePXsigH
	 d+SKN01iwPdzYa/BkqbU1g8xW6j3JvaUi4ybYzYuvfAqQ0yLYsOT51PqdH5FZGvAnzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=TCmOnrpSb85CkuICZLkuWER882/FvQFFbKeLZboWFbc=;
	b=bdXI+xj63+p7f8NavWbOSesKkduc4Q06lY3kbiwoxJzypvihaSxxZOpqvqdxJpy1xQla
	 2tdbR29CTP+zJp0MWLBbSA8yA2VQKIZTnYM4isiFeezVQJDkJH7Imh5AZBN56ItrIOEVB
	 GN1oUuMBuJKIvN+aMSGZEHAlNwfvYHM9IlI3vLShFo4+t333pXVKwqOrhYDV572h2ejJw
	 xq2o5ujF8n0Qmiu13Y6qPB2YjiBHiSlJHFyE1EUO/qiOiHQKMegBYLI7QKjHgaGi+VYXO
	 J2f+hwFBU39cOUsW+4llArpEKqFytngwi95g0TpkC+lU/vJUi0aRAIj/25rdyLWyQXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=HYT266w3;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D88B606A31E
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 13:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D88B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=HYT266w3
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53664b4860bso8122291cf.1
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 06:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792762444; x=1793367244; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TCmOnrpSb85CkuICZLkuWER882/FvQFFbKeLZboWFbc=;
        b=HYT266w3ryHdj4SZ8AJYHxPgrpaaQP6JhCK3ANM8QRBgOwX9oViDsXqVnaZfKzKd0j
         l4zkxqfNq/lMrz/F5XULi4k0ywvYpewGBRTWOLXd6rGT+scZHMOmwT1NXehdM2s6Aetq
         TJ6D7rs9mjBWk2unHA/5MW50XlLVvlEaL2iTfBF5iVXdDfvGglCiknJlnk3w2VjKW78P
         zQVPmb48cUUzEyc+ihVipJVhzPwH92RSA60ToBQ9OLW0gAZZsUzY/gz04AcGtQmOppcG
         f6PI9RKeXm6pu5aEzSlGeugLAj9Irez/PcvnM5e1jICLuCIfz80h6jpe/o9m5Nm9g1i0
         BZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792762444; x=1793367244;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TCmOnrpSb85CkuICZLkuWER882/FvQFFbKeLZboWFbc=;
        b=IGcKUXS9vbivcFu0e5+MZyk31TfZxpyHfOIGB9IO8v9E1YXe/YV5ZtGB5EjO4sgwKf
         5g/U8WpAdhJ1R/I7EP+G5oP5Pp24/pNWI75UABgwBnvsS/raGLcPubJMIrD/eciIloWd
         atuCC1nCd+iz4O9+izCFvpn9gYp3uQ3+eJOFJwvM/P9qtbvAGeBphdyVDH66qECtnLpZ
         sIK57LI82DJsKYCDzZu3QkTkSHOVi/8RFPxu2YcI3lbaIyVwS9bBhEvqC6IqTKnlXE8b
         tqZZ/6BsPFsHhu8s2T3W35x3nnzEt8A0mwaUYCVyMHeqWNHry+tclVDMVPNGJVRsbz5n
         MevA==
X-Gm-Message-State: AFq9FYL39QmvO9NfNvyKVyoyZFnjA7lp/CHOHAGDYV+Bw7e7AznLwM6w
	ej+OkTd3mRbdBwOOVzH918zKuXl9SeYKDr9lwEPMEy3iOIDudofMNLMM7tI96CXydyo=
X-Gm-Gg: AYBFou1yWMq54CLx5xGkiO92se50d4qMo/V9Wb2ErjExkE7sL5Crm6fFszNcZY972f6
	OUZzEupcsisxSJO1WCk0A27OXoc1wBI7gRjdojXf9KFgDKRgN2YRsGzwgaGB692IgigQczFlpoQ
	s5RVofyNK9+tCPqRkklSdd/Sfz3eYERHztyX6J2CFf5bTiGAN0ga4S62AzbBeTLCr55tO+FwgQH
	Z0a4p8503yIpCoJQUls8nRtPOve1O00FXf25aMXO70z4tjLFtoiOyCArZ6gslFRzCSciDYKJ8Zg
	g+S9/GzJEIZl6lbD92LcMAss0C70SOAw5D5YpigqtW1xwZt6GiGQOoUO69ymIpEq0xpwOHLFY+7
	WvJlAx7pUB+xyZOObYSTOK0v0jgpIFBbQphENOGyU4tnqPIW/eEMJPZrMMAw3hZTlw540DuwXJB
	b+6adfe8t6azIutAOfrT2YC6NiFIYLfgGqz+mruVLLTgHaG4jOxoAYUS1ueQ6dCt3HZiLCnbdka
	NpAvT3/Ajl6nei8hjySW5HbrgVLwLz+4ngO054YXAqfJ6IqeX0jsyaGPAjhub5j4SJOcg7uk/LC
	ZYYsnzCl128cpYFpl9EUuHqssJVd10H6oakGRQ==
X-Received: by 2002:a05:622a:e44d:10b0:537:5488:ada1 with SMTP id d75a77b69052e-5375488d9e8mr5137321cf.32.1792762443817;
        Fri, 23 Oct 2026 06:34:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c4529e899sm1552196d6.37.2026.10.23.06.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:34:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKFPG-0000000Ggcg-2JDx;
	Fri, 23 Oct 2026 10:34:02 -0300
Date: Fri, 23 Oct 2026 10:34:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: syzbot <syzbot+2a4570d89a1e13003dbf@syzkaller.appspotmail.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, syzkaller-bugs@googlegroups.com,
	will@kernel.org
Subject: Re: [syzbot] [iommu?] WARNING in iommu_setup_default_domain
Message-ID: <20261023133402.GJ3381610@ziepe.ca>
References: <6ad19ce4.7952420f.283480.01c3.GAE@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad19ce4.7952420f.283480.01c3.GAE@google.com>

On Thu, Oct 15, 2026 at 08:41:24PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b88c841d1164 Merge tag 'input-for-v7.3-rc6' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=117d540d580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=44ac479246d4559b
> dashboard link: https://syzkaller.appspot.com/bug?extid=2a4570d89a1e13003dbf
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b88c841d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e27770b53aa6/vmlinux-b88c841d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3a314a5eb19d/bzImage-b88c841d.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2a4570d89a1e13003dbf@syzkaller.appspotmail.com
> 
> R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> ------------[ cut here ]------------
> ret
> WARNING: drivers/iommu/iommu.c:3205 at iommu_setup_default_domain+0xbb6/0xf30 drivers/iommu/iommu.c:3205, CPU#2: syz.2.802/11603
> Modules linked in:

This is from a fault injection hit in the intel driver..

[  382.158650][T11603] FAULT_INJECTION: forcing a failure.
[  382.158650][T11603] name failslab, interval 1, probability 0, space 0, times 0

[..]

[  382.158831][T11603]  ? lockdep_hardirqs_on+0x7d/0x110
[  382.158850][T11603]  ? _raw_spin_unlock_irqrestore+0x3b/0x80
[  382.158869][T11603]  cache_tag_assign_domain+0x1f3/0x650
[  382.158888][T11603]  intel_iommu_attach_device+0x706/0xe00
[  382.158906][T11603]  ? __pfx_intel_iommu_attach_device+0x10/0x10
[  382.158921][T11603]  __iommu_attach_device+0x73/0x340
[  382.158935][T11603]  __iommu_device_set_domain+0x178/0x250
[  382.158951][T11603]  __iommu_group_set_domain_internal+0x1b1/0x450
[  382.158969][T11603]  iommu_setup_default_domain+0xb9b/0xf30
[  382.158990][T11603]  __iommu_probe_device+0x1174/0x1550
[  382.159007][T11603]  ? __pfx___iommu_probe_device+0x10/0x10
[  382.159029][T11603]  iommu_probe_device+0x28/0x130
[  382.159045][T11603]  iommu_bus_notifier+0x5b/0x110
[  382.159061][T11603]  notifier_call_chain+0x99/0x3f0

Which causes initial domain attach to fail:

                /*
                 * Drivers are not allowed to fail the first domain attach.
                 * The only way to recover from this is to fail attaching the
                 * iommu driver and call ops->release_device. Put the domain
                 * in group->default_domain so it is freed after.
                 */
                ret = __iommu_group_set_domain_internal(
                        group, dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
                if (WARN_ON(ret))
                        goto out_free_old;

Which we can't handle in any sane way.

Not sure what to do about this, it doesn't seem like a real bug to
worry about.

Jason
