Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8E15A97
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 16:15:33 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so4268266otu.7
        for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 09:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nho4Mx1okgWawVlTzUYe67i9YWynaM+oXQaK+2MMuvI=;
        b=VwqCvKnPJ7HggbwxjUkIkIQa8H/b7PRW5aOthoIKPKSz1DK+gLZjQ6BW4nlT6EaaVo
         FQTCFBHAgsK3r9PXjfda17cDQYAzny1+jxbYFIKGrPqDUy5vTb8wIgXRTWmeXA0g556q
         rCYCPmFCWZOzbBCa0bTpi8Ecw8GT/IUH8FkWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nho4Mx1okgWawVlTzUYe67i9YWynaM+oXQaK+2MMuvI=;
        b=T9zTO5bjfYor9wLR8gA2YAIB7kjAP5H3I2R0NTueXokb9EZK5c2Ujw/QWx+BXaz0i3
         xY4BjoJvI4V8DQV/9T0p4VdL2T1JYaKKKSo5o8D0gzDrwZhfU3Tmt38he07UOyKlQ3FC
         7bTVStnLaS9rBT+m5QmZ9TxBJiVT1sy525Y55hlhibXvK2ine6hVAfgB8q+9X9EKPbyf
         gumcaZSDzFAwOQtUGgAc8T+vV+4EJcG8U+APm2qukVKpDlM0lA+vggbD1qOVvx6Ej3JE
         n8XmsD/buaKYywFQhbAfJ/vwvtJRc25iEa1z6yNmDZXQLDzI+qamp4qnk1HfcotvY1KM
         8vyA==
X-Gm-Message-State: ACrzQf3BXC1ewOYoHJgQFjhfMvx6tnVNElw0ADWnWpaFsJMQaifIxEdy
	7NDm5BHsKNRt5b1baB5PvtPZiVjGJ87Xrg==
X-Google-Smtp-Source: AMsMyM5iqPXjRZsKd26eb2v9temtVurVFVqx3yciHvavB34Qe35WtkVAhvpchARyHJ6HFpwrp/DZkw==
X-Received: by 2002:a9d:666:0:b0:655:d979:8a6 with SMTP id 93-20020a9d0666000000b00655d97908a6mr13314664otn.200.1663776932220;
        Wed, 21 Sep 2022 09:15:32 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id s2-20020a056830148200b00655bbb53c55sm1510872otq.15.2022.09.21.09.15.29
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 09:15:29 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id u131so8678975oie.5
        for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 09:15:29 -0700 (PDT)
X-Received: by 2002:a05:6808:11cf:b0:34b:8f4f:314b with SMTP id
 p15-20020a05680811cf00b0034b8f4f314bmr4277924oiv.126.1663776928733; Wed, 21
 Sep 2022 09:15:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1d1844f0-c773-6222-36c6-862e14f6020d@leemhuis.info>
 <fd672632-7935-14ff-e2be-0db8443b0907@leemhuis.info> <YyrI/qzx/EWapzck@8bytes.org>
In-Reply-To: <YyrI/qzx/EWapzck@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Sep 2022 09:15:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgU0PyYHut+8zV+kNCxOZiCXd5J29Eisiy8badzsk8Msw@mail.gmail.com>
Message-ID: <CAHk-=wgU0PyYHut+8zV+kNCxOZiCXd5J29Eisiy8badzsk8Msw@mail.gmail.com>
Subject: Re: How to quickly resolve the IOMMU regression that currently
 plagues a lot of people in 5.19.y
To: Joerg Roedel <joro@8bytes.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Greg KH <gregkh@linuxfoundation.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 21, 2022 at 1:19 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> Thanks for the noise :) I will queue the fix today and send it upstream.

.. and it's in my tree now.

                  Linus
