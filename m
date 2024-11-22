Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EFF22339
	for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295105; cv=none; b=qQR0R+K+gPuH5yivt8Ci7eHW0qa56wrnmf0IdqcY8V6HC8MLYZuzmgFphUV4M3o4rZMvczGZESs9M4X8wOf7xe6jZMhL8XhPl5u2OhmhNfTMmWSQKbU8AmCAon71NZzGZUhSSjYHKfKYEz1atmy7thQ5cDzBJm2AV0RsKnsktMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295105; c=relaxed/simple;
	bh=fiILnnkT0f3Sk6+TIANC+LOPxiJ9Dbug9M8chnDoeEQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KTLatZoBo7OA0g6fjg0JmJr3HzG/A0KcOD/FE4G+c0Au2UlwjNm6ilMaib7BGI4B/ihEZQZajZxDYwsavpp2Lv0wvJw7tKxn0IbGzjLpABFqIiGDgOB+4hzt5NsWtADDuBaP/SZtJFzJ6lG0PpuywAq+Hs5zVA+fqAPGfRI3oE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a77d56e862so18790085ab.3
        for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 09:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732295102; x=1732899902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiYt7JnYh8zSIrdwmS1xz/AnJ63+g27Xyvtfwt9f9Yk=;
        b=dvgteD8k6t9PhJtvS9TFnLElRTgrUyLqDadM1EzqYZ2tlADnAqhJaOsIgmVciDxYJZ
         bwxpZOZk9EsYfEnlcbtw6wcittgNkrI10fcLlW4uFqgA9u4q+nVOzG4e2CkWZ3nbeH9c
         KX05ikSXhPU3RJJSrrJ6fggRlAw42Qpuyx4drYGjaiLBrcJdItWJMUxq7uYUWEKuj54q
         K+KU5RX5T3aMHfWlnv6zBy/vGal+vGaEhZAsjKwJp9Jqm2LunkC4EYcy9HQcTYGlsRgB
         w/DySsUX8do94tyZl3l+xrw9aGhtP7yZ57dlvkzFqVCX0tqK7nXdRwfw+4DMtUd2/ksK
         IaDw==
X-Gm-Message-State: AOJu0YyoZf/Q1dujS+Xqg9CrngoXnp+7Koc0i/Utj1sSPE9xq4vIySNP
	6/kYA/1fecMdak2eKr8UqJ5JxXqMthJ67EdtbfrEpCGy9Ngz38MCEOIHJXc7KFNDUpEaai5DSza
	IPbX5flvvOkXQMuMBSoIyAL8h/Id+BiPYGZM7RX24CIHJufRJdt3XvoM=
X-Google-Smtp-Source: AGHT+IFxLqmKQQ3aDbt+/5R15HP+DurTHA2Yuys20IgxFrah37Vht3qInWPtVRNe5MlFLAOiOjVTECXectC98XU+KRlfDDXCmHI9
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a82:b0:3a7:86ab:bebf with SMTP id
 e9e14a558f8ab-3a79af6d1b5mr41537495ab.19.1732295102747; Fri, 22 Nov 2024
 09:05:02 -0800 (PST)
Date: Fri, 22 Nov 2024 09:05:02 -0800
In-Reply-To: <CAHiZj8g8dFUZj+wL5Z-Y_aL4wM-ZtC0uymGytx-oFNAWUEBz1A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6740b9be.050a0220.363a1b.0148.GAE@google.com>
Subject: Re: [syzbot] [iommu?] WARNING in iommufd_device_unbind
From: syzbot <syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	surajsonawane0215@gmail.com, syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: trying to register non-static key in iommufd_object_remove

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 UID: 0 PID: 6664 Comm: syz.3.18 Not tainted 6.12.0-syzkaller-07749-g28eb75e178d3-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 assign_lock_key+0x241/0x280 kernel/locking/lockdep.c:981
 register_lock_class+0x1cf/0x980 kernel/locking/lockdep.c:1295
 __lock_acquire+0xf3/0x2100 kernel/locking/lockdep.c:5101
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
 iommufd_object_remove+0x3b7/0x770 drivers/iommu/iommufd/main.c:149
 iommufd_fops_ioctl+0x4d6/0x5a0 drivers/iommu/iommufd/main.c:418
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd7df57e759
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd7e0445038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd7df736058 RCX: 00007fd7df57e759
RDX: 0000000020000400 RSI: 0000000000003b80 RDI: 0000000000000003
RBP: 00007fd7df5f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fd7df736058 R15: 00007ffc4693c708
 </TASK>


Tested on:

commit:         28eb75e1 Merge tag 'drm-next-2024-11-21' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12817ec0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=c92878e123785b1fa2db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16933930580000

