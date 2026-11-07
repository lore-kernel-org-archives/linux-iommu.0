Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794034562;
	b=JengaywEd1h6fIKW4UViCs3xSVpl/R4SzbQBiDEG4tPOa7iuIteyX8g+8aXsylCdhZPn
	 hcjesS1kinM5cBJ4aUsRSskhgJ7kXOTkTzbC+OklcJAEO52DS5mZoxxKpivL5gnb8LHlf
	 +Xa3tFpgi7ucDygTHunHh4VHo8/whhrjNJUE0RrQfwPMb1P/TAND00dFSfKtJDH1nNVG9
	 +lMi1TGOLZnSmQAAgFChxZUvWPJqZkDOZL2etwHz2J1yF49SlcY/yG6pSO0D4ckZWVB+R
	 1D+zG2KxWxsWkpvGUQWJUNA5TtDwRwFog3q/v6OK7JVFzmYofahjRvv9oVyeDCQTeYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794034562;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=phssbHngQnmB12RlPBsObvqrdVHaq53PBVYghXvPY1U=;
	b=xVr1t6qhpEAqg754ggueXn4PPUIyzldLp5giQi0qrFhoaUEjMTWbRmV+VbPxcifXOnNi
	 dZLCYFsvXv+iRbDlqflIITozRgLDb5+mHf8/n5L/en6p58h55l+Z9xjVtoOPyQFUs82/p
	 IlNbUwjrxThnvD11kS8iSRJs46pdzEUmli1RHoiA5MkNm4Mnngl3sFh6v6kODGdvAdJLv
	 2arJ8UVfab0wFnI9cr8rKGODwteiBugVUrWMSBqXA1X1Rhn0S9u7P8j9/fI3bSseXppGC
	 ZhUpJAasRKxiCM9rXr/iGgk+QeFFm3V1r6MU3V/DRyRSSW6jtEspn+aGzIDY2sq9AXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6471B606A32C
	for <iommu@lists.linux.dev>; Sat,  7 Nov 2026 06:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6471B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-84586110393so1712383a34.1
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 22:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794034561; x=1794639361;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=phssbHngQnmB12RlPBsObvqrdVHaq53PBVYghXvPY1U=;
        b=FSlYxE8phiYO0VsqOoOQSm/m8+/EHChUcZJIad7N3WdHsxo2XuYKRAE3WuaLj5hFhZ
         H7nfeNO3oLDrULVpDeeqz6gLFpQ+2Ev94W3xjI5d6ASDp91M7DNGrSqwm2xHhZYOciKj
         S18va6HLm5m2F05miw2hpBR9w6kFP70TKDhWFSYkVq60lq/mUzwZ3Cyqa6z8+/6E6gVF
         Q9cl8R9Mpj7ZKDQ8W9SfSpApwRnf/3TaNubCAq9+QMQYUyb7/Zb2woAMyBUeW33x1eSN
         Iv1zhDO8LgowMIrH2HpfLLwE2tDEHhOSqgt17Eo3p5wmnc1l7lE9qbptiiOhQF0HWDpY
         stHw==
X-Forwarded-Encrypted: i=1; AKwUvBykAQgEYaZzluf1kMcWekmTHWPPlh5SXnlviSc0Lwnp3V/4W5B3dNsgYW5I3NzzGid6IUl2hw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8D/TBVaMN99jgL96bzJ8ZbOotle9UGPrU3mPUYFZzfiUKyCuwd
	CmskzQllp9UJCTjMJB2RQhwhTeT3lgBLAgwYk7TgOxbrO1BbZew8lYJPzQlQzplACfqMzjYI2N2
	9XoG0IitGBKQXBWOD6g4TqCjeW5LW0Wd1c9JXbPJ+e0Jq0//o6KZpKf+4LCI=
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1812:b0:4d6:92b3:5c8d with SMTP id
 5614622812f47-567e18782a3mr4307052b6e.67.1794034561414; Fri, 06 Nov 2026
 22:56:01 -0800 (PST)
Date: Fri, 06 Nov 2026 22:56:01 -0800
In-Reply-To: <20261107140000.1-1-diasyzhangqing@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aeecb81.01e61036.17c8d.0000.GAE@google.com>
Subject: Re: [syzbot] [iommu?] memory leak in iommu_fwspec_init
From: syzbot <syzbot+fe84fc6a684e0beb86e2@syzkaller.appspotmail.com>
To: diasyzhangqing@gmail.com, iommu@lists.linux.dev, jgg@ziepe.ca, 
	joro@8bytes.org, kevin.tian@intel.com, krystianmkaniewski@gmail.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com, tz2294@columbia.edu, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fe84fc6a684e0beb86e2@syzkaller.appspotmail.com
Tested-by: syzbot+fe84fc6a684e0beb86e2@syzkaller.appspotmail.com

Tested on:

commit:         d4872371 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14fa24d9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4361b1bb937ae1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=fe84fc6a684e0beb86e2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e0d8d9580000

Note: testing is done by a robot and is best-effort only.
