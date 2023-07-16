Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77051390
	for <iommu@lists.linux.dev>; Sun, 16 Jul 2023 02:57:24 +0000 (UTC)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a41b765478so6252175b6e.0
        for <iommu@lists.linux.dev>; Sat, 15 Jul 2023 19:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689476244; x=1692068244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AV1p85HbsZJ9THimnEm3QDwwQ23M02O0o2ECpycPfwE=;
        b=FbuFN0fPtH+QE71z/H1xxd9Dv5iiCRnqzek9+S8a41r5rB7i64L96hXuzIny5gO4ML
         /tXwsKa1WHT8K3JeDsFfVgTD0l2ZwtCxM+27OxASZUXSfg9fJ127clB+du9Uq6hXIZJm
         HMHRkC27sRRAASnVSbkWe1Yvf/E8kqlYctw6GZwZH9x2SSU2RuD2hZ7kg4U2rm4IpbdS
         9GqnakuIcA5poY8uD29b3mLjQ+JhFH1HhkgEA8QjedCM2BdPB/aSnXwJrD7ueN6SlUqU
         HsI0K6DcK/k5mfAG33yMnjkfF00gezMyPPErFIGXlQGoYs2evTudrKzz5I/BuHPjM7DX
         BFOg==
X-Gm-Message-State: ABy/qLYKgipJZqIq6dPnrfFsGYR4cgbQSC1TqxjAuCvMeuDyJETsCuMI
	76xkJw2n2GlBjHIKXPap1zzlqbIN/3+jENEQgZTZqT0Ksf02
X-Google-Smtp-Source: APBJJlHXRLig0RINXY3j+dbjr1Lw0gM/KWkDKlJRrUJRkV/EIhqOm6+gsAeWprJYorKp04zmsmZJzjX1koudKJo1771XcG86+k/s
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:30a5:b0:3a4:4b42:5ce1 with SMTP id
 bl37-20020a05680830a500b003a44b425ce1mr4442302oib.3.1689476243880; Sat, 15
 Jul 2023 19:57:23 -0700 (PDT)
Date: Sat, 15 Jul 2023 19:57:23 -0700
In-Reply-To: <00000000000054bd5b06006df9c8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f80ad060091d7cb@google.com>
Subject: Re: [syzbot] [iommu?] WARNING in iommufd_access_destroy
From: syzbot <syzbot+7574ebfe589049630608@syzkaller.appspotmail.com>
To: alex.williamson@redhat.com, iommu@lists.linux.dev, jgg@nvidia.com, 
	jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, nicolinc@nvidia.com, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, terrence.xu@intel.com, will@kernel.org, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 54b47585db6658a5eb898d4d45be18d1e581c1bf
Author: Nicolin Chen <nicolinc@nvidia.com>
Date:   Mon Mar 27 09:33:47 2023 +0000

    iommufd: Create access in vfio_iommufd_emulated_bind()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16549b42a80000
start commit:   b6e6cc1f78c7 Merge tag 'x86_urgent_for_6.5_rc2' of git://g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15549b42a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=11549b42a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6769a69bd0e144b4
dashboard link: https://syzkaller.appspot.com/bug?extid=7574ebfe589049630608
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123562dca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15825e1aa80000

Reported-by: syzbot+7574ebfe589049630608@syzkaller.appspotmail.com
Fixes: 54b47585db66 ("iommufd: Create access in vfio_iommufd_emulated_bind()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
