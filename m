Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E79984FBB
	for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716414; cv=none; b=Pok8gXty3l24hR+HT2ES3UUr3oEpSTXXH40P2uaopI+vfOhwUU9wU0bIyuGSx89zbFiR+jFPAo/oJesvbEsad3MBrudp/korShXu6YOj8HWe87nGrJiJHQe2fRtORlObDbgNUX8f4WNn6T+qs/ZMGrkuBH1opqRrSr4BdKdltG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716414; c=relaxed/simple;
	bh=R6zUV9LQ644WPBwU2nAdaKkCRupl6ITF2pP4ziWZMV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBBSq6NPYEYjThQK3zxT7RlDmtwBA+kH+eiDQCcUSwIPYIM6aH7LrpaHyZJ7HsrW2GoJaxHD+/gF0HmVn3JAwvW2ySpkqnSHDkw1OdGN9QdEbevu48b7Xg7VcTf24Rt46Ipeq0arjixZVOev24UWHRSk0Ox1sen/Vl6VFb15GHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f7dqFXVD; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7dqFXVD"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-608cf2e08f9so895467b3.0
        for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 11:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708716412; x=1709321212; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6zUV9LQ644WPBwU2nAdaKkCRupl6ITF2pP4ziWZMV0=;
        b=f7dqFXVDr7xNnXDlf5I+aBBa4E+EM0lHJ7eaeAJ+zqh3n9KcFwcecDZ8LkG811gTW/
         HuUQibyBTU9LcR/pSjLwySFwg3pN5Hwibz0JHr3FeSX2faGPZlBg+yqgygA/2acjyLFw
         FA0o4SyllZb1FLSvDCMGZJZ4jHY57k8VXLUFut1W2SKeUnQ3sD+ALWug5n8OcFl/QyId
         nVpgY7gn+oGOj3f0JbpKM9OrT7Onf9fIsw1RaJR4sLwosXkiTHw+LM6QiGL5p5iDkfXI
         D0QAVaKFDKyv+kEZpYAiVKt0OYEzRt5QQ26YM5nHCiEnKOsg3ar0XsXqttjaGBkkPgjE
         URSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708716412; x=1709321212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6zUV9LQ644WPBwU2nAdaKkCRupl6ITF2pP4ziWZMV0=;
        b=tYgtfT+WyabdlETmOzA0mUvwzqhQa73sIwdFygXFZPTcKgUZmxXMrd0bErUGU4gI9a
         +XJ+9bfFZZiZM0jFRNruLQht4P8dSyhp0/6sJdsPf5BuFCwoqg/JDG1t84UzWh7lMwny
         qf5ZGu5HqYt6aO3ivDbRvuNZH/2TnLkbddrajid21z/Vr1ldByxDAUr4bAYPx/kU8EN9
         TkQu4B6TDvUghLEvc4yJGG01FwaWwOw8VEeyB6+tBN0GZP2tHWXoYBV6FbhhiOmP9NgL
         U0/sXEy/T1UOCNRPmImqnppbpEnFfyePG+Y1kb/u91ehjYQATuGSUuyDDSaQwW8/azGe
         KHJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuG3b/x+kdpVX1tL6G7lwWSRYpCTGNUC5OYOdwwOpxELRBFh3hscyTyHVgqziWAYHmMD/Su1ACng68MgpZepkPK3e7upY=
X-Gm-Message-State: AOJu0Yzk69IJ4rwzM5pFzrcZKMgYgCjBfx/flBp4lMYwbfIDVvYYU/qn
	QmJxKrPP3/Enq4th/ou3U/M9MacpFFNToFZczMktvvy+sRUf+2JnrEEOrmbTVBlKRCU/PV0cDf2
	qTiUZgv3EHDqTBTB8Ty1wW8SOgu/vAHRigArP
X-Google-Smtp-Source: AGHT+IE/Pl6hrmaYgXKRMYbWWj3alWqUpkDIYPYsJjZVZ7mPx6TO4HEVqSuGco97bbBAS2NUd8BFNQPQR2paQWXSoCg=
X-Received: by 2002:a25:2653:0:b0:dc6:b088:e742 with SMTP id
 m80-20020a252653000000b00dc6b088e742mr843579ybm.8.1708716411749; Fri, 23 Feb
 2024 11:26:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-7-surenb@google.com>
 <Zdc6LUWnPOBRmtZH@tiehlicka> <20240222132410.6e1a2599@meshulam.tesarici.cz>
In-Reply-To: <20240222132410.6e1a2599@meshulam.tesarici.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 23 Feb 2024 11:26:40 -0800
Message-ID: <CAJuCfpGNoMa4G3o_us+Pn2wvAKxA2L=7WEif2xHT7tR76Mbw5g@mail.gmail.com>
Subject: Re: [PATCH v4 06/36] mm: enumerate all gfp flags
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 4:24=E2=80=AFAM 'Petr Tesa=C5=99=C3=ADk' via kernel=
-team
<kernel-team@android.com> wrote:
>
> On Thu, 22 Feb 2024 13:12:29 +0100
> Michal Hocko <mhocko@suse.com> wrote:
>
> > On Wed 21-02-24 11:40:19, Suren Baghdasaryan wrote:
> > > Introduce GFP bits enumeration to let compiler track the number of us=
ed
> > > bits (which depends on the config options) instead of hardcoding them=
.
> > > That simplifies __GFP_BITS_SHIFT calculation.
> > >
> > > Suggested-by: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > I thought I have responded to this patch but obviously not the case.
> > I like this change. Makes sense even without the rest of the series.
> > Acked-by: Michal Hocko <mhocko@suse.com>
>
> Thank you, Michal. I also hope it can be merged without waiting for the
> rest of the series.

Thanks Michal! I can post it separately. With the Ack I don't think it
will delay the rest of the series.
Thanks,
Suren.

>
> Petr T
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
