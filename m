Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D5377ED7
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 20:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787084360; cv=none; b=C3iIk9pRhw9eKc88CMP5Vz3rhOEaDiAhbB1DtAi6r2B7XdXAS86IY1YdUoBjbK5glNXnVfm8Fi9DooXTFmTeh5g5CIZsRKD/pdUnKBLN0Qb9z+wyR3jFDfUTxb2GUloRoPVdXauh9FRA5jN6zufu6ddt5x0UURl+DE/rM4WyeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787084360; c=relaxed/simple;
	bh=23HK3oXGJCkgVXNMMVpJRvDzUtuvfqGaZIzmssHRKms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zr0f+QtkDUZPN9A3VNYVGk/wDu/+9M7xJJftDwHM1HFsm5UCNBnuFewOYiO7utW6qZl4Qb89w6T5rQgyt0ZZ4cWozL2XngXDfylepkgQ198LtFoIcH7LGHNP2NBZKkGV6NmnwTNebWiAvadpXl0R7yqTXUTZuITbQ/Rox+fX+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fCmDMLbn; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fCmDMLbn"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7ee4399c3abso194639a34.2
        for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 13:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1787084356; x=1787689156; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jZlmslRhHAtCSzaMTa4W5Bc0ab0HyjyPNsfXiZbsD5o=;
        b=fCmDMLbnLA1iVfMqdQHkIuUHpCYe/AqcDVFalNQ4H9+5TK42NWxzv9qQb8jXb09Bm4
         /+ukShXn64hihouyIQz3zimiBF8G/nFGuOOllIHRapnQNGNuznuf7dYEwfLNTsp3o7tk
         e14iWOCEZNv7DtPWytGgrwGE8WSgW7ELhFkom1tmu/n+SPuCFqet9JpVCLwtKpZvZMwB
         PCG75ZVfHbQbycrndrbsqNdJLLH+qx3eghLQfoAaMO38e5w9syGh+Dm1YthE95H9/Zae
         fARTGhB1YI6Dyt8N7LWdACVW4VQpZWo8mVngH30R2SZ+d5oBZzOiS2XpemSE6bavi7Vt
         2BSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787084356; x=1787689156;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jZlmslRhHAtCSzaMTa4W5Bc0ab0HyjyPNsfXiZbsD5o=;
        b=bMdO4ePl1BHyUyw9dgcFVG0kFaGgRwUQUJ4nUqa8qfOpcB9/6Dhxl4rgTurUp7V4O3
         VpHPpSem3St1QeujMK5t6W1STkB5WTciYB3MGGVNhVl0Aia1heezLs8burDd/vDE1gJ2
         2gwxQqHbmWeaK26DJU6uc0/AJ6pmq8q8jSwuz69pCcOtaJX319uPDIKDxZBb0XBmF0or
         F+aju8efqrCyvkNmDRvVhRY7AmZL/PXpr6LnZmCPlJS/d+KWVT1Jr+IpCzGaSMt2g1KR
         s1MMFW2IzqmwPLi39sTKdQkO3aZvym7zbKZpoG1nl8WacEaaMqZjZB5IEr84D5blPUP6
         8cUQ==
X-Gm-Message-State: AOJu0YyBKIrrXGRa0hkko4ZBPM21uflaRIpr5ZDaC5guCQ3yw3G2CFrh
	Xw5fFA6yCYe3LSHhTlgJU8rNfvhfeSMQrFtnydEiKZ003t9fDnOsc46sSzUutN/VfZw=
X-Gm-Gg: AR+sD12BhQGc5EwB9dO22QgwhHGcxqH1x0ZJhAUKBexsjPgzwEgj43TYJo0S5V86qSc
	RBndJmCus599YdZBaDQxmGRtnJ2mBrI6kaQ1im2CIhOqC7IltSdHBP9OOlhLl9XZWGShJV0YYFm
	rPUgx67U8INTgw6ZfvcAxUJ5L05rTgJyIxsubyczizl4SOfGtIDLSbPsaZbtbl1GGdLVHjbvFF8
	9nRGZdcWnY4mOyU/N/UGYZm+J2hI/iqAEqfbbTrpIA4X2qFPu5aaXo1QJXurgUM30h9WSR/sFjO
	VX930mUJweO7iwfpEffEaHBIToNgxJFsklHUwLrPku3CcTwNNpBL/06ZXvDm1Y+9DtjvdSVAstz
	26m6vISwL69c53dgOz+Ur3bSKmtG6lfjmOj5UsK4sIinqVZOn1+xvFlW2MpSBMBKj+As/mXmqcJ
	dUwSEv+x2ld6cyCZv79UUm3AvhqJ1RVqtQPjsmRFYbdgo0HQzdVs7s342mGw82nDa2RftmISCkX
	+RwdzDIFkN815bbZfiR7cTeIY1dc+bJOs7vCLQtXtIN/A==
X-Received: by 2002:a05:6820:2215:b0:6ae:941b:521c with SMTP id 006d021491bc7-6b13ad7cd19mr126171eaf.18.1787084356276;
        Tue, 18 Aug 2026 13:19:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1166fd581sm5592640eaf.15.2026.08.18.13.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 13:19:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wwQHC-00000000I3U-2Jmi;
	Tue, 18 Aug 2026 17:19:14 -0300
Date: Tue, 18 Aug 2026 17:19:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: syzbot <syzbot+48637757323884de77a2@syzkaller.appspotmail.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	syzkaller-bugs@googlegroups.com, will@kernel.org
Subject: Re: [syzbot] [iommu?] general protection fault in
 iommufd_ioas_change_process
Message-ID: <20260818201914.GA18100@ziepe.ca>
References: <6a833819.4d75e56a.c9a88.0001.GAE@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a833819.4d75e56a.c9a88.0001.GAE@google.com>

On Mon, Aug 17, 2026 at 09:34:33AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3d6d817622b0 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10b01a9e580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
> dashboard link: https://syzkaller.appspot.com/bug?extid=48637757323884de77a2
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dbb225580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b01a9e580000

#syz fix: iommu/iommufd: Fix NULL pointer deref in iommufd_ioas_change_process when racing with iopt_map_file_pages

