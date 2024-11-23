Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC2F4FA
	for <iommu@lists.linux.dev>; Sat, 23 Nov 2024 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732348385; cv=none; b=jquMCaoJy0okOKPeuejvj8Iq59fZ4lgkNujKc3hXq5nu1zMx63Dlyu4ThveHc4E48kAyduKOCu9oyesZa/NQ9IQjlqeo6I2ZP7rPn59uNSFCge/vWmX9ZUeuS4BSP50qLVIStJcrYhsTKkIgeCVVjokEv7JNshbr+LM+feAT+ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732348385; c=relaxed/simple;
	bh=CG11Mx8KJkmxhvRSr96DMSc5GR6zw2edXVk/mbwpfAQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d1cDH0jYQ3hnzwzsPLJwfpjDtXcOzHW1v1NKg/87WEY7amyJhRxTiWwvMtPGS/p1211w0dnUC1AeN49xw59WZg8cYimdzfMY/c1IviMPA3kQcupKgRtMUf5Wx8pKfi6b4HYMfoG2V0rdkaS5Xg8bufbM20ewejy0PTnsUmEthh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7807feadfso29723485ab.2
        for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 23:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732348383; x=1732953183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fia97Z7ySxbHcy6nJJ1KE40vgds2YxCSDRL+lj8H8Fk=;
        b=FC70Xvkdk/bF08mnCN+c/KmzieTwlQa1RceuQMvqPExeBcXKU56xlc8uul4kEcjzja
         S1xztSuRm6aonpH+C0kUmntZpiGCb0koLIJWfHQAUE4NXd4MMrmUmkYSA+N93aFiCRID
         1kRc/PupKvbYQxT9rs8OZ2s2ZunDZMFf+29buV/JNpbu9108c9tewUiQWYqe49rlb3tS
         NctGRCbN6mZSZ8ATv6mjGFHpuZNDJlGW2tzZb13pUsfvl0viqdT5USRaThl2YfYQlRJL
         XU43mo1hqL7BiiI7vPfVPY8N9YhupF/2IljsMIEERzr56DBZ3ylsl161NYrJ/yCTknNt
         kWPg==
X-Gm-Message-State: AOJu0Yy5w+bovGmg2qVDMSQkLJ+adWZiHqemLohy82SQl5PESblvjJWi
	oqHpfk3Q4p+HQ7FF6te1tJS+H0FQK4+6HLtsRgh/cQlg/2rjDyctwmsM7tfhAPLIneXIqttLcW1
	v9XJULpz89klCO3Eki3lPiSJSWgUFfwQsOGNiUYsiD/9iIuuldHoG4UE=
X-Google-Smtp-Source: AGHT+IEqxcV6I3j/RJyVchz+nWxacuko23+9Krqko8Becp3DyMBhhDMdcGPIwWeqsAQCL/0jU1lF4+Up42cGWOWwnkmEUbugNsA6
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c9:b0:3a7:8040:5962 with SMTP id
 e9e14a558f8ab-3a79ab8148bmr74494225ab.0.1732348382981; Fri, 22 Nov 2024
 23:53:02 -0800 (PST)
Date: Fri, 22 Nov 2024 23:53:02 -0800
In-Reply-To: <CAHiZj8hcN-OVsfB9f1fx_bTX561j_Af2rW4L3e0+hM9kptN3Yg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674189de.050a0220.1cc393.0002.GAE@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=16f5bb78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=c92878e123785b1fa2db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1350975f980000

Note: testing is done by a robot and is best-effort only.
