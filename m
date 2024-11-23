Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6BC17DFE1
	for <iommu@lists.linux.dev>; Sat, 23 Nov 2024 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732361525; cv=none; b=ihxosXJFSo/FChstnixpqwxeSzidWx78NYU00aMtNigaLsvKEgO9CoV0Mc0jtJ6S1hOj+MMtyJuW7RGrj+WyLZivg4Dvi1mYjaZX1fBmkHzPewPDy7vo817L7IGJYEbmwgIctkCltRkUefethTPmFMlVNJ/4sjRL+dd9FuvbxHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732361525; c=relaxed/simple;
	bh=VR9S+T9x6z73xCX/A+Ll7XmOsXI4DQ+M1rnDvBMIyng=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NaNeaLjYSiittY4jX8q7q6w/8Aa/LpjUGWagjKCaS6H/MN/bIrM5BlAuZTjEzjLJ0BCAIs8aGEXMONvJpi4s3OUkyVidSyEYJoqpla9awQ+vyF7bRU+ffm5rMVLJYTP33B05WZmI+sCd3FJGmGQw7m+CojRaxrKCmy3COW0qTGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a77a2d9601so34126715ab.3
        for <iommu@lists.linux.dev>; Sat, 23 Nov 2024 03:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732361523; x=1732966323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUSQB/mQEeRuUVXWDbOrYsEhon4hx55di7nuoYsi+oo=;
        b=V3isNO4Se8Egv4v7050hHrstVv94OUeZBfw9BCrO+kMm+T4CuVcwYeKn0bKv742BMr
         6rcaZkTvgycyl9re/FfJC9wckkV1qB4d3wdGfPR3mcA0M9Rzb8hAJg0N3kjx45GlydyD
         m5RK8SSUbZzlaPZngXL5RvjwHf/12FtXKFeWtuoifvDF/V2pDSJlMIC6diA11Rjp2zys
         FJdczHS5ZChbt3jAYTtNxii2aiCXaZKfW0UGFlg+Rcr6uLxZkkGM4aSigg5oOp/JGfz9
         3PX9+kgc2WeuGipTaNpntxjjIhPEgSiUcD5MMurBwL04KXxO0JQW9F2yo0R3uTbgBU1I
         etdQ==
X-Gm-Message-State: AOJu0Yy/1FxcYGrDqidm6rf44IlPywBTKlE0KlttxtfaDiYdSfMeb9cP
	vMKI8J3s242a0OaWfTP+KS+SPr4PokdurIioFESNCvgF5utI4VyZyDHl/BsLc4BSzWoGoZ6bD6Q
	ZJqHeeCNgs5OiBA8fGC63sQDkVnIcKgL8mgmZEJJPNHwCbq5k1Izj3cc=
X-Google-Smtp-Source: AGHT+IG6z2DCg+rBpNnSGiWA28O5+iiELMj1GHBPUJFVhA9IbHCbJKfyUq05vY9BuhNx00BDZMDiO54vlZHDbogIk6ZwMMp9Jtzb
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144b:b0:3a7:44d9:c7dd with SMTP id
 e9e14a558f8ab-3a79ad27697mr68006295ab.6.1732361523582; Sat, 23 Nov 2024
 03:32:03 -0800 (PST)
Date: Sat, 23 Nov 2024 03:32:03 -0800
In-Reply-To: <CAHiZj8gkf+W5dt7SeK3T9ZRe0-c72=TAciiCsho6+1vL2T2Upw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6741bd33.050a0220.1cc393.0008.GAE@google.com>
Subject: Re: [syzbot] [iommu?] WARNING in iommufd_device_unbind
From: syzbot <syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	surajsonawane0215@gmail.com, syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com
Tested-by: syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com

Tested on:

commit:         228a1157 Merge tag '6.13-rc-part1-SMB3-client-fixes' o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102a81c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=c92878e123785b1fa2db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1686975f980000

Note: testing is done by a robot and is best-effort only.
