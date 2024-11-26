Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A05DF60
	for <iommu@lists.linux.dev>; Tue, 26 Nov 2024 01:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585888; cv=none; b=AUDzQOeYf4M5+4GLvJJ7E3qtkmjsV19okLkkL+6DM5Op0+4i3Wz2dmiHKBq2OevevRBqYWeL4glaiMIr+0pGbLEuVvXpQDxFKNDocRS9R2mI8KK/2tltIpbmP9ap4MccPjaJ1IGJbB78RpzjrRgAItm0+ZFhJtoZyfdis88+OJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585888; c=relaxed/simple;
	bh=H0mFerbMaGcm5YSo+5mHe3ECjJkRkraKwOcgif5R6ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfV0VYyaD+t4Uqiq+zfYH/ECkt0pMU1JpEDy0Wb3MAiU2T2V3VNcwPrJw5h4NjSKI7JffRrt0nRGKLc9knsYGKbfwaJCbdm5hDIvc5IzFX9M1t33eNLUHQ/PkCe+tsTbl30VIi1F4KNdui6i99lMN4aVB0JVhSdPrYo7E78sG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtaoZzuR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtaoZzuR"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ea49a1b4c8so4010958a91.2
        for <iommu@lists.linux.dev>; Mon, 25 Nov 2024 17:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732585886; x=1733190686; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aJoYAYmeRsJLY19PSmXmZzQLTbquFpEYT2ck8bCoKAI=;
        b=ZtaoZzuR1WWot19kqJQkDhYXFCcqgN/LbjW1Wc+J29Tv3l60nQEFEMIxIvjnQyS8M5
         qxf+DpuSzzPCvdTrcaqEc+6beVabuwkQ/Sh1/Ak7RydgpPcofUH2ges7NbGBmNArzGCL
         +jCzCVYIq7tDIkY6CBU1go+a0F23uH9rAGfvXeR1CkR6WgfirjglcQG1PCVV7gCC2KoR
         dcTthpwtXRi01FCxx8yNjF+SvoTsgxevVy6Gex/lpuMnUtJ8ZJA9ri9aXeQIPVqdnR3Y
         whD+zE5McQ7/c5kFSp9bDb7G8JP+YS6voTKuDxCc8qEG2Mjx+3ze7E+KHfuR35nAMqKe
         jBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732585886; x=1733190686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJoYAYmeRsJLY19PSmXmZzQLTbquFpEYT2ck8bCoKAI=;
        b=NzuZJDo8/IoD+6Xhn4Rd5MadNmceRRMnI06qxPjSZywr/LHXYq2uqfRcLIgidT167J
         /tdy2gHhQJ4UIQyZdoMrdHIGid+H9ubZoEijzaHw04/xPngjPZfjPfy+HFxIyvUNHGKQ
         zbnF21o3o/4zWRmlIAizDgWWBCja6yKvl34vOwd5cmTNAGJghFT6IsG9FZ8JUg7ZawEi
         ajyiWcKkfXiYQrOC8te47tRI8MvZWlsPr85M4hnFfuLJAGOpFcJi1ygCl6Rhz9UenV41
         Fr9qzecj/HMxxUxHRjefWgdf3Z5eCvTiVxzzwXr9FTQW+7wA7rGGtTEI0Yby+j+/Yyks
         O0aQ==
X-Gm-Message-State: AOJu0Yz216ofJA0Q8dzwPZ7yrQyyXiQ52RfhGI6t49gpB3xPBYD4vnSJ
	v+rZe3Jk83gF8XJrJAv2UcpT8hOQnyfx81Yr5SUBdmVJa07MvEwrEb1BqPiE8DcgZVw1p5NipmD
	qK3Mi9OLP3Mm8aQ0gH4eg4b6ZOD1mcw==
X-Gm-Gg: ASbGncv2kqBWs0pavcVGGO5hfL5lOCvoaSCyz4ql6MdXKYJU4TC2C6hlBBSRJ1o6CWZ
	590u245kbg8vfbNvWnttZG8waplcqWQ==
X-Google-Smtp-Source: AGHT+IECCVnij2z/+srsyPC3YUKSlek8iSKr3GS456+2J0fRCkz1dFnAzFpIUD+FnI6gkzr8aPDBr+QNAg5FE/vVq9A=
X-Received: by 2002:a17:90b:3805:b0:2ea:aa30:5edf with SMTP id
 98e67ed59e1d1-2eb0e024afemr18190299a91.5.1732585885720; Mon, 25 Nov 2024
 17:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJwJo6bu3vfogmzxpfzFV_guf5GS_1TsqdB29NZoUr-_6fd8pg@mail.gmail.com>
In-Reply-To: <CAJwJo6bu3vfogmzxpfzFV_guf5GS_1TsqdB29NZoUr-_6fd8pg@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Tue, 26 Nov 2024 01:51:14 +0000
Message-ID: <CAJwJo6ZvS3B3b927zO1PpKX7p+7N75gE-44g2mVKkLXiaDBfPQ@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.13
To: pr-tracker-bot@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	open list <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 01:45, Dmitry Safonov <0x7f454c46@gmail.com> wrote:
>
> > The pull request you sent on Fri, 22 Nov 2024 09:17:47 +0100:
> >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.13
> >
> > has been merged into torvalds/linux.git:
> > https://git.kernel.org/torvalds/c/ceba6f6f33f29ab838b23a567621b847e527d085
>
> It seems to have a minor merge resolution artefact: iommu_present() now
> has a header declaration with no definition.

[Apparently, when you choose gmail option in chromium from the mail-to link,
 it erases In-Reply-To header, sorry about it, I'll avoid using it]

Thanks,
             Dmitry
