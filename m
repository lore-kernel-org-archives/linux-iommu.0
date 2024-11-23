Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006254A0A
	for <iommu@lists.linux.dev>; Sat, 23 Nov 2024 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732377965; cv=none; b=g7LG9yCENw6K0zpJV1R5XKbKCXfluYccSR7ag8qrBGTby6VktX5M9SUlME7AcPsU02HRv805Dbin0zdvoojywb/vsUKHsQ8VYLFntUbd52BgxbmKHryE3xxR+10Kji7ZO9nCtlM2uhI1rqgdIuSGsOE+lnFDuLMiHwBcKUzWB1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732377965; c=relaxed/simple;
	bh=/Oe7C8tWFR+WpQtX4zy0qvLDM/utxO6jL0VZWbq3xac=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r62JtzgBLJ9g7DEZkToy6h2Djif/hOxKzB4rqMEGutlHPhKaDCexKnbLYHZj/YSYZfznUII2q2iepl8Uo97e4quSk328diNhBkFUYjlwjQEdm+lvWCITHwzmauudv4cOMqWphuvjGNk8zy9vVpTbGRPCdDZKvmXTd9K1fPlLGPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83aac7e7fd7so351955339f.0
        for <iommu@lists.linux.dev>; Sat, 23 Nov 2024 08:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732377963; x=1732982763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LX7/6JCZjAchMCgt4YjUfhqTQQacnrhf6k9MzJL65s=;
        b=nHEyNkzS5suYpUA4fWJQUEWjXXzLTcJuy98KTuiHJotYEKpb0r58ENF2TkP06BR3tM
         iNYuYxb0iIkm29/Vwx8wD+sRmrGE0Fb4LAL5XumLKzhMtHrBDQlNo5MIl8Af3HXvBqsI
         zB3MuQwYJv++uWc3UO0BK9wlk+f7YMwLjenNAb7DmlL1XLtXsDmaptqdsJJDJWa4AxW1
         aE4NFW5zKwMDlLn5PTpLg+/XtT0enq2/6JuBtDDtlBQdRvwQS6Yb0e9dQ7l5EuRhCUZc
         5Nou2ucbdIgoceHP6NQ3QbDL+fa0vVhNA7YajkT2aajKn9OxwbTBx3SvsO0gnGmSfe6Z
         nACg==
X-Gm-Message-State: AOJu0YzfQS/o+f1wr4qv4lJuPe1jcaQK1GbbnyafTKJsY/YhDOLJbrgo
	jsvwxwCwETxRAKP1IB4piie/G19jK2jza25qcEo70s1xiH+dHWeCBavYjiOdblhQOB+/FjYltpd
	z0rpzOZTjmYeoDePM8LD29UcmDP1Rr3OHRyt91Aaoz3ZipKFNUkWRzoo=
X-Google-Smtp-Source: AGHT+IHid+DYZc0rutOVjJkXhhK/zT4IGdk50i6NK0wDiOleYfjLPSpHE43QmXfMhzjwKaijD9FmOdOtiyzjhAeftaObjZP0fY7h
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c41:b0:3a7:6e34:9219 with SMTP id
 e9e14a558f8ab-3a79af336a4mr52136325ab.14.1732377963227; Sat, 23 Nov 2024
 08:06:03 -0800 (PST)
Date: Sat, 23 Nov 2024 08:06:03 -0800
In-Reply-To: <CAHiZj8hNe6jgUgZ=FViJV33wd89cpeHeEX-Ak02nn97t2yGiHQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6741fd6b.050a0220.1cc393.0018.GAE@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=17ab7b78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=c92878e123785b1fa2db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=121981c0580000

Note: testing is done by a robot and is best-effort only.
