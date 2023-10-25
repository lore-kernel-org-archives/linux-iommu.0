Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763EA2AB45
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KzjLHT5l"
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-3b52360cdf0so483624b6e.2
        for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698258742; x=1698863542; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ITofy++IV5vAJ6Tm+pHoA0acLIWPFQv5Ue2A3iNM5o=;
        b=KzjLHT5ltIXZFF7NDYcBngwy2zCyr6eO+0THvm5nXINFjOYevR7n7/Osws4X11fpPg
         twVlZQm5UIvYqUI+Jldy3Rg+YjTIPt1CNpssXXPBvR6af4AHsr0Wo4+aCETbCM9hjyCb
         GB8shk0JhJ7qsQFRaS6wAErDTeAwFtHllU7pQt6fhop+E5mZNQKypTNU42XkVi8r8Zxx
         cRqTxoUTKlvaFfCbLQZyh5Cy9bXfekEAZR4R8+dmDcOCv731x2XJlTAmefagyooUZ5p5
         8KSUhDkhndjicsFjdsdN5LjCCNavnX03JIU69srgL08smFC9FLw8znVha254hAH2huXf
         uVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698258742; x=1698863542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ITofy++IV5vAJ6Tm+pHoA0acLIWPFQv5Ue2A3iNM5o=;
        b=KE1NmFpZv6OVFPRhq/Lt1SwywAwAD4+lJdRMbYckH3h7xNfV+rfUftrq0tIrYb4kTa
         cNDlZdPKHDjBlxb8Y6y30suyMN0xOBYxRHkdNnQFiv6D6o0xMWrfpEb1K2DsHpsKsXKE
         NT0g7yBeZ0evE2zxa9ZoAdCNnMIJuFLtpBRhoMmsoZEgq12/e/JKyItO5imcEkvoujU5
         Ed3Wy5FymyVOFquQOHfGAHIWtx+C21U5B7Ye2MBA+lpkdRaScpeQMnz2sK4rNIDV3SEO
         ZbY4VIXBJGOg2VI0NKCIRb+dDWV1Iocbm3ZmgsqvS4uEHLyNinzQ3MhqKvvwEYHJwSCo
         XnPQ==
X-Gm-Message-State: AOJu0YyHPD8eMnbYxPLuzv3hFB7Y1lwmeYdJl2Th3o1CC+dcmK8+qADG
	MQ4lL1tkdhtKhQ/wKvX8rusYGg==
X-Google-Smtp-Source: AGHT+IF3zGyOio/TyOgUPNVF8bSfN9eycyQP3oHU1zL2/yr7Aw+jM1elK8/PMy/0y8tVVtoMH4HvQQ==
X-Received: by 2002:a05:6808:b29:b0:3ab:8956:ada4 with SMTP id t9-20020a0568080b2900b003ab8956ada4mr13619518oij.10.1698258742362;
        Wed, 25 Oct 2023 11:32:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id bl29-20020a056808309d00b003b2e4511f22sm2468353oib.17.2023.10.25.11.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 11:32:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qvig0-004vSE-Mf;
	Wed, 25 Oct 2023 15:32:20 -0300
Date: Wed, 25 Oct 2023 15:32:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: syzbot <syzbot+45f6cae2ca8c1f71e529@syzkaller.appspotmail.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	syzkaller-bugs@googlegroups.com, will@kernel.org
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in
 iommufd_ioas_iova_ranges
Message-ID: <20231025183220.GQ691768@ziepe.ca>
References: <000000000000d621b406088a2f55@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d621b406088a2f55@google.com>

On Wed, Oct 25, 2023 at 06:11:01AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c3200081020d Merge tag 'block-6.6-2023-10-20' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15013471680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=849fe52ba7c6d78a
> dashboard link: https://syzkaller.appspot.com/bug?extid=45f6cae2ca8c1f71e529
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/caa5c1eed3ec/disk-c3200081.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7990a3a9f71e/vmlinux-c3200081.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/015551ac9acc/bzImage-c3200081.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+45f6cae2ca8c1f71e529@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in __up_read+0xb3/0x690 kernel/locking/rwsem.c:1342
> Read of size 8 at addr ffff8880283c9068 by task syz-executor.2/30372

Oh *ugh* I knew about this limitation once and forgot about it
apparently.

  CPU 0         CPU1
 down_read()
 up_read()
                down_write()
                up_write()
		kfree()
 [..]
  tail portion of up_read()

I suppose the rwsem should be turned into a refcount and completion

Jason
